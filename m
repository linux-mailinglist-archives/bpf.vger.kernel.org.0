Return-Path: <bpf+bounces-28393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085C8B8FDE
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADB51F23E93
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E72A1607A3;
	Wed,  1 May 2024 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dpJHFB2a"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D41805A
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714589327; cv=none; b=cXhOMoALZOPiQ5Z5GhS4U3XnElKPVVDpdRh/r/9M0ddD4zlwJbUOkFmF+lit7gHqSCt7NmB1jfXQ8kaCCt1RnEEU1t7tq1bBN8LiBjRjxV4VgeinRj3Cgo8ar0l4PU/q1YAdZg6uXYB98zYhxif/m10Y7Zh0QZf8sXEjahhQYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714589327; c=relaxed/simple;
	bh=pryWNKEuQOSEI2QQT9FZLNnBc0JdXmWYpNiV/rarrP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPZlP1t0MVzbgLOJ2/rNCrQlaVxkfdKJy4+HcjQT+iM6qYlc9uYYxLNXaMsFnpPcQk63hHJEu82dcpvEBjw7uiMPoCAv6wKliifnU4j7qwebEwryoqV/CHNFIUZ0IOzyCUsAlcJuSg4tsQabnCaC3Lo5Rbk9AFC7V5W6oBeA8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dpJHFB2a; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714589322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kfxrSr/2RBlosvkJWmuLc1Nix4o8FUivsTTndVmVxw=;
	b=dpJHFB2aWNxbRv1ncSVklqUZZEqLLUvE3bUvl9hJwHzJZer3U50npnvVo0b4r/tVMgaE3y
	G7RtuDVa9mWfBSnazhqjRZlFJFw37U9eoqfSkRbSwSppWQU8YFC7grULxMf4/bTn9OtY12
	hbqZ/EZ4xAOmJR906b03NzHFn1VNB5Q=
Date: Wed, 1 May 2024 11:48:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240429213609.487820-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
> +/* Called from the subsystem that consume the struct_ops.
> + *
> + * The caller should protected this function by holding rcu_read_lock() to
> + * ensure "data" is valid. However, this function may unlock rcu
> + * temporarily. The caller should not rely on the preceding rcu_read_lock()
> + * after returning from this function.

This temporarily losing rcu_read_lock protection is error prone. The caller 
should do the inc_not_zero() instead if it is needed.

I feel the approach in patch 1 and 3 is a little box-ed in by the earlier tcp-cc 
usage that tried to fit into the kernel module reg/unreg paradigm and hide as 
much bpf details as possible from tcp-cc. This is not necessarily true now for 
other subsystem which has bpf struct_ops from day one.

The epoll detach notification is link only. Can this kernel side specific unreg 
be limited to struct_ops link only? During reg, a rcu protected link could be 
passed to the subsystem. That subsystem becomes a kernel user of the bpf link 
and it can call link_detach(link) to detach. Pseudo code:

struct link __rcu *link;

rcu_read_lock();
ref_link = rcu_dereference(link)
if (ref_link)
	ref_link = bpf_link_inc_not_zero(ref_link);
rcu_read_unlock();

if (!IS_ERR_OR_NULL(ref_link)) {
	bpf_struct_ops_map_link_detach(ref_link);
	bpf_link_put(ref_link);
}

> + *
> + * Return true if unreg() success. If a call fails, it means some other
> + * task has unrgistered or is unregistering the same object.
> + */
> +bool bpf_struct_ops_kvalue_unreg(void *data)
> +{
> +	struct bpf_struct_ops_map *st_map =
> +		container_of(data, struct bpf_struct_ops_map, kvalue.data);
> +	enum bpf_struct_ops_state prev_state;
> +	struct bpf_struct_ops_link *st_link;
> +	bool ret = false;
> +
> +	/* The st_map and st_link should be protected by rcu_read_lock(),
> +	 * or they may have been free when we try to increase their
> +	 * refcount.
> +	 */
> +	if (IS_ERR(bpf_map_inc_not_zero(&st_map->map)))
> +		/* The map is already gone */
> +		return false;
> +
> +	prev_state = cmpxchg(&st_map->kvalue.common.state,
> +			     BPF_STRUCT_OPS_STATE_INUSE,
> +			     BPF_STRUCT_OPS_STATE_TOBEFREE);
> +	if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
> +		st_map->st_ops_desc->st_ops->unreg(data);
> +		/* Pair with bpf_map_inc() for reg() */
> +		bpf_map_put(&st_map->map);
> +		/* Pair with bpf_map_inc_not_zero() above */
> +		bpf_map_put(&st_map->map);
> +		return true;
> +	}
> +	if (prev_state != BPF_STRUCT_OPS_STATE_READY)
> +		goto fail;
> +
> +	/* With BPF_F_LINK */
> +
> +	st_link = rcu_dereference(st_map->attached);
> +	if (!st_link || !bpf_link_inc_not_zero(&st_link->link))
> +		/* The map is on the way to unregister */
> +		goto fail;
> +
> +	rcu_read_unlock();
> +	mutex_lock(&update_mutex);
> +
> +	if (rcu_dereference_protected(st_link->map, true) != &st_map->map)
> +		/* The map should be unregistered already or on the way to
> +		 * be unregistered.
> +		 */
> +		goto fail_unlock;
> +
> +	st_map->st_ops_desc->st_ops->unreg(data);
> +
> +	map_attached_null(st_map);
> +	rcu_assign_pointer(st_link->map, NULL);
> +	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
> +	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
> +	 */
> +	bpf_map_put(&st_map->map);
> +
> +	ret = true;
> +
> +fail_unlock:
> +	mutex_unlock(&update_mutex);
> +	rcu_read_lock();
> +	bpf_link_put(&st_link->link);
> +fail:
> +	bpf_map_put(&st_map->map);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(bpf_struct_ops_kvalue_unreg);


