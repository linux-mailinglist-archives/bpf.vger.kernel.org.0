Return-Path: <bpf+bounces-29438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673348C1F95
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6331C20E1A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F30915FA66;
	Fri, 10 May 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gSCF4lyG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGKA/5gv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gSCF4lyG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGKA/5gv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329114901F;
	Fri, 10 May 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329260; cv=none; b=bhNqq6P72Jdyb9ikKQN4RWFJfDK+JPNym9F8P2eS8TZ0W7IS7Vywg7PfcUSVfIyLlCOLwaUAMtXP1DexVw46pwFD+6Rot6i8ni/ncmHzNXv8brpPIUtVgS4z8yQn2uzzOUG8bAxhBJ1zR30XORTfMuLy1DYQf1Op+BCBS+P/5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329260; c=relaxed/simple;
	bh=RFhx8OgdupAY70lU0ukVc4J3QzlTHpjDG0SzyvVkAkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbSrpqkywKg85At1rILeoB+e13BxAnFWnYnT+6DfPASK8kuYvk/nwiv2SoFzHrlGhsQ7vDIEI/h/+Hlo/OpaCwY1pWUg5bnSFogsEu7LVkC8lpH71xSj/90F5qg3EbE3EEyarQewh4i8uzovGVSgisA7xNvdSWnx4b/JzhQo/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gSCF4lyG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGKA/5gv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gSCF4lyG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGKA/5gv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AC2D343E3;
	Fri, 10 May 2024 08:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715329256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR+T73eWryimsepHQm5MHZRCEyO39uHzdAjoVe4+aKU=;
	b=gSCF4lyGsY45v8g+7zH+yr2LaLGifQzorAfXiP/BtYst+rRsTzI7ywU1WgXe0sn61rCbBk
	5dt4oSOOlWaU+xSj18jgVSy0EC+CNdR5+hnch0y+OqYOLjkDZb+tj8pObTYxtD0XpBuG+/
	TeBymu2GAqFZsbQR1lx7sA7cG0j2cuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715329256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR+T73eWryimsepHQm5MHZRCEyO39uHzdAjoVe4+aKU=;
	b=yGKA/5gv8KtUlzu5+NsiU1oCmjujD9R6vyZoWCer4bCW75ltn0fXLN27WRgebjgo8IgsJj
	FVi2btBSH5sTjqDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gSCF4lyG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="yGKA/5gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715329256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR+T73eWryimsepHQm5MHZRCEyO39uHzdAjoVe4+aKU=;
	b=gSCF4lyGsY45v8g+7zH+yr2LaLGifQzorAfXiP/BtYst+rRsTzI7ywU1WgXe0sn61rCbBk
	5dt4oSOOlWaU+xSj18jgVSy0EC+CNdR5+hnch0y+OqYOLjkDZb+tj8pObTYxtD0XpBuG+/
	TeBymu2GAqFZsbQR1lx7sA7cG0j2cuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715329256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WR+T73eWryimsepHQm5MHZRCEyO39uHzdAjoVe4+aKU=;
	b=yGKA/5gv8KtUlzu5+NsiU1oCmjujD9R6vyZoWCer4bCW75ltn0fXLN27WRgebjgo8IgsJj
	FVi2btBSH5sTjqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 883641386E;
	Fri, 10 May 2024 08:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MaTwIOjYPWb9IQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 10 May 2024 08:20:56 +0000
Message-ID: <93840eb4-609d-49d3-b48a-9c26bfb5b8ec@suse.cz>
Date: Fri, 10 May 2024 10:20:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] objpool: enable inlining objpool_push() and
 objpool_pop() operations
Content-Language: en-US
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240424215214.3956041-1-andrii@kernel.org>
 <20240424215214.3956041-2-andrii@kernel.org>
 <0e8b7482-478e-4efc-ad5f-76d60cf02bfd@suse.cz>
 <d841cb8f-fb7e-4427-8f21-a850bee3693f@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <d841cb8f-fb7e-4427-8f21-a850bee3693f@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AC2D343E3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/10/24 9:59 AM, wuqiang.matt wrote:
> On 2024/5/7 21:55, Vlastimil Babka wrote:
 >>
>>> +	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
>>> +
>>> +	/* now the tail position is reserved for the given obj */
>>> +	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
>>> +	/* update sequence to make this obj available for pop() */
>>> +	smp_store_release(&slot->last, tail + 1);
>>> +
>>> +	return 0;
>>> +}
>>>   
>>>   /**
>>>    * objpool_push() - reclaim the object and return back to objpool
>>> @@ -134,7 +219,19 @@ void *objpool_pop(struct objpool_head *pool);
>>>    * return: 0 or error code (it fails only when user tries to push
>>>    * the same object multiple times or wrong "objects" into objpool)
>>>    */
>>> -int objpool_push(void *obj, struct objpool_head *pool);
>>> +static inline int objpool_push(void *obj, struct objpool_head *pool)
>>> +{
>>> +	unsigned long flags;
>>> +	int rc;
>>> +
>>> +	/* disable local irq to avoid preemption & interruption */
>>> +	raw_local_irq_save(flags);
>>> +	rc = __objpool_try_add_slot(obj, pool, raw_smp_processor_id());
>> 
>> And IIUC, we could in theory objpool_pop() on one cpu, then later another
>> cpu might do objpool_push() and cause the latter cpu's pool to go over
>> capacity? Is there some implicit requirements of objpool users to take care
>> of having matched cpu for pop and push? Are the current objpool users
>> obeying this requirement? (I can see the selftests do, not sure about the
>> actual users).
>> Or am I missing something? Thanks.
> 
> The objects are all pre-allocated along with creation of the new objpool
> and the total number of objects never exceeds the capacity on local node.

Aha, I see, the capacity of entries is enough to hold objects from all nodes
in the most unfortunate case they all end up freed from a single cpu.

> So objpool_push() would always find an available slot from the ring-array
> for the given object to insert back. objpool_pop() would try looping all
> the percpu slots until an object is found or whole objpool is empty.

So it's correct, but seems rather wasteful to have the whole capacity for
entries replicated on every cpu? It does make objpool_push() simple and
fast, but as you say, objpool_pop() still has to search potentially all
non-local percpu slots, with disabled irqs, which is far from ideal.

And the "abort if the slot was already full" comment for
objpool_try_add_slot() seems still misleading? Maybe that was your initial
idea but changed later?

> Currently kretprobe is the only actual usecase of objpool.
> 
> I'm testing an updated objpool in our HIDS project for critical pathes,
> which is widely deployed on servers inside my company. The new version
> eliminates the raw_local_irq_save and raw_local_irq_restore pair of
> objpool_push and gains up to 5% of performance boost.

Mind Ccing me and linux-mm once you are posting that?

Thanks,
Vlastimil


