Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68BB618B3D
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 23:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKCWRk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKCWRj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 18:17:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C652125F
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 15:17:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g129so2858076pgc.7
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWO3F71iw1Es1/8JhmHTQW/pDkAgPH9yHO8+LjeEcss=;
        b=DfwBM/anoElcSCNeoP72Y2IR6DpxbL3NNw+TECSKzv5ui8jdISWJMXy6aZ4x3m6lQe
         f1vP9f5FOfktI1CmNiKrzG4w2qmmvxZKsrMe3sv7pZrk4hPCWVL/jHdwi5qmItHqoSbr
         8nFCFog/j8SnUWO2I1k48Mt6eXU+kfa9ANXbP2dG1PcpmdVyxdgCLnqKeaeyG8/q580a
         /lEIod2GU152qGJa1nTL4SWBoz2kUAGDRF23sYwDZFpCLvL0Kdb532rQQuJVHdQL0Wzk
         6F+xLUC+vgHY3vpq94X6+3cnkDjNG+skI6Zl6dOhqU5asBGah5NsZdukl38plAFPRgcp
         2paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWO3F71iw1Es1/8JhmHTQW/pDkAgPH9yHO8+LjeEcss=;
        b=zRZr/EuTBWUktxstFA1WiTbSu2/ZuW+jm0zzdTx6kE5BQvhkKK5hyaJw2T0bfXBLEl
         4J7YC+cxkfRvqEkL5frld3fvMzz96KW61sGVtXJiUQnfbXOMJY/8p70NVBPD8kQSpR1d
         BKeDeVPPP0ixf9Jd5fM1ll9B7XwTKBlRcmXsKhIynVCcuPfj4OIKXKnnG9ydd/vJh6uX
         4AgK9Ngc4zlhrAQPcpq3aF1avQHWsNTSRVypmBv5LDEEUJ/eaHmv7T+yXBQECz/NpHUr
         HHuzfUEC073KW4pMTsS3eCTO8kXXsrVxLTZtGzsUQm3Ca5ZVgAB7glavRYJ7MWg0TB0h
         vtgA==
X-Gm-Message-State: ACrzQf2LCqCQCuDxZ7ZMej5A4w2ju8wDA5PbOQ1R/tmYZSQ28B0akax+
        103+cKRfpCuvhu8R6uDR3M8=
X-Google-Smtp-Source: AMsMyM6ZuDhHy6uJSMPw/OYIGVpT6yGyP+e39bOQJtnwdZApmwf7HfxGi7/l6dSYPOWC1g+BGLhTvg==
X-Received: by 2002:a05:6a02:112:b0:440:5515:b908 with SMTP id bg18-20020a056a02011200b004405515b908mr27672018pgb.13.1667513855992;
        Thu, 03 Nov 2022 15:17:35 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b00186a6b63525sm1167651plk.120.2022.11.03.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:17:35 -0700 (PDT)
Date:   Fri, 4 Nov 2022 03:47:15 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
Message-ID: <20221103221715.zyegpoc3puz6oimx@apollo>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072118.2323222-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103072118.2323222-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 03, 2022 at 12:51:18PM IST, Yonghong Song wrote:
> A new bpf_type_flag MEM_RCU is added to indicate a PTR_TO_BTF_ID
> object access needing rcu_read_lock protection. The rcu protection
> is not needed for non-sleepable program. So various verification
> checking is only done for sleepable programs. In particular, only
> the following insns can be inside bpf_rcu_read_lock() region:
>   - any non call insns except BPF_ABS/BPF_IND
>   - non sleepable helpers and kfuncs.
> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
> allocation flag) should be GFP_ATOMIC.
>
> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
> this pointer and the load which gets this pointer needs to be
> protected by bpf_rcu_read_lock(). The following shows a couple
> of examples:
>   struct task_struct {
> 	...
> 	struct task_struct __rcu        *real_parent;
> 	struct css_set __rcu            *cgroups;
> 	...
>   };
>   struct css_set {
> 	...
> 	struct cgroup *dfl_cgrp;
> 	...
>   }
>   ...
>   task = bpf_get_current_task_btf();
>   cgroups = task->cgroups;
>   dfl_cgroup = cgroups->dfl_cgrp;
>   ... using dfl_cgroup ...
>
> The bpf_rcu_read_lock/unlock() should be added like below to
> avoid verification failures.
>   task = bpf_get_current_task_btf();
>   bpf_rcu_read_lock();
>   cgroups = task->cgroups;
>   dfl_cgroup = cgroups->dfl_cgrp;
>   bpf_rcu_read_unlock();
>   ... using dfl_cgroup ...
>
> The following is another example for task->real_parent.
>   task = bpf_get_current_task_btf();
>   bpf_rcu_read_lock();
>   real_parent = task->real_parent;
>   ... bpf_task_storage_get(&map, real_parent, 0, 0);
>   bpf_rcu_read_unlock();
>
> There is another case observed in selftest bpf_iter_ipv6_route.c:
>   struct fib6_info *rt = ctx->rt;
>   ...
>   fib6_nh = &rt->fib6_nh[0]; // Not rcu protected
>   ...
>   if (rt->nh)
>     fib6_nh = &nh->nh_info->fib6_nh; // rcu protected
>   ...
>   ... using fib6_nh ...
> Currently verification will fail with
>   same insn cannot be used with different pointers
> since the use of fib6_nh is tag with rcu in one path
> but not in the other path. The above use case is a valid
> one so the verifier is changed to ignore MEM_RCU type tag
> in such cases.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h          |   3 +
>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/btf.c             |  11 +++
>  kernel/bpf/verifier.c        | 126 ++++++++++++++++++++++++++++++++---
>  4 files changed, 133 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a9bda4c91fc7..f0d973c8d227 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -458,6 +458,9 @@ enum bpf_type_flag {
>  	/* Size is known at compile time. */
>  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
>
> +	/* MEM is tagged with rcu and memory access needs rcu_read_lock protection. */
> +	MEM_RCU			= BIT(11 + BPF_BASE_TYPE_BITS),
> +

IMO, PTR_RCU would be better name for this, since it applied to a specific
pointer through which the access is done.

>  	__BPF_TYPE_FLAG_MAX,
>  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
>  };
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1a32baa78ce2..d4e56f5a4b20 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -324,6 +324,7 @@ struct bpf_verifier_state {
>  	u32 insn_idx;
>  	u32 curframe;
>  	u32 active_spin_lock;
> +	u32 active_rcu_lock;
>  	bool speculative;
>
>  	/* first and last insn idx of this verifier state */
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 35c07afac924..293d224a7f53 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5527,6 +5527,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  			info->reg_type |= MEM_USER;
>  		if (strcmp(tag_value, "percpu") == 0)
>  			info->reg_type |= MEM_PERCPU;
> +		if (strcmp(tag_value, "rcu") == 0)
> +			info->reg_type |= MEM_RCU;
>  	}
>
>  	/* skip modifiers */
> @@ -5765,6 +5767,9 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  				/* check __percpu tag */
>  				if (strcmp(tag_value, "percpu") == 0)
>  					tmp_flag = MEM_PERCPU;
> +				/* check __rcu tag */
> +				if (strcmp(tag_value, "rcu") == 0)
> +					tmp_flag = MEM_RCU;
>  			}
>
>  			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
> @@ -6560,6 +6565,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>
> +	if (sleepable && env->cur_state->active_rcu_lock) {
> +		bpf_log(log, "kernel function %s is sleepable within rcu_read_lock region\n",
> +			func_name);
> +		return -EINVAL;
> +	}
> +
>  	if (kfunc_meta && ref_obj_id)
>  		kfunc_meta->ref_obj_id = ref_obj_id;
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 82c07fe0bfb1..3c5afd3bc216 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -188,6 +188,9 @@ struct bpf_verifier_stack_elem {
>  					  POISON_POINTER_DELTA))
>  #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
>
> +/* Using insn->off = BPF_STORAGE_GET_CALL to mark bpf_*_storage_get() helper calls. */
> +#define BPF_STORAGE_GET_CALL	1
> +
>  static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
>  static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
>
> @@ -511,6 +514,22 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
>  	return func_id == BPF_FUNC_dynptr_data;
>  }
>
> +static bool is_storage_get_function(enum bpf_func_id func_id)
> +{
> +	return func_id == BPF_FUNC_sk_storage_get ||
> +	       func_id == BPF_FUNC_inode_storage_get ||
> +	       func_id == BPF_FUNC_task_storage_get ||
> +	       func_id == BPF_FUNC_cgrp_storage_get;
> +}
> +
> +static bool is_sleepable_function(enum bpf_func_id func_id)
> +{
> +	return func_id == BPF_FUNC_copy_from_user ||
> +	       func_id == BPF_FUNC_copy_from_user_task ||
> +	       func_id == BPF_FUNC_ima_inode_hash ||
> +	       func_id == BPF_FUNC_ima_file_hash;
> +}
> +
>  static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
>  					const struct bpf_map *map)
>  {
> @@ -583,6 +602,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>  		strncpy(prefix, "percpu_", 32);
>  	if (type & PTR_UNTRUSTED)
>  		strncpy(prefix, "untrusted_", 32);
> +	if (type & MEM_RCU)
> +		strncpy(prefix, "rcu_", 32);
>
>  	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
>  		 prefix, str[base_type(type)], postfix);
> @@ -1201,6 +1222,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>  	dst_state->speculative = src->speculative;
>  	dst_state->curframe = src->curframe;
>  	dst_state->active_spin_lock = src->active_spin_lock;
> +	dst_state->active_rcu_lock = src->active_rcu_lock;
>  	dst_state->branches = src->branches;
>  	dst_state->parent = src->parent;
>  	dst_state->first_insn_idx = src->first_insn_idx;
> @@ -4536,6 +4558,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>
> +	if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
> +	    !env->cur_state->active_rcu_lock) {
> +		verbose(env,
> +			"R%d is ptr_%s access rcu-protected memory with off=%d, not in rcu_read_lock region\n",
> +			regno, tname, off);
> +		return -EACCES;
> +	}
> +
>  	if (env->ops->btf_struct_access) {
>  		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
>  						  off, size, atype, &btf_id, &flag);
> @@ -4552,6 +4582,14 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  	if (ret < 0)
>  		return ret;
>
> +	if ((flag & MEM_RCU) && env->prog->aux->sleepable &&
> +	    !env->cur_state->active_rcu_lock) {
> +		verbose(env,
> +			"R%d is rcu dereference ptr_%s with off=%d, not in rcu_read_lock region\n",
> +			regno, tname, off);
> +		return -EACCES;
> +	}
> +

This isn't right. Every load that obtains an RCU pointer needs to become tied to
the current RCU section, and needs to be invalidated once the RCU section ends.

So in addition to checking that bpf_rcu_read_lock is held around MEM_RCU access,
you need to invalidate all MEM_RCU pointers when bpf_rcu_read_unlock is called.

Otherwise, with the current logic, the following would become possible:

bpf_rcu_read_lock();
p = rcu_dereference(foo->rcup);
bpf_rcu_read_unlock();

// p is possibly dead

bpf_rcu_read_lock();
// use p
bpf_rcu_read_unlock();

I have pretty much the same patchset lying locally in my tree (waiting for the
kfunc rework to get in before I post it), but I can also rebase other stuff
using explicit bpf_rcu_read_lock on top of yours.

>  	/* If this is an untrusted pointer, all pointers formed by walking it
>  	 * also inherit the untrusted flag.
>  	 */
> @@ -5684,7 +5722,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
>  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
>  static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
>  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> +static const struct bpf_reg_types btf_ptr_types = {
> +	.types = {
> +		PTR_TO_BTF_ID,
> +		PTR_TO_BTF_ID | MEM_RCU,
> +	}
> +};
>  static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
>  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
>  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> @@ -5758,6 +5801,20 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	if (arg_type & PTR_MAYBE_NULL)
>  		type &= ~PTR_MAYBE_NULL;
>
> +	/* If the reg type is marked as MEM_RCU, ensure the usage is in the rcu_read_lock
> +	 * region, and remove MEM_RCU from the type since the arg_type won't encode
> +	 * MEM_RCU.
> +	 */
> +	if (type & MEM_RCU) {
> +		if (env->prog->aux->sleepable && !env->cur_state->active_rcu_lock) {
> +			verbose(env,
> +				"R%d is arg type %s needs rcu protection\n",
> +				regno, reg_type_str(env, reg->type));
> +			return -EACCES;
> +		}
> +		type &= ~MEM_RCU;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
>  		expected = compatible->types[i];
>  		if (expected == NOT_INIT)
> @@ -5774,7 +5831,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	return -EACCES;
>
>  found:
> -	if (reg->type == PTR_TO_BTF_ID) {
> +	/* reg is already protected by rcu_read_lock(). Peel off MEM_RCU from reg->type. */
> +	if ((reg->type & ~MEM_RCU) == PTR_TO_BTF_ID) {
>  		/* For bpf_sk_release, it needs to match against first member
>  		 * 'struct sock_common', hence make an exception for it. This
>  		 * allows bpf_sk_release to work for multiple socket types.
> @@ -5850,6 +5908,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	 * fixed offset.
>  	 */
>  	case PTR_TO_BTF_ID:
> +	case PTR_TO_BTF_ID | MEM_RCU:
>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>  		 * it's fixed offset must be 0.	In the other cases, fixed offset
>  		 * can be non-zero.
> @@ -7289,6 +7348,26 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	}
>
>  	meta.func_id = func_id;
> +
> +	if (func_id == BPF_FUNC_rcu_read_lock)
> +		env->cur_state->active_rcu_lock++;
> +	if (func_id == BPF_FUNC_rcu_read_unlock) {
> +		if (env->cur_state->active_rcu_lock == 0) {
> +			verbose(env, "missing bpf_rcu_read_lock\n");
> +			return -EINVAL;
> +		}
> +
> +		env->cur_state->active_rcu_lock--;
> +	}
> +	if (env->cur_state->active_rcu_lock) {
> +		if (is_sleepable_function(func_id))
> +			verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",
> +				func_id_name(func_id), func_id);
> +
> +		if (env->prog->aux->sleepable && is_storage_get_function(func_id))
> +			insn->off = BPF_STORAGE_GET_CALL;

This is a bit ugly. Why not use bpf_insn_aux_data?

> +	}
> +
>  	/* check args */
>  	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>  		err = check_func_arg(env, i, &meta, fn);
> @@ -10470,6 +10549,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  		return -EINVAL;
>  	}
>
> +	if (env->prog->aux->sleepable && env->cur_state->active_rcu_lock) {
> +		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_rcu_read_lock-ed region\n");
> +		return -EINVAL;
> +	}
> +
>  	if (regs[ctx_reg].type != PTR_TO_CTX) {
>  		verbose(env,
>  			"at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
> @@ -11734,6 +11818,9 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	if (old->active_spin_lock != cur->active_spin_lock)
>  		return false;
>
> +	if (old->active_rcu_lock != cur->active_rcu_lock)
> +		return false;
> +
>  	/* for states to be equal callsites have to be the same
>  	 * and all frame states need to be equivalent
>  	 */
> @@ -12141,6 +12228,11 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
>  			       !reg_type_mismatch_ok(prev));
>  }
>
> +static bool reg_type_mismatch_ignore_rcu(enum bpf_reg_type src, enum bpf_reg_type prev)
> +{
> +	return reg_type_mismatch(src & ~MEM_RCU, prev & ~MEM_RCU);
> +}
> +

See the discussion about this in David's set:
https://lore.kernel.org/bpf/CAP01T75FGW7F=Ho+oqoC6WgxK5uUir2=CUgiW_HwqNxmzmthBg@mail.gmail.com

>  static int do_check(struct bpf_verifier_env *env)
>  {
>  	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
> @@ -12266,6 +12358,18 @@ static int do_check(struct bpf_verifier_env *env)
>
>  			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
>
> +			/* For NOT_INIT *prev_src_type, ignore rcu type tag.
> +			 * For code like below,
> +			 *   struct foo *f;
> +			 *   if (...)
> +			 *     f = ...; // f with MEM_RCU type tag.
> +			 *   else
> +			 *     f = ...; // f without MEM_RCU type tag.
> +			 *   ... f ...  // Here f could be with/without MEM_RCU
> +			 *
> +			 * It is safe to ignore MEM_RCU type tag here since
> +			 * base types are the same.
> +			 */
>  			if (*prev_src_type == NOT_INIT) {
>  				/* saw a valid insn
>  				 * dst_reg = *(u32 *)(src_reg + off)
> @@ -12273,7 +12377,7 @@ static int do_check(struct bpf_verifier_env *env)
>  				 */
>  				*prev_src_type = src_reg_type;
>
> -			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
> +			} else if (reg_type_mismatch_ignore_rcu(src_reg_type, *prev_src_type)) {
>  				/* ABuser program is trying to use the same insn
>  				 * dst_reg = *(u32*) (src_reg + off)
>  				 * with different pointer types:
> @@ -12412,6 +12516,11 @@ static int do_check(struct bpf_verifier_env *env)
>  					return -EINVAL;
>  				}
>
> +				if (env->cur_state->active_rcu_lock) {
> +					verbose(env, "bpf_rcu_read_unlock is missing\n");
> +					return -EINVAL;
> +				}
> +
>  				/* We must do check_reference_leak here before
>  				 * prepare_func_exit to handle the case when
>  				 * state->curframe > 0, it may be a callback
> @@ -13499,6 +13608,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
>  			break;
>  		case PTR_TO_BTF_ID:
> +		case PTR_TO_BTF_ID | MEM_RCU:

This shouldn't be needed, right? If it is RCU protected, there shouldn't be a
need for handling faults (or it's a bug in the kernel).

>  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
>  			if (type == BPF_READ) {
>  				insn->code = BPF_LDX | BPF_PROBE_MEM |
> @@ -14148,11 +14258,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			goto patch_call_imm;
>  		}
>
> -		if (insn->imm == BPF_FUNC_task_storage_get ||
> -		    insn->imm == BPF_FUNC_sk_storage_get ||
> -		    insn->imm == BPF_FUNC_inode_storage_get ||
> -		    insn->imm == BPF_FUNC_cgrp_storage_get) {
> -			if (env->prog->aux->sleepable)
> +		if (is_storage_get_function(insn->imm)) {
> +			if (env->prog->aux->sleepable && insn->off) {
> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> +				insn->off = 0;
> +			} else if (env->prog->aux->sleepable)
>  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
>  			else
>  				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
> --
> 2.30.2
>
