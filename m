Return-Path: <bpf+bounces-63339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E7B0636A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7683A7B2CE1
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0A24A069;
	Tue, 15 Jul 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll5nqSFn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D651DF99C;
	Tue, 15 Jul 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594498; cv=none; b=f2cEGYfuXjtjH2zF8xzGX5zzz3Mv8BCse5n+qkihRiFlos9U1d8Qght4c1h8foa3NCNT81sLFSVvC6IdLj95hfilu8cumlfLYTph1ZAOwQP4f52yojV7xYMyC3gFGY64rVlBkQSY3LuQ4sHk3fiYsIe9IM0lYLIgwVXoNhnfSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594498; c=relaxed/simple;
	bh=yDmUHWGgxGRLJjN/sJvcSFzoD0oqxgTLlj8Aakr+6zc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=QCnI5pock4KpAFClCNaY1Es6VGjDwFvy2w0gKFBvUnk6aLM3TbsDxcKPYv9ZOTWTPNymnl6ztRc3O0ovsdLn1XEnMV+VZ8mkoU3NF+kemhYwTjpCQ348jJKG51txRP6ekbt9I2mltKvq9BQRZ3yP9AT5JC6DYTpGO7hjgNnusJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll5nqSFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F04C4CEE3;
	Tue, 15 Jul 2025 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594497;
	bh=yDmUHWGgxGRLJjN/sJvcSFzoD0oqxgTLlj8Aakr+6zc=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=ll5nqSFnkHQRwDoKLvbKe//dMvkq9OGgdcszxpaJTiArXkMBFlBEGznIoL9ge1UqC
	 tPNW6WABr+jUY3rf81U5zoaNpmrRK+D1Xh0rlRVG514AbLDqlG4YNK6ttjnHgFrNYU
	 EyyCygEyO645JjBNy57Mzk+zWPur8Dk6bVgjp6YIHobOUWKGXE+8OFcc9+PEIZpO6g
	 bVdgyi+HToePqiBI2Uq23KG+Ky8Uu8yrQnna/Lpx98z1wcnuXAuC9+Nd+tuCjXYHFL
	 5g0d6/IiUJYoiDbpZart9nJhJyWh0hRgX7ts8SQSWemTGI0/SvZypERIvavb2NyXce
	 1YKkrQHJUeE1g==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 17:48:12 +0200
Message-Id: <DBCQWAOZIGXF.28L8WWU55L1E1@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
 <20250715135815.2230224-1-vitaly.wool@konsulko.se>
 <DBCPB0BHKNTQ.K0NWNXIFKCT0@kernel.org>
 <07d3689c-185e-496e-a0b8-53bb3194f0da@suse.cz>
In-Reply-To: <07d3689c-185e-496e-a0b8-53bb3194f0da@suse.cz>

On Tue Jul 15, 2025 at 5:34 PM CEST, Vlastimil Babka wrote:
> On 7/15/25 16:33, Danilo Krummrich wrote:
>> On Tue Jul 15, 2025 at 3:58 PM CEST, Vitaly Wool wrote:
>>> diff --git a/fs/bcachefs/darray.c b/fs/bcachefs/darray.c
>>> index e86d36d23e9e..928e83a1ce42 100644
>>> --- a/fs/bcachefs/darray.c
>>> +++ b/fs/bcachefs/darray.c
>>> @@ -21,7 +21,7 @@ int __bch2_darray_resize_noprof(darray_char *d, size_=
t element_size, size_t new_
>>>  			return -ENOMEM;
>>> =20
>>>  		void *data =3D likely(bytes < INT_MAX)
>>> -			? kvmalloc_noprof(bytes, gfp)
>>> +			? kvmalloc_node_align_noprof(bytes, 1, gfp, NUMA_NO_NODE)
>>>  			: vmalloc_noprof(bytes);
>>>  		if (!data)
>>>  			return -ENOMEM;
>>> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
>>> index 0a4b1d433621..2d6d4b547db8 100644
>>> --- a/fs/bcachefs/util.h
>>> +++ b/fs/bcachefs/util.h
>>> @@ -61,7 +61,7 @@ static inline void *bch2_kvmalloc_noprof(size_t n, gf=
p_t flags)
>>>  {
>>>  	void *p =3D unlikely(n >=3D INT_MAX)
>>>  		? vmalloc_noprof(n)
>>> -		: kvmalloc_noprof(n, flags & ~__GFP_ZERO);
>>> +		: kvmalloc_node_align_noprof(n, 1, flags & ~__GFP_ZERO, NUMA_NO_NODE=
);
>>>  	if (p && (flags & __GFP_ZERO))
>>>  		memset(p, 0, n);
>>>  	return p;
>>=20
>> I assume this is because kvmalloc(), and hence kvrealloc(), does this:
>>=20
>> 	/* Don't even allow crazy sizes */
>> 	if (unlikely(size > INT_MAX)) {
>> 		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>> 		return NULL;
>> 	}
>>=20
>> Do we still consider this a "crazy size"? :)
>
> Yeah, with "we" including Linus:
> https://lore.kernel.org/all/CAHk-=3Dwi=3DPrbZnwnvhKEF6UUQNCZdNsUbr+hk-jOW=
Gr-q4Mmz=3DQ@mail.gmail.com/

I don't know why bcachefs needs this, hence my question. But I agree that t=
his
clearly raises an eyebrow. :)

