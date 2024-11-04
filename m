Return-Path: <bpf+bounces-43903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290039BBB16
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC182281632
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93731C07EA;
	Mon,  4 Nov 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3+W4Yqo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB21CACD0
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739817; cv=none; b=MVEs4Kbe84POrywQqqCLi+GinE7DWC/4PDB25a094iSzCrvY0VrAiHB9+qu1riYarzZs58VqqIKdakxmLlErYNSeKDEaD616u+D5tmMetmc8yU8oZRc/5mNYeQyTniVICEIuvmo9IVD0Byk1WSBMUAQlJnVsuXCn6X2AyUw7VNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739817; c=relaxed/simple;
	bh=CATjoA/K195hySTD+ukzcDwdcdY8BykwHVuXUFU1rIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOdRIfm75HDJUJjJfnPGatNQUk/IZ844svrMfXAaiwabFsDOxSOAVSxk8Q+1P4F0YcFrnMRgCYTRqfXgtkT3oOV3NK7uAJK5IDl51reCLVGH+Ff/tBqUTgWeiDLHyAMAXxSky5SLdOXlCEJs7vOi9Soyi1SMy8znIgJoccbjTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3+W4Yqo; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so4372541a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739812; x=1731344612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8m8RdUu6Dmzi7lBcrzwJ5kIpLsN3JDuuEOk5RZC0Sc=;
        b=k3+W4Yqo9sGpRd6p7i5/6A2yfPPm+giG51rpHsJ3hOwqJi/8RyTJQeN3d15TQd69Xm
         NAOJYEIuKi0kHxSTD+MCTbjKQ3qcWDXKBp2BxBWfiRNws8plizP0AYeK/8+7zPKHOUU+
         C2BP0bRXr+wg/kGOO4v1J9A22AxYw8jQ9JTbuPmquEHBmFX5flHdXAapkklsDt9Y1l/0
         t7XlI5YMjCEht47TZWu44g6tK7QvqhaG/xzh//JiAedLqBxMR3p4MW++R72uvYKLTEMn
         yMTttS9bRSyU+BOHERIyxks60WJmiNRfTglHbNtYEwFFJSuj3AxZtz0viwhFceEZCcwW
         xIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739812; x=1731344612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8m8RdUu6Dmzi7lBcrzwJ5kIpLsN3JDuuEOk5RZC0Sc=;
        b=XPkMCQoBUTuXJrO/8miLjDe3WnxWTpmsilFt4TXgoRVZWjLOwq8Q0hZi5I5S57V18v
         9tty/HX1auLutiylPAyAd4KjteiOXp9z4ET51tQocyUtlIBh58ObfVfq4LR6TeNqTkQ5
         ilcQwkKA5f52XdiIAQGa0429ebjEH8z7A67jiyWUn58MesFimo0MTzwqoARnKATPqIpK
         Rx6+id6SiN6fwAvWzbPhDHVcnYElrjGWiOgJgJ8nD0bw68IBLn6l6TwUoakklseKfnNY
         wukZY2lSpiN2ThEUPZXVpr+4raysqb1yQNIficVDEfmKU1FlmErzLmdR1lgOG77O4e8h
         R5DQ==
X-Gm-Message-State: AOJu0YxwHEKhRX/azrZhxYN63Rsey9O/6j+QjaUOHnE1fz0Zoa9/wQWY
	KmMTszLJzsFtMeQ01zSdNw6AddN/D3zNw38E/wkk5H1G1PNh/rFJJ/IDT5TochUAtivaXSYc0LO
	AT4PnpKKxka82LMv1sEkxoaMCTA6fcy4ILLJyfw==
X-Google-Smtp-Source: AGHT+IGjxeEHzAjs9f/DyGHs68BTqcIPijvw4xygx4G1Sa1fvZGIqnsUt82DsA5XRJ6tHJr+qTCe7ZD7OE3FfqHSUp0=
X-Received: by 2002:a05:6402:13cb:b0:5ce:dc4e:57ff with SMTP id
 4fb4d7f45d1cf-5cedc4e6163mr3007607a12.24.1730739812022; Mon, 04 Nov 2024
 09:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103184144.3765700-1-memxor@gmail.com> <20241103184144.3765700-2-memxor@gmail.com>
 <CAP01T77SvSO4=FXTUOcZ9D6+KenzJKAbMStV5WqQ6663P705Gg@mail.gmail.com>
In-Reply-To: <CAP01T77SvSO4=FXTUOcZ9D6+KenzJKAbMStV5WqQ6663P705Gg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 4 Nov 2024 11:02:55 -0600
Message-ID: <CAP01T759XH-g4ADNKXCwNgD2fGrFtEY8PLuAE6kiz72nvOmcsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
To: bpf@vger.kernel.org
Cc: kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <olsajiri@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 10:40, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Sun, 3 Nov 2024 at 12:41, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Arguments to a raw tracepoint are tagged as trusted, which carries the
> > semantics that the pointer will be non-NULL.  However, in certain cases,
> > a raw tracepoint argument may end up being NULL. More context about this
> > issue is available in [0].
> >
> > Thus, there is a discrepancy between the reality, that raw_tp arguments
> > can actually be NULL, and the verifier's knowledge, that they are never
> > NULL, causing explicit NULL checks to be deleted, and accesses to such
> > pointers potentially crashing the kernel.
> >
> > To fix this, mark raw_tp arguments as PTR_MAYBE_NULL, and then special
> > case the dereference and pointer arithmetic to permit it, and allow
> > passing them into helpers/kfuncs; these exceptions are made for raw_tp
> > programs only. Ensure that we don't do this when ref_obj_id > 0, as in
> > that case this is an acquired object and doesn't need such adjustment.
> >
> > The reason we do mask_raw_tp_trusted_reg logic is because other will
> > recheck in places whether the register is a trusted_reg, and then
> > consider our register as untrusted when detecting the presence of the
> > PTR_MAYBE_NULL flag.
> >
> > To allow safe dereference, we enable PROBE_MEM marking when we see loads
> > into trusted pointers with PTR_MAYBE_NULL.
> >
> > While trusted raw_tp arguments can also be passed into helpers or kfuncs
> > where such broken assumption may cause issues, a future patch set will
> > tackle their case separately, as PTR_TO_BTF_ID (without PTR_TRUSTED) can
> > already be passed into helpers and causes similar problems. Thus, they
> > are left alone for now.
> >
> > It is possible that these checks also permit passing non-raw_tp args
> > that are trusted PTR_TO_BTF_ID with null marking. In such a case,
> > allowing dereference when pointer is NULL expands allowed behavior, so
> > won't regress existing programs, and the case of passing these into
> > helpers is the same as above and will be dealt with later.
> >
> > Also update the failure case in tp_btf_nullable selftest to capture the
> > new behavior, as the verifier will no longer cause an error when
> > directly dereference a raw tracepoint argument marked as __nullable.
> >
> >   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb
> >
> > Reported-by: Juri Lelli <juri.lelli@redhat.com>
> > Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h                           |  6 ++
> >  kernel/bpf/btf.c                              |  5 +-
> >  kernel/bpf/verifier.c                         | 75 +++++++++++++++++--
> >  .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
> >  4 files changed, 83 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c3ba4d475174..1b84613b10ac 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3495,4 +3495,10 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
> >         return prog->aux->func_idx != 0;
> >  }
> >
> > +static inline bool bpf_prog_is_raw_tp(const struct bpf_prog *prog)
> > +{
> > +       return prog->type == BPF_PROG_TYPE_TRACING &&
> > +              prog->expected_attach_type == BPF_TRACE_RAW_TP;
> > +}
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index ed3219da7181..e7a59e6462a9 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6588,7 +6588,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >         if (prog_args_trusted(prog))
> >                 info->reg_type |= PTR_TRUSTED;
> >
> > -       if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
> > +       /* Raw tracepoint arguments always get marked as maybe NULL */
> > +       if (bpf_prog_is_raw_tp(prog))
> > +               info->reg_type |= PTR_MAYBE_NULL;
> > +       else if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
> >                 info->reg_type |= PTR_MAYBE_NULL;
> >
> >         if (tgt_prog) {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 797cf3ed32e0..36776624710f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -418,6 +418,21 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
> >         return rec;
> >  }
> >
> > +static bool mask_raw_tp_reg(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +       if (reg->type != (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL) ||
> > +           !bpf_prog_is_raw_tp(env->prog) || reg->ref_obj_id)
> > +               return false;
> > +       reg->type &= ~PTR_MAYBE_NULL;
> > +       return true;
> > +}
> > +
> > +static void unmask_raw_tp_reg(struct bpf_reg_state *reg, bool result)
> > +{
> > +       if (result)
> > +               reg->type |= PTR_MAYBE_NULL;
> > +}
> > +
> >  static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
> >  {
> >         struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
> > @@ -6622,6 +6637,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >         const char *field_name = NULL;
> >         enum bpf_type_flag flag = 0;
> >         u32 btf_id = 0;
> > +       bool mask;
> >         int ret;
> >
> >         if (!env->allow_ptr_leaks) {
> > @@ -6693,7 +6709,21 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >
> >         if (ret < 0)
> >                 return ret;
> > -
> > +       /* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
> > +        * trusted PTR_TO_BTF_ID, these are the ones that are possibly
> > +        * arguments to the raw_tp. Since internal checks in for trusted
> > +        * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NULL
> > +        * modifier as problematic, mask it out temporarily for the
> > +        * check. Don't apply this to pointers with ref_obj_id > 0, as
> > +        * those won't be raw_tp args.
> > +        *
> > +        * We may end up applying this relaxation to other trusted
> > +        * PTR_TO_BTF_ID with maybe null flag, since we cannot
> > +        * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
> > +        * tagging, but that should expand allowed behavior, and not
> > +        * cause regression for existing behavior.
> > +        */
> > +       mask = mask_raw_tp_reg(env, reg);
> >         if (ret != PTR_TO_BTF_ID) {
> >                 /* just mark; */
> >
> > @@ -6754,8 +6784,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >                 clear_trusted_flags(&flag);
> >         }
> >
> > -       if (atype == BPF_READ && value_regno >= 0)
> > +       if (atype == BPF_READ && value_regno >= 0) {
> >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> > +               /* We've assigned a new type to regno, so don't undo masking. */
> > +               if (regno == value_regno)
> > +                       mask = false;
> > +       }
> > +       unmask_raw_tp_reg(reg, mask);
> >
> >         return 0;
> >  }
> > @@ -7140,7 +7175,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >                 if (!err && t == BPF_READ && value_regno >= 0)
> >                         mark_reg_unknown(env, regs, value_regno);
> >         } else if (base_type(reg->type) == PTR_TO_BTF_ID &&
> > -                  !type_may_be_null(reg->type)) {
> > +                  (bpf_prog_is_raw_tp(env->prog) || !type_may_be_null(reg->type))) {
>
> While looking at this again, I'm wondering if this check is too
> relaxed. Since we're matching on base_type, this will probably end up
> allowing any PTR_TO_BTF_ID with PTR_MAYBE_NULL in raw_tp progs. So I
> think I need to narrow it down, unless I'm missing something.
>
> Will wait for a while for comments before respinning v3.

I verified that this is broken, a pointer from bpf_obj_new could be
deref'd without NULL check.
I'll respin v3 fixing this.

>
> >                 err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
> >                                               value_regno);
> > [...]

