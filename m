Return-Path: <bpf+bounces-21559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E684EC3D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180CBB21DE8
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0776C5025A;
	Thu,  8 Feb 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nyh1ZMIb"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91950257
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433309; cv=none; b=Ctv6geeAWdF+GXGo7OZT8PEMwojuF4IIFXeP8fZ4X83Wu5SqioyqetGXDN5uWzF73YYYuteu4WxqDPc28q2oBqIUvIueLndEEct6gcSK2I1Ii7ACK80qWgB9jO926M5B0mcufUELaRyv+UeaZ9jk+R89SO0UzPUbffERjOqf46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433309; c=relaxed/simple;
	bh=JY73RQYGLHFfADFaNHRGwO5l42hBhjzfxAd6Ifzb7JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGmYmK+u7qgWj7rT9BiyvwxCEHcf9h5rrQErabWniwRbUOqNM9sc1VJQmPSYM5JktEY980rbAXVxGhqa7C357/8b56m7gxRlw8264eeOVMRkXqRhR2Ycxp8p2LZLOyhby1vhBbSObWuOQ2ze+RiYnatNl6VkGSCchWRj6e+WMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nyh1ZMIb; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed958d9e-d1c7-4189-9f3f-d89eb86d4897@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707433304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ4075DJBtI5zjjQrGVC8aJPKhnn6A816766ml/kCOs=;
	b=nyh1ZMIbaafZf/LCldh4uGPTbePnZ0IGgw/ZhWyY3CRBiRngTMf/FYlsuvkSUs2E4HOEKa
	AtSmfTo8s2lfQzW1kH4RP+eFJ9M2TR5HNmJm4JxbeX04QHDy7FLjgRVTD74aq/9H0GmfPG
	hejaYJc3ssQyOmlAdfNhAVdjG61Ipe4=
Date: Thu, 8 Feb 2024 15:01:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/4] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240208065103.2154768-1-thinker.li@gmail.com>
 <20240208065103.2154768-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240208065103.2154768-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/7/24 10:51 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Collect argument information from the type information of stub functions to
> mark arguments of BPF struct_ops programs with PTR_MAYBE_NULL if they are
> nullable.  A nullable argument is annotated by suffixing "__nullable" at
> the argument name of stub function.
> 
> For nullable arguments, this patch sets an arg_info to label their reg_type
> with PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This makes the verifier
> to check programs and ensure that they properly check the pointer. The
> programs should check if the pointer is null before accessing the pointed
> memory.
> 
> The implementer of a struct_ops type should annotate the arguments that can
> be null. The implementer should define a stub function (empty) as a
> placeholder for each defined operator. The name of a stub function should
> be in the pattern "<st_op_type>__<operator name>". For example, for
> test_maybe_null of struct bpf_testmod_ops, it's stub function name should
> be "bpf_testmod_ops__test_maybe_null". You mark an argument nullable by
> suffixing the argument name with "__nullable" at the stub function.
> 
> Since we already has stub functions for kCFI, we just reuse these stub
> functions with the naming convention mentioned earlier. These stub
> functions with the naming convention is only required if there are nullable
> arguments to annotate. For functions having not nullable arguments, stub
> functions are not necessary for the purpose of this patch.
> 
> This patch will prepare a list of struct bpf_ctx_arg_aux, aka arg_info, for
> each member field of a struct_ops type.  "arg_info" will be assigned to
> "prog->aux->ctx_arg_info" of BPF struct_ops programs in
> check_struct_ops_btf_id() so that it can be used by btf_ctx_access() later
> to set reg_type properly for the verifier.

One more nit on the naming. It is my overlook in v5.

There are also things that need to address in btf_ctx_arg_offset(). Comment 
inlined below.

Other patches of the set lgtm.

> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h         |  22 ++++
>   include/linux/btf.h         |   2 +
>   kernel/bpf/bpf_struct_ops.c | 197 ++++++++++++++++++++++++++++++++++--
>   kernel/bpf/btf.c            |  33 ++++++
>   kernel/bpf/verifier.c       |   6 ++
>   5 files changed, 253 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9a2ee9456989..6908bd2360ea 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1709,6 +1709,19 @@ struct bpf_struct_ops {
>   	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>   };
>   
> +/* Every member of a struct_ops type has an instance even a member is not
> + * an operator (function pointer). The "arg_info" field will be assigned to
> + * prog->aux->ctx_arg_info of BPF struct_ops programs to provide the
> + * argument information required by the verifier to verify the program.
> + *
> + * btf_ctx_access() will lookup prog->aux->ctx_arg_info to find the
> + * corresponding entry for an given argument.
> + */
> +struct bpf_struct_ops_arg_info {
> +	struct bpf_ctx_arg_aux *arg_info;

One more nit on naming,

It is my overlook in v5. After looking at how "arg_info" means both 
"bpf_struct_ops_arg_info" and "bpf_ctx_arg_aux" in this patch, could you do one 
more rename here and shorten the "*arg_info" here to "*info".

> +	u32 arg_info_cnt;

and "info_cnt" or just "cnt" here.

> +};
> +
>   struct bpf_struct_ops_desc {
>   	struct bpf_struct_ops *st_ops;
>   
> @@ -1716,6 +1729,9 @@ struct bpf_struct_ops_desc {
>   	const struct btf_type *value_type;
>   	u32 type_id;
>   	u32 value_id;
> +
> +	/* Collection of argument information for each member */
> +	struct bpf_struct_ops_arg_info *arg_info;
>   };
>   
>   enum bpf_struct_ops_state {
> @@ -1790,6 +1806,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   			     struct btf *btf,
>   			     struct bpf_verifier_log *log);
>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc,
> +				 int len);
>   #else
>   #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
> @@ -1814,6 +1832,10 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
>   {
>   }
>   
> +static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc, int len)
> +{
> +}
> +
>   #endif
>   
>   #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index df76a14c64f6..15ee845e6b38 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -498,6 +498,8 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
>   bool btf_param_match_suffix(const struct btf *btf,
>   			    const struct btf_param *arg,
>   			    const char *suffix);
> +int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
> +		       u32 arg_no);
>   
>   struct bpf_verifier_log;
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index f98f580de77a..e9cc8c847736 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -116,17 +116,177 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
>   	return true;
>   }
>   
> +#define MAYBE_NULL_SUFFIX "__nullable"
> +#define MAX_STUB_NAME 128
> +
> +/* Return the type info of a stub function, if it exists.
> + *
> + * The name of a stub function is made up of the name of the struct_ops and
> + * the name of the function pointer member, separated by "__". For example,
> + * if the struct_ops type is named "foo_ops" and the function pointer
> + * member is named "bar", the stub function name would be "foo_ops__bar".
> + */
> +static const struct btf_type *
> +find_stub_func_proto(struct btf *btf, const char *st_op_name,
> +		     const char *member_name)
> +{
> +	char stub_func_name[MAX_STUB_NAME];
> +	const struct btf_type *func_type;
> +	s32 btf_id;
> +	int cp;
> +
> +	cp = snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
> +		      st_op_name, member_name);
> +	if (cp >= MAX_STUB_NAME) {
> +		pr_warn("Stub function name too long\n");
> +		return NULL;
> +	}
> +	btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
> +	if (btf_id < 0)
> +		return NULL;
> +	func_type = btf_type_by_id(btf, btf_id);
> +	if (!func_type)
> +		return NULL;
> +
> +	return btf_type_by_id(btf, func_type->type); /* FUNC_PROTO */
> +}
> +
> +/* Prepare argument info for every nullable argument of a member of a
> + * struct_ops type.
> + *
> + * Initialize a struct bpf_struct_ops_arg_info according to type info of
> + * the arguments of a stub function. (Check kCFI for more information about
> + * stub functions.)
> + *
> + * Each member in the struct_ops type has a struct bpf_struct_ops_arg_info
> + * to provide an array of struct bpf_ctx_arg_aux, which in turn provides
> + * the information that used by the verifier to check the arguments of the
> + * BPF struct_ops program assigned to the member. Here, we only care about
> + * the arguments that are marked as __nullable.
> + *
> + * The array of struct bpf_ctx_arg_aux is eventually assigned to
> + * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
> + * verifier. (See check_struct_ops_btf_id())
> + *
> + * all_arg_info->arg_info will be the list of struct bpf_ctx_arg_aux if
> + * success. If fails, it will be kept untouched.
> + */
> +static int prepare_arg_info(struct btf *btf,
> +			    const char *st_ops_name,
> +			    const char *member_name,
> +			    const struct btf_type *func_proto,
> +			    struct bpf_struct_ops_arg_info *all_arg_info)

s/all_arg_info/arg_info/

> +{
> +	const struct btf_type *stub_func_proto, *pointed_type;
> +	struct bpf_ctx_arg_aux *arg_info, *arg_info_buf;

s/arg_info/info/
s/arg_info_buf/info_buf/

> +	const struct btf_param *stub_args, *args;
> +	u32 nargs, arg_no, arg_info_cnt = 0;
> +	s32 arg_btf_id;
> +	int offset;
> +
> +	stub_func_proto = find_stub_func_proto(btf, st_ops_name, member_name);
> +	if (!stub_func_proto)
> +		return 0;
> +
> +	/* Check if the number of arguments of the stub function is the same
> +	 * as the number of arguments of the function pointer.
> +	 */
> +	nargs = btf_type_vlen(func_proto);
> +	if (nargs != btf_type_vlen(stub_func_proto)) {
> +		pr_warn("the number of arguments of the stub function %s__%s does not match the number of arguments of the member %s of struct %s\n",
> +			st_ops_name, member_name, member_name, st_ops_name);
> +		return -EINVAL;
> +	}
> +
> +	args = btf_params(func_proto);
> +	stub_args = btf_params(stub_func_proto);
> +
> +	arg_info_buf = kcalloc(nargs, sizeof(*arg_info_buf), GFP_KERNEL);
> +	if (!arg_info_buf)
> +		return -ENOMEM;
> +
> +	/* Prepare arg_info for every nullable argument */
> +	arg_info = arg_info_buf;
> +	for (arg_no = 0; arg_no < nargs; arg_no++) {
> +		/* Skip arguments that is not suffixed with
> +		 * "__nullable".
> +		 */
> +		if (!btf_param_match_suffix(btf, &stub_args[arg_no],
> +					    MAYBE_NULL_SUFFIX))
> +			continue;
> +
> +		/* Should be a pointer to struct */
> +		pointed_type = btf_type_resolve_ptr(btf,
> +						    args[arg_no].type,
> +						    &arg_btf_id);
> +		if (!pointed_type ||
> +		    !btf_type_is_struct(pointed_type))

pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
	st_ops_name, member_name, MAYBE_NULL_SUFFIX);

> +			goto err_out;
> +
> +		offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
> +		if (offset < 0)

pr_warn("stub function %s__%s has invalid trampoline ctx offset for arg#%u\n",
	st_ops_name, member_name, arg_no);

> +			goto err_out;
> +
> +		/* Fill the information of the new argument */
> +		arg_info->reg_type =
> +			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> +		arg_info->btf_id = arg_btf_id;
> +		arg_info->btf = btf;
> +		arg_info->offset = offset;
> +
> +		arg_info++;
> +		arg_info_cnt++;
> +	}
> +
> +	if (arg_info_cnt) {
> +		all_arg_info->arg_info = arg_info_buf;
> +		all_arg_info->arg_info_cnt = arg_info_cnt;
> +	} else {
> +		kfree(arg_info_buf);
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	kfree(arg_info_buf);
> +
> +	return -EINVAL;
> +}
> +
> +/* Clean up the arg_info in a struct bpf_struct_ops_desc.
> + *
> + * The callers should pass the length of st_ops_desc->arg_info.  The length
> + * can not be derived from std_ops_desc->type since the list may be
> + * incomplete.
> + */
> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc,
> +				 int len)

The "len" argument is not needed. It is the btf_type_vlen(st_ops_desc->type). 
Initialize the st_ops_desc->type/value_type/type_id/value_id earlier if necessary.

> +{
> +	struct bpf_struct_ops_arg_info *arg_info;
> +	int i;
> +
> +	arg_info = st_ops_desc->arg_info;
> +	if (!arg_info)
> +		return;
> +
> +	for (i = 0; i < len; i++)
> +		kfree(arg_info[i].arg_info);
> +
> +	kfree(arg_info);
> +}
> +
>   int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   			     struct btf *btf,
>   			     struct bpf_verifier_log *log)
>   {
>   	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
> +	struct bpf_struct_ops_arg_info *arg_info;
>   	const struct btf_member *member;
>   	const struct btf_type *t;
>   	s32 type_id, value_id;
>   	char value_name[128];
>   	const char *mname;
> -	int i;
> +	int i, err;
>   
>   	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
>   	    sizeof(value_name)) {
> @@ -160,6 +320,12 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   	if (!is_valid_value_type(btf, value_id, t, value_name))
>   		return -EINVAL;
>   
> +	arg_info = kcalloc(btf_type_vlen(t), sizeof(*arg_info),
> +			   GFP_KERNEL);
> +	if (!arg_info)
> +		return -ENOMEM;
> +
> +	st_ops_desc->arg_info = arg_info;
>   	for_each_member(i, t, member) {
>   		const struct btf_type *func_proto;
>   
> @@ -167,32 +333,44 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   		if (!*mname) {
>   			pr_warn("anon member in struct %s is not supported\n",
>   				st_ops->name);
> -			return -EOPNOTSUPP;
> +			err = -EOPNOTSUPP;
> +			goto errout;
>   		}
>   
>   		if (__btf_member_bitfield_size(t, member)) {
>   			pr_warn("bit field member %s in struct %s is not supported\n",
>   				mname, st_ops->name);
> -			return -EOPNOTSUPP;
> +			err = -EOPNOTSUPP;
> +			goto errout;
>   		}
>   
>   		func_proto = btf_type_resolve_func_ptr(btf,
>   						       member->type,
>   						       NULL);
> -		if (func_proto &&
> -		    btf_distill_func_proto(log, btf,
> +		if (!func_proto)
> +			continue;
> +
> +		if (btf_distill_func_proto(log, btf,
>   					   func_proto, mname,
>   					   &st_ops->func_models[i])) {
>   			pr_warn("Error in parsing func ptr %s in struct %s\n",
>   				mname, st_ops->name);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto errout;
>   		}
> +
> +		err = prepare_arg_info(btf, st_ops->name, mname,
> +				       func_proto,
> +				       arg_info + i);
> +		if (err)
> +			goto errout;
>   	}
>   
>   	if (st_ops->init(btf)) {
>   		pr_warn("Error in init bpf_struct_ops %s\n",
>   			st_ops->name);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto errout;
>   	}
>   
>   	st_ops_desc->type_id = type_id;
> @@ -201,6 +379,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
>   
>   	return 0;
> +
> +errout:
> +	bpf_struct_ops_desc_release(st_ops_desc, i);
> +
> +	return err;
>   }
>   
>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e3508b8008a2..554a57a0eaa5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1699,6 +1699,14 @@ static void btf_free_struct_meta_tab(struct btf *btf)
>   static void btf_free_struct_ops_tab(struct btf *btf)
>   {
>   	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
> +	int i;
> +
> +	if (!tab)
> +		return;
> +
> +	for (i = 0; i < tab->cnt; i++)
> +		bpf_struct_ops_desc_release(&tab->ops[i],
> +					    btf_type_vlen(tab->ops[i].type));
>   
>   	kfree(tab);
>   	btf->struct_ops_tab = NULL;
> @@ -6130,6 +6138,31 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
>   	}
>   }
>   
> +int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
> +		       u32 arg_no)
> +{
> +	const struct btf_param *args;
> +	const struct btf_type *t;
> +	int off = 0, i;
> +	u32 sz, nargs;
> +
> +	nargs = btf_type_vlen(func_proto);
> +	/* It is the return value if arg_no == nargs */

I forgot to mention this in v5. This comment is not accurate.

This function is trying to figure out the trampoline ctx offset for a particular 
arg_no. arg_no cannot be the return value and arg_no cannot be >= nargs.

> +	if (arg_no > nargs)

so remove this check all together.

> +		return -EINVAL;
> +
> +	args = btf_params(func_proto);
> +	for (i = 0; i < arg_no; i++) {
> +		t = btf_type_by_id(btf, args[i].type);
> +		t = btf_resolve_size(btf, t, &sz);
> +		if (IS_ERR(t))
> +			return -EINVAL;

return PTR_ERR(t);

> +		off += roundup(sz, 8);
> +	}
> +
> +	return off;
> +}
> +
>   bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>   		    const struct bpf_prog *prog,
>   		    struct bpf_insn_access_aux *info)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7edd70eec7dd..7826d6e6a09b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20415,6 +20415,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   		}
>   	}
>   
> +	/* btf_ctx_access() used this to provide argument type info */
> +	prog->aux->ctx_arg_info =
> +		st_ops_desc->arg_info[member_idx].arg_info;
> +	prog->aux->ctx_arg_info_size =
> +		st_ops_desc->arg_info[member_idx].arg_info_cnt;
> +
>   	prog->aux->attach_func_proto = func_proto;
>   	prog->aux->attach_func_name = mname;
>   	env->ops = st_ops->verifier_ops;


