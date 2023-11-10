Return-Path: <bpf+bounces-14668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58D7E766E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693911C20CEB
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9567F1;
	Fri, 10 Nov 2023 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oBR3HSTl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07B62B
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 01:11:17 +0000 (UTC)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243BBC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:11:17 -0800 (PST)
Message-ID: <eec08936-e001-5d7b-17b4-5074db0754f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699578674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TpLAu35WEkKfLe58MkgycKPP0CM1ysM9sVbciYu0p4=;
	b=oBR3HSTl7MyfvVG/kgTLtuTu9vN1uPsbXNaptXHos/eOScfhmogfXdgGD7MVDWrYEYN3au
	WynsetCfge74AD1v3PzwMcyUXknQyh9THFcPskMmg3CfPpH2/yGUUTZufpmov5EBy0wkd+
	6lP8/PFf5NbaMi+nR7DqKANkH+vP8BY=
Date: Thu, 9 Nov 2023 17:11:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v11 01/13] bpf: refactory struct_ops type
 initialization to a function.
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-2-thinker.li@gmail.com>
Content-Language: en-US
In-Reply-To: <20231106201252.1568931-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index db6176fb64dc..627cf1ea840a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -110,102 +110,111 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
>   
>   static const struct btf_type *module_type;
>   
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> +static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
> +				    struct btf *btf,
> +				    struct bpf_verifier_log *log)
>   {
> -	s32 type_id, value_id, module_id;
>   	const struct btf_member *member;
> -	struct bpf_struct_ops *st_ops;
>   	const struct btf_type *t;
> +	s32 type_id, value_id;
>   	char value_name[128];
>   	const char *mname;
> -	u32 i, j;
> +	int i;
>   
> -	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> +	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
> +	    sizeof(value_name)) {
> +		pr_warn("struct_ops name %s is too long\n",
> +			st_ops->name);
> +		return;
> +	}
> +	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>   
> -	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
> -	if (module_id < 0) {
> -		pr_warn("Cannot find struct module in btf_vmlinux\n");
> +	value_id = btf_find_by_name_kind(btf, value_name,
> +					 BTF_KIND_STRUCT);
> +	if (value_id < 0) {
> +		pr_warn("Cannot find struct %s in btf_vmlinux\n",
> +			value_name);

"btf_vmlinux" needs to change in the pr_warn(). It should be btf->name but that 
may need a helper function to return btf->name.

>   		return;
>   	}
> -	module_type = btf_type_by_id(btf, module_id);
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		st_ops = bpf_struct_ops[i];
> +	type_id = btf_find_by_name_kind(btf, st_ops->name,
> +					BTF_KIND_STRUCT);
> +	if (type_id < 0) {
> +		pr_warn("Cannot find struct %s in btf_vmlinux\n",

Same here.

