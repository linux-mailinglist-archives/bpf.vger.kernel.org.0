Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB46E14F3
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDMTOV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDMTOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 15:14:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27B8689
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 12:14:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504ecfdf6b6so2028802a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681413252; x=1684005252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2G7s5ShKmUa4nDETLFsCF1FlxKXLmKLYCG+eimZnyY=;
        b=he4aQX1Aykc4AmhislF63iFgq/atGMEatanBeYusTxKCGQXorb3CpryAiU0N3wwPwx
         3InBSehtXWUReycda3+v7L1bPLTVFKyVy5tXptH4Edfy/2JGp35cmLXdVKGFXWcQnmLm
         kUDSYYjJhH4u3v6AApFjqwch98UAV2rkpv5ivtqlI2k+813MoE3pe3x7L0ICJw2y78zo
         B83kSXBqv+xVKPCHD+N2Ev3QBzzLYVAczx4t1iGhl9u2wMmrRruGbSXMVA7ZxNmlc3lh
         ax/4/zxfWJq1UjCZeDL0GqOdOp22ECjA0aWAaQj2B7KIQuody4AaV8PWBrYMQXwZ42Yd
         ZWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413252; x=1684005252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2G7s5ShKmUa4nDETLFsCF1FlxKXLmKLYCG+eimZnyY=;
        b=aIQbJs0JGmxwkd16EDjG/Ix3EGy+yXNpIBl1OLxf11pfE9QHTlhytxA8OiB+nqQr2F
         53r8N/2+xM+YmhhKo8GH6AS4c4Rh/pYbPGkWnar2ScyT1mpBRtAZTn+CkDlLSc0tBprj
         AEIz5VPgjw1ziEoAa1wR1GD2ZJ4H/Bsk6Rk5oqMh/Aw1QGE3kXuJOiAmaGjceHq5Rr45
         LXHXGTbrg1dYtMPu9K7t/g4VqSV13EslyUz0NhQwsqTTs0+j+q5XxzxcNY2dMlXiRVAM
         Fmw4vLoYNcCU4dj3MYTCvc63lSXo0QYasNycNI+mozvjlpU1+9ebT5rOLBjd7SLBXpBw
         kkUw==
X-Gm-Message-State: AAQBX9c7jEmOK2/Mg4jE1YDaBEkrpo3W7qHhJt+ylTlEO5IgKpd0B0bT
        dC7ZKWXOhWdzq7pqXHqbsFLJ0YrGfn8QRA==
X-Google-Smtp-Source: AKy350a3dfGrkTCRGUXOBHNQGzLA+S/rSttrPqN1KG+aAuiYaDBiZKM3RB9cWuFLWztlEVFRscEutw==
X-Received: by 2002:aa7:dccd:0:b0:4fb:eda4:c093 with SMTP id w13-20020aa7dccd000000b004fbeda4c093mr3561512edu.13.1681413251654;
        Thu, 13 Apr 2023 12:14:11 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id l16-20020aa7cad0000000b005021d210899sm1174954edt.23.2023.04.13.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:14:11 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 13 Apr 2023 21:14:08 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v7] bpf: Support 64-bit pointers to kfuncs
Message-ID: <ZDhUgMyQHiNxDB8l@krava>
References: <20230412230632.885985-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412230632.885985-1-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 01:06:32AM +0200, Ilya Leoshkevich wrote:
> test_ksyms_module fails to emit a kfunc call targeting a module on
> s390x, because the verifier stores the difference between kfunc
> address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
> are roughly (1 << 42) bytes away from the kernel on s390x.
> 
> Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> and storing the absolute address in bpf_kfunc_desc.
> 
> Introduce bpf_jit_supports_far_kfunc_call() in order to limit this new
> behavior to the s390x JIT. Otherwise other JITs need to be modified,
> which is not desired.
> 
> Introduce bpf_get_kfunc_addr() instead of exposing both
> find_kfunc_desc() and struct bpf_kfunc_desc.
> 
> In addition to sorting kfuncs by imm, also sort them by offset, in
> order to handle conflicting imms from different modules. Do this on
> all architectures in order to simplify code.
> 
> Factor out resolving specialized kfuncs (XPD and dynptr) from
> fixup_kfunc_call(). This was required in the first place, because
> fixup_kfunc_call() uses find_kfunc_desc(), which returns a const
> pointer, so it's not possible to modify kfunc addr without stripping
> const, which is not nice. It also removes repetition of code like:
> 
> 	if (bpf_jit_supports_far_kfunc_call())
> 		desc->addr = func;
> 	else
> 		insn->imm = BPF_CALL_IMM(func);
> 
> and separates kfunc_desc_tab fixups from kfunc_call fixups.
> 
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

I'll rebase the test kfuncs move on top of this

thanks,
jirka


> ---
> 
> v6: https://lore.kernel.org/bpf/20230405213453.49756-1-iii@linux.ibm.com/
> v6 -> v7: - Fix build with !CONFIG_BPF_SYSCALL by providing a dummy
>             implementation for this case.
>             Reported-by: kernel test robot <lkp@intel.com>
>             Link: https://lore.kernel.org/oe-kbuild-all/202304060822.L9VsdUzS-lkp@intel.com/
>           - Specialize kfuncs when adding them (Jiri).
>           - Remove an unnecessary newline (Jiri).
>           - Add bpf_jit_supports_far_kfunc_call() check to
>             fixup_kfunc_call() (Jiri). Strictly speaking it's not
>             neccessary (we get the right value in all cases), but it
>             makes the logic more clear.
> 
> v5: https://lore.kernel.org/bpf/20230405141407.172357-1-iii@linux.ibm.com/
> v5 -> v6: Fix build with !CONFIG_BPF_SYSCALL by moving bpf_get_kfunc_addr()
>           declaration outside of the respective ifdef.
>           Reported-by: kernel test robot <lkp@intel.com>
>           Link: https://lore.kernel.org/oe-kbuild-all/202304060240.OeUgnjzZ-lkp@intel.com/
>           Specialize kfunc when adding (Jiri).
>           Remove an unnecessary newline (Jiri).
>           Add bpf_jit_supports_far_kfunc_call() check to
>           fixup_kfunc_call() (Jiri). Strictly speaking it's not
>           neccessary, but it makes the logic less confusing.
> 
> v4: https://lore.kernel.org/bpf/20230403172833.1552354-1-iii@linux.ibm.com/
> v4 -> v5: Fix issues identified by Andrii:
>           - Improve bpf_get_kfunc_addr() argument naming.
>           - Do overflow check only in !bpf_jit_supports_far_kfunc_call() case.
>           - Fix kfunc_desc_cmp_by_imm_off() bug when passing huge values.
>           - Update fixup_kfunc_call() comment to reflect the new logic.
> 
> v3: https://lore.kernel.org/bpf/20230222223714.80671-1-iii@linux.ibm.com/
> v3 -> v4: Use Jiri's proposal and make it work on s390x.
> 
>  arch/s390/net/bpf_jit_comp.c |   5 ++
>  include/linux/bpf.h          |  10 +++
>  include/linux/filter.h       |   1 +
>  kernel/bpf/core.c            |  11 ++++
>  kernel/bpf/verifier.c        | 123 +++++++++++++++++++++++------------
>  5 files changed, 110 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index d0846ba818ee..7102e4b674a0 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2001,6 +2001,11 @@ bool bpf_jit_supports_kfunc_call(void)
>  	return true;
>  }
>  
> +bool bpf_jit_supports_far_kfunc_call(void)
> +{
> +	return true;
> +}
> +
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  		       void *old_addr, void *new_addr)
>  {
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2c6095bd7d69..88845aadc47d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2295,6 +2295,9 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>  const struct btf_func_model *
>  bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>  			 const struct bpf_insn *insn);
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> +		       u16 btf_fd_idx, u8 **func_addr);
> +
>  struct bpf_core_ctx {
>  	struct bpf_verifier_log *log;
>  	const struct btf *btf;
> @@ -2545,6 +2548,13 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>  	return NULL;
>  }
>  
> +static inline int
> +bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> +		   u16 btf_fd_idx, u8 **func_addr)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static inline bool unprivileged_ebpf_enabled(void)
>  {
>  	return false;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 5364b0c52c1d..bbce89937fde 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -920,6 +920,7 @@ void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
>  bool bpf_jit_supports_subprog_tailcalls(void);
>  bool bpf_jit_supports_kfunc_call(void);
> +bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_helper_changes_pkt_data(void *func);
>  
>  static inline bool bpf_dump_raw_ok(const struct cred *cred)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b297e9f60ca1..7a75fdfd707e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1187,6 +1187,7 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>  	s16 off = insn->off;
>  	s32 imm = insn->imm;
>  	u8 *addr;
> +	int err;
>  
>  	*func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
>  	if (!*func_addr_fixed) {
> @@ -1201,6 +1202,11 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
>  			addr = (u8 *)prog->aux->func[off]->bpf_func;
>  		else
>  			return -EINVAL;
> +	} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> +		   bpf_jit_supports_far_kfunc_call()) {
> +		err = bpf_get_kfunc_addr(prog, insn->imm, insn->off, &addr);
> +		if (err)
> +			return err;
>  	} else {
>  		/* Address of a BPF helper call. Since part of the core
>  		 * kernel, it's always at a fixed location. __bpf_call_base
> @@ -2732,6 +2738,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
>  	return false;
>  }
>  
> +bool __weak bpf_jit_supports_far_kfunc_call(void)
> +{
> +	return false;
> +}
> +
>  /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
>   * skb_copy_bits(), so provide a weak definition of it for NET-less config.
>   */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d6db6de3e9ea..1514cf878a1d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -195,6 +195,8 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
>  			      struct bpf_reg_state *reg);
> +static void specialize_kfunc(struct bpf_verifier_env *env,
> +			     u32 func_id, u16 offset, unsigned long *addr);
>  
>  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>  {
> @@ -2374,6 +2376,7 @@ struct bpf_kfunc_desc {
>  	u32 func_id;
>  	s32 imm;
>  	u16 offset;
> +	unsigned long addr;
>  };
>  
>  struct bpf_kfunc_btf {
> @@ -2383,6 +2386,11 @@ struct bpf_kfunc_btf {
>  };
>  
>  struct bpf_kfunc_desc_tab {
> +	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
> +	 * verification. JITs do lookups by bpf_insn, where func_id may not be
> +	 * available, therefore at the end of verification do_misc_fixups()
> +	 * sorts this by imm and offset.
> +	 */
>  	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
>  	u32 nr_descs;
>  };
> @@ -2423,6 +2431,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
>  		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>  }
>  
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> +		       u16 btf_fd_idx, u8 **func_addr)
> +{
> +	const struct bpf_kfunc_desc *desc;
> +
> +	desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
> +	if (!desc)
> +		return -EFAULT;
> +
> +	*func_addr = (u8 *)desc->addr;
> +	return 0;
> +}
> +
>  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  					 s16 offset)
>  {
> @@ -2602,13 +2623,18 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  			func_name);
>  		return -EINVAL;
>  	}
> +	specialize_kfunc(env, func_id, offset, &addr);
>  
> -	call_imm = BPF_CALL_IMM(addr);
> -	/* Check whether or not the relative offset overflows desc->imm */
> -	if ((unsigned long)(s32)call_imm != call_imm) {
> -		verbose(env, "address of kernel function %s is out of range\n",
> -			func_name);
> -		return -EINVAL;
> +	if (bpf_jit_supports_far_kfunc_call()) {
> +		call_imm = func_id;
> +	} else {
> +		call_imm = BPF_CALL_IMM(addr);
> +		/* Check whether the relative offset overflows desc->imm */
> +		if ((unsigned long)(s32)call_imm != call_imm) {
> +			verbose(env, "address of kernel function %s is out of range\n",
> +				func_name);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	if (bpf_dev_bound_kfunc_id(func_id)) {
> @@ -2621,6 +2647,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  	desc->func_id = func_id;
>  	desc->imm = call_imm;
>  	desc->offset = offset;
> +	desc->addr = addr;
>  	err = btf_distill_func_proto(&env->log, desc_btf,
>  				     func_proto, func_name,
>  				     &desc->func_model);
> @@ -2630,19 +2657,19 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  	return err;
>  }
>  
> -static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
> +static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
>  {
>  	const struct bpf_kfunc_desc *d0 = a;
>  	const struct bpf_kfunc_desc *d1 = b;
>  
> -	if (d0->imm > d1->imm)
> -		return 1;
> -	else if (d0->imm < d1->imm)
> -		return -1;
> +	if (d0->imm != d1->imm)
> +		return d0->imm < d1->imm ? -1 : 1;
> +	if (d0->offset != d1->offset)
> +		return d0->offset < d1->offset ? -1 : 1;
>  	return 0;
>  }
>  
> -static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
> +static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
>  {
>  	struct bpf_kfunc_desc_tab *tab;
>  
> @@ -2651,7 +2678,7 @@ static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
>  		return;
>  
>  	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> -	     kfunc_desc_cmp_by_imm, NULL);
> +	     kfunc_desc_cmp_by_imm_off, NULL);
>  }
>  
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> @@ -2665,13 +2692,14 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>  {
>  	const struct bpf_kfunc_desc desc = {
>  		.imm = insn->imm,
> +		.offset = insn->off,
>  	};
>  	const struct bpf_kfunc_desc *res;
>  	struct bpf_kfunc_desc_tab *tab;
>  
>  	tab = prog->aux->kfunc_tab;
>  	res = bsearch(&desc, tab->descs, tab->nr_descs,
> -		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
> +		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
>  
>  	return res ? &res->func_model : NULL;
>  }
> @@ -17293,11 +17321,45 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  	return err;
>  }
>  
> +/* replace a generic kfunc with a specialized version if necessary */
> +static void specialize_kfunc(struct bpf_verifier_env *env,
> +			     u32 func_id, u16 offset, unsigned long *addr)
> +{
> +	struct bpf_prog *prog = env->prog;
> +	bool seen_direct_write;
> +	void *xdp_kfunc;
> +	bool is_rdonly;
> +
> +	if (bpf_dev_bound_kfunc_id(func_id)) {
> +		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
> +		if (xdp_kfunc) {
> +			*addr = (unsigned long)xdp_kfunc;
> +			return;
> +		}
> +		/* fallback to default kfunc when not supported by netdev */
> +	}
> +
> +	if (offset)
> +		return;
> +
> +	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> +		seen_direct_write = env->seen_direct_write;
> +		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
> +
> +		if (is_rdonly)
> +			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
> +
> +		/* restore env->seen_direct_write to its original value, since
> +		 * may_access_direct_pkt_data mutates it
> +		 */
> +		env->seen_direct_write = seen_direct_write;
> +	}
> +}
> +
>  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
>  	const struct bpf_kfunc_desc *desc;
> -	void *xdp_kfunc;
>  
>  	if (!insn->imm) {
>  		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
> @@ -17306,18 +17368,9 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  
>  	*cnt = 0;
>  
> -	if (bpf_dev_bound_kfunc_id(insn->imm)) {
> -		xdp_kfunc = bpf_dev_bound_resolve_kfunc(env->prog, insn->imm);
> -		if (xdp_kfunc) {
> -			insn->imm = BPF_CALL_IMM(xdp_kfunc);
> -			return 0;
> -		}
> -
> -		/* fallback to default kfunc when not supported by netdev */
> -	}
> -
> -	/* insn->imm has the btf func_id. Replace it with
> -	 * an address (relative to __bpf_call_base).
> +	/* insn->imm has the btf func_id. Replace it with an offset relative to
> +	 * __bpf_call_base, unless the JIT needs to call functions that are
> +	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
>  	 */
>  	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
>  	if (!desc) {
> @@ -17326,7 +17379,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		return -EFAULT;
>  	}
>  
> -	insn->imm = desc->imm;
> +	if (!bpf_jit_supports_far_kfunc_call())
> +		insn->imm = BPF_CALL_IMM(desc->addr);
>  	if (insn->off)
>  		return 0;
>  	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
> @@ -17351,17 +17405,6 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt = 1;
> -	} else if (desc->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> -		bool seen_direct_write = env->seen_direct_write;
> -		bool is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
> -
> -		if (is_rdonly)
> -			insn->imm = BPF_CALL_IMM(bpf_dynptr_from_skb_rdonly);
> -
> -		/* restore env->seen_direct_write to its original value, since
> -		 * may_access_direct_pkt_data mutates it
> -		 */
> -		env->seen_direct_write = seen_direct_write;
>  	}
>  	return 0;
>  }
> @@ -17891,7 +17934,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		}
>  	}
>  
> -	sort_kfunc_descs_by_imm(env->prog);
> +	sort_kfunc_descs_by_imm_off(env->prog);
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
