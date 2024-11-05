Return-Path: <bpf+bounces-43978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB59BC25D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3387B21D70
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438218EB0;
	Tue,  5 Nov 2024 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUXlVV46"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972CB65C;
	Tue,  5 Nov 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769175; cv=none; b=icSuy00cCNG10FsbDoijAlXEn5O56bwFnrFsb+zUgxndTHZExiGJh0NrFJsieSQ+UEKdxu6rFE8oBFUyjaXcePyRgCeBuIND+/BQb8rRO+72+Ds1vHhQ/DcgjEJxl2wnVB227gNBCFEsu2LEGhzbuD/B4dJO7Mw5WGsd6TlvdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769175; c=relaxed/simple;
	bh=m5C8XOivdf7KbGpUTDlvdSqBiY3dppczrSUlFvWubTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbggbFNgFSRJockn7pkfluB3TMFQAl4qMazUQcz5vBp2FzHARL6jE/QOOHPouDAlv86o7jyx+zoiELByM0Y4kwmfP7wxt9dlPP5OYb5p39Xw+Tc8o3ohDjZ/x/9xMlXQ1OZJCwque/2ybkJ5Kt419QusiCLWA1y3JW2lLuc658Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUXlVV46; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720e94d36c8so1762434b3a.1;
        Mon, 04 Nov 2024 17:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730769174; x=1731373974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5C8XOivdf7KbGpUTDlvdSqBiY3dppczrSUlFvWubTQ=;
        b=IUXlVV46MPiEigbGQORzeK63UHIk3vzQbQ+Kqa2EeN9plrj8KayGmGxTI608atCJ0z
         YgJqL76bURDOIvLbmheq6S39XlPnDPTx5UQMXmsGVTSuVjuAq530WvadFknkJ2DLOHIW
         AkcGuhJH+H3pfOy+DSez2vpO9kuy4inG0/VbMz2E3T83HTUkJ/pC71rGtBMI1T7ZreGv
         5K3BAvVl3BGKLd6kXxsMH1j10ySlfx/Ph6DaHBGBoXTr1Za8lg31Gf170lJDzxZkNB01
         A/c396AjS+qDo4EcvorcG6N/hVJcj04mz+3bRCEBoYHiRyQx1OSs8UiBJFQnwKsR9jHY
         Zhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769174; x=1731373974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5C8XOivdf7KbGpUTDlvdSqBiY3dppczrSUlFvWubTQ=;
        b=eR2UbsmRuh+6s08rmVvuWBIonvTV6reBFSppE13A0Qhv64I+nU6igNk4GoPwQS1PXU
         j0K9aHy7zZKNV+gMf0z+2uTOAMj98PxnJWBOFm3s7FMNII+fx7Xih6rquxXxXN1RcULJ
         AspuaW6CrnOqthskwaTRrz0rTWCmcl92XLEChdreWYS8qCWwb3SS6PMqSr+KwJt/xqRH
         LDP8dpJPVC6XSG8pRqmz6ayCnKg3gSDkTkJ098F/KwF54KY1XkEHEaNsJWGHlvLpFuD+
         BnetUnkoEX5V/BOLXo5HeEgoCQm51KdNCOKWzAfcwsZDWpv/I8i6JmOuUqJsX3U+rUdt
         L64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy/JZ0vIJlJpPtrumePpw0axITUb4qLufS57oM+FxtuVBRRGs8OzZfQtqDQ9P2r9LXaKIQLDB+y9qV@vger.kernel.org, AJvYcCUzANayArnaAM0ejf5ur2wWFnLbIRitfcQH9k5EZpc3Q05qrXIQRuWXzjrNLo9szoRQPEozEAjU@vger.kernel.org, AJvYcCXOXooVq+A8YMmJfaIJ6XNorAfFeEh+oWVIzpJmYWhOcB8w65sSGr6N9Aka/BmuZA7GRSKb05nJiOTJREU5@vger.kernel.org, AJvYcCXykA/xgebXRIjx1DQrafgoKpIegPHCJy5/zMm97aRnJ4dVtTd1Oc04O20q6rcHIOmPvQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMgFDm+qJLSBBPgXpZ/3TlkxdMH1au9XfBKuS0qRty0OE6fu8
	VEQF8QYGUfJIgN13O2wQKm0Ed5bkxgASH/n3qfUsKyNHVHBJj1Ey
X-Google-Smtp-Source: AGHT+IEjh8MBZRrCtXT5QVUJeeVGt2RL2XWhfBmqTN42Vg7BAdnssjEEu05r9UptXLrxeXGqMM64oA==
X-Received: by 2002:a05:6a21:6da6:b0:1d9:3747:fb51 with SMTP id adf61e73a8af0-1dba4139846mr22781203637.8.1730769173434;
        Mon, 04 Nov 2024 17:12:53 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee455a4fe4sm7570146a12.51.2024.11.04.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 17:12:52 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 74DB1420B6E5; Tue, 05 Nov 2024 08:12:49 +0700 (WIB)
Date: Tue, 5 Nov 2024 08:12:49 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: corbet@lwn.net, hdanton@sina.com, pabeni@redhat.com,
	namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v6 7/7] docs: networking: Describe irq suspension
Message-ID: <ZylxEZFuWZqWAI3q@archie.me>
References: <20241104215542.215919-1-jdamato@fastly.com>
 <20241104215542.215919-8-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DH6iE1DkWfTAyKne"
Content-Disposition: inline
In-Reply-To: <20241104215542.215919-8-jdamato@fastly.com>


--DH6iE1DkWfTAyKne
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 09:55:31PM +0000, Joe Damato wrote:
> Describe irq suspension, the epoll ioctls, and the tradeoffs of using
> different gro_flush_timeout values.
>=20

The docs LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--DH6iE1DkWfTAyKne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZylxDAAKCRD2uYlJVVFO
o19AAQDfxStsVa7EAB7D+0HqQTxFuydhPib6RgS6vTp84x6xIwD/ftvmgbmVvmrk
ZAEbGZ6PedNe74tpHE18Y0UZt2cNAgg=
=7PrK
-----END PGP SIGNATURE-----

--DH6iE1DkWfTAyKne--

