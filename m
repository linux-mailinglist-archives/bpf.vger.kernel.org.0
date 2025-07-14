Return-Path: <bpf+bounces-63214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F4B0443D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5EA7BA0D8
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E2265630;
	Mon, 14 Jul 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Z/BES+gk";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="AQxoKkTN"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448626462A
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506893; cv=none; b=Traa586B1wQYvam8quVb3yJLbDIQh9uLgNBURIF26+4KaeLX6GAPtwD7uDx36HN1IGLmmCshqXJswBjt5hJgnOD6q6QYd0ERILbizzxTX+AaLPR1xbB+zEFdo6yFWwdTkODrn3y6pd8ZLJA9P9Z7TeHSQFYmqSSqZQEJU/wc6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506893; c=relaxed/simple;
	bh=6/eBWxJ1QIgkIgwCwS+ng4W7G8JH+ooFJnVUfMl83dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1aQB7W0JhmKxSEeJONoe4dMglu19bZzSpOD1/0m62TgpqFI77jJh+hQ4kqU7Z/G2VsUXQB4lPKT9KXjts+Zv0p2GDZA763rIXtnjImuqHeAjmPfdJlgCQfdl2v87ZMPdVdYv2dmZ49en6vYuPmH6x3p15zUKXx4tPIgDUHaRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Z/BES+gk; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=AQxoKkTN; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752506881; x=1753111681;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=CxNCFSgystRqkUUeIIO2FJHvWHtIjD7SOGJQsrFHYEE=;
	b=Z/BES+gklQqP0Ut67CFd0O7AKDdxn7SzeAeP9sKo9hDxc5vHyaQluD8u4GBmORfa/K3k6FT/QNg5K
	 +5pSyJLd1VjFqcGU04jt6VNqDAAKY3U2gnBYhHJ6CKvmCDjQu4vgMW4qZXRNtX3EmIVFOTqzZwJzXk
	 zeb8JB1bgVleUMUYPfwoZcku/BGt2s7xNJaMnERDpWZcbDs0R3vrVJURffyKZK5uSNMVcOY8Da6QAH
	 aky+odmUqXjx0O/6U3/CTVeIX0gYVFyMxMidO6cmQQq/CB7FbGRVLsUEonhUKu7GDT93zLKlHdMVZO
	 TpEdBDsXq5yhp1IwW7irPS5z6/BDsZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752506881; x=1753111681;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
	 subject:mime-version:date:message-id:from;
	bh=CxNCFSgystRqkUUeIIO2FJHvWHtIjD7SOGJQsrFHYEE=;
	b=AQxoKkTNHwRxzS8AOTETVDzj4k4Jmbk8Yhmp3MgKFL7e8XlwIfsKyDurTcDTsSbvUFVkpLk9Df/aH
	 3NS4YiLAQ==
X-HalOne-ID: 1ed28d5b-60c7-11f0-bb53-e90f2b8e16ca
Received: from [192.168.10.245] (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 1ed28d5b-60c7-11f0-bb53-e90f2b8e16ca;
	Mon, 14 Jul 2025 15:28:00 +0000 (UTC)
Message-ID: <45e705ef-e40b-4dd3-a9b9-1a713df5d4e5@konsulko.se>
Date: Mon, 14 Jul 2025 17:27:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] mm/slub: allow to set node and align in
 k[v]realloc
To: Vlastimil Babka <vbabka@suse.cz>
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
 <1dedcee0-c5a2-47b3-ae13-315ad437ae1a@suse.cz>
Content-Language: en-US
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <1dedcee0-c5a2-47b3-ae13-315ad437ae1a@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/14/25 10:14, Vlastimil Babka wrote:
> On 7/12/25 14:43, Vitaly Wool wrote:
>>
>>
>>> On Jul 11, 2025, at 5:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>
>>> On 7/11/25 10:58, Harry Yoo wrote:
>>>> On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
>>>>> static __always_inline __realloc_size(2) void *
>>>>> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>>>> +__do_krealloc(const void *p, size_t new_size, unsigned long align, gfp_t flags, int nid)
>>>>> {
>>>>> void *ret;
>>>>> size_t ks = 0;
>>>>> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>>>> if (!kasan_check_byte(p))
>>>>> return NULL;
>>>>>
>>>>> + /* refuse to proceed if alignment is bigger than what kmalloc() provides */
>>>>> + if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
>>>>> + return NULL;
>>>>
>>>> Hmm but what happens if `p` is aligned to `align`, but the new object is not?
>>>>
>>>> For example, what will happen if we  allocate object with size=64, align=64
>>>> and then do krealloc with size=96, align=64...
>>>>
>>>> Or am I missing something?
>>>
>>> Good point. We extended the alignment guarantees in commit ad59baa31695
>>> ("slab, rust: extend kmalloc() alignment guarantees to remove Rust padding")
>>> for rust in a way that size 96 gives you alignment of 32. It assumes that
>>> rust side will ask for alignments that are power-of-two and sizes that are
>>> multiples of alignment. I think if that assumption is still honored than
>>> this will keep working, but the check added above (is it just a sanity check
>>> or something the rust side relies on?) doesn't seem correct?
>>>
>>
>> It is a sanity check and it should have looked like this:
>>
>>          if (!IS_ALIGNED((unsigned long)p, align) && new_size <= ks)
>>                  return NULL;
>>
>> and the reasoning for this is the following: if we don’t intend to reallocate (new size is not bigger than the original size), but the user requests a larger alignment, it’s a miss. Does that sound reasonable?
> 
> So taking a step back indeed the align passed to krealloc is indeed used
> only for this check. If it's really just a sanity check, then I'd rather not
> add this parameter to krealloc functions at all - kmalloc() itself also
> doesn't have it, so it's inconsistent that krealloc() would have it - but
> only to return NULL and not e.g. try to reallocate for alignment.
> 
> If it's not just a sanity check, it means it's expected that for some
> sequence of valid kvrealloc_node_align() calls it can return NULL and then
> rely on the fallback to vmalloc. That would be rather wasteful for the cases
> like going from 64 to 96 bytes etc. So in that case it would be better if
> krealloc did the reallocation, same as in cases when size increases. Of
> course it would still have to rely on the documented alignment guarantees
> only and not provide anything arbitrary. aligned_size() in
> rust/kernel/alloc/allocator.rs is responsible for that, AFAIK.
> 
> And I think it's not a sanity check but the latter - if the following is a
> valid k(v)realloc sequence (from Rust POV). The individual size+align
> combinations AFAIK are, but if it's valid to make them follow one another
> them like this, I don't know.
> 
> krealloc(size=96, align=32) -> can give object with 32 alignment only
> krealloc(size=64, align=64) -> doesn't increase size but wants alignment 64
> 

We should be able to correctly process these. I agree that making such 
cases fall back to vrealloc is suboptimal but it's a technically correct 
behavior. I understand that you would rather have a reallocation on the 
slub side in these cases, so this will look as

           if (!IS_ALIGNED((unsigned long)p, align) && new_size <= ks)
                   goto alloc_new;

I'll modify/retest for the next patchset iteration.

~Vitaly

