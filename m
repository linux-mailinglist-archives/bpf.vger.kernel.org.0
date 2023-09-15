Return-Path: <bpf+bounces-10188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083297A2A9D
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 00:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A521C20929
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 22:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AA1B263;
	Fri, 15 Sep 2023 22:44:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79418E1B
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 22:44:06 +0000 (UTC)
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAEE186
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 15:44:05 -0700 (PDT)
Message-ID: <34a6af4f-ef3d-7e34-0c71-3c76d8f299e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694817842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZNvCWF+N65vkn8roSj1cO2O65mXKFU4DOTflcgy3no=;
	b=URYU7u+4SgTOprfMXqOYppIiI6dWYc013bRMR3pX+y3+dUW34WUJru399u0Qd6petLnb1j
	iiyiPOvbAp7WVsj2wbwjBF5wswVzex7PHHRVl7gc3F4cykGWLXEoeaDP6SoAxNXpkvZ4KB
	iOkV8HO53wOzDXVkr/jKWmufCl+1rKs=
Date: Fri, 15 Sep 2023 15:43:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v2 1/9] bpf: refactory struct_ops type
 initialization to a function.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230913061449.1918219-1-thinker.li@gmail.com>
 <20230913061449.1918219-2-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230913061449.1918219-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/12/23 11:14 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Move most of code to bpf_struct_ops_init_one() that can be use to
> initialize new struct_ops types registered dynamically.

While in RFC, still better to have SOB so that it won't be overlooked in the future.

> ---
>   kernel/bpf/bpf_struct_ops.c | 157 +++++++++++++++++++-----------------
>   1 file changed, 83 insertions(+), 74 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fdc3e8705a3c..1662875e0ebe 100644
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

It needs to do some sanity checks on the value_type since this won't be 
statically enforced by bpf_struct_ops.c.

[ ... ]

> +void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> +{
> +	struct bpf_struct_ops *st_ops;
> +	s32 module_id;
> +	u32 i;
>   
> -			if (__btf_member_bitfield_size(t, member)) {
> -				pr_warn("bit field member %s in struct %s is not supported\n",
> -					mname, st_ops->name);
> -				break;
> -			}
> +	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
> +#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
> +#include "bpf_struct_ops_types.h"
> +#undef BPF_STRUCT_OPS_TYPE

Can this static way of defining struct_ops be removed? bpf_tcp_ca should be able 
to use the register_bpf_struct_ops() introduced in patch 2.

For the future subsystem supporting struct_ops, the subsystem could be compiled 
as a kernel module or as a built-in. register_bpf_struct_ops() should work for both.


