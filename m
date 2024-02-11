Return-Path: <bpf+bounces-21719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64181850B48
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 20:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805261C218CA
	for <lists+bpf@lfdr.de>; Sun, 11 Feb 2024 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745725DF1E;
	Sun, 11 Feb 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFYOoX/6"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB278AD2D
	for <bpf@vger.kernel.org>; Sun, 11 Feb 2024 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707680991; cv=none; b=oDD/3J8i2AaPc5HFOKFXZXKAxJzsW2XIMP+ktvh9J5w3P+mGuq0pn4tXDgHM/iMzeDbw9V0eRd7yeFPwMzkmp42xKCQNgziVTVJbAph2s1jKkfTQS+pcP804f44fDv70GxfyN18j9JgsCSOAuSCc9pSHRcjhE5oS5KaD6wDNhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707680991; c=relaxed/simple;
	bh=nX6owGeVgjUaVbeTVZfJS6HaTz82QXWbLF4aswgqvMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im8dkxv5xuZYR0dknM24Z1uWtwd87Pk8aoVORflW2SIeVAQg5W87FDFofKrH8QjTkmmaVKXkeAEV0GTNaYkylDq6p8sv82x/AUhM3sTGLAvKLRMGnhPx06kmoEhP2fVEwDWwz7RdpDPzgpENhMycBFSBZA3Zhi+Q5NxneCpVbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFYOoX/6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9404a412-90ca-4a45-92f2-a034f99c66f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707680986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOaGTM+BHFWnzaQZGSPbad4uw6YDuX5rmTYz1h5PXYg=;
	b=ZFYOoX/6oWZpOPXmtE0niGHu7ts+9mFcfoEw2dLlw3Z+fV6hfyd6d9yo70ubvR5G7XRvCx
	LaZ8d1ajsQi6SQKz+goBmFwlxMDOWZI+cUFL5I9ls2QZc7lNpHgVGCN/C2JXl+VyvXb2I+
	RGJKRArnYKlqie7HQ5ECrNZ9YX58Fe4=
Date: Sun, 11 Feb 2024 11:49:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Create argument information for
 nullable arguments.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 davemarchevsky@meta.com, dvernet@meta.com
References: <20240209023750.1153905-1-thinker.li@gmail.com>
 <20240209023750.1153905-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240209023750.1153905-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/24 6:37 PM, thinker.li@gmail.com wrote:
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
> + * arg_info->info will be the list of struct bpf_ctx_arg_aux if success. If
> + * fails, it will be kept untouched.
> + */
> +static int prepare_arg_info(struct btf *btf,
> +			    const char *st_ops_name,
> +			    const char *member_name,
> +			    const struct btf_type *func_proto,
> +			    struct bpf_struct_ops_arg_info *arg_info)
> +{
> +	const struct btf_type *stub_func_proto, *pointed_type;
> +	const struct btf_param *stub_args, *args;
> +	struct bpf_ctx_arg_aux *info, *info_buf;
> +	u32 nargs, arg_no, info_cnt = 0;
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
> +	info_buf = kcalloc(nargs, sizeof(*info_buf), GFP_KERNEL);
> +	if (!info_buf)
> +		return -ENOMEM;
> +
> +	/* Prepare info for every nullable argument */
> +	info = info_buf;
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
> +		    !btf_type_is_struct(pointed_type)) {
> +			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
> +				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
> +			goto err_out;
> +		}

We briefly talked about this and compiler can probably catch any arg
type inconsistency between the stub func_proto and the original func_proto.

I still think it is better to be strict at the
beginning and ensure the "stub_args" type is the same as the original "args"
type. It is to bar any type inconsistency going forward on the __nullable
tagged argument (e.g. changing the original func_proto but forgot to
change the stub func_proto).

We can revisit in the future if the following type comparison does not work well.

                 if (args[arg_no].type != stub_args[arg_no].type) {
			pr_warn("arg#%u type in stub func_proto %s__%s does not match with its original func_proto\n",
				arg_no, st_ops_name, member_name);
			goto err_out;
                 }

> +
> +		offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
> +		if (offset < 0) {
> +			pr_warn("stub function %s__%s has an invalid trampoline ctx offset for arg#%u\n",
> +				st_ops_name, member_name, arg_no);
> +			goto err_out;
> +		}
> +
> +		/* Fill the information of the new argument */
> +		info->reg_type =
> +			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
> +		info->btf_id = arg_btf_id;
> +		info->btf = btf;
> +		info->offset = offset;
> +
> +		info++;
> +		info_cnt++;
> +	}
> +
> +	if (info_cnt) {
> +		arg_info->info = info_buf;
> +		arg_info->cnt = info_cnt;
> +	} else {
> +		kfree(info_buf);
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	kfree(info_buf);
> +
> +	return -EINVAL;
> +}
> +
> +/* Clean up the arg_info in a struct bpf_struct_ops_desc. */
> +void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
> +{
> +	struct bpf_struct_ops_arg_info *arg_info;
> +	int i;
> +
> +	arg_info = st_ops_desc->arg_info;
> +	if (!arg_info)

nit. I think this check is unnecessary ?

If the above two comments make sense to you, I can make the adjustment. No need to resend.

Patch 4 lgtm.

> +		return;
> +
> +	for (i = 0; i < btf_type_vlen(st_ops_desc->type); i++)
> +		kfree(arg_info[i].info);
> +
> +	kfree(arg_info);
> +}
> +


