Return-Path: <bpf+bounces-43122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22229AF662
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64121C214AD
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668712B64;
	Fri, 25 Oct 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6ND4Rfr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CF29A0;
	Fri, 25 Oct 2024 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818215; cv=none; b=RfqxNF0Mtv5UxrnN4Cn1onEfEXXx87DqSSz5rNtg0MT9M/NS0Ufg4g3ezbzIpZX2XIstj/MJambWeW4vk4xO6HKbza77UG4kxAl6Q+soA94tHO7g7H4+6iLu1AUIv9mddHidLDK1r/YeVKENGtsO65mfc9XpDhLHvoyjw481nD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818215; c=relaxed/simple;
	bh=ANao3SalIylcgaUhcEsnm2zI9WSTU3qx2wawj/Ele28=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZW39MS1qSccMR79hpoM04Cni9gi8oDMaTkg2ew/BeklIVmdXj4+KfqEKd6uFcmyQFN262le0+8k4dPcgr+ppcrO19BfGr8ygQHU9p34d/sdhGvsFJ8WDvasSvTtGQZC8msGXpODWPA+3+RwpGvLqgSajJ37/baBC2x4yp9YzKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6ND4Rfr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e5ae69880so1064285b3a.2;
        Thu, 24 Oct 2024 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729818212; x=1730423012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNGcvfWZU2TxEL7LKZ45PLQqJbpzUP1414tKc6KMVMo=;
        b=l6ND4Rfr2hYUUnv6x9Ae3A1r10HkguThzVTc3SjsnklHXJRzOPlOek6DY+i/dJw2lq
         oem469zJXvd7oiZEhs18OtttVr4D4SLLE/KfCjALp6+rroMzMZOcgB5Yfv2cF/RxKj4D
         1p7hOaZWujU+tJmw5z92t52geY11OcVlyefFR6wqdbtJ68XjhMulMNuJNblZynrFKzdN
         /v9e2bBFzz+HZe0uvkqOKZ58+M24dwmLWPexhHzla/E9Kx7WGu2embQ/zdu6jsHstGYL
         304laotOTJd/a1UgiEbRQO9HYM+JAGQqgZlFptNPp7boP1L4Gu/ngmp2Xv3e5RDXtQDf
         E7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818212; x=1730423012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNGcvfWZU2TxEL7LKZ45PLQqJbpzUP1414tKc6KMVMo=;
        b=lEYQ9lPCwAmv/2D7r1j/VuNpk9e5jncM72KOgT47X9Fr7o92f2/sn0E0MCwBmIVlAO
         +22Kkyng+eJ9ETivjFLwdgN1adVh46FI/cw08SbbdAHfNKF9VpW6sGoX6RiiBsF02l5D
         lv3t/6QMHcwXlAdY3ROqKMlA3X8G3DAlpRgqXOv6EyJhf3BaDrz0uEnMYrRuTZwpLlYp
         3PL491XO5rmZ4rYUvB219xnblNF5EhWJd+L103VpCzv2h4+bILxi+O09xqVaVI7SumYE
         TWkfUCWH1NwuVYpKe4U+I41lpbPAlxcLzkj2pJ7XQqx2U0fJZ8n2BfTlkQRLHD5HuaIO
         ry9g==
X-Forwarded-Encrypted: i=1; AJvYcCUlbfAOivhxVXQTmXoVztmupHM87vHdwWRWtIdM+nUQpuhn9AXYMzWRQNAX/tRnbzIyxUCaBsl3@vger.kernel.org, AJvYcCVTUtOiHw+XLt7/PMc6vPtHcX/6hFSC0lkGwpb3C1Bo+IB6KdPgA1e9sMIMf4ZHG0u5a9NH8Fey8B+utTM+@vger.kernel.org, AJvYcCWaMsfjwFx52+xFwyl5zDkHt3fGygosVey34PS3RHz5B3/A5oV321hnIt7NCdfvsrad3KJwYoS8pu8q@vger.kernel.org, AJvYcCX7GfJosawwoyKYd9uEyuRijwyYSmDqTiGU/N/9yPiZPYnxJ3eoCEOBKB/fDDeMqU6Ona8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgsVDKj39yIeG37KOkcCXIqVNlgeEZvDfM3/OUVOcoeyilquD
	XaDggT3v6BcPF+rwLEui9VOHWkPXegmr+yZCZueU3PqZBM3yBhUiTZkVLQ==
X-Google-Smtp-Source: AGHT+IF0cMHbWVTxjfafW97nsmkrbkE+9N3H1YT2wc59PBi6x6/wVg203OFjCMyt2TzZK3h5DDL3hg==
X-Received: by 2002:a05:6a21:70cb:b0:1d9:181f:e6d8 with SMTP id adf61e73a8af0-1d978bacfeamr8947325637.31.1729818212239;
        Thu, 24 Oct 2024 18:03:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a20406sm47220b3a.166.2024.10.24.18.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:03:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 41D904352F21; Fri, 25 Oct 2024 08:03:28 +0700 (WIB)
Date: Fri, 25 Oct 2024 08:03:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joe Damato <jdamato@fastly.com>,
	Linux Networking <netdev@vger.kernel.org>, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/6] docs: networking: Describe irq suspension
Message-ID: <ZxruYJizjXR8KUz0@archie.me>
References: <20241021015311.95468-1-jdamato@fastly.com>
 <20241021015311.95468-7-jdamato@fastly.com>
 <ZxYxqhj7cesDO8-j@archie.me>
 <ZxaCUZ5rNd86gDHG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nCoJbkgUJcwJ4Pal"
Content-Disposition: inline
In-Reply-To: <ZxaCUZ5rNd86gDHG@LQ3V64L9R2>


--nCoJbkgUJcwJ4Pal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 09:33:21AM -0700, Joe Damato wrote:
> On Mon, Oct 21, 2024 at 05:49:14PM +0700, Bagas Sanjaya wrote:
> > On Mon, Oct 21, 2024 at 01:53:01AM +0000, Joe Damato wrote:
> > > diff --git a/Documentation/networking/napi.rst b/Documentation/networ=
king/napi.rst
> > > index dfa5d549be9c..3b43477a52ce 100644
> > > --- a/Documentation/networking/napi.rst
> > > +++ b/Documentation/networking/napi.rst
> > > @@ -192,6 +192,28 @@ is reused to control the delay of the timer, whi=
le
> > >  ``napi_defer_hard_irqs`` controls the number of consecutive empty po=
lls
> > >  before NAPI gives up and goes back to using hardware IRQs.
> > > =20
> > > +The above parameters can also be set on a per-NAPI basis using netli=
nk via
> > > +netdev-genl. This can be done programmatically in a user application=
 or by
> > > +using a script included in the kernel source tree: ``tools/net/ynl/c=
li.py``.
> > > +
> > > +For example, using the script:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +  $ kernel-source/tools/net/ynl/cli.py \
> > > +            --spec Documentation/netlink/specs/netdev.yaml \
> > > +            --do napi-set \
> > > +            --json=3D'{"id": 345,
> > > +                     "defer-hard-irqs": 111,
> > > +                     "gro-flush-timeout": 11111}'
> > > +
> > > +Similarly, the parameter ``irq-suspend-timeout`` can be set using ne=
tlink
> > > +via netdev-genl. There is no global sysfs parameter for this value.
> >=20
> > In JSON, both gro-flush-timeout and irq-suspend-timeout parameter
> > names are written in hyphens; but the rest of the docs uses underscores
> > (that is, gro_flush_timeout and irq_suspend_timeout), right?
>=20
> That's right. The YAML specification uses hyphens throughout, so we
> follow that convention there.
>=20
> In the rest of the docs we use the name of the field which appears
> in the code itself, which uses underscores.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--nCoJbkgUJcwJ4Pal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxruXAAKCRD2uYlJVVFO
o+elAQDkoqcE6id9sBM4flYDeF4AKjCK6eoWx1sJOc1cWJZm+gD/Qhegiolned1A
OLxCqHd6kJJi29DFvz4KZ9i0VkWPUAM=
=6/03
-----END PGP SIGNATURE-----

--nCoJbkgUJcwJ4Pal--

