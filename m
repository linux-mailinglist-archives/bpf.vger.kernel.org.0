Return-Path: <bpf+bounces-14296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8677A7E2A11
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 17:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407CF2815B8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B229406;
	Mon,  6 Nov 2023 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T14lgCQD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42828E27
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 16:40:15 +0000 (UTC)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9728D49
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 08:40:13 -0800 (PST)
Message-ID: <6091db94-f730-40e8-a9c4-1ee6a3c56d11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699288811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s25VPfa5QojCyYfjN5OSQVKCu++MV3nm/9B5Yn5BTj0=;
	b=T14lgCQD+sNBBgnMTOs03djfpOYrZB47SX5n3ZjFqDoOdn0nx7JW/UZiXJoPmaQL3Uw1/H
	ctdfzWFTxGftVSalPB5G8lVFM7HpOaC+es3c3RV4s16/JjNN8kgDiezrfZfE8JIdU0ZBMc
	1aQukzTVKJBxPy/TGcL/QG1EUpVgCZ4=
Date: Mon, 6 Nov 2023 16:40:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 bpf-next 2/9] bpf: Factor out helper
 check_reg_const_str()
Content-Language: en-US
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org, fsverity@lists.linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com, ebiggers@kernel.org,
 tytso@mit.edu, roberto.sassu@huaweicloud.com, kpsingh@kernel.org,
 vadfed@meta.com
References: <20231104001313.3538201-1-song@kernel.org>
 <20231104001313.3538201-3-song@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231104001313.3538201-3-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/11/2023 00:13, Song Liu wrote:
> ARG_PTR_TO_CONST_STR is used to specify constant string args for BPF
> helpers. The logic that verifies a reg is ARG_PTR_TO_CONST_STR is
> implemented in check_func_arg().
> 
> As we introduce kfuncs with constant string args, it is necessary to
> do the same check for kfuncs (in check_kfunc_args). Factor out the logic
> for ARG_PTR_TO_CONST_STR to a new check_reg_const_str() so that it can be
> reused.
> 
> check_func_arg() ensures check_reg_const_str() is only called with reg of
> type PTR_TO_MAP_VALUE. Add a redundent type check in check_reg_const_str()
> to avoid misuse in the future. Other than this redundent check, there is
> no change in behavior.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   kernel/bpf/verifier.c | 85 +++++++++++++++++++++++++------------------
>   1 file changed, 49 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2197385d91dc..618446006d5a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8718,6 +8718,54 @@ static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
>   	return state->stack[spi].spilled_ptr.dynptr.type;
>   }
>   
> +static int check_reg_const_str(struct bpf_verifier_env *env,
> +			       struct bpf_reg_state *reg, u32 regno)
> +{
> +	struct bpf_map *map = reg->map_ptr;
> +	int err;
> +	int map_off;
> +	u64 map_addr;
> +	char *str_ptr;
> +
> +	if (reg->type != PTR_TO_MAP_VALUE)
> +		return -EINVAL;
> +
> +	if (!bpf_map_is_rdonly(map)) {
> +		verbose(env, "R%d does not point to a readonly map'\n", regno);
> +		return -EACCES;
> +	}
> +
> +	if (!tnum_is_const(reg->var_off)) {
> +		verbose(env, "R%d is not a constant address'\n", regno);
> +		return -EACCES;
> +	}
> +
> +	if (!map->ops->map_direct_value_addr) {
> +		verbose(env, "no direct value access support for this map type\n");
> +		return -EACCES;
> +	}
> +
> +	err = check_map_access(env, regno, reg->off,
> +			       map->value_size - reg->off, false,
> +			       ACCESS_HELPER);
> +	if (err)
> +		return err;
> +
> +	map_off = reg->off + reg->var_off.value;
> +	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> +	if (err) {
> +		verbose(env, "direct value access on string failed\n");
> +		return err;
> +	}
> +
> +	str_ptr = (char *)(long)(map_addr);
> +	if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> +		verbose(env, "string is not zero-terminated\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>   			  struct bpf_call_arg_meta *meta,
>   			  const struct bpf_func_proto *fn,
> @@ -8962,44 +9010,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>   	}
>   	case ARG_PTR_TO_CONST_STR:
>   	{
> -		struct bpf_map *map = reg->map_ptr;
> -		int map_off;
> -		u64 map_addr;
> -		char *str_ptr;
> -
> -		if (!bpf_map_is_rdonly(map)) {
> -			verbose(env, "R%d does not point to a readonly map'\n", regno);
> -			return -EACCES;
> -		}
> -
> -		if (!tnum_is_const(reg->var_off)) {
> -			verbose(env, "R%d is not a constant address'\n", regno);
> -			return -EACCES;
> -		}
> -
> -		if (!map->ops->map_direct_value_addr) {
> -			verbose(env, "no direct value access support for this map type\n");
> -			return -EACCES;
> -		}
> -
> -		err = check_map_access(env, regno, reg->off,
> -				       map->value_size - reg->off, false,
> -				       ACCESS_HELPER);
> +		err = check_reg_const_str(env, reg, regno);
>   		if (err)
>   			return err;
> -
> -		map_off = reg->off + reg->var_off.value;
> -		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
> -		if (err) {
> -			verbose(env, "direct value access on string failed\n");
> -			return err;
> -		}
> -
> -		str_ptr = (char *)(long)(map_addr);
> -		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
> -			verbose(env, "string is not zero-terminated\n");
> -			return -EINVAL;
> -		}
>   		break;
>   	}
>   	case ARG_PTR_TO_KPTR:

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

