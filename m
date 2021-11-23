Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4959C45993D
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKWAqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhKWAqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:46:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC271C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:43:04 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r5so16693222pgi.6
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1AP0IbAYUumhlNTExSNL2dQvu1eX0MUJpipCOzO0hk=;
        b=ch7vwmSISIZ5N/V2AbXsTOweS4GATJjlvTwtEi+D9QYybfUZuQ9Zv5AoZf7APWAD5h
         OWNbaoGCMSGtUptjRgbzXaa/ajVwqBu4ADzhsboYSF5OUG0led30cNHlIFHIdsIllmxS
         Rs9FL51kROiRo8wS7WI665s4LdBFUvZfhz9lHKZvsoT2aRmG3oKJwsjbToeKWAsqaalL
         GYV0CQIP2lJi+rw0HMXP0ixLqLWvIep7KUHLyK0xoQC5r/H0jHsej/ls43lUK6eDTucP
         B0hv2dhF6/3y2sbTEhvTf8t/rzv6qV6nw2txWL/Y+BkFAUfT3ZzA0p66CtNfe8Brj0Fr
         O1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1AP0IbAYUumhlNTExSNL2dQvu1eX0MUJpipCOzO0hk=;
        b=Zf2F/IdGjquyObyKI+8n83QslUOID3U2b7St7CkFgC25miKOr6ojkZmTNOFMfkyiye
         pT56j8qC0fozCAo+mNj5C0tICtGiMfo5MRMdUddV7HmiKo9hjF8EdI2fHrJtJzrlgLTE
         s2QTn6jI2laHNF13+z8jmLTDD9XOrM1i20dYE8X/Y8rm8QrDkbSstANQfgu8ZI8f79yF
         E1zC9kVbwGAhtSUyNhQXIApOyEo4ouMDERw2lfeOkQAibgPTqi8cBHSsHWFWfwYGOEr9
         0BdnYy04dxvwtrxbMcms/BW5B0NMz6wR0i0QhrLFIg4MU8zVPPXHApYahfB/RzCqf7Fb
         6EzA==
X-Gm-Message-State: AOAM533hwcVNEkZS/xpYJuHhViXzKt7RcjOWqB9aHgrGYay8DmI5wbNI
        QIzLaDJTWDb+V5xI+gw9ORky28u5Z0mdvT+tajo=
X-Google-Smtp-Source: ABdhPJzTZLkvUyLRPsOfHvoTB3t34xHGuhom6+0Pxbcd0RLdQGrq+eLS70KoxvSJBWunRpbAnBbm5eb86vz3xp59diQ=
X-Received: by 2002:a63:a50a:: with SMTP id n10mr862693pgf.310.1637628184304;
 Mon, 22 Nov 2021 16:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Nov 2021 16:42:53 -0800
Message-ID: <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Given BPF program's BTF perform a linear search through kernel BTFs for
> > a possible candidate.
> > Then wire the result into bpf_core_apply_relo_insn().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 135 insertions(+), 1 deletion(-)
> >
>
> [...]
>
> >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> >                    int relo_idx, void *insn)
> >  {
> > -       return -EOPNOTSUPP;
> > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > +               struct bpf_core_cand_list *cands;
> > +
> > +               cands = bpf_core_find_cands(ctx, relo->type_id);
>
> this is wrong for many reasons:
>
> 1. you will overwrite previous ctx->cands, if it was already set,
> which leaks memory
> 2. this list of candidates should be keyed by relo->type_id ("root
> type"). Different root types get their own independent lists; so it
> has to be some sort of look up table from type_id to a list of
> candidates.
>
> 2) means that if you had a bunch of relos against struct task_struct,
> you'll crate a list of candidates when processing first relo that
> starts at task_struct. All the subsequent relos that have task_struct
> as root type will re-used that list and potentially trim it down. If
> there are some other relos against, say, struct mm_struct, they will
> have their independent list of candidates.

right.
Your prior comment confused me. I didn't do this reuse of cands
to avoid introducing hashtable here like libbpf does,
since it does too little to actually help.
I think I will go back to the prior version: linear search for every relo.
If we actually need to optimize this part of loading
we better do persistent cache of
name -> kernel btf_type-s
and reuse it across different programs.
