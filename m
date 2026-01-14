Return-Path: <bpf+bounces-78867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1FD1E4A1
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5441530A6AED
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE6D396B8F;
	Wed, 14 Jan 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUCuoL0i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C939524B
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388135; cv=none; b=AxBu0ofNEWih5VQReWeP4l5ycdLc4cvp2QtOO/65qL2wutE+4kP2rIdeV5qkp5uFH7WfkjI92kIKA1xD8ld6nDmCccv0oS9Mo2m3KlYmPKYs4dHGle87WcWJRmeY344XHcWeKaGavZ8aJJ/EkyR1izrA8cCT2M8VD5g6KwASeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388135; c=relaxed/simple;
	bh=8cD9JdBHWcr1tBAy6MBf1BzGayKmQA8VNsx+zkq9upo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thvpzY3nFYvoot77e6+irTRkAfGGjmq15P+Nne4wipPPnrVFnIxFEH8+QQvLJL4jHthumE4lmCUDAgVp4bCVhR54jGYBx2Yf8OqjKgKQrYfb5WtBZ+thwC1tyJBefqIQ+Y5iifGcNIGoYFcqdNpxMKbzvmKdO5yfoTLtSyZF0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUCuoL0i; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso13193551a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768387974; x=1768992774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kXQqP8vHkbnxWDEukkjz+eOd3+2/jYGQdFhLamLH/A=;
        b=EUCuoL0i704bzxJ/73uFjLSu41v/tAMLhB0SBhD3rD5/akZCmWioMT/QKHCMd9kYjd
         ozq/k/VKWf3cePKlHRPJcxH/uSIBeqhLGFxZD5Vf4nXKIuUDNcY2FFlpHcEoLpjXmWY9
         KTRw4lFl6OGLXjiTaN5zbM43cwuxnCNGWgwMAWzXIAy8vJu82xgF3M3HqtqBFYa/Stmi
         93k+ezJtRX9wlaIqUQbLYq+s9h4CwsxgyPoCthwYSbRFY+SLbPZZ1cm55atNglalJyiP
         y/ishiucNohLYl6emADRc1nQVgAct1E8WAccrn0/k2a4P8WbvdUskoRPlkLx0JflkkG9
         8Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387974; x=1768992774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kXQqP8vHkbnxWDEukkjz+eOd3+2/jYGQdFhLamLH/A=;
        b=IHkh2Caw0X8AyINRFKN20Rghlk8hkA42j52ZvLgi2Dn0pS8MKrjh+Upx+NQ7XJgJus
         JWXIPmufQsg++l2IeT9iIDGfNkgvdsrjLulJGK5yPQLcjT/4QoEV117c+i+bwI0LbsMM
         X1TlInP03X5wig9WV/fYSs6pNGRKM8GoJTDASk0wHOruvmYOEiwj3rrJWbWUm3JsWxab
         ZilatZZjMJwVLcFGPf4LY9h0IxPwTsTKJwChyf1Z0V6knFJWfqzSaaY8sR7WgOPE0zfQ
         1n2cMxY+U3oursTXeI1wX2Y8rOi5cgtVlnds/jeAlleXxnS4mBwUAnrt2nBIXwp5xUdb
         JREg==
X-Gm-Message-State: AOJu0YzhSUknViQjVx90Zwp1wttrUUM5Dxhh0ea62R3wf7W4h4sm1B0M
	cBpHUgUv/I0YiLwKc0ix+G+RV0lyZyjz/pmWCAlVHpsAaLpeP6Zn1xT8
X-Gm-Gg: AY/fxX4fJaAz3qR6cN1MeFiLSz3UwfIdtfUMLCcoejwG7ZDiX3jj2wvLPoTaH0X7zLm
	kJlpN8qT1FS8Qagmwkl7tG4lcgEZ3yLFpRXhjn0nyhhCsxzC8D0dk1c+0Q/bwBRGYOnwA0af7us
	y3Oz4ow2AYO19GkPK7iqhvfE5/yURZB04uoP9Q2MoI5WOqxBNdR+7rRIwTzPJKjfiLn8xc1uq4O
	F7xF6Ft62BK3cpd9jkBBDlGIJXHKDwcXzPNMCL62oQYK8KijCNJCCd4bXtEhb/RqtcYlEad2snR
	LLCJapK98IO4wjXDV/YUqm7CsP96nbZpA12IGU1i43jvz3uhpVj9cQK8BUBl4snTBbj+WWXeD1v
	D6uDRAhL2CDvDGHAXiTv5NzVXmuyZhXFo8QAWqniCiQWtAyd7dL1fOorUIZsNCB0Sn3xrgMHt3m
	rS0pr559eUKkC3L/xKMiZBeGppCGw5ubA=
X-Received: by 2002:a05:6402:1d50:b0:64b:7dd2:6b9d with SMTP id 4fb4d7f45d1cf-653ec11cac9mr1660982a12.8.1768387974025;
        Wed, 14 Jan 2026 02:52:54 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf661f3sm25006719a12.26.2026.01.14.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:52:53 -0800 (PST)
Date: Wed, 14 Jan 2026 11:00:40 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Add helper to detect indirect jump
 targets
Message-ID: <aWd3WBMVjpaFw39w@mail.gmail.com>
References: <20260114093914.2403982-1-xukuohai@huaweicloud.com>
 <20260114093914.2403982-3-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114093914.2403982-3-xukuohai@huaweicloud.com>

On 26/01/14 05:39PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Introduce helper bpf_insn_is_indirect_target to determine whether a BPF
> instruction is an indirect jump target. This helper will be used by
> follow-up patches to decide where to emit indirect landing pad instructions.
> 
> Add a new flag to struct bpf_insn_aux_data to mark instructions that are
> indirect jump targets. The BPF verifier sets this flag, and the helper
> checks it to determine whether an instruction is an indirect jump target.
> 
> Since bpf_insn_aux_data is only available before JIT stage, add a new
> field to struct bpf_prog_aux to store a pointer to the bpf_insn_aux_data
> array, making it accessible to the JIT.
> 
> For programs with multiple subprogs, each subprog uses its own private
> copy of insn_aux_data, since subprogs may insert additional instructions
> during JIT and need to update the array. For non-subprog, the verifier's
> insn_aux_data array is used directly to avoid unnecessary copying.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/bpf.h          |  2 ++
>  include/linux/bpf_verifier.h | 10 ++++---
>  kernel/bpf/core.c            | 51 +++++++++++++++++++++++++++++++++---
>  kernel/bpf/verifier.c        | 51 +++++++++++++++++++++++++++++++++++-
>  4 files changed, 105 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5936f8e2996f..e7d7e705327e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1533,6 +1533,7 @@ bool bpf_has_frame_pointer(unsigned long ip);
>  int bpf_jit_charge_modmem(u32 size);
>  void bpf_jit_uncharge_modmem(u32 size);
>  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
> +bool bpf_insn_is_indirect_target(const struct bpf_prog *prog, int idx);
>  #else
>  static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  					   struct bpf_trampoline *tr,
> @@ -1760,6 +1761,7 @@ struct bpf_prog_aux {
>  	struct bpf_stream stream[2];
>  	struct mutex st_ops_assoc_mutex;
>  	struct bpf_map __rcu *st_ops_assoc;
> +	struct bpf_insn_aux_data *insn_aux;
>  };
>  
>  #define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 130bcbd66f60..758086b384df 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -574,16 +574,18 @@ struct bpf_insn_aux_data {
>  
>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
> -	bool jmp_point;
> -	bool prune_point;
> +	u32 jmp_point:1;
> +	u32 prune_point:1;
>  	/* ensure we check state equivalence and save state checkpoint and
>  	 * this instruction, regardless of any heuristics
>  	 */
> -	bool force_checkpoint;
> +	u32 force_checkpoint:1;
>  	/* true if instruction is a call to a helper function that
>  	 * accepts callback function as a parameter.
>  	 */
> -	bool calls_callback;
> +	u32 calls_callback:1;
> +	/* true if the instruction is an indirect jump target */
> +	u32 indirect_target:1;
>  	/*
>  	 * CFG strongly connected component this instruction belongs to,
>  	 * zero if it is a singleton SCC.
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e0b8a8a5aaa9..bb870936e74b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1486,6 +1486,35 @@ static void adjust_insn_arrays(struct bpf_prog *prog, u32 off, u32 len)
>  #endif
>  }
>  
> +static int adjust_insn_aux(struct bpf_prog *prog, int off, int cnt)
> +{
> +	size_t size;
> +	struct bpf_insn_aux_data *new_aux;
> +
> +	if (cnt == 1)
> +		return 0;
> +
> +	/* prog->len already accounts for the cnt - 1 newly inserted instructions */
> +	size = array_size(prog->len, sizeof(struct bpf_insn_aux_data));
> +	new_aux = vrealloc(prog->aux->insn_aux, size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (!new_aux)
> +		return -ENOMEM;
> +
> +	/* follow the same behavior as adjust_insn_array(): leave [0, off] unchanged and shift
> +	 * [off + 1, end) to [off + cnt, end). Otherwise, the JIT would emit landing pads at
> +	 * wrong locations, as the actual indirect jump target remains at off.
> +	 */
> +	size = array_size(prog->len - off - cnt, sizeof(struct bpf_insn_aux_data));
> +	memmove(new_aux + off + cnt, new_aux + off + 1, size);
> +
> +	size = array_size(cnt - 1, sizeof(struct bpf_insn_aux_data));
> +	memset(new_aux + off + 1, 0, size);
> +
> +	prog->aux->insn_aux = new_aux;
> +
> +	return 0;
> +}
> +
>  struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>  {
>  	struct bpf_insn insn_buff[16], aux[2];
> @@ -1541,6 +1570,11 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>  		clone = tmp;
>  		insn_delta = rewritten - 1;
>  
> +		if (adjust_insn_aux(clone, i, rewritten)) {
> +			bpf_jit_prog_release_other(prog, clone);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +
>  		/* Instructions arrays must be updated using absolute xlated offsets */
>  		adjust_insn_arrays(clone, prog->aux->subprog_start + i, rewritten);
>  
> @@ -1553,6 +1587,11 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>  	clone->blinded = 1;
>  	return clone;
>  }
> +
> +bool bpf_insn_is_indirect_target(const struct bpf_prog *prog, int idx)
> +{
> +	return prog->aux->insn_aux && prog->aux->insn_aux[idx].indirect_target;

Is there a case when insn_aux is NULL?

> +}
>  #endif /* CONFIG_BPF_JIT */
>  
>  /* Base function for offset calculation. Needs to go into .text section,
> @@ -2540,24 +2579,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  	if (!bpf_prog_is_offloaded(fp->aux)) {
>  		*err = bpf_prog_alloc_jited_linfo(fp);
>  		if (*err)
> -			return fp;
> +			goto free_insn_aux;
>  
>  		fp = bpf_int_jit_compile(fp);
>  		bpf_prog_jit_attempt_done(fp);
>  		if (!fp->jited && jit_needed) {
>  			*err = -ENOTSUPP;
> -			return fp;
> +			goto free_insn_aux;
>  		}
>  	} else {
>  		*err = bpf_prog_offload_compile(fp);
>  		if (*err)
> -			return fp;
> +			goto free_insn_aux;
>  	}
>  
>  finalize:
>  	*err = bpf_prog_lock_ro(fp);
>  	if (*err)
> -		return fp;
> +		goto free_insn_aux;
>  
>  	/* The tail call compatibility check can only be done at
>  	 * this late stage as we need to determine, if we deal
> @@ -2566,6 +2605,10 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  	 */
>  	*err = bpf_check_tail_call(fp);
>  
> +free_insn_aux:
> +	vfree(fp->aux->insn_aux);
> +	fp->aux->insn_aux = NULL;
> +
>  	return fp;
>  }
>  EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 22605d9e0ffa..f2fe6baeceb9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3852,6 +3852,11 @@ static bool is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
>  	return env->insn_aux_data[insn_idx].jmp_point;
>  }
>  
> +static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
> +{
> +	env->insn_aux_data[idx].indirect_target = true;
> +}
> +
>  #define LR_FRAMENO_BITS	3
>  #define LR_SPI_BITS	6
>  #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
> @@ -20337,6 +20342,7 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  	}
>  
>  	for (i = 0; i < n; i++) {

^ n -> n-1

> +		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
>  					  env->insn_idx, env->cur_state->speculative);
>  		if (IS_ERR(other_branch))
> @@ -21243,6 +21249,37 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
>  	}

mark_indirect_target(n-1)

>  }
>  
> +static int clone_insn_aux_data(struct bpf_prog *prog, struct bpf_verifier_env *env, u32 off)
> +{
> +	u32 i;
> +	size_t size;
> +	bool has_indirect_target = false;
> +	struct bpf_insn_aux_data *insn_aux;
> +
> +	for (i = 0; i < prog->len; i++) {
> +		if (env->insn_aux_data[off + i].indirect_target) {
> +			has_indirect_target = true;
> +			break;
> +		}
> +	}
> +
> +	/* insn_aux is copied into bpf_prog so the JIT can check whether an instruction is an
> +	 * indirect jump target. If no indirect jump targets exist, copying is unnecessary.
> +	 */
> +	if (!has_indirect_target)
> +		return 0;
> +
> +	size = array_size(sizeof(struct bpf_insn_aux_data), prog->len);
> +	insn_aux = vzalloc(size);
> +	if (!insn_aux)
> +		return -ENOMEM;
> +
> +	memcpy(insn_aux, env->insn_aux_data + off, size);
> +	prog->aux->insn_aux = insn_aux;
> +
> +	return 0;
> +}
> +
>  /* single env->prog->insni[off] instruction was replaced with the range
>   * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
>   * [0, off) and [off, end) to new locations, so the patched range stays zero
> @@ -22239,6 +22276,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		if (!i)
>  			func[i]->aux->exception_boundary = env->seen_exception;
>  
> +		err = clone_insn_aux_data(func[i], env, subprog_start);
> +		if (err < 0)
> +			goto out_free;
> +
>  		/*
>  		 * To properly pass the absolute subprog start to jit
>  		 * all instruction adjustments should be accumulated
> @@ -22306,6 +22347,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	for (i = 0; i < env->subprog_cnt; i++) {
>  		func[i]->aux->used_maps = NULL;
>  		func[i]->aux->used_map_cnt = 0;
> +		vfree(func[i]->aux->insn_aux);
> +		func[i]->aux->insn_aux = NULL;
>  	}
>  
>  	/* finally lock prog and jit images for all functions and
> @@ -22367,6 +22410,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	for (i = 0; i < env->subprog_cnt; i++) {
>  		if (!func[i])
>  			continue;
> +		vfree(func[i]->aux->insn_aux);
>  		func[i]->aux->poke_tab = NULL;
>  		bpf_jit_free(func[i]);
>  	}
> @@ -25350,6 +25394,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  	env->verification_time = ktime_get_ns() - start_time;
>  	print_verification_stats(env);
>  	env->prog->aux->verified_insns = env->insn_processed;
> +	env->prog->aux->insn_aux = env->insn_aux_data;
>  
>  	/* preserve original error even if log finalization is successful */
>  	err = bpf_vlog_finalize(&env->log, &log_true_size);
> @@ -25428,7 +25473,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  	if (!is_priv)
>  		mutex_unlock(&bpf_verifier_lock);
>  	clear_insn_aux_data(env, 0, env->prog->len);
> -	vfree(env->insn_aux_data);
> +	/* on success, insn_aux_data will be freed by bpf_prog_select_runtime */
> +	if (ret) {
> +		vfree(env->insn_aux_data);
> +		env->prog->aux->insn_aux = NULL;
> +	}
>  err_free_env:
>  	bpf_stack_liveness_free(env);
>  	kvfree(env->cfg.insn_postorder);
> -- 
> 2.47.3
> 

LGTM, just in case, could you please tell how you have tested
this patchset exactly?

