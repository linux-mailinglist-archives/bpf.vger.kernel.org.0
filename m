Return-Path: <bpf+bounces-63052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875EB020C1
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5513AD2F4
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF152EE268;
	Fri, 11 Jul 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="buVz6wBK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrfIPlZn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="buVz6wBK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrfIPlZn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F32ED160
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248600; cv=none; b=OG6v5eDM2dvCbppcgFqrlvfV6MN9tUYJJskgGnZRg6jOkyNy2i1lzty4tsNtxwqxETgKF+sxKPmzWDmXLRaYWp2FXgxXq4iBk05XG45ppdeVfjXvUlSs6k25W+bT5u41zZmNHs5XyBRok9eCaO36607NN46/K9EqFM1M1wxFKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248600; c=relaxed/simple;
	bh=X4OMalfak3+mVNJ6hPZvojzo4/zMhqoNofhoFoNgwK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnIrbflqpbV4mVggtQ4G0czxw91BQMpkKpeLHWg8RDeU5ZjLOGYw5Q0588p9h5c6tMhbJKgMJl/0+ngP4GLWYNntaFlFYwIwcUcRawVwx6wKKN4w2qKDUhlJZIWMAVO2ehuORpKDNdFmjim5VhW4GFeApnbrDIkqRvKFeunqbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=buVz6wBK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrfIPlZn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=buVz6wBK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrfIPlZn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8F1B1F451;
	Fri, 11 Jul 2025 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752248596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QX0qRN0p/QGgY/SoU9mRpHTPekrDiV+O8fwwSQc0kC0=;
	b=buVz6wBKiiIiyZM6vaFmOTWIxruB5hgLycrzUnFIP3i05lNHYTeXKflgPgUvyQkE5sBN7/
	5egUzgt10/7IGx6jvx3sEv7Z2dsjcu03b49CnR6FNEFnhWXKtum5YJfwkLtR0kMbhzHbme
	mWkaIPjCBZFp2bnXjMUdJy00Y4uBPGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752248596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QX0qRN0p/QGgY/SoU9mRpHTPekrDiV+O8fwwSQc0kC0=;
	b=lrfIPlZnuLcoU0b08zNg2VqqtM69xC64NHT8F4dxTn1rduqBgJcfhnotwiM4FFB1Y8kIWw
	1s4eBVHL3UJ9mTAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752248596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QX0qRN0p/QGgY/SoU9mRpHTPekrDiV+O8fwwSQc0kC0=;
	b=buVz6wBKiiIiyZM6vaFmOTWIxruB5hgLycrzUnFIP3i05lNHYTeXKflgPgUvyQkE5sBN7/
	5egUzgt10/7IGx6jvx3sEv7Z2dsjcu03b49CnR6FNEFnhWXKtum5YJfwkLtR0kMbhzHbme
	mWkaIPjCBZFp2bnXjMUdJy00Y4uBPGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752248596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QX0qRN0p/QGgY/SoU9mRpHTPekrDiV+O8fwwSQc0kC0=;
	b=lrfIPlZnuLcoU0b08zNg2VqqtM69xC64NHT8F4dxTn1rduqBgJcfhnotwiM4FFB1Y8kIWw
	1s4eBVHL3UJ9mTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3C0B1388B;
	Fri, 11 Jul 2025 15:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VtBYJxQxcWhtawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Jul 2025 15:43:16 +0000
Message-ID: <5bc89531-ab09-4690-aae4-a44f9ddb4a68@suse.cz>
Date: Fri, 11 Jul 2025 17:43:16 +0200
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
To: Harry Yoo <harry.yoo@oracle.com>, Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172441.1032006-1-vitaly.wool@konsulko.se> <aHDSLyHZ8b1ELeWe@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aHDSLyHZ8b1ELeWe@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,vger.kernel.org,gmail.com,kernel.org,google.com,oracle.com,linux.dev,gondor.apana.org.au,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/11/25 10:58, Harry Yoo wrote:
> On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
>> Reimplement k[v]realloc_node() to be able to set node and
>> alignment should a user need to do so. In order to do that while
>> retaining the maximal backward compatibility, add
>> k[v]realloc_node_align() functions and redefine the rest of API
>> using these new ones.
>> 
>> While doing that, we also keep the number of  _noprof variants to a
>> minimum, which implies some changes to the existing users of older
>> _noprof functions, that basically being bcachefs.
>> 
>> With that change we also provide the ability for the Rust part of
>> the kernel to set node and alignment in its K[v]xxx
>> [re]allocations.
>> 
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>> ---
>>  fs/bcachefs/darray.c   |  2 +-
>>  fs/bcachefs/util.h     |  2 +-
>>  include/linux/bpfptr.h |  2 +-
>>  include/linux/slab.h   | 38 +++++++++++++++----------
>>  lib/rhashtable.c       |  4 +--
>>  mm/slub.c              | 64 +++++++++++++++++++++++++++++-------------
>>  6 files changed, 72 insertions(+), 40 deletions(-)
>  
>> diff --git a/mm/slub.c b/mm/slub.c
>> index c4b64821e680..6fad4cdea6c4 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4845,7 +4845,7 @@ void kfree(const void *object)
>>  EXPORT_SYMBOL(kfree);
>>  
>>  static __always_inline __realloc_size(2) void *
>> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
>> +__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
>>  {
>>  	void *ret;
>>  	size_t ks = 0;
>> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>  	if (!kasan_check_byte(p))
>>  		return NULL;
>>  
>> +	/* refuse to proceed if alignment is bigger than what kmalloc() provides */
>> +	if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
>> +		return NULL;
> 
> Hmm but what happens if `p` is aligned to `align`, but the new object is not?
> 
> For example, what will happen if we  allocate object with size=64, align=64
> and then do krealloc with size=96, align=64...
> 
> Or am I missing something?

Good point. We extended the alignment guarantees in commit ad59baa31695
("slab, rust: extend kmalloc() alignment guarantees to remove Rust padding")
for rust in a way that size 96 gives you alignment of 32. It assumes that
rust side will ask for alignments that are power-of-two and sizes that are
multiples of alignment. I think if that assumption is still honored than
this will keep working, but the check added above (is it just a sanity check
or something the rust side relies on?) doesn't seem correct?

>> +	/*
>> +	 * If reallocation is not necessary (e. g. the new size is less
>> +	 * than the current allocated size), the current allocation will be
>> +	 * preserved unless __GFP_THISNODE is set. In the latter case a new
>> +	 * allocation on the requested node will be attempted.
>> +	 */
>> +	if (unlikely(flags & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
>> +		     nid != page_to_nid(virt_to_page(p)))
>> +		goto alloc_new;
>> +
>>  	if (is_kfence_address(p)) {
>>  		ks = orig_size = kfence_ksize(p);
>>  	} else {
> 


