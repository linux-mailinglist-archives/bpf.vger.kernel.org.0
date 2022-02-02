Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA44A7727
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiBBRzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 12:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiBBRzv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 12:55:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05793C06173B
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 09:55:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u18so264310edt.6
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 09:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xb//V0S6CQDlSDJ8cfBwbA51UVe8f0nXhJXeelSNg40=;
        b=JOZasG8HqttiwmdHXeD7rBtMwVmtuKcEVO/bcGatsdx7PZ2UGkjSPEhfzX99UYYqQC
         6OUfmssE4MHebA1GQQCLQSU5xbKLS4kE7L0ciLY7D10l+IwgwR3c8ELnl87ck9ebikSV
         pUHJ/l1Dy5N9BIXVY6vkRQART2ar0ffgRZncpJtl7IaCOPx9v6fLpEBQLcRN/UFvqT/+
         K1Y8GPpN++R4TWzE5zTRqr/FacEh9tAujDkLFIE7NrME0TyiJ24/wjhJy7kxB25Ocds/
         ZhWix2rs9p19wOBlty4YhU/drSqgTc5eCyhEBmLZsEkjLFrSMbNVE/jZ9fa1/T1nUVEA
         HY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xb//V0S6CQDlSDJ8cfBwbA51UVe8f0nXhJXeelSNg40=;
        b=4mr9+FW0BEaghhESVXMro6Uedi/nyvK1okrnKq3I4WkgFuIOuBGpthkKPgnX2AM0kd
         ddHS0TaNNDZTi+ARWUBk1sHUDq5q0q6gZHidKU3zujKNseUObEEWBeu4nLYv1iG1Gc8T
         8jWpeGYHwmRJ8n+dsQUSA3aK0kSKW4WYmwmVlWaSkC7+E1aMfnyymRBkUjdKaQ+BGMfX
         NMLpfKtsGylo54TrOaa77kjCgqEi+oNF2vC8TyJn1KvuROigIgyA6H2d8xqym6HAgTx+
         lR1K5xHOhA3V3sHBn04xQfBDP3zKzPsOntfNfe5bCTgpiC5Olgnb90bQVoB4ZiDf+B/F
         OAlQ==
X-Gm-Message-State: AOAM530c0wBrg8ies0eJJVeVdpS/kxWqeiIDkMjpjMxwe06YFJZi/Ki3
        6X3cHmMiEv7rTpJC2f3JJeYkRsoyY2km+Q==
X-Google-Smtp-Source: ABdhPJyWS12e4IXoWFSiLHMA35/j8aJ1H/CVTScjeB4oJdQfbzESI/WfCoL/kV8m9gF50o3XYmAvQQ==
X-Received: by 2002:a05:6402:f0f:: with SMTP id i15mr31239125eda.327.1643824549496;
        Wed, 02 Feb 2022 09:55:49 -0800 (PST)
Received: from erthalion.local (dslb-094-223-160-189.094.223.pools.vodafone-ip.de. [94.223.160.189])
        by smtp.gmail.com with ESMTPSA id n21sm18854620edq.27.2022.02.02.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:55:49 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:55:31 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [RFC PATCH] bpftool: Add bpf_cookie to perf output
Message-ID: <20220202175531.nuwk3eee7z7qy4fv@erthalion.local>
References: <20220127082649.12134-1-9erthalion6@gmail.com>
 <CAEf4BzbZHm8c=eeMTx=tLHKSddvH-fKQ5qkuULymQnZqd2DgtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbZHm8c=eeMTx=tLHKSddvH-fKQ5qkuULymQnZqd2DgtQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Mon, Jan 31, 2022 at 04:49:36PM -0800, Andrii Nakryiko wrote:
> On Thu, Jan 27, 2022 at 12:27 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> > BPF perf links") introduced the concept of user specified bpf_cookie,
> > which could be accessed by BPF programs using bpf_get_attach_cookie().
> > For troubleshooting purposes it is convenient to expose bpf_cookie via
> > bpftool as well, so there is no need to meddle with the target BPF
> > program itself.
> >
> >     $ bpftool perf
> >     pid 83  fd 9: prog_id 5  bpf_cookie: 123  tracepoint  sched_process_exec
> >
>
> I think a more natural place to expose this would be in `bpftool link
> show` output, as bpf_cookie is actually per attachment (i.e., link)
> information (not a per-program). We'll need to anticipate multi-attach
> use cases (e.g., multi-attach kprobe and fentry programs we are
> discussing at the moment).

Yes, makes sense. I guess it will require extending bpf_link &
bpf_link_info to store a cookie on attachment and carry it around,
otherwise I don't see other ways to extract it. Is that fine, or it's
not supposed to be extendable (as with bpf_task_fd_query API)?
