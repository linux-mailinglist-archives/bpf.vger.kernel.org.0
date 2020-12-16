Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BF2DC9A6
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 00:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgLPXgd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 18:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPXgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 18:36:33 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568EEC061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 15:35:53 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t13so24003198ybq.7
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 15:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aawkY8SHop5hshTAr1n4eH4ea1UiR9WrN23SfzBoaTk=;
        b=ptUGtgMRzewTSLSANVN92GnXN5RtrZjzL/n486YHPWWNX3fjA1GAbeAxpDet8TTO5E
         86C5Dk7C42m6fP2MnjeGIqvkdQla3yiyF0rbfn49LvUnjV0oZjLFwOYaHlvUMcZLA6Lo
         9RfNY3Nv6XaBb0C6fYQXN7jcQC9p7zE4qcKpLMFErJ7ylfvZyy9zq/ZT9zddpKntR0zS
         6SkrgxJ0D/dflutSkdHDO7Mxi24wRTXHME5IkuAGee6c8k31mjGt03GMMBq+1B0bN6Cf
         aPas52mX8fVyyXoJd0sCcKVisaM3xGzb1D+EJdt4qckfS+WR/rSwWG93AES+Xptgw9Os
         /s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aawkY8SHop5hshTAr1n4eH4ea1UiR9WrN23SfzBoaTk=;
        b=qcAhCPeDuhalMkUhtxlDVP/isAVlwiPhaoE0gJq6sm4y1fd1796VnvMuHkl/afYd1+
         K1RLH7MJmaqbgEv9QBXf+KiTGLEvLyPChVhtbrtczM6E0z9ORiZyJDG0Gh/fCcGIFE2w
         cEy1I9r4PUs7kOymAms7+Z+sjULX8BE3SM12Mzqm4e075fvGd2UMw68R8jG28kLEImjZ
         poT0VP00Ta6nc2mVK03CxrURoGR/V+kL092pHYc/rvVR273m5eGpe+LYSrk4oStFJZBZ
         9OkJFjLr7XbqjZSZPOR+0X4Wa6f+J7Ywhh4ppsLG5n3aO3Opq9KTzTVpgZTMPCqU6VJt
         CThA==
X-Gm-Message-State: AOAM530Z2HRb0wVCoSPk1MvPC3viik9nmFeY28mZOfxtFizYEXz3agyC
        NrqG8y2AoKqqaU3euqNYRhHcE7IWX5xatrbYa2Q=
X-Google-Smtp-Source: ABdhPJxTCF8r3UhUudIFCQhkQDgkMEFly8IxK9jcewmLHpVlmQp8eojscV+YACC+O9dgAx/yxftWORzRk3n2bxdtP5w=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr53212802ybe.403.1608161752565;
 Wed, 16 Dec 2020 15:35:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607973529.git.me@ubique.spb.ru> <5e2ca46ecadda0bde060a7cc0da7edba746b68da.1607973529.git.me@ubique.spb.ru>
In-Reply-To: <5e2ca46ecadda0bde060a7cc0da7edba746b68da.1607973529.git.me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Dec 2020 15:35:41 -0800
Message-ID: <CAEf4BzY3RaxvPcmQkTYsDa8MB+v6XpWuftdZEkFfgVVKgeLPbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Support pointer to struct in global
 func args
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 14, 2020 at 11:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Add an ability to pass a pointer to a struct in arguments for a global
> function. The struct may not have any pointers as it isn't possible to
> verify them in a general case.
>

If such a passed struct has a field which is a pointer, will it
immediately reject the program, or that field is just going to be
treated as an unknown scalar. The latter makes most sense and if the
verifier behaves like that already, it would be good to clarify that
here.

> Passing a struct pointer to a global function allows to overcome the
> limit on maximum number of arguments and avoid expensive and tricky
> workarounds.
>
> The implementation consists of two parts: if a global function has an
> argument that is a pointer to struct then:
>   1) In btf_check_func_arg_match(): check that the corresponding
> register points to NULL or to a valid memory region that is large enough
> to contain the struct.
>   2) In btf_prepare_func_args(): set the corresponding register type to
> PTR_TO_MEM_OR_NULL and its size to the size of the struct.
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/btf.c             | 59 +++++++++++++++++++++++++++++++-----
>  kernel/bpf/verifier.c        | 30 ++++++++++++++++++
>  3 files changed, 83 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e941fe1484e5..dbd00a7743d8 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -467,6 +467,8 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
>
>  int check_ctx_reg(struct bpf_verifier_env *env,
>                   const struct bpf_reg_state *reg, int regno);
> +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                 int regno, u32 mem_size);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8d6bdb4f4d61..0bb5ea523486 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5352,10 +5352,6 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>                         goto out;
>                 }
>                 if (btf_type_is_ptr(t)) {
> -                       if (reg[i + 1].type == SCALAR_VALUE) {
> -                               bpf_log(log, "R%d is not a pointer\n", i + 1);
> -                               goto out;
> -                       }
>                         /* If function expects ctx type in BTF check that caller
>                          * is passing PTR_TO_CTX.
>                          */
> @@ -5370,6 +5366,30 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>                                         goto out;
>                                 continue;
>                         }
> +
> +                       t = btf_type_by_id(btf, t->type);
> +                       while (btf_type_is_modifier(t))
> +                               t = btf_type_by_id(btf, t->type);
> +                       if (btf_type_is_struct(t)) {
> +                               u32 mem_size;
> +                               const struct btf_type *ret =
> +                                       btf_resolve_size(btf, t, &mem_size);
> +
> +                               if (IS_ERR(ret)) {
> +                                       bpf_log(log,
> +                                               "unable to resolve the size of type '%s': %ld\n",
> +                                               btf_name_by_offset(btf,
> +                                                                  t->name_off),

this wrapping is just distracting, please keep it in one line

> +                                               PTR_ERR(ret));
> +                                       return -EINVAL;

goto out to mark as unreliable?

> +                               }
> +
> +                               if (check_mem_reg(env, &reg[i + 1], i + 1,
> +                                                 mem_size))

same here, no need to wrap for this, imo

> +                                       goto out;
> +
> +                               continue;
> +                       }
>                 }
>                 bpf_log(log, "Unrecognized arg#%d type %s\n",
>                         i, btf_kind_str[BTF_INFO_KIND(t->info)]);
> @@ -5471,10 +5491,33 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
>                         reg[i + 1].type = SCALAR_VALUE;
>                         continue;
>                 }
> -               if (btf_type_is_ptr(t) &&
> -                   btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> -                       reg[i + 1].type = PTR_TO_CTX;
> -                       continue;
> +               if (btf_type_is_ptr(t)) {
> +                       if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> +                               reg[i + 1].type = PTR_TO_CTX;
> +                               continue;
> +                       }
> +
> +                       t = btf_type_by_id(btf, t->type);
> +                       while (btf_type_is_modifier(t))
> +                               t = btf_type_by_id(btf, t->type);
> +                       if (btf_type_is_struct(t)) {

Can we support a pointer to integer/enum here as well? Basically, a
pointer to any sized type would make sense. So if you just drop above
3 lines and just rely on btf_resolve_size() to either fail or return
the correct memory size, it would just work.


> +                               const struct btf_type *ret = btf_resolve_size(
> +                                       btf, t, &reg[i + 1].mem_size);
> +
> +                               if (IS_ERR(ret)) {
> +                                       const char *tname = btf_name_by_offset(
> +                                               btf, t->name_off);
> +                                       bpf_log(log,
> +                                               "unable to resolve the size of type '%s': %ld\n",

With the above change, this would be better to adjust to look like an
expected, but not supported case (E.g., "Arg is not supported because
it's impossible to determine the size of accessed memory" or something
along those lines).

A small surprising bit:

int foo(char arr[123]) { return arr[0]; }

would be legal, but arr[1] not. Which is a C type system quirk, but
it's probably fine to allow.


> +                                               tname, PTR_ERR(ret));
> +                                       return -EINVAL;
> +                               }
> +
> +                               reg[i + 1].type = PTR_TO_MEM_OR_NULL;
> +                               reg[i + 1].id = i + 1;

this reg[i + 1] addressing is error-prone and verbose, let's just have
a local pointer variable? Probably would want to rename `struct
bpf_reg_state *reg` to regs.

> +
> +                               continue;
> +                       }
>                 }
>                 bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
>                         i, btf_kind_str[BTF_INFO_KIND(t->info)], tname);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dee296dbc7a1..a08f85fffdb2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3886,6 +3886,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>         }
>  }
>
> +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                 int regno, u32 mem_size)
> +{
> +       if (register_is_null(reg))
> +               return 0;
> +
> +       if (reg_type_may_be_null(reg->type)) {

this looks wrong, we expect the register to be PTR_TO_MEM or
PTR_TO_MEM_OR_NULL here. So any other NU

> +               const struct bpf_reg_state saved_reg = *reg;

this saving and restoring of the original state due to
mark_ptr_not_null_reg() is a bit ugly. Maybe it's better to refactor
mark_ptr_not_null_reg to just return a new register type on success or
0 (NOT_INIT) on failure? Then you won't have to do this.

> +               int rv;
> +
> +               if (mark_ptr_not_null_reg(reg)) {
> +                       verbose(env, "R%d type=%s expected nullable\n", regno,
> +                               reg_type_str[reg->type]);
> +                       return -EINVAL;
> +               }
> +               rv = check_helper_mem_access(env, regno, mem_size, 1, NULL);
> +               *reg = saved_reg;
> +               return rv;
> +       }
> +
> +       return check_helper_mem_access(env, regno, mem_size, 1, NULL);


here and above, use true instead of 1, it's a bool argument, not
integer, super confusing

> +}
> +
>  /* Implementation details:
>   * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
>   * Two bpf_map_lookups (even with the same key) will have different reg->id.
> @@ -11435,6 +11458,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>                                 mark_reg_known_zero(env, regs, i);
>                         else if (regs[i].type == SCALAR_VALUE)
>                                 mark_reg_unknown(env, regs, i);
> +                       else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
> +                               const u32 mem_size = regs[i].mem_size;
> +
> +                               mark_reg_known_zero(env, regs, i);
> +                               regs[i].mem_size = mem_size;
> +                               regs[i].id = i;

I don't think we need to set id, we don't use that for PTR_TO_MEM registers.

> +                       }
>                 }
>         } else {
>                 /* 1st arg to a function */
> --
> 2.25.1
>
