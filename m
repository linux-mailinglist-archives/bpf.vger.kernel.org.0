Return-Path: <bpf+bounces-78535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F78D12172
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91FE93033B9D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484E734EEFC;
	Mon, 12 Jan 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbLM/krQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMKJOGkD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pbLM/krQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xMKJOGkD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10B34EEF7
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215315; cv=none; b=i6OuJl8e8r0HqjsQ4hFQBCKnZYraE37xTHlyNoNQmJ76uCtPNlYMZPLN99i5QNUM65z/dHguxx/FxU4ZiBBR3pwcsK1YIYFvgAnWLkgRRspizObiADBUKTBB7NYN1zP3GzMfjsTvMbDi6+AYJSKmFc8sIe3PJ+lPw6Ck01egM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215315; c=relaxed/simple;
	bh=+vzexkOZbMYGJE4dipwOnlFRvr8Ynw0m2cxotmJ+jE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWxOYfSdJOFO6a5DvCUb0NBj6giYr3eSZbpBHxS8yScH9LuDnc8LCL6D0YyJYrofc8oN31cRq2q98HSh4gNNmLX9aP1Iaau4QTU6eoXrqfOocH6Je9NS5onpflnJxtrbDIGe2xHdOPUAQrvilMEpxYfMNbg1m4yg1VPvnefFzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbLM/krQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMKJOGkD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pbLM/krQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xMKJOGkD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7138D5BD08;
	Mon, 12 Jan 2026 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768215308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQnLU2w7dK6piodCTax/NpreN6qBl/Gte0TSTHMUnzk=;
	b=pbLM/krQiyS4EYDLdL5/3AWqj35K6/N9uMR1an60W2x5Asw6eBRgKbL17LL5gM50SQQbOA
	oVDW4WY6k4FVBkW7dzYDg+7uWyosFF2Lws5nVc17I+6jTSD3zWGZxAvRxD84BweaD9Lsfq
	fvY05kz9+AUND/z7L2jWLgrDWX0GMto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768215308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQnLU2w7dK6piodCTax/NpreN6qBl/Gte0TSTHMUnzk=;
	b=xMKJOGkD+hqy/9QkXnnjbhoIdfusqAbAuA3TiOGLdG39Ffr2nPDvacv0GWEjAKkkuGdIb4
	JstcluC0eFdzGGDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768215308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQnLU2w7dK6piodCTax/NpreN6qBl/Gte0TSTHMUnzk=;
	b=pbLM/krQiyS4EYDLdL5/3AWqj35K6/N9uMR1an60W2x5Asw6eBRgKbL17LL5gM50SQQbOA
	oVDW4WY6k4FVBkW7dzYDg+7uWyosFF2Lws5nVc17I+6jTSD3zWGZxAvRxD84BweaD9Lsfq
	fvY05kz9+AUND/z7L2jWLgrDWX0GMto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768215308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQnLU2w7dK6piodCTax/NpreN6qBl/Gte0TSTHMUnzk=;
	b=xMKJOGkD+hqy/9QkXnnjbhoIdfusqAbAuA3TiOGLdG39Ffr2nPDvacv0GWEjAKkkuGdIb4
	JstcluC0eFdzGGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DB173EA63;
	Mon, 12 Jan 2026 10:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ylyeEgzTZGkPEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Jan 2026 10:55:08 +0000
Message-ID: <3b7b610d-6482-49f0-8e46-6ae553bf8b98@suse.cz>
Date: Mon, 12 Jan 2026 11:55:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/19] slab: replace cpu (partial) slabs with sheaves
Content-Language: en-US
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Mike Rapoport <rppt@kernel.org>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <f7c33974-e520-387e-9e2f-1e523bfe1545@gentwo.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <f7c33974-e520-387e-9e2f-1e523bfe1545@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,linux.dev,oracle.com,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/4/25 23:11, Christoph Lameter (Ampere) wrote:
> On Thu, 23 Oct 2025, Vlastimil Babka wrote:
> 
>> Besides (hopefully) improved performance, this removes the rather
>> complicated code related to the lockless fastpaths (using
>> this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
>> kmalloc_nolock().

Sorry for the late reply and thanks for the insights, I will incorporate
them to the cover letter.

> Going back to a strict LIFO scheme for alloc/free removes the following
> performance features:
> 
> 1. Objects are served randomly from a variety of slab pages instead of
> serving all available objects from a single slab page and then from the
> next. This means that the objects require a larger set of TLB entries to
> cover. TLB pressure will increase.

OK. Should be mitigated by the huge direct mappings hopefully. Also IIRC
when Mike was evaluating patches to preserve the huge mappings better
against splitting, the benefits were so low it was abandoned, so that
suggests the TLB pressure on direct map isn't that bad.

> 2. The number of partial slabs will increase since the free objects in a
> partial page are not used up before moving onto the next. Instead free
> objects from random slab pages are used.

Agreed. Should be bounded by the number of cpu+barn sheaves.

> Spatial object locality is reduced. Temporal object hotness increases.

Ack.

>> The lockless slab freelist+counters update operation using
>> try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
>> without repeating the "alien" array flushing of SLUB, and to allow
>> flushing objects from sheaves to slabs mostly without the node
>> list_lock.
> 
> Hmm... So potential cache hot objects are lost that way and reused on
> another node next. The role of the alien caches in SLAB was to cover that
> case and we saw performance regressions without these caches.

Interesting observation. I think commit e00946fe2351 ("[PATCH] slab: Bypass
free lists for __drain_alien_cache()") is relevant?

But I wonder, wouldn't the objects tend to be cache hot on the cpu which was
freeing them (and to which they were remote), but after that alien->shared
array transfer then reallocated on a different cpu (to which they are
local)? So I wouldn't expect cache hotness benefits there?

> The method of freeing still reduces the amount of remote partial slabs
> that have to be managed and increases the locality of the objects.

Ack.

