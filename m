Return-Path: <bpf+bounces-73090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3AC22D8F
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CD03B4F1D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F821D3CD;
	Fri, 31 Oct 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0JqK4sx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55D3E47B
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873120; cv=none; b=TmoTCF0Z+3iYPlCUmHiHwuHsSKVWVJpSOoly1itDwK9497r6yJSLiyhfMMc//yqvzQ9T32rvJ0650b6ct1Mr9Se63ef8fGW8V1XcEzyT7gFb47cg2/6FEagsgysVq5uXsFqTU3Q1B+HFRBb0bSaHv8SZxY7HF7ySqpbia2W3+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873120; c=relaxed/simple;
	bh=cXl4F61qk0RRWyXuv/DKPX4iPDEPSy53HnD/apHYfeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N19hYCOtJ9RwGqDgM8HwmohqnMQhUXzQRB4Ylik8n+2iqNh3NrBQNdD3D6cG1Vsmpxxrsy9GeGRVOV8nFJkcAb8pNZXFmwSIL7BBU61YAUfSPDlSkv7NneoUvEv5VUtdXfnvYxcpcuV0cPcxYUY3LPXGj8j8oVSSC4qF57hUIaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0JqK4sx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29521af0e2cso3645415ad.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873119; x=1762477919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXl4F61qk0RRWyXuv/DKPX4iPDEPSy53HnD/apHYfeY=;
        b=N0JqK4sxa9iapIohManbfmYm1PVQZgR9zPrujT0ykBl2pP5nr4pmn5HZ4nhZDzwmmY
         M2ujMCWz2EIiHdRIKakm9+OaztD2InRTlokh1MM8o5umhUg+3bxaDTGDfU3OElN7F7Ri
         scCdB6J1VLob/cHlUnsEI7q5RCYmQpk1djfIqPN2gGcThhunIJrpQamUDaKTnoHTI5zI
         +yiEvTbIYggukiQvIBjJKZ1exa/Za3A0w02TdV+VRasDFyh8ZqlazvNkt6soGRnav6w1
         i8dD6vNpxXZG04CGJ36UhB0dSN0SdyGwdeSSO3fIRGa6mVPprNFAOoda2G8O9EeZzoc7
         XeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873119; x=1762477919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXl4F61qk0RRWyXuv/DKPX4iPDEPSy53HnD/apHYfeY=;
        b=CzbyFqfxo3ks4AJE/chsiPiJRG2nkY/b6Mz0wgrY7NujfyWCoBXGHlqJFgs+k72iqf
         IVL/iqm40gVvjRFPdlvlBOp6ArhpmGnKHJs/fRl5V7GWeOdIMxAtS5SpeqmUy2S0Jf72
         MRNZ3Q+zzxud5uHTfgs4EBrD2vRop78VRTzerCMmwkbEG5hqKaUXDth0TO9Lv739axHf
         jQSfF//8QQn45ojyxIFD3Bfkrtkloj2gCTYhDOjREsLrnfl64BALesNKBuz+YXTV5vIZ
         vEHdMS2UVTW9IWB19XEfElHoUzUnNbs6eW2aRgfjnkzuMwYJYYN+D9BwTxChX02n/NwJ
         wbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbf4KvtWlcZe1HyT/R1S/eRsb7qUApzHY68ekQruR10XouLRbpSJbiH30/qxI4hqkF7QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88Xy1Il7xdpD/BGvcEdCOkBVGM28rmOKQDjNuWwtKagSFcIbx
	75Pgxoip4RRN9SqAfTT1GWPV/HNgJM3Wp3ie0kNhZOvasRGGYh3L0mD0
X-Gm-Gg: ASbGncvTxhOFNDjvwHbBdayh6hFGfKECJT6g4ZRPTKUSxKjnPPcvuMJgk8iuQC+WMyu
	h/tEjXh/nx3h2b1cSUyv+f6P0ANF3B5+nIORCEa/qEdEqbJV7nxupEiGnP38UNr+HDlSKduWJ40
	W+19s3YTwSA9oLWVBpj0RNxMqspOxuCFkDQluxD9cRWBcw0y0jo5ewLhCBTgUKXh1TczoGXLe3p
	GypGQgs5Li+50kZt/WkRwsrj8+rrbwqWstmL0YfEJr+q6BVtb/9TCnyx60Qq4pVZ5vSgOnbfw+c
	rNd7uU2iyfCWvgLWjr3U0V4lqVGu5pgmrN3lANN1uHcegAKiDMTH6DSb3/N3AhV0DEgc4fIYGcW
	FlAaqctiB20T07WV5xB+I2uaVMBwMN6kwlZfk6WcZXlFfx5Y3g5yCw0xzKve2arIDqNXc67cPnA
	/hE9EmpJaaEPo=
X-Google-Smtp-Source: AGHT+IEHapc7w9Gx8yrz+L2DluxT/V1jbCrHhNPlwsrThoMBSWJpdgs28NJQRRnMQSzE2MZMqvg8vA==
X-Received: by 2002:a17:903:3848:b0:294:df00:1886 with SMTP id d9443c01a7336-2951a45a13dmr24237915ad.39.1761873118722;
        Thu, 30 Oct 2025 18:11:58 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699baabsm2864505ad.76.2025.10.30.18.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:11:57 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 49BEB4209E4A; Fri, 31 Oct 2025 08:11:44 +0700 (WIB)
Date: Fri, 31 Oct 2025 08:11:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: Reorganize networking documentation toctree
Message-ID: <aQQM0Likqs1RFNQ1@archie.me>
References: <20251028113923.41932-2-bagasdotme@gmail.com>
 <20251030175018.01eda2a5@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V/o7SHKPHcLe3ZGP"
Content-Disposition: inline
In-Reply-To: <20251030175018.01eda2a5@kernel.org>


--V/o7SHKPHcLe3ZGP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 05:50:18PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 18:39:24 +0700 Bagas Sanjaya wrote:
> > Current netdev docs has one large, unorganized toctree that makes
> > finding relevant docs harder like a needle in a haystack. Split the
> > toctree into four categories: networking core; protocols; devices; and
> > assorted miscellaneous.
> >=20
> > While at it, also sort the toctree entries and reduce toctree depth.
>=20
> Looking at the outcome -- I'm not sure we're achieving sufficient
> categorization here. It's a hard problem to group these things.
> What ends up under Networking devices and Miscellaneous seems
> pretty random. Bunch of the entries under there should be in protocols
> or core. And at the end of the day if we don't have a very intuitive
> categorization the reader has to search anyway. So no point..

Do you have any categorization suggestions then?

--=20
An old man doll... just what I always wanted! - Clara

--V/o7SHKPHcLe3ZGP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQQMywAKCRD2uYlJVVFO
o1U1AQDRwRJPDWDhOoEN0cxpUZAwGPbIiXFoXycOD6tM+zcaFgEA0zj7VgXNOtyM
KSulyuqTMQWLPt+319v8+73/8wrNxw4=
=Slfl
-----END PGP SIGNATURE-----

--V/o7SHKPHcLe3ZGP--

