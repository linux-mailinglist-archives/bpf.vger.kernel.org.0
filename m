Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59A1696EFF
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 22:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjBNVOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 16:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjBNVOE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 16:14:04 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11C82FCC6
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 13:13:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 139so18296963ybe.3
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hd0m2MxONjC6d6C1HIeIWf7QleThADNMTx4mMlRapE=;
        b=O2A+1H+BhmaC+bXVmCcYap7joUScO+9gjg5uCc9tBu0WH+Mxxc3O7JIFZrAteRsUZd
         BjQvtGznxFJYJUbZYFNuq2j8U6T/ZePCQ4K9U0ch057JwMCMkTZZP9C1e2oEW7JD85Ju
         DJ95YHdTpMQcttEs7oe6j5SCy6qq6mN0zdIRUI4+ZchSXvU5KTv3yJK1OQekRHXrQ8lb
         ENdeXOGMdULOwV2Oi6YScgKOGOhLXCOUzIAZCxBOqbmyxI0u8egg1JJCodUJE3vHLok0
         vqqFvfAi5sI/wDqLEN/e+lBJwLlI6atDl8oMRXGluVDtIfG1OtJKok/pNuGFg5pFkz57
         trZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hd0m2MxONjC6d6C1HIeIWf7QleThADNMTx4mMlRapE=;
        b=W9DngMrBmDAeixckBEXlf455s48GdZhfJPHmXzbRxPecvDwKtM/g0fpdGso6cY5Ugc
         VBaf99RDuktnuBZ28LJILx1BYHoLpSSdgK5rRWdC1Sm4+0QQHYUhwtK3t7JDEf9P0L8C
         E52SJIVzKuurR4hfDYFK3leeMJmOHpS2YybhwPVxri3AGnRIBjhHxvBlIDuhb97z77e8
         Zm3SndWfXxGKNO2FsJRD7zSZbo2wP4z7Y5UYuvsQMp/6woNXnNGGsSnHtey809wbP/Zp
         TkU7RZ96+u+R9nv46aGF/7HHG4mA38XZlKzplngPnDWkPc5Y6TypQ1C4LnRpt1QK2QjJ
         KXJA==
X-Gm-Message-State: AO0yUKVhNgdxUeXYjClXD5UwsVwjx3l1498y4HwBPXHYhOkfuGQ0bq+U
        sWqLES24GAz6KoGRMnupyIRjTW8IeMm2Nvh4E2AGyktv
X-Google-Smtp-Source: AK7set8FB6dROHjc/ItvCleObzEnUDvkXldD5FOq7TZ2JBB3cxybb/A3GhhnRQKjeuvWPYM/Z7pVfvEzftOmFYQ1oI8=
X-Received: by 2002:a25:9f90:0:b0:8ec:929:cc93 with SMTP id
 u16-20020a259f90000000b008ec0929cc93mr4988ybq.281.1676409234672; Tue, 14 Feb
 2023 13:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20230214190551.2264057-1-davemarchevsky@fb.com>
In-Reply-To: <20230214190551.2264057-1-davemarchevsky@fb.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 14 Feb 2023 13:13:43 -0800
Message-ID: <CAJnrk1bYbVd2AHH71eiaD6gY4r3sMjMFVGHmwvAY3BqJOQLVhQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Refactor release_regno searching logic
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 11:17 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
> that examines each individual arg (check_func_arg for helpers and
> check_kfunc_args inner loop for kfuncs). This patch pulls out this
> searching to occur before individual arg type handling, resulting in a
> cleaner separation of logic and shared logic between kfuncs and helpers.
>
> The logic for this searching is already very similar between kfuncs and
> helpers:
>
> Kfuncs:
>   * Function-level KF_RELEASE flag indicates that the kfunc releases
>     some previously-acquired arg
>   * Verifier searches through arg regs to find those with ref_obj_id set
>     * One such arg reg is selected. If multiple arg regs have ref_obj_id
>       set, the last one (by regno) is chosen to be released
>
> Helpers:
>   * OBJ_RELEASE is used in function proto to tag a particular arg as the
>     one that should be released
>     * There can only be one such tagged arg
>   * Verifier confirms that only one arg reg has ref_obj_id set and that
>     that reg matches expected OBJ_RELEASE arg
>     * If OBJ_RELEASE arg doesn't have a matching ref_obj_id arg reg, or
>       some other arg reg has ref_obj_id, it's an invalid state
>
> It's a long-term goal to merge as much kfunc and helper logic as
> possible. Merging the similar functionality here is a small step in that
> direction.
>
> Two new helper functions are added:
>   * args_find_ref_obj_id_regno
>     * For helpers and kfuncs. Searches through arg regs to find
>       ref_obj_id reg and returns its regno.
>
>   * helper_proto_find_release_arg_regno
>     * For helpers only. Searches through fn proto args to find the
>       OBJ_RELEASE arg and returns the corresponding regno.
>
> The refactoring strives to keep failure logic and error messages
> unchanged. However, because the release arg searching is now done before
> any arg-specific type checking, verifier states that are invalid due to
> both invalid release arg state _and_ some type- or helper-specific
> checking logic might see the release arg-related error message first,
> when previously verification would fail for the other reason.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> v2 -> v3:
>  * Edit patch summary for clarity
>  * Correct err_multi comment in args_find_ref_obj_id_regno doc string
>  * Rebase onto latest bpf-next: 'Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"'
>
> v1 -> v2: https://lore.kernel.org/bpf/20230121002417.1684602-1-davemarchevsky@fb.com/
>  * Fix uninitialized variable complaint (kernel test bot)
>  * Add err_multi param to args_find_ref_obj_id_regno - kfunc arg reg
>    checking wasn't erroring if multiple ref_obj_id arg regs were found,
>    retain this behavior
>
> v0 -> v1: https://lore.kernel.org/bpf/20221217082506.1570898-2-davemarchevsky@fb.com/
>  * Remove allow_multi from args_find_ref_obj_id_regno, no need to
>    support multiple ref_obj_id arg regs
>  * No need to use temp variable 'i' to count nargs (David)
>  * Proper formatting of function-level comments on newly-added helpers (David)
>
>  kernel/bpf/verifier.c | 220 +++++++++++++++++++++++++++++-------------
>  1 file changed, 153 insertions(+), 67 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 21e08c111702..c0d01085f44f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6735,48 +6735,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 return err;
>
[...]
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                              int *insn_idx_p)
>  {
>         enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> +       int i, err, func_id, nargs, release_regno, ref_regno;
>         const struct bpf_func_proto *fn = NULL;
>         enum bpf_return_type ret_type;
>         enum bpf_type_flag ret_flag;
> @@ -8115,7 +8178,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         struct bpf_call_arg_meta meta;
>         int insn_idx = *insn_idx_p;
>         bool changes_data;
> -       int i, err, func_id;
>
>         /* find function prototype */
>         func_id = insn->imm;
> @@ -8179,8 +8241,37 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         }
>
>         meta.func_id = func_id;
> +       regs = cur_regs(env);
> +
> +       /* find actual arg count */
> +       for (nargs = 0; nargs < MAX_BPF_FUNC_REG_ARGS; nargs++)
> +               if (fn->arg_type[nargs] == ARG_DONTCARE)
> +                       break;
> +
> +       release_regno = helper_proto_find_release_arg_regno(env, fn, nargs);
> +       if (release_regno < 0)
> +               return release_regno;
> +
> +       ref_regno = args_find_ref_obj_id_regno(env, regs, nargs, true);
> +       if (ref_regno < 0)
> +               return ref_regno;
> +       else if (ref_regno > 0)
> +               meta.ref_obj_id = regs[ref_regno].ref_obj_id;

nit: I think it's easier to read if this ref_regno logic gets moved
below the release_regno logic, so that all the release_regno logic is
together

> +
> +       if (release_regno > 0) {
> +               if (!regs[release_regno].ref_obj_id &&
> +                   !register_is_null(&regs[release_regno]) &&
> +                   !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
> +                       verbose(env, "R%d must be referenced when passed to release function\n",
> +                               release_regno);
> +                       return -EINVAL;
> +               }
> +
> +               meta.release_regno = release_regno;
> +       }
> +
>         /* check args */
> -       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +       for (i = 0; i < nargs; i++) {
>                 err = check_func_arg(env, i, &meta, fn);
>                 if (err)
>                         return err;
> @@ -8204,8 +8295,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                         return err;
>         }
>
> -       regs = cur_regs(env);
> -
>         /* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
>          * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
>          * is safe to do directly.
> @@ -9442,10 +9531,11 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>  {
>         const char *func_name = meta->func_name, *ref_tname;
> +       struct bpf_reg_state *regs = cur_regs(env);
>         const struct btf *btf = meta->btf;
>         const struct btf_param *args;
> +       int ret, ref_regno;
>         u32 i, nargs;
> -       int ret;
>
>         args = (const struct btf_param *)(meta->func_proto + 1);
>         nargs = btf_type_vlen(meta->func_proto);
> @@ -9455,17 +9545,31 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>                 return -EINVAL;
>         }
>
> +       ref_regno = args_find_ref_obj_id_regno(env, cur_regs(env), nargs, false);

nit: I think we can just pass in "regs" as the 2nd arg

> +       if (ref_regno < 0) {
> +               return ref_regno;
> +       } else if (!ref_regno && is_kfunc_release(meta)) {
> +               verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> +                       func_name);
> +               return -EINVAL;
> +       }
> +
> +       meta->ref_obj_id = regs[ref_regno].ref_obj_id;
> +       if (is_kfunc_release(meta))
> +               meta->release_regno = ref_regno;
> +

I think we also need to check that if the kfunc is a release func then
there can't be more than one arg reg with a set ref_obj_id (the
earlier call to args_find_ref_obj_id_regno doesn't catch this since we
pass in false for err_multi)

>         /* Check that BTF function arguments match actual types that the
>          * verifier sees.
>          */
>         for (i = 0; i < nargs; i++) {
> -               struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
>                 const struct btf_type *t, *ref_t, *resolve_ret;
>                 enum bpf_arg_type arg_type = ARG_DONTCARE;
>                 u32 regno = i + 1, ref_id, type_size;
>                 bool is_ret_buf_sz = false;
> +               struct bpf_reg_state *reg;
>                 int kf_arg_type;
>
> +               reg = &regs[regno];
>                 t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>
>                 if (is_kfunc_arg_ignore(btf, &args[i]))
> @@ -9528,18 +9632,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>                         return -EACCES;
>                 }
>
> -               if (reg->ref_obj_id) {
> -                       if (is_kfunc_release(meta) && meta->ref_obj_id) {
> -                               verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -                                       regno, reg->ref_obj_id,
> -                                       meta->ref_obj_id);
> -                               return -EFAULT;
> -                       }
> -                       meta->ref_obj_id = reg->ref_obj_id;
> -                       if (is_kfunc_release(meta))
> -                               meta->release_regno = regno;
> -               }
> -
>                 ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>                 ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>
> @@ -9585,7 +9677,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>                         return -EFAULT;
>                 }
>
> -               if (is_kfunc_release(meta) && reg->ref_obj_id)
> +               if (is_kfunc_release(meta) && regno == meta->release_regno)

I don't think we need the "is_kfunc_release(meta)" check here since
meta->release_regno is set to a regno only when is_kfunc_release(meta)
is true

>                         arg_type |= OBJ_RELEASE;
>                 ret = check_func_arg_reg_off(env, reg, regno, arg_type);
>                 if (ret < 0)
> @@ -9747,12 +9839,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>                 }
>         }
>
> -       if (is_kfunc_release(meta) && !meta->release_regno) {
> -               verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> -                       func_name);
> -               return -EINVAL;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.30.2
>
