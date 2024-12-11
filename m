Return-Path: <bpf+bounces-46617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF39ECB9A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 12:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AE9282741
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAB2210E7;
	Wed, 11 Dec 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZilIRmc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Hmy4jFx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nZilIRmc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Hmy4jFx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3421A83E4
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918144; cv=none; b=tLqw8IJgk/LcjI9DXiZTUxcnlYtgXIpf3m/K74hobwKRqOWeU02xcRgE1JORZ+RNwj3DLUj8pFM9f8EOCDN3Ll2fWk1zfLG8/g3Nyyl5hykk8gBg5lwfHr8WFZul4/ntn5Pj5EnJw3py+o0TyH+hsClq5w8d37tzCrOHD2bX5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918144; c=relaxed/simple;
	bh=5kTmPBFxGD1VSr5/Zldy069BVNmAXykm7fXOixfYTf8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HtXDcTjRqyXuVrClQ9w1b6O/YWydTQsNHF/yNH2nq3oumtZm6NdLayWMkOpWL5s/VzgbBb/p0vDZoj0hO9MAB49ZYMEFhRf5t3q6b40GqLsFD85FfBpiGoLX0GbATi4ilvCKJaM7vVUFTJ7Q0HvLvkZvU3aQnSooGpwAh0IDzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nZilIRmc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Hmy4jFx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nZilIRmc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Hmy4jFx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 864F51F38C;
	Wed, 11 Dec 2024 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733918140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ITp2yxbRugxAWKTUlx0Z/DqsjKK8zSF7Mf+1R1O0848=;
	b=nZilIRmceW6datZ4H9jjSYCZbc/GfqNe+zDZ3SHdl1BA10dLCjsFHYdzCeCuhQV5O0iTMs
	nF56la03XB8J7xii0Es7hdFe4LhNfz+ixh/mUPdt0CXD/S5XCpHV3bY/Rb7k8EWa33culJ
	AqY8/o7P52I3x2vWDYc+FY2vHMtbY0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733918140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ITp2yxbRugxAWKTUlx0Z/DqsjKK8zSF7Mf+1R1O0848=;
	b=2Hmy4jFxD2A2R15+XALv8Y5XRAaob/qivr9hnqHZ7WQd7WZWkJZFIz4oDx805NqUW47GOR
	PgdZmuF9et+qQXCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nZilIRmc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Hmy4jFx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733918140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ITp2yxbRugxAWKTUlx0Z/DqsjKK8zSF7Mf+1R1O0848=;
	b=nZilIRmceW6datZ4H9jjSYCZbc/GfqNe+zDZ3SHdl1BA10dLCjsFHYdzCeCuhQV5O0iTMs
	nF56la03XB8J7xii0Es7hdFe4LhNfz+ixh/mUPdt0CXD/S5XCpHV3bY/Rb7k8EWa33culJ
	AqY8/o7P52I3x2vWDYc+FY2vHMtbY0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733918140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ITp2yxbRugxAWKTUlx0Z/DqsjKK8zSF7Mf+1R1O0848=;
	b=2Hmy4jFxD2A2R15+XALv8Y5XRAaob/qivr9hnqHZ7WQd7WZWkJZFIz4oDx805NqUW47GOR
	PgdZmuF9et+qQXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AB6313983;
	Wed, 11 Dec 2024 11:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6GSgFbx9WWfMeQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 11 Dec 2024 11:55:40 +0000
Message-ID: <9e5bdef1-a692-47d5-82b9-96a4f2c68463@suse.cz>
Date: Wed, 11 Dec 2024 12:55:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce
 local_trylock_irqsave()
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, tj@kernel.org,
 linux-mm@kvack.org, kernel-team@fb.com, Jann Horn <jannh@google.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-4-alexei.starovoitov@gmail.com>
 <1c760bf1-14a4-42e4-a55b-438a29987aef@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <1c760bf1-14a4-42e4-a55b-438a29987aef@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 864F51F38C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com,google.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/11/24 11:53, Vlastimil Babka wrote:
> On 12/10/24 03:39, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>> 
>> Similar to local_lock_irqsave() introduce local_trylock_irqsave().
>> It uses spin_trylock in PREEMPT_RT and always succeeds when !RT.
> 
> Hmm but is that correct to always succeed? If we're in an nmi, we might be
> preempting an existing local_(try)lock_irqsave() critical section because
> disabling irqs doesn't stop NMI's, right?

So unless I'm missing something, it would need to be a new kind of local
lock to support this trylock operation on !RT? Perhaps based on the same
principle of a simple active/locked flag that I tried in my sheaves RFC? [1]
There could be also the advantage that if all (potentially) irq contexts
(not just nmi) used trylock, it would be sufficient to disable preeemption
and not interrupts, which is cheaper.
The RT variant could work as you proposed here, that was wrong in my RFC as
you already pointed out when we discussed v1 of this series.

[1]
https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05@suse.cz/

>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  include/linux/local_lock.h          |  9 +++++++++
>>  include/linux/local_lock_internal.h | 23 +++++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>> 
>> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
>> index 091dc0b6bdfb..6880c29b8b98 100644
>> --- a/include/linux/local_lock.h
>> +++ b/include/linux/local_lock.h
>> @@ -30,6 +30,15 @@
>>  #define local_lock_irqsave(lock, flags)				\
>>  	__local_lock_irqsave(lock, flags)
>>  
>> +/**
>> + * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
>> + *			   interrupts. Always succeeds in !PREEMPT_RT.
>> + * @lock:	The lock variable
>> + * @flags:	Storage for interrupt flags
>> + */
>> +#define local_trylock_irqsave(lock, flags)			\
>> +	__local_trylock_irqsave(lock, flags)
>> +
>>  /**
>>   * local_unlock - Release a per CPU local lock
>>   * @lock:	The lock variable
>> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
>> index 8dd71fbbb6d2..2c0f8a49c2d0 100644
>> --- a/include/linux/local_lock_internal.h
>> +++ b/include/linux/local_lock_internal.h
>> @@ -31,6 +31,13 @@ static inline void local_lock_acquire(local_lock_t *l)
>>  	l->owner = current;
>>  }
>>  
>> +static inline void local_trylock_acquire(local_lock_t *l)
>> +{
>> +	lock_map_acquire_try(&l->dep_map);
>> +	DEBUG_LOCKS_WARN_ON(l->owner);
>> +	l->owner = current;
>> +}
>> +
>>  static inline void local_lock_release(local_lock_t *l)
>>  {
>>  	DEBUG_LOCKS_WARN_ON(l->owner != current);
>> @@ -45,6 +52,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
>>  #else /* CONFIG_DEBUG_LOCK_ALLOC */
>>  # define LOCAL_LOCK_DEBUG_INIT(lockname)
>>  static inline void local_lock_acquire(local_lock_t *l) { }
>> +static inline void local_trylock_acquire(local_lock_t *l) { }
>>  static inline void local_lock_release(local_lock_t *l) { }
>>  static inline void local_lock_debug_init(local_lock_t *l) { }
>>  #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
>> @@ -91,6 +99,13 @@ do {								\
>>  		local_lock_acquire(this_cpu_ptr(lock));		\
>>  	} while (0)
>>  
>> +#define __local_trylock_irqsave(lock, flags)			\
>> +	({							\
>> +		local_irq_save(flags);				\
>> +		local_trylock_acquire(this_cpu_ptr(lock));	\
>> +		1;						\
>> +	})
>> +
>>  #define __local_unlock(lock)					\
>>  	do {							\
>>  		local_lock_release(this_cpu_ptr(lock));		\
>> @@ -148,6 +163,14 @@ typedef spinlock_t local_lock_t;
>>  		__local_lock(lock);				\
>>  	} while (0)
>>  
>> +#define __local_trylock_irqsave(lock, flags)			\
>> +	({							\
>> +		typecheck(unsigned long, flags);		\
>> +		flags = 0;					\
>> +		migrate_disable();				\
>> +		spin_trylock(this_cpu_ptr((__lock)));		\
>> +	})
>> +
>>  #define __local_unlock(__lock)					\
>>  	do {							\
>>  		spin_unlock(this_cpu_ptr((__lock)));		\
> 


