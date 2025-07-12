Return-Path: <bpf+bounces-63117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC8B02AD8
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 14:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9947756328E
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21189276057;
	Sat, 12 Jul 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="021r4Foq";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="nzRAI9Bm"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A4275B12
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752324253; cv=none; b=rfWG7g6XExMjb8gzD9yec4fKssPN6G9po5uZH0RKguh/gMp2OVEwTf2HRv/nMsLasgN/fCwUCTSeqKrYdUWeYs0vq5ABGtn2YdMAoDkT3bM/Ahg0c+mIzUyXriiSm0dT+KGsQ9fKNDVc75eTqiUP/Z6NoNgFG49+gKoGlZf919Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752324253; c=relaxed/simple;
	bh=2+tY9iG4ElbQ7e13afB6Qc+qfOOxZeWzcGD7fyq8lS4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=benGWalJz07rmaO5ugI6FRSMwzJ4PZ7mgxhW4WDlDWmRFW8duRcv5wxMGZLWQdg5wROcU61bQAvd1bPZ4GxCumWGck8J/m8fvqbCixMD3Sl2TdBVQzGFvwbhCc7GY+W1PZKb3niy0RnEp7ynbaItQWZloJLIrNC+Hcc+33L4q1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=021r4Foq; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=nzRAI9Bm; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752324242; x=1752929042;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=3hsAftBbWhEHVqUIKPhJJLEw9P2gRr/T0ErS4BPPLBI=;
	b=021r4Foqi/XPzdzuHHaBc/y43I6LhWARnZteRrjDdXyLagsCMHjGqpuI0z1jKAHp/bsoyGB3ypbKl
	 nRZa336xwNRGhc1O/+ebjgEb5SFzsgVNTxVRuqwUNo5xrWQ3rF91M5Xu+PRq6m6hqaSB9IbkQI9R7q
	 h4rWmJryPbxsrf+tcuS0DGoIikZzfrlFAHx7EUe/KhuUzs9FR7bLEBUp9E2Oi2gVyjgWRHLL49d/D6
	 3J/R0fJE9LZCSRP4+DnwogDq+z9/y5TOVcE7+AwLNfcWu5u0QRWFMGf0McGwZgCqwim3+mdhkR7RH6
	 Bo7/NgB0zJfAHhV4kYsCl9lrg/DrKqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752324242; x=1752929042;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=3hsAftBbWhEHVqUIKPhJJLEw9P2gRr/T0ErS4BPPLBI=;
	b=nzRAI9Bmd8f+g3EqfvU7tY76SJchTfBnMo5Yh+77Sb5A6fJ1GUbyHxw6yupAh65rwqwMZ+0PVUXwO
	 zFFy29sDA==
X-HalOne-ID: e2b9d497-5f1d-11f0-b78d-85eb291bc831
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id e2b9d497-5f1d-11f0-b78d-85eb291bc831;
	Sat, 12 Jul 2025 12:44:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v12 2/4] mm/slub: allow to set node and align in
 k[v]realloc
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <5bc89531-ab09-4690-aae4-a44f9ddb4a68@suse.cz>
Date: Sat, 12 Jul 2025 14:43:51 +0200
Cc: Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 bpf@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AD3F7B5-679F-4DC8-968F-9FE991B56A5C@konsulko.se>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172441.1032006-1-vitaly.wool@konsulko.se> <aHDSLyHZ8b1ELeWe@hyeyoo>
 <5bc89531-ab09-4690-aae4-a44f9ddb4a68@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 11, 2025, at 5:43=E2=80=AFPM, Vlastimil Babka <vbabka@suse.cz> =
wrote:
>=20
> On 7/11/25 10:58, Harry Yoo wrote:
>> On Wed, Jul 09, 2025 at 07:24:41PM +0200, Vitaly Wool wrote:
>>> Reimplement k[v]realloc_node() to be able to set node and
>>> alignment should a user need to do so. In order to do that while
>>> retaining the maximal backward compatibility, add
>>> k[v]realloc_node_align() functions and redefine the rest of API
>>> using these new ones.
>>>=20
>>> While doing that, we also keep the number of  _noprof variants to a
>>> minimum, which implies some changes to the existing users of older
>>> _noprof functions, that basically being bcachefs.
>>>=20
>>> With that change we also provide the ability for the Rust part of
>>> the kernel to set node and alignment in its K[v]xxx
>>> [re]allocations.
>>>=20
>>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>>> ---
>>> fs/bcachefs/darray.c   |  2 +-
>>> fs/bcachefs/util.h     |  2 +-
>>> include/linux/bpfptr.h |  2 +-
>>> include/linux/slab.h   | 38 +++++++++++++++----------
>>> lib/rhashtable.c       |  4 +--
>>> mm/slub.c              | 64 =
+++++++++++++++++++++++++++++-------------
>>> 6 files changed, 72 insertions(+), 40 deletions(-)
>>=20
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index c4b64821e680..6fad4cdea6c4 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4845,7 +4845,7 @@ void kfree(const void *object)
>>> EXPORT_SYMBOL(kfree);
>>>=20
>>> static __always_inline __realloc_size(2) void *
>>> -__do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>> +__do_krealloc(const void *p, size_t new_size, unsigned long align, =
gfp_t flags, int nid)
>>> {
>>> void *ret;
>>> size_t ks =3D 0;
>>> @@ -4859,6 +4859,20 @@ __do_krealloc(const void *p, size_t new_size, =
gfp_t flags)
>>> if (!kasan_check_byte(p))
>>> return NULL;
>>>=20
>>> + /* refuse to proceed if alignment is bigger than what kmalloc() =
provides */
>>> + if (!IS_ALIGNED((unsigned long)p, align) || new_size < align)
>>> + return NULL;
>>=20
>> Hmm but what happens if `p` is aligned to `align`, but the new object =
is not?
>>=20
>> For example, what will happen if we  allocate object with size=3D64, =
align=3D64
>> and then do krealloc with size=3D96, align=3D64...
>>=20
>> Or am I missing something?
>=20
> Good point. We extended the alignment guarantees in commit =
ad59baa31695
> ("slab, rust: extend kmalloc() alignment guarantees to remove Rust =
padding")
> for rust in a way that size 96 gives you alignment of 32. It assumes =
that
> rust side will ask for alignments that are power-of-two and sizes that =
are
> multiples of alignment. I think if that assumption is still honored =
than
> this will keep working, but the check added above (is it just a sanity =
check
> or something the rust side relies on?) doesn't seem correct?
>=20

It is a sanity check and it should have looked like this:

        if (!IS_ALIGNED((unsigned long)p, align) && new_size <=3D ks)
                return NULL;

and the reasoning for this is the following: if we don=E2=80=99t intend =
to reallocate (new size is not bigger than the original size), but the =
user requests a larger alignment, it=E2=80=99s a miss. Does that sound =
reasonable?

~Vitaly


