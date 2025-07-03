Return-Path: <bpf+bounces-62298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1602CAF7C60
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E8A17AA70
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626022EE97A;
	Thu,  3 Jul 2025 15:30:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6510224882;
	Thu,  3 Jul 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556615; cv=none; b=XEZTyaqj2Tx96dUCm6sua2v7lOuU++z6DZGHQ+D5g7GDmcHWu1WJP1fyvnsfAfViUO7dj3uyRz/zeD6pB8xyTA+RZuMuLyjzyrTUiCwyNnA7ycV+G0sXdxcqnRiOe2U5BUfWw2Y05WfhhIRVxX0gmVxihzOQMiJUZReIsQeMLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556615; c=relaxed/simple;
	bh=Midkn1Xwtp4OL+Lym1QanU5upXg6cal2GSP4RDHTegU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXkddZWieSJhn5calxt7JPgTyI3KODD5+bjKwA8U94pUm230jzQJA889IXGwqsZqFvcWyKIlhFLqLtWTtCc7D7wxGBtb9TmC5TvX2hst+2Rxr3erpnI19cOayHvhFfgA763NO4N+TC+uWS+FEwHCnGCX1w41D7ZEF2OCd6EPSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 6557416027E;
	Thu,  3 Jul 2025 15:30:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id CD5243B;
	Thu,  3 Jul 2025 15:30:02 +0000 (UTC)
Date: Thu, 3 Jul 2025 11:30:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 04/18] ftrace: add reset_ftrace_direct_ips
Message-ID: <20250703113001.099dc88f@batman.local.home>
In-Reply-To: <20250703121521.1874196-5-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
	<20250703121521.1874196-5-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yu9k4juoddbxh539wfecre1dnfmdgbzk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CD5243B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/x9+2Gkl0bLv99oqhAlyDopYKg4Dbgx6k=
X-HE-Tag: 1751556602-956081
X-HE-Meta: U2FsdGVkX19dPdUqBcQIwd55zOtqPhMAfP9K1ZUY4b6lHAd3pwk0Iy1sV1K/m/r1wORmWx3jBgV8J/4Ct+MnvvnN5XhCNEJIYkyPwAzgUtq5IXE7gU5cwxmgBo5b4k2TPmeAX/M750OVZjcKnnfqygvXP3iHuhYyxljycr/0ef/KceelGDbznfr+ng1MWmUpEAOCr0egjhf139Qw6+lx3mDRdZ2qlgd3H1NxPsWTlaqdoKLQXdOWx+RufD85szWqhnoIC5BbBzCUofZT2UGLnKKPBd/v96I67YhV22oJdkG0vH2ukV3muvmex2RJ5Az8iyGMu4IXv/oddVOk/BDxv1AFqbzAZTlh

On Thu,  3 Jul 2025 20:15:07 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

Note, the tracing subsystem uses capitalization in the subject:

  ftrace: Add reset_ftrace_direct_ips


> For now, we can change the address of a direct ftrace_ops with
> modify_ftrace_direct(). However, we can't change the functions to filter
> for a direct ftrace_ops. Therefore, we introduce the function
> reset_ftrace_direct_ips() to do such things, and this function will reset
> the functions to filter for a direct ftrace_ops.
> 
> This function do such thing in following steps:
> 
> 1. filter out the new functions from ips that don't exist in the
>    ops->func_hash->filter_hash and add them to the new hash.
> 2. add all the functions in the new ftrace_hash to direct_functions by
>    ftrace_direct_update().
> 3. reset the functions to filter of the ftrace_ops to the ips with
>    ftrace_set_filter_ips().
> 4. remove the functions that in the old ftrace_hash, but not in the new
>    ftrace_hash from direct_functions.

Please also include a module that can be loaded for testing.
See samples/ftrace/ftrace-direct*

But make it a separate patch. And you'll need to add a test in selftests.
See tools/testing/selftests/ftrace/test.d/direct

> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/ftrace.h |  7 ++++
>  kernel/trace/ftrace.c  | 75 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index b672ca15f265..b7c60f5a4120 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -528,6 +528,8 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
>  
>  void ftrace_stub_direct_tramp(void);
>  
> +int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
> +			    unsigned int cnt);
>  #else
>  struct ftrace_ops;
>  static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
> @@ -551,6 +553,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
>  {
>  	return -ENODEV;
>  }
> +static inline int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
> +					  unsigned int cnt)
> +{
> +	return -ENODEV;
> +}
>  
>  /*
>   * This must be implemented by the architecture.
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f5f6d7bc26f0..db3aa61889d3 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6224,6 +6224,81 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(modify_ftrace_direct);
> +
> +/* reset the ips for a direct ftrace (add or remove) */

As this function is being used externally, it requires proper KernelDoc
headers.

What exactly do you mean by "reset"?

> +int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
> +			    unsigned int cnt)
> +{
> +	struct ftrace_hash *hash, *free_hash;
> +	struct ftrace_func_entry *entry, *del;
> +	unsigned long ip;
> +	int err, size;
> +
> +	if (check_direct_multi(ops))
> +		return -EINVAL;
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> +		return -EINVAL;
> +
> +	mutex_lock(&direct_mutex);
> +	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> +	if (!hash) {
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	/* find out the new functions from ips and add to hash */

Capitalize comment: /* Find out ...

> +	for (int i = 0; i < cnt; i++) {
> +		ip = ftrace_location(ips[i]);
> +		if (!ip) {
> +			err = -ENOENT;
> +			goto out_unlock;
> +		}
> +		if (__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
> +			continue;
> +		err = __ftrace_match_addr(hash, ip, 0);
> +		if (err)
> +			goto out_unlock;
> +	}
> +
> +	free_hash = direct_functions;

Add newline.

> +	/* add the new ips to direct hash. */

Again capitalize.

> +	err = ftrace_direct_update(hash, ops->direct_call);
> +	if (err)
> +		goto out_unlock;
> +
> +	if (free_hash && free_hash != EMPTY_HASH)
> +		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);

Since the above is now used more than once, let's make it into a helper
function so that if things change, there's only one place to change it:

	free_ftrace_direct(free_hash);

static inline void free_ftrace_direct(struct ftrace_hash *hash)
{
	if (hash && hash != EMPTY_HASH)
		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
}

> +
> +	free_ftrace_hash(hash);
> +	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS,
> +					  ops->func_hash->filter_hash);
> +	if (!hash) {
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +	err = ftrace_set_filter_ips(ops, ips, cnt, 0, 1);
> +
> +	/* remove the entries that don't exist in our filter_hash anymore
> +	 * from the direct_functions.
> +	 */

This isn't the network subsystem, we use the default comment style for multiple lines:

/*
 * line 1
 * line 2
 * ...
 */

-- Steve

> +	size = 1 << hash->size_bits;
> +	for (int i = 0; i < size; i++) {
> +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> +			if (__ftrace_lookup_ip(ops->func_hash->filter_hash, entry->ip))
> +				continue;
> +			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> +			if (del && del->direct == ops->direct_call) {
> +				remove_hash_entry(direct_functions, del);
> +				kfree(del);
> +			}
> +		}
> +	}
> +out_unlock:
> +	mutex_unlock(&direct_mutex);
> +	if (hash)
> +		free_ftrace_hash(hash);
> +	return err;
> +}
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
>  
>  /**


