Return-Path: <bpf+bounces-57512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF7AAAC4C0
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F4B1774BD
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5628000C;
	Tue,  6 May 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rUKTixUh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CpXdeFV7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rUKTixUh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CpXdeFV7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF827FD54
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536210; cv=none; b=DBRmTVQXMu4o4p++apJ4/ejEGXfQqYwVq+8mG2GbxntNrghgzREvc2yllFVf+T3ZwilkBFton06yITdR8gvbrJr8q/4pTXYoiWgzX4G00Z9delbL6DxphqVqtvXwoSmiNYDZeRblqZAz/E6sr2E/Ydu/MD6tfJwG4MMGXlIVx+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536210; c=relaxed/simple;
	bh=8j2GzBKRF3zjzVNXWvVGmSJCQBsHLzSsvWb4DrvLnLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSeH8UvDy1JnLU6gDBhBrYhLMVAMnigvHILrfCg8U6vUtql0ccO8l71y3q6/C9nXrY0BZy3LIOJeu22iWdc+KkMcVOEy3bQKGzF5kUr3e85PKA9KTp0YZBgRHK2RKnjl5Q+iwQeUFhWsWAI9YeYP4JKq0Zz60G5D4lyu0ulg9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rUKTixUh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CpXdeFV7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rUKTixUh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CpXdeFV7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B831321226;
	Tue,  6 May 2025 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746536206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hunScdSIxp8Vg1m4zyx7MIsCc9J0eZolhrA9JPok3M0=;
	b=rUKTixUhd7ToKR+ybMdrnQsfLIlKJabORXiML9F3t+ZOEKAhmB3XgdtBlkkmG9WesZ7qLX
	CN31JDL4U+aY6176EFk2+y4lHIhUSHul1+nf+lHvlNKtq4y3j5WribYtWu2FrhaqOIOXKn
	7mAp5eQ1xdj3+eItKZDyIE/cTJ18H7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746536206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hunScdSIxp8Vg1m4zyx7MIsCc9J0eZolhrA9JPok3M0=;
	b=CpXdeFV7aoRZQ/2m4cofwvJkHaGy1QDhSGWUZYpAvd+x2yZdFjLALXpv0zw7hjpIL9I4dP
	qiep5aA4K5ObyMDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rUKTixUh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CpXdeFV7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746536206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hunScdSIxp8Vg1m4zyx7MIsCc9J0eZolhrA9JPok3M0=;
	b=rUKTixUhd7ToKR+ybMdrnQsfLIlKJabORXiML9F3t+ZOEKAhmB3XgdtBlkkmG9WesZ7qLX
	CN31JDL4U+aY6176EFk2+y4lHIhUSHul1+nf+lHvlNKtq4y3j5WribYtWu2FrhaqOIOXKn
	7mAp5eQ1xdj3+eItKZDyIE/cTJ18H7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746536206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hunScdSIxp8Vg1m4zyx7MIsCc9J0eZolhrA9JPok3M0=;
	b=CpXdeFV7aoRZQ/2m4cofwvJkHaGy1QDhSGWUZYpAvd+x2yZdFjLALXpv0zw7hjpIL9I4dP
	qiep5aA4K5ObyMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9788713687;
	Tue,  6 May 2025 12:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E1KrJA4HGmh6MgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 May 2025 12:56:46 +0000
Message-ID: <9e19b706-4c3c-4d62-b7f2-5936ca842060@suse.cz>
Date: Tue, 6 May 2025 14:56:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] locking/local_lock: Expose dep_map in
 local_trylock_t.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-3-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250501032718.65476-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B831321226
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 5/1/25 05:27, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
> is a top level field of any lock that participates in LOCKDEP.
> Make it so for local_trylock_t.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/local_lock_internal.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index bf2bf40d7b18..29df45f95843 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -17,7 +17,10 @@ typedef struct {
>  
>  /* local_trylock() and local_trylock_irqsave() only work with local_trylock_t */
>  typedef struct {
> -	local_lock_t	llock;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map	dep_map;
> +	struct task_struct	*owner;
> +#endif
>  	u8		acquired;
>  } local_trylock_t;
>  
> @@ -31,7 +34,7 @@ typedef struct {
>  	.owner = NULL,
>  
>  # define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
> -	.llock = { LOCAL_LOCK_DEBUG_INIT((lockname).llock) },
> +	LOCAL_LOCK_DEBUG_INIT(lockname)
>  
>  static inline void local_lock_acquire(local_lock_t *l)
>  {
> @@ -81,7 +84,7 @@ do {								\
>  	local_lock_debug_init(lock);				\
>  } while (0)
>  
> -#define __local_trylock_init(lock) __local_lock_init(lock.llock)
> +#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)lock)

This cast seems unnecessary. Better not hide mistakes when using the
local_trylock_init() macro.

>  
>  #define __spinlock_nested_bh_init(lock)				\
>  do {								\


