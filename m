Return-Path: <bpf+bounces-29141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE48C079D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 01:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875DD1C21292
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259C27D3FB;
	Wed,  8 May 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rB9SX4C0"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C714502D
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210539; cv=none; b=jOcw5HcCxCzoqXGAeR156EjeN05LXTE7HOYRHD/rYOhv/rBqKN7wZGuYEBZxXLIjwmhC51+Rd0g0vHWbCIaA4Xp53fBqSIixIXVKpcbAy0tRRiVBDGh+GWjYp1r8Y7qFLX8sAfyntjnkG8NsT87Bn+MFylzHaOOWMJcGK9TqSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210539; c=relaxed/simple;
	bh=CphiwXIFJbpOJXbVasm8KXSEAoOjUzfyLKi9Ohk0AHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+HpsT7+JZdy5GYg9JxA5mQOwUsptD4wvJXOMti0trn/j7IRhTKa+cNLIkesAvmEiKbWtvIf0NeSFLJyTreJ21UbWpTSg/UZ4Aixlwk8ADFwgWSrsdMYyqyOpktDrEn20n9cUPaugGv4GwVZC3CqJN+DjoAUwTG9Mo24lrk3OKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rB9SX4C0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88fdd488-f548-4ed4-8afa-ab6a8af974e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715210535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpbvMxJWWDvXeSnTatjqnDO5UkYHc+yMgZCcRc9VTJM=;
	b=rB9SX4C0uUhVTLDEy+Brp246BrLGdv3Ov9ZsZ/hBUPP0TsUgI8mcxja8gTyOLTzTnta3l0
	fnnq0NKo7Ibeg3gZ4RIodEDNQD65AdsBPrfg+CMcUC8QkPMqUTo9JVCrwbuCPL5Qj1KXx6
	D7GGHPJbgeAkYkW/X9C7AMZLPpRAghA=
Date: Wed, 8 May 2024 16:22:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: enable detaching links of struct_ops
 objects.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240507055600.2382627-1-thinker.li@gmail.com>
 <20240507055600.2382627-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240507055600.2382627-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 10:55 PM, Kui-Feng Lee wrote:
> Implement the detach callback in bpf_link_ops for struct_ops. The
> subsystems that struct_ops objects are registered to can use this callback
> to detach the links being passed to them.

The user space can also use the detach. The subsystem is merely reusing the 
similar detach callback if it stores the link during reg().

> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 50 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 390f8c155135..bd2602982e4d 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1057,9 +1057,6 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>   	st_map = (struct bpf_struct_ops_map *)
>   		rcu_dereference_protected(st_link->map, true);
>   	if (st_map) {
> -		/* st_link->map can be NULL if
> -		 * bpf_struct_ops_link_create() fails to register.
> -		 */
>   		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, st_link);
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
> +	map = rcu_dereference_protected(st_link->map, true);

nit. s/true/lockdep_is_held(&update_mutex)/

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
> +	RCU_INIT_POINTER(link->map, map);
> +
>   	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
>   	if (err) {
> +		rcu_assign_pointer(link->map, NULL);

nit. RCU_INIT_POINTER(link->map, NULL) is fine.

There is a merge conflict with patch 4 also.

pw-bot: cr

>   		bpf_link_cleanup(&link_primer);
> +		/* The link has been free by bpf_link_cleanup() */
>   		link = NULL;
>   		goto err_out;
>   	}
> -	RCU_INIT_POINTER(link->map, map);
>   
>   	return bpf_link_settle(&link_primer);
>   


