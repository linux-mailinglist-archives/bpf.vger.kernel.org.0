Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13E245C88
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2019 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfFNMRs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jun 2019 08:17:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36766 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfFNMRs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jun 2019 08:17:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so3232457edq.3
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2019 05:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+8quq0k8tqu/xsODhVIPdEOM4T34ZCS4DIB0amj5ChA=;
        b=Mo6wun8A7pgxPORUx10wMaMNVN/w8B1W9Mauo4Mcn5BN4+zbcx+Eh2MPqbeAtn18es
         LfuTzKdqNZTM0K5B6Cyt062P7wn8CPsCJbKmkPxgdruyO7ey2xZk8vBRw6ojuT9GJx3I
         9kAlypbPKUVQSZ76QCSX1FA6GpVweTNOpAOOYoh15rs1oS3f2FyAFAJtitz1Utku1XEl
         YDIFZXlkEKgdGTEw0bbi6ZHPpVCrRjFmxvai52Q+h1yuGRG12ogyAizaL8noiClDASJB
         aTj1rrK33kq27qK8pjkG0wdxEOkOCwHx3LYN8K5eB7o4ThOEeWaLs+Noc8GYKFEsQamy
         Ebig==
X-Gm-Message-State: APjAAAXu7I/W6SdRkZJ6bcm2D1Hf9p4BpQhMFcJ2zJA22Vkmu/vgahLv
        S9cxAC2XoPP39KtzEb6zMqHOdA==
X-Google-Smtp-Source: APXvYqyqOun6k3rFPZiHWrWAxUeMwEI/iqTNd06JTPho68It+7LHZEn/6EYjihJLeJfIdRD2OVDxgw==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr82883736ejb.217.1560514666534;
        Fri, 14 Jun 2019 05:17:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id z40sm847346edb.61.2019.06.14.05.17.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:17:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3194F1804AF; Fri, 14 Jun 2019 14:17:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk, newella@fb.com,
        clm@fb.com, josef@toxicpanda.com, dennisz@fb.com,
        lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-ioweight
In-Reply-To: <20190614015620.1587672-9-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org> <20190614015620.1587672-9-tj@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 14 Jun 2019 14:17:45 +0200
Message-ID: <87pnngbbti.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> This patchset implements IO cost model based work-conserving
> proportional controller.
>
> While io.latency provides the capability to comprehensively prioritize
> and protect IOs depending on the cgroups, its protection is binary -
> the lowest latency target cgroup which is suffering is protected at
> the cost of all others.  In many use cases including stacking multiple
> workload containers in a single system, it's necessary to distribute
> IO capacity with better granularity.
>
> One challenge of controlling IO resources is the lack of trivially
> observable cost metric.  The most common metrics - bandwidth and iops
> - can be off by orders of magnitude depending on the device type and
> IO pattern.  However, the cost isn't a complete mystery.  Given
> several key attributes, we can make fairly reliable predictions on how
> expensive a given stream of IOs would be, at least compared to other
> IO patterns.
>
> The function which determines the cost of a given IO is the IO cost
> model for the device.  This controller distributes IO capacity based
> on the costs estimated by such model.  The more accurate the cost
> model the better but the controller adapts based on IO completion
> latency and as long as the relative costs across differents IO
> patterns are consistent and sensible, it'll adapt to the actual
> performance of the device.
>
> Currently, the only implemented cost model is a simple linear one with
> a few sets of default parameters for different classes of device.
> This covers most common devices reasonably well.  All the
> infrastructure to tune and add different cost models is already in
> place and a later patch will also allow using bpf progs for cost
> models.
>
> Please see the top comment in blk-ioweight.c and documentation for
> more details.

Reading through the description here and in the comment, and with the
caveat that I am familiar with network packet scheduling but not with
the IO layer, I think your approach sounds quite reasonable; and I'm
happy to see improvements in this area!

One question: How are equal-weight cgroups scheduled relative to each
other? Or requests from different processes within a single cgroup for
that matter? FIFO? Round-robin? Something else?

Thanks,

-Toke
