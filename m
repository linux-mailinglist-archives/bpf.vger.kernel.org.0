Return-Path: <bpf+bounces-63237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF915B0476F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D2C4A1876
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654E2253EA;
	Mon, 14 Jul 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHXl/LaQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ph2fMKjg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHXl/LaQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ph2fMKjg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA31223DDE
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752518026; cv=none; b=e2UDUaDgIfL05aE2dVPTR/flS2idmsWuzIGyy//N+WDAOxHxzkaUIWlJ6mdjmHfxk9x432goPkCjhaKaZp6LQUnXgVtzItgmxzU55F1DBH6E0mATARceOxIcr6lgGPWDRhvbHuPTZOzVDuyE/JRDo1LnannKG0wNkpA0IRBsY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752518026; c=relaxed/simple;
	bh=eT51e6BhuTrBzsuB3p5M4QkrGEvY+sp4H+7mxCHdQy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfO0N52f1j4yU9h1ctuHKRgV1YCSwO/HXSR72mpk/84uSFPM2UxvfTd8KGbpBzEtNHqN1toQlwGdg2d9n7FzBzSt6fj9aqtKwbIqk+mgtxdepuZ1s2Qb/FlSI1B6IrX+lLc8zGqQJ0xYfAkST/aHC5ruL8ME8fS58NVLuC7yEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHXl/LaQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ph2fMKjg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHXl/LaQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ph2fMKjg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02BF921238;
	Mon, 14 Jul 2025 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752518022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6/FGE+NMOoxKuuWL4wAXRaERggEBLB22rEACtZeDsPs=;
	b=rHXl/LaQTiPxR9PqjCO1KWD2cwCIIf74F3WStWf6yr3DnmtexQin4/HJ2IoUEZ2ogsg0Fd
	5n73DHzdAU2990oJPR4YG9e7l5OeBsHfoF8VIp39P63kkWM395psTbZkXZXGfTjMjLLsKH
	AM0bFymJqLUhDqslQYwXewC1inJ/HEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752518022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6/FGE+NMOoxKuuWL4wAXRaERggEBLB22rEACtZeDsPs=;
	b=ph2fMKjgBs/HaQcSMqTfxinwIbrVAriS/e0zdHptNf+s4MULTxYv/mTyn1auZTdiaEJ8RD
	+PE0fXBkaVyLs3AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752518022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6/FGE+NMOoxKuuWL4wAXRaERggEBLB22rEACtZeDsPs=;
	b=rHXl/LaQTiPxR9PqjCO1KWD2cwCIIf74F3WStWf6yr3DnmtexQin4/HJ2IoUEZ2ogsg0Fd
	5n73DHzdAU2990oJPR4YG9e7l5OeBsHfoF8VIp39P63kkWM395psTbZkXZXGfTjMjLLsKH
	AM0bFymJqLUhDqslQYwXewC1inJ/HEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752518022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6/FGE+NMOoxKuuWL4wAXRaERggEBLB22rEACtZeDsPs=;
	b=ph2fMKjgBs/HaQcSMqTfxinwIbrVAriS/e0zdHptNf+s4MULTxYv/mTyn1auZTdiaEJ8RD
	+PE0fXBkaVyLs3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D95F513306;
	Mon, 14 Jul 2025 18:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zyJLNIVNdWjWbAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Jul 2025 18:33:41 +0000
Message-ID: <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
Date: Mon, 14 Jul 2025 20:33:41 +0200
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
 <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_TO(0.00)[gmail.com,linutronix.de];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 7/14/25 19:52, Alexei Starovoitov wrote:
> On Mon, Jul 14, 2025 at 4:06 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2025-07-11 19:19:26 [-0700], Alexei Starovoitov wrote:
>> > > If there is no parent check then we could do "normal lock" on both
>> > > sides.
>> >
>> > How would ___slab_alloc() know whether there was a parent check or not?
>> >
>> > imo keeping local_lock_irqsave() as-is is cleaner,
>> > since if there is no parent check lockdep will rightfully complain.
>>
>> what about this:
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 7e2ffe1d46c6c..3520d1c25c205 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3693,6 +3693,34 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
>>         return freelist;
>>  }
>>
>> +static void local_lock_cpu_slab(struct kmem_cache *s, const gfp_t gfp_flags,
>> +                               unsigned long *flags)
>> +{
>> +       bool allow_spin = gfpflags_allow_spinning(gfp_flags);
>> +
>> +       /*
>> +        * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
>> +        * can be acquired without a deadlock before invoking the function.
>> +        *
>> +        * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
>> +        * disabled context. The lock will always be acquired and if needed it
>> +        * block and sleep until the lock is available.
>> +        *
>> +        * On !PREEMPT_RT allocations from any context but NMI are safe. The lock
>> +        * is always acquired with disabled interrupts meaning it is always
>> +        * possible to it.
>> +        * In NMI context it is needed to check if the lock is acquired. If it is not,
>> +        * it is safe to acquire it. The trylock semantic is used to tell lockdep
>> +        * that we don't spin. The BUG_ON() will not trigger if it is safe to acquire
>> +        * the lock.
>> +        *
>> +        */
>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !allow_spin)
>> +               BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags));
>> +       else
>> +               local_lock_irqsave(&s->cpu_slab->lock, *flags);
>> +}
> 
> the patch misses these two:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 36779519b02c..2f30b85fbf68 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3260,7 +3260,7 @@ static void put_cpu_partial(struct kmem_cache
> *s, struct slab *slab, int drain)
>         unsigned long flags;
>         int slabs = 0;
> 
> -       local_lock_irqsave(&s->cpu_slab->lock, flags);
> +       local_lock_cpu_slab(s, 0, &flags);
> 
>         oldslab = this_cpu_read(s->cpu_slab->partial);
> 
> @@ -4889,8 +4889,9 @@ static __always_inline void do_slab_free(struct
> kmem_cache *s,
>                         goto redo;
>                 }
>         } else {
> +               long flags;
>                 /* Update the free list under the local lock */
> -               local_lock(&s->cpu_slab->lock);
> +               local_lock_cpu_slab(s, 0, &flags);
>                 c = this_cpu_ptr(s->cpu_slab);
>                 if (unlikely(slab != c->slab)) {
>                         local_unlock(&s->cpu_slab->lock);
> 
> I realized that the latter one was missing local_lock_lockdep_start/end()
> in my patch as well, but that's secondary.
> 
> So with above it works on !RT,
> but on RT lockdep complains as I explained earlier.
> 
> With yours and above hunks applied here is full lockdep splat:
> 
> [   39.819636] ============================================
> [   39.819638] WARNING: possible recursive locking detected
> [   39.819641] 6.16.0-rc5-00342-gc8aca7837440-dirty #54 Tainted: G           O
> [   39.819645] --------------------------------------------
> [   39.819646] page_alloc_kthr/2306 is trying to acquire lock:
> [   39.819650] ff110001f5cbea88 ((&c->lock)){+.+.}-{3:3}, at:
> ___slab_alloc+0xb7/0xec0
> [   39.819667]
> [   39.819667] but task is already holding lock:
> [   39.819668] ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
> ___slab_alloc+0xb7/0xec0
> [   39.819677]
> [   39.819677] other info that might help us debug this:
> [   39.819678]  Possible unsafe locking scenario:
> [   39.819678]
> [   39.819679]        CPU0
> [   39.819680]        ----
> [   39.819681]   lock((&c->lock));
> [   39.819684]   lock((&c->lock));
> [   39.819687]
> [   39.819687]  *** DEADLOCK ***
> [   39.819687]
> [   39.819687]  May be due to missing lock nesting notation
> [   39.819687]
> [   39.819689] 2 locks held by page_alloc_kthr/2306:
> [   39.819691]  #0: ff110001f5cbfe88 ((&c->lock)){+.+.}-{3:3}, at:
> ___slab_alloc+0xb7/0xec0
> [   39.819700]  #1: ffffffff8588f3a0 (rcu_read_lock){....}-{1:3}, at:
> rt_spin_lock+0x197/0x250
> [   39.819710]
> [   39.819710] stack backtrace:
> [   39.819714] CPU: 1 UID: 0 PID: 2306 Comm: page_alloc_kthr Tainted:
> G           O        6.16.0-rc5-00342-gc8aca7837440-dirty #54
> PREEMPT_RT
> [   39.819721] Tainted: [O]=OOT_MODULE
> [   39.819723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   39.819726] Call Trace:
> [   39.819729]  <TASK>
> [   39.819734]  dump_stack_lvl+0x5b/0x80
> [   39.819740]  print_deadlock_bug.cold+0xbd/0xca
> [   39.819747]  __lock_acquire+0x12ad/0x2590
> [   39.819753]  ? __lock_acquire+0x42b/0x2590
> [   39.819758]  lock_acquire+0x133/0x2d0
> [   39.819763]  ? ___slab_alloc+0xb7/0xec0
> [   39.819769]  ? try_to_take_rt_mutex+0x624/0xfc0
> [   39.819773]  ? __lock_acquire+0x42b/0x2590
> [   39.819778]  rt_spin_lock+0x6f/0x250

But why are we here in ___slab_alloc, trying to take the lock...

> [   39.819783]  ? ___slab_alloc+0xb7/0xec0
> [   39.819788]  ? rtlock_slowlock_locked+0x5c60/0x5c60
> [   39.819792]  ? rtlock_slowlock_locked+0xc3/0x5c60
> [   39.819798]  ___slab_alloc+0xb7/0xec0
> [   39.819803]  ? __lock_acquire+0x42b/0x2590
> [   39.819809]  ? my_debug_callback+0x20e/0x390 [bpf_testmod]
> [   39.819826]  ? __lock_acquire+0x42b/0x2590
> [   39.819830]  ? rt_read_unlock+0x2f0/0x2f0
> [   39.819835]  ? my_debug_callback+0x20e/0x390 [bpf_testmod]
> [   39.819844]  ? kmalloc_nolock_noprof+0x15a/0x430
> [   39.819849]  kmalloc_nolock_noprof+0x15a/0x430

When in patch 6/6 __slab_alloc() we should have bailed out via

	if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
+		if (local_lock_is_locked(&s->cpu_slab->lock)) {
+			/*
+			 * EBUSY is an internal signal to kmalloc_nolock() to
+			 * retry a different bucket. It's not propagated
+			 * to the caller.
+			 */
+			p = ERR_PTR(-EBUSY);
+			goto out;
+		}

So it doesn't seem to me as a lack of lockdep tricking, but we reached
something we should not have because the avoidance based on
local_lock_is_locked() above didn't work properly? At least if I read the
splat and backtrace properly, it doesn't seem to suggest a theoretical
scenario but that we really tried to lock something we already had locked.

> [   39.819857]  my_debug_callback+0x20e/0x390 [bpf_testmod]

What exactly did you instrument here?

> [   39.819867]  ? page_alloc_kthread+0x320/0x320 [bpf_testmod]
> [   39.819875]  ? lock_is_held_type+0x85/0xe0
> [   39.819881]  ___slab_alloc+0x256/0xec0

And here we took the lock originally?

> [   39.819898]  ? lock_acquire+0x133/0x2d0
> [   39.819927]  ? __kmalloc_cache_noprof+0xd6/0x3b0
> [   39.819932]  __kmalloc_cache_noprof+0xd6/0x3b0
> 
> As I said earlier lockdep _has_ to be tricked.
> We cannot unconditionally call local_lock_irqsave() on RT.
> lockdep doesn't understand per-cpu local_lock.
> And it doesn't understand this "if !locked_by_current_task -> go and lock"
> concept.
> lockdep has to be taught about safe lock region (call it tricking
> lockdep, but it has to be an external signal to lockdep).


