Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B03467F36
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 22:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353880AbhLCV0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 16:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbhLCV0I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 16:26:08 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D524AC061751
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 13:22:43 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d10so13219335ybn.0
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuVY+RFxwoXNJccbG2A8RHNwC1kfJYciHAbEmTXpIGc=;
        b=hP5MkGZUDIzMDABVFYYlJTsigmch4gIuMZwgHwMhyW61K4v8RwH+DnjhABNmzEdfKl
         OksvE30WO0W6UVfUXNubzqZWdb5tAIkuxpnqacgTL1Npa3e1ZARjdjwcO5BREDQMfvg4
         I4w6xn8oF2m5D9WFlAcmnd0PRmIYU8xHDgj2PVrpRkNHj9Aelm1E+yEtqeAoFQgjowDn
         m7tAaDt4xStQGon/FTAKrRnIyhPIEASQuJEe/1Z94zCH4hOvwg1a7tHVgvo4+QU6+P+Q
         84HydHnQFJkpOnZjGl43iQ1wHqkYaYxudu0Sg3Ozo63m6ywMsWqpbYobkGFhGOt0oecX
         M0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuVY+RFxwoXNJccbG2A8RHNwC1kfJYciHAbEmTXpIGc=;
        b=naYDatyw5CqsKaYXWsIgSt8/mN3oZyc5nH4nIVZb1aOOXMRpxmBpjyG1VLsqUGD1c4
         +r9/eKstfL/N6fvAuxyKN2YzVY6ZjfydL+0wvPwiRotpy4e8xqwhXCyGwEKkwJfP0s+5
         Nv3j6PW2yf0jQo1BIWH2rIQIy7RBo6fVGi4CvZqoI3/pZ6d2lfFXINFLEJKfDdolOgdS
         jtQr7RjQb84Ys6Pv3Klnm70iwQTphsDRwGIkLDVjwP45PRSe+i4idjMKKac91KR1OCGv
         YqI9SHP0SZKd9+XOJwN9RQo7DYLKBlZHIA/7X46a8IEo0dGvdgGfj2b5+2AcGEPyUxw5
         vjiQ==
X-Gm-Message-State: AOAM533jkWA+k5iKFfOy+/CqE7mQpbgzGT3w1VpWQvjVMGl8Lrgjx7JW
        yH7GFiw06hjiKKEHnbkgxEkakZfWPV+HLiwVNXrxo7wP3Qk=
X-Google-Smtp-Source: ABdhPJxKLWQzaLn7WB3OBVs21D+oC6SGWvwPycu5N8IqVRkHkF1507uPfIFnSqVBsEt1v9Ql9VgxiPEgHp65+UH0b+w=
X-Received: by 2002:a05:6902:1006:: with SMTP id w6mr27804252ybt.252.1638566562423;
 Fri, 03 Dec 2021 13:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20211203182836.16646-1-alexei.starovoitov@gmail.com>
 <CAEf4BzaYwWw1tCiu0Kk34YpEJeqDTLCKmrxgDCKr8fyZbTQYYw@mail.gmail.com> <CAADnVQJ8y6ZUw5L1TLwUrBviq5DFJShfi+EBjkgMnSb23QBd3Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ8y6ZUw5L1TLwUrBviq5DFJShfi+EBjkgMnSb23QBd3Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Dec 2021 13:22:31 -0800
Message-ID: <CAEf4Bzbvvinya8dQFCBpAYazYEEa0Na=zaeYXay0MH33a9NQuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Reduce bpf_core_apply_relo_insn() stack usage.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 12:11 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 3, 2021 at 12:08 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Dec 3, 2021 at 10:28 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Reduce bpf_core_apply_relo_insn() stack usage and bump
> > > BPF_CORE_SPEC_MAX_LEN limit back to 64.
> > >
> > > Fixes: 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> >
> > Looks good except for the three separate specs passed as an array.
> > Let's do separate input args and it should be good to go. Thanks.
> >
> > >  kernel/bpf/btf.c          | 11 ++++++-
> > >  tools/lib/bpf/libbpf.c    |  4 ++-
> > >  tools/lib/bpf/relo_core.c | 60 +++++++++++----------------------------
> > >  tools/lib/bpf/relo_core.h | 30 +++++++++++++++++++-
> > >  4 files changed, 59 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index ed4258cb0832..2a902a946f70 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6742,8 +6742,16 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > >  {
> > >         bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
> > >         struct bpf_core_cand_list cands = {};
> > > +       struct bpf_core_spec *specs;
> > >         int err;
> > >
> > > +       /* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
> > > +        * into arrays of btf_ids of struct fields and array indices.
> > > +        */
> > > +       specs = kcalloc(3, sizeof(*specs), GFP_KERNEL);
> > > +       if (!specs)
> > > +               return -ENOMEM;
> > > +
> > >         if (need_cands) {
> > >                 struct bpf_cand_cache *cc;
> > >                 int i;
> > > @@ -6779,8 +6787,9 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > >         }
> > >
> > >         err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> > > -                                      relo, relo_idx, ctx->btf, &cands);
> > > +                                      relo, relo_idx, ctx->btf, &cands, specs);
> > >  out:
> > > +       kfree(specs);
> > >         if (need_cands) {
> > >                 kfree(cands.cands);
> > >                 mutex_unlock(&cand_cache_mutex);
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index de260c94e418..1ad070b19bb4 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -5515,6 +5515,7 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
> > >                                const struct btf *local_btf,
> > >                                struct hashmap *cand_cache)
> > >  {
> > > +       struct bpf_core_spec specs[3] = {};
> >
> > so I get why single kcalloc() is good on the kernel side, but there is
> > no reason to do it here, please define three separate variables
> >
> > >         const void *type_key = u32_as_hash_key(relo->type_id);
> > >         struct bpf_core_cand_list *cands = NULL;
> > >         const char *prog_name = prog->name;
> >
> > [...]
> >
> > >  static bool is_flex_arr(const struct btf *btf,
> > >                         const struct bpf_core_accessor *acc,
> > >                         const struct btf_array *arr)
> > > @@ -1200,9 +1173,10 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
> > >                              const struct bpf_core_relo *relo,
> > >                              int relo_idx,
> > >                              const struct btf *local_btf,
> > > -                            struct bpf_core_cand_list *cands)
> > > +                            struct bpf_core_cand_list *cands,
> > > +                            struct bpf_core_spec *specs)
> >
> > same here, let's pass three separate arguments instead of having to
> > remember which array element corresponds to which (local vs cand vs
> > targ). It doesn't prevent kernel-side from using an array and just
> > passing pointers.
>
> I don't understand the suggestion.
> There is nothing to remember. It could have been just raw bytes
> of appropriate size. It's temp data.
> Passing them as 3 different args would make an impression
> that they're actually meaningful. They're not. It's a scratch space.

Ok, fair enough. I've renamed specs to specs_scratch to make this more
explicit and pushed to bpf-next.
