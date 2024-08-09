Return-Path: <bpf+bounces-36773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FC94D115
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0257F1C212B1
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B019538A;
	Fri,  9 Aug 2024 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cLxUXseC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uirEumlb"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23BB193070;
	Fri,  9 Aug 2024 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209548; cv=none; b=ou2ot82sMsLPk4w4WOo2lYlJx7PuNL4U7QpXXM50f8Z/kvDaYYZpfT4O/sxXHqWlUxOMH4X/gkqcHpn+NBIyn6bM+SyUMRQgKH3f2dVCWrPyns0e+/kduOg1gHezPChw1CVXT9JByha+HJUdyCeDSaZ5d+9fw280UKd0apemYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209548; c=relaxed/simple;
	bh=ErLd6DhGCdux756bOfuNy7+krstMVOwpA8qWXEztB64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADOZJ/TOtaFtOSUPyDRYh0DnMQw4NI37YxGECZ5A4cczaIUNy/nB9EJXxUvxYpKTWBfxB2wAEdiepbIP1EdbKoAznG+MZUcl1wbeLUXQjgcqW6ZMJOM7w/+jKTAsAAUGPryrJLlHJQumR4JvQzfB4BzDIqtzV4/C5VdzqGFd17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cLxUXseC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uirEumlb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723209544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsVL9uRKd35RtMXXNxTtsXkiWw1bWDHQ48y0kUEe6SE=;
	b=cLxUXseC9SXUZJMcLQNdSfhXjCezOC2ic7WGdsaYqg/DJ9pxO8mbFK4a/a373+OAq3w48/
	wzhwpp4PKH97dj34+EmjHJ2JqqhUX5n/cLtcRAh0tvC3VnxVUO87avxCmJTpVG4WDENaZi
	k3Y5FpmwZN88HfnleVBQa/w5S4P0UErCTkbqttWP4xOnqmOtKZBM4XV6CGXlfzqMjdazaF
	98BmXLL6DxBDk9A4dic1SSBaS3Mx9r59ioq/uEFEH5edle9dlp8u4oJUqZHXWgt/MiRlNg
	Rfiw171T9dbTll4133fEbc2CfrEGA5e1Ad7MmiKIn3+hOnIZylCEFcYM9tmEjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723209544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsVL9uRKd35RtMXXNxTtsXkiWw1bWDHQ48y0kUEe6SE=;
	b=uirEumlbq8Il/nk4A3Iq1JMvvphFWKXc5NQoD2Lbk4WOV+quVh3kQmThDdIlnDIwTWNbaD
	jkVVn9cM3FIDjpAg==
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>, "ast@kernel.org"
 <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "sriram.yagnaraman@ericsson.com" <sriram.yagnaraman@ericsson.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "benjamin.steinke@woks-audio.com" <benjamin.steinke@woks-audio.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "Rout, ChandanX"
 <chandanx.rout@intel.com>
Subject: RE: [PATCH net-next 1/4] igb: prepare for AF_XDP zero-copy support
In-Reply-To: <IA1PR11MB6097C23D38FDAEA5B6A72E3882BA2@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-2-anthony.l.nguyen@intel.com>
 <ZrUsuq1vanahPyOd@boxer> <87bk21hmnl.fsf@kurt.kurt.home>
 <IA1PR11MB6097C23D38FDAEA5B6A72E3882BA2@IA1PR11MB6097.namprd11.prod.outlook.com>
Date: Fri, 09 Aug 2024 15:19:03 +0200
Message-ID: <875xs9hm0o.fsf@kurt.kurt.home>
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

On Fri Aug 09 2024, Fijalkowski, Maciej wrote:
>> >> +static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
>> >> +{
>> >> +	return !!adapter->xdp_prog;
>> >
>> > READ_ONCE() plus use this everywhere else where prog is read.
>>=20
>> Sure. I'll send v6 to iwl then.
>
> I'm in the middle of going through rest of the set, will finish today.

Perfect, thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAma2F0cTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgszlD/0TufQkDIM0jQW6RcAFZHg9Bo3YQnme
1L3uQ9fy4gtEOl6FQZDzo7EfNUt6/Z8ZMxNWMR67OIXqUsRyIXoL9iU9J/JyUikk
txXlCwtZXS2E4IUc6WkIhWDdgtW1fr+ha/1rijKR0DlSi9t/3/lUxAxwo8B1zESb
LcObEk0vtV2fXqhM0Ok8uBEnzNWbf0/USXrcwXYB0kplOuNcEk9l6oNhIgawAIpB
JCPkbxARluMR5pdUvvB8PkT9Gmu0DIRajH0UcoawkKeTa+YMNcZWp5RlLfViwihD
b+xXnt+mxW3BbGkA5bgDfZTkzrTSiaHS7aFbLqsS199Iah/PxcZe8X5jOaduEoR8
POLyaHZoJ53slHpASPEQJ/47Okttb3uBbqsCDekaHILDLRvxIbdB20+FPs27DEbf
2csVWW9jnpUgvlCXyEPKPRY6H+HDgjnrOiKIxKE0VNp5s+3azaT2dzAlEQvVY71w
oLn3q5p6bNlQwxAUBcgpIHhUT90l9ad1ufqPzLv87UAbEbkChp5uCLHqPPsAKrQW
77yhejt0SWzvCO28/tI7/RNxhArQzk8k1fovkxa/2WhmzLKcTyFSnm/RLVTyDIaa
uNB+J245+9WQ8sgQ/wjCJlq1Q/EpNAMdVeZY6jhjTIon+XxZhLah3dF1qkUPkABQ
rh6BkcARbl30xg==
=iMGX
-----END PGP SIGNATURE-----
--=-=-=--

