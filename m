Return-Path: <bpf+bounces-53717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC0A591F1
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 11:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F54216CCC2
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAB22759A;
	Mon, 10 Mar 2025 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRG5z+v9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F14226556
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603840; cv=none; b=gIK1U93NlpROowNbPdnFDKawr6DJbh6IvzCQruteDEvQUNjbL14d42PJjzB1jAxQf75EOrFNEhQtTFHyXWKspZwkVL84lerLfdhKFhgcdsYmN68fcaBh/0S3YBG5HeDwgi+lCYscqNDcJI6C0ep2hfa4zLTRa8lVg/N2V0ndMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603840; c=relaxed/simple;
	bh=8Ke5r5EWzcOxUSC+3fnaQfDYZktH68rkRSOJseUUTRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAblhAyuRiAVYT0HshYxacpRN1QlVDWGa5AZhuA/DXXs4A3yskrZ4Y0wLUlvOW7JcWQ4Uma7YKl5r8Of2inbsb8UBYR/8Bpn/cQ28HYhZH0H/6sbw+CxEpa1l8ovB3Njvu7QCqToEkF5HGT7bgBd4WY3CGXUksezoIsDmhP5Syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRG5z+v9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741603836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8MDkm0T3YtIhnU9EfRl2HAFi+SIIpJRBoztoRpFsoLM=;
	b=iRG5z+v9FpKfZRJqO/CraQdhEweidtPb5y5QrnaDJXAWyZyeTXdTZdGXrvPb5mkDdwTsmj
	Vglr8JThxNEZMf6uTy0csU+eq3zKcGACUS661R6CGndGbahATkU9pOmuy8HlnHC9klsoV5
	OV1dIGCBfuuQisSnCc0ErTN0ergdask=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-BqQ7KmJxNn2bUDqbxncYyA-1; Mon, 10 Mar 2025 06:50:32 -0400
X-MC-Unique: BqQ7KmJxNn2bUDqbxncYyA-1
X-Mimecast-MFC-AGG-ID: BqQ7KmJxNn2bUDqbxncYyA_1741603831
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac21697a8ebso335154766b.1
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 03:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603831; x=1742208631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MDkm0T3YtIhnU9EfRl2HAFi+SIIpJRBoztoRpFsoLM=;
        b=XCCWE3zKshYUEIhupuKf+uuV3CeOtO+cTg6TNEFuU4Xl84A7DZ80ON6yH8y4vL/rKY
         nD34wj3LX1BWr+YuecLbu6quknY3KtXIKFahvYnTcw7xPEMR3W99icEdSRvBpbzVKh0F
         dtvJvUNUoW6YIoc4iMyob7CcZm0ZgA8+cBXik5d7suqfV2qnANBEaEhgYtD1POPXnTX6
         nM/Jd5LPZWfuqrSekHdI4PRiffK48FUkmI75mUdFnu6gyWyILw9bfOl/ZPRfLz4U2+LU
         VLT9o19JdROqkdqTsZtaWbpVI/63YHBNx9FR1eWKcXRXMbk5297hv6JNDAFp4LjtHPN9
         q1pw==
X-Forwarded-Encrypted: i=1; AJvYcCXs1FRucqpyjzhXGSUdQYRVpNmSoQqeY5vsKAzNPS2NXkBEzxbnSLCxcdt4iWJfnfqHnvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxegMuYx8QwAM/mLZMIajPjcGIzEAVJ00bpW+Ykb/fZXoINELKG
	aR/iMGVGKLu1fDBYDd4YEV0rZ7BHJd+uMZwjGdTO9aEI4QK4LZ29zScc4J8R6JTKf7Uqow7gaOI
	H+/Z9R8Sy+JNIbMDpXsHbEkVw5jxt6Pqav52AJ9P8xJnwA+53Zw==
X-Gm-Gg: ASbGncuZ0rlG0IpQADOJlKBMgBJnlthQN4uXwW7ReO5PaSi1fcpe0diwUyUG1zfN9AR
	CH30kHTWvlCyO6JAntOZZ8FjC6PEDpgU8rNHI2DrZCyH91AFy3AYcTm+aMm8xsSJAuz+HgSLFeY
	FVyK3T8YV2VraGZh7qpXoyj9nzjP6F6DPLWwZPH5rYG4m2+AzFSNBlsm/Ld+96lg8tFxKkY9xli
	Fhu6CJKOwKI2f5n14OjE0RJ6jRRUHu/bYZiF3ufIqpZwbSEU/WW7z512CyqeJzJuS51FqDW+tnf
	ek1HMTCXIz5IctkAeIjr0F5l/+/igg/aQdar1BkUH92cv9PtLkSkzHm/vsGWE38=
X-Received: by 2002:a17:906:d552:b0:ac1:ea29:4e63 with SMTP id a640c23a62f3a-ac252a866b6mr1232132766b.26.1741603830855;
        Mon, 10 Mar 2025 03:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADYNhHzwZIzPXp6bWzsZ5qWlfyUFSyr/MLaLS1nArAA9uovbFqyO+deUUGlUpnOt+OH1Vww==
X-Received: by 2002:a17:906:d552:b0:ac1:ea29:4e63 with SMTP id a640c23a62f3a-ac252a866b6mr1232129566b.26.1741603830418;
        Mon, 10 Mar 2025 03:50:30 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485bf3sm755327266b.63.2025.03.10.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:50:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:50:28 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: arthur@arthurfabre.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
	thoiland@redhat.com, lbiancon@redhat.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 05/20] trait: Replace memcpy calls with
 inline copies
Message-ID: <Z87D9GblwWBZjwE-@lore-desk>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LdxVSwL0xr9PrwX"
Content-Disposition: inline
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>


--8LdxVSwL0xr9PrwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Arthur Fabre <afabre@cloudflare.com>
>=20
> When copying trait values to or from the caller, the size isn't a
> constant so memcpy() ends up being a function call.
>=20
> Replace it with an inline implementation that only handles the sizes we
> support.
>=20
> We store values "packed", so they won't necessarily be 4 or 8 byte
> aligned.
>=20
> Setting and getting traits is roughly ~40% faster.

Nice! I guess in a formal series this patch can be squashed with patch 1/20
(adding some comments).

Regards,
Lorenzo

>=20
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---
>  include/net/trait.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/trait.h b/include/net/trait.h
> index 536b8a17dbbc091b4d1a4d7b4b21c1e36adea86a..d4581a877bd57a32e2ad03214=
7c906764d6d37f8 100644
> --- a/include/net/trait.h
> +++ b/include/net/trait.h
> @@ -7,6 +7,7 @@
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include <linux/bitops.h>
> +#include <linux/unaligned.h>
> =20
>  /* Traits are a very limited KV store, with:
>   * - 64 keys (0-63).
> @@ -145,23 +146,23 @@ int trait_set(void *traits, void *hard_end, u64 key=
, const void *val, u64 len, u
>  			memmove(traits + off + len, traits + off, traits_size(traits) - off);
>  	}
> =20
> -	/* Set our value. */
> -	memcpy(traits + off, val, len);
> -
> -	/* Store our length in header. */
>  	u64 encode_len =3D 0;
> -
>  	switch (len) {
>  	case 2:
> +		/* Values are least two bytes, so they'll be two byte aligned */
> +		*(u16 *)(traits + off) =3D *(u16 *)val;
>  		encode_len =3D 1;
>  		break;
>  	case 4:
> +		put_unaligned(*(u32 *)val, (u32 *)(traits + off));
>  		encode_len =3D 2;
>  		break;
>  	case 8:
> +		put_unaligned(*(u64 *)val, (u64 *)(traits + off));
>  		encode_len =3D 3;
>  		break;
>  	}
> +
>  	h->high |=3D (encode_len >> 1) << key;
>  	h->low |=3D (encode_len & 1) << key;
>  	return 0;
> @@ -201,7 +202,19 @@ int trait_get(void *traits, u64 key, void *val, u64 =
val_len)
>  	if (real_len > val_len)
>  		return -ENOSPC;
> =20
> -	memcpy(val, traits + off, real_len);
> +	switch (real_len) {
> +	case 2:
> +		/* Values are least two bytes, so they'll be two byte aligned */
> +		*(u16 *)val =3D *(u16 *)(traits + off);
> +		break;
> +	case 4:
> +		*(u32 *)val =3D get_unaligned((u32 *)(traits + off));
> +		break;
> +	case 8:
> +		*(u64 *)val =3D get_unaligned((u64 *)(traits + off));
> +		break;
> +	}
> +
>  	return real_len;
>  }
> =20
>=20
> --=20
> 2.43.0
>=20
>=20

--8LdxVSwL0xr9PrwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ87D9AAKCRA6cBh0uS2t
rKiHAP4ig6AB4OYPje30z4tiswFLGKvRQKjJfOWR/9sexp8ODgEA3c2LJVAALxka
vA6BEzSCv3QLZX1Pd1LJJjsBU766WAQ=
=iMCa
-----END PGP SIGNATURE-----

--8LdxVSwL0xr9PrwX--


