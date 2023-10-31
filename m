Return-Path: <bpf+bounces-13648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2077DC3D6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC94280FCF
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 01:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787D97FC;
	Tue, 31 Oct 2023 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IWwfcU0v"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41607F2
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 01:22:00 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC3C1
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 18:21:59 -0700 (PDT)
Message-ID: <ac35bad1-f978-6278-9619-c5e9ed3b76e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698715317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=disR6/9qdMQna5mM+MDfQoCNj7UJX/w3WGO9mvSIVbg=;
	b=IWwfcU0v7xHmDClKgtYIVc99Euk+S8qk1oGEPVlU6ml9yLy10+ZzU85XWUfU194NS+Dqs9
	nMzuMU0cxjzsSa25TUXtNNeNJowSbigGvziX22tZYBtQzq5UwyEByh1wRO8c+2RiVCRYsE
	eseGJcw4sdPCmJCo7QNh7/5BesUvcno=
Date: Mon, 30 Oct 2023 18:21:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 04/10] bpf: hold module for
 bpf_struct_ops_map.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-5-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231030192810.382942-5-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
> @@ -681,9 +697,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	if (!st_ops_desc)
>   		return ERR_PTR(-ENOTSUPP);
>   
> +	if (st_ops_desc->btf != btf_vmlinux) {
> +		mod = btf_try_get_module(st_ops_desc->btf);
> +		if (!mod)
> +			return ERR_PTR(-EINVAL);
> +	}
> +
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
> @@ -694,17 +718,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		(vt->size - sizeof(struct bpf_struct_ops_value));
>   
>   	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
> -	if (!st_map)
> -		return ERR_PTR(-ENOMEM);
> +	if (!st_map) {
> +		ret = -ENOMEM;
> +		goto errout;
> +	}
>   
>   	st_map->st_ops_desc = st_ops_desc;
>   	map = &st_map->map;
>   
>   	ret = bpf_jit_charge_modmem(PAGE_SIZE);
> -	if (ret) {
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(ret);
> -	}
> +	if (ret)
> +		goto errout_free;
>   
>   	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
>   	if (!st_map->image) {
> @@ -713,23 +737,32 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		 * here.
>   		 */
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(-ENOMEM);
> +		ret = -ENOMEM;
> +		goto errout_free;
>   	}
>   	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>   	st_map->links =
>   		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
>   				   NUMA_NO_NODE);
>   	if (!st_map->uvalue || !st_map->links) {
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(-ENOMEM);
> +		ret = -ENOMEM;
> +		goto errout_free;
>   	}
>   
>   	mutex_init(&st_map->lock);
>   	set_vm_flush_reset_perms(st_map->image);
>   	bpf_map_init_from_attr(map, attr);
>   
> +	module_put(mod);
> +
>   	return map;
> +
> +errout_free:
> +	__bpf_struct_ops_map_free(map);
> +	btf = NULL;		/* has been released */

btf is not defined. I don't think this patch compiles.
Something from a latter patch?

> +errout:
> +	module_put(mod);
> +	return ERR_PTR(ret);
>   }


