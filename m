Return-Path: <bpf+bounces-63037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD1B018DA
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDD75C0B94
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCB327EFF5;
	Fri, 11 Jul 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LiRshOFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RsN9FdZn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LiRshOFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RsN9FdZn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8A207E1D
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227726; cv=none; b=ayyeyhQyO/Em/wNVSrinHPMroF1L4H+EaUl5ycKKkJgyn53x3HfeKLjDpTUdkoB9U9UIjfI73PRx8S7CcDAwadyuwb++VN7u32HFzBREGSRsRKPJ5emZ3ba1+Gue/eR+HHp59C65VNNEfRKepLXxfrXxoDMRaf32cJ8jHH3lYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227726; c=relaxed/simple;
	bh=DJTCGcDeD0MrXWG1iiq2hJki8xYcym6hUgRKaFasaQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVcUPAWJkVDd5zQu4wHUHz3M5HP9mwqN/o99CNIxRznsK0S0+k+/jfFRd9lVyVD1LhdHrcQJubR1AMHVaIMYfCp//7pfiYeWKZYkrOcjLnATuUT9HhtTFh3tALOmODjYQBoYr+81A5friVtK8x9xVzdNlW0LZLh4ngV+68XLhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LiRshOFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RsN9FdZn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LiRshOFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RsN9FdZn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4142D211AB;
	Fri, 11 Jul 2025 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752227723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JspHrYZjJC0VAW2SlLrGUVCPG2kljB+Iy5PPXm9zaa8=;
	b=LiRshOFM48IHo/bW3gouDrGxMwveUS+59dDO1M8sfojlz5UrXD2esxQjxcgvEIydxO5fRi
	lw5I4BGE6ywdC+HHWHHxBXrgjTij7AvN79FHbzNl0TEEGcH3p6ESrxAKlJ1eM54/0/jmXO
	QONNDiUJl4/FxgA4dZxGZ/3cfVxnqMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752227723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JspHrYZjJC0VAW2SlLrGUVCPG2kljB+Iy5PPXm9zaa8=;
	b=RsN9FdZnZkVfawUZod9YoiE/Y9rA4TzFZFtG/9HtQAy0Kv+KNKs8nTgRnJ9SJTWKgbS5vT
	gNJeo8c211OWf+Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LiRshOFM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RsN9FdZn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752227723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JspHrYZjJC0VAW2SlLrGUVCPG2kljB+Iy5PPXm9zaa8=;
	b=LiRshOFM48IHo/bW3gouDrGxMwveUS+59dDO1M8sfojlz5UrXD2esxQjxcgvEIydxO5fRi
	lw5I4BGE6ywdC+HHWHHxBXrgjTij7AvN79FHbzNl0TEEGcH3p6ESrxAKlJ1eM54/0/jmXO
	QONNDiUJl4/FxgA4dZxGZ/3cfVxnqMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752227723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JspHrYZjJC0VAW2SlLrGUVCPG2kljB+Iy5PPXm9zaa8=;
	b=RsN9FdZnZkVfawUZod9YoiE/Y9rA4TzFZFtG/9HtQAy0Kv+KNKs8nTgRnJ9SJTWKgbS5vT
	gNJeo8c211OWf+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25E621388B;
	Fri, 11 Jul 2025 09:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UMntCIvfcGhedQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Jul 2025 09:55:23 +0000
Message-ID: <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
Date: Fri, 11 Jul 2025 11:55:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, harry.yoo@oracle.com,
 shakeel.butt@linux.dev, mhocko@suse.com, andrii@kernel.org,
 memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org,
 rostedt@goodmis.org, hannes@cmpxchg.org
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250711075001.fnlMZfk6@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4142D211AB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 7/11/25 09:50, Sebastian Andrzej Siewior wrote:
> On 2025-07-08 18:53:00 [-0700], Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>> 
>> Introduce local_lock_lockdep_start/end() pair to teach lockdep
>> about a region of execution where per-cpu local_lock is not taken
>> and lockdep should consider such local_lock() as "trylock" to
>> avoid multiple false-positives:
>> - lockdep doesn't like when the same lock is taken in normal and
>>   in NMI context
>> - lockdep cannot recognize that local_locks that protect kmalloc
>>   buckets are different local_locks and not taken together
>> 
>> This pair of lockdep aid is used by slab in the following way:
>> 
>> if (local_lock_is_locked(&s->cpu_slab->lock))
>> 	goto out;
>> local_lock_lockdep_start(&s->cpu_slab->lock);
>> p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>> local_lock_lockdep_end(&s->cpu_slab->lock);
>> 
>> Where ___slab_alloc() is calling
>> local_lock_irqsave(&s->cpu_slab->lock, ...) many times,
>> and all of them will not deadlock since this lock is not taken.
> 
> So you prefer this instead of using a trylock variant in ___slab_alloc()
> which would simply return in case the trylock fails?

The code isn't always in a position to "simply return". On !RT I think we
can at least assume that if we succeeded once, it means we're not a irq/nmi
interrupting a locked context so we'll succeed the following attempts too.
On RT IIUC the lock might be taken by someone else, so a trylock might fail
(even if it should also mean we're in a context that can do a non-try lock).

> Having the local_lock_is_locked() is still good to avoid the lock
> failure if it can be detected early. I am just not sure if the extra
> lockdep override is really needed.
> 
> …
>> --- a/include/linux/local_lock.h
>> +++ b/include/linux/local_lock.h
>> @@ -81,6 +81,21 @@
>>  #define local_trylock_irqsave(lock, flags)			\
>>  	__local_trylock_irqsave(lock, flags)
>>  
>> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>> +#define local_lock_lockdep_start(lock)					\
>> +	do {								\
>> +		lockdep_assert(!__local_lock_is_locked(lock));		\
>> +		this_cpu_ptr(lock)->dep_map.flags = LOCAL_LOCK_UNLOCKED;\
>> +	} while (0)
>> +
>> +#define local_lock_lockdep_end(lock)					\
>> +	do { this_cpu_ptr(lock)->dep_map.flags = 0; } while (0)
>> +
>> +#else
>> +#define local_lock_lockdep_start(lock) /**/
>> +#define local_lock_lockdep_end(lock) /**/
> 
> Why the /**/?
> 
> …
>> index 9f361d3ab9d9..6c580081ace3 100644
>> --- a/include/linux/lockdep_types.h
>> +++ b/include/linux/lockdep_types.h
>> @@ -190,13 +190,15 @@ struct lockdep_map {
>>  	u8				wait_type_outer; /* can be taken in this context */
>>  	u8				wait_type_inner; /* presents this context */
>>  	u8				lock_type;
>> -	/* u8				hole; */
>> +	u8				flags;
>>  #ifdef CONFIG_LOCK_STAT
>>  	int				cpu;
>>  	unsigned long			ip;
>>  #endif
>>  };
>>  
>> +#define LOCAL_LOCK_UNLOCKED		1
> 
> Maybe DEPMAP_FLAG_LL_UNLOCKED so it is kind of obvious where it belongs
> to. Maybe use "u8 local_lock_unlocked:1;" instead the flags + define. It
> is even used for held_lock below so it is not a new concept with
> lockdep. It would narrow down the usage.
> 
>>  struct pin_cookie { unsigned int val; };
>>  
> 
> Sebastian


