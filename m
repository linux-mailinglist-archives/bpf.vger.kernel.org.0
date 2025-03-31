Return-Path: <bpf+bounces-54959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8FA765A4
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C324A188983D
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A891E5205;
	Mon, 31 Mar 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoahoAHh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EaYcS6pK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yoahoAHh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EaYcS6pK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B701ADC69
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423474; cv=none; b=gMHhQjwNiYv2rjoR3C8zBUb7LBNU9Kbkouc4OxCm6WLOA3w4QJ1sZyx6aMb9exx/Jr3Qxx+UKTaIkKHAif7nTn+vhr47rrdKat8D63Dp0m4WrsL+5AZSkT3lpkPtQIPjV4zIQT1SGJwiyPFn2FX0eCyjDrlP9TEpKuGVt2pB6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423474; c=relaxed/simple;
	bh=XiU6XXZh7I2bVg3HYxXrfGTUzcpkCnRZ5VDh0RelhA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOc+QwmqFumc/jm/b/gPiY4sLzEHZExTmf13RAcwKElzgi0rAomoq6FFh6BloTjR0ympAICHNB2R0/L928Ww6JQjS1vKsW47oLaql765bxN34bdFu0C9fZ3PfPHsm7T5M9DDA8/4p/CDtXbI4BbT24GnSApFDpP8O5X2arNJPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoahoAHh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EaYcS6pK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yoahoAHh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EaYcS6pK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 846E91F38D;
	Mon, 31 Mar 2025 12:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743423470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oArW10f+nxGARF7+t8CNupKdBShoEMsJB1abiQpAdLM=;
	b=yoahoAHh3yp3ahPbxKNhDvzTyUxLXL/uumJF48ldJ3Li5oukjBFBATYY+0uThGdp8CT/LQ
	JOoGlEDDAahUhccs3prywY6WKb2GvbOIKhe1+JQ+v8igWI1vxBcfDxQrddJOs4Xw94XHWJ
	GJibedOnHde9unjDeAuuExoCxHdB8hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743423470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oArW10f+nxGARF7+t8CNupKdBShoEMsJB1abiQpAdLM=;
	b=EaYcS6pKOcf5tfcfHlmkzt7UN62yDfHrSYadIWuWSRGwU/FmcbZTJgxw/RoY7zdhb67epB
	gLIeXAwQWLEUJvDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yoahoAHh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EaYcS6pK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743423470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oArW10f+nxGARF7+t8CNupKdBShoEMsJB1abiQpAdLM=;
	b=yoahoAHh3yp3ahPbxKNhDvzTyUxLXL/uumJF48ldJ3Li5oukjBFBATYY+0uThGdp8CT/LQ
	JOoGlEDDAahUhccs3prywY6WKb2GvbOIKhe1+JQ+v8igWI1vxBcfDxQrddJOs4Xw94XHWJ
	GJibedOnHde9unjDeAuuExoCxHdB8hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743423470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oArW10f+nxGARF7+t8CNupKdBShoEMsJB1abiQpAdLM=;
	b=EaYcS6pKOcf5tfcfHlmkzt7UN62yDfHrSYadIWuWSRGwU/FmcbZTJgxw/RoY7zdhb67epB
	gLIeXAwQWLEUJvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8EA139A1;
	Mon, 31 Mar 2025 12:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tlWfFO6H6mfJCQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 31 Mar 2025 12:17:50 +0000
Message-ID: <aeac0a2e-bf4a-4a73-8c64-6244978284b1@suse.cz>
Date: Mon, 31 Mar 2025 14:17:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 akpm@linux-foundation.org, peterz@infradead.org, bigeasy@linutronix.de,
 rostedt@goodmis.org, shakeel.butt@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
 <Z-p0B27EtOW_lswI@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z-p0B27EtOW_lswI@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 846E91F38D
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[suse.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/31/25 12:52, Michal Hocko wrote:
> On Sun 30-03-25 17:28:09, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>> 
>> spin_trylock followed by spin_lock will cause extra write cache
>> access. If the lock is contended it may cause unnecessary cache
>> line bouncing

Right.

> and will execute redundant irq restore/save pair.

Maybe that part matters less if we're likely to have to spin anyway - it
doesn't affect other cpus at least unlike the bouncing.

>> Therefore, check alloc/fpi_flags first and use spin_trylock or
>> spin_lock.

Yeah this should be still ok for the zone lock as the fast paths are using
pcplists, so we still shouldn't be making page allocator slower due to the
try_alloc addition.

>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> Makes sense. Fixes tag is probably over reaching but whatever.

It's fixing 6.15-rc1 code so no possible stable implications anyway.

> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Thanks!
> 
>> ---
>>  mm/page_alloc.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e3ea5bf5c459..ffbb5678bc2f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1268,11 +1268,12 @@ static void free_one_page(struct zone *zone, struct page *page,
>>  	struct llist_head *llhead;
>>  	unsigned long flags;
>>  
>> -	if (!spin_trylock_irqsave(&zone->lock, flags)) {
>> -		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
>> +	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
>> +		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>>  			add_page_to_zone_llist(zone, page, order);
>>  			return;
>>  		}
>> +	} else {
>>  		spin_lock_irqsave(&zone->lock, flags);
>>  	}
>>  
>> @@ -2341,9 +2342,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>>  	unsigned long flags;
>>  	int i;
>>  
>> -	if (!spin_trylock_irqsave(&zone->lock, flags)) {
>> -		if (unlikely(alloc_flags & ALLOC_TRYLOCK))
>> +	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
>> +		if (!spin_trylock_irqsave(&zone->lock, flags))
>>  			return 0;
>> +	} else {
>>  		spin_lock_irqsave(&zone->lock, flags);
>>  	}
>>  	for (i = 0; i < count; ++i) {
>> @@ -2964,9 +2966,10 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>>  
>>  	do {
>>  		page = NULL;
>> -		if (!spin_trylock_irqsave(&zone->lock, flags)) {
>> -			if (unlikely(alloc_flags & ALLOC_TRYLOCK))
>> +		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
>> +			if (!spin_trylock_irqsave(&zone->lock, flags))
>>  				return NULL;
>> +		} else {
>>  			spin_lock_irqsave(&zone->lock, flags);
>>  		}
>>  		if (alloc_flags & ALLOC_HIGHATOMIC)
>> -- 
>> 2.47.1
> 


