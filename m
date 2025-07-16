Return-Path: <bpf+bounces-63440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54EB07716
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAB01C2335B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D11CAA92;
	Wed, 16 Jul 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9RzPl53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="06XQjcY1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9RzPl53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="06XQjcY1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7641A76BB
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672918; cv=none; b=bkPnDIeHs5cdRciJo6QxsLauam4QcL7/FDO2vktIIdpErFJW+WLru59JYclQwx8ssyqc/VKHA8b2jm1rMX6wWSrJCYvKZd5g+s+w4eq1tu8jmkny2fERzCQ6Sw+S6O98iD6Od+xZmgvOSJpbSrfLYGeRhZLr7qEx/j+ou1MiuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672918; c=relaxed/simple;
	bh=kb2fpw8jVxUgITftmUEpyIrHyBe1WApYGrvEHmSbDww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb27ZwwQ3h7sF/bqnX74YLaBad0I5Aa+YwoC4vrlV4RG2B8UtJzBddO2xzvcu6DWvRe2TeEHZtuwsjRWQwIiTsHMXZ+kX7EEYlCXq4K17y2PicAEkAeIILVziHD083+iQEOFjOkbxGkymeIDcH4gkWYps4i6X7fRmf++9lLcc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9RzPl53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=06XQjcY1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9RzPl53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=06XQjcY1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D5552125C;
	Wed, 16 Jul 2025 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752672914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/g53h9FY0qCP83Gv2QCi97/K/5yn1Pqfsli7li9uQ4o=;
	b=o9RzPl53JkAADuv1YOnk2bY++XiNOFrb/VQ4Wotpffc4Z213abD9DMnIevnojkU8118XXy
	QVpC5dGj5IpTAzPR2O2oUwq93ls/+lKG3VxJW0lVjjmzp2Au7rJAiRkFSEO+B0P5VUf2ZB
	kg9y01p5RSnuyytnt9HIwB8ZEFHjNw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752672914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/g53h9FY0qCP83Gv2QCi97/K/5yn1Pqfsli7li9uQ4o=;
	b=06XQjcY1FVGtoJeDRpLUiZLZPLn8ztkpdP8+LL9ytpZLalwc1e48jz1XfaQXmhbkT0DPhJ
	GgMexov28HhkOFBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o9RzPl53;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=06XQjcY1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752672914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/g53h9FY0qCP83Gv2QCi97/K/5yn1Pqfsli7li9uQ4o=;
	b=o9RzPl53JkAADuv1YOnk2bY++XiNOFrb/VQ4Wotpffc4Z213abD9DMnIevnojkU8118XXy
	QVpC5dGj5IpTAzPR2O2oUwq93ls/+lKG3VxJW0lVjjmzp2Au7rJAiRkFSEO+B0P5VUf2ZB
	kg9y01p5RSnuyytnt9HIwB8ZEFHjNw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752672914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/g53h9FY0qCP83Gv2QCi97/K/5yn1Pqfsli7li9uQ4o=;
	b=06XQjcY1FVGtoJeDRpLUiZLZPLn8ztkpdP8+LL9ytpZLalwc1e48jz1XfaQXmhbkT0DPhJ
	GgMexov28HhkOFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AF1B13AF6;
	Wed, 16 Jul 2025 13:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zjazBZKqd2jCegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Jul 2025 13:35:14 +0000
Message-ID: <7173c09b-99fa-4e16-a764-b9ddfa7909ce@suse.cz>
Date: Wed, 16 Jul 2025 15:35:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] slab: Make slub local_trylock_t more precise for
 LOCKDEP
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-7-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250716022950.69330-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3D5552125C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 7/16/25 04:29, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Since kmalloc_nolock() can be called from any context
> the ___slab_alloc() can acquire local_trylock_t (which is rt_spin_lock
> in PREEMPT_RT) and attempt to acquire a different local_trylock_t
> while in the same task context.
> 
> The calling sequence might look like:
> kmalloc() -> tracepoint -> bpf -> kmalloc_nolock()
> 
> or more precisely:
> __lock_acquire+0x12ad/0x2590
> lock_acquire+0x133/0x2d0
> rt_spin_lock+0x6f/0x250
> ___slab_alloc+0xb7/0xec0
> kmalloc_nolock_noprof+0x15a/0x430
> my_debug_callback+0x20e/0x390 [testmod]
> ___slab_alloc+0x256/0xec0
> __kmalloc_cache_noprof+0xd6/0x3b0
> 
> Make LOCKDEP understand that local_trylock_t-s protect
> different kmem_caches. In order to do that add lock_class_key
> for each kmem_cache and use that key in local_trylock_t.
> 
> This stack trace is possible on both PREEMPT_RT and !PREEMPT_RT,
> but teach lockdep about it only for PREEMP_RT, since
> in !PREEMPT_RT the code is using local_trylock_irqsave() only.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Should we switch the order of patches 5 and 6 or is it sufficient there are
no callers of kmalloc_nolock() yet?

> ---
>  mm/slab.h |  1 +
>  mm/slub.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 65f4616b41de..165737accb20 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -262,6 +262,7 @@ struct kmem_cache_order_objects {
>  struct kmem_cache {
>  #ifndef CONFIG_SLUB_TINY
>  	struct kmem_cache_cpu __percpu *cpu_slab;
> +	struct lock_class_key lock_key;

I see " * The class key takes no space if lockdep is disabled:", ok good.

>  #endif
>  	/* Used for retrieving partial slabs, etc. */
>  	slab_flags_t flags;
> diff --git a/mm/slub.c b/mm/slub.c
> index c92703d367d7..526296778247 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3089,12 +3089,26 @@ static inline void note_cmpxchg_failure(const char *n,
>  
>  static void init_kmem_cache_cpus(struct kmem_cache *s)
>  {
> +#ifdef CONFIG_PREEMPT_RT
> +	/* Register lockdep key for non-boot kmem caches */
> +	bool finegrain_lockdep = !init_section_contains(s, 1);

I guess it's to avoid the "if (WARN_ON_ONCE(static_obj(key)))"
if it means the two bootstrap caches get a different class just by being
static, then I guess it works.

> +#else
> +	/*
> +	 * Don't bother with different lockdep classes for each
> +	 * kmem_cache, since we only use local_trylock_irqsave().
> +	 */
> +	bool finegrain_lockdep = false;
> +#endif
>  	int cpu;
>  	struct kmem_cache_cpu *c;
>  
> +	if (finegrain_lockdep)
> +		lockdep_register_key(&s->lock_key);
>  	for_each_possible_cpu(cpu) {
>  		c = per_cpu_ptr(s->cpu_slab, cpu);
>  		local_trylock_init(&c->lock);
> +		if (finegrain_lockdep)
> +			lockdep_set_class(&c->lock, &s->lock_key);
>  		c->tid = init_tid(cpu);
>  	}
>  }
> @@ -5976,6 +5990,9 @@ void __kmem_cache_release(struct kmem_cache *s)
>  {
>  	cache_random_seq_destroy(s);
>  #ifndef CONFIG_SLUB_TINY
> +#ifdef CONFIG_PREEMPT_RT
> +	lockdep_unregister_key(&s->lock_key);
> +#endif
>  	free_percpu(s->cpu_slab);
>  #endif
>  	free_kmem_cache_nodes(s);


