Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2F69FFC1
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjBVXoY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjBVXoQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:44:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBDD2CFEA
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:44:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso10818599pjb.5
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 15:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbWYtKvADBD4Bt52N39AjMiv0nM/L8UvfbkhwmuGKMY=;
        b=Jw37Y4p/kT5evjlJGcYBH/aS4vRpAwLAV6DSwi5RllKYSzENJHmyH6qb8NRRCe435d
         JVK1clHbX0XNoiH0113b1keqHxe/YDdRy5GEXsTCCKiUvEVtBxLx807TqmL9glvxvTjR
         1UmLRTpvLJxV/sajj4ov5qnBerL4P6x+M1N322KYvuaMgx8X1UUefnWV4qpaglLh9UAu
         PXlK7rsZ8buviRLP10/ELnnNDbQWGKNEklui/UKSTR2dx6l2i18oP/ylrOnNnR4ilBHE
         QtfMIDG+qCBaVboiI+Rf8HWMsxPpmC9YGnwyOPPLzdRolM55EsFKotiix595LCktg6EC
         0xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbWYtKvADBD4Bt52N39AjMiv0nM/L8UvfbkhwmuGKMY=;
        b=dwW5NumbHxxNLUs8rQifWOOv/NeFBny8OMjiBxtD2VPiBNlNcmKkJIvbo3mFQEU480
         ppILfX+rLVun3kJfAoeJPZuRwJlRv2tIFlKXwU+FtfoMvbDMZu7NbIHKag/gfRxki/PJ
         45C6OQnas97+XMB7vKodbZm4/sDlUgtiQE4Pv1ViJ2s14xCpqD4qXBujZ4smTNV8HJuu
         4CFNhjjjuZKyE3pNqt9akN6HxmuykypAOVxAb7QuL6+e5QfZ9bv4H+wCSuTEpdh1GjcF
         r3+LJ6Kdte6WhvaE8pbFsN6ZGLWisk5n8cWKZTNiJ4g0tb2Aw/a7zf5jUzQPRjM2u0Mv
         9G7Q==
X-Gm-Message-State: AO0yUKUYTcZXZw8u9wOwqd10UBFK4wXXNTLI3X06JGw630h3wNCE2XsK
        nXDbWoW88kX5Nc62iE+Lh5v1ABAny9J0DdBpAo35kQ==
X-Google-Smtp-Source: AK7set91aPn/gEbGKn4NZPf0iMo2TsjKaU8DohO0wOw5EsBf5cDKLVU5m3EEfW3a2dkhnNxRDvK78W8f7q0bX8Q0/zE=
X-Received: by 2002:a17:90b:268f:b0:237:6157:b45d with SMTP id
 pl15-20020a17090b268f00b002376157b45dmr91197pjb.95.1677109440340; Wed, 22 Feb
 2023 15:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20230222223714.80671-1-iii@linux.ibm.com> <20230222223714.80671-12-iii@linux.ibm.com>
In-Reply-To: <20230222223714.80671-12-iii@linux.ibm.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 22 Feb 2023 15:43:48 -0800
Message-ID: <CAKH8qBsB0jgeODqhOwiJB1vUZZfWD27VU0nN+Bo8b4aJLBgESg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/12] bpf: Support 64-bit pointers to kfuncs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> test_ksyms_module fails to emit a kfunc call targeting a module on
> s390x, because the verifier stores the difference between kfunc
> address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
> are roughly (1 << 42) bytes away from the kernel on s390x.
>
> Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> and storing the absolute address in bpf_kfunc_desc, which JITs retrieve
> as usual by calling bpf_jit_get_func_addr().
>
> Introduce bpf_get_kfunc_addr() instead of exposing both
> find_kfunc_desc() and struct bpf_kfunc_desc.
>
> This also fixes the problem with XDP metadata functions outlined in
> the description of commit 63d7b53ab59f ("s390/bpf: Implement
> bpf_jit_supports_kfunc_call()") by replacing address lookups with BTF
> id lookups. This eliminates the inconsistency between "abstract" XDP
> metadata functions' BTF ids and their concrete addresses.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

With a nit below (and an unrelated question).

I'll wait a bit for the buildbots to finish until ack'ing the rest.
But the jit (except sparc quirks) and selftest changes also make sense to me.

> ---
>  include/linux/bpf.h   |  2 ++
>  kernel/bpf/core.c     | 21 ++++++++++--
>  kernel/bpf/verifier.c | 79 +++++++++++++------------------------------
>  3 files changed, 44 insertions(+), 58 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 520b238abd5a..e521eae334ea 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2234,6 +2234,8 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>  const struct btf_func_model *
>  bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>                          const struct bpf_insn *insn);
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
> +                      u8 **func_addr);
>  struct bpf_core_ctx {
>         struct bpf_verifier_log *log;
>         const struct btf *btf;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 933869983e2a..4d51782f17ab 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1185,10 +1185,12 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>  {
>         s16 off = insn->off;
>         s32 imm = insn->imm;

[..]

> +       bool fixed;

nit: do we really need that extra fixed bool? Why not directly
*func_addr_fixes = true/false in all the places?

>         u8 *addr;
> +       int err;
>
> -       *func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
> -       if (!*func_addr_fixed) {
> +       switch (insn->src_reg) {
> +       case BPF_PSEUDO_CALL:
>                 /* Place-holder address till the last pass has collected
>                  * all addresses for JITed subprograms in which case we
>                  * can pick them up from prog->aux.
> @@ -1200,15 +1202,28 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>                         addr = (u8 *)prog->aux->func[off]->bpf_func;
>                 else
>                         return -EINVAL;
> -       } else {
> +               fixed = false;
> +               break;
> +       case 0:
>                 /* Address of a BPF helper call. Since part of the core
>                  * kernel, it's always at a fixed location. __bpf_call_base
>                  * and the helper with imm relative to it are both in core
>                  * kernel.
>                  */
>                 addr = (u8 *)__bpf_call_base + imm;
> +               fixed = true;
> +               break;
> +       case BPF_PSEUDO_KFUNC_CALL:
> +               err = bpf_get_kfunc_addr(prog, imm, off, &addr);
> +               if (err)
> +                       return err;
> +               fixed = true;
> +               break;
> +       default:
> +               return -EINVAL;
>         }
>
> +       *func_addr_fixed = fixed;
>         *func_addr = (unsigned long)addr;
>         return 0;
>  }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 574d2dfc6ada..6d4632476c9c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2115,8 +2115,8 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
>  struct bpf_kfunc_desc {
>         struct btf_func_model func_model;
>         u32 func_id;
> -       s32 imm;
>         u16 offset;

[..]

> +       unsigned long addr;

Do we have some canonical type to store the address? I was using void
* in bpf_dev_bound_resolve_kfunc, but we are doing ulong here. We seem
to be doing u64/void */unsigned long inconsistently.

Also, maybe move it up a bit? To turn u32+u16+gap+u64 into u64+u32+u16+padding ?

>  };
>
>  struct bpf_kfunc_btf {
> @@ -2166,6 +2166,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
>                        sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>  }
>
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 offset,
> +                      u8 **func_addr)
> +{
> +       const struct bpf_kfunc_desc *desc;
> +
> +       desc = find_kfunc_desc(prog, func_id, offset);
> +       if (!desc)
> +               return -EFAULT;
> +
> +       *func_addr = (u8 *)desc->addr;
> +       return 0;
> +}
> +
>  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>                                          s16 offset)
>  {
> @@ -2261,8 +2274,8 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>         struct bpf_kfunc_desc *desc;
>         const char *func_name;
>         struct btf *desc_btf;
> -       unsigned long call_imm;
>         unsigned long addr;
> +       void *xdp_kfunc;
>         int err;
>
>         prog_aux = env->prog->aux;
> @@ -2346,24 +2359,21 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>                 return -EINVAL;
>         }
>
> -       call_imm = BPF_CALL_IMM(addr);
> -       /* Check whether or not the relative offset overflows desc->imm */
> -       if ((unsigned long)(s32)call_imm != call_imm) {
> -               verbose(env, "address of kernel function %s is out of range\n",
> -                       func_name);
> -               return -EINVAL;
> -       }
> -
>         if (bpf_dev_bound_kfunc_id(func_id)) {
>                 err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
>                 if (err)
>                         return err;
> +
> +               xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, func_id);
> +               if (xdp_kfunc)
> +                       addr = (unsigned long)xdp_kfunc;
> +               /* fallback to default kfunc when not supported by netdev */
>         }
>
>         desc = &tab->descs[tab->nr_descs++];
>         desc->func_id = func_id;
> -       desc->imm = call_imm;
>         desc->offset = offset;
> +       desc->addr = addr;
>         err = btf_distill_func_proto(&env->log, desc_btf,
>                                      func_proto, func_name,
>                                      &desc->func_model);
> @@ -2373,30 +2383,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>         return err;
>  }
>
> -static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
> -{
> -       const struct bpf_kfunc_desc *d0 = a;
> -       const struct bpf_kfunc_desc *d1 = b;
> -
> -       if (d0->imm > d1->imm)
> -               return 1;
> -       else if (d0->imm < d1->imm)
> -               return -1;
> -       return 0;
> -}
> -
> -static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
> -{
> -       struct bpf_kfunc_desc_tab *tab;
> -
> -       tab = prog->aux->kfunc_tab;
> -       if (!tab)
> -               return;
> -
> -       sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> -            kfunc_desc_cmp_by_imm, NULL);
> -}
> -
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>  {
>         return !!prog->aux->kfunc_tab;
> @@ -2407,14 +2393,15 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>                          const struct bpf_insn *insn)
>  {
>         const struct bpf_kfunc_desc desc = {
> -               .imm = insn->imm,
> +               .func_id = insn->imm,
> +               .offset = insn->off,
>         };
>         const struct bpf_kfunc_desc *res;
>         struct bpf_kfunc_desc_tab *tab;
>
>         tab = prog->aux->kfunc_tab;
>         res = bsearch(&desc, tab->descs, tab->nr_descs,
> -                     sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
> +                     sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>
>         return res ? &res->func_model : NULL;
>  }
> @@ -16267,7 +16254,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                             struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
>         const struct bpf_kfunc_desc *desc;
> -       void *xdp_kfunc;
>
>         if (!insn->imm) {
>                 verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
> @@ -16275,20 +16261,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>         }
>
>         *cnt = 0;
> -
> -       if (bpf_dev_bound_kfunc_id(insn->imm)) {
> -               xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, insn->imm);
> -               if (xdp_kfunc) {
> -                       insn->imm = BPF_CALL_IMM(xdp_kfunc);
> -                       return 0;
> -               }
> -
> -               /* fallback to default kfunc when not supported by netdev */
> -       }
> -
> -       /* insn->imm has the btf func_id. Replace it with
> -        * an address (relative to __bpf_call_base).
> -        */
>         desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
>         if (!desc) {
>                 verbose(env, "verifier internal error: kernel function descriptor not found for func_id %u\n",
> @@ -16296,7 +16268,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                 return -EFAULT;
>         }
>
> -       insn->imm = desc->imm;
>         if (insn->off)
>                 return 0;
>         if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> @@ -16850,8 +16821,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                 }
>         }
>
> -       sort_kfunc_descs_by_imm(env->prog);
> -
>         return 0;
>  }
>
> --
> 2.39.1
>
