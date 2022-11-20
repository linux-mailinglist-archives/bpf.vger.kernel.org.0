Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F006315FB
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTTqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKTTqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:46:02 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC62E9D5;
        Sun, 20 Nov 2022 11:46:00 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j12so8817948plj.5;
        Sun, 20 Nov 2022 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSrs1ucQDnZEbTziL8NtM/AcshFZ2RL7pB9xrfB5Jj0=;
        b=oTSc1ChFNecJAo5dWHcbAlgb8kGAbU8VfEs1r9JKZ6zKaMj986xKhBB4OuSUfC6n+a
         wdpN30UEj5bKTrm61MyPc9JWmRhKYomiqKmklXYiT7FbykqRWep5C4MgOSVn9of7/1tE
         j5nZZRX4TP52N8ryTpwD9To46lv2g8xpmeHTKy9VNNrlbTlX10g9sMOYxc1WH3cdzT1v
         LaLh9Z6fUTUQ21r9q+BiqvPd7rHzFEQ/GxAB8v8zvEWkvVH65T6gwHVpwhIP0ebVSaxr
         Qz2Xk2rUJoOESEUj39hWza/e4G5EE8KrkAYSBhW0W/kCCW0d1mCYGKnpwhuvOe7CUd8T
         JGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSrs1ucQDnZEbTziL8NtM/AcshFZ2RL7pB9xrfB5Jj0=;
        b=K8oal4hz4FSZHvKt23AXFOxyZPTxrfBO60i7LgDE24zPKo2mSeaapREvjcBU9fu/rQ
         wp6Q+US8kshIYQFZ2yKdeduiorcg8YXQYVYoEoV5RMJlC65ikITzU1nLas6QtqXnbDXJ
         sZyT8yPFcVZ4XZig/zxtEhYvQPEuOSwbIdtkgfWqe5N3W9fOvgcAvRgZjOVkVHFQnHEp
         b7nsWJvFJhsAUFTSqEQKdcTr1cbL6JSGeEL+wuvxcm92LS7fOcG2uddA/PBkOu52S67P
         hvzRGhN2ym8gFcHLvbJvQLDziHOP/nxblSTytg8cCfB3zTxR3UAB7L/iR6oZrWJlCHnV
         OcNQ==
X-Gm-Message-State: ANoB5pnsPDz8QYUpCmM4yw6BvENDS+oQxq5vYWEHNHQGx+ToEfj6yH+2
        AxamJ4npxI1PebQ/nz7dh2E=
X-Google-Smtp-Source: AA0mqf7W2fgxhtALotAWVantX1jA210Z6dfBexYTytSusvrPGALz6gNVmHYRxiBjo6pQZ6TwoH6rmA==
X-Received: by 2002:a17:902:d38c:b0:188:4c74:e1f1 with SMTP id e12-20020a170902d38c00b001884c74e1f1mr8519036pld.98.1668973560184;
        Sun, 20 Nov 2022 11:46:00 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001869d71228bsm7954040plg.170.2022.11.20.11.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 11:45:59 -0800 (PST)
Date:   Mon, 21 Nov 2022 01:15:48 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, tj@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 2/4] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221120194548.g76fytbyxhi7xqcu@apollo>
References: <20221120051004.3605026-1-void@manifault.com>
 <20221120051004.3605026-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120051004.3605026-3-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 10:40:02AM IST, David Vernet wrote:
> Kfuncs currently support specifying the KF_TRUSTED_ARGS flag to signal
> to the verifier that it should enforce that a BPF program passes it a
> "safe", trusted pointer. Currently, "safe" means that the pointer is
> either PTR_TO_CTX, or is refcounted. There may be cases, however, where
> the kernel passes a BPF program a safe / trusted pointer to an object
> that the BPF program wishes to use as a kptr, but because the object
> does not yet have a ref_obj_id from the perspective of the verifier, the
> program would be unable to pass it to a KF_ACQUIRE | KF_TRUSTED_ARGS
> kfunc.
>
> The solution is to expand the set of pointers that are considered
> trusted according to KF_TRUSTED_ARGS, so that programs can invoke kfuncs
> with these pointers without getting rejected by the verifier.
>
> There is already a PTR_UNTRUSTED flag that is set in some scenarios,
> such as when a BPF program reads a kptr directly from a map
> without performing a bpf_kptr_xchg() call. These pointers of course can
> and should be rejected by the verifier. Unfortunately, however,
> PTR_UNTRUSTED does not cover all the cases for safety that need to
> be addressed to adequately protect kfuncs. Specifically, pointers
> obtained by a BPF program "walking" a struct are _not_ considered
> PTR_UNTRUSTED according to BPF. For example, say that we were to add a
> kfunc called bpf_task_acquire(), with KF_ACQUIRE | KF_TRUSTED_ARGS, to
> acquire a struct task_struct *. If we only used PTR_UNTRUSTED to signal
> that a task was unsafe to pass to a kfunc, the verifier would mistakenly
> allow the following unsafe BPF program to be loaded:
>
> SEC("tp_btf/task_newtask")
> int BPF_PROG(unsafe_acquire_task,
>              struct task_struct *task,
>              u64 clone_flags)
> {
>         struct task_struct *acquired, *nested;
>
>         nested = task->last_wakee;
>
>         /* Would not be rejected by the verifier. */
>         acquired = bpf_task_acquire(nested);
>         if (!acquired)
>                 return 0;
>
>         bpf_task_release(acquired);
>         return 0;
> }
>
> To address this, this patch defines a new type flag called PTR_TRUSTED
> which tracks whether a PTR_TO_BTF_ID pointer is safe to pass to a
> KF_TRUSTED_ARGS kfunc or a BPF helper function. PTR_TRUSTED pointers are
> passed directly from the kernel as a tracepoint or struct_ops callback
> argument. Any nested pointer that is obtained from walking a PTR_TRUSTED
> pointer is no longer PTR_TRUSTED. From the example above, the struct
> task_struct *task argument is PTR_TRUSTED, but the 'nested' pointer
> obtained from 'task->last_wakee' is not PTR_TRUSTED.
>
> A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
> and then another patch will add selftests to validate.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---

Sorry that I couldn't look at it earlier.

> [...]
> @@ -5884,8 +5889,18 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
>  static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
>  static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
>  static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
> -static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
> -static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
> +static const struct bpf_reg_types btf_ptr_types = {
> +	.types = {
> +		PTR_TO_BTF_ID,
> +		PTR_TO_BTF_ID | PTR_TRUSTED,
> +	},
> +};
> +static const struct bpf_reg_types percpu_btf_ptr_types = {
> +	.types = {
> +		PTR_TO_BTF_ID | MEM_PERCPU,
> +		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,

Where is PTR_TRUSTED set for MEM_PERCPU?

> +	}
> +};
>  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
>  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> @@ -5973,7 +5988,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	return -EACCES;
>
>  found:
> -	if (reg->type == PTR_TO_BTF_ID) {
> +	if (reg->type == PTR_TO_BTF_ID || reg->type & PTR_TRUSTED) {

Now, earlier MEM_ALLOC was supposed to not enter this branch. If your patch
allows MEM_ALLOC | PTR_TRUSTED (but I don't think it does), it will enter this
branch. I think it is better to just be explicit and say PTR_TO_BTF_ID ||
PTR_TO_BTF_ID | PTR_TRUSTED.

>  		/* For bpf_sk_release, it needs to match against first member
>  		 * 'struct sock_common', hence make an exception for it. This
>  		 * allows bpf_sk_release to work for multiple socket types.
> @@ -6055,6 +6070,8 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	 */
>  	case PTR_TO_BTF_ID:
>  	case PTR_TO_BTF_ID | MEM_ALLOC:
> +	case PTR_TO_BTF_ID | PTR_TRUSTED:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:

This and the one below:

> @@ -8366,6 +8402,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
>  		ptr = reg->map_ptr;
>  		break;
>  	case PTR_TO_BTF_ID | MEM_ALLOC:
> +	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:

I think this will never be set, based on my reading of the code.
Is the case with MEM_ALLOC | PTR_TRUSTED ever possible?
And if this is needed here, why not update btf_struct_access?
And KF_ARG_PTR_TO_ALLOC_BTF_ID is not updated either?
Let me know if I missed something.

>  		/* When referenced PTR_TO_BTF_ID is passed to release function,
>  		 * it's fixed offset must be 0.	In the other cases, fixed offset
>  		 * can be non-zero.
> @@ -7939,6 +7956,25 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>  	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>  }
>
> +static bool is_trusted_reg(const struct bpf_reg_state *reg)
> +{
> +	/* A referenced register is always trusted. */
> +	if (reg->ref_obj_id)
> +		return true;
> +
> +	/* If a register is not referenced, it is trusted if it has either the
> +	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
> +	 * other type modifiers may be safe, but we elect to take an opt-in
> +	 * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
> +	 * not.
> +	 *
> +	 * Eventually, we should make PTR_TRUSTED the single source of truth
> +	 * for whether a register is trusted.
> +	 */
> +	return type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS &&
> +	       !bpf_type_has_unsafe_modifiers(reg->type);
> +}
> +
>  static bool __kfunc_param_match_suffix(const struct btf *btf,
>  				       const struct btf_param *arg,
>  				       const char *suffix)
> @@ -8220,7 +8256,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
>  	const char *reg_ref_tname;
>  	u32 reg_ref_id;
>
> -	if (reg->type == PTR_TO_BTF_ID) {
> +	if (base_type(reg->type) == PTR_TO_BTF_ID) {
>  		reg_btf = reg->btf;
>  		reg_ref_id = reg->btf_id;
>  	} else {
>  		ptr = reg->btf;
>  		break;
>  	default:
> @@ -8596,8 +8633,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			if (!is_kfunc_trusted_args(meta))
>  				break;
> -			if (!reg->ref_obj_id) {
> -				verbose(env, "R%d must be referenced\n", regno);
> +
> +			if (!is_trusted_reg(reg)) {
> +				verbose(env, "R%d must be referenced or trusted\n", regno);
>  				return -EINVAL;
>  			}
>  			fallthrough;
> @@ -8702,9 +8740,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			break;
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			/* Only base_type is checked, further checks are done here */
> -			if (reg->type != PTR_TO_BTF_ID &&
> -			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> -				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> +			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
> +			     bpf_type_has_unsafe_modifiers(reg->type)) &&
> +			    !reg2btf_ids[base_type(reg->type)]) {
> +				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
> +				verbose(env, "expected %s or socket\n",
> +					reg_type_str(env, base_type(reg->type) |
> +							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
>  				return -EINVAL;
>  			}
>  			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> @@ -14713,6 +14755,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  			break;
>  		case PTR_TO_BTF_ID:
>  		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> +		case PTR_TO_BTF_ID | PTR_TRUSTED:
>  		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
>  		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
>  		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
> @@ -14720,6 +14763,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>  		 * for this case.
>  		 */
>  		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
> +		case PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_TRUSTED:

I feel this is confusing. What do we mean with PTR_UNTRUSTED | PTR_TRUSTED?

> +		case PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_ALLOC | PTR_TRUSTED:
