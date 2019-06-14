Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E622046B42
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2019 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFNUui convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 14 Jun 2019 16:50:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43185 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFNUui (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jun 2019 16:50:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so5241491edr.10
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2019 13:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lh0n1D7R2t0Y0d+wEjcTMFEBGes1xmgH+/nCCWSCn40=;
        b=koEv8d9M42U7NB4eeBYgHheBwkza7P5kaeZ38I7JEt0F68OdOwhtoql+BFyvgAgDFn
         GsyW6g2vmG/Z0E5x8QGVMlmEb003zJcE6TwD82vVkKKMoNY6FZRVQX80d/ejAqZXdEOC
         +32plibI3q3KzreBdFJWZPOEoD4YpXtupdqO1zpi6e5ENyr0L59A+q2XziSuogd6IH2I
         5kb/jm+hfrdRMJBYp5jKh+bSRd3SyEiZpJPpelaBlWPVJ67GMCu+5T1+1cNRZBJTdnni
         kg+N3v6Tu/4pO+2PZ6p2JE6e+Qlw0AfoVgzOMMgCjFU4myvjKhPN8Wps2yqLgvbvRGhl
         YCpw==
X-Gm-Message-State: APjAAAXfDEIJrv6B39gE8kzewKhF0GGhZqsJ6CoXXpi0gu/GnS/Wgcuv
        2kBgiZ07YNYVn60MeNkqf8Itfw==
X-Google-Smtp-Source: APXvYqw5ig+HTGJdDvIEyeCTt+dMoTZfjl/YqoKuroUVvyIcNYyXmfL0k5ThxMse9XKZpDPvdkdRJA==
X-Received: by 2002:a50:b4cb:: with SMTP id x11mr34441028edd.284.1560545436484;
        Fri, 14 Jun 2019 13:50:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u26sm1128548edf.91.2019.06.14.13.50.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:50:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6F021804AF; Fri, 14 Jun 2019 22:50:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-ioweight
In-Reply-To: <20190614150924.GB538958@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org> <20190614015620.1587672-9-tj@kernel.org> <87pnngbbti.fsf@toke.dk> <20190614150924.GB538958@devbig004.ftw2.facebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 14 Jun 2019 22:50:34 +0200
Message-ID: <87blyzc2n9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> Hello, Toke.
>
> On Fri, Jun 14, 2019 at 02:17:45PM +0200, Toke Høiland-Jørgensen wrote:
>> One question: How are equal-weight cgroups scheduled relative to each
>> other? Or requests from different processes within a single cgroup for
>> that matter? FIFO? Round-robin? Something else?
>
> Once each cgroup got their hierarchical weight and current vtime for
> the period, they don't talk to each other.  Each is expected to do the
> right thing on their own.  When the period ends, the timer looks at
> how the device is performing, how much each used and so on and then
> make necessary adjustments.  So, there's no direct cross-cgroup
> synchronization.  Each is throttled to their target level
> independently.

Right, makes sense.

> Within a single cgroup, the IOs are FIFO. When an IO has enough vtime
> credit, it just passes through. When it doesn't, it always waits
> behind any other IOs which are already waiting.

OK. Is there any fundamental reason why requests from individual
processes could not be interleaved? Or does it just not give the same
benefits in an IO request context as it does for network packets?

Thanks for the explanations! :)

-Toke
