Return-Path: <bpf+bounces-76996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA362CCC7F5
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282EB310B907
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388DE34DB43;
	Thu, 18 Dec 2025 15:18:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51234CFDB;
	Thu, 18 Dec 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071094; cv=none; b=s/c4SKNgu+ryeY4dokrEosj9ldt0ltUEy9hqFrwymY1nviE6CyvFF2NY23rUK+rU0vO9pCuhxe00O4i5+fv6cWz6Md1M/hJvDCQuQ1gk9R4U0n6wFr1LLabZxcm0wizt2+jsq9ZIpcjWsV8//L9wECCtPhcE/pRKwBCLc/gVnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071094; c=relaxed/simple;
	bh=5mRUAGVgIej87qg9kGbMLQqMWji+/g68YRxTl/i7zuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdcXvygOzVAGNnBN1oWqeS0VPIvadlG19AzCLj41LODWtpKpWqhr5q5bzUZSUeLkmxDbp26rfeSoeB8iFDEz3zkig3GejOMBYqpQ26syQtpYJoWJO159q5prgMs+PrQAcfsGnJW4VBbSvCLhTaUIL6Xysc8MLyJDxCUYIXL7qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 698F512E4C;
	Thu, 18 Dec 2025 15:18:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id ABF8A6000C;
	Thu, 18 Dec 2025 15:18:04 +0000 (UTC)
Date: Thu, 18 Dec 2025 10:19:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu
 <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/9] ftrace: Add update_ftrace_direct_mod
 function
Message-ID: <20251218101942.0716efd6@gandalf.local.home>
In-Reply-To: <20251215211402.353056-7-jolsa@kernel.org>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-7-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: ABF8A6000C
X-Stat-Signature: 7stoz3y9s7gbc4gkicouzdj7p4f5jkai
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Tawb5aeJtZNDj3eiQyPJECxVNSgJGjLo=
X-HE-Tag: 1766071084-610297
X-HE-Meta: U2FsdGVkX1+XAMvJSK/Fo4/cUd56YAbeR4EMtxvTGxe6O5eiPBzwZZQW8AjtW8GvcqRXaAi4Xg0Dfvb0qmXfsZLi2ZL09yQG6rNuFLlECwO2WvT+949txinB85A5fYnB02qTqj7gtGAxxhgGPNrqLC9pyVnRe33f2Rk/S9T02jpAO7kSFrZ8DDy98lJe1FxTGRbWK8qJAV7KjclFuPIKC3I/4QM2Re8ZpHqBQRF7CT9qYdlEEZFjrYgjNEZdGEQrSeP36Bm9+ENQRURwkY1X6RLmM5CeZwCBC3eFkBqHvp8NBDWiEu8ngW5hNYYU4tHuxg2zp3RSXNQ7DBGBfQihaUSvhWpda+YW

On Mon, 15 Dec 2025 22:13:59 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 48dc0de5f2ce..95a38fb18ed7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6489,6 +6489,78 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  	return err;
>  }
>  

Kerneldoc needed.

> +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> +{
> +	struct ftrace_func_entry *entry, *tmp;
> +	static struct ftrace_ops tmp_ops = {
> +		.func		= ftrace_stub,
> +		.flags		= FTRACE_OPS_FL_STUB,
> +	};
> +	struct ftrace_hash *orig_hash;
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
> +	if (do_direct_lock)
> +		mutex_lock(&direct_mutex);

This optional taking of the direct_mutex lock needs some serious rationale
and documentation.

> +
> +	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> +	if (!orig_hash)
> +		goto unlock;
> +
> +	/* Enable the tmp_ops to have the same functions as the direct ops */
> +	ftrace_ops_init(&tmp_ops);
> +	tmp_ops.func_hash = ops->func_hash;
> +
> +	err = register_ftrace_function_nolock(&tmp_ops);
> +	if (err)
> +		goto unlock;
> +
> +	/*
> +	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
> +	 * ops->ops_func for the ops. This is needed because the above
> +	 * register_ftrace_function_nolock() worked on tmp_ops.
> +	 */
> +	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
> +	if (err)
> +		goto out;
> +
> +	/*
> +	 * Now the ftrace_ops_list_func() is called to do the direct callers.
> +	 * We can safely change the direct functions attached to each entry.
> +	 */
> +	mutex_lock(&ftrace_lock);

I'm going to need some time staring at this code. It looks like it may be
relying on some internals here.

-- Steve


> +
> +	size = 1 << hash->size_bits;
> +	for (i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			tmp = __ftrace_lookup_ip(direct_functions, entry->ip);
> +			if (!tmp)
> +				continue;
> +			tmp->direct = entry->direct;
> +		}
> +	}
> +
> +	mutex_unlock(&ftrace_lock);
> +
> +out:
> +	/* Removing the tmp_ops will add the updated direct callers to the functions */
> +	unregister_ftrace_function(&tmp_ops);
> +
> +unlock:
> +	if (do_direct_lock)
> +		mutex_unlock(&direct_mutex);
> +	return err;
> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**


