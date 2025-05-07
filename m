Return-Path: <bpf+bounces-57658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BFAADFFC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50ACE1C03523
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300A1D5CD4;
	Wed,  7 May 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5bHeXDW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXfX7Fjc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5bHeXDW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXfX7Fjc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDDBA34
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622929; cv=none; b=j3oBGna0QsRR0aYB5xDD37pqR7L10+lP0c4lwWOjQ0iSU9oxt1td8EGEYrWeSU8Nciw9a7A/EkVthFD8s7RLQMV8YGMloH2WYfR2ARLDGYggyN7vWEWS+TSCJKj1qAPbPce9veFZlmcwyHoRk1HVFxRgjaYX2PXeoiz/2gXx9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622929; c=relaxed/simple;
	bh=Suk5ywM8pKmpgd48J/aGB5TNN0oigi8WDh1FyejKaHE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YUrtjAU/CHPTvxLOTp017wcXIxUJpUlF+3eX+i5R5ALZvuXQuO8QCYJ9rECkGAXu/VCOS6gFwtRUrrpnML8wsyaa03yVff8cqfaGT+dOjnNAR//f5PNaFJkft62E/UW+p7B506NZzJ+6SVHD8kGidVIr2PMHWcOP52g2j+pioog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5bHeXDW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXfX7Fjc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5bHeXDW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXfX7Fjc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0394D1F441;
	Wed,  7 May 2025 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746622925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9tESCeBbULja3MOUysra++fStjGsyG4dYt4IVq2Mio=;
	b=f5bHeXDWyMTl8DDt5IWzt3+ZnNpMLCBSDGvwSiGwfkRy2wi6r/OODHanl650INna3IYpW8
	7GO2jMpqweFk63WwxpsW0jqXXxqNdXYQwNecFc74wkUIt5SngMN+GZ9Crlx6gfDi2jM4O2
	gYD/A+Ex6UHpZn3YP5HPw7yXH2BagJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746622925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9tESCeBbULja3MOUysra++fStjGsyG4dYt4IVq2Mio=;
	b=jXfX7FjceKQLA4qJf9VbS1Mx5xED8A4g91rZI+iyghZmmbSBK5UV7GRoXWNPKIcRajj0jx
	i/Te8EZIOR7P1NDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f5bHeXDW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jXfX7Fjc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746622925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9tESCeBbULja3MOUysra++fStjGsyG4dYt4IVq2Mio=;
	b=f5bHeXDWyMTl8DDt5IWzt3+ZnNpMLCBSDGvwSiGwfkRy2wi6r/OODHanl650INna3IYpW8
	7GO2jMpqweFk63WwxpsW0jqXXxqNdXYQwNecFc74wkUIt5SngMN+GZ9Crlx6gfDi2jM4O2
	gYD/A+Ex6UHpZn3YP5HPw7yXH2BagJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746622925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9tESCeBbULja3MOUysra++fStjGsyG4dYt4IVq2Mio=;
	b=jXfX7FjceKQLA4qJf9VbS1Mx5xED8A4g91rZI+iyghZmmbSBK5UV7GRoXWNPKIcRajj0jx
	i/Te8EZIOR7P1NDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1B5413882;
	Wed,  7 May 2025 13:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /4N9NsxZG2h4PAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 May 2025 13:02:04 +0000
Message-ID: <395ce5cd-5557-4312-b60f-8d1cedfb86e6@suse.cz>
Date: Wed, 7 May 2025 15:02:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 4/6] locking/local_lock: Introduce
 local_lock_irqsave_check()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-5-alexei.starovoitov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250501032718.65476-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0394D1F441
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.01

On 5/1/25 5:27 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce local_lock_irqsave_check() to check that local_lock is
> not taken recursively.
> In !PREEMPT_RT local_lock_irqsave() disables IRQ, but
> re-entrance is possible either from NMI or strategically placed
> kprobe. The code should call local_lock_is_locked() before proceeding
> to acquire a local_lock. Such local_lock_is_locked() might be called
> earlier in the call graph and there could be a lot of code
> between local_lock_is_locked() and local_lock_irqsave_check().
> 
> Without CONFIG_DEBUG_LOCK_ALLOC the local_lock_irqsave_check()
> is equivalent to local_lock_irqsave().
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

While I agree with the principle, what I think is less ideal:

- it's an opt-in new API local_lock_irqsave_check() so requires to
change the callers that want the check enabled, even though it's
controlled by a debug config. We could just do the check in every
local_lock_*() operation? Perhaps it would be checking something that
can't ever trigger for instances that never use local_lock_is_locked()
(or local_trylock()) to determine the code flow. But maybe we can be
surprised, and the cost of the check everywhere is fine to pay with a
debug option.

Yes the check only supports local_trylock_t (on !RT) but we could handle
that with _Generic(), or maybe even turn local_lock's to full
local_trylock's to include the acquired field, when the debug option is
enabled?

- CONFIG_DEBUG_LOCK_ALLOC seems like a wrong config given its
name+description, isn't there something more fitting in the lock related
debugging ecosystem?

- shouldn't lockdep just handle this already because this is about not
locking something that's already locked by us?

- a question below for the implementation:

> ---
>  include/linux/local_lock.h          | 13 +++++++++++++
>  include/linux/local_lock_internal.h | 19 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 092ce89b162a..0d6efb0fdd15 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -81,6 +81,19 @@
>  #define local_trylock_irqsave(lock, flags)			\
>  	__local_trylock_irqsave(lock, flags)
>  
> +/**
> + * local_lock_irqsave_check - Acquire a per CPU local lock, save and disable
> + *			      interrupts
> + * @lock:	The lock variable
> + * @flags:	Storage for interrupt flags
> + *
> + * This function checks that local_lock is not taken recursively.
> + * In !PREEMPT_RT re-entrance is possible either from NMI or kprobe.
> + * In PREEMPT_RT it checks that current task is not holding it.
> + */
> +#define local_lock_irqsave_check(lock, flags)			\
> +	__local_lock_irqsave_check(lock, flags)
> +
>  DEFINE_GUARD(local_lock, local_lock_t __percpu*,
>  	     local_lock(_T),
>  	     local_unlock(_T))
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index 263723a45ecd..7c4cc002bc68 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -168,6 +168,15 @@ do {								\
>  /* preemption or migration must be disabled before calling __local_lock_is_locked */
>  #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
>  
> +#define __local_lock_irqsave_check(lock, flags)					\
> +	do {									\
> +		if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&			\
> +		    (!__local_lock_is_locked(lock) || in_nmi()))		\
> +			WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));	\

I'm wondering about the conditions here. If local_lock_is_locked() is
true and we're not in nmi, we just do nothing here, but that means thies
just silently ignores the situation where we would lock in the task and
then try locking again in irq?
Shouldn't we just always trylock and warn if it fails? (but back to my
lockdep point this might be just duplicating what it already does?)

> +		else								\
> +			__local_lock_irqsave(lock, flags);			\
> +	} while (0)
> +
>  #define __local_lock_release(lock)					\
>  	do {								\
>  		local_trylock_t *tl;					\
> @@ -293,4 +302,14 @@ do {								\
>  #define __local_lock_is_locked(__lock)					\
>  	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
>  
> +#define __local_lock_irqsave_check(lock, flags)				\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		flags = 0;						\
> +		migrate_disable();					\
> +		if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC))		\
> +			WARN_ON_ONCE(__local_lock_is_locked(lock));	\
> +		spin_lock(this_cpu_ptr((lock)));			\
> +	} while (0)
> +
>  #endif /* CONFIG_PREEMPT_RT */


