Return-Path: <bpf+bounces-79433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A22D3A294
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F19A1300924E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70385354ADB;
	Mon, 19 Jan 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="quUkNXI8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYX9y27W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="quUkNXI8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jYX9y27W"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C8352F98
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814035; cv=none; b=fyAI6wxp96a9PSCWFRGZya3VIC8fgBsD0jJEQ2Xev3ea8aBx5hlA8QFkCNLn1YB7lW8IP1Fm0YqNHDkT+YSYmUEeBOk6F8+/KMJSRpJvcB3pT1pabk3Fal8uMyhUXuzQNIN1RQyZeR186US8cJz13ngCQzLekYDwQJKYfsp5Bkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814035; c=relaxed/simple;
	bh=lkumwIOgBxjuj0xIKdM1IdZOe6eRG4qJybdfBdHhCUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hga9CuGNqXBIy60TZcNOxEShuE6p3J1NRVVjk+YjdIOXvlLWG8ABS7LK2qAz3TwdApsnnsfulAawgKQw+5uldrB7NBV0gQ2pEzDCWtw0HmRQ7/7Ncd+e6/TgfXqqwZCL9uRtO0noSdY2qXD8vn2s04CGQt32FOXKb6bGcgcjieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=quUkNXI8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYX9y27W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=quUkNXI8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jYX9y27W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B814336FE;
	Mon, 19 Jan 2026 09:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768814031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XhooBqjIFB2Zss7F6dtPfbhQAxjPz0yCTX0IY1G6TwY=;
	b=quUkNXI8whjFLXWQEgtlqwb32btvqRwOBu9Kvhxud89O3mPo6629RCETHf8qy+6O3xc/zw
	Z6i3iMI86eABtBJ5GYZmsq1t+0LD2ZieYJAIBnZMeTKfyURACAGYgLFtF5hJ8Qd8nSHPFO
	pul/4lqAegwdIbXIPOZtNNqUjjpnMRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768814031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XhooBqjIFB2Zss7F6dtPfbhQAxjPz0yCTX0IY1G6TwY=;
	b=jYX9y27Wks0FdQuI6wroIgn1vU/1z8p4cyNoHI6b/nvSjBKPpbe51MwiUuUqpsd921RmyX
	piwd/dX+3zLKQcCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768814031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XhooBqjIFB2Zss7F6dtPfbhQAxjPz0yCTX0IY1G6TwY=;
	b=quUkNXI8whjFLXWQEgtlqwb32btvqRwOBu9Kvhxud89O3mPo6629RCETHf8qy+6O3xc/zw
	Z6i3iMI86eABtBJ5GYZmsq1t+0LD2ZieYJAIBnZMeTKfyURACAGYgLFtF5hJ8Qd8nSHPFO
	pul/4lqAegwdIbXIPOZtNNqUjjpnMRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768814031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XhooBqjIFB2Zss7F6dtPfbhQAxjPz0yCTX0IY1G6TwY=;
	b=jYX9y27Wks0FdQuI6wroIgn1vU/1z8p4cyNoHI6b/nvSjBKPpbe51MwiUuUqpsd921RmyX
	piwd/dX+3zLKQcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D7AD3EA65;
	Mon, 19 Jan 2026 09:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OFZ/Fs/1bWnsQwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Jan 2026 09:13:51 +0000
Message-ID: <41048e09-5dd9-42a6-b5d8-dadee3ecfd9c@suse.cz>
Date: Mon, 19 Jan 2026 10:13:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/21] slab: introduce percpu sheaves bootstrap
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-6-5595cb000772@suse.cz>
 <CAJuCfpERcCzBysPVh63g7d0FpUBNQeq9nCL+ycem1iR08gDmaQ@mail.gmail.com>
 <aW2nlIlXFXGk4yx1@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aW2nlIlXFXGk4yx1@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/19/26 04:40, Harry Yoo wrote:
> On Sat, Jan 17, 2026 at 02:11:02AM +0000, Suren Baghdasaryan wrote:
>> On Fri, Jan 16, 2026 at 2:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >
>> > Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
>> > sheaves enabled. Since we want to enable them for almost all caches,
>> > it's suboptimal to test the pointer in the fast paths, so instead
>> > allocate it for all caches in do_kmem_cache_create(). Instead of testing
>> > the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
>> > kmem_cache->sheaf_capacity for being 0, where needed, using a new
>> > cache_has_sheaves() helper.
>> >
>> > However, for the fast paths sake we also assume that the main sheaf
>> > always exists (pcs->main is !NULL), and during bootstrap we cannot
>> > allocate sheaves yet.
>> >
>> > Solve this by introducing a single static bootstrap_sheaf that's
>> > assigned as pcs->main during bootstrap. It has a size of 0, so during
>> > allocations, the fast path will find it's empty. Since the size of 0
>> > matches sheaf_capacity of 0, the freeing fast paths will find it's
>> > "full". In the slow path handlers, we use cache_has_sheaves() to
>> > recognize that the cache doesn't (yet) have real sheaves, and fall back.
>> 
>> I don't think kmem_cache_prefill_sheaf() handles this case, does it?
>> Or do you rely on the caller to never try prefilling a bootstrapped
>> sheaf?
> 
> If a cache doesn't have sheaves, s->sheaf_capacity should be 0,
> so the sheaf returned by kmem_cache_prefill_sheaf() should be
> "oversized" one... unless the user tries to prefill a sheaf with
> size == 0?

I'll add a

        if (unlikely(!size))
                return NULL;

to kmem_cache_prefill_sheaf() so we don't have to deal with oversized
sheaves of size 0 just for this theoretical case...


