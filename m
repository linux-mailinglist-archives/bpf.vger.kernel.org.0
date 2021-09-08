Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C3403F05
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbhIHSWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349745AbhIHSWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 14:22:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EFC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 11:21:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1929172pjc.3
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Zns6gslyH9a/olbK7XjumGoSBEER/uG5E31IJd9NiA=;
        b=GFp0C5jqEQgoDtMPCDJ3tpZj88NEjss+AOhG5s1h4dn6UNvfXdwProtzrSCXSaTM6Y
         S9m2uK14DaE8jwdwI3dTYXQA22aWxZpVCTcKHXv2GfY6j+V4XlmBtmQqnPG55B1jQEmY
         +RKGwQNV/awJBm2LhDFyBdoWSiSwjB+LtAtedVrDo8Yy19ekUzxHvBUqZ6cocvNDE1Lc
         JZ9iT8DQthYU/h0Gw+fl07s/pNmcb5JEpUZFhtiTF4SSESjqsTMdAwjByH6a6mkKyQan
         iWI+SECtwjiwNe1G3zSqawGnCMIIVdB+ArJfQF47locZMYTbkCr+W8V4ouR55YxqlfpX
         tAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Zns6gslyH9a/olbK7XjumGoSBEER/uG5E31IJd9NiA=;
        b=3LeGTvFTrCrRUE4aCC1/ei5DDfBFEqAUiP5D/nAtiheoXHAqWRzim8pWElE2N4IoIY
         Jhh+Ixo6DZbRRM55Vfx6yR9C+7xpq3Hg1HAY1MMtQ/3Kpk4Snk4A3fx3isuZLENvLyPw
         5+POGdlbFHvf9dpu+CwuT7GndLAtvQL8kXKAJXOxS6PQvdOjjGdboHVgkfCYcanXl/In
         8aIomriEg18jvqCb8TR8KNwzWG5LR0mgfDJfisfkRlULqCN7mHojzunlSawvE4i5OmDe
         i3+X9wOJiklZ1r6FHYXdZl1FxOHsjQItzHMkUlwI3XzlO4OlmdhEbdgPiE9jAjkviEav
         48ww==
X-Gm-Message-State: AOAM531L9AkXRG8sUxnLDPmY8wr28yuUZP/FIVXanUNhl1T/he3d8IWD
        ZwpU3WvlsmV7rnzKb/tdqVYAVIvgzVg9nv9daR4=
X-Google-Smtp-Source: ABdhPJx7bLHsd2Yu88B/rTt2UQp+xh9cyfij6RE7vL9Z6KtZC+b9Fz6AfZ8pnNqwTau96U2T6nZ0ZMhaO1ErkYEUX7w=
X-Received: by 2002:a17:90b:4f8e:: with SMTP id qe14mr5583215pjb.122.1631125269538;
 Wed, 08 Sep 2021 11:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210908044427.3632119-1-yhs@fb.com> <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca> <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver> <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com> <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
In-Reply-To: <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 8 Sep 2021 11:20:58 -0700
Message-ID: <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>, walken@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 11:15 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 8 Sep 2021 11:02:58 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > > Please describe the expected userspace-visible change from Peter's
> > > patch in full detail?
> >
> > User space expects build_id to be available. Peter patch simply removes
> > that feature.
>
> Are you sure?  He ends up with

More than sure :)
Just look at below.

> static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>                                           u64 *ips, u32 trace_nr, bool user)
> {
>         int i;
>
>         /* cannot access current->mm, fall back to ips */
>         for (i = 0; i < trace_nr; i++) {
>                 id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>                 id_offs[i].ip = ips[i];
>                 memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>         }
>         return;
> }
>
> and you're saying that userspace won't like this because we didn't set
> BPF_STACK_BUILD_ID_VALID?

The patch forces the "fallback path" that in production is seen 0.001%
Meaning that user space doesn't see build_id any more. It sees IPs only.
The user space cannot correlate IPs to binaries. That's what build_id enabled.
