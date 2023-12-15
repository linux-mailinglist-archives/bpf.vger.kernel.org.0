Return-Path: <bpf+bounces-17940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EB814029
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F461C21EB3
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B4EC9;
	Fri, 15 Dec 2023 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IYKdfrYk"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CF5697
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e6bff53-a219-4c69-a662-75e097100c9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702608254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yif2miY7MAya9lfKU6FV3CiQfHhp5g/3uqlvkXR1StM=;
	b=IYKdfrYkQ0hY2WXg8Y1jZj4gEnsUZj32ho1gL/Uac6/ZidK4R1G2a0kuztlpMN3BknEFeL
	dgDpvgsrXfFyqAJ5SIfQPTav4Z9zkC9AthUWm4K2q8zZY69YlvfQf//B33Q/LZQnV/y64B
	castaDH0KgcRsX/NYGKBSkrkqmhcB00=
Date: Thu, 14 Dec 2023 18:44:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 07/14] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-8-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-8-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
> @@ -681,15 +682,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_struct_ops_map *st_map;
>   	const struct btf_type *t, *vt;
>   	struct bpf_map *map;
> +	struct btf *btf;
>   	int ret;
>   
> -	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
> -	if (!st_ops_desc)
> -		return ERR_PTR(-ENOTSUPP);
> +	if (attr->value_type_btf_obj_fd) {
> +		/* The map holds btf for its whole life time. */
> +		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
> +		if (IS_ERR(btf))
> +			return ERR_PTR(PTR_ERR(btf));

			return ERR_CAST(btf);

It needs to check for btf_is_module:

		if (!btf_is_module(btf)) {
			btf_put(btf);
			return ERR_PTR(-EINVAL);
		}

> +	} else {
> +		btf = btf_vmlinux;
> +		btf_get(btf);

btf_vmlinux could be NULL or a ERR_PTR? Lets take this chance to use 
bpf_get_btf_vmlinux():
		btf = bpf_get_btf_vmlinux();
	        if (IS_ERR(btf))
         	        return ERR_CAST(btf);

Going back to patch 4. This should be the only case that btf will be NULL or 
ERR_PTR?

will continue the remaining review later tonight.

pw-bot: cr

> +	}
> +
> +	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
> +	if (!st_ops_desc) {
> +		ret = -ENOTSUPP;
> +		goto errout;
> +	}
>   
>   	vt = st_ops_desc->value_type;
> -	if (attr->value_size != vt->size)
> -		return ERR_PTR(-EINVAL);
> +	if (attr->value_size != vt->size) {
> +		ret = -EINVAL;
> +		goto errout;
> +	}
>   
>   	t = st_ops_desc->type;
>   


