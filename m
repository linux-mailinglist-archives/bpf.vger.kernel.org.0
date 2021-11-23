Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598DF459AA7
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 04:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKWDr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhKWDr6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 22:47:58 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C1C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:44:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j2so19216980ybg.9
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1l0I5yl1OkK+xEp8FIfxSg8A+rGFRqPkY+VwnLBVH4=;
        b=qlZemOq2OJLkXzveI4BDSyFXMor2UodXrgCJdgxVavta1MX0kkD5PMjsINqzw5CG/g
         hBBfuYItp+XR5ya8vQync98znwG5JcO3mKkL0fb8sfGBwNZ/cKQCOxmHFmofR3StxOa8
         kg2JZPDxEDSjgGKwLFMEyotv5DGC2Tv9h4x5He740SFpfcmmVok0CqhG19bTYWDjh6T4
         TNXiMts13S8DboYuKCilFsYG486noA7Nc1AzsUb/9rO1Nr+ll6Kzcu2tsvOR3GN+iwlu
         ZpEwATjazmGkvI5JEWeJrp+q58n3ohtJbwWhA0xDH3osBSvdc6SCDK8Xpb5SBui3VLdc
         7FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1l0I5yl1OkK+xEp8FIfxSg8A+rGFRqPkY+VwnLBVH4=;
        b=Ezpo7DNtnUonAIWvCs9vLG3FcPQKYbkdKRxC0oXHe/JMtDqkjzW8bw7VI0tVBv+Szx
         TVFvWiznfgg6NlHXzU251UuF6pl5NZhEcSKkqI+TpN4Jy2JAkVZhVzlp/sVQ9AC9cbu5
         YJcO4Jqlzki1U9bqRu13Mq97a2BeVsfZPVKq5a05aW7qYUvqeNz4Ljp+SXS3f83M1jLb
         qW14puKleNifvDblZin3Oxn+e30kVta9t0vQibcFvFs08/r2JotKjG+yRdNkG2uqO11I
         6ZyAzY6EeyTJNYYW3grrH5hI+UgkgqAreFDgb4IgoTCYK/oMZv3Uk61V1lve9TvR2cJn
         TjVA==
X-Gm-Message-State: AOAM53094Lm9UvJ1Qzzq2wpd4QWdLVv18PTVT9D1MlTHpb3Gc0IaCosT
        x/gL/ZxG9dv3ZQHiIc1ghd3E/frTBWpeepfbTaY=
X-Google-Smtp-Source: ABdhPJwtEWgUdhvpiHU2TzJbpMnZX36L12ED6ys/Iq7Ox/Y2o11KOmKN2Wf22DCU+yVJqXDPusXQjXcAxnE2TTNVK+4=
X-Received: by 2002:a05:6902:68d:: with SMTP id i13mr2738864ybt.2.1637639089979;
 Mon, 22 Nov 2021 19:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
 <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com>
 <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com> <CAADnVQLZASm0tUfLALeLmZbdmfUZq4umRpRDBT06a1cF1aJWhg@mail.gmail.com>
In-Reply-To: <CAADnVQLZASm0tUfLALeLmZbdmfUZq4umRpRDBT06a1cF1aJWhg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 19:44:39 -0800
Message-ID: <CAEf4BzYb6Cb5-g77rX6Unz29EYwRCHbGgaGJWZnpp2vhh8Z56g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 7:15 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 5:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 4:43 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > >
> > > > > Given BPF program's BTF perform a linear search through kernel BTFs for
> > > > > a possible candidate.
> > > > > Then wire the result into bpf_core_apply_relo_insn().
> > > > >
> > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > ---
> > > > >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > > > >                    int relo_idx, void *insn)
> > > > >  {
> > > > > -       return -EOPNOTSUPP;
> > > > > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > > > > +               struct bpf_core_cand_list *cands;
> > > > > +
> > > > > +               cands = bpf_core_find_cands(ctx, relo->type_id);
> > > >
> > > > this is wrong for many reasons:
> > > >
> > > > 1. you will overwrite previous ctx->cands, if it was already set,
> > > > which leaks memory
> > > > 2. this list of candidates should be keyed by relo->type_id ("root
> > > > type"). Different root types get their own independent lists; so it
> > > > has to be some sort of look up table from type_id to a list of
> > > > candidates.
> > > >
> > > > 2) means that if you had a bunch of relos against struct task_struct,
> > > > you'll crate a list of candidates when processing first relo that
> > > > starts at task_struct. All the subsequent relos that have task_struct
> > > > as root type will re-used that list and potentially trim it down. If
> > > > there are some other relos against, say, struct mm_struct, they will
> > > > have their independent list of candidates.
> > >
> > > right.
> > > Your prior comment confused me. I didn't do this reuse of cands
> > > to avoid introducing hashtable here like libbpf does,
> > > since it does too little to actually help.
> >
> > Since when avoiding millions of iterations for each relocation is "too
> > little help"?
>
> because it is a premature optimization for a case that
> may or may not be relevant.
> If 180 sk_buff relocations somehow makes the loading too slow
> 180 relocations of 180 different types would produce exactly
> the same slow down and hashtable cache won't help.

Likelihood of using 180 different root types in real application is
very small. Using 180 relocations (either with explicit BPF_CORE_READ,
field accesses in fentry, or just through always_inline helpers doing
either and being inlined in multiple places) is very real in
real-world non-trivial applications. And the cost of optimizing that
in the kernel later is very high, you'll be waiting for a new kernel
release to get everywhere to rely on this optimization. The cost of
further optimizing this in libbpf is much smaller (and libbpf still
did the optimization from the get go and I stand by that decision).

If you think I'm making this up, we have one security-related BPF app
with 1076 CO-RE relocations across 11 BPF programs. It's using 22
different root types.

>
> > BTW, I've tried to measure how noticeable this will be and added
> > test_verif_scale2 to core_kern with only change to use vmlinux.h (so
> > that __sk_buff accesses are CO-RE relocated). I didn't manage to get
> > it loaded, so something else is going there. So please take a look, I
> > don't really know how to debug lskel stuff. Here are the changes:
>
> Looking. Thanks for the test.
>
> > > If we actually need to optimize this part of loading
> > > we better do persistent cache of
> > > name -> kernel btf_type-s
> > > and reuse it across different programs.
> >
> > You can't reuse it because the same type name in a BPF object BTF can
> > be resolved to different kernel types (e.g., if we still had
> > ring_buffer name collision),
>
> well and the candidate list will have two kernel types with the same name.
> Both kept in a cache.
> so cache_lookup("ring_buffer") will return two kernel types.
> That would be the case for all progs being loaded.
> What am I missing?

if there are two matching types with the same matching field but field
offsets are different (and thus there is ambiguity), that's an error.
So the correct (by current definition, at least) program has to result
in one of such two incompatible ring_buffer types and only one. If
there are multiple duplicates, though, (like task_struct and
task_struct___2) they will have identical sets of fields at the same
offsets, so both will remain possible candidates and that's not an
error. But for actually two different types, there can be only one
winner.
