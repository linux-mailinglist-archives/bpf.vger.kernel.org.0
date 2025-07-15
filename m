Return-Path: <bpf+bounces-63340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB8B06404
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130AF189B552
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB6254AE1;
	Tue, 15 Jul 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHryj5/M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F924E4C3;
	Tue, 15 Jul 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595942; cv=none; b=ZCrGzcSmzK07qUYFGZvTWURIXL8mTsSc60EAXG4wLItRwWXzoXSmBJS2PAj0aaMRuQXBilkgg5+Wd3yhoIJkkCz5zi/s4ITo/I1fsAJYY3oIG11JwlzaX8GkpYYKcJTUXDJZyFNry4Xfi9lklf7u7gLq8r160x1EIGlsCDBfwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595942; c=relaxed/simple;
	bh=S6NeTh0N+OJFfOpss2s8lIkigkMHFd/akf+52X3RrsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=g7g3r4Z5htJb93hL+wYdlUW6eDEHYGD/iW5USH6EiRMonbyQmmb99kvrlk0N35ir3Q4po7GTpGImZr/TkXTUO7dbsJ85Z2m7H97FhjPc2QM76MOb52v5FU24ARFBjdd+n/Y6tIUG0vsR0PK+21qKHu8K7PcMVAHqthCF4RjYBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHryj5/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D987C4CEF1;
	Tue, 15 Jul 2025 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595941;
	bh=S6NeTh0N+OJFfOpss2s8lIkigkMHFd/akf+52X3RrsU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DHryj5/M1MASVx/6obu/6ILztY1hiSeq6H7Aib/15MQAB2zQBgCr9/3DgzPB9CZn2
	 fytEE+daaQ7mfxvETj2Ty4/FdCf/qn3CU+yB3+U3jsIGzUbSMZJLd520oCqXg7Y6mR
	 bFAOADAf/RCMW74v58FpMWTAKjYJ2Ft9dPchRRPIJTEzLK9fKnHmWew3xwhiDCah9/
	 dzT8rCFea6uK6H5X0chyxTwY6X4DA1qbYd4ZZEfZxyBwOLX7aqinRcEZSjc2CRciPX
	 7Q8Mu8Gqvp6a+FFfD9+JRC8zaFYGq59iU5KTkgJhzeLdynPn8RqiF13HBTGG/bBBDT
	 UWjPxe4CIgrfA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 18:12:16 +0200
Message-Id: <DBCREQ7KNW50.1CB6ZO5GZHDW9@kernel.org>
Subject: Re: [PATCH v13 2/4] mm/slub: allow to set node and align in
 k[v]realloc
Cc: "Vitaly Wool" <vitaly.wool@konsulko.se>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <linux-mm@kvack.org>,
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 <rust-for-linux@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 <linux-bcachefs@vger.kernel.org>, <bpf@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "Kent Overstreet" <kent.overstreet@linux.dev>
To: "Vlastimil Babka" <vbabka@suse.cz>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135815.2230224-1-vitaly.wool@konsulko.se>
 <DBCPB0BHKNTQ.K0NWNXIFKCT0@kernel.org>
 <07d3689c-185e-496e-a0b8-53bb3194f0da@suse.cz>
 <DBCQWAOZIGXF.28L8WWU55L1E1@kernel.org>
In-Reply-To: <DBCQWAOZIGXF.28L8WWU55L1E1@kernel.org>

On Tue Jul 15, 2025 at 5:48 PM CEST, Danilo Krummrich wrote:
> On Tue Jul 15, 2025 at 5:34 PM CEST, Vlastimil Babka wrote:
>> On 7/15/25 16:33, Danilo Krummrich wrote:
>>> On Tue Jul 15, 2025 at 3:58 PM CEST, Vitaly Wool wrote:
>>>> diff --git a/fs/bcachefs/darray.c b/fs/bcachefs/darray.c
>>>> index e86d36d23e9e..928e83a1ce42 100644
>>>> --- a/fs/bcachefs/darray.c
>>>> +++ b/fs/bcachefs/darray.c
>>>> @@ -21,7 +21,7 @@ int __bch2_darray_resize_noprof(darray_char *d, size=
_t element_size, size_t new_
>>>>  			return -ENOMEM;
>>>> =20
>>>>  		void *data =3D likely(bytes < INT_MAX)
>>>> -			? kvmalloc_noprof(bytes, gfp)
>>>> +			? kvmalloc_node_align_noprof(bytes, 1, gfp, NUMA_NO_NODE)
>>>>  			: vmalloc_noprof(bytes);
>>>>  		if (!data)
>>>>  			return -ENOMEM;
>>>> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
>>>> index 0a4b1d433621..2d6d4b547db8 100644
>>>> --- a/fs/bcachefs/util.h
>>>> +++ b/fs/bcachefs/util.h
>>>> @@ -61,7 +61,7 @@ static inline void *bch2_kvmalloc_noprof(size_t n, g=
fp_t flags)
>>>>  {
>>>>  	void *p =3D unlikely(n >=3D INT_MAX)
>>>>  		? vmalloc_noprof(n)
>>>> -		: kvmalloc_noprof(n, flags & ~__GFP_ZERO);
>>>> +		: kvmalloc_node_align_noprof(n, 1, flags & ~__GFP_ZERO, NUMA_NO_NOD=
E);
>>>>  	if (p && (flags & __GFP_ZERO))
>>>>  		memset(p, 0, n);
>>>>  	return p;
>>>=20
>>> I assume this is because kvmalloc(), and hence kvrealloc(), does this:
>>>=20
>>> 	/* Don't even allow crazy sizes */
>>> 	if (unlikely(size > INT_MAX)) {
>>> 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>> 		return NULL;
>>> 	}
>>>=20
>>> Do we still consider this a "crazy size"? :)
>>
>> Yeah, with "we" including Linus:
>> https://lore.kernel.org/all/CAHk-=3Dwi=3DPrbZnwnvhKEF6UUQNCZdNsUbr+hk-jO=
WGr-q4Mmz=3DQ@mail.gmail.com/
>
> I don't know why bcachefs needs this, hence my question. But I agree that=
 this
> clearly raises an eyebrow. :)

I.e. this is me noting that we're considering anything larger to be unreaso=
nable
while having an in-tree user bypassing this check intentionally.

