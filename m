Return-Path: <bpf+bounces-47371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0839F8803
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 23:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B7416B80D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224471C5CC9;
	Thu, 19 Dec 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ft+wKP6q"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4386337
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648221; cv=none; b=qPjpwa4BoOLnS4BJj0dX3iSobC1UMrlYsIXC2oBylnAHffT12UmKKOXbt4vevxp7mDHvnc+4zSPh/bOlvNpMg644LfgiIBUJf+HD8OED8o7u9quq6a0Sa398khVyz7qeYbKGhr9FXFLwqUIr5FEWfWWjruxAj1BrPzSAwU7BUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648221; c=relaxed/simple;
	bh=4fmPcWKjeO67qj6ciJPlVo6dJyCUn+0clUCf5Birzy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X54UyecOmOtN8M+U+NrH+3pvM9jBiLHzvLUazU6B0ik90XgFkvs+KezeLRu/6OxBOMl14wKV+QrCfAI0Morda7ETZclNgmZwDtGhpCzvXRKZcsSk5jeqRkoUeR7eCG/WM1MGlTFIOIx4KDZki2VtQDCncjtIc/PxMjMyEu6KUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ft+wKP6q; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f56aca3-a27a-49b6-90de-7f1b2ff39df1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734648217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+i4PtjvWS84jCmxpRNu1g3Fzl6WMJ7eBdsTXPqebBg=;
	b=Ft+wKP6q6S5wsyOb5FP9+VzdSYp8OdSpAuPpk3Tgii6ZLXEelP9M2xOAsvkD17FsFTlWvK
	5051wHWOzA6YgrGmmm76c/qk2xn/tge4c22azzSpuBoyVtpevLMRIu/la/bM58PnBM4uca
	qxgjqCMaYuoHICVL027sUcvsmawjxYk=
Date: Thu, 19 Dec 2024 14:43:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, Daniel Xu <dlxu@meta.com>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-5-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241218024422.23423-5-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/17/24 6:44 PM, D. Wythe wrote:
> When a struct_ops named xxx_ops was registered by a module, and
> it will be used in both built-in modules and the module itself,
> so that the btf_type of xxx_ops will be present in btf_vmlinux
> instead of in btf_mod, which means that the btf_type of
> bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
> 
> Here are four possible case:
> 
> +--------+-------------+-------------+---------------------------------+
> |        | st_opx_xxx  | xxx         |                                 |
> +--------+-------------+-------------+---------------------------------+
> | case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
> +--------+-------------+-------------+---------------------------------+
> | case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
> +--------+-------------+-------------+---------------------------------+
> | case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
> |        |             |             | vmlinux and mod.                |
> +--------+-------------+-------------+---------------------------------+
> | case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
> +--------+-------------+-------------+---------------------------------+
> 
> At present, cases 0, 1, and 3 can be correctly identified, because
> st_ops_xxx is searched from the same btf with xxx. In order to
> handle case 2 correctly without affecting other cases, we cannot simply
> change the search method for st_ops_xxx from find_btf_by_prefix_kind()
> to find_ksym_btf_id(), because in this way, case 1 will not be
> recognized anymore.
> 
> To address this issue, if st_ops_xxx cannot be found in the btf with xxx
> and mod_btf does not exist, do find_ksym_btf_id() again to
> avoid such issue.
> 
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   tools/lib/bpf/libbpf.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..56bf74894110 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1005,7 +1005,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>   	const struct btf_member *kern_data_member;
>   	struct btf *btf = NULL;
>   	__s32 kern_vtype_id, kern_type_id;
> -	char tname[256];
> +	char tname[256], stname[256];
> +	int ret;
>   	__u32 i;
>   
>   	snprintf(tname, sizeof(tname), "%.*s",
> @@ -1020,17 +1021,25 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>   	}
>   	kern_type = btf__type_by_id(btf, kern_type_id);
>   
> +	ret = snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);

How about always look for "struct bpf_struct_ops_smc_ops" first, figure out the 
btf, and then look for "struct smc_ops", would it work?

If CONFIG_SMC=y instead of =m, this change cannot be tested?

> +	if (ret < 0 || ret >= sizeof(stname))
> +		return -ENAMETOOLONG;
> +
>   	/* Find the corresponding "map_value" type that will be used
>   	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
>   	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
>   	 * btf_vmlinux.
>   	 */
> -	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
> -						tname, BTF_KIND_STRUCT);
> +	kern_vtype_id = btf__find_by_name_kind(btf, stname, BTF_KIND_STRUCT);
>   	if (kern_vtype_id < 0) {
> -		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
> -			STRUCT_OPS_VALUE_PREFIX, tname);
> -		return kern_vtype_id;
> +		if (kern_vtype_id == -ENOENT && !*mod_btf)
> +			kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT,
> +							 &btf, mod_btf);
> +		if (kern_vtype_id < 0) {
> +			pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
> +				stname);
> +			return kern_vtype_id;
> +		}
>   	}
>   	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
>   
> @@ -1046,8 +1055,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>   			break;
>   	}
>   	if (i == btf_vlen(kern_vtype)) {
> -		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
> -			tname, STRUCT_OPS_VALUE_PREFIX, tname);
> +		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s\n",
> +			tname, stname);
>   		return -EINVAL;
>   	}
>   


