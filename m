Return-Path: <bpf+bounces-53600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B7A57135
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D083B627A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179742500C9;
	Fri,  7 Mar 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJh6JymA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24E215F49
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374847; cv=none; b=QgpSJ6S6DLo6Qi3fddVeRENMB6tT7CYtQZekKQCPuMrFuKvC6ZXhz08M66a37+Tjulfr37FNszQBGqzX+kDEkTVG1PhZQu7PSkgaeyNyEAD7hUvAvZNZb3yCtzoTObzKv5Jn3+x8vQnUsYsMzqGiAqobwO1mEtQXjwGcj3aesvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374847; c=relaxed/simple;
	bh=3xhtrZ+TJQtySeSb/xseGKN2W9jRVmfKw8fd1Y2wtDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEbWdRNkVis7jkZ/710buObRIgGJ2arSoAxY0enxJ1ohL0JPz1p3BvSL+2Vhyf4Z13OlrC4y0mNoZDTh4UtkTPLXdQYQ7shwBwEoLG2Z/k5mRs7BtYRwk2xS2y9vWla9UcGiyQtwcMOU6ADGQdALeeFWbHW+qRUYaLOblaeho8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJh6JymA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741374844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ke/imfqmjQFbYhlRuxax0oJwjbzb0sFUqgVA5hQ4sHA=;
	b=YJh6JymA3T/2EoCR0WP4SCGE1BhS/XEmAQHiMt/Q6zprVFGQ1PrruavWrc5QAANbLvFjuV
	gty2HjusgFlQWwjB8Qu/ReuHzSqQfS+7dSVKpDwbPWHaVbDjWutVdaWpggTHWMEQt7UJq4
	gpwc3iCFe3boFfqdzDLck3+Fj+qczro=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-MgQBM1M_NmO8LMs6Igaiug-1; Fri, 07 Mar 2025 14:14:01 -0500
X-MC-Unique: MgQBM1M_NmO8LMs6Igaiug-1
X-Mimecast-MFC-AGG-ID: MgQBM1M_NmO8LMs6Igaiug_1741374840
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abf75d77447so241274866b.0
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 11:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741374840; x=1741979640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke/imfqmjQFbYhlRuxax0oJwjbzb0sFUqgVA5hQ4sHA=;
        b=CnX2IyM5WEIQuIv1w4/cN3S2VJVCuvC2fyNAcsxHMIUxYL5JmxDKHx0rY7BXzeBt/O
         Dqofpd7YSTIiHUdZO7AiwP5dGxJV5ORjFzyzALpnRwuT7G58A0cfx+UrP2PDYuuZrhr5
         93o4FbjJFXfurmQoIATMifxDEb4FjjnaZwPyoxMPFfmK8yulWbLxirLJ8Lk+NepFCMrL
         sWPzB+XSsXXAsOzv3yw9LYVLyS0+WU5l9YOWwjKag+TpWn5dlJ8lwpbweYa/Ta0mPIO4
         5MIcwcJwYEj4NPMc89GBllNDZDPtSCQX9iYLu2ZaUikygPZfmnvv9b+GWfL751fy3JP8
         98pw==
X-Forwarded-Encrypted: i=1; AJvYcCWIyhtNqmHk49JGOWG4cWmq4DLGBGJapgFDCPrmSA44R/9g86P4gCTHN38dlz8mES5Lecc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIcNS7ZWk93Kz/yBcRv/7PxHsnRXRSGIP5dUImIz96l6oJ+p2
	tw0OPa33LRyAsAlGstclswougfhE3n850pc5o16/b+pu0jB6T74o9r8aRwXKflbkN/wk+okr/j7
	Wrj5qmh57eSWV3/fQMX6noGIlihN4cIGSO5kzoap7Q8CqiJvdZA==
X-Gm-Gg: ASbGncu2zi6uF76djzdF5LSbwwySCqAN+4d5PXYgYGA/vdRmhdaFkK7TcdUozPWFoFk
	73awFpDlTnBSpDI+rKyn+4iLzprG8LhpU76P4owhdHNuTvsTcn7iYniU/ZiSCNB2bRkg+ufmUZ9
	W9IZGBIsa2VL7tlvBDipUmHvnXRWjMFWpZgP5fAH6YS40y+EI0hH78njNtqL3PwpVzcukgsKbnM
	JQW4NvUc33g2qCykTGgn5H+B9SSstSmTkwlDwoaHN0MdXKI5pLa/14xaBaIrh3qTLnhSzM83GpL
	PsWBY2lNXyMAD8ols3XkQunELPl4u9JywRNOK416qdHpmH5TnGNzBBe79zLd79g=
X-Received: by 2002:a17:906:2413:b0:ac2:63a9:df0b with SMTP id a640c23a62f3a-ac263a9e288mr276218066b.35.1741374839869;
        Fri, 07 Mar 2025 11:13:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElNnLAZBDI6vdBytgOWr4aoj3YXGeLzAP6Fxj9C3Xi6uiOz3UgDvkBhP0pOyBnLDfxJ2Xvlw==
X-Received: by 2002:a17:906:2413:b0:ac2:63a9:df0b with SMTP id a640c23a62f3a-ac263a9e288mr276214866b.35.1741374839433;
        Fri, 07 Mar 2025 11:13:59 -0800 (PST)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2394fd4f2sm315470866b.75.2025.03.07.11.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:13:58 -0800 (PST)
Date: Fri, 7 Mar 2025 20:13:57 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: arthur@arthurfabre.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
	thoiland@redhat.com, lbiancon@redhat.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 02/20] trait: XDP support
Message-ID: <Z8tFdSbT7Gg4iO5z@lore-desk>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-2-d0ecfb869797@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K7ngI1ZuMPmb7khg"
Content-Disposition: inline
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-2-d0ecfb869797@cloudflare.com>


--K7ngI1ZuMPmb7khg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 05, arthur@arthurfabre.com wrote:
> From: Arthur Fabre <afabre@cloudflare.com>
>=20

[...]

> +static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
> +{
> +	return xdp->data_hard_start + _XDP_FRAME_SIZE;
> +}
> +
>  static __always_inline void
>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *r=
xq)
>  {
> @@ -133,6 +139,13 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char=
 *hard_start,
>  	xdp->data =3D data;
>  	xdp->data_end =3D data + data_len;
>  	xdp->data_meta =3D meta_valid ? data : data + 1;
> +
> +	if (meta_valid) {

can we relax this constraint and use xdp->data as end boundary here?

> +		/* We assume drivers reserve enough headroom to store xdp_frame
> +		 * and the traits header.
> +		 */
> +		traits_init(xdp_buff_traits(xdp), xdp->data_meta);
> +	}
>  }
> =20
>  /* Reserve memory area at end-of data area.
> @@ -267,6 +280,8 @@ struct xdp_frame {
>  	u32 flags; /* supported values defined in xdp_buff_flags */
>  };
> =20
> +static_assert(sizeof(struct xdp_frame) =3D=3D _XDP_FRAME_SIZE);
> +
>  static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *=
frame)
>  {
>  	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
> @@ -517,6 +532,11 @@ static inline bool xdp_metalen_invalid(unsigned long=
 metalen)
>  	return !IS_ALIGNED(metalen, sizeof(u32)) || metalen > meta_max;
>  }
> =20
> +static __always_inline void *xdp_meta_hard_start(const struct xdp_buff *=
xdp)
> +{
> +	return xdp_buff_traits(xdp) + traits_size(xdp_buff_traits(xdp));

here we are always consuming sizeof(struct __trait_hdr)), right? We can do
somehing smarter and check if traits are really used? (e.g. adding in the f=
lags
in xdp_buff)?

> +}
> +
>  struct xdp_attachment_info {
>  	struct bpf_prog *prog;
>  	u32 flags;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index dcc53ac5c5458f67a422453134665d43d466a02e..79b78e7cd57fd78c6cc8443da=
54ae96408c496b0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -85,6 +85,7 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <net/trait.h>
> =20
>  #include "dev.h"
> =20
> @@ -3935,9 +3936,8 @@ static unsigned long xdp_get_metalen(const struct x=
dp_buff *xdp)
> =20
>  BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
>  {
> -	void *xdp_frame_end =3D xdp->data_hard_start + sizeof(struct xdp_frame);
>  	unsigned long metalen =3D xdp_get_metalen(xdp);
> -	void *data_start =3D xdp_frame_end + metalen;
> +	void *data_start =3D xdp_meta_hard_start(xdp) + metalen;

We could waste 16byte here, right?

Regards,
Lorenzo

>  	void *data =3D xdp->data + offset;
> =20
>  	if (unlikely(data < data_start ||
> @@ -4228,13 +4228,12 @@ static const struct bpf_func_proto bpf_xdp_adjust=
_tail_proto =3D {
> =20
>  BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
>  {
> -	void *xdp_frame_end =3D xdp->data_hard_start + sizeof(struct xdp_frame);
>  	void *meta =3D xdp->data_meta + offset;
>  	unsigned long metalen =3D xdp->data - meta;
> =20
>  	if (xdp_data_meta_unsupported(xdp))
>  		return -ENOTSUPP;
> -	if (unlikely(meta < xdp_frame_end ||
> +	if (unlikely(meta < xdp_meta_hard_start(xdp) ||
>  		     meta > xdp->data))
>  		return -EINVAL;
>  	if (unlikely(xdp_metalen_invalid(metalen)))
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 2c6ab6fb452f7b90d85125ae17fef96cfc9a8576..2e87f82aa5f835f60295d859a=
524e40bd47c42ee 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -1032,3 +1032,53 @@ void xdp_features_clear_redirect_target(struct net=
_device *dev)
>  	xdp_set_features_flag(dev, val);
>  }
>  EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target);
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc int bpf_xdp_trait_set(const struct xdp_buff *xdp, u64 key,
> +				  const void *val, u64 val__sz, u64 flags)
> +{
> +	if (xdp_data_meta_unsupported(xdp))
> +		return -EOPNOTSUPP;
> +
> +	return trait_set(xdp_buff_traits(xdp), xdp->data_meta, key,
> +			 val, val__sz, flags);
> +}
> +
> +__bpf_kfunc int bpf_xdp_trait_get(const struct xdp_buff *xdp, u64 key,
> +				  void *val, u64 val__sz)
> +{
> +	if (xdp_data_meta_unsupported(xdp))
> +		return -EOPNOTSUPP;
> +
> +	return trait_get(xdp_buff_traits(xdp), key, val, val__sz);
> +}
> +
> +__bpf_kfunc int bpf_xdp_trait_del(const struct xdp_buff *xdp, u64 key)
> +{
> +	if (xdp_data_meta_unsupported(xdp))
> +		return -EOPNOTSUPP;
> +
> +	return trait_del(xdp_buff_traits(xdp), key);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(xdp_trait)
> +// TODO - should we use KF_TRUSTED_ARGS? https://www.kernel.org/doc/html=
/next/bpf/kfuncs.html#kf-trusted-args-flag
> +BTF_ID_FLAGS(func, bpf_xdp_trait_set)
> +BTF_ID_FLAGS(func, bpf_xdp_trait_get)
> +BTF_ID_FLAGS(func, bpf_xdp_trait_del)
> +BTF_KFUNCS_END(xdp_trait)
> +
> +static const struct btf_kfunc_id_set xdp_trait_kfunc_set =3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &xdp_trait,
> +};
> +
> +static int xdp_trait_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +					 &xdp_trait_kfunc_set);
> +}
> +late_initcall(xdp_trait_init);
>=20
> --=20
> 2.43.0
>=20
>=20

--K7ngI1ZuMPmb7khg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8tFdQAKCRA6cBh0uS2t
rId7AQDuvojs/jSwdbdL4FsPRua+qnhDfIRtba9O6YimQJbhmgD/WW/ZOWcBZyqF
JV/C1AnDK/bbD+XrnJH0P7NiWPJYVAI=
=9X90
-----END PGP SIGNATURE-----

--K7ngI1ZuMPmb7khg--


