Return-Path: <bpf+bounces-57513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEEAAC505
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F117F3BF692
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E9280A3D;
	Tue,  6 May 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Brmv+GDb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0IeWWCQ+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Brmv+GDb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0IeWWCQ+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2642280319
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536398; cv=none; b=HClz97EZ05PILuw5nKyObTYAqyDMBXvIm8WYNQA6WjB6mNKQUz+cBYv7HfzEbmXPnn5wf1hSPerIFKi/vmsDTDMGBU8UVdbgsA58HdEclc5Bvp9vP62VVXJ2V+FmFNK6RE4ih98nsXxBtLBy4xHy52IWE65XjdQD7ZmN8zz43E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536398; c=relaxed/simple;
	bh=k0qbTJ7zVSNyl1w7+/waiR856rjrtu0lO5hW8ENxNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pag/5QA4UBKvWX3dR4WtldDP9iw1vxLer7nKN5gk6gObXVS8x8JGJSgtRPXEttVFHu4SycwQbxD7lq3izZZYQgV0cHY1j90BIvGkMVqXN3wPGV6KMxE1091xO0kKFjo8luFyYpXPjKUyeOS3cxXhUmTV4HBtXQuPMjq1ETZwNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Brmv+GDb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0IeWWCQ+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Brmv+GDb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0IeWWCQ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99AF71F7CC;
	Tue,  6 May 2025 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746536394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LE288l1OjNqKRkvvMw8NUANY6m2+aW6j7ftSgAAUxjs=;
	b=Brmv+GDbbaZI8nnTTjKvvWkSZQpx+O47c25SxiaYph71lFHXyckCO1nK1ICZFD/wM85lPv
	no8Da9lgStssS7PjcDLdM2ihEqDjaQwnMv3bajjEr76frANBZlVVyDNnCPxV56dAfhNHm3
	IHiSFGlKsXTvUX50Aad11so7hB/3v1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746536394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LE288l1OjNqKRkvvMw8NUANY6m2+aW6j7ftSgAAUxjs=;
	b=0IeWWCQ+hkKQAt2Jf/PboVlhZwlCcUFpQiQRh64K0PokVha2z5p2qtLy+nizUUi+CAg0my
	FEx7xI7r1llasNBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Brmv+GDb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0IeWWCQ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746536394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LE288l1OjNqKRkvvMw8NUANY6m2+aW6j7ftSgAAUxjs=;
	b=Brmv+GDbbaZI8nnTTjKvvWkSZQpx+O47c25SxiaYph71lFHXyckCO1nK1ICZFD/wM85lPv
	no8Da9lgStssS7PjcDLdM2ihEqDjaQwnMv3bajjEr76frANBZlVVyDNnCPxV56dAfhNHm3
	IHiSFGlKsXTvUX50Aad11so7hB/3v1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746536394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LE288l1OjNqKRkvvMw8NUANY6m2+aW6j7ftSgAAUxjs=;
	b=0IeWWCQ+hkKQAt2Jf/PboVlhZwlCcUFpQiQRh64K0PokVha2z5p2qtLy+nizUUi+CAg0my
	FEx7xI7r1llasNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7841913687;
	Tue,  6 May 2025 12:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /fUCHcoHGmh0MwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 May 2025 12:59:54 +0000
Message-ID: <5e708851-6e8a-4ec8-81ee-55a55d1e3d2c@suse.cz>
Date: Tue, 6 May 2025 14:59:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] locking/local_lock: Introduce local_lock_is_locked().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-4-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250501032718.65476-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99AF71F7CC
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 5/1/25 05:27, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce local_lock_is_locked() that returns true when
> given local_lock is locked by current cpu (in !PREEMPT_RT) or
> by current task (in PREEMPT_RT).
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

On !RT this only works for local_trylock_t, which is fine, but maybe make it
part of the name then? local_trylock_is_locked()?

> ---
>  include/linux/local_lock.h          | 2 ++
>  include/linux/local_lock_internal.h | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 16a2ee4f8310..092ce89b162a 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -66,6 +66,8 @@
>   */
>  #define local_trylock(lock)		__local_trylock(lock)
>  
> +#define local_lock_is_locked(lock)	__local_lock_is_locked(lock)
> +
>  /**
>   * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
>   *			   interrupts if acquired
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index 29df45f95843..263723a45ecd 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -165,6 +165,9 @@ do {								\
>  		!!tl;						\
>  	})
>  
> +/* preemption or migration must be disabled before calling __local_lock_is_locked */
> +#define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
> +
>  #define __local_lock_release(lock)					\
>  	do {								\
>  		local_trylock_t *tl;					\
> @@ -285,4 +288,9 @@ do {								\
>  		__local_trylock(lock);				\
>  	})
>  
> +/* migration must be disabled before calling __local_lock_is_locked */
> +#include "../../kernel/locking/rtmutex_common.h"
> +#define __local_lock_is_locked(__lock)					\
> +	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
> +
>  #endif /* CONFIG_PREEMPT_RT */


