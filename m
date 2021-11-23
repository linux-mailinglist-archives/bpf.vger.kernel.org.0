Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F287A459A69
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 04:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhKWDSU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKWDST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 22:18:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46DC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:15:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so1649795pjb.4
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZTJYg5tFvfmJu524dxM86KehCvGRP63z3Tfxxd3Qmc=;
        b=brCqG7IlzAw8pyT8TS8rbN1czXH4OkZ330c9MNoK2SAhnpAoxDaQUtpLQyWUkcd7sU
         j2HOgpJkN/dAHpMX8M96kIx37kXZ8/XxGHLZ73EAprnU8+Dnw8GsW1hISusWN0fsEV3N
         tnpnViG0FyUDIXE4hqtGf+HYCL03HVgXKXqj+LCUoc+O4iyP9aMdaAqsqe2+1Pr6Iz+b
         +nG+11IJ1/5bTgWXxM3aOW7On8R6ocME3gHUWQzqIuNIwquvLvlMSjozl2TYdd1HbjMN
         6qd6Z3HU8vFhmAV/wCzBLjdIHinl4qZTHPQz2U8YLdEJj8Ba1UhrRUiv+gp37tOv7LEs
         I2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZTJYg5tFvfmJu524dxM86KehCvGRP63z3Tfxxd3Qmc=;
        b=W9Qx+nhUsEp6aP8JQIlSsTy3DcwdWeaXyfjN0WP1ZS1YyNYky9XNwVmvsVlS7Ip+Fq
         PQj8uCHBxL0aQRTZt9gKtGpr24CRj1gW38miJjOgf8aLE6219L/ibDMM6NEcmTYrotJ1
         svS4Th4vtXOsIKEVRHW+qglwd9YYJBCM+RF5ul+brbphiikSPMvOB9fnndqQbDjbTvSp
         tnUJFjsCT3Mdj1wBM5E+esFaN0JS6fs+uC9PLfjQ+jpVAuxaf0lPVHzeE1qyoqiwhyox
         b275i+QFxcfnc5wfFfVyyAQt8mM2dAM14pxjb2hEiLCmeguSMsGnrj4uTI5ShtgKbIXP
         s+Cg==
X-Gm-Message-State: AOAM532KurM33QNpnkiJNUU/iqNODGBnfrZ0mT/sxnX9AeCeiWn0BQ1J
        BWUz2yZyAcF7FuzvlKSThl2YrKW0azUqT8vLrrc=
X-Google-Smtp-Source: ABdhPJzJhlZ6CDBayI+tg0+Ky2ckE9RnV82tnc30L7hQNAUC0UiFOfOb5zQQMWBFD/CT06AdqLTPQ5oDvwKwPwBToVY=
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id
 a8-20020a170902b58800b00143b7320834mr2425757pls.22.1637637312022; Mon, 22 Nov
 2021 19:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
 <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com> <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
In-Reply-To: <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Nov 2021 19:15:00 -0800
Message-ID: <CAADnVQLZASm0tUfLALeLmZbdmfUZq4umRpRDBT06a1cF1aJWhg@mail.gmail.com>
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

On Mon, Nov 22, 2021 at 5:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 4:43 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Given BPF program's BTF perform a linear search through kernel BTFs for
> > > > a possible candidate.
> > > > Then wire the result into bpf_core_apply_relo_insn().
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > >
> > >
> > > [...]
> > >
> > > >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > > >                    int relo_idx, void *insn)
> > > >  {
> > > > -       return -EOPNOTSUPP;
> > > > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > > > +               struct bpf_core_cand_list *cands;
> > > > +
> > > > +               cands = bpf_core_find_cands(ctx, relo->type_id);
> > >
> > > this is wrong for many reasons:
> > >
> > > 1. you will overwrite previous ctx->cands, if it was already set,
> > > which leaks memory
> > > 2. this list of candidates should be keyed by relo->type_id ("root
> > > type"). Different root types get their own independent lists; so it
> > > has to be some sort of look up table from type_id to a list of
> > > candidates.
> > >
> > > 2) means that if you had a bunch of relos against struct task_struct,
> > > you'll crate a list of candidates when processing first relo that
> > > starts at task_struct. All the subsequent relos that have task_struct
> > > as root type will re-used that list and potentially trim it down. If
> > > there are some other relos against, say, struct mm_struct, they will
> > > have their independent list of candidates.
> >
> > right.
> > Your prior comment confused me. I didn't do this reuse of cands
> > to avoid introducing hashtable here like libbpf does,
> > since it does too little to actually help.
>
> Since when avoiding millions of iterations for each relocation is "too
> little help"?

because it is a premature optimization for a case that
may or may not be relevant.
If 180 sk_buff relocations somehow makes the loading too slow
180 relocations of 180 different types would produce exactly
the same slow down and hashtable cache won't help.

> BTW, I've tried to measure how noticeable this will be and added
> test_verif_scale2 to core_kern with only change to use vmlinux.h (so
> that __sk_buff accesses are CO-RE relocated). I didn't manage to get
> it loaded, so something else is going there. So please take a look, I
> don't really know how to debug lskel stuff. Here are the changes:

Looking. Thanks for the test.

> > If we actually need to optimize this part of loading
> > we better do persistent cache of
> > name -> kernel btf_type-s
> > and reuse it across different programs.
>
> You can't reuse it because the same type name in a BPF object BTF can
> be resolved to different kernel types (e.g., if we still had
> ring_buffer name collision),

well and the candidate list will have two kernel types with the same name.
Both kept in a cache.
so cache_lookup("ring_buffer") will return two kernel types.
That would be the case for all progs being loaded.
What am I missing?
