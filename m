Return-Path: <bpf+bounces-49398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB9EA18189
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C0716AFCD
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353C1F470D;
	Tue, 21 Jan 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUHFdhgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oluIpPDg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUHFdhgD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oluIpPDg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E01F1505
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475120; cv=none; b=mQeXIK4xcGRVJgGcKJK81H198WuWoHec7Xsa3BayQszTwRfZ9Ek9N4GDI9bDbUuBdUxOCnxS4Cs/0IN6JyEvzrOlOarPB+K9zDE8PG5g8S1kKQi0O09yzUpAZzj+gaUPKxXae3cou2F5iU+FxiAzc/P4zUKeKUJ+yhr5cmQlTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475120; c=relaxed/simple;
	bh=gBMFnSemPU4B9/SXX4+n8vW7GQ9Sxz9AwPFxJGHGmT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxyhoZwGLw3CV06/mAEFMfCG81h0FVG0knlIevdaHxcYLjD0N9iQajTy0EecMUG8MlIbVhhJ0aI5kShxsU5eCBO09+Uy3Fmw8i1jtrbklQojZLj9QxD5sFrN2knDfS3mqHf2Ef9Gaj6AsgIv0PEZam9NLDudMqcBqlN8nxd3Iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUHFdhgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oluIpPDg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUHFdhgD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oluIpPDg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0C71F399;
	Tue, 21 Jan 2025 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737475115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzYZxu4zQxSb9+0uvZiUVZVxqCp7jCsg39dJ2ytLhA4=;
	b=nUHFdhgDbKiT6cvQI0Xoj4+6E1Ej8mQhPbC8yw56c3CIpfHA5w9YDPOAXyRifAX7ZmsECq
	Zdy3RLwB8OhLI2EVrJQ7cqAS/ZldjkJ6qql1QcXVzyWTo2i3L12xX5Z1D0YNi0MnD1Wnff
	NxYSragGtczSz/kAMSrsF2qVpkd1nxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737475115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzYZxu4zQxSb9+0uvZiUVZVxqCp7jCsg39dJ2ytLhA4=;
	b=oluIpPDg+k5XGm42XHjH73AwJ9sevqT8WzvsxZN0Q20W0mnYKzmFc2BYbK5KHcLgI+/EMy
	bRuQeX1CPc7KKrCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nUHFdhgD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oluIpPDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737475115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzYZxu4zQxSb9+0uvZiUVZVxqCp7jCsg39dJ2ytLhA4=;
	b=nUHFdhgDbKiT6cvQI0Xoj4+6E1Ej8mQhPbC8yw56c3CIpfHA5w9YDPOAXyRifAX7ZmsECq
	Zdy3RLwB8OhLI2EVrJQ7cqAS/ZldjkJ6qql1QcXVzyWTo2i3L12xX5Z1D0YNi0MnD1Wnff
	NxYSragGtczSz/kAMSrsF2qVpkd1nxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737475115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzYZxu4zQxSb9+0uvZiUVZVxqCp7jCsg39dJ2ytLhA4=;
	b=oluIpPDg+k5XGm42XHjH73AwJ9sevqT8WzvsxZN0Q20W0mnYKzmFc2BYbK5KHcLgI+/EMy
	bRuQeX1CPc7KKrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DDE913963;
	Tue, 21 Jan 2025 15:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P7yoFivEj2cPWgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 21 Jan 2025 15:58:35 +0000
Message-ID: <cec11348-a55f-40b4-9011-0e83113ade63@suse.cz>
Date: Tue, 21 Jan 2025 16:59:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce
 local_trylock_irqsave()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com>
 <20250117203315.FWviQT38@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250117203315.FWviQT38@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B0C71F399
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
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,linutronix.de,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 1/17/25 9:33 PM, Sebastian Andrzej Siewior wrote:
> On 2025-01-14 18:17:42 [-0800], Alexei Starovoitov wrote:
>> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
>> index 8dd71fbbb6d2..93672127c73d 100644
>> --- a/include/linux/local_lock_internal.h
>> +++ b/include/linux/local_lock_internal.h
>> @@ -75,37 +85,73 @@ do {								\
>>  
>>  #define __local_lock(lock)					\
>>  	do {							\
>> +		local_lock_t *l;				\
>>  		preempt_disable();				\
>> -		local_lock_acquire(this_cpu_ptr(lock));		\
>> +		l = this_cpu_ptr(lock);				\
>> +		lockdep_assert(l->active == 0);			\
>> +		WRITE_ONCE(l->active, 1);			\
>> +		local_lock_acquire(l);				\
>>  	} while (0)
> 
> …
> 
>> +#define __local_trylock_irqsave(lock, flags)			\
>> +	({							\
>> +		local_lock_t *l;				\
>> +		local_irq_save(flags);				\
>> +		l = this_cpu_ptr(lock);				\
>> +		if (READ_ONCE(l->active) == 1) {		\
>> +			local_irq_restore(flags);		\
>> +			l = NULL;				\
>> +		} else {					\
>> +			WRITE_ONCE(l->active, 1);		\
>> +			local_trylock_acquire(l);		\
>> +		}						\
>> +		!!l;						\
>> +	})
>> +
> 
> Part of the selling for local_lock_t was that it does not affect
> !PREEMPT_RT builds. By adding `active' you extend every data structure
> and you have an extra write on every local_lock(). It was meant to
> replace preempt_disable()/ local_irq_save() based locking with something
> that actually does locking on PREEMPT_RT without risking my life once
> people with pitchforks come talk about the new locking :)
> 
> I admire that you try to make PREEMPT_RT and !PREEMPT_RT similar in a
> way that both detect recursive locking which not meant to be supported. 
> 
> Realistically speaking as of today we don't have any recursive lock
> detection other than lockdep. So it should be enough given that the bots
> use it often and hopefully local testing.
> Your assert in local_lock() does not work without lockdep. It will only
> make local_trylock_irqsave() detect recursion and lead to two splats
> with lockdep enabled in local_lock() (one from the assert and the second
> from lockdep).
> 
> I would say you could get rid of the `active' field and solely rely on
> lockdep and the owner field. So __local_trylock_irqsave() could maybe
> use local_trylock_acquire() to conditionally acquire the lock if `owner'
> is NULL.
> 
> This makes it possible to have recursive code without lockdep, but with
> lockdep enabled the testcase should fail if it relies on recursion.
> Other than that, I don't see any advantage. Would that work?

I don't think it would work, or am I missing something? The goal is to
allow the operation (alloc, free) to opportunistically succeed in e.g.
nmi context, but only if we didn't interrupt anything that holds the
lock. Otherwise we must allow for failure - hence trylock.
(a possible extension that I mentioned is to also stop doing irqsave to
avoid its overhead and thus also operations from an irq context would be
oportunistic)
But if we detect the "trylock must fail" cases only using lockdep, we'll
deadlock without lockdep. So e.g. the "active" flag has to be there?

So yes this goes beyond the original purpose of local_lock. Do you think
it should be a different lock type then, which would mean the other
users of current local_lock that don't want the opportunistic nesting
via trylock, would not inflict the "active" flag overhead?

AFAICS the RT implementation of local_lock could then be shared for both
of these types, but I might be missing some nuance there.

> Sebastian


