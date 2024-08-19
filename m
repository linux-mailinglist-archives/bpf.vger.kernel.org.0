Return-Path: <bpf+bounces-37511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C72956D1E
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F652825A6
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E01416DC02;
	Mon, 19 Aug 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUrS1NI9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="edGRjFn6"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63516C844;
	Mon, 19 Aug 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077414; cv=none; b=DcI4Oc9qaOzWbreU+CyA2o3Jy9frkp1Q+AT92zNgS3mgJ2x0lDEcqA1BlmKnIaneQcc/NywFX7gM+hi5h1cWRQ/Rwrn6DDJuv3kObGK87N5Kh1hFzxi8vvRg3wt8mEge1oYhff40rj+URMIGyuX7Hj3IkRnyFLV9rmvwUd8n8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077414; c=relaxed/simple;
	bh=+mxhW/AMCmI2oaiMdzAW2dtIm1Ckb87i0ukk7+cIY4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XgXbgVng1ktHNo2y2tG5/KELe1f0EoOIwNlflGbeMXz+8dqgPnu67f7Hk75eCqH58UnoRS4ESxqAPfGbAG/v88NXY6BSnq2bXpcsH2KeU6BEFEa0wkelj7jUGsBST5DEToil0mYlXO3KjuFH7W1SFjw7vCN9puBBjb7wnWwJ0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUrS1NI9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=edGRjFn6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724077409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mxhW/AMCmI2oaiMdzAW2dtIm1Ckb87i0ukk7+cIY4I=;
	b=iUrS1NI9pTD61ICXAO/4wBIl74n5KrnCcoLLIRJtqExUDJFbD1TH94gwxGx2c/gXnkFKqJ
	AXLGlogabypH0IYEP8XLzSgI1K/taJz+aoG5649kccSCcvGzzEpvzFXTJ5Efk9UBmcD53H
	D4mzhDCo9AI0tpOgrP3VCpmIlmbBICmHQP7l7P6DXr6CLUeHDfeYWaTeoU9LaM6eTbK4nA
	UtSdON26Ea2SPv9tmmdTZjMldDHUsIJnCyyqsBVFTijffukQLhZNp+gYz/Gcrl+0XaomQd
	Yzz9vLdWcAWANhhVOU5CbZRwl5Wgb+pKci/BqLD59bVXwrNcUL4o4U2l1c546g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724077409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mxhW/AMCmI2oaiMdzAW2dtIm1Ckb87i0ukk7+cIY4I=;
	b=edGRjFn6pqNQ9iqMPbs5B4pEJsRIwpS4DDzyET7tE6SMA5PZz69RByR20WOQtkjZtEu3Ot
	AXxiyks0NnqfBYBg==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Benjamin Steinke
 <benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v6 2/6] igb: Remove static qualifiers
In-Reply-To: <ZsNEU1OPt6PYhBnT@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-2-4bfb68773b18@linutronix.de>
 <ZsNEU1OPt6PYhBnT@boxer>
Date: Mon, 19 Aug 2024 16:23:27 +0200
Message-ID: <87jzgc8ucg.fsf@kurt.kurt.home>
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

On Mon Aug 19 2024, Maciej Fijalkowski wrote:
> On Fri, Aug 16, 2024 at 11:24:01AM +0200, Kurt Kanzenbach wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Remove static qualifiers on the following functions to be able to call
>> from XSK specific file that is added in the later patches:
>> - igb_xdp_tx_queue_mapping()
>> - igb_xdp_ring_update_tail()
>> - igb_clean_tx_ring()
>> - igb_clean_rx_ring()
>> - igb_xdp_xmit_back()
>> - igb_process_skb_fields()
>
> How about inlining some of these that are small enough?
>
> - igb_xdp_tx_queue_mapping()
> - igb_xdp_ring_update_tail()

Will do.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbDVV8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgowCD/0ep7WJYeDlyu9YzP+Hs3hojDR8zDf7
bZuuR+QZbpX2BFP7pa15MaaRzcIRumkqC4gIse67H++iEBedii9FmntU0LyeaMS/
p6ThB/E6JY7+iCDJfTCTXNJ5A4uf4g8y6qLtizLWjsNhUwKW5HeiT2h9eHDYnJAU
mo9KRYvjG3EFMmskiO7fxzhF5cobwoTgrIR2gOH16pwqM5B3j2rbIRjwNIriYbo5
Q8FQBqXWPMYwxSmY1SEiHOQ5LEp8uM9VyT244UrqT24rCENLO5xKjzyFfx3lma+s
xRgQCtYmmTQhBqC0ujozgiB50TB7yO8PCn/NEfZDEEP8sz8F3gMBGa1YFbpq/m0J
Il8hatVhxOfMBVvseDhEW0wgEZQ/zW25YvIP1C3z/hxAz0u/RYaaioRa+HdRlws2
zp7gtqo8E+jzKG7kK48i6CSikxBI/aauOZQ8ihg76+cBy7SVz7Veeq6WmQ/brJX+
UArZJQZd37cNjDtZALxgvEVAXZgyogXEdfSYiBdfGHKF4Z33i0dpr83tUBi6gWOm
9824+CM91+qJxCbl25HyAC/OPrS0YOlUxusoIxDYiRQbDOpUgw79YjqclpVhn9oi
Z0ry80HGjTeleQ3pg7Xp9JSL1nlofr3OM3mTPpkah7MHhIUhLc7zA1P/rWMFsTXK
Uc+jR5/+VjJ0yA==
=1bJz
-----END PGP SIGNATURE-----
--=-=-=--

