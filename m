Return-Path: <bpf+bounces-63144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED6B038D8
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 10:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E692166897
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE423AB81;
	Mon, 14 Jul 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a9k0+0DU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpcnJWFj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mamSDHXH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq58d71Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442E239E60
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480854; cv=none; b=LT5pFogqL8JVTo5oRm8r7fBaw/PWyakAiflv6o2P2UrSMlczw95BYVHThGPKRExoAQ+cdaZrfIDLl644G0dxQGQI58RiuIZyYIh01WUmDp6ykOmO32HHpHoHyRbwFN4lTfyfib56y6MxGgMXGOM8ji1l1eYbYqWip10tzWHhgpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480854; c=relaxed/simple;
	bh=N3NDV8ZRMS6/YJ3Bor5jdHCVj/sPizkjyONgJopAub8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTDxVSkOB0bilHwXdIyIGdvyAyxNN/LNEtKPyVU3U7WHbmAdDMSmeUDwM01j5hnS9WxutzWrc2fEzUXwStHJnFRZSelBBky1YbtIC7Xg6z880/JrimCguzWqMCam1yF5AEfOhDpiXtcNW4IDdbjWyHp4dD80mJ07Ig+yNv2ZSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a9k0+0DU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpcnJWFj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mamSDHXH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq58d71Y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCB5B1F387;
	Mon, 14 Jul 2025 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752480849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oLZSSKrSwR5i5R+ZxG6wpsVx5R6CJ87qoC7NyByXS8Y=;
	b=a9k0+0DUgZ+2NNuTdMbJoo1Y5Q0zy6GMb/MkRjDMrstrGNWv5OkmiHnH6jNPucrCajF0Cx
	O9KlFRpmUGGcHFqpsALCmnYUv4VYBnkUz0AsfNnDA55b3HbCZJz4yqZFoeWPXxO5dLNr3C
	xg1YrMVXAeEqA9NBM+BuPyALea1S2/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752480849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oLZSSKrSwR5i5R+ZxG6wpsVx5R6CJ87qoC7NyByXS8Y=;
	b=dpcnJWFjkB42gHX2Xh61tgF0ar4MVlp0HBxcHI73dYPj2xoJESeUSFOQJWO1dgliEG4ZPs
	ktFsgO9C0+bPBlCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mamSDHXH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gq58d71Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752480846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oLZSSKrSwR5i5R+ZxG6wpsVx5R6CJ87qoC7NyByXS8Y=;
	b=mamSDHXHZWkLnGgbg19zG6gMVU+zJ57lV2t/JJ4e2ASq66TrP7V4YqtdyLunpYRSUV6xaU
	p4UYLAtB/ceAGan1kO959AkMtjhaG6WULOzR/xlMFP9RLDnunPIJgM18UqJcE8JYRuZWso
	TMtAUIwA4OumM5nn7ZBFAQXCkhokkFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752480846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oLZSSKrSwR5i5R+ZxG6wpsVx5R6CJ87qoC7NyByXS8Y=;
	b=gq58d71YYaI0uMOCONBGIgtW5YJWbpuTP4grXzqc4SVuvE8YQZa5W6QcA5NRv/nyTCBgF8
	ivA596bA9koOpJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8BD413306;
	Mon, 14 Jul 2025 08:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id af6ZKE68dGhhKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Jul 2025 08:14:06 +0000
Message-ID: <1dedcee0-c5a2-47b3-ae13-315ad437ae1a@suse.cz>
Date: Mon, 14 Jul 2025 10:14:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Content-Language: en-US
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172441.1032006-1-vitaly.wool@konsulko.se> <aHDSLyHZ8b1ELeWe@hyeyoo>
 <5bc89531-ab09-4690-aae4-a44f9ddb4a68@suse.cz>
 <3AD3F7B5-679F-4DC8-968F-9FE991B56A5C@konsulko.se>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <3AD3F7B5-679F-4DC8-968F-9FE991B56A5C@konsulko.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,kvack.org,linux-foundation.org,vger.kernel.org,gmail.com,kernel.org,google.com,linux.dev,gondor.apana.org.au,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: CCB5B1F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/12/25 14:43, Vitaly Wool wrote:
> 
> 
>> On Jul 11, 2025, at 5:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
>> 
>> On 7/11/25 10:58, Harry Yoo wrote:
>>> On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
>>>> static __always_inline __realloc_size(2) void *
>>>> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>>> +__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
>>>> {
>>>> void *ret;
>>>> size_t ks = 0;
>>>> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>>> if (!kasan_check_byte(p))
>>>> return NULL;
>>>> 
>>>> + /* refuse to proceed if alignment is bigger than what kmalloc() provides */
>>>> + if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
>>>> + return NULL;
>>> 
>>> Hmm but what happens if `p` is aligned to `align`, but the new object is not?
>>> 
>>> For example, what will happen if we  allocate object with size=64, align=64
>>> and then do krealloc with size=96, align=64...
>>> 
>>> Or am I missing something?
>> 
>> Good point. We extended the alignment guarantees in commit ad59baa31695
>> ("slab, rust: extend kmalloc() alignment guarantees to remove Rust padding")
>> for rust in a way that size 96 gives you alignment of 32. It assumes that
>> rust side will ask for alignments that are power-of-two and sizes that are
>> multiples of alignment. I think if that assumption is still honored than
>> this will keep working, but the check added above (is it just a sanity check
>> or something the rust side relies on?) doesn't seem correct?
>> 
> 
> It is a sanity check and it should have looked like this:
> 
>         if (!IS_ALIGNED((unsigned long)p, align) && new_size <= ks)
>                 return NULL;
> 
> and the reasoning for this is the following: if we don’t intend to reallocate (new size is not bigger than the original size), but the user requests a larger alignment, it’s a miss. Does that sound reasonable?

So taking a step back indeed the align passed to krealloc is indeed used
only for this check. If it's really just a sanity check, then I'd rather not
add this parameter to krealloc functions at all - kmalloc() itself also
doesn't have it, so it's inconsistent that krealloc() would have it - but
only to return NULL and not e.g. try to reallocate for alignment.

If it's not just a sanity check, it means it's expected that for some
sequence of valid kvrealloc_node_align() calls it can return NULL and then
rely on the fallback to vmalloc. That would be rather wasteful for the cases
like going from 64 to 96 bytes etc. So in that case it would be better if
krealloc did the reallocation, same as in cases when size increases. Of
course it would still have to rely on the documented alignment guarantees
only and not provide anything arbitrary. aligned_size() in
rust/kernel/alloc/allocator.rs is responsible for that, AFAIK.

And I think it's not a sanity check but the latter - if the following is a
valid k(v)realloc sequence (from Rust POV). The individual size+align
combinations AFAIK are, but if it's valid to make them follow one another
them like this, I don't know.

krealloc(size=96, align=32) -> can give object with 32 alignment only
krealloc(size=64, align=64) -> doesn't increase size but wants alignment 64

> ~Vitaly
> 


