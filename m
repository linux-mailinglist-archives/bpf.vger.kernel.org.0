Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE0467EAE
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383019AbhLCUOl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 15:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382989AbhLCUOl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 15:14:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE05C061751
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 12:11:17 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u80so3876900pfc.9
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zy+E6nUtQnhHGpy74yW+ktFa/3ZKK8HGWBc4Sv37Ymw=;
        b=JMBA8FHpG8QXPgGt0ibUPY0xZ5UX0IaBLBFnvlsofA8sIpSWMlPOgBH/f8XqcqGZN4
         nfaDGiH0oqsopD0W7c3UJAiJFuHQStQEOy7lhVtlmV6JwN27fp6bFLyjhaMhq+WSZyGP
         hLqOqNN6dtu4lp1uKK+yj+SxFgENOoZWkIwRDHKdUHVJXuFmlhLJkno2SJOOlA44WKL2
         OYi9jSEqpmss0eBrYvBcgdpIpiTtORv1lt2L6ddOebQDUOaNYSVcooRGTRq8EvUioyN8
         9QVuMUoM7oW/d+hCrgvJi8goFJIuzMqVIjxFRgtNkqBlM5kR8hu3lh9o7pkyxkI8BhZD
         Sc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy+E6nUtQnhHGpy74yW+ktFa/3ZKK8HGWBc4Sv37Ymw=;
        b=uI84nfa29PxLXn9cMhP37dUTvEbMO3CGNNWgA2AeoXms9St9kDORAhRJD6QNNy1nf+
         KtVas9YfV9cM3N411+GB/DisdJ/Uxyc6CffhPnEhrN2d4Kt0dQwW0FbEfYKyyE1/TqXz
         sZuSdEbz/DivxsmaMMDElCkWWrvS7fp5FDvFdhCSoEdW+rEUm7A7cg4bGTTVmwslW9Yy
         N8y8YpCvnpxgbJJm/xhoKrYUkV82PJGZl1OO3OeBN4Q3T/WFr3rCkOLW8cMUeQaFS9OE
         S4Zm78Z7BZJpafZdN/R7khRsz5J0MiED9sExE7i9X9itejumf9YHUhXIewFNViP3EUDk
         Catg==
X-Gm-Message-State: AOAM530mmDGKQ63jKMZ04C99Fz8XQC55KFqonefBhCFQ22CCGbXDdXd6
        qx8Lm27j3LtSkTmTy+LIbKx/AY40pecCP9AFmBE=
X-Google-Smtp-Source: ABdhPJx++kpIG2pqJ3xk7vdGOpgXDb76txNUWjD/SvkXm00vp/7GSYicZlnXp4uYmOtpN6qL9zNJ/oozBMdCRPXxFDI=
X-Received: by 2002:aa7:9a4e:0:b0:4a2:71f9:21e0 with SMTP id
 x14-20020aa79a4e000000b004a271f921e0mr21486305pfj.77.1638562276459; Fri, 03
 Dec 2021 12:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20211203182836.16646-1-alexei.starovoitov@gmail.com> <CAEf4BzaYwWw1tCiu0Kk34YpEJeqDTLCKmrxgDCKr8fyZbTQYYw@mail.gmail.com>
In-Reply-To: <CAEf4BzaYwWw1tCiu0Kk34YpEJeqDTLCKmrxgDCKr8fyZbTQYYw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 12:11:05 -0800
Message-ID: <CAADnVQJ8y6ZUw5L1TLwUrBviq5DFJShfi+EBjkgMnSb23QBd3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Reduce bpf_core_apply_relo_insn() stack usage.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 12:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 3, 2021 at 10:28 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Reduce bpf_core_apply_relo_insn() stack usage and bump
> > BPF_CORE_SPEC_MAX_LEN limit back to 64.
> >
> > Fixes: 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> Looks good except for the three separate specs passed as an array.
> Let's do separate input args and it should be good to go. Thanks.
>
> >  kernel/bpf/btf.c          | 11 ++++++-
> >  tools/lib/bpf/libbpf.c    |  4 ++-
> >  tools/lib/bpf/relo_core.c | 60 +++++++++++----------------------------
> >  tools/lib/bpf/relo_core.h | 30 +++++++++++++++++++-
> >  4 files changed, 59 insertions(+), 46 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index ed4258cb0832..2a902a946f70 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6742,8 +6742,16 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> >  {
> >         bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
> >         struct bpf_core_cand_list cands = {};
> > +       struct bpf_core_spec *specs;
> >         int err;
> >
> > +       /* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
> > +        * into arrays of btf_ids of struct fields and array indices.
> > +        */
> > +       specs = kcalloc(3, sizeof(*specs), GFP_KERNEL);
> > +       if (!specs)
> > +               return -ENOMEM;
> > +
> >         if (need_cands) {
> >                 struct bpf_cand_cache *cc;
> >                 int i;
> > @@ -6779,8 +6787,9 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> >         }
> >
> >         err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> > -                                      relo, relo_idx, ctx->btf, &cands);
> > +                                      relo, relo_idx, ctx->btf, &cands, specs);
> >  out:
> > +       kfree(specs);
> >         if (need_cands) {
> >                 kfree(cands.cands);
> >                 mutex_unlock(&cand_cache_mutex);
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index de260c94e418..1ad070b19bb4 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -5515,6 +5515,7 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
> >                                const struct btf *local_btf,
> >                                struct hashmap *cand_cache)
> >  {
> > +       struct bpf_core_spec specs[3] = {};
>
> so I get why single kcalloc() is good on the kernel side, but there is
> no reason to do it here, please define three separate variables
>
> >         const void *type_key = u32_as_hash_key(relo->type_id);
> >         struct bpf_core_cand_list *cands = NULL;
> >         const char *prog_name = prog->name;
>
> [...]
>
> >  static bool is_flex_arr(const struct btf *btf,
> >                         const struct bpf_core_accessor *acc,
> >                         const struct btf_array *arr)
> > @@ -1200,9 +1173,10 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
> >                              const struct bpf_core_relo *relo,
> >                              int relo_idx,
> >                              const struct btf *local_btf,
> > -                            struct bpf_core_cand_list *cands)
> > +                            struct bpf_core_cand_list *cands,
> > +                            struct bpf_core_spec *specs)
>
> same here, let's pass three separate arguments instead of having to
> remember which array element corresponds to which (local vs cand vs
> targ). It doesn't prevent kernel-side from using an array and just
> passing pointers.

I don't understand the suggestion.
There is nothing to remember. It could have been just raw bytes
of appropriate size. It's temp data.
Passing them as 3 different args would make an impression
that they're actually meaningful. They're not. It's a scratch space.
