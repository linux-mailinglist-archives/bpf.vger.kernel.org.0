Return-Path: <bpf+bounces-55215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C4BA7A002
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 11:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38773170560
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5475243399;
	Thu,  3 Apr 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Go74T+tU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo5K1YJs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Go74T+tU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo5K1YJs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A811E5B8B
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672407; cv=none; b=s+HFYOLQYGCABbXIEQWwKZeu6OkYA40uHix3ESTrvz5dgd/Mr7qTVOQJb0ZuGjT7iT1caXHNN38z/NkIBEliC9nsxoMfqA4tYwpr3Xa2AgP/TrF/05//h7ETidz0mdR79DJl/5ONNK6sO6rwtECdOPs9iVIHXbDf8dzWVDjj8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672407; c=relaxed/simple;
	bh=3kt8uZWFqgd+7TiQBoV1mBy2E5+2zlC3Ohx8tCaBTJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOWTrl4hVR+aFh+cLkB/LyPqWFyCzpCwcXTGeFZGXdvVTPXvrhMlinMT3yR8bnmhfmQGHBMoSEentGUsevcfZWTU4U92VOUloaR7oSwPoMfqsGrwjazlR9TE9tR+3SRWW9CYcdnUVmlowpt9DeJdket9hWEF1/hxh6RHjqAl1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Go74T+tU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo5K1YJs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Go74T+tU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo5K1YJs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3946C2119C;
	Thu,  3 Apr 2025 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743672396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5JBiagd/IaphZnNyD5cE9CP+4ou/BNEE11+z/xpLv8=;
	b=Go74T+tUMTM6OYdgLA37QBOkBLwM+KvGmRKuScprELaI3wS+y+CEE0CAGHNeZpSu42E4HC
	PS4zr7Qb+kuj+u0fqs7wZGYgJs+8ZJTPubY1mLgqZrdVKHNGouW1eOPXNA83eeDL7OXWaT
	wz/auDH67aPVt+xsgV9PkVm2z0QNIrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743672396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5JBiagd/IaphZnNyD5cE9CP+4ou/BNEE11+z/xpLv8=;
	b=Yo5K1YJsEQjD37r4hoFAPojI/47BnHdlm4EGwH/fr7Ve751Vut4k5R/Mwyg8w3kGQRfuid
	PkQezbA8/O+1sSCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743672396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5JBiagd/IaphZnNyD5cE9CP+4ou/BNEE11+z/xpLv8=;
	b=Go74T+tUMTM6OYdgLA37QBOkBLwM+KvGmRKuScprELaI3wS+y+CEE0CAGHNeZpSu42E4HC
	PS4zr7Qb+kuj+u0fqs7wZGYgJs+8ZJTPubY1mLgqZrdVKHNGouW1eOPXNA83eeDL7OXWaT
	wz/auDH67aPVt+xsgV9PkVm2z0QNIrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743672396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5JBiagd/IaphZnNyD5cE9CP+4ou/BNEE11+z/xpLv8=;
	b=Yo5K1YJsEQjD37r4hoFAPojI/47BnHdlm4EGwH/fr7Ve751Vut4k5R/Mwyg8w3kGQRfuid
	PkQezbA8/O+1sSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 146AD13A2C;
	Thu,  3 Apr 2025 09:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JThnBExU7mdkbgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Apr 2025 09:26:36 +0000
Message-ID: <78c2d3be-aa8e-4bb7-8883-7f144a06f866@suse.cz>
Date: Thu, 3 Apr 2025 11:26:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250401205245.70838-1-alexei.starovoitov@gmail.com>
 <umfukiohyxcxxw5g6ca5g7stq7oonnr3sbvjyjshnbqalzffeq@2nrwqsmwcrug>
 <CAADnVQLHakKsVEbKiENF8eV0fEAtbVbL0b_QbJO2b0dH9r7PSw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQLHakKsVEbKiENF8eV0fEAtbVbL0b_QbJO2b0dH9r7PSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,linux.dev:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 4/2/25 23:40, Alexei Starovoitov wrote:
> On Wed, Apr 2, 2025 at 1:56 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Tue, Apr 01, 2025 at 01:52:45PM -0700, Alexei Starovoitov wrote:
>> > From: Alexei Starovoitov <ast@kernel.org>
>> >
>> > Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
>> > Remove localtry_*() helpers, since localtry_lock() name might
>> > be misinterpreted as "try lock".
>> >
>> > Introduce local_trylock[_irqsave]() helpers that only work
>> > with newly introduced local_trylock_t type.
>> > Note that attempt to use local_trylock[_irqsave]() with local_lock_t
>> > will cause compilation failure.
>> >
>> > Usage and behavior in !PREEMPT_RT:
>> >
>> > local_lock_t lock;                     // sizeof(lock) == 0
>> > local_lock(&lock);                     // preempt disable
>> > local_lock_irqsave(&lock, ...);        // irq save
>> > if (local_trylock_irqsave(&lock, ...)) // compilation error
>> >
>> > local_trylock_t lock;                  // sizeof(lock) == 4
>>
>> Is there a reason for this 'acquired' to be int? Can it be uint8_t? No
>> need to change anything here but I plan to change it later to compact as
>> much as possible within one (or two) cachline for memcg stocks.
> 
> I don't see any issue. I can make it u8 right away.

Are you planning to put the lock near other <64bit sized values in memcg
stock? Otherwise it will be padded anyway?

I hope it won't hurt the performance though, AFAIK at least sub-word atomics
are much slower than using a full word. But we use only read/write once for
acquired so hopefully it's fine?

>> > local_lock(&lock);                     // preempt disable, acquired = 1
>> > local_lock_irqsave(&lock, ...);        // irq save, acquired = 1
>> > if (local_trylock(&lock))              // if (!acquired) preempt disable
>> > if (local_trylock_irqsave(&lock, ...)) // if (!acquired) irq save
>>
>> For above two ", acquired = 1" as well.
> 
> I felt it would be too verbose and not accurate anyway,
> since irq save will be done before the check.
> It's a pseudo code.
> But sure, I can add.
> 
>>
>> >
>> > The existing local_lock_*() macros can be used either with
>> > local_lock_t or local_trylock_t.
>> > With local_trylock_t they set acquired = 1 while local_unlock_*() clears it.
>> >
>> > In !PREEMPT_RT local_lock_irqsave(local_lock_t *) disables interrupts
>> > to protect critical section, but it doesn't prevent NMI, so the fully
>> > reentrant code cannot use local_lock_irqsave(local_lock_t *) for
>> > exclusive access.
>> >
>> > The local_lock_irqsave(local_trylock_t *) helper disables interrupts
>> > and sets acquired=1, so local_trylock_irqsave(local_trylock_t *) from
>> > NMI attempting to acquire the same lock will return false.
>> >
>> > In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
>> > Map local_trylock_irqsave() to preemptible spin_trylock().
>> > When in hard IRQ or NMI return false right away, since
>> > spin_trylock() is not safe due to explicit locking in the underneath
>> > rt_spin_trylock() implementation. Removing this explicit locking and
>> > attempting only "trylock" is undesired due to PI implications.
>> >
>> > The local_trylock() without _irqsave can be used to avoid the cost of
>> > disabling/enabling interrupts by only disabling preemption, so
>> > local_trylock() in an interrupt attempting to acquire the same
>> > lock will return false.
>> >
>> > Note there is no need to use local_inc for acquired variable,
>> > since it's a percpu variable with strict nesting scopes.
>> >
>> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks!


