Return-Path: <bpf+bounces-64781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F31B16E17
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555321C205FC
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269128E5F3;
	Thu, 31 Jul 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="e/0ZkerW";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="24f4CS50"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9C28D8E1
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952584; cv=none; b=P1JGtpXY6QONOSVXo21GRB3E/s+dvd6HCupowe6XQmZPHkksna0xvSBz6Wap5FmM4XFiz2mwNARxXJ8Gc+Ua0HVmPBTenEgyJWtjTTHQnxERriHp803KsG7O+okUTbkNdiW8szMnGSPLzZf50u2dKcNwSOZlqfR1Kb2BweNzkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952584; c=relaxed/simple;
	bh=aGrAH/Tbb6SSGgZDJ06gVdgOyL4PKYXs6RPb1SJ9MZU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TobmFO+GXpWH9/cTgPp72O0bXzr8bis9vFP9yK7oL82pyk46JCc0KU2e1LCQpw36g4c/88nDrpHTDZOlXFJgGDPAlmfA5ElVS/7WyRMaM8Y9y1QJltry03yeaQqyaZh1AEmvodrWRWZggzi8rMaPFBg09XONdmusJeOTINd+TJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=e/0ZkerW; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=24f4CS50; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753952578; x=1754557378;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=8BwiugyGiIx5huwWXGhp1Gaxm7XgAQiVNO4WhfBafE8=;
	b=e/0ZkerWldZOJhyo3/TNKzQlyQwDWSN/m8zXlitwCXnrR+wG+qmSEqSaHodl8x+XmshVpWl4zg6DU
	 Jf1Rb6ChBQ8hoVKTkpzYFz29jcnxVQ+9Xoh0CemHD+keH9kdizHHIsPh+KTfqEiIHl1uOrqhO50bxJ
	 REYRelU9ufsTV7QIVSiqII3DTovBqwLvZIF5yTvR+ZFkd1XdlfnaJx4L6TtVy50eV/+WO1lXvd1g7x
	 CZOmMHmOID250oilyVtZgMagshmylzUruRzOzhkbPRBIbpR1VmSiTrx0RCcQWVbw55ZnASQ3TZN8YG
	 vxwXpZ8Bk4lYEXJuR40QklGd6jlpolA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753952578; x=1754557378;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=8BwiugyGiIx5huwWXGhp1Gaxm7XgAQiVNO4WhfBafE8=;
	b=24f4CS50xBjUkRcbBmrVztFzUeo6tMFD47Di0TF9dCJJwkK5aDnTsR71NoAxweYI7Q+NCT9HWK1vM
	 x30J+0ZCw==
X-HalOne-ID: 25f7a752-6ded-11f0-b15b-d510462faafc
Received: from smtpclient.apple (unknown [2a01:cb1d:9264:6f00:816e:7fc8:3908:5295])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 25f7a752-6ded-11f0-b15b-d510462faafc;
	Thu, 31 Jul 2025 09:02:57 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v14 4/4] rust: support large alignments in allocations
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <DBPO1RQMZDH2.2WFOZO0X4DODN@kernel.org>
Date: Thu, 31 Jul 2025 11:02:45 +0200
Cc: linux-mm@kvack.org,
 akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
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
Message-Id: <933C4F7E-0E14-4C6A-AA18-ADB21CE1953F@konsulko.se>
References: <20250730191921.352591-1-vitaly.wool@konsulko.se>
 <20250730192101.358943-1-vitaly.wool@konsulko.se>
 <DBPO1RQMZDH2.2WFOZO0X4DODN@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jul 30, 2025, at 10:18=E2=80=AFPM, Danilo Krummrich =
<dakr@kernel.org> wrote:
>=20
> On Wed Jul 30, 2025 at 9:21 PM CEST, Vitaly Wool wrote:
>> diff --git a/rust/kernel/alloc/allocator_test.rs =
b/rust/kernel/alloc/allocator_test.rs
>> index d19c06ef0498..17b27c6e9e37 100644
>> --- a/rust/kernel/alloc/allocator_test.rs
>> +++ b/rust/kernel/alloc/allocator_test.rs
>> @@ -40,6 +40,7 @@ unsafe fn realloc(
>>         layout: Layout,
>>         old_layout: Layout,
>>         flags: Flags,
>> +        nid: NumaNode,
>>     ) -> Result<NonNull<[u8]>, AllocError> {
>>         let src =3D match ptr {
>>             Some(src) =3D> {
>=20
> I think this hunk should be on patch 3.
>=20
> Also, don't you see a warning when running the rusttest target? I =
think it has
> to be _nid, given that the argument is unused.

Indeed, thanks. I=E2=80=99ll respin the patchset shortly.

~Vitaly=

