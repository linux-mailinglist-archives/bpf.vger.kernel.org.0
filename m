Return-Path: <bpf+bounces-20966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A0845D7A
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C23292B9B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C05257;
	Thu,  1 Feb 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfb6dsY3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B85468C;
	Thu,  1 Feb 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805673; cv=none; b=aDBAaAFuFcJRv+QLhxB9AW6yxSz4vxUke+aYIbanqj4AYBgxLlY057+MaegOBR8J4bDFiu6bZEgaMKu5a3MDQVPpPG/T58ozBOZ1IE3XYcAf9vLm/M5Q7zSMxglY4jv/wFerennSH/4DDqKvNokYvwV1ddS0K4T9OiLFeNUvlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805673; c=relaxed/simple;
	bh=C5qACvJe4fco+aV4C5Cr3NGN+Os63Z8yz1zzXlaXL0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlkdzs4itg9sAzxURwereSBfR9v49WAhPWdBcZgWGtxKw9CADd097O9YIr6//XcOM1mIeoxyIaoNbFloK9JNH9UraPbQvhLCY0968yt+3IZJDnstgmeIalHu6Tz1yEoNtoO0rhVEf0LWwDtcyWd8EKIoi6plp/6V5EjAyT6FpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfb6dsY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139FC433F1;
	Thu,  1 Feb 2024 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805673;
	bh=C5qACvJe4fco+aV4C5Cr3NGN+Os63Z8yz1zzXlaXL0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfb6dsY3vtKeeT9ssgHQFDkW7nhyCtSHlIS+KFNcFWWfF2Idcv/tp2O8xVuVNNAy+
	 AMf0SH08itOSEYRCoVAMT6l4CZeTQEJ2qSKIfm7H0QlhTgICs8UJ3say4XVSDDAEGG
	 zpG3tzZM9xvAzwoh8gyaav6LOqJrFI9sBWuixreV/U/E60RJ+NbOGHU3h/LuV8uyMU
	 gbSlqwbMXgo+fOj7q6XsUKLqnRiNJbobhg0fLkB524fxFh/dP4feFX/ja5rIGigLbS
	 ZEEGqGJGA1XFmi/xRn12+CBuIPGR3xN1W6Wjp/1kYCva2EAEetSrg9t3+SFKvdYsVm
	 +gos90HrwjgvQ==
Date: Thu, 1 Feb 2024 17:41:09 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 3/5] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <ZbvJpQfyz-QG8EdQ@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <c93dce1f78bd383c117311e4d53e2766264f6759.1706451150.git.lorenzo@kernel.org>
 <20240131154740.615966a9@kernel.org>
 <ZbuBwvCa4diMHNhk@lore-desk>
 <20240201071512.0fb7c5ee@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RMohjYX9M5WO5zrC"
Content-Disposition: inline
In-Reply-To: <20240201071512.0fb7c5ee@kernel.org>


--RMohjYX9M5WO5zrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 1 Feb 2024 12:34:26 +0100 Lorenzo Bianconi wrote:
> > > nit: doesn't look all that related to a netif, I'd put it in skbuff.c=
 =20
> >=20
> > ack, fine. skb_segment_for_xdp() in this case?
>=20
> I think the closest thing we have now is skb_cow_data(),
> so how about skb_cow_data_pp() or skb_cow_fragged() or
> skb_cow_something? :)

I like skb_cow_something :)

>=20
> I'm on the fence whether we should split the XDP-ness out.
> I mean the only two xdp-related things are the headroom and
> check for xdp_has_frags, so we could also:
>=20
> skb_cow_data_pp(struct page_pool *pool, struct sk_buff **pskb,
> 		unsigned int headroom)
> {
> 	...
> }
>=20
> skb_cow_data_xdp(struct page_pool *pool, struct sk_buff **pskb,
> 		 struct bpf_prog *prog)
> {
> 	if (!prog->aux->xdp_has_frags)
> 		return -EINVAL;
>=20
> 	return skb_cow_data_pp(pool, pskb, XDP_PACKET_HEADROOM);
> }
>=20
>=20
> I think it'd increase the chances of reuse. But that's speculative=20
> so I'll let you decide if you prefer that or to keep it simple.

ack, I agree. I will fix it in v7.

Regards,
Lorenzo

--RMohjYX9M5WO5zrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbvJpQAKCRA6cBh0uS2t
rBQeAQDjWxYXA4LO9NpbdMFqQxHAoE9xCllfwg+tem94ByDntgD/SW9IojM4gQtJ
+FhLDKxDQnSEbDtMvTUK368/jepCQwQ=
=qvpZ
-----END PGP SIGNATURE-----

--RMohjYX9M5WO5zrC--

