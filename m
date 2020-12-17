Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1822DCC62
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 07:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLQGOA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 01:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQGN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 01:13:59 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6124BC061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 22:13:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t30so7331507wrb.0
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 22:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fWrHwjdngktrpglfSskFceA+PfMz5rFQsFMcxRkVak=;
        b=rVqeTC61+tofxcubhfI8cNpYFpRiach6d/Ym/O9hTInNr0TvjhYOcaAjFRMa9dambG
         kX4Y6guiwvTbL4TBQ2cIO1hefuPrBxrrwslIcylhIa6NQ0dpcT5+I/Xn/G+6xhvC3w1r
         xrsyBHzvlWC0UvTso5a6ByS/ffvHaXb+b45ilKMJIDc18lnNhb5RvvlwtyaZXd0gKHrR
         Iq1qRg0ngmDuGxaoLeKj1HQ2V96U/8WsQM2GUC/eDRNjhIW6RvUr+kI6Paa7PL97mYo1
         Mp4BMRhcE1LDmUBHyOA5RQSTwQaB6d0pR4SjiDvRiR0jPZu1XFVPXyJh2IOh8SZqpLJB
         lcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7fWrHwjdngktrpglfSskFceA+PfMz5rFQsFMcxRkVak=;
        b=lrlOMkVTCsHtZOi3x+SRKMukG15x/6aZ67jFnQTaiMquFgSD2hVdQpt0gE+a7dSsr8
         zju7sKAlnIMTDkIQPAFcOmv1ZLizetIw7+ZARGOeH+quqvXb1LG9a9VSHAlAETuvap6a
         VTU075zDITGAM1/v1IK7TBQ4Ci05KLhQJ6225/2rEozCHpKYV038NZWOjYwdA4v1aVUm
         ppMW6CvM+54GAW2DUmt2ok+ILT3H1mo/GSiBPq/s3kJ6K5fkgw/MoY1aWMCIqgKk1mvO
         Ki5aMChzfBpKU+7XTTE+Q2k5EinkYm3i/ZwnQz+d+Qpopqd4tWFdtxlN3F34/1XaWRfB
         IDeQ==
X-Gm-Message-State: AOAM530dYknXVXgVLc3lRTE5G1H6vsb2DWzZBcaBQfBWC1x68R4o7vvS
        qKDo1n9TJCqiKnP2rK2KUQIRgg==
X-Google-Smtp-Source: ABdhPJwZIp9MQWZP7aBWt/xqlylOxm76R/WDZIoqivjGHPMzro9tiPUHpD8Z9emh4T4CZa7RKPvYVA==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr43131088wrs.390.1608185597024;
        Wed, 16 Dec 2020 22:13:17 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id x66sm6046670wmg.26.2020.12.16.22.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 22:13:16 -0800 (PST)
Date:   Thu, 17 Dec 2020 10:13:07 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Support pointer to struct in global
 func args
Message-ID: <20201217061307.e4m7ezbc73ga7lke@amnesia>
References: <cover.1607973529.git.me@ubique.spb.ru>
 <5e2ca46ecadda0bde060a7cc0da7edba746b68da.1607973529.git.me@ubique.spb.ru>
 <CAEf4BzY3RaxvPcmQkTYsDa8MB+v6XpWuftdZEkFfgVVKgeLPbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY3RaxvPcmQkTYsDa8MB+v6XpWuftdZEkFfgVVKgeLPbQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 16, 2020 at 03:35:41PM -0800, Andrii Nakryiko wrote:
> On Mon, Dec 14, 2020 at 11:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> >
> > Add an ability to pass a pointer to a struct in arguments for a global
> > function. The struct may not have any pointers as it isn't possible to
> > verify them in a general case.
> >
> 
> If such a passed struct has a field which is a pointer, will it
> immediately reject the program, or that field is just going to be
> treated as an unknown scalar. The latter makes most sense and if the
> verifier behaves like that already, it would be good to clarify that
> here.

Such a field is treated as an unknown scalar.


> 
> > Passing a struct pointer to a global function allows to overcome the
> > limit on maximum number of arguments and avoid expensive and tricky
> > workarounds.
> >
> > The implementation consists of two parts: if a global function has an
> > argument that is a pointer to struct then:
> >   1) In btf_check_func_arg_match(): check that the corresponding
> > register points to NULL or to a valid memory region that is large enough
> > to contain the struct.
> >   2) In btf_prepare_func_args(): set the corresponding register type to
> > PTR_TO_MEM_OR_NULL and its size to the size of the struct.
> >
> > Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> > ---
> >  include/linux/bpf_verifier.h |  2 ++
> >  kernel/bpf/btf.c             | 59 +++++++++++++++++++++++++++++++-----
> >  kernel/bpf/verifier.c        | 30 ++++++++++++++++++
> >  3 files changed, 83 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index e941fe1484e5..dbd00a7743d8 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -467,6 +467,8 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
> >
> >  int check_ctx_reg(struct bpf_verifier_env *env,
> >                   const struct bpf_reg_state *reg, int regno);
> > +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                 int regno, u32 mem_size);
> >
> >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 8d6bdb4f4d61..0bb5ea523486 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5352,10 +5352,6 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >                         goto out;
> >                 }
> >                 if (btf_type_is_ptr(t)) {
> > -                       if (reg[i + 1].type == SCALAR_VALUE) {
> > -                               bpf_log(log, "R%d is not a pointer\n", i + 1);
> > -                               goto out;
> > -                       }
> >                         /* If function expects ctx type in BTF check that caller
> >                          * is passing PTR_TO_CTX.
> >                          */
> > @@ -5370,6 +5366,30 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >                                         goto out;
> >                                 continue;
> >                         }
> > +
> > +                       t = btf_type_by_id(btf, t->type);
> > +                       while (btf_type_is_modifier(t))
> > +                               t = btf_type_by_id(btf, t->type);
> > +                       if (btf_type_is_struct(t)) {
> > +                               u32 mem_size;
> > +                               const struct btf_type *ret =
> > +                                       btf_resolve_size(btf, t, &mem_size);
> > +
> > +                               if (IS_ERR(ret)) {
> > +                                       bpf_log(log,
> > +                                               "unable to resolve the size of type '%s': %ld\n",
> > +                                               btf_name_by_offset(btf,
> > +                                                                  t->name_off),
> 
> this wrapping is just distracting, please keep it in one line
> 
> > +                                               PTR_ERR(ret));
> > +                                       return -EINVAL;
> 
> goto out to mark as unreliable?
> 
> > +                               }
> > +
> > +                               if (check_mem_reg(env, &reg[i + 1], i + 1,
> > +                                                 mem_size))
> 
> same here, no need to wrap for this, imo
> 
> > +                                       goto out;
> > +
> > +                               continue;
> > +                       }
> >                 }
> >                 bpf_log(log, "Unrecognized arg#%d type %s\n",
> >                         i, btf_kind_str[BTF_INFO_KIND(t->info)]);
> > @@ -5471,10 +5491,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> >                         reg[i + 1].type = SCALAR_VALUE;
> >                         continue;
> >                 }
> > -               if (btf_type_is_ptr(t) &&
> > -                   btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> > -                       reg[i + 1].type = PTR_TO_CTX;
> > -                       continue;
> > +               if (btf_type_is_ptr(t)) {
> > +                       if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> > +                               reg[i + 1].type = PTR_TO_CTX;
> > +                               continue;
> > +                       }
> > +
> > +                       t = btf_type_by_id(btf, t->type);
> > +                       while (btf_type_is_modifier(t))
> > +                               t = btf_type_by_id(btf, t->type);
> > +                       if (btf_type_is_struct(t)) {
> 
> Can we support a pointer to integer/enum here as well? Basically, a
> pointer to any sized type would make sense. So if you just drop above
> 3 lines and just rely on btf_resolve_size() to either fail or return
> the correct memory size, it would just work.

Agreed.

> 
> 
> > +                               const struct btf_type *ret = btf_resolve_size(
> > +                                       btf, t, &reg[i + 1].mem_size);
> > +
> > +                               if (IS_ERR(ret)) {
> > +                                       const char *tname = btf_name_by_offset(
> > +                                               btf, t->name_off);
> > +                                       bpf_log(log,
> > +                                               "unable to resolve the size of type '%s': %ld\n",
> 
> With the above change, this would be better to adjust to look like an
> expected, but not supported case (E.g., "Arg is not supported because
> it's impossible to determine the size of accessed memory" or something
> along those lines).
> 
> A small surprising bit:
> 
> int foo(char arr[123]) { return arr[0]; }
> 
> would be legal, but arr[1] not. Which is a C type system quirk, but
> it's probably fine to allow.

If an array size is known at compile time then it should be
possible to use pointer to array type and support access to the
entire array:

int foo (char (*arr)[123]) { return arr[1]; }


> 
> 
> > +                                               tname, PTR_ERR(ret));
> > +                                       return -EINVAL;
> > +                               }
> > +
> > +                               reg[i + 1].type = PTR_TO_MEM_OR_NULL;
> > +                               reg[i + 1].id = i + 1;
> 
> this reg[i + 1] addressing is error-prone and verbose, let's just have
> a local pointer variable? Probably would want to rename `struct
> bpf_reg_state *reg` to regs.
> 
> > +
> > +                               continue;
> > +                       }
> >                 }
> >                 bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
> >                         i, btf_kind_str[BTF_INFO_KIND(t->info)], tname);
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index dee296dbc7a1..a08f85fffdb2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3886,6 +3886,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >         }
> >  }
> >
> > +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                 int regno, u32 mem_size)
> > +{
> > +       if (register_is_null(reg))
> > +               return 0;
> > +
> > +       if (reg_type_may_be_null(reg->type)) {
> 
> this looks wrong, we expect the register to be PTR_TO_MEM or
> PTR_TO_MEM_OR_NULL here. So any other NU

check_mem_reg() is called from btf_check_func_arg_match() which
is called from check_func_call() which is called when the
verifier encounters BPF_CALL(from calle). For example it should
be possible to pass a return value of bpf_map_lookup_elem()
directly to a global function. Without any additional checks in
callee the type of a register would be PTR_TO_MAP_VALUE_OR_NULL.

In other words the goal of check_mem_reg() is to ensure that a
register has a value that points to NULL or any valid memory
region(PTR_TO_STACK, PTR_TO_MAP_VALUE etc.). If a register has a
nullable type we temporarly convert the register type to its
corresponding type with a value and check if the access would be
safe.

A caller works just with PTR_TO_MEM_OR_NULL which abstracts all
the possible underlying types. btf_prepare_func_args() prepares
registers on entry to a verification of a global function.

A callee handles all the possible types of a register while a
caller uses PTR_TO_MEM_OR_NULL only.


> 
> > +               const struct bpf_reg_state saved_reg = *reg;
> 
> this saving and restoring of the original state due to
> mark_ptr_not_null_reg() is a bit ugly. Maybe it's better to refactor
> mark_ptr_not_null_reg to just return a new register type on success or
> 0 (NOT_INIT) on failure? Then you won't have to do this.

It is not enough just to convert register's type - e.g. we also
want to change map_ptr to map->inner_map_meta for a case of
PTR_TO_MAP_VALUE_OR_NULL and inner_map_meta because it may be
used in check_helper_mem_access() -> check_map_access().


> 
> > +               int rv;
> > +
> > +               if (mark_ptr_not_null_reg(reg)) {
> > +                       verbose(env, "R%d type=%s expected nullable\n", regno,
> > +                               reg_type_str[reg->type]);
> > +                       return -EINVAL;
> > +               }
> > +               rv = check_helper_mem_access(env, regno, mem_size, 1, NULL);
> > +               *reg = saved_reg;
> > +               return rv;
> > +       }
> > +
> > +       return check_helper_mem_access(env, regno, mem_size, 1, NULL);
> 
> 
> here and above, use true instead of 1, it's a bool argument, not
> integer, super confusing
> 
> > +}
> > +
> >  /* Implementation details:
> >   * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
> >   * Two bpf_map_lookups (even with the same key) will have different reg->id.
> > @@ -11435,6 +11458,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
> >                                 mark_reg_known_zero(env, regs, i);
> >                         else if (regs[i].type == SCALAR_VALUE)
> >                                 mark_reg_unknown(env, regs, i);
> > +                       else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
> > +                               const u32 mem_size = regs[i].mem_size;
> > +
> > +                               mark_reg_known_zero(env, regs, i);
> > +                               regs[i].mem_size = mem_size;
> > +                               regs[i].id = i;
> 
> I don't think we need to set id, we don't use that for PTR_TO_MEM registers.

If we don't set id then in check_cond_jump_id() ->
mark_ptr_or_null_regs() -> mark_ptr_or_null_reg() we don't
transform register type either to SCALAR(NULL case) or
PTR_TO_MEM(value case):
...
if (reg_type_may_be_null(reg->type) && reg->id == id && 
...

The end result is that the verifier mem access checks fail for a
PTR_TO_MEM_OR_NULL register.


> 
> > +                       }
> >                 }
> >         } else {
> >                 /* 1st arg to a function */
> > --
> > 2.25.1
> >

-- 

Dmitrii Banshchikov
