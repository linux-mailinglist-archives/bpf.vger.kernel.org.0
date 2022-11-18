Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407662FE12
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiKRTkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiKRTkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 14:40:19 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4CC12AF8
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:40:16 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id w4so3846162qts.0
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CnJ/8xPn/dg2XfE/Sv6+SdxGJ40lf11ZRoJnn6ol78=;
        b=GTs6tCwMB712rseYMGOOx0jOV6d3NZ0iKqqI8pIz1EGwmIEBHRD55Pv4erINei/+xN
         MvrwVB7WZWMciXtvSqa8hkXppRERa/w+4nhP9NDCVcOnlH+EJioisLSpqL7mYH6zMf2W
         Zg2wsDbSumK4V/jB992mqQZFNjkpp5GGhq3FAQbtMIAOkQKZR07e72DCvs+NNhdj9AIT
         m61qkj4uY0tEedn7A+/YpPPoWyKcjl7Zb3EzUDshpaiboJWw4JJDEBKIn4kH3uA5O1/O
         5tf6j7gTW5CpBQbUrd9X9sSvDuv9WU7ZQHbblxqzXGBs3pDNv9db9meJurMZQHYdpcsk
         tYwg==
X-Gm-Message-State: ANoB5pmnY+paCkyAKEwkwhbqEYTlFfc0xCouriHfSSAehwpGqmHnBOm9
        RB4l9y0q616v6sGu5vjvbRw=
X-Google-Smtp-Source: AA0mqf7aMhpyOA61sVbGHkcuQKJrf95yJ7Dg9sp/U63A+Nm0GYL27bmXl+v0Lm2PFJabTPvZowpf5g==
X-Received: by 2002:ac8:1491:0:b0:3a5:e90a:125 with SMTP id l17-20020ac81491000000b003a5e90a0125mr8133725qtj.476.1668800415064;
        Fri, 18 Nov 2022 11:40:15 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:cf15])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05620a192600b006cbe3be300esm3013839qkb.12.2022.11.18.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:40:14 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:40:12 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
Message-ID: <Y3ffnATsq8kg7Js1@maniforge.lan>
References: <20221118015614.2013203-1-memxor@gmail.com>
 <20221118015614.2013203-12-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118015614.2013203-12-memxor@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 07:26:01AM +0530, Kumar Kartikeya Dwivedi wrote:
> As we continue to add more features, argument types, kfunc flags, and
> different extensions to kfuncs, the code to verify the correctness of
> the kfunc prototype wrt the passed in registers has become ad-hoc and
> ugly to read. To make life easier, and make a very clear split between
> different stages of argument processing, move all the code into
> verifier.c and refactor into easier to read helpers and functions.
> 
> This also makes sharing code within the verifier easier with kfunc
> argument processing. This will be more and more useful in later patches
> as we are now moving to implement very core BPF helpers as kfuncs, to
> keep them experimental before baking into UAPI.
> 
> Remove all kfunc related bits now from btf_check_func_arg_match, as
> users have been converted away to refactored kfunc argument handling.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks for working on this. I'm relieved to see this work being done. I
have a few comments but overall this is great. I'll take a closer look
later.

> ---
>  include/linux/bpf.h                           |  11 -
>  include/linux/bpf_verifier.h                  |   2 -
>  include/linux/btf.h                           |  31 +-
>  kernel/bpf/btf.c                              | 380 +-----------
>  kernel/bpf/verifier.c                         | 545 +++++++++++++++++-
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
>  tools/testing/selftests/bpf/verifier/calls.c  |   2 +-
>  .../selftests/bpf/verifier/ref_tracking.c     |   4 +-
>  8 files changed, 573 insertions(+), 404 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 323985a39ece..0a74df731eb8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2109,22 +2109,11 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>  			   const char *func_name,
>  			   struct btf_func_model *m);
>  
> -struct bpf_kfunc_arg_meta {
> -	u64 r0_size;
> -	bool r0_rdonly;
> -	int ref_obj_id;
> -	u32 flags;
> -};
> -
>  struct bpf_reg_state;
>  int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
>  				struct bpf_reg_state *regs);
>  int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
>  			   struct bpf_reg_state *regs);
> -int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
> -			      const struct btf *btf, u32 func_id,
> -			      struct bpf_reg_state *regs,
> -			      struct bpf_kfunc_arg_meta *meta);
>  int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
>  			  struct bpf_reg_state *reg);
>  int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *prog,
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1db2b4dc7009..fb146b0ce006 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -603,8 +603,6 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  			   const struct bpf_reg_state *reg, int regno,
>  			   enum bpf_arg_type arg_type);
> -int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -			     u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		   u32 regno, u32 mem_size);
>  bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 42d8f3730a8d..d5b26380a60f 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -338,6 +338,16 @@ static inline bool btf_type_is_struct(const struct btf_type *t)
>  	return kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION;
>  }
>  
> +static inline bool __btf_type_is_struct(const struct btf_type *t)
> +{
> +	return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
> +}
> +
> +static inline bool btf_type_is_array(const struct btf_type *t)
> +{
> +	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
> +}
> +
>  static inline u16 btf_type_vlen(const struct btf_type *t)
>  {
>  	return BTF_INFO_VLEN(t->info);
> @@ -439,9 +449,10 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
>  	return bsearch(&id, set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func);
>  }
>  
> -#ifdef CONFIG_BPF_SYSCALL
>  struct bpf_prog;
> +struct bpf_verifier_log;
>  
> +#ifdef CONFIG_BPF_SYSCALL
>  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
>  const char *btf_name_by_offset(const struct btf *btf, u32 offset);
>  struct btf *btf_parse_vmlinux(void);
> @@ -455,6 +466,12 @@ s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
>  int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
>  				struct module *owner);
>  struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id);
> +const struct btf_member *
> +btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
> +		      const struct btf_type *t, enum bpf_prog_type prog_type,
> +		      int arg);
> +bool btf_types_are_same(const struct btf *btf1, u32 id1,
> +			const struct btf *btf2, u32 id2);
>  #else
>  static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
>  						    u32 type_id)
> @@ -490,6 +507,18 @@ static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf
>  {
>  	return NULL;
>  }
> +static inline const struct btf_member *
> +btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
> +		      const struct btf_type *t, enum bpf_prog_type prog_type,
> +		      int arg)
> +{
> +	return NULL;
> +}
> +static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
> +				      const struct btf *btf2, u32 id2)
> +{
> +	return false;
> +}
>  #endif
>  
>  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 91aa9c96621f..4dcda4ae48c1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -478,16 +478,6 @@ static bool btf_type_nosize_or_null(const struct btf_type *t)
>  	return !t || btf_type_nosize(t);
>  }
>  
> -static bool __btf_type_is_struct(const struct btf_type *t)
> -{
> -	return BTF_INFO_KIND(t->info) == BTF_KIND_STRUCT;
> -}
> -
> -static bool btf_type_is_array(const struct btf_type *t)
> -{
> -	return BTF_INFO_KIND(t->info) == BTF_KIND_ARRAY;
> -}
> -
>  static bool btf_type_is_datasec(const struct btf_type *t)
>  {
>  	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
> @@ -5536,7 +5526,7 @@ static u8 bpf_ctx_convert_map[] = {
>  #undef BPF_MAP_TYPE
>  #undef BPF_LINK_TYPE
>  
> -static const struct btf_member *
> +const struct btf_member *
>  btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  		      const struct btf_type *t, enum bpf_prog_type prog_type,
>  		      int arg)
> @@ -6322,8 +6312,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
>   * end up with two different module BTFs, but IDs point to the common type in
>   * vmlinux BTF.
>   */
> -static bool btf_types_are_same(const struct btf *btf1, u32 id1,
> -			       const struct btf *btf2, u32 id2)
> +bool btf_types_are_same(const struct btf *btf1, u32 id1,
> +			const struct btf *btf2, u32 id2)
>  {
>  	if (id1 != id2)
>  		return false;
> @@ -6605,122 +6595,19 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
>  	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
>  }
>  
> -static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> -#ifdef CONFIG_NET
> -	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> -	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> -	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
> -#endif
> -};
> -
> -/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> -static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
> -					const struct btf *btf,
> -					const struct btf_type *t, int rec)
> -{
> -	const struct btf_type *member_type;
> -	const struct btf_member *member;
> -	u32 i;
> -
> -	if (!btf_type_is_struct(t))
> -		return false;
> -
> -	for_each_member(i, t, member) {
> -		const struct btf_array *array;
> -
> -		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
> -		if (btf_type_is_struct(member_type)) {
> -			if (rec >= 3) {
> -				bpf_log(log, "max struct nesting depth exceeded\n");
> -				return false;
> -			}
> -			if (!__btf_type_is_scalar_struct(log, btf, member_type, rec + 1))
> -				return false;
> -			continue;
> -		}
> -		if (btf_type_is_array(member_type)) {
> -			array = btf_type_array(member_type);
> -			if (!array->nelems)
> -				return false;
> -			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
> -			if (!btf_type_is_scalar(member_type))
> -				return false;
> -			continue;
> -		}
> -		if (!btf_type_is_scalar(member_type))
> -			return false;
> -	}
> -	return true;
> -}
> -
> -static bool is_kfunc_arg_mem_size(const struct btf *btf,
> -				  const struct btf_param *arg,
> -				  const struct bpf_reg_state *reg)
> -{
> -	int len, sfx_len = sizeof("__sz") - 1;
> -	const struct btf_type *t;
> -	const char *param_name;
> -
> -	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> -	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
> -		return false;
> -
> -	/* In the future, this can be ported to use BTF tagging */
> -	param_name = btf_name_by_offset(btf, arg->name_off);
> -	if (str_is_empty(param_name))
> -		return false;
> -	len = strlen(param_name);
> -	if (len < sfx_len)
> -		return false;
> -	param_name += len - sfx_len;
> -	if (strncmp(param_name, "__sz", sfx_len))
> -		return false;
> -
> -	return true;
> -}
> -
> -static bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
> -				      const struct btf_param *arg,
> -				      const struct bpf_reg_state *reg,
> -				      const char *name)
> -{
> -	int len, target_len = strlen(name);
> -	const struct btf_type *t;
> -	const char *param_name;
> -
> -	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> -	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
> -		return false;
> -
> -	param_name = btf_name_by_offset(btf, arg->name_off);
> -	if (str_is_empty(param_name))
> -		return false;
> -	len = strlen(param_name);
> -	if (len != target_len)
> -		return false;
> -	if (strcmp(param_name, name))
> -		return false;
> -
> -	return true;
> -}
> -
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				    const struct btf *btf, u32 func_id,
>  				    struct bpf_reg_state *regs,
>  				    bool ptr_to_mem_ok,
> -				    struct bpf_kfunc_arg_meta *kfunc_meta,
>  				    bool processing_call)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> -	bool rel = false, kptr_get = false, trusted_args = false;
> -	bool sleepable = false;
>  	struct bpf_verifier_log *log = &env->log;
> -	u32 i, nargs, ref_id, ref_obj_id = 0;
> -	bool is_kfunc = btf_is_kernel(btf);
>  	const char *func_name, *ref_tname;
>  	const struct btf_type *t, *ref_t;
>  	const struct btf_param *args;
> -	int ref_regno = 0, ret;
> +	u32 i, nargs, ref_id;
> +	int ret;
>  
>  	t = btf_type_by_id(btf, func_id);
>  	if (!t || !btf_type_is_func(t)) {
> @@ -6746,14 +6633,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> -	if (is_kfunc && kfunc_meta) {
> -		/* Only kfunc can be release func */
> -		rel = kfunc_meta->flags & KF_RELEASE;
> -		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
> -		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
> -		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
> -	}
> -
>  	/* check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
> @@ -6761,42 +6640,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  		enum bpf_arg_type arg_type = ARG_DONTCARE;
>  		u32 regno = i + 1;
>  		struct bpf_reg_state *reg = &regs[regno];
> -		bool obj_ptr = false;
>  
>  		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>  		if (btf_type_is_scalar(t)) {
> -			if (is_kfunc && kfunc_meta) {
> -				bool is_buf_size = false;
> -
> -				/* check for any const scalar parameter of name "rdonly_buf_size"
> -				 * or "rdwr_buf_size"
> -				 */
> -				if (btf_is_kfunc_arg_mem_size(btf, &args[i], reg,
> -							      "rdonly_buf_size")) {
> -					kfunc_meta->r0_rdonly = true;
> -					is_buf_size = true;
> -				} else if (btf_is_kfunc_arg_mem_size(btf, &args[i], reg,
> -								     "rdwr_buf_size"))
> -					is_buf_size = true;
> -
> -				if (is_buf_size) {
> -					if (kfunc_meta->r0_size) {
> -						bpf_log(log, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
> -						return -EINVAL;
> -					}
> -
> -					if (!tnum_is_const(reg->var_off)) {
> -						bpf_log(log, "R%d is not a const\n", regno);
> -						return -EINVAL;
> -					}
> -
> -					kfunc_meta->r0_size = reg->var_off.value;
> -					ret = mark_chain_precision(env, regno);
> -					if (ret)
> -						return ret;
> -				}
> -			}
> -
>  			if (reg->type == SCALAR_VALUE)
>  				continue;
>  			bpf_log(log, "R%d is not a scalar\n", regno);
> @@ -6809,88 +6655,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  			return -EINVAL;
>  		}
>  
> -		/* These register types have special constraints wrt ref_obj_id
> -		 * and offset checks. The rest of trusted args don't.
> -		 */
> -		obj_ptr = reg->type == PTR_TO_CTX || reg->type == PTR_TO_BTF_ID ||
> -			  reg2btf_ids[base_type(reg->type)];
> -
> -		/* Check if argument must be a referenced pointer, args + i has
> -		 * been verified to be a pointer (after skipping modifiers).
> -		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
> -		 */
> -		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
> -			bpf_log(log, "R%d must be referenced\n", regno);
> -			return -EINVAL;
> -		}
> -
>  		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
>  		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>  
> -		/* Trusted args have the same offset checks as release arguments */
> -		if ((trusted_args && obj_ptr) || (rel && reg->ref_obj_id))
> -			arg_type |= OBJ_RELEASE;
>  		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
>  		if (ret < 0)
>  			return ret;
>  
> -		if (is_kfunc && reg->ref_obj_id) {
> -			/* Ensure only one argument is referenced PTR_TO_BTF_ID */
> -			if (ref_obj_id) {
> -				bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> -					regno, reg->ref_obj_id, ref_obj_id);
> -				return -EFAULT;
> -			}
> -			ref_regno = regno;
> -			ref_obj_id = reg->ref_obj_id;
> -		}
> -
> -		/* kptr_get is only true for kfunc */
> -		if (i == 0 && kptr_get) {
> -			struct btf_field *kptr_field;
> -
> -			if (reg->type != PTR_TO_MAP_VALUE) {
> -				bpf_log(log, "arg#0 expected pointer to map value\n");
> -				return -EINVAL;
> -			}
> -
> -			/* check_func_arg_reg_off allows var_off for
> -			 * PTR_TO_MAP_VALUE, but we need fixed offset to find
> -			 * off_desc.
> -			 */
> -			if (!tnum_is_const(reg->var_off)) {
> -				bpf_log(log, "arg#0 must have constant offset\n");
> -				return -EINVAL;
> -			}
> -
> -			kptr_field = btf_record_find(reg->map_ptr->record, reg->off + reg->var_off.value, BPF_KPTR);
> -			if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
> -				bpf_log(log, "arg#0 no referenced kptr at map value offset=%llu\n",
> -					reg->off + reg->var_off.value);
> -				return -EINVAL;
> -			}
> -
> -			if (!btf_type_is_ptr(ref_t)) {
> -				bpf_log(log, "arg#0 BTF type must be a double pointer\n");
> -				return -EINVAL;
> -			}
> -
> -			ref_t = btf_type_skip_modifiers(btf, ref_t->type, &ref_id);
> -			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> -
> -			if (!btf_type_is_struct(ref_t)) {
> -				bpf_log(log, "kernel function %s args#%d pointer type %s %s is not supported\n",
> -					func_name, i, btf_type_str(ref_t), ref_tname);
> -				return -EINVAL;
> -			}
> -			if (!btf_struct_ids_match(log, btf, ref_id, 0, kptr_field->kptr.btf,
> -						  kptr_field->kptr.btf_id, true)) {
> -				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s\n",
> -					func_name, i, btf_type_str(ref_t), ref_tname);
> -				return -EINVAL;
> -			}
> -			/* rest of the arguments can be anything, like normal kfunc */
> -		} else if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> +		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
>  			/* If function expects ctx type in BTF check that caller
>  			 * is passing PTR_TO_CTX.
>  			 */
> @@ -6900,109 +6672,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  					i, btf_type_str(t));
>  				return -EINVAL;
>  			}
> -		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
> -			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
> -			const struct btf_type *reg_ref_t;
> -			const struct btf *reg_btf;
> -			const char *reg_ref_tname;
> -			u32 reg_ref_id;
> -
> -			if (!btf_type_is_struct(ref_t)) {
> -				bpf_log(log, "kernel function %s args#%d pointer type %s %s is not supported\n",
> -					func_name, i, btf_type_str(ref_t),
> -					ref_tname);
> -				return -EINVAL;
> -			}
> -
> -			if (reg->type == PTR_TO_BTF_ID) {
> -				reg_btf = reg->btf;
> -				reg_ref_id = reg->btf_id;
> -			} else {
> -				reg_btf = btf_vmlinux;
> -				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
> -			}
> -
> -			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
> -							    &reg_ref_id);
> -			reg_ref_tname = btf_name_by_offset(reg_btf,
> -							   reg_ref_t->name_off);
> -			if (!btf_struct_ids_match(log, reg_btf, reg_ref_id,
> -						  reg->off, btf, ref_id,
> -						  trusted_args || (rel && reg->ref_obj_id))) {
> -				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
> -					func_name, i,
> -					btf_type_str(ref_t), ref_tname,
> -					regno, btf_type_str(reg_ref_t),
> -					reg_ref_tname);
> -				return -EINVAL;
> -			}
>  		} else if (ptr_to_mem_ok && processing_call) {
>  			const struct btf_type *resolve_ret;
>  			u32 type_size;
>  
> -			if (is_kfunc) {
> -				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> -				bool arg_dynptr = btf_type_is_struct(ref_t) &&
> -						  !strcmp(ref_tname,
> -							  stringify_struct(bpf_dynptr_kern));
> -
> -				/* Permit pointer to mem, but only when argument
> -				 * type is pointer to scalar, or struct composed
> -				 * (recursively) of scalars.
> -				 * When arg_mem_size is true, the pointer can be
> -				 * void *.
> -				 * Also permit initialized local dynamic pointers.
> -				 */
> -				if (!btf_type_is_scalar(ref_t) &&
> -				    !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> -				    !arg_dynptr &&
> -				    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> -					bpf_log(log,
> -						"arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> -						i, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> -					return -EINVAL;
> -				}
> -
> -				if (arg_dynptr) {
> -					if (reg->type != PTR_TO_STACK) {
> -						bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
> -							i, btf_type_str(ref_t),
> -							ref_tname);
> -						return -EINVAL;
> -					}
> -
> -					if (!is_dynptr_reg_valid_init(env, reg)) {
> -						bpf_log(log,
> -							"arg#%d pointer type %s %s must be valid and initialized\n",
> -							i, btf_type_str(ref_t),
> -							ref_tname);
> -						return -EINVAL;
> -					}
> -
> -					if (!is_dynptr_type_expected(env, reg,
> -							ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> -						bpf_log(log,
> -							"arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> -							i, btf_type_str(ref_t),
> -							ref_tname);
> -						return -EINVAL;
> -					}
> -
> -					continue;
> -				}
> -
> -				/* Check for mem, len pair */
> -				if (arg_mem_size) {
> -					if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {
> -						bpf_log(log, "arg#%d arg#%d memory, len pair leads to invalid memory access\n",
> -							i, i + 1);
> -						return -EINVAL;
> -					}
> -					i++;
> -					continue;
> -				}
> -			}
> -
>  			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
>  			if (IS_ERR(resolve_ret)) {
>  				bpf_log(log,
> @@ -7015,36 +6688,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  			if (check_mem_reg(env, reg, regno, type_size))
>  				return -EINVAL;
>  		} else {
> -			bpf_log(log, "reg type unsupported for arg#%d %sfunction %s#%d\n", i,
> -				is_kfunc ? "kernel " : "", func_name, func_id);
> +			bpf_log(log, "reg type unsupported for arg#%d function %s#%d\n", i,
> +				func_name, func_id);
>  			return -EINVAL;
>  		}
>  	}
>  
> -	/* Either both are set, or neither */
> -	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
> -	/* We already made sure ref_obj_id is set only for one argument. We do
> -	 * allow (!rel && ref_obj_id), so that passing such referenced
> -	 * PTR_TO_BTF_ID to other kfuncs works. Note that rel is only true when
> -	 * is_kfunc is true.
> -	 */
> -	if (rel && !ref_obj_id) {
> -		bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> -			func_name);
> -		return -EINVAL;
> -	}
> -
> -	if (sleepable && !env->prog->aux->sleepable) {
> -		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
> -			func_name);
> -		return -EINVAL;
> -	}
> -
> -	if (kfunc_meta && ref_obj_id)
> -		kfunc_meta->ref_obj_id = ref_obj_id;
> -
> -	/* returns argument register number > 0 in case of reference release kfunc */
> -	return rel ? ref_regno : 0;
> +	return 0;
>  }
>  
>  /* Compare BTF of a function declaration with given bpf_reg_state.
> @@ -7074,7 +6724,7 @@ int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subprog,
>  		return -EINVAL;
>  
>  	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
> -	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, NULL, false);
> +	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, false);
>  
>  	/* Compiler optimizations can remove arguments from static functions
>  	 * or mismatched type can be passed into a global function.
> @@ -7117,7 +6767,7 @@ int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
>  		return -EINVAL;
>  
>  	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
> -	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, NULL, true);
> +	err = btf_check_func_arg_match(env, btf, btf_id, regs, is_global, true);
>  
>  	/* Compiler optimizations can remove arguments from static functions
>  	 * or mismatched type can be passed into a global function.
> @@ -7128,14 +6778,6 @@ int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
>  	return err;
>  }
>  
> -int btf_check_kfunc_arg_match(struct bpf_verifier_env *env,
> -			      const struct btf *btf, u32 func_id,
> -			      struct bpf_reg_state *regs,
> -			      struct bpf_kfunc_arg_meta *meta)
> -{
> -	return btf_check_func_arg_match(env, btf, func_id, regs, true, meta, true);
> -}
> -
>  /* Convert BTF of a function into bpf_reg_state if possible
>   * Returns:
>   * EFAULT - there is a verifier bug. Abort verification.
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8f3abe9b08e..ac6476104983 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5550,8 +5550,8 @@ int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  	return err;
>  }
>  
> -int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -			     u32 regno)
> +static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +				    u32 regno)
>  {
>  	struct bpf_reg_state *mem_reg = &cur_regs(env)[regno - 1];
>  	bool may_be_null = type_may_be_null(mem_reg->type);
> @@ -7863,19 +7863,517 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
>  	}
>  }
>  
> +struct bpf_kfunc_call_arg_meta {
> +	/* In parameters */
> +	struct btf *btf;
> +	u32 func_id;
> +	u32 kfunc_flags;
> +	const struct btf_type *func_proto;
> +	const char *func_name;
> +	/* Out parameters */
> +	u32 ref_obj_id;
> +	u8 release_regno;
> +	bool r0_rdonly;
> +	u64 r0_size;
> +};
> +
> +static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_ACQUIRE;
> +}
> +
> +static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_RET_NULL;
> +}
> +
> +static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_RELEASE;
> +}
> +
> +static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_TRUSTED_ARGS;
> +}
> +
> +static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_SLEEPABLE;
> +}
> +
> +static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_DESTRUCTIVE;
> +}
> +
> +static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
> +{
> +	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> +}
> +
> +static bool is_kfunc_arg_mem_size(const struct btf *btf,
> +				  const struct btf_param *arg,
> +				  const struct bpf_reg_state *reg)
> +{
> +	int len, sfx_len = sizeof("__sz") - 1;
> +	const struct btf_type *t;
> +	const char *param_name;
> +
> +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
> +		return false;
> +
> +	/* In the future, this can be ported to use BTF tagging */
> +	param_name = btf_name_by_offset(btf, arg->name_off);
> +	if (str_is_empty(param_name))
> +		return false;
> +	len = strlen(param_name);
> +	if (len < sfx_len)
> +		return false;
> +	param_name += len - sfx_len;
> +	if (strncmp(param_name, "__sz", sfx_len))
> +		return false;

Oh, I thought we weren't doing this arg-type-by-name-suffix thing? I see
that you're just moving it around so it's fine to move it here, but it
seems to diverge from the discussions I've seen in the past. Don't want
to distract from the patch but is there a plan to get rid of this at
some point?

> +
> +	return true;
> +}
> +
> +static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
> +					  const struct btf_param *arg,
> +					  const char *name)
> +{
> +	int len, target_len = strlen(name);
> +	const char *param_name;
> +
> +	param_name = btf_name_by_offset(btf, arg->name_off);
> +	if (str_is_empty(param_name))
> +		return false;
> +	len = strlen(param_name);
> +	if (len != target_len)
> +		return false;
> +	if (strcmp(param_name, name))
> +		return false;
> +
> +	return true;
> +}

It doesn't look like this function has anything to do with the arg being
a scalar, does it? Should we just rename it something like,
"kfunc_arg_has_name()"?

> +
> +enum {
> +	KF_ARG_DYNPTR_ID,
> +};
> +
> +BTF_ID_LIST(kf_arg_btf_ids)
> +BTF_ID(struct, bpf_dynptr_kern)
> +
> +static bool is_kfunc_arg_dynptr(const struct btf *btf,
> +				const struct btf_param *arg)
> +{
> +	const struct btf_type *t;
> +	u32 res_id;
> +
> +	t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	if (!t)
> +		return false;
> +	if (!btf_type_is_ptr(t))
> +		return false;
> +	t = btf_type_skip_modifiers(btf, t->type, &res_id);
> +	if (!t)
> +		return false;
> +	return btf_types_are_same(btf, res_id, btf_vmlinux, kf_arg_btf_ids[KF_ARG_DYNPTR_ID]);
> +}
> +
> +/* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> +static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> +					const struct btf *btf,
> +					const struct btf_type *t, int rec)
> +{
> +	const struct btf_type *member_type;
> +	const struct btf_member *member;
> +	u32 i;
> +
> +	if (!btf_type_is_struct(t))
> +		return false;
> +
> +	for_each_member(i, t, member) {
> +		const struct btf_array *array;
> +
> +		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
> +		if (btf_type_is_struct(member_type)) {
> +			if (rec >= 3) {
> +				verbose(env, "max struct nesting depth exceeded\n");
> +				return false;
> +			}
> +			if (!__btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
> +				return false;
> +			continue;
> +		}
> +		if (btf_type_is_array(member_type)) {
> +			array = btf_array(member_type);
> +			if (!array->nelems)
> +				return false;
> +			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
> +			if (!btf_type_is_scalar(member_type))
> +				return false;
> +			continue;
> +		}
> +		if (!btf_type_is_scalar(member_type))
> +			return false;
> +	}
> +	return true;
> +}
> +
> +
> +static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> +#ifdef CONFIG_NET
> +	[PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> +	[PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> +	[PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
> +#endif
> +};
> +
> +enum kfunc_ptr_arg_type {
> +	KF_ARG_PTR_TO_CTX,
> +	KF_ARG_PTR_TO_KPTR,	     /* PTR_TO_KPTR but type specific */
> +	KF_ARG_PTR_TO_DYNPTR,
> +	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
> +	KF_ARG_PTR_TO_MEM,
> +	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
> +};
> +
> +static enum kfunc_ptr_arg_type
> +get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
> +		       struct bpf_kfunc_call_arg_meta *meta,
> +		       const struct btf_type *t, const struct btf_type *ref_t,
> +		       const char *ref_tname, const struct btf_param *args,
> +		       int argno, int nargs)
> +{
> +	u32 regno = argno + 1;
> +	struct bpf_reg_state *regs = cur_regs(env);
> +	struct bpf_reg_state *reg = &regs[regno];
> +	bool arg_mem_size = false;
> +
> +	/* In this function, we verify the kfunc's BTF as per the argument type,
> +	 * leaving the rest of the verification with respect to the register
> +	 * type to our caller. When a set of conditions hold in the BTF type of
> +	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
> +	 */
> +	if (btf_get_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), argno))
> +		return KF_ARG_PTR_TO_CTX;
> +
> +	if (is_kfunc_arg_kptr_get(meta, argno)) {
> +		if (!btf_type_is_ptr(ref_t)) {
> +			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
> +			return -EINVAL;
> +		}
> +		ref_t = btf_type_by_id(meta->btf, ref_t->type);
> +		ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
> +		if (!btf_type_is_struct(ref_t)) {
> +			verbose(env, "kernel function %s args#0 pointer type %s %s is not supported\n",
> +				meta->func_name, btf_type_str(ref_t), ref_tname);
> +			return -EINVAL;
> +		}
> +		return KF_ARG_PTR_TO_KPTR;
> +	}
> +
> +	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
> +		return KF_ARG_PTR_TO_DYNPTR;
> +
> +	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
> +		if (!btf_type_is_struct(ref_t)) {
> +			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
> +				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> +			return -EINVAL;
> +		}
> +		return KF_ARG_PTR_TO_BTF_ID;
> +	}
> +
> +	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
> +		arg_mem_size = true;
> +
> +	/* This is the catch all argument type of register types supported by
> +	 * check_helper_mem_access. However, we only allow when argument type is
> +	 * pointer to scalar, or struct composed (recursively) of scalars. When
> +	 * arg_mem_size is true, the pointer can be void *.
> +	 */
> +	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
> +	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> +		verbose(env, "arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> +			argno, btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> +		return -EINVAL;
> +	}
> +	return arg_mem_size ? KF_ARG_PTR_TO_MEM_SIZE : KF_ARG_PTR_TO_MEM;
> +}
> +
> +static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
> +					struct bpf_reg_state *reg,
> +					const struct btf_type *ref_t,
> +					const char *ref_tname, u32 ref_id,
> +					struct bpf_kfunc_call_arg_meta *meta,
> +					int argno)
> +{
> +	const struct btf_type *reg_ref_t;
> +	bool strict_type_match = false;
> +	const struct btf *reg_btf;
> +	const char *reg_ref_tname;
> +	u32 reg_ref_id;
> +
> +	if (reg->type == PTR_TO_BTF_ID) {
> +		reg_btf = reg->btf;
> +		reg_ref_id = reg->btf_id;
> +	} else {
> +		reg_btf = btf_vmlinux;
> +		reg_ref_id = *reg2btf_ids[base_type(reg->type)];
> +	}
> +
> +	if (is_kfunc_trusted_args(meta) || (is_kfunc_release(meta) && reg->ref_obj_id))
> +		strict_type_match = true;
> +
> +	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
> +	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
> +	if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
> +		verbose(env, "kernel function %s args#%d expected pointer to %s %s but R%d has a pointer to %s %s\n",
> +			meta->func_name, argno, btf_type_str(ref_t), ref_tname, argno + 1,
> +			btf_type_str(reg_ref_t), reg_ref_tname);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
> +					     struct bpf_reg_state *reg,
> +					     const struct btf_type *ref_t,
> +					     const char *ref_tname,
> +					     struct bpf_kfunc_call_arg_meta *meta,
> +					     int argno)
> +{
> +	struct btf_field *kptr_field;
> +
> +	/* check_func_arg_reg_off allows var_off for
> +	 * PTR_TO_MAP_VALUE, but we need fixed offset to find
> +	 * off_desc.
> +	 */
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env, "arg#0 must have constant offset\n");
> +		return -EINVAL;
> +	}
> +
> +	kptr_field = btf_record_find(reg->map_ptr->record, reg->off + reg->var_off.value, BPF_KPTR);
> +	if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
> +		verbose(env, "arg#0 no referenced kptr at map value offset=%llu\n",
> +			reg->off + reg->var_off.value);
> +		return -EINVAL;
> +	}
> +
> +	if (!btf_struct_ids_match(&env->log, meta->btf, ref_t->type, 0, kptr_field->kptr.btf,
> +				  kptr_field->kptr.btf_id, true)) {
> +		verbose(env, "kernel function %s args#%d expected pointer to %s %s\n",
> +			meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	const char *func_name = meta->func_name, *ref_tname;
> +	const struct btf *btf = meta->btf;
> +	const struct btf_param *args;
> +	u32 i, nargs;
> +	int ret;
> +
> +	args = (const struct btf_param *)(meta->func_proto + 1);

Not your change and it's fine to not block this cleanup on fixing an
issue that's been in the verifier for a while, but it's unfortunate that
we never built proper encapsulations for fetching params from the func
proto. This is pretty brittle. A cleanup for another day...

> +	nargs = btf_type_vlen(meta->func_proto);
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
> +			MAX_BPF_FUNC_REG_ARGS);
> +		return -EINVAL;
> +	}
> +
> +	/* Check that BTF function arguments match actual types that the
> +	 * verifier sees.
> +	 */
> +	for (i = 0; i < nargs; i++) {
> +		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
> +		const struct btf_type *t, *ref_t, *resolve_ret;
> +		enum bpf_arg_type arg_type = ARG_DONTCARE;
> +		u32 regno = i + 1, ref_id, type_size;
> +		bool is_ret_buf_sz = false;
> +		int kf_arg_type;
> +
> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> +		if (btf_type_is_scalar(t)) {
> +			if (reg->type != SCALAR_VALUE) {
> +				verbose(env, "R%d is not a scalar\n", regno);
> +				return -EINVAL;
> +			}
> +			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
> +				meta->r0_rdonly = true;
> +				is_ret_buf_sz = true;
> +			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
> +				is_ret_buf_sz = true;
> +			}
> +
> +			if (is_ret_buf_sz) {
> +				if (meta->r0_size) {
> +					verbose(env, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
> +					return -EINVAL;
> +				}
> +
> +				if (!tnum_is_const(reg->var_off)) {
> +					verbose(env, "R%d is not a const\n", regno);
> +					return -EINVAL;
> +				}
> +
> +				meta->r0_size = reg->var_off.value;
> +				ret = mark_chain_precision(env, regno);
> +				if (ret)
> +					return ret;
> +			}
> +			continue;
> +		}
> +
> +		if (!btf_type_is_ptr(t)) {
> +			verbose(env, "Unrecognized arg#%d type %s\n", i, btf_type_str(t));
> +			return -EINVAL;
> +		}
> +
> +		if (reg->ref_obj_id) {
> +			if (is_kfunc_release(meta) && meta->ref_obj_id) {
> +				verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> +					regno, reg->ref_obj_id,
> +					meta->ref_obj_id);
> +				return -EFAULT;
> +			}
> +			meta->ref_obj_id = reg->ref_obj_id;
> +			if (is_kfunc_release(meta))
> +				meta->release_regno = regno;
> +		}
> +
> +		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
> +		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
> +
> +		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname, args, i, nargs);
> +		if (kf_arg_type < 0)
> +			return kf_arg_type;
> +
> +		switch (kf_arg_type) {
> +		case KF_ARG_PTR_TO_BTF_ID:
> +			if (!is_kfunc_trusted_args(meta))
> +				break;
> +			if (!reg->ref_obj_id) {
> +				verbose(env, "R%d must be referenced\n", regno);
> +				return -EINVAL;
> +			}
> +			fallthrough;
> +		case KF_ARG_PTR_TO_CTX:
> +			/* Trusted arguments have the same offset checks as release arguments */
> +			arg_type |= OBJ_RELEASE;
> +			break;
> +		case KF_ARG_PTR_TO_KPTR:
> +		case KF_ARG_PTR_TO_DYNPTR:
> +		case KF_ARG_PTR_TO_MEM:
> +		case KF_ARG_PTR_TO_MEM_SIZE:
> +			/* Trusted by default */
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			return -EFAULT;
> +		}
> +
> +		if (is_kfunc_release(meta) && reg->ref_obj_id)
> +			arg_type |= OBJ_RELEASE;
> +		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (kf_arg_type) {
> +		case KF_ARG_PTR_TO_CTX:
> +			if (reg->type != PTR_TO_CTX) {
> +				verbose(env, "arg#%d expected pointer to ctx, but got %s\n", i, btf_type_str(t));
> +				return -EINVAL;
> +			}
> +			break;
> +		case KF_ARG_PTR_TO_KPTR:
> +			if (reg->type != PTR_TO_MAP_VALUE) {
> +				verbose(env, "arg#0 expected pointer to map value\n");
> +				return -EINVAL;
> +			}
> +			ret = process_kf_arg_ptr_to_kptr_strong(env, reg, ref_t, ref_tname, meta, i);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case KF_ARG_PTR_TO_DYNPTR:
> +			if (reg->type != PTR_TO_STACK) {
> +				verbose(env, "arg#%d expected pointer to stack\n", i);
> +				return -EINVAL;
> +			}
> +
> +			if (!is_dynptr_reg_valid_init(env, reg)) {
> +				verbose(env, "arg#%d pointer type %s %s must be valid and initialized\n",
> +					i, btf_type_str(ref_t), ref_tname);
> +				return -EINVAL;
> +			}
> +
> +			if (!is_dynptr_type_expected(env, reg, ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> +				verbose(env, "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
> +					i, btf_type_str(ref_t), ref_tname);
> +				return -EINVAL;
> +			}
> +			break;
> +		case KF_ARG_PTR_TO_BTF_ID:
> +			/* Only base_type is checked, further checks are done here */
> +			if (reg->type != PTR_TO_BTF_ID &&
> +			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> +				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> +				return -EINVAL;
> +			}
> +			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case KF_ARG_PTR_TO_MEM:
> +			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
> +			if (IS_ERR(resolve_ret)) {
> +				verbose(env, "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
> +					i, btf_type_str(ref_t), ref_tname, PTR_ERR(resolve_ret));
> +				return -EINVAL;
> +			}
> +			ret = check_mem_reg(env, reg, regno, type_size);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case KF_ARG_PTR_TO_MEM_SIZE:
> +			ret = check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1);
> +			if (ret < 0) {
> +				verbose(env, "arg#%d arg#%d memory, len pair leads to invalid memory access\n", i, i + 1);
> +				return ret;
> +			}
> +			/* Skip next '__sz' argument */
> +			i++;
> +			break;
> +		}
> +	}
> +
> +	if (is_kfunc_release(meta) && !meta->release_regno) {
> +		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
> +			func_name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			    int *insn_idx_p)
>  {
>  	const struct btf_type *t, *func, *func_proto, *ptr_type;
>  	struct bpf_reg_state *regs = cur_regs(env);
> -	struct bpf_kfunc_arg_meta meta = { 0 };
>  	const char *func_name, *ptr_type_name;
> +	struct bpf_kfunc_call_arg_meta meta;
>  	u32 i, nargs, func_id, ptr_type_id;
>  	int err, insn_idx = *insn_idx_p;
>  	const struct btf_param *args;
>  	struct btf *desc_btf;
>  	u32 *kfunc_flags;
> -	bool acq;
>  
>  	/* skip for now, but return error when we find this in fixup_kfunc_call */
>  	if (!insn->imm)
> @@ -7896,24 +8394,34 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			func_name);
>  		return -EACCES;
>  	}
> -	if (*kfunc_flags & KF_DESTRUCTIVE && !capable(CAP_SYS_BOOT)) {
> -		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capabilities\n");
> +
> +	/* Prepare kfunc call metadata */
> +	memset(&meta, 0, sizeof(meta));
> +	meta.btf = desc_btf;
> +	meta.func_id = func_id;
> +	meta.kfunc_flags = *kfunc_flags;
> +	meta.func_proto = func_proto;
> +	meta.func_name = func_name;
> +
> +	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
> +		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
>  		return -EACCES;
>  	}
>  
> -	acq = *kfunc_flags & KF_ACQUIRE;
> -
> -	meta.flags = *kfunc_flags;
> +	if (is_kfunc_sleepable(&meta) && !env->prog->aux->sleepable) {
> +		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
> +		return -EACCES;
> +	}
>  
>  	/* Check the arguments */
> -	err = btf_check_kfunc_arg_match(env, desc_btf, func_id, regs, &meta);
> +	err = check_kfunc_args(env, &meta);
>  	if (err < 0)
>  		return err;
>  	/* In case of release function, we get register number of refcounted
> -	 * PTR_TO_BTF_ID back from btf_check_kfunc_arg_match, do the release now
> +	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>  	 */
> -	if (err) {
> -		err = release_reference(env, regs[err].ref_obj_id);
> +	if (meta.release_regno) {
> +		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
>  		if (err) {
>  			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
>  				func_name, func_id);
> @@ -7927,7 +8435,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	/* Check return type */
>  	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
>  
> -	if (acq && !btf_type_is_struct_ptr(desc_btf, t)) {
> +	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
>  		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
>  		return -EINVAL;
>  	}

Can you move this up to where we check is_kfunc_desctructive(),
is_kfunc_sleepable(), etc to group logically similar code together?

> @@ -7966,20 +8474,23 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
>  			regs[BPF_REG_0].btf_id = ptr_type_id;
>  		}
> -		if (*kfunc_flags & KF_RET_NULL) {
> +		if (is_kfunc_ret_null(&meta)) {
>  			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
>  			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
>  			regs[BPF_REG_0].id = ++env->id_gen;
>  		}
>  		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
> -		if (acq) {
> +		if (is_kfunc_acquire(&meta)) {
>  			int id = acquire_reference_state(env, insn_idx);
>  
>  			if (id < 0)
>  				return id;
> -			regs[BPF_REG_0].id = id;
> +			if (is_kfunc_ret_null(&meta))
> +				regs[BPF_REG_0].id = id;
>  			regs[BPF_REG_0].ref_obj_id = id;
>  		}
> +		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
> +			regs[BPF_REG_0].id = ++env->id_gen;
>  	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
>  
>  	nargs = btf_type_vlen(func_proto);
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> index c210657d4d0a..55d641c1f126 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> @@ -22,7 +22,7 @@ static struct {
>  	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type", 0},
>  	{"not_valid_dynptr",
>  	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized", 0},
> -	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack", 0},
> +	{"not_ptr_to_stack", "arg#0 expected pointer to stack", 0},
>  	{"dynptr_data_null", NULL, -EBADMSG},
>  };
>  
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index e1a937277b54..86d6fef2e3b4 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -109,7 +109,7 @@
>  	},
>  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>  	.result = REJECT,
> -	.errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point",
> +	.errstr = "arg#0 expected pointer to btf or socket",
>  	.fixup_kfunc_btf_id = {
>  		{ "bpf_kfunc_call_test_acquire", 3 },
>  		{ "bpf_kfunc_call_test_release", 5 },
> diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> index fd683a32a276..55cba01c99d5 100644
> --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> @@ -142,7 +142,7 @@
>  	.kfunc = "bpf",
>  	.expected_attach_type = BPF_LSM_MAC,
>  	.flags = BPF_F_SLEEPABLE,
> -	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> +	.errstr = "arg#0 expected pointer to btf or socket",
>  	.fixup_kfunc_btf_id = {
>  		{ "bpf_lookup_user_key", 2 },
>  		{ "bpf_key_put", 4 },
> @@ -163,7 +163,7 @@
>  	.kfunc = "bpf",
>  	.expected_attach_type = BPF_LSM_MAC,
>  	.flags = BPF_F_SLEEPABLE,
> -	.errstr = "arg#0 pointer type STRUCT bpf_key must point to scalar, or struct with scalar",
> +	.errstr = "arg#0 expected pointer to btf or socket",
>  	.fixup_kfunc_btf_id = {
>  		{ "bpf_lookup_system_key", 1 },
>  		{ "bpf_key_put", 3 },
> -- 
> 2.38.1
> 
