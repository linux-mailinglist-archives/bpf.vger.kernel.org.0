Return-Path: <bpf+bounces-58103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B6AB4C63
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C57A9B4A
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D21EA7F1;
	Tue, 13 May 2025 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ohnsBIxQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jRHEwBNT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8U+0rYT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ku25K/j6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5651624DE
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119529; cv=none; b=lveiw/hRXRb/VaDuyZkTHmo7wzFOzxi0CSG1tRk2VaG1wbtqXNf8+h6BfgibilWBnAqIfZy6vHB2EyJvQqXpvfWXO34nTo4VeHhGYz3omEbHGw7MurXxEc3tHdrqI/hetKT46XP/gAspAkmuE3ttCJGN+I2+omEmAyplTwAjrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119529; c=relaxed/simple;
	bh=zd/wDlnqf/FPdjjJznrQI/JC0iLRFYH1WLMEvM26ZP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfuqDAMYxwbSQaL8wTZ9Qti42wf/rTrdRKwnwg8UeMTnm5+uL3qFEqfL7XgItmUjLTcz7y3RTOhTAE+y49mIMPLjiTidQIeqEqWihA0Qe6UBb2mg7Capqk4+AX5pNhTtHcJC9wtYPMjNQWgFzi/rQE8rP9nPO/jl0pXyNvMjwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ohnsBIxQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jRHEwBNT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8U+0rYT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ku25K/j6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30DC11F387;
	Tue, 13 May 2025 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747119525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHFYjp+NZF69gFs84lEm0Tqe7hwBiQDRrO4TAqTmZlQ=;
	b=ohnsBIxQcoYJSBP3KrzPYNO2BCmMLFsVATlnVsJkBuGBj22MmV/LWs+jL4+DHCwmCTm6jn
	L+TrH8zO4yL2r87BYdcKuwbPdwlF5DjnJ9VAI3cU7RfL6qBqBiG4sk99jh9qSU5pc33YGb
	L0k4a5krbsR9biXHOQza5hPRcWfHeg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747119525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHFYjp+NZF69gFs84lEm0Tqe7hwBiQDRrO4TAqTmZlQ=;
	b=jRHEwBNTm5Ue38W7au7yMQMQn2neYPyeuN9KC30Y/+zZja8nSUCSsu08yDkM6iQsLDG5df
	DJvL2jyPx7L2rRDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y8U+0rYT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ku25K/j6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747119524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHFYjp+NZF69gFs84lEm0Tqe7hwBiQDRrO4TAqTmZlQ=;
	b=y8U+0rYThE7ed7Ek6inI7M/CyA7vBD+f5TmW+fqf7/kzC0Fr55Q6dPU5TCfcrFVwsW6N6l
	G9fXF+vG5/P+oPHggb6ZPV9Dj6OdKxctL2n6z8EIUexnQg6FMh5Z9DyxxrKrQigguiU1hQ
	5bcCTAcdTw+Y+yNffoBN4wXtlhCoaqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747119524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHFYjp+NZF69gFs84lEm0Tqe7hwBiQDRrO4TAqTmZlQ=;
	b=ku25K/j6M6jzfOGavHwWzq0FvTjkfBJJy33xh6FLnU97iTk5vMDRc0OUV0BUARztcFPB+N
	LyeBSw63c0MSIaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F37E8137E8;
	Tue, 13 May 2025 06:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1HqNOaPtImhFUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 06:58:43 +0000
Message-ID: <737d8993-b3c7-4ed5-8872-20c62ab81572@suse.cz>
Date: Tue, 13 May 2025 08:58:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] locking/local_lock: Introduce
 local_lock_irqsave_check()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-5-alexei.starovoitov@gmail.com>
 <20250512140359.CDEasCj3@linutronix.de>
 <CAADnVQLs009ZgcwHfo77zHA_NiGqsBpwvdG1kqc0cW6b02tXXw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQLs009ZgcwHfo77zHA_NiGqsBpwvdG1kqc0cW6b02tXXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 30DC11F387
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linutronix.de:email,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Action: no action

On 5/12/25 19:16, Alexei Starovoitov wrote:
> On Mon, May 12, 2025 at 7:04 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2025-04-30 20:27:16 [-0700], Alexei Starovoitov wrote:
>> > --- a/include/linux/local_lock_internal.h
>> > +++ b/include/linux/local_lock_internal.h
>> > @@ -168,6 +168,15 @@ do {                                                             \
>> >  /* preemption or migration must be disabled before calling __local_lock_is_locked */
>> >  #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
>> >
>> > +#define __local_lock_irqsave_check(lock, flags)                                      \
>> > +     do {                                                                    \
>> > +             if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&                      \
>> > +                 (!__local_lock_is_locked(lock) || in_nmi()))                \
>> > +                     WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));    \
>> > +             else                                                            \
>> > +                     __local_lock_irqsave(lock, flags);                      \
>> > +     } while (0)
>> > +
>>
>> Hmm. If I see this right in SLUB then this is called from preemptible
>> context. Therefore the this_cpu_ptr() from __local_lock_is_locked()
>> should trigger a warning here.
> 
> When preemptible the migration is disabled. So no warning.
> 
>> This check variant provides only additional debugging and otherwise
>> behaves as local_lock_irqsave(). Therefore the in_nmi() should return
>> immediately with a WARN_ON() regardless if the lock is available or not
>> because the non-try variant should never be invoked from an NMI.
> 
> non-try variant can be invoked from NMI, because the earlier
> __local_lock_is_locked() check tells us that the lock is not locked.
> And it's safe to do.
> And that's the main challenge here.
> local_lock_irqsave_check() macro fights lockdep here.
> 
>> This looks like additional debug infrastructure that should be part of
>> local_lock_irqsave() itself,
> 
> The pattern of
> 
> if (!__local_lock_is_locked(lock)) {
>    .. lots of code..
>    local_lock_irqsave(lock);
> 
> is foreign to lockdep.
> 
> Since it can be called from NMI the lockdep just hates it:
> 
> [ 1021.956825] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> ...
> [ 1021.956888]   lock(per_cpu_ptr(&lock));
> [ 1021.956890]   <Interrupt>
> [ 1021.956891]     lock(per_cpu_ptr(&lock));
> ..
> 
> and technically lockdep is correct.
> For any normal lock it's a deadlock waiting to happen,
> but not here.
> 
> Even without NMI the lockdep doesn't like it:
> [   14.627331] page_alloc_kthr/1965 is trying to acquire lock:
> [   14.627331] ffff8881f6ebe0f0 ((local_lock_t
> *)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0x9a9/0x1ab0
> [   14.627331]
> [   14.627331] but task is already holding lock:
> [   14.627331] ffff8881f6ebd490 ((local_lock_t
> *)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0xc7/0x1ab0
> [   14.627331]
> [   14.627331] other info that might help us debug this:
> [   14.627331]  Possible unsafe locking scenario:
> [   14.627331]
> [   14.627331]        CPU0
> [   14.627331]        ----
> [   14.627331]   lock((local_lock_t *)&c->lock);
> [   14.627331]   lock((local_lock_t *)&c->lock);
> 
> When slub is holding lock ...bd490 we detect it with
> __local_lock_is_locked(),
> then we check that lock ..be0f0 is not locked,
> and proceed to acquire it, but
> lockdep will show the above splat.
> 
> So local_lock_irqsave_check() is a workaround to avoid
> these two false positives from lockdep.
> 
> Yours and Vlastimil's observation is correct, that ideally
> local_lock_irqsave() should just handle it,
> but I don't see how to do it.
> How can lockdep understand the if (!locked()) lock() pattern ?
> Such usage is correct only for per-cpu local lock when migration
> is disabled from check to acquire.

Thanks, I think I finally understand the issue and why a _check variant is
necessary. As a general note as this is so tricky, having more details in
comments and commit messages can't hurt so we can understand it sooner :)

Again this would be all simpler if we could just use trylock instead of
_check(), but then we need to handle the fallbacks. And AFAIU on RT trylock
can fail "spuriously", i.e. when we don't really preempt ourselves, as we
discussed in that memcg thread.

> Hence the macro is doing:
> if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
>    (!__local_lock_is_locked(lock) || in_nmi()))
>          WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));
> 
> in_nmi() part is a workaround for the first lockdep splat
> and __local_lock_is_locked() is a workaround for 2nd lockdep splat,
> though the code did __local_lock_is_locked() check already.

So here's where this would be useful to have that info in a comment.
However, I wonder about it, as the code uses __local_trylock_irqsave(), so
lockdep should see it as an opportunistic attempt and not splat as that
trylock alone should be avoiding deadlock - if not we might have a bug in
the lockdep bits of trylock.

> In your other email you wonder whether
> rt_mutex_base_is_locked() should be enough.
> It's not.
> We need to check:
> __local_lock_is_locked(__lock) \
> rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current
> 
> Because the following sequence is normal in PREEMP_RT:
> kmalloc
>   local_lock_irqsave(lock_A)
>      preemption
>         kmalloc_nolock
>            if (is_locked(lock_A) == true)
>                retry:  is_locked(lock_B) == false
>                          local_lock_irqsave_check(lock_B)
> 
> while lock_B could be locked on another CPU by a different task.
> So we cannot trylock(lock_B) here.
> Hence in PREEMPT_RT
> __local_lock_irqsave_check() is doing:
> WARN_ON_ONCE(__local_lock_is_locked(lock));
> spin_lock(this_cpu_ptr((lock)));


