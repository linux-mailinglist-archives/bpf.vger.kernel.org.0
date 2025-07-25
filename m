Return-Path: <bpf+bounces-64330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78BB119C9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5043B7210
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC92C1582;
	Fri, 25 Jul 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H1eNZ77N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9YHNMFF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H1eNZ77N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b9YHNMFF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C22BEC44
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432005; cv=none; b=W3elaRr+6A8XnoOEJPRpdJBADVYf+WNBe9CRejrFpqKQby04+lIVJBpO6/V9zpkQW7RBjCKyv9NIrdJo8L+lyW5u8rrpuHyX5ymhfJY0FYntD3izgd6sbPoyW/riDP5XGroncHr/vzv/zBNVOUR+kTsZUUcX2g94ABpbZyPYdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432005; c=relaxed/simple;
	bh=Z7aDi37finAbTTLjMQ+aI5jDE8C6XmVWzbSCpuhC1SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwbNM5aoAO7Rwz713CzoQs1wDsJtLMLTvrXt44fZSQnn4pG6/wo028G/w/V4UwZFraFG2V5b4o1G5g6qCdpi7D5yfmJX5s0F7kIxCKfL/GP1FWWJpSgs9IXUVz1hMV5aDJFmpmeMQpFwWAJQ4uIraW+NYPoMxVdpGgHvAYG5AwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H1eNZ77N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9YHNMFF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H1eNZ77N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b9YHNMFF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 048921F387;
	Fri, 25 Jul 2025 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753431999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zXZqF93QlM7fvQgmaIDTxVZ7v4AegbzGaTVx0Ma0Afw=;
	b=H1eNZ77NmMyDq3tiTznajEsmBs2dpgU/LSlXu7FnWi8+2Zgb1FSa9PlODRPteL6+OVTy0Q
	xQIfR8CSo9wjzoxndU8nKC8Clp8Ib3uv50xP6B2U9ulzP1bJFl8dfGx29YhbUqa5T/wrT7
	6+TxsPl5+drGXIjhlSjJbSjVLOIYPiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753431999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zXZqF93QlM7fvQgmaIDTxVZ7v4AegbzGaTVx0Ma0Afw=;
	b=b9YHNMFFjfzNuCDmJa0JsbmueKP7D2A4Aq0Blj85pakW7GcJP9FQILumjnX32gBdNYJ1d7
	jqBE4zJZGsNUmKBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H1eNZ77N;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b9YHNMFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753431999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zXZqF93QlM7fvQgmaIDTxVZ7v4AegbzGaTVx0Ma0Afw=;
	b=H1eNZ77NmMyDq3tiTznajEsmBs2dpgU/LSlXu7FnWi8+2Zgb1FSa9PlODRPteL6+OVTy0Q
	xQIfR8CSo9wjzoxndU8nKC8Clp8Ib3uv50xP6B2U9ulzP1bJFl8dfGx29YhbUqa5T/wrT7
	6+TxsPl5+drGXIjhlSjJbSjVLOIYPiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753431999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zXZqF93QlM7fvQgmaIDTxVZ7v4AegbzGaTVx0Ma0Afw=;
	b=b9YHNMFFjfzNuCDmJa0JsbmueKP7D2A4Aq0Blj85pakW7GcJP9FQILumjnX32gBdNYJ1d7
	jqBE4zJZGsNUmKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEB3E1373A;
	Fri, 25 Jul 2025 08:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cQYRNr4/g2g3XQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Jul 2025 08:26:38 +0000
Message-ID: <379d3d5c-b730-4a5d-9c71-d34d23472621@suse.cz>
Date: Fri, 25 Jul 2025 10:26:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/4] support large align and nid in Rust allocators
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>
 <CAH5fLgjatYenX_xPvRW11BnRw1wP_G19eY-7AqUctnuZ3rGBYA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAH5fLgjatYenX_xPvRW11BnRw1wP_G19eY-7AqUctnuZ3rGBYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 048921F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[konsulko.se,kvack.org,vger.kernel.org,gmail.com,kernel.org,oracle.com,linux.dev,gondor.apana.org.au,google.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

On 7/25/25 09:14, Alice Ryhl wrote:
> On Thu, Jul 24, 2025 at 10:54 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 15 Jul 2025 15:56:45 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
>>
>> > The coming patches provide the ability for Rust allocators to set
>> > NUMA node and large alignment.
>> >
>> > ...
>> >
>> >  fs/bcachefs/darray.c           |    2 -
>> >  fs/bcachefs/util.h             |    2 -
>> >  include/linux/bpfptr.h         |    2 -
>> >  include/linux/slab.h           |   39 ++++++++++++++++++++++---------------
>> >  include/linux/vmalloc.h        |   12 ++++++++---
>> >  lib/rhashtable.c               |    4 +--
>> >  mm/nommu.c                     |    3 +-
>> >  mm/slub.c                      |   64 +++++++++++++++++++++++++++++++++++++++++--------------------
>> >  mm/vmalloc.c                   |   29 ++++++++++++++++++++++-----
>> >  rust/helpers/slab.c            |   10 +++++----
>> >  rust/helpers/vmalloc.c         |    5 ++--
>> >  rust/kernel/alloc.rs           |   54 ++++++++++++++++++++++++++++++++++++++++++++++-----
>> >  rust/kernel/alloc/allocator.rs |   49 +++++++++++++++++++++-------------------------
>> >  rust/kernel/alloc/kbox.rs      |    4 +--
>> >  rust/kernel/alloc/kvec.rs      |   11 ++++++++--
>> >  15 files changed, 200 insertions(+), 90 deletions(-)
>>
>> I assume we're looking for a merge into mm.git?
>>
>> We're at -rc7 so let's target 6.17.  Please resend around the end of
>> the upcoming merge window?
> 
> I think it would make sense for this to land through mm.git, so yes
> that sounds like a good plan.

Ack.

> Alice


