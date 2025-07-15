Return-Path: <bpf+bounces-63352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48BB0655D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF6E177E5E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC53287240;
	Tue, 15 Jul 2025 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZGmqw+8j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tic65hCt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZGmqw+8j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tic65hCt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129D248F60
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601723; cv=none; b=crFwSSAMZIkLLfZktkYi9RiAGnL0a4PEwgVug7CL661ZuUMnyHroguH9omZ0nPjbSeN+kiieKbzOfI4Y6hIgPWMV9wujaQXUTTWjRTqoIOfb1QiETKQgfqu0CZNna2sbKghAdev7/+U8uYKrrLl33rrK4mEOMHuHkuDU23kf7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601723; c=relaxed/simple;
	bh=XxZ24SZ0Ndlg4JKP7Y6BkGH1JDrGGsGSdEw3sgdX92o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PldaPHSEH6/zYrMBOPCtuJDWKm6vmGxHJQs6DUtTA7rE/BfEZR0VNCvM7tMyKjT6uPIV/4jawQ/OaxNlSPg5IQKe+o/EsJg6wFeYJ/rGuY8zz3p9nGCpfoEbSJ/SZbYf36P2HnBCtnbM8BIm5CZk4HNq9xmbcWc/jRzy6yj7bFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZGmqw+8j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tic65hCt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZGmqw+8j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tic65hCt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEFD21F38F;
	Tue, 15 Jul 2025 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752601719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wb2ksK0EHa/ctnPW4+9xoR4SMsKpah0TgRutfEDFs28=;
	b=ZGmqw+8j4VTNFS2D0M87oCV4chZ5a1Lj8uB/K/MeJxLStutGeTUBKQ4XJ7URx9F5jdkzjR
	DPTfZsHTdfSFOqSPl6VrgL41PW3v04Mt3Sicm6Hpfv1P/aQUQyq1UzBC9MFr4w8iOk7XvN
	GZugP1gyQoJhcWgxmqekVnnpLZH2v8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752601719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wb2ksK0EHa/ctnPW4+9xoR4SMsKpah0TgRutfEDFs28=;
	b=Tic65hCteaDmMd7x610hj+cxbLBHWLZEICev/zkNsVCwM+h6SGg+2RyVE0izdVMr5/os4h
	fWF31vsczdSC3iBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752601719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wb2ksK0EHa/ctnPW4+9xoR4SMsKpah0TgRutfEDFs28=;
	b=ZGmqw+8j4VTNFS2D0M87oCV4chZ5a1Lj8uB/K/MeJxLStutGeTUBKQ4XJ7URx9F5jdkzjR
	DPTfZsHTdfSFOqSPl6VrgL41PW3v04Mt3Sicm6Hpfv1P/aQUQyq1UzBC9MFr4w8iOk7XvN
	GZugP1gyQoJhcWgxmqekVnnpLZH2v8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752601719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wb2ksK0EHa/ctnPW4+9xoR4SMsKpah0TgRutfEDFs28=;
	b=Tic65hCteaDmMd7x610hj+cxbLBHWLZEICev/zkNsVCwM+h6SGg+2RyVE0izdVMr5/os4h
	fWF31vsczdSC3iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F60313A68;
	Tue, 15 Jul 2025 17:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ij5AJneUdmi5CgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Jul 2025 17:48:39 +0000
Message-ID: <d5379c97-1954-4352-820d-87b610d597ba@suse.cz>
Date: Tue, 15 Jul 2025 19:48:39 +0200
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de>
 <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
 <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
 <CAADnVQK3B4ToOOuWOWQdvHO-1as3X2YMGkj45vYQ0Nxoe55Nsw@mail.gmail.com>
 <6835614d-c316-4ecf-ae2b-52687a66ae7c@suse.cz>
 <mb6gbhm7f6xflrtzkjjz4rsapudg55ushyzqqo2uw7intdqmcc@4ess725k2gjj>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <mb6gbhm7f6xflrtzkjjz4rsapudg55ushyzqqo2uw7intdqmcc@4ess725k2gjj>
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
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 7/15/25 19:29, Alexei Starovoitov wrote:
> On Tue, Jul 15, 2025 at 08:56:21AM +0200, Vlastimil Babka wrote:
>> > the addresses of the locks are different and they're different
>> > kmalloc buckets, but lockdep cannot understand this without
>> > explicit local_lock_lockdep_start().
>> > The same thing I'm trying to explain in the commit log.
>> 
>> Thanks for the explanation and sorry for being so dense.
>> Maybe lockdep's lock classes can be used here somehow instead of having to
>> teach lockdep completely new tricks, but I don't know enough about those to
>> know for sure.
> 
> I tried that with a separate lock_key for each local_trylock_t
> and it's sort-of kinda works for 16 cpus, but doesn't scale
> when number of cpus is large.
> There is no good way to pick LOCKDEP_BITS.
> 
> It can be made optional on PREEMP_RT only
> and used for kmalloc buckets only that kmalloc_nolock() is using,
> but still feels less clean than
> local_lock_lockdep_start/end()
> since it makes lockdep work harder.
> 
> Better ideas?

I was thinking something like a class for normal context and a different
class for kmalloc_nolock() context (determined by allow_spinning) but it's
quite vague as I don't understand lockdep enough.

> From da2b3bac08950929da105836fbff7e2ea4ecbc0e Mon Sep 17 00:00:00 2001
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Tue, 15 Jul 2025 10:16:42 -0700
> Subject: [PATCH] lockdep
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  lib/Kconfig.debug |  2 +-
>  mm/slub.c         | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6..94c07b84ecd0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1526,7 +1526,7 @@ config LOCKDEP_BITS
>  	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
>  	depends on LOCKDEP && !LOCKDEP_SMALL
>  	range 10 24
> -	default 15
> +	default 16
>  	help
>  	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 2f30b85fbf68..2ae6bf3ebcd0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -395,6 +395,7 @@ struct kmem_cache_cpu {
>  	struct slab *partial;	/* Partially allocated slabs */
>  #endif
>  	local_trylock_t lock;	/* Protects the fields above */
> +	struct lock_class_key lock_key;
>  #ifdef CONFIG_SLUB_STATS
>  	unsigned int stat[NR_SLUB_STAT_ITEMS];
>  #endif
> @@ -3083,6 +3084,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>  	for_each_possible_cpu(cpu) {
>  		c = per_cpu_ptr(s->cpu_slab, cpu);
>  		local_trylock_init(&c->lock);
> +		lockdep_register_key(&c->lock_key);
> +		lockdep_set_class(&c->lock, &c->lock_key);
>  		c->tid = init_tid(cpu);
>  	}
>  }
> @@ -5953,6 +5956,16 @@ void __kmem_cache_release(struct kmem_cache *s)
>  {
>  	cache_random_seq_destroy(s);
>  #ifndef CONFIG_SLUB_TINY
> +	{
> +		int cpu;
> +
> +		for_each_possible_cpu(cpu) {
> +			struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab,
> +							       cpu);
> +
> +			lockdep_unregister_key(&c->lock_key);
> +		}
> +	}
>  	free_percpu(s->cpu_slab);
>  #endif
>  	free_kmem_cache_nodes(s);


