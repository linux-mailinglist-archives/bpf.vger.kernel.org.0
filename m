Return-Path: <bpf+bounces-62919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC92FB004B2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4082B46C20
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908527147D;
	Thu, 10 Jul 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="VHpubo+O";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="71llo6v6"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028E21CC56
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156461; cv=none; b=hC6SfnQiwgIXVeny4weZp5Qym7L+OKSduOXxbSsOV/7EHYVvs/jZci8tDji1n9/en5qjA3KeP0bB91OaSfKhhM1Ith+TCLTzyJKE2OFCnr3C2t6QxVlG97k3lPeEAoXv1wXO0ULzeWEw4N2qhwxvvlteHjIbZ3S/27eYYE9IBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156461; c=relaxed/simple;
	bh=fEk+AE6/WEqc/2Z+GVzvG2frW2My/PwWPejaD2SJCKQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qSLGGovdWz6WBPtxIqZCjk/ISCk0SX8MRjcMt9uq4jJXrhs/a1V/1tl2kef1XocQ/ATnQGtbFaLc+/kSC4bQAnKvA1/mmxvckyi0MbPjxbyjU3l4FrEMKJ0tB018S7Jd8Wu3m8aZ1FeqxXDpXwrf4IDfIMeXFHOGkunP6J0bUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=VHpubo+O; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=71llo6v6; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752156450; x=1752761250;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=z6CYkY/mnHsPc1zlAI1YQ9WMPDSlzYrFWMeZlYj4cpw=;
	b=VHpubo+OBZhzjd4PXBL2vtOFLMM2bRHh5EeEz+IBCjXyVL4Ukh6jyp1csiboGxXQ1tLHFoINMJ5C4
	 1ctcoTuCpgQyNoAT2oGWAp0T0NmCmxu63oSdgyLLwlpIjYGksuqtkH5l39quLXxeJSQOPmZ8U4wiAE
	 /hNmU9nqubJ0lOMKO6+bRyz+c9m0eXYUBliSymIBdoTt4jyKXhqNh75iley3u6crCOjr+Sxk4ex/4c
	 g97BlnCT9qmhal31kJyh9KRJvuigslwTrELthNmRmAmMLWHIAWkJPj69oMzx/eRYQJJ65LtLzrGnrY
	 r+ABRS9dN1OjMes5PM4HJ3WcgJdb/Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752156450; x=1752761250;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=z6CYkY/mnHsPc1zlAI1YQ9WMPDSlzYrFWMeZlYj4cpw=;
	b=71llo6v6/l7OTXw3SNLSRYkfbg1Wmiisu+BttGsr8RLc6NHuwz5OHPiG6WSlNgNzzVcW0wzjID+ca
	 FxpPsbOAg==
X-HalOne-ID: 363fb403-5d97-11f0-9d28-c9fa7b04d629
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 363fb403-5d97-11f0-9d28-c9fa7b04d629;
	Thu, 10 Jul 2025 14:07:30 +0000 (UTC)
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
In-Reply-To: <nsacpwgldqdidsqkqalxdhwptikk7srnhjncmjaulnzcf6nsmu@fisb5w4aamhl>
Date: Thu, 10 Jul 2025 16:07:19 +0200
Cc: linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 rust-for-linux@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C240E394-C3F6-4A46-A9F3-E6D95A3F4DF3@konsulko.se>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
 <nsacpwgldqdidsqkqalxdhwptikk7srnhjncmjaulnzcf6nsmu@fisb5w4aamhl>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 9, 2025, at 9:01=E2=80=AFPM, Liam R. Howlett =
<Liam.Howlett@oracle.com> wrote:
>=20
> * Vitaly Wool <vitaly.wool@konsulko.se> [250709 13:24]:
>> Reimplement vrealloc() to be able to set node and alignment should
>> a user need to do so. Rename the function to vrealloc_node_align()
>> to better match what it actually does now and introduce macros for
>> vrealloc() and friends for backward compatibility.
>>=20
>> With that change we also provide the ability for the Rust part of
>> the kernel to set node and alignment in its allocations.
>>=20
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>> include/linux/vmalloc.h | 12 +++++++++---
>> mm/nommu.c              |  3 ++-
>> mm/vmalloc.c            | 31 ++++++++++++++++++++++++++-----
>> 3 files changed, 37 insertions(+), 9 deletions(-)
>>=20
> ...
>=20
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 6dbcdceecae1..03dd06097b25 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -4089,19 +4089,31 @@ void *vzalloc_node_noprof(unsigned long size, =
int node)
>> EXPORT_SYMBOL(vzalloc_node_noprof);
>>=20
>> /**
>> - * vrealloc - reallocate virtually contiguous memory; contents =
remain unchanged
>> + * vrealloc_node_align_noprof - reallocate virtually contiguous =
memory; contents
>> + * remain unchanged
>>  * @p: object to reallocate memory for
>>  * @size: the size to reallocate
>> + * @align: requested alignment
>>  * @flags: the flags for the page level allocator
>> + * @nid: node number of the target node
>> + *
>> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc(). If =
@size is
>> + * 0 and @p is not a %NULL pointer, the object pointed to is freed.
>>  *
>> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If =
@size is 0 and
>> - * @p is not a %NULL pointer, the object pointed to is freed.
>> + * if @nid is not NUMA_NO_NODE, this function will try to allocate =
memory on
>> + * the given node. If reallocation is not necessary (e. g. the new =
size is less
>> + * than the current allocated size), the current allocation will be =
preserved
>> + * unless __GFP_THISNODE is set. In the latter case a new allocation =
on the
>> + * requested node will be attempted.
>=20
> I am having a very hard time understanding what you mean here.  What =
is
> the latter case?
>=20
> If @nis is !NUMA_NO_NODE, the allocation will be attempted on the =
given
> node.  Then things sort of get confusing.  What is the latter case?

The latter case is __GFP_THISNODE present in flags. That=E2=80=99s the =
latest if-clause in this paragraph.

>=20
>>  *
>>  * If __GFP_ZERO logic is requested, callers must ensure that, =
starting with the
>>  * initial memory allocation, every subsequent call to this API for =
the same
>>  * memory allocation is flagged with __GFP_ZERO. Otherwise, it is =
possible that
>>  * __GFP_ZERO is not fully honored by this API.
>>  *
>> + * If the requested alignment is bigger than the one the *existing* =
allocation
>> + * has, this function will fail.
>> + *
>=20
> It might be better to say something like:
> Requesting an alignment that is bigger than the alignment of the
> *existing* allocation will fail.
>=20
The whole function description in fact consists of several if-clauses =
(some of which are nested) so I am just following the pattern here.

~Vitaly



