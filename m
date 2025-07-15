Return-Path: <bpf+bounces-63336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECFB0630F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AEE5806B2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06C24BBEE;
	Tue, 15 Jul 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="weuKPp28";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8JCEqK1Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="weuKPp28";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8JCEqK1Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16084039
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593665; cv=none; b=VOjebjfsY/oeUtZH4yu5ef69wS9w/f9pv+lfv7rK4GKQ5+Gg99zaaPYMTTZ8dhd1VeqWFWkpmVWm0qth4ivOdMLCLoicjeQfxfRxNBsMs5bHQaaVqoC1U6lekukfWF4y6BTx3AuXg1bvbTrziqKeuDli8d4PEYnmy2X30lMTRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593665; c=relaxed/simple;
	bh=m1tPZ6E6Fo1uYAoYypHOqU9s8YA9XsS8DprvtDx5/iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lULNpDf2bcNCFx+T6M+LMkGrWdVQHQtGUFxk8sOEvw9Ofa3qPOMeNH19VLgAyj5pAWvP05Q9C58aX9FtQOI5MFafdJnyrxS5xXX/U1Auj8hhOidTIZ8q5iRtjgouLs+BG1sGzTnjpnHl4+rkKwVXwfY7BqDH7NyEOe2tNFfSBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=weuKPp28; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8JCEqK1Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=weuKPp28; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8JCEqK1Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CCCA211D4;
	Tue, 15 Jul 2025 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752593661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qNoq8mHkdJD9dv4Bl1KFQ2tFDOhjLYSD+a5dl7OxpgA=;
	b=weuKPp28UfQ08F+RICd3TblaQpRkO1BgArnR0V4zXcceO+SL3Ki8Zt4vBX+eMcHvSERwp4
	O4/F7KpOHAimGMyMlct5cpbao4OBFDsMYAlm3tnNJ43ZGNbYZVrZRjihCC1KjZpt8+OTYn
	g8zZW56j1OTA2Vl4qJ++T0+gU5qkiqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752593661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qNoq8mHkdJD9dv4Bl1KFQ2tFDOhjLYSD+a5dl7OxpgA=;
	b=8JCEqK1YRa4VJlBX+hud9zeOA+/yVU0WpsJiWaY2kMp4uiMc1C9ouX/esYqo7BeZECG9UZ
	pdGRuXDw6UIrIwDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752593661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qNoq8mHkdJD9dv4Bl1KFQ2tFDOhjLYSD+a5dl7OxpgA=;
	b=weuKPp28UfQ08F+RICd3TblaQpRkO1BgArnR0V4zXcceO+SL3Ki8Zt4vBX+eMcHvSERwp4
	O4/F7KpOHAimGMyMlct5cpbao4OBFDsMYAlm3tnNJ43ZGNbYZVrZRjihCC1KjZpt8+OTYn
	g8zZW56j1OTA2Vl4qJ++T0+gU5qkiqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752593661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qNoq8mHkdJD9dv4Bl1KFQ2tFDOhjLYSD+a5dl7OxpgA=;
	b=8JCEqK1YRa4VJlBX+hud9zeOA+/yVU0WpsJiWaY2kMp4uiMc1C9ouX/esYqo7BeZECG9UZ
	pdGRuXDw6UIrIwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E9E13A68;
	Tue, 15 Jul 2025 15:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PeCSM/x0dmhkYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Jul 2025 15:34:20 +0000
Message-ID: <07d3689c-185e-496e-a0b8-53bb3194f0da@suse.cz>
Date: Tue, 15 Jul 2025 17:34:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Content-Language: en-US
To: Danilo Krummrich <dakr@kernel.org>, Vitaly Wool
 <vitaly.wool@konsulko.se>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Kent Overstreet <kent.overstreet@linux.dev>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135815.2230224-1-vitaly.wool@konsulko.se>
 <DBCPB0BHKNTQ.K0NWNXIFKCT0@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <DBCPB0BHKNTQ.K0NWNXIFKCT0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,gmail.com,google.com,oracle.com,gondor.apana.org.au,suse.de,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/15/25 16:33, Danilo Krummrich wrote:
> On Tue Jul 15, 2025 at 3:58 PM CEST, Vitaly Wool wrote:
>> diff --git a/fs/bcachefs/darray.c b/fs/bcachefs/darray.c
>> index e86d36d23e9e..928e83a1ce42 100644
>> --- a/fs/bcachefs/darray.c
>> +++ b/fs/bcachefs/darray.c
>> @@ -21,7 +21,7 @@ int __bch2_darray_resize_noprof(darray_char *d, size_t element_size, size_t new_
>>  			return -ENOMEM;
>>  
>>  		void *data = likely(bytes < INT_MAX)
>> -			? kvmalloc_noprof(bytes, gfp)
>> +			? kvmalloc_node_align_noprof(bytes, 1, gfp, NUMA_NO_NODE)
>>  			: vmalloc_noprof(bytes);
>>  		if (!data)
>>  			return -ENOMEM;
>> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
>> index 0a4b1d433621..2d6d4b547db8 100644
>> --- a/fs/bcachefs/util.h
>> +++ b/fs/bcachefs/util.h
>> @@ -61,7 +61,7 @@ static inline void *bch2_kvmalloc_noprof(size_t n, gfp_t flags)
>>  {
>>  	void *p = unlikely(n >= INT_MAX)
>>  		? vmalloc_noprof(n)
>> -		: kvmalloc_noprof(n, flags & ~__GFP_ZERO);
>> +		: kvmalloc_node_align_noprof(n, 1, flags & ~__GFP_ZERO, NUMA_NO_NODE);
>>  	if (p && (flags & __GFP_ZERO))
>>  		memset(p, 0, n);
>>  	return p;
> 
> I assume this is because kvmalloc(), and hence kvrealloc(), does this:
> 
> 	/* Don't even allow crazy sizes */
> 	if (unlikely(size > INT_MAX)) {
> 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> 		return NULL;
> 	}
> 
> Do we still consider this a "crazy size"? :)

Yeah, with "we" including Linus:
https://lore.kernel.org/all/CAHk-=wi=PrbZnwnvhKEF6UUQNCZdNsUbr+hk-jOWGr-q4Mmz=Q@mail.gmail.com/



