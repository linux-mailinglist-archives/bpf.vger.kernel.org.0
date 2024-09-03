Return-Path: <bpf+bounces-38838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2496AA3E
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 23:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BD31C217CB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA313F43E;
	Tue,  3 Sep 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcy+32Sy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31829126BF9;
	Tue,  3 Sep 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399228; cv=none; b=T/qGgONNQuztbK2M726RJgDIKKUqGnfokQfd+d1BifrAQiEqvko/GOFAPRUXK6YPD7WGOb6XDN0LIv4cpy/eryeojC3IRBstr0zQsQ1snon3SHHXNYfbeGzjAimD0lFiBSCZkgxu0X5y+56QDkFAkcMgFOQtlTnPiE9mu0ljwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399228; c=relaxed/simple;
	bh=TRTXUqQFASSC2sfWl1tDxNXxSXeWrjjjNTyL3ofIRFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxFPG4vK1Bzzlk5uSbN20ruSPpREQ6ejf+atQypsR5fBnF38nRG8UzcizaPKqny47F8kMY5belu7Hvte21MUmbidzGo0iu93U5RmMj1A0GXF+P/tXipXPceJFXiBqDDO8sny05AWnB6+nxbwJxHLcQw7JsOJPvhgHtiytDkkWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcy+32Sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EA4C4CEC4;
	Tue,  3 Sep 2024 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725399227;
	bh=TRTXUqQFASSC2sfWl1tDxNXxSXeWrjjjNTyL3ofIRFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcy+32SyyNWs9DvcCknqrehZ0qycvbeI2/oXHtMcCUsS+agASWN2lNHi+ue4g1AOv
	 08YSQoCoaFH/t/f+7/XyV8dNczLn0h/urozp/P9E+IlOyk8HAH1x/NUMI6z4cn0SWD
	 Y/wmGzKJkcpkxYSJBsg3MYdt3+lC+5aQpl+T64IvQO2w91IGiNoClj42+ur0vqqvw+
	 HZxOU2lEyxuALluRwpBTic8AlZM/+TquBWT2IB+T687+YOj0C5/whqMCeQeFuJqn8m
	 MtOoov9IoKfXcfjy6YRJkEE+ugijVoKTiyw5qK0BJ7AonMSXF2MQMvI7GYP/1YWK+i
	 u/YAALwDiorZw==
Date: Tue, 3 Sep 2024 23:33:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS frames
Message-ID: <ZteAuB-QjYU6PIf7@lore-desk>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X4TJpRX71CgNtJFP"
Content-Disposition: inline
In-Reply-To: <20240903135158.7031a3ab@kernel.org>


--X4TJpRX71CgNtJFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 30 Aug 2024 18:24:59 +0200 Alexander Lobakin wrote:
> > * patch 4: switch cpumap from a custom kthread to a CPU-pinned
> >   threaded NAPI;
>=20
> Could you try to use the backlog NAPI? Allocating a fake netdev and
> using NAPI as a threading abstraction feels like an abuse. Maybe try
> to factor out the necessary bits? What we want is using the per-cpu=20
> caches, and feeding GRO. None of the IRQ related NAPI functionality
> fits in here.

I was thinking allocating a fake netdev to use NAPI APIs is quite a common
approach, but sure, I will looking into it.

Regards,
Lorenzo

--X4TJpRX71CgNtJFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZteAuAAKCRA6cBh0uS2t
rBhMAPwLo2CYrtIKtGFCymhR3ixx9kulDbNEgsx5341RlzPlXwEAtMsfLpf+0ONw
iCDcu9hQMiby73ZWqMQYrmXUvpKxYQ8=
=B7pJ
-----END PGP SIGNATURE-----

--X4TJpRX71CgNtJFP--

