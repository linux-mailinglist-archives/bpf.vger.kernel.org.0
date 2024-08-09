Return-Path: <bpf+bounces-36771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8994D0CC
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D7AB2175D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2A194AEB;
	Fri,  9 Aug 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="usC5lZNP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVtf8EX3"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24C19307A;
	Fri,  9 Aug 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208724; cv=none; b=awXHbGbirdapLJRoA8CE4mnNqee4y8gq/8zf17dxwgTu8/EGh7Mb1cdMOISDSSDhyaxaGseuqGkEksMJLSvAXwzhbT4abLJzi2n3luzEIicXQkxzlcYiJGLZm0fi/LpVGRddlM5VYfKzBX9Ium2GtBOBTlg8NdYKlV1+/fNvo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208724; c=relaxed/simple;
	bh=1TxU2n/WrJFO7WKPsdUtuzfNLmBI/FWdilYDh3wL93A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ds3S4M3eaYQg6Brp92cu1/5cgiF3/E62rZzAmHdfDyiHJi5NgXL+tLOkT9CA3Jopqq1BqsZvg+6DEjm5BMZPwNDkdCoDgloqt37SXw17r7kVcAe5IA/028WJsYwfcpUuOYvmi7lMIi0bkw9ZSH5gLZJGiO6TGx+4b1sSM9RgGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=usC5lZNP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVtf8EX3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723208720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4h+n+L3qxYQcsKc2n4yh36vH22pbOvngVDqC3iaxo=;
	b=usC5lZNP4Pt3VvAqwfpBJea7ojqs6UI1S+BnGtjtAQKPBVx+VNPx0DOjhP+f+U5eQECQaL
	XozhyMkxn43RYIzPBn4kLuZ2N7VJ2qk+Y6tUZT9I9XpWRFA+XeOavGeYGCyIsovM8dmz1o
	9SGSGcuCpVPY9BCu3MLbq/VSnAW3GXOle2iFtIfYLlaDD5EYjaewx420j3j0Ty2c2RFm+q
	xKOrr/gMXzo+cfN1+cWpWF3RAa7QiD2hZJe7gUCAWMRNqvpvlb3Upboap7yCKK6m77huhH
	xRkiLd6zwi4YnMHPNOG0jVwsJ/ToRO/tC1AePItCG8DAFaFGU2734NBp4SBRow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723208720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jt4h+n+L3qxYQcsKc2n4yh36vH22pbOvngVDqC3iaxo=;
	b=rVtf8EX3I2NabjP7uxn/ny21PzoqJMfhpf9Hk3TAKcHcwVV4eaEWT0fnNp6FtvDJ2ZJfWI
	M9vcU8IHbs6U4OAw==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, sriram.yagnaraman@ericsson.com,
 richardcochran@gmail.com, benjamin.steinke@woks-audio.com,
 bigeasy@linutronix.de, Chandan Kumar
 Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 1/4] igb: prepare for AF_XDP zero-copy support
In-Reply-To: <ZrUsuq1vanahPyOd@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-2-anthony.l.nguyen@intel.com>
 <ZrUsuq1vanahPyOd@boxer>
Date: Fri, 09 Aug 2024 15:05:18 +0200
Message-ID: <87bk21hmnl.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu Aug 08 2024, Maciej Fijalkowski wrote:
> On Thu, Aug 08, 2024 at 11:35:51AM -0700, Tony Nguyen wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Always call igb_xdp_ring_update_tail under __netif_tx_lock, add a
>> comment to indicate that. This is needed to share the same TX ring
>> between XDP, XSK and slow paths.
>
> standalone commit

Ok.

>> +static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
>> +{
>> +	return !!adapter->xdp_prog;
>
> READ_ONCE() plus use this everywhere else where prog is read.

Sure. I'll send v6 to iwl then.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma2FA4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpZoD/4wTi4Cqs7L7tZsVdbabogVDogW+j8p
tQGBKTfLP61D6R4cXHJkvJ/aaYD3XigVuC476MQWG3qFYvuc/wznLTBo0gvylOc+
jYZBpHycQlPLQLaq6wuXVqFv1fthV/JMlwKpPXKUHYkhBt9k19pDsVUdh12eMptG
MwBw7/cNxDS6//r9z6kXqRml5InF7JjpcaOgBkNxTWoNPfTDSfrLX0fZ2OIe6YIu
M70MciIwjyqML+wtgeqEknMkIKrWG3BQIpMGXGPWtMI2ASRjsMoaj+v0uVd3YLYq
/B4/bFGPbTpnZL6A4/HJ5+UaFoBmgJyLnpRBbHtgtMukmjGvJe6xGIs91oyAImME
kz84siTkxap7F5SxdbdTbDqL+9tuc027R+bxGDas/dNDvi3bmMJD7KgWDq2p4eA0
dbIvoeQY6bcGXQWJmjgh1tctc+W30mxJSIecpiD1HEloEZbZ06n5bAamdnF2A30s
TLzyrrKTYDHMd3DecWmA+kwzW8ohT8NrV1nREQP158kgGiK4bR20lhR4PO5kWIpd
Z5YtYMSs3HcasCT+4Ve/Fvv8dWHDQx7grJmpYiOgZk6YSI9HoZ6i617Xk3aA6YLM
s6Mj/Ak3bVzJx8fCqob0OQW1/lxbDrQ9HeAwx7Mnspa3GO00ku5krVgQ0IXkYRTf
ilq0c3m7gWBmBg==
=wmVM
-----END PGP SIGNATURE-----
--=-=-=--

