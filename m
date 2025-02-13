Return-Path: <bpf+bounces-51416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B3A34582
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97256166C12
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E2145A03;
	Thu, 13 Feb 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XvxFdHYi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ndFx74Fk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TDwEVnzP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J2vOl310"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A326B083
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459050; cv=none; b=XClBm70FaTWsxyOQeeIzyy+UKq6qQ+5cTAQYcqXx9n4bBBjZeBX+u7dr82g4+PsvYjgiKZFo3fVK2F84ANkHEM2oAq80KtI4Q7bwfl6KYNWLjsXWPLrCGIVTbmesnVKFI1HhU8EQJ5xwFMj1IqKrhjz9e/rc6C72RrDqmdo9RKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459050; c=relaxed/simple;
	bh=AXfVvj5lXLFSSQXxv+5VpoumcmDYPd/95ByIXu4pYaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9pmO1eTemCdINlgLxnGTT+gc+Lql8FG97Cntn00/uMK/Cypf4Z7nyY1ihGHOLUs9NqjlP9FA8lgJc5QHMpuAVzA3a97LPtPqK3z+PTUrjKT3w/QkQaMcKcI+8fCRjQfslsklwScwRjAcH60evWpzGZraWL0LTUkWxg9WUUQyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XvxFdHYi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ndFx74Fk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TDwEVnzP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J2vOl310; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF4B91F7C3;
	Thu, 13 Feb 2025 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739459041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=susM+pGx0JRyk/dlK8TsLXGXveCaCCNIB6+JVEGUplE=;
	b=XvxFdHYiH4YyL78Q/l3X7A4BnHsR3lDNq/sTmciyLAcTk0yK+0n5N24Kwm0hy5oWX5c+uZ
	XAiU8v7MrZDsNuzf0FRDZegofiUVXortQKzcGgHQRB4GtGx+c/Jo07+mghGsgk2/5OpW1n
	TtE5df5/YqwVJGSldmhMObK/g/idcI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739459041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=susM+pGx0JRyk/dlK8TsLXGXveCaCCNIB6+JVEGUplE=;
	b=ndFx74FkQ/6z4VxDWP/Cfh+qgxykCVe0puccPZTyczqk65kLcsDPAcvEukwAakudY7s3n7
	ruLVuQHIex+50FDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TDwEVnzP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J2vOl310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739459036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=susM+pGx0JRyk/dlK8TsLXGXveCaCCNIB6+JVEGUplE=;
	b=TDwEVnzP1SGTlhJ1qkyPwd7KqyoBjyiStV2Tq3B9Bj/OmRGxoeZki3zI6pYTcAo+YSERDF
	qbLphykbTTXBbs82bHTKTtQ3YJuumnYlnRkXvr5urAF8qrlV1ObThc6sfSLTrsyUFrooIg
	hZ7BVDKdAC3j/dPT9fmeRvYxZ0BwQ3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739459036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=susM+pGx0JRyk/dlK8TsLXGXveCaCCNIB6+JVEGUplE=;
	b=J2vOl310hhYOv3cxLj2OIlW99KvxViAvsxZiT/tLk0m1WD4omDzL2s3JQyiKJ8PNzeYshW
	GEk7NAgyrvdlBJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B242B137DB;
	Thu, 13 Feb 2025 15:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dsArK9wJrmfGdAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 13 Feb 2025 15:03:56 +0000
Message-ID: <1fda7391-228d-4e10-8449-189be36eb27c@suse.cz>
Date: Thu, 13 Feb 2025 16:03:56 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/6] locking/local_lock: Introduce
 localtry_lock_t
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-4-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250213033556.9534-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF4B91F7C3
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linutronix.de:query timed out,suse.cz:query timed out];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.cz:query timed out];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/13/25 04:35, Alexei Starovoitov wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
> critical section, but it doesn't prevent NMI, so the fully reentrant
> code cannot use local_lock_irqsave() for exclusive access.
> 
> Introduce localtry_lock_t and localtry_lock_irqsave() that
> disables interrupts and sets acquired=1, so localtry_lock_irqsave()
> from NMI attempting to acquire the same lock will return false.
> 
> In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
> Map localtry_lock_irqsave() to preemptible spin_trylock().
> When in hard IRQ or NMI return false right away, since
> spin_trylock() is not safe due to PI issues.
> 
> Note there is no need to use local_inc for acquired variable,
> since it's a percpu variable with strict nesting scopes.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/local_lock.h          |  59 +++++++++++++
>  include/linux/local_lock_internal.h | 123 ++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 091dc0b6bdfb..05c254a5d7d3 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -51,6 +51,65 @@
>  #define local_unlock_irqrestore(lock, flags)			\
>  	__local_unlock_irqrestore(lock, flags)
>  
> +/**
> + * localtry_lock_init - Runtime initialize a lock instance
> + */
> +#define localtry_lock_init(lock)		__localtry_lock_init(lock)
> +
> +/**
> + * localtry_lock - Acquire a per CPU local lock
> + * @lock:	The lock variable
> + */
> +#define localtry_lock(lock)		__localtry_lock(lock)
> +
> +/**
> + * localtry_lock_irq - Acquire a per CPU local lock and disable interrupts
> + * @lock:	The lock variable
> + */
> +#define localtry_lock_irq(lock)		__localtry_lock_irq(lock)
> +
> +/**
> + * localtry_lock_irqsave - Acquire a per CPU local lock, save and disable
> + *			 interrupts
> + * @lock:	The lock variable
> + * @flags:	Storage for interrupt flags
> + */
> +#define localtry_lock_irqsave(lock, flags)				\
> +	__localtry_lock_irqsave(lock, flags)
> +
> +/**
> + * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
> + *			      interrupts if acquired
> + * @lock:	The lock variable
> + * @flags:	Storage for interrupt flags
> + *
> + * The function can be used in any context such as NMI or HARDIRQ. Due to
> + * locking constrains it will _always_ fail to acquire the lock on PREEMPT_RT.

The "always fail" applies only to the NMI and HARDIRQ contexts, right? It's
not entirely obvious so it sounds worse than it is.

> +
> +#define __localtry_trylock_irqsave(lock, flags)			\
> +	({							\
> +		int __locked;					\
> +								\
> +		typecheck(unsigned long, flags);		\
> +		flags = 0;					\
> +		if (in_nmi() | in_hardirq()) {			\
> +			__locked = 0;				\

Because of this, IIUC?

> +		} else {					\
> +			migrate_disable();			\
> +			__locked = spin_trylock(this_cpu_ptr((lock)));	\
> +			if (!__locked)				\
> +				migrate_enable();		\
> +		}						\
> +		__locked;					\
> +	})
> +
>  #endif /* CONFIG_PREEMPT_RT */


