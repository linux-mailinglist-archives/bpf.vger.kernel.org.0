Return-Path: <bpf+bounces-38994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9BF96D3AC
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416E4289D65
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43CB198856;
	Thu,  5 Sep 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpjR9Ma6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXuSTmD7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A819538A;
	Thu,  5 Sep 2024 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529466; cv=none; b=pYrGyk/+j6XxXb8r9/MoNMmKm35RObqYCRJMHsZZhcuavWmOYTfY/RPRlqevt8D5SJJ+y9Q2rj5Z+A0GsxiGG/Rvfap/6bd5ySNdAMEVB86vMVTLgVJ2LQrb3/djvEwBM9uLpMNrlwD+6A298jkZI+yzafiaPWhAXrE9lFp8wF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529466; c=relaxed/simple;
	bh=gGXv2tnI6Kmy/fRpA12pfvXh3zAcEJ16hhyiGQtJuuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnaQMVCo14FVnsn5XuMEKCbq46EMPYVYyl2izUR/xkHhuV8CiVRX5Z317YO6OJhaqFWrdt9x5TXif0KFuf6TJF2Kr51ee7mAosiZHtEIDEG6ISTjoOh/k135vPG8Ju+5kdBEDevjvdKBq/YDVfaMVuyRhyvOf8AQrbk5O12Qzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CpjR9Ma6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXuSTmD7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725529463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gGXv2tnI6Kmy/fRpA12pfvXh3zAcEJ16hhyiGQtJuuQ=;
	b=CpjR9Ma61exW7ol3UmrSxBVZ3HgZSNHq6VurgZkDkqRT3+qAwrol5qU/31/K9CszDQLYCz
	pBN9OLhLrsRPgoOAF0rxP7/bs5aAA6LfW0dsZ96eTsjOH5MsoFn8tQmk5AfDaMfHEfYWhY
	KA4hiNEbEzs0ow4fS9wEPuz6De0b0jEK7yanHLz1Cyn21R5R/vzX/ZQuyIEvCr3sqVlhwI
	Ysm7ip1QS4+f8DIlxDys11NXnDhs5kZ6T4Y+Qbk4b4IwYV3Ryj1yymUoD1h9XxLR3G1bgI
	vIv+x4FLWlH9+DO/bj338t4X/NlKc8rQkfQP09eEmavLdciMumU0UjQ3J5ZK1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725529463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gGXv2tnI6Kmy/fRpA12pfvXh3zAcEJ16hhyiGQtJuuQ=;
	b=DXuSTmD79xdrAwAAK2+Ih6jQ8eBF2b/l68XFagpc8QLc/Ba9bufw3B/j6DmNHY5nct76pl
	f5u8BOWnQ7AtdHCA==
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org
Cc: sasha.neftin@intel.com, vitaly.lifshits@intel.com,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, bigeasy@linutronix.de, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Simon Horman <horms@kernel.org>, Mor Bar-Gabay
 <morx.bar.gabay@intel.com>
Subject: Re: [PATCH net-next 2/6] igc: Get rid of spurious interrupts
In-Reply-To: <b5120c1e-4312-40da-8c11-c0af035dbbb5@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
 <20240830210451.2375215-3-anthony.l.nguyen@intel.com>
 <b5120c1e-4312-40da-8c11-c0af035dbbb5@intel.com>
Date: Thu, 05 Sep 2024 11:44:20 +0200
Message-ID: <87bk12sadn.fsf@kurt.kurt.home>
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

On Thu Sep 05 2024, Dima Ruinskiy wrote:
> On 31/08/2024 0:04, Tony Nguyen wrote:
>> - wr32(IGC_ICS, IGC_ICS_RXDMT0);
>> + struct igc_ring *rx_ring =3D adapter->rx_ring[0];
>> +
>> + if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
>> + clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
>> + wr32(IGC_ICS, IGC_ICS_RXDMT0);
>> + }
> I have some concerns specifically about this code (Legacy/MSI interrupt=20
> case). The code only checks the IGC_RING_FLAG_RX_ALLOC_FAILED flag of=20
> ring 0. What if the failure was on another ring? It seems proper to=20
> iterate over all Rx rings in the adapter (I believe igc can have up to 4).

In case of Legacy/MSI only one vector, one rx queue and one tx queue is
utilized. The MSI-X code has to check for all rings, which it does.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbZfXUTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgiKeD/42QTepFNA6epyU/zNqzqU0qCA25hTH
lC6C/GnsMXI1s+5SgOGDHqYlcf20vKatKaUk/qAfHQhzzetqwSU79e22KGJFEcJC
dzIoLB1t2PWw9c1ehjRaCNQTqUrmS7INoJOFPlg0te9rk7EqtnRrO6cmCPGgd9Ur
gldScf+9FuH0ya9oOFP6nF4okyddRdUSlKDCAKksVDB4WGpSAJzEkTg1Nxg1lgNs
SAJqom/JGlAv6ZcF33pPlU0tQtMvjX0/s865/QaF+S5rbiyvGBZKN5t6AIXB1u+1
f+UmRomSp+GqoX0Fg9uxb1R9MrD9mNAB50oA4gV4DXdrFpOWRkduNZ+1TorvU0vP
xeqpR1yXrr7un8+KnzF664fIA7tmg8XSoys3TG/mt8Fo+3i+gXwI09Ca1YPcDGei
3Lbpc5D9mgtMSVt9bEULUgbwLjTjPQe8KSWB+xku7lUEFrXXA+b/DRIAZtkIHAky
uii3Ra2M1484XvdzjzE7rNU9W7OriSJyopg1FLJt0vVPfkTUKaiYS+UJtJIGb1KM
KU2FY6rJC4yIi1IttsYNUQ8KL3nc/Y4ku0K/uHS5B+4WFC+GyghS8RQFVCTQOWg3
fNJtDR0w+p+fFyBdIyCwNDN3b/l+YJEE16jSWTDnBuG047XIlfDFK89WbSNPDfVv
vfRy4KKEGvi4Kw==
=hG9B
-----END PGP SIGNATURE-----
--=-=-=--

