Return-Path: <bpf+bounces-51908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51DA3B105
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 06:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B87D3AF0B1
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 05:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8B81B81DC;
	Wed, 19 Feb 2025 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHOEaCv1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172958BF8;
	Wed, 19 Feb 2025 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943964; cv=none; b=eGtJlt8XTLi1b9k/Hl75LZ5yg5awExdyujJgZ6sJnMngiq6Tg83mngwxrRHz5g9bkrJ+ymFHDv+MEtQJ4AhcigEo9Q65V6N2P2izMNkYLD6NN0AOrn8KDJuwMYsCJeU/+r4/aL0qZpIQ5iwCjDxqEf47Qt86awy8M3IPU/b/5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943964; c=relaxed/simple;
	bh=dGIMySxz5DRw5VQhH38SnBthnAMpo+67IaAIq75P2uw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6lzMZiKq0tt/Ol26vzjUjkuGpud1Q2Dj0p/Xw/YhaVRx93l4GkauH2GzSbKXfEd9SggOpwPhUNf+rd3aS4mgsjUEjqswXV7zRyX5rn8mCggx/e4yJvdGBZKN3sSDvuu4P/RviW1UEIE4Q/TQJVeRNSD3FohVf5iYIyvQ+Vxtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHOEaCv1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso806987a91.1;
        Tue, 18 Feb 2025 21:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739943962; x=1740548762; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdKRTz2Ka05Q/GPi8WGvAjk/zuWSVlVN/wD5pZqv30Y=;
        b=EHOEaCv1Qe0bAn7549wD3V3n/lrqn3py70HekebyZ4ZxdiFDT9I5J+HGd1clTEuVcn
         IJW99FLf6NDGllupSGTBdekdDEy+Qzc6QGxUeXXBcTg6CMVabfs67mzjYrCHaFXcCxTb
         pkZsCjGGEIgNiXtSxS2K11ZvPdKwBWtlhTmcVeaca8MxZiJFQajLQtVryMZJiXL2KXHf
         IxoidKMCq2gVeVM40T4WzVtrh+nLv8yKUjS3SUCszJZfHS5NvvGxKV4cQckwUwGQ6agu
         WWwGCwv1eNusHmD7Y0AVco5DfOftZz2PEVBP1i27wShdB149kOkmBsvz/pQL1hbzamlf
         sZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739943962; x=1740548762;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdKRTz2Ka05Q/GPi8WGvAjk/zuWSVlVN/wD5pZqv30Y=;
        b=M6QAWiSKMRpg7PfoGgPzzDO1ZOtxuJh3TD9Z7mSDIcZnPP6TgSTUATt9fRsrklLH5o
         sSv2eHnRyEVrQsss9KRFIIQuwObof/MxGTEYjJVL48KkBOuWmZY89DfKt0l595ku36gN
         JNQbHUWo3gNL8/cG3TzUTzEmYjjzZ+VAl+otGhmlZybRIY04yjICr0dtnwH/txvxz6Z8
         wUh/qZt16JkdOI6Q29iKEhadOMKG0KjptAgEdcOiBjALut6vr6RctKdKAasKsiO5PuKo
         nhcA1FURXTm/HPKidBz/N5zZejwPlAAgdJ+0Ootij8Lqv6P+xA36HczNtMgTA/I8yeBf
         /PoA==
X-Forwarded-Encrypted: i=1; AJvYcCV2eJiKTRwaTa9P9z2BdCsxYnJEYy4+t6xINPhcK5eH2hUaFlkfBbbwdaSvAdZOhkNdpgB7d5njzA==@vger.kernel.org, AJvYcCWbu+A93668AbX7mo3W0q3iwpsvk9N1CSCxX0HZt5SkTgnJV6GEkd0fK2QLkB0itUte2ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAeF9pyDvBn59QK59ywdVdS3e4/5aXyo/9CVUg/Vz+1OnBiwl
	YCuM5umnNj6Nn4DxxZgIV21Y6QGACjPskxojnCzC5OIJwPaqwnb7
X-Gm-Gg: ASbGncsiKV4k5taTZg3gck2w1lHIQoiVpricSh2bYzEd9fheMO0RGv4Ul9URwGEsHrz
	D7vsiMuKutXqwXasNDWorO39pBuX+40NRdL+lrphLX5X7Agy5RkvgSAtUEBypBcgDtodFJ46L/e
	u7OvHxHIZETb9fNjVX5SWFeEpjuttuJEoIqFJIrkBTeHrnkl0W4EBRmwWU99nmJ6iLEqXvx+CtD
	KLHO0WOy2ezP2l3lfuvw5gMWhfcPMcYTQgwT0JORaCd6ZmSWCq5R8qZxTjqt5xoWiY4xuBDpBY2
	rgEOytdnvGTe
X-Google-Smtp-Source: AGHT+IGLWp10+MouHvHmEbW8dZkzAyZt8k9iM36m7mFL8R6ONKRAvMEdqSmlQSSpOQvYdgz+FP3/RA==
X-Received: by 2002:a17:90b:1b06:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2fcb4cdb6bcmr4042412a91.3.1739943962345;
        Tue, 18 Feb 2025 21:46:02 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba6969sm11125784a91.47.2025.02.18.21.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:46:01 -0800 (PST)
Message-ID: <a1ab7ec2ca121105065e84ad0b7b0f58cf1f6fe3.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 2/4] btf_encoder: emit type tags for
 bpf_arena pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, 	mykolal@fb.com, kernel-team@meta.com
Date: Tue, 18 Feb 2025 21:45:57 -0800
In-Reply-To: <8d222fd0f26fdce0193047074e660abab19ffc32.camel@gmail.com>
References: <20250212201552.1431219-1-ihor.solodrai@linux.dev>
		 <20250212201552.1431219-3-ihor.solodrai@linux.dev>
	 <8d222fd0f26fdce0193047074e660abab19ffc32.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 20:36 -0800, Eduard Zingerman wrote:
> On Wed, 2025-02-12 at 12:15 -0800, Ihor Solodrai wrote:
>=20
> [...]
>=20
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 965e8f0..3cec106 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
>=20
> [...]
>=20
> > +static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
> > +{
> > +	const struct btf_type *ptr;
> > +	int tagged_type_id;
> > +
> > +	ptr =3D btf__type_by_id(btf, ptr_id);
> > +	if (!btf_is_ptr(ptr))
> > +		return -EINVAL;
> > +
> > +	tagged_type_id =3D btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr->type)=
;
> > +	if (tagged_type_id < 0)
> > +		return tagged_type_id;
> > +
> > +	return btf__add_ptr(btf, tagged_type_id);
> > +}
>=20
> I might be confused, but this is a bit strange.
> The type constructed here is: ptr -> type_tag -> t.
> However, address_space is an attribute of a pointer, not a pointed type.
> I think that correct sequence should be: type_tag -> ptr -> t.
> This would make libbpf emit C declaration as follows:
>=20
>   void * __attribute__((address_space(1))) ptr;
>=20
> Instead of current:
>=20
>   void __attribute__((address_space(1))) * ptr;
>=20
> clang generates identical IR for both declarations:
>=20
>   @ptr =3D dso_local global ptr addrspace(1) null, align 8
>=20
> Thus, imo, this function should be simplified as below:
>=20
>   static int btf__tag_bpf_arena_ptr(struct btf *btf, int ptr_id)
>   {
> 	const struct btf_type *ptr;
>=20
> 	ptr =3D btf__type_by_id(btf, ptr_id);
> 	if (!btf_is_ptr(ptr))
> 		return -EINVAL;
>=20
> 	return btf__add_type_attr(btf, BPF_ARENA_ATTR, ptr_id);
>   }
>=20
> [...]
>

Ok, this comment can be ignored.
The following C code:

int foo(void * __attribute__((address_space(1))) ptr) {
  return ptr !=3D 0;
}

does not compile, with the following error reported:

test3.c:1:49: error: parameter may not be qualified with an address space
    1 | int foo(void *__attribute__((address_space(1))) ptr) {
      |

While the following works:

int foo(void __attribute__((address_space(1))) *ptr) {
  return ptr !=3D 0;
}

With the following IR generated:

define dso_local i32 @foo(ptr addrspace(1) noundef %0) #0 { ... }

Strange.


