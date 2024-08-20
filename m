Return-Path: <bpf+bounces-37627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601DF9586D5
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B431C2144C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A718FC9F;
	Tue, 20 Aug 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGEYvTXn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ly5HL7PT"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083D18F2F9;
	Tue, 20 Aug 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156664; cv=none; b=fODN+kYU/ZQ4TPyn7GZZNv6+Opp8jc5KS3uLs3NfxrcyuTrpjUrqvNAj86wcKi8TKHtPId74Q3ws/gwhTqC2lPUnky+sNY0GEmW3vz7JL69DobAxrLVhJoDemx8/NLBINhkH/+MVwGf/SKpzqB63aYDOOoCO3Wbu8ARiOUdayxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156664; c=relaxed/simple;
	bh=uoTE5a6aWpLtaIBQRdoTYQPSHqUjfKBd4l/YRCLQ42E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QZx8J+GEqGRqecrwVrARd4Yrqh6qftmGY0nQYljbKiXQaAXbyhBCoDdkVbkyfmjkcMp4SlE2cyvx+TG4Z9GkDf6fFTpkxvAhnPt9AVlFoudXcILlA3S+cP1jcGDfiqiseVIf2P8E59d4716cnPaXfVBzZMhPo8cCdEXLEr+RXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGEYvTXn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ly5HL7PT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724156660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoTE5a6aWpLtaIBQRdoTYQPSHqUjfKBd4l/YRCLQ42E=;
	b=cGEYvTXndXAP+01WmGPjfMiBag9F+jEvc8/58sZa4+RaYWYmDhjwdHRTMOGuKck4LBvszi
	k3QkO0+03L1tReUptxZ9yATfWJMKkvjzzL2TqVMojqBaoeEotrk956+mvCT8W2bcpnYyD7
	k8DY/TeeqomH/GHfPNYY3+t+22C5t25qzgZ5dr/f+1y4IWmndnUEmFprTwkHQ6YAjghtSU
	+3yOTZwwigJVRk5sP9J91TGyusB0Ad5rpUieG6Z3Vb4vNch4hBxSz0uuQnJZS9JL2/AarA
	DDPEzYg+fEaAueUX/TDIARbGEghib0h/Q9pM+9Fxmec2wJedPhVJiz/hUBXMQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724156660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uoTE5a6aWpLtaIBQRdoTYQPSHqUjfKBd4l/YRCLQ42E=;
	b=Ly5HL7PTzwADtNLVLKl36kqSBDya28e805WoLgOQ4WCoPSUv4aiRVhKwVwArASRgA/DDCs
	Oc1TwXfiYMBs2dBw==
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John
 Fastabend <john.fastabend@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, Benjamin Steinke
 <benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Georg
 Kunz <georg.kunz@ericsson.com>
Subject: RE: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
In-Reply-To: <AS4PR07MB84123D29A27BEB30CECC5FAA908C2@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
 <ZsNGf66OjbqQSTid@boxer> <87r0ak8wan.fsf@kurt.kurt.home>
 <ZsNSc9moGwySgpcU@boxer>
 <AS4PR07MB84123D29A27BEB30CECC5FAA908C2@AS4PR07MB8412.eurprd07.prod.outlook.com>
Date: Tue, 20 Aug 2024 14:24:18 +0200
Message-ID: <87frqzidql.fsf@kurt.kurt.home>
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

Hi Sriram,

On Mon Aug 19 2024, Sriram Yagnaraman wrote:
>> -----Original Message-----
>> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Sent: Monday, 19 August 2024 16:11
>> To: Kurt Kanzenbach <kurt@linutronix.de>
>> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>; Przemek Kitszel
>> <przemyslaw.kitszel@intel.com>; David S. Miller <davem@davemloft.net>;
>> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> Paolo Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>;
>> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
>> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Richard
>> Cochran <richardcochran@gmail.com>; Sriram Yagnaraman
>> <sriram.yagnaraman@ericsson.com>; Benjamin Steinke
>> <benjamin.steinke@woks-audio.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>; intel-wired-lan@lists.osuosl.org;
>> netdev@vger.kernel.org; bpf@vger.kernel.org; Sriram Yagnaraman
>> <sriram.yagnaraman@est.tech>
>> Subject: Re: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
>> helpers
>>
>> On Mon, Aug 19, 2024 at 03:41:20PM +0200, Kurt Kanzenbach wrote:
>> > On Mon Aug 19 2024, Maciej Fijalkowski wrote:
>> > > On Fri, Aug 16, 2024 at 11:24:03AM +0200, Kurt Kanzenbach wrote:
>> > >> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> > >>
>> > >> Add the following ring flag:
>> > >> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
>> > >>
>> > >> Add a xdp_buff array for use with XSK receive batch API, and a
>> > >> pointer to xsk_pool in igb_adapter.
>> > >>
>> > >> Add enable/disable functions for TX and RX rings.
>> > >> Add enable/disable functions for XSK pool.
>> > >> Add xsk wakeup function.
>> > >>
>> > >> None of the above functionality will be active until
>> > >> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev-
>> >xdp_features.
>> > >>
>> > >> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> > >
>> > > Sriram's mail bounces unfortunately, is it possible to grab his
>> > > current address?
>> >
>> > His current email address is in the Cc list. However, i wasn't sure if
>> > it's okay to update the From and SoB of these patches?
>>
>> Okay. Then I believe Sriram should provide a mailmap entry to map his old
>> mail to a new one.
>
> Please feel free to remove my "est.tech" address from From: and
> Signed-of-By:

Ok, I'll replace your est.tech email address with your ericsson one in
all patches. Or do you have a personal address (like gmail), which you
prefer?

What about the copyright in igb_xsk.c? Does it belong to you, or Intel
or to your previous employer?

> I am just glad that my work has not gone to waste. Thank you for that.

You're welcome.

> I will check with my company's *lawyers* to see if I can provide a
> mailmap to my current address :(

Good luck with that :-).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbEivITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgsmkD/0Ty5gZjp0LX3isSDnM5Rmv66yqAmjy
ekDqKQRgrwlSw2WcYb5L/6kT0Lt4+pzEc30b+ye7X+oJiWoOTrI50kFH97h/67/Z
sMx6EXhKfCj5QE5wntyM1TtezRO3ywUoniurk3loHf/qUHvpInlchVe944kPcIJl
Clx0/EtYSUFadLifS5Ny7P3mwFKFt8gM2mDsf2GCESvIopEP/J31XInlVyaov92j
alTFaPA6Hpz9DYro3MPguAvZAin1kX0ayNL00nKDnBQyrw2CiM9/aSfzd4sKBJ46
8KDutbSiWkCW1hVz1+s2nLW0VQl9Iys91f9R1QNoH3DFvnPLVnCTD74mKnVjZ4yl
UxnHliFMzwsUga2HP7zhfp62511xLHVDvXqUTEOAE8vD+fCk/ya3J4F2rgf/FvEl
KJNykfPkt5OPf0D/B2SgmNHwO+1TtZBHvVX7ETQNtt5NQXzX8XyJLV8YNaJ5MBO1
KXv9c3FbwyV8idTxFo9LRZownb+4y7ta9/TZxpW5VBIdoQh7k2IqCfzEpWl7OXjM
qPna6tsTfcC29AKU9rGryYRDNINQGaFaKjvW2kkhN4genh8y8YXaLJjNi1Ii7eME
a9APoqh6pHFHjquyaZzMWN8lj016PDP328Eloli6XR0uGC1m3KDxJDZk2TLVa1JF
NTDaap0WIa5GSA==
=rszS
-----END PGP SIGNATURE-----
--=-=-=--

