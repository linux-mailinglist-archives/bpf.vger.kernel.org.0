Return-Path: <bpf+bounces-76998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2530CCCC84C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 16:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2C27302425F
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1F3570CC;
	Thu, 18 Dec 2025 15:40:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224F357719;
	Thu, 18 Dec 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072401; cv=none; b=WOpqFvxjoRhrjqdfNJOlNB9EYygkxJDeHZga3Td3MMZt6wOqFFzEDAiIsl1rb0kZMkiZgoQQdaywqPS/0stAeT5RfanvIhWoVcMDgCiuisr6TFIHfHnPVVjSyi+vWhJffVYDH7FcLt4l7FhfBCKxzzshQRIyt+YqNXTW/ZivLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072401; c=relaxed/simple;
	bh=4XQw+STsrMN9eUhH3fzOAd2bq6FCEKqXxK0hHCazLDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HE4Vz4CqtsMcftgdHyRcxODG4I0+6vOLYTGJmK7tZjPB6SlSd024dVrZGd/mLQV6NdsMiYXQm2Y26qvaGeerVYGQ81h1Tfjb2TCXHtaeNepp9F5zTcq4uLWzMqfFO0PWItMxBK2vEwdYBliRHwHWSW+fUMfioZF+YEQA5+txU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9F49FB7460;
	Thu, 18 Dec 2025 15:39:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id CA3EF20030;
	Thu, 18 Dec 2025 15:39:40 +0000 (UTC)
Date: Thu, 18 Dec 2025 10:41:19 -0500
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
Message-ID: <20251218104119.311adc09@gandalf.local.home>
In-Reply-To: <20251218101942.0716efd6@gandalf.local.home>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-7-jolsa@kernel.org>
	<20251218101942.0716efd6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hyd7obcpethh7mbhynnfm913gwqf8351
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: CA3EF20030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19eMCvXLU/iy0pusX2AKTnSYMMq1qf40Gk=
X-HE-Tag: 1766072380-414909
X-HE-Meta: U2FsdGVkX1+qdFcnlxLPjXd3JW5Y/+0pKI0xTsAa/MHRhpHeNLBsPBRNCg+H723yVJ7NpyItko3gA2wj68SbZ+IIIPUnbgTsdXjs+Y7PsDCRAayGAvC07jcanonG5k/BqdK2mbkU6RW8quT4XG7lqEfa98717k59hUZx32RtbzwjJLWsT0COfK8CsxpWJ2i7qTsGKFwc27rM+cxfZS2ACZcTOBxcMJUO9UvJAddUjNXIjaePm+BcK9QaQk3KbmwUsEI8fbn3U7zMbyKF9fgl4qlXKekB4zCTfeTaOyO+N0wSbKub9HEdfqIh7n2Rt+eDv1pVRsL3czVsAhAgxXdwoUGgqBNDD21y8PlfQw1KcVe811+P9vQO7XHGsfDoJhMh6/twovBHduGQCg1ab28PDA==

On Thu, 18 Dec 2025 10:19:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 15 Dec 2025 22:13:59 +0100
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 48dc0de5f2ce..95a38fb18ed7 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6489,6 +6489,78 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return err;
> >  }
> >    
> 
> Kerneldoc needed.
> 
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> > +{
> > +	struct ftrace_func_entry *entry, *tmp;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> > +	struct ftrace_hash *orig_hash;
> > +	unsigned long size, i;
> > +	int err = -EINVAL;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	if (do_direct_lock)
> > +		mutex_lock(&direct_mutex);  
> 
> This optional taking of the direct_mutex lock needs some serious rationale
> and documentation.
> 
> > +
> > +	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> > +	if (!orig_hash)
> > +		goto unlock;
> > +
> > +	/* Enable the tmp_ops to have the same functions as the direct ops */

Add to the comments here:

	 * In order to modify the direct callers, all the functions need to
	 * first be calling the ftrace_ops_list_func() and not be connected
	 * to any direct callers. To do that, create a temporary ops that
	 * attach to the same functions as the direct ops, and attach that
	 * first. Then when adding the direct ops, it will use the
	 * ftrace_ops_list_func(), and this can safely modify what the
	 * direct ops call.

Or something like that. I want this code to be as clear as day to what it
is doing. In a year or two, we will forget, and this will be very confusing
to newcomers.

> > +	ftrace_ops_init(&tmp_ops);
> > +	tmp_ops.func_hash = ops->func_hash;
> > +
> > +	err = register_ftrace_function_nolock(&tmp_ops);
> > +	if (err)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
> > +	 * ops->ops_func for the ops. This is needed because the above
> > +	 * register_ftrace_function_nolock() worked on tmp_ops.
> > +	 */
> > +	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
> > +	if (err)
> > +		goto out;
> > +
> > +	/*
> > +	 * Now the ftrace_ops_list_func() is called to do the direct callers.
> > +	 * We can safely change the direct functions attached to each entry.
> > +	 */
> > +	mutex_lock(&ftrace_lock);  
> 
> I'm going to need some time staring at this code. It looks like it may be
> relying on some internals here.
> 
> -- Steve
> 
> 
> > +

I would add a comment here:

	/* Now update the direct functions to point to the new callbacks */

-- Steve

> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +			tmp = __ftrace_lookup_ip(direct_functions, entry->ip);
> > +			if (!tmp)
> > +				continue;
> > +			tmp->direct = entry->direct;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&ftrace_lock);
> > +
> > +out:
> > +	/* Removing the tmp_ops will add the updated direct callers to the functions */
> > +	unregister_ftrace_function(&tmp_ops);
> > +
> > +unlock:
> > +	if (do_direct_lock)
> > +		mutex_unlock(&direct_mutex);
> > +	return err;
> > +}
> > +
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> >  
> >  /**  


