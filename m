Return-Path: <bpf+bounces-55214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD06A79FBB
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876E43A950D
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987DD241CA4;
	Thu,  3 Apr 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf2ctPoL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r74Dtkjs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jf2ctPoL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r74Dtkjs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857CA54F81
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671407; cv=none; b=CLqTDvxSkMyFrnDpSr4Y/PMaA4ZtRaP55c0hKH3N/teqo/jBkpN8TDa25udUPyZ9k/455FwlsUdJ19VCIDHSs6hiWaOLzubrodICD5mrFu/4BLs5Y7e8u8Vhn/cjXCjIduaMIdOB1JDIiQBPpS2f0Y5cYAHEuYigGqM4wmx0bK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671407; c=relaxed/simple;
	bh=HHxZIAZcwZOnAq4xhrNoZfpUIfBIEeEfgyvQXZlNywg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU72vSrGhq5b0Bj7dLtEUaPmUcpFPYTy+SBITKdNdvrcWTdXSUf37ogeVsR5u4CRePNUCSPgiYSgxj0uuqy9OKD1PXUQGb17fwFj8Bk8DjkZVh195IBptRwWBWLSDbugCAPcHphZXiUHMq0mPIf3BTP+Gi1Z9kXBoyuKbWrXBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf2ctPoL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r74Dtkjs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jf2ctPoL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r74Dtkjs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69F661F385;
	Thu,  3 Apr 2025 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743671398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6atIuqWpPN4lEFGJe1apHKHtKrhoP192orQSgXjdE=;
	b=Jf2ctPoLw+9eqnbDiBxwHWRRYdaAokyiPC6zyUFxb394F715kljGMU5IHg2ZrFd3cHgLwi
	2ScUKkUDX4RuD1EWBz0g78imjTFrVZ3rQuzl+pQjPXoIskbrx7SUOgj5zEvjZb/O9n90iS
	JM95pblnr7x5kors/5rEQVbEudmW+4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743671398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6atIuqWpPN4lEFGJe1apHKHtKrhoP192orQSgXjdE=;
	b=r74Dtkjs4whoZ8fRok7/dhf+dGMIPKcf3Vj1vlBZptk1vRnrK8L13Vsr3bde6ds1S1HrSm
	Io/aN/mAxspXMHAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743671398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6atIuqWpPN4lEFGJe1apHKHtKrhoP192orQSgXjdE=;
	b=Jf2ctPoLw+9eqnbDiBxwHWRRYdaAokyiPC6zyUFxb394F715kljGMU5IHg2ZrFd3cHgLwi
	2ScUKkUDX4RuD1EWBz0g78imjTFrVZ3rQuzl+pQjPXoIskbrx7SUOgj5zEvjZb/O9n90iS
	JM95pblnr7x5kors/5rEQVbEudmW+4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743671398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs6atIuqWpPN4lEFGJe1apHKHtKrhoP192orQSgXjdE=;
	b=r74Dtkjs4whoZ8fRok7/dhf+dGMIPKcf3Vj1vlBZptk1vRnrK8L13Vsr3bde6ds1S1HrSm
	Io/aN/mAxspXMHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BFAE13A2C;
	Thu,  3 Apr 2025 09:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wRqNEGZQ7meBZwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Apr 2025 09:09:58 +0000
Message-ID: <5feaf4c7-4970-4d9b-84a2-fcba2cbe0bc4@suse.cz>
Date: Thu, 3 Apr 2025 11:09:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com>
 <20250402073032.rqsmPfJs@linutronix.de>
 <62dd026d-1290-49cb-a411-897f4d5f6ca7@suse.cz>
 <CAADnVQLce4pH4DJW2WW6W2-ct-17OnQE7D8q7KiwdNougis2BQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQLce4pH4DJW2WW6W2-ct-17OnQE7D8q7KiwdNougis2BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/2/25 23:35, Alexei Starovoitov wrote:
> On Wed, Apr 2, 2025 at 2:02 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> This is because the macro specifies the type:
> DEFINE_GUARD(local_lock, local_lock_t __percpu*,
> 
> and that type is used to define two static inline functions
> with that type,
> so by the time our __local_lock_acquire() macro is used
> it sees 'local_lock_t *' and not the actual type of memcg.stock_lock.

Hm but I didn't even try to instantiate any guard. In fact the compilation
didn't even error on compiling my slub.o but earlier in compiling
arch/x86/kernel/asm-offsets.c

I think the problem is rather that the guard creates static inline functions
and _Generic() only works via macros as you pointed out in the reply to Andrew?

I guess it's solvable if we care in the future, but it means more code
duplication - move the _Generic() dispatch outside the whole implementation
to choose between two variants, have guards use use the specific variant
directly without _Generic()?

Or maybe there's a simpler way I'm just not familiar with both the guards
and _Generic() enough.

> Your macro can be hacked with addition of:
> local_lock_t *l = NULL;
> ...
> l = (void *)this_cpu_ptr(lock);
> ...
> tl = (void *)this_cpu_ptr(lock);
> ...
> DEFINE_GUARD(local_lock, void __percpu*,
> 
> then
> guard(local_lock)(&memcg_stock.stock_lock);
> 
> will compile without warnings with both
> typeof(stock_lock) = local_lock_t and local_trylock_t,
> 
> but the generated code will take default:(void)0) path
> and will pass NULL into local_lock_acquire(NULL);
> 
> In other words guard(local_lock) can only support one
> specific type. It cannot be made polymorphic with _Generic() trick.
> This is an unfortunate tradeoff with this approach.
> Thankfully there are no users of it in the tree:
> git grep 'guard(local'|wc -l
> 0
> 
> so I think it's ok that guard(local_lock) can only be used with local_lock_t.



