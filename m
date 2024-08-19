Return-Path: <bpf+bounces-37512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEDE956D33
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9FF1C226AA
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A4170A39;
	Mon, 19 Aug 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGY/s0Y+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ej0FynEN"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35916F91D;
	Mon, 19 Aug 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077681; cv=none; b=MKG7iemK+LmGTddFFyr2MzHVZnG4fcMvC5jx5LWkL9MRhGpEL0ALlxW5JDHrySDqfCoxd1Z9ZPZdrulISmF7sf9Z2VOBmwybd8CUuIXOso/GxjodEDEd5mullOIAkjeIfRvGD2QYU9zuLk/GJKhxYdbooH7otfp7QUwhWy8ezWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077681; c=relaxed/simple;
	bh=T4kXcrf6U1ZzhbkT3a2rP7wxyAUDvWW2UaMwpDLxAzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V8BYE7UIwiknua35h4ZcKXOD1iqDy3SpWU5NiE0I6nej4Qnzm24/guRS2m+1YRz9fBhiEH651Mo7m2cGC/m0pyHwOFiF/gOafXp3Zc3JatiwVnphuwzsQoSrs9CLFfo9jpWeTD8XFK407hYyAu1hsKCQzib2OxlYOrfhLUsXrwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGY/s0Y+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ej0FynEN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724077677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4kXcrf6U1ZzhbkT3a2rP7wxyAUDvWW2UaMwpDLxAzY=;
	b=mGY/s0Y+57u6UEK597/ujos/ffBufRW9eUCjC9qc5dDtLx5Uq6MS2chEL4u4fugEQaeyWW
	n1LFy9UzGgOIO++3+1i/3bRgZ8oOPsV5qEY9wo0VBS+DninOMs278lRaX64VvopviydTZ5
	AEKCeHyIdR5ikUttitPdqjeVZubrOYYgkMkS0tyvpMIhRjAhoq8YR1iXjH7Cpg68UNExJQ
	9R51NnkiHJMgKynhkYLJznOKA996LaQX/he0QXJgfzVP327KniJBOK0pkQo/cj3deXljP0
	Agzr8w/y+ajnK8ZRa6C/s4p6wtro1cKrxSCfEhoAh2mqC3rcZzbHFowbRKA2Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724077677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4kXcrf6U1ZzhbkT3a2rP7wxyAUDvWW2UaMwpDLxAzY=;
	b=ej0FynENLHM5oq6oeyFlle/rpZ+l0IohArldJYwavZ4ZAwo3bP/RG/GjAZom5lT0yglKHK
	m7enlCFozqmxcxDA==
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
Subject: Re: [PATCH iwl-next v6 4/6] igb: Introduce XSK data structures and
 helpers
In-Reply-To: <ZsNSc9moGwySgpcU@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
 <ZsNGf66OjbqQSTid@boxer> <87r0ak8wan.fsf@kurt.kurt.home>
 <ZsNSc9moGwySgpcU@boxer>
Date: Mon, 19 Aug 2024 16:27:55 +0200
Message-ID: <87h6bg8u50.fsf@kurt.kurt.home>
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
> On Mon, Aug 19, 2024 at 03:41:20PM +0200, Kurt Kanzenbach wrote:
>> On Mon Aug 19 2024, Maciej Fijalkowski wrote:
>> > On Fri, Aug 16, 2024 at 11:24:03AM +0200, Kurt Kanzenbach wrote:
>> >> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> >>=20
>> >> Add the following ring flag:
>> >> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
>> >>=20
>> >> Add a xdp_buff array for use with XSK receive batch API, and a pointer
>> >> to xsk_pool in igb_adapter.
>> >>=20
>> >> Add enable/disable functions for TX and RX rings.
>> >> Add enable/disable functions for XSK pool.
>> >> Add xsk wakeup function.
>> >>=20
>> >> None of the above functionality will be active until
>> >> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.
>> >>=20
>> >> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> >
>> > Sriram's mail bounces unfortunately, is it possible to grab his current
>> > address?
>>=20
>> His current email address is in the Cc list. However, i wasn't sure if
>> it's okay to update the From and SoB of these patches?
>
> Okay. Then I believe Sriram should provide a mailmap entry to map his old
> mail to a new one.
>
>>=20
>> >
>> > You could also update the copyright date in igb_xsk.c.
>>=20
>> Ditto for the copyright. It probably has to be something like
>> Copyright(c) 2023 Ericsson?
>
> It says 2018 Intel. I don't think Sriram was working under E/// employment
> as he said he was forbidden to work on this further and that's why you
> picked it up, right?
>
> My intent was not stir up the copyright pot, though. It can be left as-is
> or have something of a Linutronix/Sriram Yagnamaran mix :P

Let's see if Sriram has something to say about the copyright. If not
i'll just leave this as-is.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbDVmsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgos6EAClRiQ46uuQdJSoVAuRS+Oy0h7N5gSX
DLar3+UBIn0n2vd56pfsvptPA/KYR7bXnQc75LhOidWoXlrHsrP0yyDeoqvNGNM0
Syl2uEeYkok7/C8WvXsMmOtMbIXxJ2H98/0SNwfl8HYp1jzUKVaYGkioi8CyktHN
fPQqX33WMiBHyOMB3AB+Fh5MZ3BtrEc0NbiazK5Nuu0z4MD7tU82By8PS+4iBalk
00lZNcsvufAy2/DBkUx+A5PEpHqd9wUGnGESu9Dyyw5pEJqlT62DjUgA8BEnpTUE
G9iG/mA2/wFt0OIlEnrWMqRuHxO8JV4el4IkuKSrdkHbbA+zcwCnAEi2ApYhbW8s
h5YxhFHMn54jwKUIpMdpdnBlaXq/tYtDkRZqC5fOLDW1gZvcJaK7KaL0p3RT/UPM
dxnDAhMoiJO5iBOn9VgaEUudwl/QhWtGcXlKwFzpKYxZzws7Pgk0hFNFQxeNtPV/
PQDjVf541S4XYf0C+TNL6rr97ffUqTdIx84EzYafw93d1huvWjQWIaa0LzjgTfJu
rquJhAtCJLOfbbghbVao+nuTaTBl+AORwgEcGPJLPu5svP0LxP5h3ZkBRqI5Ozet
mr4WP1MZvCujFjWGRyaV/JhI78MNNF3gppPz+6KNque/G3BjmoKx7xd2+3W2YZjM
6YBuN700RJpouA==
=oq9R
-----END PGP SIGNATURE-----
--=-=-=--

