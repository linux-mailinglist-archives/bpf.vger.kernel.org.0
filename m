Return-Path: <bpf+bounces-30076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD188CA5B2
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053571C2104F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D579F3;
	Tue, 21 May 2024 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B4phpxJ8"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F723B1
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716254648; cv=none; b=WgfLED/+I16h6KW24GXw5AwuP/aXWbdgHFsM1pXvn3w+yEPHoPGD7MKC09uLBSxfPAcGciEHabXpd9CI0IL0rYk9ld5/2Ra3hLFwQOKNjy14G6QHxVEE4Xk6I1gSLD8YBo02+/MSKrEhCcza6zEaQfdrML70WpNtFdASMv8q8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716254648; c=relaxed/simple;
	bh=5+JYFUvq6T+x2e8i7Sndb2q0nVW/NsBAdQpqSvv/fQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NseaTaT0mg7hhUm4J6okjq2gjDnmQh4E77oRuj2MZSBZFVq4p2uEGkyGIrXm/HGG7/kPJi6HqAsQuNgjOJSPVsj/WPyD5/uczcHhmBinmuGY2tDkfdFcyGzOG5nviFywwmw9OGJv0RCXNak2+yl560TwWfQBXTBYhGF0ipq9QbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B4phpxJ8; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716254645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4hKhSDMB4GzbL5k8YczpW/62xlwUobg16CbIRdw5c8=;
	b=B4phpxJ8rKEXwq9unPBdWmTf7cxy81dn+vry5gB5Ehb0Gu09WlPCmE+P2se6oKjou8VTJM
	UztBSDqzdO4y5dFV3YU3F51InkJfVP2tYt4SEjJJOA4CWa6vnof8d8zmi6Rsoa/4X17OSY
	RPEjHQHWzOiXAiFL1fV8WmDCgb17Q+0=
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
Message-ID: <fcae9370-82ab-4c2f-90f5-e3a704f6d11c@linux.dev>
Date: Mon, 20 May 2024 18:22:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/7] bpf: enable detaching links of struct_ops
 objects.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240510002942.1253354-1-thinker.li@gmail.com>
 <20240510002942.1253354-3-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240510002942.1253354-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/9/24 5:29 PM, Kui-Feng Lee wrote:
> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	struct bpf_struct_ops_map *st_map;
> +	struct bpf_map *map;
> +
> +	mutex_lock(&update_mutex);
> +
> +	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
> +	if (!map) {
> +		mutex_unlock(&update_mutex);
> +		return -EINVAL;
> +	}
> +	st_map = container_of(map, struct bpf_struct_ops_map, map);
> +
> +	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
> +
> +	rcu_assign_pointer(st_link->map, NULL);
> +	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
> +	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
> +	 */
> +	bpf_map_put(&st_map->map);
> +
> +	mutex_unlock(&update_mutex);
> +
> +	return 0;
> +}
> +
>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>   	.dealloc = bpf_struct_ops_map_link_dealloc,
> +	.detach = bpf_struct_ops_map_link_detach,
>   	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>   	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>   	.update_map = bpf_struct_ops_map_link_update,
> @@ -1176,13 +1208,19 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	if (err)
>   		goto err_out;
>   
> +	/* Init link->map before calling reg() in case being detached
> +	 * immediately.
> +	 */

It is not obvious in the patch how this (immediate detach by subsystem after 
reg) may work without race, so I think it is easier to ask.

[ I put back the err_out context at the end ]

> +	RCU_INIT_POINTER(link->map, map);
> +
>   	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
>   	if (err) {
> +		RCU_INIT_POINTER(link->map, NULL);

In the bpf_struct_ops_map_link_detach() above, the update to link->map is 
protected by the update_mutex. Could you explain how the link->map update to 
NULL is safe here without holding the update_mutex?

>   		bpf_link_cleanup(&link_primer);
> +		/* The link has been free by bpf_link_cleanup() */
>   		link = NULL;
>   		goto err_out;
>   	}
> -	RCU_INIT_POINTER(link->map, map);
>   
>   	return bpf_link_settle(&link_primer);
>

err_out:
	bpf_map_put(map);
	kfree(link);
	return err;
}



