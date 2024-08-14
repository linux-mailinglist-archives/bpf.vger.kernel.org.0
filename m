Return-Path: <bpf+bounces-37176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB4B951B29
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE6DB21DDA
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DE1B0124;
	Wed, 14 Aug 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rgrqfVZ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8q8arsUs"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3D25762;
	Wed, 14 Aug 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639872; cv=none; b=F0WzAABtLooWfAd8BZCZd7pSV/KLE2qa6Hxio6QmHab7BcUVZIDCk6SXNPJJMbNcX9V486ckf+TzZiglD1hR8089FMl5CXPy3H3k740cQjS67d9Gk+JiGJm4gQZoSmCEWTG/v/nuXmtgQKkRdwuHQb9yua2FCHzkhMC4osX3AhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639872; c=relaxed/simple;
	bh=3sbw3+PDT3iR0dyONO/UTUtZ6DXK8c6Xypp2vGcYEbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tAgue2M6c1rVTCZ5QPukM25UfASJmlAIlXlTAh6rSSsa/75Hk8MrCRNWxA5y+9Qs3pPRi4dd9pseUqFRf9vOeKpQAVP/CbobRF9roedbqxAX2ZD4STVHlbv1WjkxaaAHu8eVcdPx4QeZg4R0Aebm7QL0dzaxxW+jQ1uNIMgmWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rgrqfVZ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8q8arsUs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723639867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sbw3+PDT3iR0dyONO/UTUtZ6DXK8c6Xypp2vGcYEbk=;
	b=rgrqfVZ/YJC2m0mkhG8DbZaaLBAFc2ylT15KhjtAn9TtNpfV/rTArOHvWRGmnB93SiSjO0
	qWdStS4uLPsqmFeNPn5Uo/7bH+9AKvN9YCASjJftfYdal9Qi3sUAsljWLBfdGiggj/c18w
	QNXDco9vJ30lkKVeMYAcFhutLnaRlzb0ZED9x1BsAQO/qaK+S0cIF71xJEAMNQ5JM3MH/+
	NN3KfB9WEwIeqlN2pq7u/xpr2tpEkkam/AbLJLTdvM3d8QXHYulRHqu4+7Hhd4/Ws9nO1q
	vmqiyCpzuz+qLKCZuV6hZokbVQic2Tnm9lchpXJjK6YA+pm3QGAd3v4JMVraRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723639867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3sbw3+PDT3iR0dyONO/UTUtZ6DXK8c6Xypp2vGcYEbk=;
	b=8q8arsUsU/ym8b6B8oSXA7Hdm3Ixz8AQh7IKya8AkwY8+CUeXWb23gekEdyBUbk96BCA66
	uL2VLuujbWs6NpCA==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 sriram.yagnaraman@ericsson.com, richardcochran@gmail.com,
 benjamin.steinke@woks-audio.com, bigeasy@linutronix.de, Chandan Kumar
 Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 4/4] igb: add AF_XDP zero-copy Tx support
In-Reply-To: <ZryGUj7HBasW7aRI@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-5-anthony.l.nguyen@intel.com>
 <Zrd0vnsU2l0OTsvj@boxer> <874j7nzejz.fsf@kurt.kurt.home>
 <Zrxw+FI7rbYHXN2d@boxer> <871q2rzcw1.fsf@kurt.kurt.home>
 <ZryGUj7HBasW7aRI@boxer>
Date: Wed, 14 Aug 2024 14:51:05 +0200
Message-ID: <87mslfxo7a.fsf@kurt.kurt.home>
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

On Wed Aug 14 2024, Maciej Fijalkowski wrote:
>> >> The amount of irqs can be also controlled by irq coalescing or even
>> >> using busy polling. So I'd rather keep this implementation as simple =
as
>> >> it is now.
>> >
>> > That has nothing to do with what I was describing.
>>=20
>> Ok, maybe I misunderstood your suggestion. It seemed to me that adding
>> the RS bit to the last frame of the burst will reduce the amount of
>> raised irqs.
>
> You got it right, but I don't think it's related to any outer settings.
> The main case here is that by doing what I proposed you get much less PCIe
> traffic which in turn yields better performance.

I see, makes sense. Then, let's address this in another patchset also
for igc.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma8qDkTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgi98EACJZ8Ts55w/WLkf4gEShL0cS/tuQhx+
K9SGiomvBUmO+pqEyYmbdCPS24c6eayRqF8o/rKipfBMTJdteUViqxgQUb2vSrCU
qQl300mdEw/3Llp58icDcUuirQlt1ZmgrHT2QSefcuvzncQ+pmFUcnz9h1l2zjsN
KOizHXY++bRZ/EbE1j3GW857zAC/N+zLrpYR1nkYERm+Bm8EksIEK4o+ezKSZZsd
2IsWgJSG5o/FlbKxI5mrF0XwWKPkQYRatHBqcqaS2nekA3iMecQiwGelA+a2sjTd
hwQDVnaXdWyugfTlMrK1Vcpnj45HrJJdp8T26U8bEzcFFKnKcAwqtxZUmEd42zfS
Qq6GDRSBGOvPY/DzcbqioB01ZSkOSy3iw47pm0TFxZ9+AaKx5qZ6qfKvW4qMZcTV
tX0hVSGxlWv8P074TamjdEhBofsBXCczfEFrG1Vl1P2Rl7lqtyMC+wk/koXsy3dZ
/hlM5p7q9jzBQCBr40gxpoL3JLWu8R9m5I0oFpKe5DzBo9cjaRnL+Zx1zpBLFZHJ
ezfQUt1N2gJ8H9zQFfuXIfM7SGtVVdck49j5EZPVWIMdXSYW5XiemqX5pZIBVz31
CT2ObG0+UOQbd/sALHFdVR32wRcym3Iu1Vfauwty1xiX6qn2Dd/9BrKP2IokBusD
sMe6QGBlcC9APw==
=CtAa
-----END PGP SIGNATURE-----
--=-=-=--

