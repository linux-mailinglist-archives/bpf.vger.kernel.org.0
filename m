Return-Path: <bpf+bounces-62976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325CB00BC0
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1025616EF86
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E742FD598;
	Thu, 10 Jul 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="59u0gWhR";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Z6euGjn8"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A42FD58D
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173885; cv=none; b=cIEgg4UvV+QLVR4mNARgAIiQ05iNvwJuv6i2AA4XeRVaX2ZBJRbzHZxynb2SNR3JQZ8bHVbDrFjg5MAlNmS3s52Ou8lp1o6BVtOML/joe8LcKfmMYsEnyi2Od7oAYg4sV6BoVasxymz3Gjmc/s7L62L5qJK4Vs94oyCyMZdDAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173885; c=relaxed/simple;
	bh=pe4AI+RI8fgZTAcJ20G+kMV/6FPxTNz+kibld3PNvek=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T88Rh/V9xhni/E7j+CP4Pmu1p90S6LMGTObOABCEMO9D8k/abfk/fPrfktH9i1/lo1sBKDqWlYsxegSQ1LdvrSsiPwynFy52IMmCFbeeAriYfomeJryJDcUG2W4VDOP9x4s6FjJIGkm2TLyY59uo7hM94YRW8yvtbfBeaHvJbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=59u0gWhR; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Z6euGjn8; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752173879; x=1752778679;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=qOROnEfbRMkEU9HUIlrw8G/gc7MbaqKeDQV/AuFw0LU=;
	b=59u0gWhR/XhR/i5COmwjWdLGRDxP9xDXHDopl2OUB0iq94dLbpEeYI7Vz1wimKDxihVFX59SQmx+V
	 4IrlXC7v64t9gScthV2gZhTtx+AzVXPmuO6lqlvgbUHCRVJurwRE6W+yLK+m71O/CWRks6wFn7wvyC
	 1srhBrdDsj6lXbdNNVWqQbs26VS/nXQH6SzfgsR8amVggugx648AYHZmJAThmuZnloO6LgMLB/Myxg
	 XY3CWlKactui0SrgVoLBfB2EhQBLRH+fqfQDGSqv9uzvosBsOgiC9Yp9gqFZlT1s4cJKfnT9bRXKmG
	 lD7N51RK0yaCSc/InhrGXh4Jfb4SIJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752173879; x=1752778679;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=qOROnEfbRMkEU9HUIlrw8G/gc7MbaqKeDQV/AuFw0LU=;
	b=Z6euGjn8Mwt0J/TG8fUhvLbVRpyUb5j4Wf9Bv9akAk10Z6B/49l8SclhsQwGW5lI0CgIAMtsb89gN
	 /5kL9yNBA==
X-HalOne-ID: cb161d63-5dbf-11f0-b814-e90f2b8e16ca
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id cb161d63-5dbf-11f0-b814-e90f2b8e16ca;
	Thu, 10 Jul 2025 18:57:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <aedc2b36-b3b0-4367-aa68-ba9f8a110b52@lucifer.local>
Date: Thu, 10 Jul 2025 20:57:48 +0200
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 rust-for-linux@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D8A1A29-C847-479F-B732-A7CB13A46FA7@konsulko.se>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <nsacpwgldqdidsqkqalxdhwptikk7srnhjncmjaulnzcf6nsmu@fisb5w4aamhl>
 <D0D76B82-E390-498E-AE84-1B2CA6C0F809@konsulko.se>
 <aedc2b36-b3b0-4367-aa68-ba9f8a110b52@lucifer.local>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 10, 2025, at 5:19=E2=80=AFPM, Lorenzo Stoakes =
<lorenzo.stoakes@oracle.com> wrote:
>=20
> On Thu, Jul 10, 2025 at 08:21:19AM +0200, Vitaly Wool wrote:
>>=20
>>=20
>>> On Jul 9, 2025, at 9:01=E2=80=AFPM, Liam R. Howlett =
<Liam.Howlett@oracle.com> wrote:
>>>=20
>>> * Vitaly Wool <vitaly.wool@konsulko.se =
<mailto:vitaly.wool@konsulko.se>> [250709 13:24]:
>>>> Reimplement vrealloc() to be able to set node and alignment should
>>>> a user need to do so. Rename the function to vrealloc_node_align()
>>>> to better match what it actually does now and introduce macros for
>>>> vrealloc() and friends for backward compatibility.
>>>>=20
>>>> With that change we also provide the ability for the Rust part of
>>>> the kernel to set node and alignment in its allocations.
>>>>=20
>>>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>>>> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>> ---
>>>> include/linux/vmalloc.h | 12 +++++++++---
>>>> mm/nommu.c              |  3 ++-
>>>> mm/vmalloc.c            | 31 ++++++++++++++++++++++++++-----
>>>> 3 files changed, 37 insertions(+), 9 deletions(-)
>>>>=20
>>> ...
>>>=20
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 6dbcdceecae1..03dd06097b25 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -4089,19 +4089,31 @@ void *vzalloc_node_noprof(unsigned long =
size, int node)
>>>> EXPORT_SYMBOL(vzalloc_node_noprof);
>>>>=20
>>>> /**
>>>> - * vrealloc - reallocate virtually contiguous memory; contents =
remain unchanged
>>>> + * vrealloc_node_align_noprof - reallocate virtually contiguous =
memory; contents
>>>> + * remain unchanged
>>>> * @p: object to reallocate memory for
>>>> * @size: the size to reallocate
>>>> + * @align: requested alignment
>>>> * @flags: the flags for the page level allocator
>>>> + * @nid: node number of the target node
>>>> + *
>>>> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc(). =
If @size is
>>>> + * 0 and @p is not a %NULL pointer, the object pointed to is =
freed.
>>>> *
>>>> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If =
@size is 0 and
>>>> - * @p is not a %NULL pointer, the object pointed to is freed.
>>>> + * if @nid is not NUMA_NO_NODE, this function will try to allocate =
memory on
>>>> + * the given node. If reallocation is not necessary (e. g. the new =
size is less
>>>> + * than the current allocated size), the current allocation will =
be preserved
>>>> + * unless __GFP_THISNODE is set. In the latter case a new =
allocation on the
>>>> + * requested node will be attempted.
>=20
> Agreed with Liam, this is completely unreadable.
>=20
> I think the numa node stuff is unnecesasry, that's pretty much =
inferred.
>=20
> I'd just go with something like 'if the function can void having to =
reallocate
> then it does'.
>=20
> Nice and simple :)

I think it is important to stress that the function is not always =
following the specified nid.
How about =E2=80=9CIf the caller wants the new memory to be on specific =
node *only*, __GFP_THISNODE flag should be set, otherwise the function =
will try to avoid reallocation and possibly disregard the specified =
@nid=E2=80=9D ?

>=20
>>>=20
>>> I am having a very hard time understanding what you mean here.  What =
is
>>> the latter case?
>>>=20
>>> If @nis is !NUMA_NO_NODE, the allocation will be attempted on the =
given
>>> node.  Then things sort of get confusing.  What is the latter case?
>>=20
>> The latter case is __GFP_THISNODE present in flags. That=E2=80=99s =
the latest if-clause in this paragraph.
>>>=20
>>>> *
>>>> * If __GFP_ZERO logic is requested, callers must ensure that, =
starting with the
>>>> * initial memory allocation, every subsequent call to this API for =
the same
>>>> * memory allocation is flagged with __GFP_ZERO. Otherwise, it is =
possible that
>>>> * __GFP_ZERO is not fully honored by this API.
>>>> *
>>>> + * If the requested alignment is bigger than the one the =
*existing* allocation
>>>> + * has, this function will fail.
>>>> + *
>>>=20
>>> It might be better to say something like:
>>> Requesting an alignment that is bigger than the alignment of the
>>> *existing* allocation will fail.
>>>=20
>>=20
>> The whole function description in fact consists of several if-clauses =
(some of which are nested) so I am just following the pattern here.
>=20
> Right, but in no sane world is essentially describing a series of =
if-clauses in
> a kerneldoc a thing.
>=20
> Just it keep it simple, this is meant to be an overview, people can go =
read the
> code if they need details :)
>=20
Alright, no strong feelings about it anyway. Will reword as you guys =
suggest.

Thanks,
Vitaly


