Return-Path: <bpf+bounces-42400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40079A3BE2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CB41C22FFF
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F9201033;
	Fri, 18 Oct 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4yxB3N6T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8opP18O8"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40518C908;
	Fri, 18 Oct 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248341; cv=none; b=FqijxnDMAuek9QKKGtK70X06GUV8xMQeRJpPkTtCYRLuXQr9LpJXZlFomFeAiI5qKwCM7WnjFdERtJGmfZsuObRn5oKjlLpdW/UjSswLE/z+GXSxwmvje+aMMQY89FRFS+IoaE+DSiIzz1X6nTjdD4QBbzpzvbNvLv0fSGALoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248341; c=relaxed/simple;
	bh=0Jmisw2cLggoK/DDYMrJ+rdowAmrCBTj5NyHjQngiIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TczwQOBmuQ3hSbrso3MMstAI/Lb/GcFg8rfcocYhia/NptGPyc+0mmuDX/b6bFLErfud+n0et/9aQvmP8YWwr4iJOSJdaEubAIWE+P1ICuKTMwAmsjosvCkT5heVrpcWb7KbdZlBB5tb/cDjlw1bkm+9VmtqWBTbcd0x7SFKTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4yxB3N6T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8opP18O8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729248336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kskf9UDezxVGJ4aXQTni8no/qq21DITWsZfuuEZ1kwQ=;
	b=4yxB3N6TbaZy71+8aqvd7ML7qf907GLVntdilhKlZZRann1yDSITkz7a8HQyjxZDcUxCmG
	Y2QoiIsnJhI8B6fPz/8jyykIDsdN8cdX17R7U9z1ZAq5Ce/Mx+SOoLxaEbYdCenJVu4t/L
	GPDlORusEl4P4F4zotOUcVOb27GjhrAVj9wjTJ3/2aoYkUFvovmaftSdSHTrB4RxSrYcYh
	BSrLFTeF/4AICBdADIQC5LDU5tmmzwEUiERNQG6LRRxMi3oqaT1YI73JBotXeLVrVBquUz
	uQlQeUPDsNZp3xZh670VfcXv+gNYwSBJLwAz1SouGKwrydgE4rCZboi2szJwQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729248336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kskf9UDezxVGJ4aXQTni8no/qq21DITWsZfuuEZ1kwQ=;
	b=8opP18O8dIu248QLLC9BECp9981hLdkusjOEtW96d8ONnz112eSzAKk2u4wbu/iGyyqmul
	ifmA7I0scCzrSUBA==
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
Subject: Re: [PATCH iwl-next v9 6/6] igb: Add AF_XDP zero-copy Tx support
In-Reply-To: <ZxIzRJlXA91Bapwt@boxer>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-6-da139d78d796@linutronix.de>
 <ZxIzRJlXA91Bapwt@boxer>
Date: Fri, 18 Oct 2024 12:45:34 +0200
Message-ID: <87frot8zap.fsf@kurt.kurt.home>
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

On Fri Oct 18 2024, Maciej Fijalkowski wrote:
> On Fri, Oct 18, 2024 at 10:40:02AM +0200, Kurt Kanzenbach wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Add support for AF_XDP zero-copy transmit path.
>>=20
>> A new TX buffer type IGB_TYPE_XSK is introduced to indicate that the Tx
>> frame was allocated from the xsk buff pool, so igb_clean_tx_ring() and
>> igb_clean_tx_irq() can clean the buffers correctly based on type.
>>=20
>> igb_xmit_zc() performs the actual packet transmit when AF_XDP zero-copy =
is
>> enabled. We share the TX ring between slow path, XDP and AF_XDP
>> zero-copy, so we use the netdev queue lock to ensure mutual exclusion.
>>=20
>> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>> [Kurt: Set olinfo_status in igb_xmit_zc() so that frames are transmitted,
>>        Use READ_ONCE() for xsk_pool and check Tx disabled and carrier in
>>        igb_xmit_zc(), Add FIXME for RS bit]
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>
> I didn't give you my tag on this patch in previous revision, but from what
> I can see now it can stay here:)

At some point you did [1]. And I didn't remove it, because it felt like
only small changes like adding the FIXME and re-using the xsk pool
pointer were made.

>
> Finally, thanks!
>

Yay :). Thanks for your review and time spent.

[1] - https://lore.kernel.org/intel-wired-lan/ZsNzLvH38p%2FcWwI0@boxer/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmcSPE4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmxjD/4x2gifNl9lijcJL5SfPTDKL1Tmkr61
/shaBi4j9ucmzG23CT9xIgbCS004WltMximufeVHSpJPwWFc0IYgejOrsr3MTAcJ
pXgveA/s6aJjondxglSWv3RAr11lmyl/qI2EtXNtVV2xFaURti0ygJZ+HTUh2POu
8vDMWqCVFyRMpsQPt2N6WdeLRLEpDKxWPkPZWu0pR7tTWC5pfv51tbAEv63iED2P
Md+IgOolqJkC3YKJL61KPg/XK/ztK7ttrLYG+3OiQp19MTj8FVshmR1QGmYsS8mx
2Z/462emgRJGLynRTbRPA1zsy/Qr90V4ox7YeF4BNgCEUtCo3WP2bx7Ib5whi5P/
c7FaqKDmgA0rFsHgdxwgTB13qNJGPjS5I7zHt5+JMZH4rUmGipp0E8/+PfZgyHI3
FPLpJJV+6E6WxOtUBkEMfW+7cuFHrp+OCuXkG7UikVBNbALvNYMXFJw7bGKNHT7S
4RsnxipOMA05ORwnzyHf2G1HGS+kqZl09k5X9vh4vzH+5YuvdfPByVF8ieX3/HP/
qWS7TwaBWoKJdSU0G8EpjKwym18iXm1dWOIVjdU19q1Y6FukuNYkDUwK54iohaRh
2Tp9NYv1iK3E6g311O9krYMTWDE9O+aYYHx2/L0xHEZgH/gmtirnkfFia1vDlBk1
+bVdqz00q5I+eQ==
=iCBf
-----END PGP SIGNATURE-----
--=-=-=--

