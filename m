Return-Path: <bpf+bounces-53721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A78A592F4
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 12:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB9118874F6
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963721E0BE;
	Mon, 10 Mar 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQEVtXuq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFC22155C
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607113; cv=none; b=r0L2xNJl6PSkGc+5hQiiwCK5ZJsAtqUYhdgAsTZ7aXuMWUJ30xLsDG7OoKVXWCEPdDaDEtFYtWbvM23C2JzaOdHQWPKB0qDe0nVt1t6ec5LOySZGWDJatqvz0qSjNdV4K5fo1zJG7XAd7YEC6xZcJPxXQ8lyVobWm9RrLG/XwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607113; c=relaxed/simple;
	bh=x+WFX7olKDjTcMQvhmFJ+JyUfPsBQ7itCk14a2w6bAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIyyPrCNRelqQEJbl01Xhk1nUuvU9frioxFc9ftxRDmx67poHtmxAUF67BZoqzii8y8xBa19xIjtkz97FRXa/MHcg7LPZ8SBp45dLoQCpUb4sEiPJzE9oVZ9eCEndqnivjF0upol25lcinPH6c94skHIvhggK22XhsjrSc2ywOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQEVtXuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741607110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QfU9xYM0tace1BiK8/7PTtQnMWCzi3j/O4vQ34r5aI=;
	b=JQEVtXuqhJxnQe9kK58JTtUyw5h9m+b2pnxOuhmraLhSpm1uOW+j8oWaRRgf/PlGE7ET/1
	eeyzZLdCFBfZfy5Zfz+KB1gyEvOL4W8bGkIPtOzVdcqEX0phmRzSxeiC3rU5BQhEOxuwr+
	phFdlyl3JDlVHnnNn8q1NQUJwYP9x8c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-f0xjIyvxNfafPoUeFhK9Ug-1; Mon, 10 Mar 2025 07:45:07 -0400
X-MC-Unique: f0xjIyvxNfafPoUeFhK9Ug-1
X-Mimecast-MFC-AGG-ID: f0xjIyvxNfafPoUeFhK9Ug_1741607106
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso27514545e9.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 04:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741607106; x=1742211906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QfU9xYM0tace1BiK8/7PTtQnMWCzi3j/O4vQ34r5aI=;
        b=pbiiJWIhfI+pJkaZh2w/2l87LrXUGqpyNRVcNOOdrNvKbclnvr3bsH9f4cIdQuIRHk
         8/n0Aa2zbASGtCzGjUXzdqHuedcB/4KH99ds4MQafnYbWX1ePvohDFRNBEpOXW1p1wpk
         YJi5zsNI/GYNmKCvnclnV7aHvXsx794NdF5T6UxWOJuHOJB+Vi9IO0XtEY97EQ6dmgHz
         lMp883x4RC/OOeBI48BbzuS07cFm6cjXdupVIGwkObKaZ2pUrUEjRH9MR8lL07bsWiUy
         XwEntGQVDm8Fyq5C+EbDCOTJS3nbc53VDx7x5yiGr8A5LEQbN+/eoOVxMRf+KNWhSsAl
         SGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlAkLFyTRiKR39+tpZO9I26HUCTg6RsQR2F0knhlXN64nf+9bWzuGip2pVMYCHcSIc/eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLqxuvVe5HRx25QlMN9szPWp2rnUZRg/pEHLynEbmxiRvqgrx
	LfsWCt4i9fpPjdHuB5LP4mHg0eorQ/IbQ340R3Rf7LhYKB7yeEgd9qmi1KjG7hmYdW5s54CxhO9
	tqXy1k/IjBu6XnvzZ8P116WMbJNIuW9zhUU0OOAawudEQbt4opw==
X-Gm-Gg: ASbGncsF5xW1OKbRTe0BJZ4tsWjkcwOMs2N9p34cX8/zbZkagPnSpDF8eEYuD0ZnmTj
	pvwpHfoYR6Wtrd0ID8lpgChkaK9HkAusTkev8G6tucdNHWuFoXdOfStJOunGyLqDV9Z+NOQ0Igt
	NZtzZO8VOkvD82P6w+clXLxlT2an5NMvCstclmuCSK52PGbJst4C7XrqoLz/91C24E9f0L2HnuY
	mBDIWWZfnmow9+p90tAHm5ok+G3scuU38ijl+Yzw1+CWwqmJRjre1FN46T1X1W+Yugv1jfYMQr4
	IbEFBNe2+e5LIZC8O2RdPZK5FnFrv5EeJEOP4BO1XNZHIoJsj8fxdD4dOvgnBH0=
X-Received: by 2002:a05:600c:3592:b0:43c:fdbe:439b with SMTP id 5b1f17b1804b1-43cfdbe44femr9279735e9.4.1741607105618;
        Mon, 10 Mar 2025 04:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFntvyjQYUVUh6Y39qXZJ0Lrweu9SVC2j94JbuIrpaWU6W9u+hEflQeu8um6b92DvHRXziOTQ==
X-Received: by 2002:a05:600c:3592:b0:43c:fdbe:439b with SMTP id 5b1f17b1804b1-43cfdbe44femr9279245e9.4.1741607105113;
        Mon, 10 Mar 2025 04:45:05 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm81060755e9.1.2025.03.10.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:45:04 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:45:03 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: arthur@arthurfabre.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
	thoiland@redhat.com, lbiancon@redhat.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 16/20] trait: Support sk_buffs
Message-ID: <Z87Qv2Jf3p3MeXRC@lore-desk>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-16-d0ecfb869797@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DfAkXsiRZSBUgOma"
Content-Disposition: inline
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-16-d0ecfb869797@cloudflare.com>


--DfAkXsiRZSBUgOma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Arthur Fabre <afabre@cloudflare.com>
>=20
> Hide the space used by traits from skb_headroom(): that space isn't
> actually usable.
>=20
> Preserve the trait store in pskb_expand_head() by copying it ahead of
> the new headroom. The struct xdp_frame at the start of the headroom
> isn't needed anymore, so we can overwrite it with traits, and introduce
> a new flag to indicate traits are stored at the start of the headroom.
>=20
> Cloned skbs share the same packet data and headroom as the original skb,
> so changes to traits in one would be reflected in the other.
> Is that ok?
> Are there cases where we would want a clone to have different traits?
> For now, prevent clones from using traits.
>=20
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---
>  include/linux/skbuff.h | 25 +++++++++++++++++++++++--
>  net/core/skbuff.c      | 25 +++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index d7dfee152ebd26ce87a230222e94076aca793adc..886537508789202339c925b56=
13574de67b7e43c 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -39,6 +39,7 @@
>  #include <net/net_debug.h>
>  #include <net/dropreason-core.h>
>  #include <net/netmem.h>
> +#include <net/trait.h>
> =20
>  /**
>   * DOC: skb checksums
> @@ -729,6 +730,8 @@ enum skb_traits_type {
>  	SKB_TRAITS_NONE,
>  	/* Trait store in headroom, offset by sizeof(struct xdp_frame) */
>  	SKB_TRAITS_AFTER_XDP,
> +	/* Trait store at start of headroom */
> +	SKB_TRAITS_AT_HEAD,
>  };
> =20
>  /**
> @@ -1029,7 +1032,7 @@ struct sk_buff {
>  	__u8			csum_not_inet:1;
>  #endif
>  	__u8			unreadable:1;
> -	__u8			traits_type:1;	/* See enum skb_traits_type */
> +	__u8			traits_type:2;	/* See enum skb_traits_type */
>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>  	__u16			tc_index;	/* traffic control index */
>  #endif
> @@ -2836,6 +2839,18 @@ static inline void *pskb_pull(struct sk_buff *skb,=
 unsigned int len)
> =20
>  void skb_condense(struct sk_buff *skb);
> =20
> +static inline void *skb_traits(const struct sk_buff *skb)
> +{
> +	switch (skb->traits_type) {
> +	case SKB_TRAITS_AFTER_XDP:
> +		return skb->head + _XDP_FRAME_SIZE;
> +	case SKB_TRAITS_AT_HEAD:
> +		return skb->head;
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  /**
>   *	skb_headroom - bytes at buffer head
>   *	@skb: buffer to check
> @@ -2844,7 +2859,13 @@ void skb_condense(struct sk_buff *skb);
>   */
>  static inline unsigned int skb_headroom(const struct sk_buff *skb)
>  {
> -	return skb->data - skb->head;
> +	int trait_size =3D 0;
> +	void *traits =3D skb_traits(skb);
> +
> +	if (traits)
> +		trait_size =3D traits_size(traits);
> +
> +	return skb->data - skb->head - trait_size;

I am not fully aware of all possible use-cases, but do we really need to
store hw medata traits (e.g. hw rx checksum or hw rx hash) in the skb
headroom when we convert the xdp_frame/xdp_buff in the skb? All of these
fields already have dedicated fields in the skb struct. Moreover, we need
to set them in order to have a real performance improvements when we execute
XDP_PASS. Something like:

https://lore.kernel.org/bpf/01ce17910fdd7b693c23132663fa884d5ec7f440.172693=
5917.git.lorenzo@kernel.org/

Regards,
Lorenzo

>  }
> =20
>  /**
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7b03b64fdcb276f68ce881d1d8da8e4c6b897efc..83f58517738e8ff12990c28b0=
9336ed44f4be32a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1515,6 +1515,19 @@ static struct sk_buff *__skb_clone(struct sk_buff =
*n, struct sk_buff *skb)
>  	atomic_inc(&(skb_shinfo(skb)->dataref));
>  	skb->cloned =3D 1;
> =20
> +	/* traits would end up shared with the clone,
> +	 * and edits would be reflected there.
> +	 *
> +	 * Is that ok? What if the original skb and the clone take different pa=
ths?
> +	 * Does that even happen?
> +	 *
> +	 * If that's not ok, we could copy the traits and store them in an exte=
nsion header
> +	 * for clones.
> +	 *
> +	 * For now, pretend the clone doesn't have any traits.
> +	 */
> +	skb->traits_type =3D SKB_TRAITS_NONE;
> +
>  	return n;
>  #undef C
>  }
> @@ -2170,7 +2183,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead=
, int ntail,
>  	unsigned int osize =3D skb_end_offset(skb);
>  	unsigned int size =3D osize + nhead + ntail;
>  	long off;
> -	u8 *data;
> +	u8 *data, *head;
>  	int i;
> =20
>  	BUG_ON(nhead < 0);
> @@ -2187,10 +2200,18 @@ int pskb_expand_head(struct sk_buff *skb, int nhe=
ad, int ntail,
>  		goto nodata;
>  	size =3D SKB_WITH_OVERHEAD(size);
> =20
> +	head =3D skb->head;
> +	if (skb->traits_type !=3D SKB_TRAITS_NONE) {
> +		head =3D skb_traits(skb) + traits_size(skb_traits(skb));
> +		/* struct xdp_frame isn't needed in the headroom, drop it */
> +		memcpy(data, skb_traits(skb), traits_size(skb_traits(skb)));
> +		skb->traits_type =3D SKB_TRAITS_AT_HEAD;
> +	}
> +
>  	/* Copy only real data... and, alas, header. This should be
>  	 * optimized for the cases when header is void.
>  	 */
> -	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
> +	memcpy(data + nhead, head, skb_tail_pointer(skb) - head);
> =20
>  	memcpy((struct skb_shared_info *)(data + size),
>  	       skb_shinfo(skb),
>=20
> --=20
> 2.43.0
>=20
>=20

--DfAkXsiRZSBUgOma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ87QvwAKCRA6cBh0uS2t
rOitAQDaUArc6o9q/HqK0/8om4aTm1nmL9iwOsBvkO0dCfMj/QEA7BPhuOjnrmiN
8084+hmr3sbXUZMHUKF+CnqcWAzuIgw=
=SlS4
-----END PGP SIGNATURE-----

--DfAkXsiRZSBUgOma--


