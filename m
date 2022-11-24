Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E464636FF0
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 02:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKXBlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 20:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKXBlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 20:41:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D97CFEA8
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 17:41:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vv4so1081238ejc.2
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 17:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEnBdet9Ta62vT0PAZY1Nhj0u2eMC6VYWzZNbQFlles=;
        b=af9ze564WxSAK0lKzH93QXgNIwwWRfWA8a9GslcLx3lFq6m2OCkyiIxisUYINC6Lve
         ZIHslbdBTuawgBlmcUedGT+pdwOaG3vlsRX7HacTGvB8kKuSdsBBqx3Lb1cK4pITKC/V
         x8yG2wwDAww4ftcQnhNo9W4x4TNEtDw4zo+nO7PKps4CvnIDTACTFPqgg/LXYxedWfJd
         cDLLsUZ1TpvvNK/rdqORfE/4R0BaZwtdvkt+9x+1H/ALmw//brPbcP1zJd0EYHZPpFyo
         Np/8FkdM2Slr7WUNyj6pVpPRZx7QnJy/hcTtxQbpVnNgyynYcGX93DIZT3GbpcCBMH2P
         WXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEnBdet9Ta62vT0PAZY1Nhj0u2eMC6VYWzZNbQFlles=;
        b=DFCKlebMHpSAqDKNd+/00MuZvVuonmylsyYYAQVogvVziHARWrQ6a17X1X2Gybjjhp
         CJyt5jpcQeLPxCfYIgVhlZUm43U3s5ii6sP0Tq7GIDmkabnI8DEtMsLytnCVm9Q4rKK2
         tCeh2ffQx9Mf9sNXq91+GpDn95FeVOwp4MQHrXBOARU/dj4zuA136hrlS1MtX0A3qP7i
         vCDLdR+DqQxkRF2XiCYNrJe/sRAB9Ed7DlBWy3coSHzR8DUi0EDRAUGQhbGCARE5JjGi
         RlYjGYrDkrfxyyOQri2qGa8iKnnCsLCvBQTJN7vnEtmmimuhH6KFaZ7AfcZHBiTN8Gj9
         H0lg==
X-Gm-Message-State: ANoB5pl+M33gjVyWOwamBAYohXmyhaFQhnGnFtpSb6f2yHXYNDXNwMRJ
        I7w1ul0b/RmyU9plLXZHnAWYenEzyhvPxkOGj0Y=
X-Google-Smtp-Source: AA0mqf78+diBVyuMvsWDmguR7t/MAo0rP9/gnIu3+wE2yAxVcNBZ8j+lkCuXKbho3Qz7o46CP+DZVpe3CL+FmIMMO18=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr14245607eje.94.1669254065375; Wed, 23
 Nov 2022 17:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20221123045350.2322811-1-yhs@fb.com> <20221123045406.2324479-1-yhs@fb.com>
In-Reply-To: <20221123045406.2324479-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Nov 2022 17:40:54 -0800
Message-ID: <CAADnVQJGx=8Hdd_fzV=jt7n_zo9GwG5O5a3S4V4JJiM3YpxSkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Tue, Nov 22, 2022 at 8:54 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These two kfunc's
> can be used for all program types. The following is an example about how
> rcu pointer are used w.r.t. bpf_rcu_read_lock()/bpf_rcu_read_unlock().
>
>   struct task_struct {
>     ...
>     struct task_struct              *last_wakee;
>     struct task_struct __rcu        *real_parent;
>     ...
>   };
>
> Let us say prog does 'task = bpf_get_current_task_btf()' to get a
> 'task' pointer. The basic rules are:
>   - 'real_parent = task->real_parent' should be inside bpf_rcu_read_lock
>     region.  this is to simulate rcu_dereference() operation. The
>     'real_parent' is marked as MEM_RCU only if (1). task->real_parent is
>     inside bpf_rcu_read_lock region, and (2). task is a trusted ptr. So
>     MEM_RCU marked ptr can be 'trusted' inside the bpf_rcu_read_lock region.
>   - 'last_wakee = real_parent->last_wakee' should be inside bpf_rcu_read_lock
>     region since it tries to access rcu protected memory.
>   - the ptr 'last_wakee' will be marked as PTR_UNTRUSTED since in general
>     it is not clear whether the object pointed by 'last_wakee' is valid or
>     not even inside bpf_rcu_read_lock region.
>
> To prevent rcu pointer leaks outside the rcu read lock region.
> The verifier will clear all rcu pointer register state to unknown, i.e.,
> scalar_value, at bpf_rcu_read_unlock() kfunc call site,
> so later dereference becomes impossible.
>
> The current implementation does not support nested rcu read lock
> region in the prog.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h          |   3 +
>  include/linux/bpf_verifier.h |   4 +-
>  kernel/bpf/btf.c             |   3 +
>  kernel/bpf/helpers.c         |  12 +++
>  kernel/bpf/verifier.c        | 155 ++++++++++++++++++++++++++++-------
>  5 files changed, 147 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 43fd7eeeeabb..c6aa6912ea16 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -572,6 +572,9 @@ enum bpf_type_flag {
>          */
>         PTR_TRUSTED             = BIT(12 + BPF_BASE_TYPE_BITS),
>
> +       /* MEM is tagged with rcu and memory access needs rcu_read_lock protection. */
> +       MEM_RCU                 = BIT(13 + BPF_BASE_TYPE_BITS),
> +
>         __BPF_TYPE_FLAG_MAX,
>         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
>  };
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 545152ac136c..1f3ce54e50ed 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -344,6 +344,7 @@ struct bpf_verifier_state {
>                 u32 id;
>         } active_lock;
>         bool speculative;
> +       bool active_rcu_lock;
>
>         /* first and last insn idx of this verifier state */
>         u32 first_insn_idx;
> @@ -445,6 +446,7 @@ struct bpf_insn_aux_data {
>         u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
>         bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
>         bool zext_dst; /* this insn zero extends dst reg */
> +       bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
>         u8 alu_state; /* used in combination with alu_limit */
>
>         /* below fields are initialized once */
> @@ -680,7 +682,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
>         }
>  }
>
> -#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
> +#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
>
>  static inline bool bpf_type_has_unsafe_modifiers(u32 type)
>  {
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1a59cc7ad730..68df0df27302 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6237,6 +6237,9 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>                                 /* check __percpu tag */
>                                 if (strcmp(tag_value, "percpu") == 0)
>                                         tmp_flag = MEM_PERCPU;
> +                               /* check __rcu tag */
> +                               if (strcmp(tag_value, "rcu") == 0)
> +                                       tmp_flag = MEM_RCU;
>                         }
>
>                         stype = btf_type_skip_modifiers(btf, mtype->type, &id);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index ae565b495f3d..eda9824694bf 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1971,6 +1971,16 @@ void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
>         return obj__ign;
>  }
>
> +void bpf_rcu_read_lock(void)
> +{
> +       rcu_read_lock();
> +}
> +
> +void bpf_rcu_read_unlock(void)
> +{
> +       rcu_read_unlock();
> +}
> +

I think the check from selftest:

/* rcu_tag_btf_id < 0 implies rcu tag support not available in vmlinux btf */
rcu_tag_btf_id = btf__find_by_name_kind(vmlinux_btf, "rcu", BTF_KIND_TYPE_TAG);

should be done by the kernel as well.
And if the kernel is not compiled with clang the verifier
should probably disallow bpf_rcu_read_lock/unlock kfuncs.

Otherwise the same bpf prog will work differently
depending on whether the kernel was compiled with gcc or clang.

>  __diag_pop();
>
>  BTF_SET8_START(generic_btf_ids)
> @@ -2012,6 +2022,8 @@ BTF_ID(func, bpf_cgroup_release)
>  BTF_SET8_START(common_btf_ids)
>  BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
>  BTF_ID_FLAGS(func, bpf_rdonly_cast)
> +BTF_ID_FLAGS(func, bpf_rcu_read_lock)
> +BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
>  BTF_SET8_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 068cc885903c..f76c341fea82 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -527,6 +527,14 @@ static bool is_callback_calling_function(enum bpf_func_id func_id)
>                func_id == BPF_FUNC_user_ringbuf_drain;
>  }
>
> +static bool is_storage_get_function(enum bpf_func_id func_id)
> +{
> +       return func_id == BPF_FUNC_sk_storage_get ||
> +              func_id == BPF_FUNC_inode_storage_get ||
> +              func_id == BPF_FUNC_task_storage_get ||
> +              func_id == BPF_FUNC_cgrp_storage_get;
> +}
> +
>  static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
>                                         const struct bpf_map *map)
>  {
> @@ -589,11 +597,12 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>                         strncpy(postfix, "_or_null", 16);
>         }
>
> -       snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
> +       snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
>                  type & MEM_RDONLY ? "rdonly_" : "",
>                  type & MEM_RINGBUF ? "ringbuf_" : "",
>                  type & MEM_USER ? "user_" : "",
>                  type & MEM_PERCPU ? "percpu_" : "",
> +                type & MEM_RCU ? "rcu_" : "",
>                  type & PTR_UNTRUSTED ? "untrusted_" : "",
>                  type & PTR_TRUSTED ? "trusted_" : ""
>         );
> @@ -1220,6 +1229,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>                 dst_state->frame[i] = NULL;
>         }
>         dst_state->speculative = src->speculative;
> +       dst_state->active_rcu_lock = src->active_rcu_lock;
>         dst_state->curframe = src->curframe;
>         dst_state->active_lock.ptr = src->active_lock.ptr;
>         dst_state->active_lock.id = src->active_lock.id;
> @@ -4258,6 +4268,25 @@ static bool is_flow_key_reg(struct bpf_verifier_env *env, int regno)
>         return reg->type == PTR_TO_FLOW_KEYS;
>  }
>
> +static bool is_trusted_reg(const struct bpf_reg_state *reg)
> +{
> +       /* A referenced register is always trusted. */
> +       if (reg->ref_obj_id)
> +               return true;
> +
> +       /* If a register is not referenced, it is trusted if it has either the
> +        * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the

The comment needs to be adjusted.

> +        * other type modifiers may be safe, but we elect to take an opt-in
> +        * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
> +        * not.
> +        *
> +        * Eventually, we should make PTR_TRUSTED the single source of truth
> +        * for whether a register is trusted.
> +        */
> +       return type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS &&
> +              !bpf_type_has_unsafe_modifiers(reg->type);
> +}
> +
>  static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
>                                    const struct bpf_reg_state *reg,
>                                    int off, int size, bool strict)
> @@ -4737,9 +4766,29 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>         if (type_flag(reg->type) & PTR_UNTRUSTED)
>                 flag |= PTR_UNTRUSTED;
>
> -       /* Any pointer obtained from walking a trusted pointer is no longer trusted. */
> +       /* By default any pointer obtained from walking a trusted pointer is
> +        * no longer trusted except the rcu case below.
> +        */
>         flag &= ~PTR_TRUSTED;
>
> +       if (flag & MEM_RCU) {
> +               /* Mark value register as MEM_RCU only if it is protected by
> +                * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
> +                * itself can already indicate trustedness inside the rcu
> +                * read lock region. But Mark it as PTR_TRUSTED as well
> +                * similar to MEM_ALLOC.

'similar to MEM_ALLOC' part is not true yet.
Let's not get ahead of ourselves :)

> +                */
> +               if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
> +                       flag &= ~MEM_RCU;
> +               else
> +                       flag |= PTR_TRUSTED;
> +       } else if (reg->type & MEM_RCU) {
> +               /* ptr (reg) is marked as MEM_RCU, but value reg is not marked
> +                * as MEM_RCU. Mark the value reg as PTR_UNTRUSTED conservatively.
> +                */
> +               flag |= PTR_UNTRUSTED;

The part about 'value reg' doesn't look correct.
This part of the code has no idea about 'value reg' yet.
We just checked 'flag & MEM_RCU', so it's the flag that doesn't have
MEM_RCU set which means that the field of the structure we're
dereferencing doesn't have __rcu tag.
I think it's better to adjust this comment.

> +       }
> +
>         if (atype == BPF_READ && value_regno >= 0)
>                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
>
> @@ -5897,6 +5946,7 @@ static const struct bpf_reg_types btf_ptr_types = {
>         .types = {
>                 PTR_TO_BTF_ID,
>                 PTR_TO_BTF_ID | PTR_TRUSTED,
> +               PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
>         },
>  };
>  static const struct bpf_reg_types percpu_btf_ptr_types = {
> @@ -6075,6 +6125,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         case PTR_TO_BTF_ID:
>         case PTR_TO_BTF_ID | MEM_ALLOC:
>         case PTR_TO_BTF_ID | PTR_TRUSTED:
> +       case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
>         case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
>                 /* When referenced PTR_TO_BTF_ID is passed to release function,
>                  * it's fixed offset must be 0. In the other cases, fixed offset
> @@ -7539,6 +7590,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 return err;
>         }
>
> +       if (env->cur_state->active_rcu_lock) {
> +               if (fn->might_sleep) {
> +                       verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",
> +                               func_id_name(func_id), func_id);
> +                       return -EINVAL;
> +               }
> +
> +               if (env->prog->aux->sleepable && is_storage_get_function(func_id))
> +                       env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
> +       }
> +
>         meta.func_id = func_id;
>         /* check args */
>         for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> @@ -7966,25 +8028,6 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>         return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>  }
>
> -static bool is_trusted_reg(const struct bpf_reg_state *reg)
> -{
> -       /* A referenced register is always trusted. */
> -       if (reg->ref_obj_id)
> -               return true;
> -
> -       /* If a register is not referenced, it is trusted if it has either the
> -        * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
> -        * other type modifiers may be safe, but we elect to take an opt-in
> -        * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
> -        * not.
> -        *
> -        * Eventually, we should make PTR_TRUSTED the single source of truth
> -        * for whether a register is trusted.
> -        */
> -       return type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS &&
> -              !bpf_type_has_unsafe_modifiers(reg->type);
> -}
> -
>  static bool __kfunc_param_match_suffix(const struct btf *btf,
>                                        const struct btf_param *arg,
>                                        const char *suffix)
> @@ -8163,6 +8206,8 @@ enum special_kfunc_type {
>         KF_bpf_list_pop_back,
>         KF_bpf_cast_to_kern_ctx,
>         KF_bpf_rdonly_cast,
> +       KF_bpf_rcu_read_lock,
> +       KF_bpf_rcu_read_unlock,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -8185,6 +8230,18 @@ BTF_ID(func, bpf_list_pop_front)
>  BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
> +BTF_ID(func, bpf_rcu_read_lock)
> +BTF_ID(func, bpf_rcu_read_unlock)
> +
> +static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +       return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
> +}
> +
> +static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +       return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
> +}
>
>  static enum kfunc_ptr_arg_type
>  get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> @@ -8817,6 +8874,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>         const struct btf_type *t, *func, *func_proto, *ptr_type;
>         struct bpf_reg_state *regs = cur_regs(env);
>         const char *func_name, *ptr_type_name;
> +       bool sleepable, rcu_lock, rcu_unlock;
>         struct bpf_kfunc_call_arg_meta meta;
>         u32 i, nargs, func_id, ptr_type_id;
>         int err, insn_idx = *insn_idx_p;
> @@ -8858,11 +8916,38 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                 return -EACCES;
>         }
>
> -       if (is_kfunc_sleepable(&meta) && !env->prog->aux->sleepable) {
> +       sleepable = is_kfunc_sleepable(&meta);
> +       if (sleepable && !env->prog->aux->sleepable) {
>                 verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
>                 return -EACCES;
>         }
>
> +       rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
> +       rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
> +       if (env->cur_state->active_rcu_lock) {
> +               struct bpf_func_state *state;
> +               struct bpf_reg_state *reg;
> +
> +               if (rcu_lock) {
> +                       verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
> +                       return -EINVAL;
> +               } else if (rcu_unlock) {
> +                       bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> +                               if (reg->type & MEM_RCU)
> +                                       __mark_reg_unknown(env, reg);
> +                       }));

That feels too drastic.
rcu_unlock will mark all pointers as scalar,
but the prog can still do bpf_rdonly_cast and read them.
Why force the prog to jump through such hoops?
Are we trying to prevent some kind of programming mistake?

Maybe clear MEM_RCU flag here and add PTR_UNTRUSTED instead?

> +                       env->cur_state->active_rcu_lock = false;
> +               } else if (sleepable) {
> +                       verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
> +                       return -EACCES;
> +               }
> +       } else if (rcu_lock) {
> +               env->cur_state->active_rcu_lock = true;
> +       } else if (rcu_unlock) {
> +               verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
> +               return -EINVAL;
> +       }
> +
>         /* Check the arguments */
>         err = check_kfunc_args(env, &meta);
>         if (err < 0)
> @@ -11754,6 +11839,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>                 return -EINVAL;
>         }
>
> +       if (env->cur_state->active_rcu_lock) {
> +               verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock-ed region\n");
> +               return -EINVAL;
> +       }
> +
>         if (regs[ctx_reg].type != PTR_TO_CTX) {
>                 verbose(env,
>                         "at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
> @@ -13019,6 +13109,9 @@ static bool states_equal(struct bpf_verifier_env *env,
>             old->active_lock.id != cur->active_lock.id)
>                 return false;
>
> +       if (old->active_rcu_lock != cur->active_rcu_lock)
> +               return false;
> +
>         /* for states to be equal callsites have to be the same
>          * and all frame states need to be equivalent
>          */
> @@ -13706,6 +13799,11 @@ static int do_check(struct bpf_verifier_env *env)
>                                         return -EINVAL;
>                                 }
>
> +                               if (env->cur_state->active_rcu_lock) {
> +                                       verbose(env, "bpf_rcu_read_unlock is missing\n");
> +                                       return -EINVAL;
> +                               }
> +
>                                 /* We must do check_reference_leak here before
>                                  * prepare_func_exit to handle the case when
>                                  * state->curframe > 0, it may be a callback
> @@ -14802,6 +14900,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>                 case PTR_TO_BTF_ID:
>                 case PTR_TO_BTF_ID | PTR_UNTRUSTED:
>                 case PTR_TO_BTF_ID | PTR_TRUSTED:
> +               case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
>                 /* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
>                  * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
>                  * be said once it is marked PTR_UNTRUSTED, hence we must handle

wait a sec.
Why are we converting PTR_TRUSTED, MEM_RCU, MEM_ALLOC pointers into
BPF_PROBE_MEM ?
The mistake slipped in earlier, but let's fix it first.

BPF_REG_TRUSTED_MODIFIERS should stay as normal LDX.

> @@ -15494,14 +15593,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                         goto patch_call_imm;
>                 }
>
> -               if (insn->imm == BPF_FUNC_task_storage_get ||
> -                   insn->imm == BPF_FUNC_sk_storage_get ||
> -                   insn->imm == BPF_FUNC_inode_storage_get ||
> -                   insn->imm == BPF_FUNC_cgrp_storage_get) {
> -                       if (env->prog->aux->sleepable)
> -                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
> -                       else
> +               if (is_storage_get_function(insn->imm)) {
> +                       if (!env->prog->aux->sleepable ||
> +                           env->insn_aux_data[i + delta].storage_get_func_atomic)
>                                 insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> +                       else
> +                               insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
>                         insn_buf[1] = *insn;
>                         cnt = 2;
>
> --
> 2.30.2
>
