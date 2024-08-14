Return-Path: <bpf+bounces-37158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D539D951694
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9231C225EC
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC2B13D52F;
	Wed, 14 Aug 2024 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sB9djppe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YzR2YeaW"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE10347F4A;
	Wed, 14 Aug 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624181; cv=none; b=PyZ15trjxwe4z0LOX3h9sduCAdIrsYZPnjlpV1nbWyWqJEitESFKqNCELmGzY4WonMqeUSGHuu6GjtmD8XfVggkEtnvpJjfEOYGG9VQ5gQqrq9hSHkdDfdmxlL3gYm4l0KiMMclYHe9isGwIIo8JBY99WvNVSYGw6Dh56Z2r2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624181; c=relaxed/simple;
	bh=f+Ml8v1t/ISsuzXvr4UXMpaRSOVhYTO46jSYoDQq7f0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MX7/hXwR0PgJ6D270zp7GMJRCHGv5fyJTju65GNLwSysSgvf4iZbo16yH1kT8wQcP0H8o9e+BnYv669+zbsH6vgkb/w3EUxWFpsJPLCXJjd8EUSxvNPS8GsPiwb2liZct2elSE6XCSHX860HKS1UD2VtB4v6wRzvCYJzURVLwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sB9djppe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YzR2YeaW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723624171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2f0WRZwYOziW+V8P7Q/HBYfwvajlPUsM6+tNEHrVhk=;
	b=sB9djppeNe1eBzrIOPcLh6q8nX/ggMocqzKnhBbAQg4yZK9uyKT95AjyuE5z68FaOMlLmd
	Hyg0z5oxoX7ClblgRYWTXuScminNjzhteyl4VLwkpFMjHjzUWjmjn7XyYRtSkHtslVpp2o
	hY9ZaZj5eWzCT0up5X2yFJpnP4uBdGJuevEs8aoexYmNx6lyWPBJD7LLhdDHQxrDy1rLbt
	HkBbL2F7KIYEVxD8sbsdeO9Uk9h8pdsPGNgEaXJcviHT5E3Pl3ylyF7R7YoidWKZ++N5Xa
	NUh90ezc5CBd+76ZqxSsjE1rwCOyCD74wZR+mD3gO1qALZxTE/XVCv5PEBsqxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723624171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+2f0WRZwYOziW+V8P7Q/HBYfwvajlPUsM6+tNEHrVhk=;
	b=YzR2YeaWyqc7L5x9z+sAXoYwlnH1xW0U0b2Qrb7+g1U63nvFim2QFVhPFv2f0hdkl3bO9r
	Y1W6d7euR88b27Aw==
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
Subject: Re: [PATCH net-next 3/4] igb: add AF_XDP zero-copy Rx support
In-Reply-To: <ZrdxPgcqLdzCXCAS@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-4-anthony.l.nguyen@intel.com>
 <ZrdxPgcqLdzCXCAS@boxer>
Date: Wed, 14 Aug 2024 10:29:29 +0200
Message-ID: <877ccjzevq.fsf@kurt.kurt.home>
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

>>  	case XDP_REDIRECT:
>>  		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
>
> We were introducing a ZC variant of handling XDP verdict due to a fact
> that mostly what happens is the redirect to user space. We observed a
> reasonable perf improvement from likely()fying XDP_REDIRECT case.

Indeed, I can observe an improvement too.

I've introduced igb_run_xdp_zc() which takes care of that
optimization. Also it takes a pointer to the (read once) xsk_pool to
address the other comment.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma8aukTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpkZEACnTZApnoBsKfP0TAyVJaZc4jaSt9g6
VtvILSnJLKdNRX9u2/gaDDYZ3tZqwTeFUdL2rKc76SikQOMgZoFtBYU7kM2ioa0J
iaCpmEp0GXlkAC+/dg98X/fgCnY5BfKMooXG+CCazujpcGCNElCbx4xwSG/+Ut6U
n4VET03ivxYUR/+xRlYaoIHVJBx/5N/CpXJUIfswIST29l+eMBHXO52xd7yLyu3s
NGaG3/XcVu0HLe3YUaWdxn6qmgiDdAKKdXdyyXT9PNY1zXkZRWK3pUvLSxeLUyOA
W8adUIlXcuuhZHA07iMHVVEHp44Piy++qmF9d2t7Zw6xOLWVN3tAgcKlXlEWRZVR
FUaAFKGq+o6DyCIJ6La1S0wrts0af5boVOQHCNGhjvgalesYdwv/nlC7eJkmhAS7
KJJJZPgyK15yozsVnzdRxwb0ah9063b34JFXog7n4AjZ5whQ9Nh9ekV7RL9XukHa
u2E5qyZFizIVTHL1K2yn0HbxzL21pnnXuuTRZWEikvaOuy3pU2CGwsGzGZMYrqEm
SxPoQl64DS6pmyjoxV2x+XiAlbW5ZNHPcA1gLPnAMLiJ1gpSqJsdXG+vqfpFSeEP
wXcurP5oH6U0IGSZUEly6oNdGzqwrRYlnXNC5pBFzNIcnJfcBxNwuSFXl6tt1eSl
rQBY9ExbFKLCWQ==
=IyaS
-----END PGP SIGNATURE-----
--=-=-=--

