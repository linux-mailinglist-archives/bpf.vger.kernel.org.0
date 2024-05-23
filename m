Return-Path: <bpf+bounces-30423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E68CD9B1
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 20:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02580282709
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F136B17;
	Thu, 23 May 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KECJ8dpf"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D09537FF
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487794; cv=none; b=pQI6lsvNW73eFdnKRjCI514MwTHSqBf1H1h+bdNiYhdsBU1w+/pLUOrSerAQfosqy8vj+9CGMAVzLmVtmzKokopO+a2QfdMzefxD+ubYS6a+HCBncTOv5BHfnokEuhg1qvz1YPfdseupJdXgvIyZyS8cJCFvd/QLkbk/IWe+p1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487794; c=relaxed/simple;
	bh=fx7c/uIrebsEUNN0jqxoqKKb9qWdx9BGKGAsdA1rQ28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8dp09u+WMggo+SoOo7oycZa3D3sFqxTjynMlA7zP6QRymRfeg+9un367kEz+anFawTJnyaWyUJLBu4uLvzeTjFUR1eo/2ffDlj4sxXpT32v9OGhib/TdaNpMT9KYv+FYEnIKyGUVZ6V2ME1bwxVj8pLMK7SVGNx85DrwZ0N8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KECJ8dpf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716487789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYPwczL09IvGUMXox487Rmbi/l1CYXVVss6pxvrqyBQ=;
	b=KECJ8dpfIxDtZBHSpEIwtZoQQIjGWzvKAdGVrKeTaOMAW0pVyrB9DNFcfyrmOm51q04pT1
	+7qmGceziYRcQtzDwJzlYi5+08Pk5v+gSQ6aBjooWnI3AB/POEXQ+mkYZYCWhHvwQjQVeF
	gi0DMk5Hb7UVUKPGywwLjaShLGiM85I=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
Message-ID: <025ebd13-fcd1-4abe-b5c1-d845c057200d@linux.dev>
Date: Thu, 23 May 2024 11:09:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/7] bpf: enable detaching links of struct_ops
 objects.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240521225121.770930-1-thinker.li@gmail.com>
 <20240521225121.770930-3-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240521225121.770930-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
> Implement the detach callback in bpf_link_ops for struct_ops so that user
> programs can detach a struct_ops link. The subsystems that struct_ops
> objects are registered to can also use this callback to detach the links
> being passed to them.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 63 +++++++++++++++++++++++++++++++++----
>   1 file changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 1542dded7489..fb6e8a3190ef 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1057,9 +1057,6 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>   	st_map = (struct bpf_struct_ops_map *)
>   		rcu_dereference_protected(st_link->map, true);
>   	if (st_map) {
> -		/* st_link->map can be NULL if
> -		 * bpf_struct_ops_link_create() fails to register.
> -		 */
>   		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>   		bpf_map_put(&st_map->map);
>   	}
> @@ -1075,7 +1072,8 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
>   	st_link = container_of(link, struct bpf_struct_ops_link, link);
>   	rcu_read_lock();
>   	map = rcu_dereference(st_link->map);
> -	seq_printf(seq, "map_id:\t%d\n", map->id);
> +	if (map)
> +		seq_printf(seq, "map_id:\t%d\n", map->id);
>   	rcu_read_unlock();
>   }
>   
> @@ -1088,7 +1086,8 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>   	st_link = container_of(link, struct bpf_struct_ops_link, link);
>   	rcu_read_lock();
>   	map = rcu_dereference(st_link->map);
> -	info->struct_ops.map_id = map->id;
> +	if (map)
> +		info->struct_ops.map_id = map->id;
>   	rcu_read_unlock();
>   	return 0;
>   }
> @@ -1113,6 +1112,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   	mutex_lock(&update_mutex);
>   
>   	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
> +	if (!old_map) {
> +		err = -EINVAL;

Just noticed this while checking the return value in patch 3.

This should be -ENOLINK such that it is consistent to the other links' 
.update_prog (e.g. cgroup, tcx, net_namespace...).

> +		goto err_out;
> +	}
>   	if (expected_old_map && old_map != expected_old_map) {
>   		err = -EPERM;
>   		goto err_out;
> @@ -1139,8 +1142,37 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   	return err;
>   }
>   
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

Same here but should be always 0 (detach always succeeds).

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
> @@ -1176,13 +1208,32 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	if (err)
>   		goto err_out;
>   
> +	/* Init link->map before calling reg() in case being detached
> +	 * immediately.
> +	 */
> +	RCU_INIT_POINTER(link->map, map);
> +
> +	/* Once reg() is called, the object and link is already available
> +	 * to the subsystem, and it can call
> +	 * bpf_struct_ops_map_link_detach() to unreg() it. However, it is
> +	 * sfae not holding update_mutex here.
> +	 *
> +	 * In the case of failure in reg(), the subsystem has no reason to
> +	 * call bpf_struct_ops_map_link_detach() since the object is not
> +	 * accepted by it. In the case of success, the subsystem may call
> +	 * bpf_struct_ops_map_link_detach() to unreg() it, but we don't
> +	 * change the content of the link anymore except changing link->id
> +	 * in bpf_link_settle(). So, it is safe to not hold update_mutex
> +	 * here.

After sleeping on the RCU_INIT_POINTER dance and re-reading this comment, I need 
to walk back my early reply.

Instead of having comment to explain the RCU_INIT_POINTER dance (resetting it to 
NULL on reg() err because bpf_struct_ops_map_link_dealloc is not supposed to 
unreg when the reg did fail), how about simplifying it and just take the 
update_mutex here such that the subsystem cannot detach until the 
RCU_INIT_POINTER(link->map, map) is done. Performance is not a concern here, so 
I would prefer simplicity.

> +	 */
>   	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
>   	if (err) {
> +		RCU_INIT_POINTER(link->map, NULL);
>   		bpf_link_cleanup(&link_primer);
> +		/* The link has been free by bpf_link_cleanup() */
>   		link = NULL;
>   		goto err_out;
>   	}
> -	RCU_INIT_POINTER(link->map, map);
>   
>   	return bpf_link_settle(&link_primer);
>   


