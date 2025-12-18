Return-Path: <bpf+bounces-76955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B96CCA015
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 02:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2FC6301D65E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D126CE2F;
	Thu, 18 Dec 2025 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdxJLF3C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213583C2F;
	Thu, 18 Dec 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022498; cv=none; b=bD76rztQ3ky9NEJzyUMdTVLbLcfsFvGIF2b9wpYn4Os0qjGWbAjljPYVR39kjq6JXfrdCEu1HpwhPixcxuAmEmv04h8qc5aViPHoX199Wqdx+sm5buYHyp0t6FY0i/MxkYirkrQ7TcxwxNUC8jVw24RQo/spcdvTUUSNGrT1zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022498; c=relaxed/simple;
	bh=dQlBuB3KnyMoKeAYJ0vjAIrQK6ORdk+MFt6eBG/8Btg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtKpIJVk4q1abyTySAscRuKqnCnLIsglTQ6O0ViasfBlM+EMJkp5x5THCmv056OsrHUthr18mrngqZ6KslMANYKoZ8+iuSeG7htUsBFAkXEHL1rYwa47O7U1/QheAKC8Z01VDfG1wm6FOfydLO4V2JerE63OdY3te6HYSmURar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdxJLF3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324F6C4CEF5;
	Thu, 18 Dec 2025 01:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766022497;
	bh=dQlBuB3KnyMoKeAYJ0vjAIrQK6ORdk+MFt6eBG/8Btg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdxJLF3CukKnvJa2ypw7qV5usHJoBdKs7WGFk2LjAAUOVNYhDyZdXuftwp3XBJKDA
	 8F8zhdWarRMtr2qax8/EoTFH8U2t/Otkqesr9ld9RChHJZc6CbiJQm2/uOE2DHpDRj
	 AH8t+IswcNb98bAmui+BVD9WD5LeyeYkI4zpLP5tN/90wTXUvFRVLpn/w8Faffs+bv
	 toLDtCCwuTb9r9I/Pq9ZIemp5VBWw3N/reR1+rG+2YsoIaXG33sPUf9TpIToS9cgph
	 J8ALVsLj1LBDtOiDXpcjSxCZ4ibTyylPLmrBzBrFfftd+Pk/2575dO7JTNUMB5Qrp1
	 MElyM7Jle3vLg==
Date: Wed, 17 Dec 2025 20:48:14 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 5/9] ftrace: Add update_ftrace_direct_del
 function
Message-ID: <20251217204814.38756224@robin>
In-Reply-To: <20251215211402.353056-6-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-6-jolsa@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 22:13:58 +0100
Jiri Olsa <jolsa@kernel.org> wrote:
> +/**
> + * hash_sub - substracts @b from @a and returns the result
> + * @a: struct ftrace_hash object
> + * @b: struct ftrace_hash object
> + *
> + * Returns struct ftrace_hash object on success, NULL on error.
> + */
> +static struct ftrace_hash *hash_sub(struct ftrace_hash *a, struct ftrace_hash *b)
> +{
> +	struct ftrace_func_entry *entry, *del;
> +	struct ftrace_hash *sub;
> +	int size, i;
> +
> +	sub = alloc_and_copy_ftrace_hash(a->size_bits, a);
> +	if (!sub)
> +		goto error;

Again, this can be just return NULL;

> +
> +	size = 1 << b->size_bits;
> +	for (i = 0; i < size; i++) {

You can make this for (int i = 0; ...) too.

> +		hlist_for_each_entry(entry, &b->buckets[i], hlist) {
> +			del = __ftrace_lookup_ip(sub, entry->ip);
> +			if (WARN_ON_ONCE(!del))
> +				goto error;

And you can remove the error label here too:

			if (WARN_ON_ONCE(!del)) {
				free_ftrace_hash(sub);
				return NULL;
			}


> +			remove_hash_entry(sub, del);
> +			kfree(del);
> +		}
> +	}
> +	return sub;
> +
> + error:
> +	free_ftrace_hash(sub);
> +	return NULL;
> +}
> +
> +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> +{
> +	struct ftrace_hash *old_direct_functions = NULL, *new_direct_functions;
> +	struct ftrace_hash *old_filter_hash, *new_filter_hash = NULL;
> +	struct ftrace_func_entry *del, *entry;

One variable per line.

> +	unsigned long size, i;
> +	int err = -EINVAL;
> +
> +	if (!hash_count(hash))
> +		return -EINVAL;
> +	if (check_direct_multi(ops))
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return -EINVAL;
> +	if (direct_functions == EMPTY_HASH)
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +
> +	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> +
> +	if (!hash_count(old_filter_hash))
> +		goto out_unlock;
> +
> +	/* Make sure requested entries are already registered. */
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {

	for (int i = 0; ...) 

-- Steve

> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> +			if (!del || del->direct != entry->direct)
> +				goto out_unlock;
> +		}
> +	}
> +
> +	err = -ENOMEM;
> +	new_filter_hash = hash_sub(old_filter_hash, hash);
> +	if (!new_filter_hash)
> +		goto out_unlock;
> +
> +	new_direct_functions = hash_sub(direct_functions, hash);
> +	if (!new_direct_functions)
> +		goto out_unlock;
> +
> +	/* If there's nothing left, we need to unregister the ops. */
> +	if (ftrace_hash_empty(new_filter_hash)) {
> +		err = unregister_ftrace_function(ops);
> +		if (!err) {
> +			/* cleanup for possible another register call */
> +			ops->func = NULL;
> +			ops->trampoline = 0;
> +			ftrace_free_filter(ops);
> +			ops->func_hash->filter_hash = NULL;
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
> +		/* free the new_direct_functions */
> +		old_direct_functions = new_direct_functions;
> +	} else {
> +		rcu_assign_pointer(direct_functions, new_direct_functions);
> +	}
> +
> + out_unlock:
> +	mutex_unlock(&direct_mutex);
> +
> +	if (old_direct_functions && old_direct_functions != EMPTY_HASH)
> +		call_rcu_tasks(&old_direct_functions->rcu, register_ftrace_direct_cb);
> +	free_ftrace_hash(new_filter_hash);
> +
> +	return err;
> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**


