Return-Path: <bpf+bounces-76954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10CCC9FDB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE49301A1FC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FA262FE7;
	Thu, 18 Dec 2025 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mufJ4BCG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DC25A34F;
	Thu, 18 Dec 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021953; cv=none; b=jgxAAxl6cUE5hDcAV8f8ZRwraq5pRl63d/2tw2KXIO8fSc6lQxDNEdq75UDV6jv/SgmpoWYlWKBT+tV10TAW2E+nL2z4BtA79JAqzzl/vBYtLWL2k+1FTQriMBNUVFRTXMLLQ3UOWhEZrzobaiohuXh4NKTipC7Wa8C1aDIC6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021953; c=relaxed/simple;
	bh=oyPUqyvzxAd6qp0fqK19COneEyiAOn13C8hIpgwMOes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8BYIHZQ2/7Z7I4u4tlzSR39617HbSvW6fB8bAPAFB0u13T566r0Ma8L5PGKv5SkaDMrUqsweqhXayG6DjTcgOek0RVPfVxGe/skmVZyxbHoe5i+n0wzyw5qn121Ni3T47XoWBq36DNGWOAdNAwyE/fyLfc6E4rgLZAHcEUgeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mufJ4BCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37BCC4CEF5;
	Thu, 18 Dec 2025 01:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766021953;
	bh=oyPUqyvzxAd6qp0fqK19COneEyiAOn13C8hIpgwMOes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mufJ4BCGTOhbBFReqv9GFo5+wxvsgPlKC2LeW3LoBt/3H7uC7/lMXLk580UhB2vEN
	 qEyiTMQi8m4X1EsDAyF/lrzJF+AIMj18uhwVGW7DUnbJ/y+NUfzoKAUZHHE/KdbZlD
	 0XW0dSheS1xFoR5mVCiWos93QTcx8NOiz58hI2gx/LD4W8w3a9Njt0APJBo2gFKKiD
	 72NA5oesfePNowSTD4VoL8L4kjDvY/Vi3Vw/EWE26HTwaLr4mgZr1BRHuPHRxdyPQB
	 ul2Wz/QXscpYicUfqYPcUZ0CRyJ8Gw61ZNEQHVL/1yL7Gn4yrdUzkQ4hOsVkjYxPjj
	 C2cXPBurDHruw==
Date: Wed, 17 Dec 2025 20:39:09 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 4/9] ftrace: Add update_ftrace_direct_add
 function
Message-ID: <20251217203909.474ae959@robin>
In-Reply-To: <20251215211402.353056-5-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-5-jolsa@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 22:13:57 +0100
Jiri Olsa <jolsa@kernel.org> wrote:


> +/**
> + * hash_add - adds two struct ftrace_hash and returns the result
> + * @a: struct ftrace_hash object
> + * @b: struct ftrace_hash object
> + *
> + * Returns struct ftrace_hash object on success, NULL on error.
> + */
> +static struct ftrace_hash *hash_add(struct ftrace_hash *a, struct ftrace_hash *b)
> +{
> +	struct ftrace_func_entry *entry;
> +	struct ftrace_hash *add;
> +	int size, i;
> +
> +	size = hash_count(a) + hash_count(b);
> +	if (size > 32)
> +		size = 32;
> +
> +	add = alloc_and_copy_ftrace_hash(fls(size), a);
> +	if (!add)
> +		goto error;

You can just return NULL here, as add is NULL.

> +
> +	size = 1 << b->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> +			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL)
> +				goto error;

Could remove the error and have:

			if (add_hash_entry_direct(add, entry->ip, entry->direct) == NULL) {
				free_ftrace_hash(add);
				return NULL;
			}


> +		}
> +	}
> +	return add;
> +
> + error:
> +	free_ftrace_hash(add);
> +	return NULL;
> +}
> +

Non static functions require a kerneldoc header.

> +int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{
> +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions;
> +	struct ftrace_hash *old_filter_hash, *new_filter_hash = NULL;

BTW, I prefer to not double up on variables. That is to have each on
their own lines. Makes it easier to read for me.

> +	struct ftrace_func_entry *entry;
> +	int i, size, err = -EINVAL;

Even here.

> +	bool reg;
> +
> +	if (!hash_count(hash))
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +
> +	/* Make sure requested entries are not already registered. */
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {

If you want, you can remove the i declaration and use for(int i = 0; ... here.

> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			if (__ftrace_lookup_ip(direct_functions, entry->ip))
> +				goto out_unlock;
> +		}
> +	}
> +
> +	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> +
> +	/* If there's nothing in filter_hash we need to register the ops. */
> +	reg = hash_count(old_filter_hash) == 0;
> +	if (reg) {
> +		if (ops->func || ops->trampoline)
> +			goto out_unlock;
> +		if (ops->flags & FTRACE_OPS_FL_ENABLED)
> +			goto out_unlock;
> +	}
> +
> +	err = -ENOMEM;
> +	new_filter_hash = hash_add(old_filter_hash, hash);
> +	if (!new_filter_hash)
> +		goto out_unlock;
> +
> +	new_direct_functions = hash_add(direct_functions, hash);
> +	if (!new_direct_functions)
> +		goto out_unlock;
> +
> +	old_direct_functions = direct_functions;
> +	rcu_assign_pointer(direct_functions, new_direct_functions);
> +
> +	if (reg) {
> +		ops->func = call_direct_funcs;
> +		ops->flags |= MULTI_FLAGS;
> +		ops->trampoline = FTRACE_REGS_ADDR;
> +		ops->local_hash.filter_hash = new_filter_hash;
> +
> +		err = register_ftrace_function_nolock(ops);
> +		if (err) {
> +			/* restore old filter on error */
> +			ops->local_hash.filter_hash = old_filter_hash;
> +
> +			/* cleanup for possible another register call */
> +			ops->func = NULL;
> +			ops->trampoline = 0;
> +		} else {
> +			new_filter_hash = old_filter_hash;
> +		}
> +	} else {
> +		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> +		/*
> +		 * new_filter_hash is dup-ed, so we need to release it anyway,
> +		 * old_filter_hash either stays on error or is already released
> +		 */
> +	}
> +
> +	if (err) {
> +		/* reset direct_functions and free the new one */
> +		rcu_assign_pointer(direct_functions, old_direct_functions);
> +		old_direct_functions = new_direct_functions;
> +	}
> +
> + out_unlock:
> +	mutex_unlock(&direct_mutex);
> +
> +	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
> +		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
> +	if (new_filter_hash)

free_ftrace_hash() checks for NULL, so you don't need the above if statement.

> +		free_ftrace_hash(new_filter_hash);
> +
> +	return err;

-- Steve

> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**


