Return-Path: <bpf+bounces-22204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BA858EC4
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 11:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF740281CDE
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2870048CFF;
	Sat, 17 Feb 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRQJcQ8f"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319A1EB38
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708166080; cv=none; b=KPOSzTV0aso6DsC4Ic6i/u04IR1A9gbPmQ/lCCgNfQ5+c55jTEreGidmTFzLaRFIwL+7GgOwL0k7fOhIvAnI9XvLRH4QrIIUOuc+hHfP7uWDQHhPucNCsLRtKu+3QCek2gRodg3bwH/vkNF+Ij43nUYJ+YLpM2PAaPYPgU5i11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708166080; c=relaxed/simple;
	bh=LoYxog7Iul3HP3wdb7G/rin5j1GdLBooMdZyC/FXOxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDNtj76v21D4nTYo2+cmD1mUR1lDuJuzF9zxHWggbfYVQv8/Lv6eEQwod0R2nC0RMsyCiIK6uTkYyJamlHs1aGYFn4iRpOwsbbxv4IJmU+/m22tIIRHKb099DLDtIjbC2Fr2cP6zw5W7qI0KAjupTLcfqisAUzFJvRcPxFVkk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRQJcQ8f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708166078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UWlBXzFEHwPmVbbRP4UZJxYV5Y85+s2Si79ETMcdxqU=;
	b=MRQJcQ8f4GSy/ArcEYtwtzWE4bAlERDwidV1rCwAyXd9XSz+GIurRJiv84YAAzCrVR0X3G
	UZz8ElC3HIb+llfQsOAN+rfJ2Ws1uhaT/CIxsitCeADQAWyraq6uPVXU7eqDBkMDyDO3g0
	1SK1+j0BQAoghA44Bi03QF579BBz8Y4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-2S99QXtCMbeTKv8EOEMi8Q-1; Sat, 17 Feb 2024 05:34:36 -0500
X-MC-Unique: 2S99QXtCMbeTKv8EOEMi8Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51169a55bddso2641100e87.0
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 02:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708166074; x=1708770874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWlBXzFEHwPmVbbRP4UZJxYV5Y85+s2Si79ETMcdxqU=;
        b=sf64BZw/FmOef67p3b/fQFYOhvP9bFFgYPObLJXqlz0lpPsderFsfJWKGbFPOzQCv+
         oXIFi1T/BEldQKSr4YWd7PxhGYAEOt3XCBOpSxwV1HMoGKQeA7B5ixco5ETpJzYs81Ql
         ztiXfOu0Nvs2xiQ39iGf11EQvFwoc9RIU7KqnFlIaFCO2dCzBO+2X20B+YQu3RAhG3jQ
         OqYaRKem9j28PzTKUaTKt5UuEc2x/obbnQm4AQy9liXXVKLf6Qh7JvzJifsT365R5Xz0
         mMmd0GI0MdzK51/BO+/4PGnrfYQEU1Pe6FRceO3WDV0NIIA8TrN6gydWinwLe95wHPCU
         3Htg==
X-Forwarded-Encrypted: i=1; AJvYcCU84n53klE7E9+HNQN8+I5HLqCLm+bKkBOqYwyKug7ecdIpsCsv8dvgMdO3Yyxm0XmUjknhAlhM7ElkDVZPfsTiLuzW
X-Gm-Message-State: AOJu0Yx9YTbWFcIW4K6YmN7LKb3Ir++J9fjeZeue/FcKJV0tFlfqXEDV
	WjKexty0EqLhG2BwIiVfbBD9gGtIYLx/sMVtqy52YZj5ba/VAMUyMjRGE8Yx8zREAeiQLqlY3/g
	n8iCuwzWIgWy6coLJtZ2GoK1dQe8nzOOUVFslQYUp44MrtLN/xw==
X-Received: by 2002:ac2:483c:0:b0:511:a40b:e5d0 with SMTP id 28-20020ac2483c000000b00511a40be5d0mr4559573lft.11.1708166074769;
        Sat, 17 Feb 2024 02:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvqBbxclKvPPd1enIMmyMjyfNjsZ9GgGBrmfMmER/7sJQZOnsb/Pz4hBPGwuMO/QSuPQ7/Vw==
X-Received: by 2002:ac2:483c:0:b0:511:a40b:e5d0 with SMTP id 28-20020ac2483c000000b00511a40be5d0mr4559564lft.11.1708166074412;
        Sat, 17 Feb 2024 02:34:34 -0800 (PST)
Received: from localhost (net-93-71-3-198.cust.vodafonedsl.it. [93.71.3.198])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c451200b0040fd1629443sm4945014wmo.18.2024.02.17.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 02:34:33 -0800 (PST)
Date: Sat, 17 Feb 2024 11:34:32 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Julian Wiedmann <jwiedmann.dev@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [PATCH v9 net-next 3/4] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZdCLuFZu_94_HTz5@lore-desk>
References: <cover.1707729884.git.lorenzo@kernel.org>
 <1044d6412b1c3e95b40d34993fd5f37cd2f319fd.1707729884.git.lorenzo@kernel.org>
 <8b68b781-879a-43b5-be41-7b5f75342daf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NkVwt6B95GaEKL1v"
Content-Disposition: inline
In-Reply-To: <8b68b781-879a-43b5-be41-7b5f75342daf@gmail.com>


--NkVwt6B95GaEKL1v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > +	nskb =3D napi_build_skb(data, truesize);
> > +	if (!nskb) {
> > +		page_pool_free_va(pool, data, true);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	skb_reserve(nskb, headroom);
> > +	skb_copy_header(nskb, skb);
> > +	skb_mark_for_recycle(nskb);
> > +
> > +	err =3D skb_copy_bits(skb, 0, nskb->data, size);
> > +	if (err) {
> > +		consume_skb(nskb);
> > +		return err;
> > +	}
> > +	skb_put(nskb, size);
> > +
> > +	head_off =3D skb_headroom(nskb) - skb_headroom(skb);
> > +	skb_headers_offset_update(nskb, head_off);
> > +
> > +	off =3D size;
> > +	len =3D skb->len - off;
> > +	for (i =3D 0; i < MAX_SKB_FRAGS && off < skb->len; i++) {
> > +		struct page *page;
> > +		u32 page_off;
> > +
> > +		size =3D min_t(u32, len, PAGE_SIZE);
> > +		truesize =3D size;
> > +
> > +		page =3D page_pool_dev_alloc(pool, &page_off, &truesize);
> > +		if (!data) {

ack, right. I will post a fix, thx for reporting the issue.

Regards,
Lorenzo

> > +			consume_skb(nskb);
> > +			return -ENOMEM;
> > +		}
> > +
>=20
> This should check for !page instead, no?
>=20
> (picked up as CID 1583654 by the coverity scan for linux-next)
>=20

--NkVwt6B95GaEKL1v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZdCLuAAKCRA6cBh0uS2t
rJ0GAQDpZH9iE0YdpE+xW6XCH02knrRdVHMCuz43ocVx+1pq6AEAropqtCCaPw+8
4DiE29pcuDb4larv+MZ25gK+4+Vg1Qk=
=gjEQ
-----END PGP SIGNATURE-----

--NkVwt6B95GaEKL1v--


