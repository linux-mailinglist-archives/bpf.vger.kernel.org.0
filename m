Return-Path: <bpf+bounces-63215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A5B0445A
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FAE171A8D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49644270EB2;
	Mon, 14 Jul 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WMo3YZ4t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3eL5GV5i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0f9nh7L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="noXFIZg+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FA2673B7
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507357; cv=none; b=TNUo/S9nWEt4OznMstpcoaVyHVSViaC1RLib3CrMCWhpabmt7Enan0s9EUn9MtD9q2qsEdRM4NcslqXufT4K4IB3CccTtBqwTpIxfBuPk1LaueKjz4AZLOJhXB3zn4TjJPKqgCnqdarBQwp4DiN5nnOWmQgC2WSJJGoRSL5i9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507357; c=relaxed/simple;
	bh=j6yONx8szkAC+EcI7X0D1G7GRtezAtev87Kkq2gSXOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDP0EjBWBG7yxbvrxQ0w1CNzyl6AxSbN9mMBpUUzeik1GjvsUC1geV8191GaX6WibDXJe/yG8FPh56WIpEeBXOUP4f9y3b2tChTD1d56N0uhePS/7h/EyBCcAx1I6sj9aFe4OK0PbPdyfqvrM+aw3XOzj5i3M9NGgv7Xbrt/MLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WMo3YZ4t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3eL5GV5i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0f9nh7L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=noXFIZg+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E37C21271;
	Mon, 14 Jul 2025 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752507354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YWXvJzd7nL3ax52foGLz+Hlyhnvwg5cdeW0wQYQO08=;
	b=WMo3YZ4tsZbsaA2fOdBeIt9XEz/pNY0uKJxWqYEu9p5umKi2vXQlELE5m+9yi4nIXJxSvV
	CUwpmnJaKNzf2IE6OarAUo1rVdhq2WIrp/lFr0zzrFTRgOdX1Hy95zJfHQTUGsDC95OZkc
	Q+EHu9IvujEndS47TaASlb6eaPGy1KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752507354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YWXvJzd7nL3ax52foGLz+Hlyhnvwg5cdeW0wQYQO08=;
	b=3eL5GV5ihm7dQ+piKqNigrVOJ7Z+sVyfe6AbdHNAqRKAU6vJbKWl7hyD8r+HIxEvJJJIYf
	t9YvUjY/U6y+WeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752507353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YWXvJzd7nL3ax52foGLz+Hlyhnvwg5cdeW0wQYQO08=;
	b=r0f9nh7L8MJS07uGe9rD/IxPbRDf3ZLAvrQHQBcQjlFkcesyfDyOFMpSHUq1B81vVCXFFt
	+LkcPPm7jtycLguOwRv4vtj5x1nRCPzfRe2Fqb1meFzR3xqISB3NOdsezxqy7m+g2epwdC
	sUy7vOIAmGXtm4nOcARIHaHKAg+ZuwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752507353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YWXvJzd7nL3ax52foGLz+Hlyhnvwg5cdeW0wQYQO08=;
	b=noXFIZg+wEabpEupjXZal0LbRDc0kFbx45bp209STDQeIT3CO9BrblI6a20Ne1ePREajCo
	k3GnTiAVOD99OEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6FB0138A1;
	Mon, 14 Jul 2025 15:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVsSONgjdWjyOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Jul 2025 15:35:52 +0000
Message-ID: <12615023-1762-49fc-9c86-2e1d9f5997f3@suse.cz>
Date: Mon, 14 Jul 2025 17:35:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250714110639.uOaKJEfL@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 7/14/25 13:06, Sebastian Andrzej Siewior wrote:
> On 2025-07-11 19:19:26 [-0700], Alexei Starovoitov wrote:
>> > If there is no parent check then we could do "normal lock" on both
>> > sides.
>> 
>> How would ___slab_alloc() know whether there was a parent check or not?
>> 
>> imo keeping local_lock_irqsave() as-is is cleaner,
>> since if there is no parent check lockdep will rightfully complain.
> 
> what about this:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 7e2ffe1d46c6c..3520d1c25c205 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3693,6 +3693,34 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
>  	return freelist;
>  }
>  
> +static void local_lock_cpu_slab(struct kmem_cache *s, const gfp_t gfp_flags,
> +				unsigned long *flags)
> +{
> +	bool allow_spin = gfpflags_allow_spinning(gfp_flags);
> +
> +	/*
> +	 * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
> +	 * can be acquired without a deadlock before invoking the function.
> +	 *
> +	 * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
> +	 * disabled context. The lock will always be acquired and if needed it
> +	 * block and sleep until the lock is available.
> +	 *
> +	 * On !PREEMPT_RT allocations from any context but NMI are safe. The lock
> +	 * is always acquired with disabled interrupts meaning it is always
> +	 * possible to it.
> +	 * In NMI context it is needed to check if the lock is acquired. If it is not,
> +	 * it is safe to acquire it. The trylock semantic is used to tell lockdep
> +	 * that we don't spin. The BUG_ON() will not trigger if it is safe to acquire
> +	 * the lock.
> +	 *
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !allow_spin)
> +		BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags));
> +	else
> +		local_lock_irqsave(&s->cpu_slab->lock, *flags);

If we go with this, then I think the better approach would be simply:

if (unlikely(!local_trylock_irqsave(&s->cpu_slab->lock, *flags))
	local_lock_irqsave(&s->cpu_slab->lock, *flags);

- no branches before the likely to succeed local_trylock_irqsave()
- the unlikely local_lock_irqsave() fallback exists to handle the PREEMPT_RT
case / provide lockdep checks in case of screwing up
- we don't really need to evaluate allow_spin or add BUG_ON() (which is
actively disallowed to add these days anyway) - if we screw up, either
lockdep will splat, or we deadlock

Also I'm thinking on !PREEMPT_RT && !LOCKDEP we don't even need the fallback
local_lock_irqsave part? The trylock is supposed to always succeed, right?
Either we allow spinning and that means we're not under kmalloc_nolock() and
should not be interrupting the locked section (as before this series). Or
it's the opposite and then the earlier local_lock_is_locked() check should
have prevented us from going here. So I guess we could just trylock without
checking the return value - any screw up should blow up quickly even without
the BUG_ON().

> +}
> +
>  /*
>   * Slow path. The lockless freelist is empty or we need to perform
>   * debugging duties.
> @@ -3765,7 +3793,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		goto deactivate_slab;
>  
>  	/* must check again c->slab in case we got preempted and it changed */
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> +	local_lock_cpu_slab(s, gfpflags, &flags);
> +
>  	if (unlikely(slab != c->slab)) {
>  		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		goto reread_slab;
> @@ -3803,7 +3832,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  deactivate_slab:
>  
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> +	local_lock_cpu_slab(s, gfpflags, &flags);
>  	if (slab != c->slab) {
>  		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  		goto reread_slab;
> @@ -3819,7 +3848,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	while (slub_percpu_partial(c)) {
> -		local_lock_irqsave(&s->cpu_slab->lock, flags);
> +		local_lock_cpu_slab(s, gfpflags, &flags);
>  		if (unlikely(c->slab)) {
>  			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  			goto reread_slab;
> @@ -3947,7 +3976,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  retry_load_slab:
>  
> -	local_lock_irqsave(&s->cpu_slab->lock, flags);
> +	local_lock_cpu_slab(s, gfpflags, &flags);
>  	if (unlikely(c->slab)) {
>  		void *flush_freelist = c->freelist;
>  		struct slab *flush_slab = c->slab;
> @@ -4003,12 +4032,8 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  			p = ERR_PTR(-EBUSY);
>  			goto out;
>  		}
> -		local_lock_lockdep_start(&s->cpu_slab->lock);
> -		p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> -		local_lock_lockdep_end(&s->cpu_slab->lock);
> -	} else {
> -		p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>  	}
> +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>  out:
>  #ifdef CONFIG_PREEMPT_COUNT
>  	slub_put_cpu_ptr(s->cpu_slab);
> 
> 
> Sebastian


