Return-Path: <bpf+bounces-51463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1975FA34E3D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3693A9CB5
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D824A04A;
	Thu, 13 Feb 2025 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSpbBFE1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZmKUni1"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE6245AFA;
	Thu, 13 Feb 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473933; cv=none; b=LowfvBgh0ClapNhAiGE8yIgh6rvcFMDXoai8hY+L9U4iYJOGauMdjYgfR5H7vskDIcUoY3ZO7FiJMFWNluW2spmkoVfdNtTTdB3rzMFIGULvGtEKOsX2XkEKF/Bnl7onN+rIuGQYG1NeHAzDJp1kQbJO/S77yoePhe0yHZIZOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473933; c=relaxed/simple;
	bh=GajXLDN2685pWJo9xC0Nx2+rK1EwQ+K75rt+Q/4qOCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uDb1z/ju94QASnq/E+krX9+nfqKVmgZGYaf2xev7nQFo9G+Ng+Q0QLdz52Ez//ER5G0Ei5eUO8JUTg6zAKDpuQy7UL9fRie1kzAvOZBhQLEuOPsUY+p2PPEN6340pv2oTz55q4qFqzdJaiYFSdEXSWznEZCRlcpCs8KhQ6XjR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSpbBFE1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZmKUni1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739473929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GajXLDN2685pWJo9xC0Nx2+rK1EwQ+K75rt+Q/4qOCM=;
	b=NSpbBFE1aVWv4CUyVIyy8riKxiF2EC4/siz5rBzOHmG4U22DSfCQNKAOgi5C8eirgRh1ho
	bdpnUTW+2fqZgg1d0EoWomTjaGjCwh5DIOwHQ5uGOq1/YlWZ5OknnB3V+krWU5WnUPtR3C
	pQFv81WdqqMu/IaTr2hh7HjrZGpt+4lhh10WpZ699NXQMnaOfdymm8laArzpbRDDVjEsqb
	sTYUQsP1twvZz3YYXV6FwkT5Tb+ao6OTO3e5FJtp9tpsq5tsXzJaH78aGxs6IN++967t/y
	w8qHULwNTJ4XLP+NKRGHBOBJxV3Xn4wRNTLAiYbmOnmxPp6UzsSfdyCH3nwUnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739473929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GajXLDN2685pWJo9xC0Nx2+rK1EwQ+K75rt+Q/4qOCM=;
	b=iZmKUni1dH4kiDDh/0GIAY089sWMZeS0ib4L4RxdVqhbyRgXwwEqBZ/AkFhfj6lhFMoShn
	QVU77G37xaLlkyDg==
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>, Russell King
 <rmk+kernel@armlinux.org.uk>, Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Kory Maincent <kory.maincent@bootlin.com>, Gal
 Pressman <gal@nvidia.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Andrew Halaney <ahalaney@redhat.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
In-Reply-To: <20250213184613.cqc2zhj2wkaf5hn7@skbuf>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
 <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
 <20250213130003.nxt2ev47a6ppqzrq@skbuf>
 <1c981aa1-e796-4c53-9853-3eae517f2f6d@linux.intel.com>
 <877c5undbg.fsf@kurt.kurt.home> <20250213184613.cqc2zhj2wkaf5hn7@skbuf>
Date: Thu, 13 Feb 2025 20:12:06 +0100
Message-ID: <87v7td3bi1.fsf@kurt.kurt.home>
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

On Thu Feb 13 2025, Vladimir Oltean wrote:
> So, confusingly to me, it seems like one operating mode is fundamentally
> different from the other, and something will have to change if both will
> be made to behave the same. What will change? You say mqprio will behave
> like taprio, but I think if anything, mqprio is the one which does the
> right thing, in igc_tsn_tx_arb(), and taprio seems to use the default Tx
> arbitration scheme?

Correct. taprio is using the default scheme. mqprio configures it to
what ever the user provided (in igc_tsn_tx_arb()).

> I don't think I'm on the same page as you guys, because to me, it is
> just odd that the P traffic classes would be the first ones with
> mqprio, but the last ones with taprio.

I think we are on the same page here. At the end both have to behave the
same. Either by using igc_tsn_tx_arb() for taprio too or only using the
default scheme for both (and thereby keeping broken_mqprio). Whatever
Faizal implements I'll match the behavior with mqprio.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmeuRAYTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgoNMEACxHuGRV1xo/6Yr14uiqR7/m6lnJfHO
VTBNS6156eY78HOjVVIf+0xjxVFobt8kZyohcfPY147TRWrpHMg4ZQ1uLu+YGkEi
xDmY+wpwU/CN+/8bbfQwijBQ0fHYGPmP7k0x416USYh3v1pw4nS8jOoZ/jOyV8PG
fM9g5geb8hVNqHwqTSMXA/YUBsZWLHyU21KZ0HPHsw7bADdXLEMWyFhRJaVY7FSD
SOdNfVqqjS0JZVDjq9VG2ducxhT7pX+3eWvtbXQE389lfGTmksx/Y51OFlIbRmpj
pvWvsxdQbD1/eAhnf5KBUWekuFLuGnJfvWI+cj0+Bm4dHiICIQHUgPj7Hg7xNiPs
eF1MfoS6N0ZDoO5RvHRB8DxzqUhBIOtDnEhBSITVraGkvH7C6tmtOHWrx1NSnuAs
d6Ia/wwRTeCKvUfMWkgFdIAJU+FFWSAxbOjNEDPzzbrACs+/M7m6O0tpmZUWnYbN
pXmA3a8EPGgkWxVgXBmQkqaPqCp8idSlLE1K7n7vIumuHfxTkg3QHa8EU7lYogkk
jPBMvornSEgDfvotXaprSHKdW+J0kiGTwZ7xDX3tUcAofflSmtbxFhOeXa3rs8Js
v/GJW2S0mWcjeCRbJePDGeg1PSQwXGmV2PL6WBzNOhjSBvwluBguSQnrLhfYwXtK
icCpedLirXUfiQ==
=C6Aw
-----END PGP SIGNATURE-----
--=-=-=--

