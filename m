Return-Path: <bpf+bounces-69855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F5BA4B73
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6252A69B2
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47789307AFA;
	Fri, 26 Sep 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AKxxMsJS"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255D267B07
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905627; cv=none; b=ArPk7SBdtsoDvsqSkZAVHhE4XX+7JbRYHKHmE5Za1V/mr7OqxJ/ApooRfPwDB9lM7jeC7x+my6PhVilgX7S0wSexRcXNvqD9QJFB6jxiFZrjTznLxHaJjGO9ZDHFmlty3OR2pm4ggkNfIWerc5O+lme7XQG0NUr1MBXPxlwgrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905627; c=relaxed/simple;
	bh=LwOJpW+sePplAG4eX66QcVDUAwVdGU5QRYA0F0ndEt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv1FXhvq0sp4BaNL0u+xMlfIbdmnamkhAZr5KZzQIDyWUhtdJw6GCig6A7ITa4IndfaWjqeNJvAqDOeBnIMrCS+I+VZoxcvjrfC+X1CvFdrPn7ZBLKJcgea8tMeHSwCer2aWcrFpoe1zOMtiNptJcz2D/ohbguCl/jE8c0eOra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AKxxMsJS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bf53fe2d-366f-46eb-bd9c-5820ebd87db7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758905623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxQha2U3givTWX9Jey3JjHcMVKjbxrYi3ZLCeQ5vxsw=;
	b=AKxxMsJSpuanP0Rm7dhGi4SoTEpl2Csgqr0/89nSGlKItU958szk8s8HqBwyGYTK2X/ocl
	QcfbfZFc758ls8azpu84GabvqgIg5v3/V8ulCKxVJaATI9UZaw1iaMT5F0T1UUuvJmP/gI
	1DtZZTIGpDgZ7CJ5M+z5vSAPSlArCN8=
Date: Fri, 26 Sep 2025 09:53:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: fix error when st-prefix_ops and ops
 from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com
References: <20250926071751.108293-1-alibuda@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250926071751.108293-1-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/26/25 12:17 AM, D. Wythe wrote:
> When a module registers a struct_ops, the struct_ops type and its
> corresponding map_value type ("bpf_struct_ops_") may reside in different
> btf objects, here are four possible case:
> 
> +--------+---------------+-------------+---------------------------------+
> |        |bpf_struct_ops_| xxx_ops     |                                 |
> +--------+---------------+-------------+---------------------------------+
> | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinux |

s/bft/btf/

> +--------+---------------+-------------+---------------------------------+
> | case 1 | btf_vmlinux   | mod_btf     | INVALID                         |
> +--------+---------------+-------------+---------------------------------+
> | case 2 | mod_btf       | btf_vmlinux | reg in mod but be used both in  |
> |        |               |             | vmlinux and mod.                |
> +--------+---------------+-------------+---------------------------------+
> | case 3 | mod_btf       | mod_btf     | be used and reg only in mod     |
> +--------+---------------+-------------+---------------------------------+
> 
> Currently we figure out the mod_btf by searching with the struct_ops type,
> which makes it impossible to figure out the mod_btf when the struct_ops
> type is in btf_vmlinux while it's corresponding map_value type is in
> mod_btf (case 2).
> 
> The fix is to use the corresponding map_value type ("bpf_struct_ops_")
> as the lookup anchor instead of the struct_ops type to figure out the
> `btf` and `mod_btf` via find_ksym_btf_id(), and then we can locate
> the kern_type_id via btf__find_by_name_kind() with the `btf` we just
> obtained from find_ksym_btf_id().
> 
> With this change the lookup obtains the correct btf and mod_btf for case 2,
> preserves correct behavior for other valid cases, and still fails as
> expected for the invalid scenario (case 1).
> 
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 5161c2b39875..a93eed660404 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1018,35 +1018,34 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>   	const struct btf_member *kern_data_member;
>   	struct btf *btf = NULL;
>   	__s32 kern_vtype_id, kern_type_id;
> -	char tname[256];
> +	char tname[256], stname[256];
>   	__u32 i;
>   
>   	snprintf(tname, sizeof(tname), "%.*s",
>   		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
>   
> -	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
> -					&btf, mod_btf);
> -	if (kern_type_id < 0) {
> -		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
> -			tname);
> -		return kern_type_id;
> -	}
> -	kern_type = btf__type_by_id(btf, kern_type_id);
> +	snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_PREFIX,
> +		 (int)strlen(tname), tname);

nit. strlen(tname) should not be needed. Others lgtm.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>



