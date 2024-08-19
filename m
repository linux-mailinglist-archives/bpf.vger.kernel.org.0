Return-Path: <bpf+bounces-37510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B752D956D16
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04676B2633B
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC916D4E3;
	Mon, 19 Aug 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QgYlKwZL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5o+YrMG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728616C863;
	Mon, 19 Aug 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077312; cv=none; b=SL5cN6q9nxTyCDT82gx+C+VylIChsPjsowfFzbBZHTt00TL61agpBOwREBB9H0KSAAjK6WVj8QfwQbK0AIzNzYn10ZOdt3NAZMBk1jnkPqmiS3dO2jBPvpBlnnFaAEdmrY58VKaxhhAzsm1FBsL4970+cyKqbPQCGgkOmSx+lbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077312; c=relaxed/simple;
	bh=SLHhR+rzf4JQqmUikEjK3E7yXqz/4mLlLXIqQxKal6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3wePBQO1Oa2DDYza0b60y8QYxtI2XODrgCWWnd4qdlFy7n9/uTeLSp/18pCGzAeWo4qD7RNSVGWPzM8QR0VIZo/m4Vn/B7Ni1Zpj0/pc4/gPIo8DywyrYXf3INEuwNalXkgKT0WYIBTW/XhhlHtiA30x6Zt933OLQ+pHa+7+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QgYlKwZL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5o+YrMG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724077309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLHhR+rzf4JQqmUikEjK3E7yXqz/4mLlLXIqQxKal6E=;
	b=QgYlKwZLBbVtiPm99BZV8eRbPO1RH43QBIHwGg5skvRuyWRH5SGAoOPxsdUAhhskyPESFq
	+zt6RZ2zCT+s2kOa+9MwBHSUWlokBiX4Efo3UmVzjc8NB/DxUgaouWqC1lTjmRQd5RNnLv
	Tzwpi3ebX3TJy6ajginqQ0A3b7vgmkIHKoHgzGDR1htv4Efo6HuKKJR9nKEWiyzdqg6UNb
	uW3zro91+wD7cQ3LSPlEtgBrTcf6Ys4aDmtwQ7ZjwOTtC7MQFAtLRKpQlmpOfLMj5zO1hf
	g8g+Ew9pSRuemBPCs/vLeWZQzxBmmqebKhouCZrZ6QjclHIsVVk8eJpwNVNdZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724077309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLHhR+rzf4JQqmUikEjK3E7yXqz/4mLlLXIqQxKal6E=;
	b=G5o+YrMGIbxBmQuH4y4AQms58B24+agqX6/FnFTet/XtRI9upSMMCiOKXHK65+9s21geVU
	1NFQQnwgIoUIbcAA==
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
Subject: Re: [PATCH iwl-next v6 1/6] igb: Always call
 igb_xdp_ring_update_tail() under Tx lock
In-Reply-To: <ZsNDdPTHu2OACpPq@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-1-4bfb68773b18@linutronix.de>
 <ZsNDdPTHu2OACpPq@boxer>
Date: Mon, 19 Aug 2024 16:21:47 +0200
Message-ID: <87o75o8uf8.fsf@kurt.kurt.home>
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
> On Fri, Aug 16, 2024 at 11:24:00AM +0200, Kurt Kanzenbach wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Always call igb_xdp_ring_update_tail() under __netif_tx_lock(), add a
>> comment to indicate that. This is needed to share the same TX ring betwe=
en
>> XDP, XSK and slow paths.
>
> Sorry for being a-hole here but I think this should go to -net as a fix...
> I should have brought it up earlier, current igb XDP support is racy on
> tail updates which you're fixing here.
>
> Do you agree...or not?:)

Yeah, makes sense. I'll add a Fixes tag and send it to iwl-net.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbDVPsTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgio+EACxHf2TIRo4Ebw4aCqR7PmkA/iqNbX5
18s/iS/jVy7DJcqWb3y20H34MErTMlBuFU7uv2dXqDzYetd78zIbSQ0zeMQJiM8R
X1haJVFaZJkiJiQcIJ9cQ4IJDalOr0D2Zxl3wKR/PSjlUJGCgFS5xPfLkJxShFGK
Yxw7dR2CrzJFvWXMzEKxnrWJi57aoELGDVtlSd6oDZZTdgH8VOMspd2cuaG0ndw7
tYnw6VFRWfWx/RUwmM+zt43zqMMBYciCK2f/uIm0RPFgdjyXt3cHQn4wU3Asqlm1
7d8qH18FONfZyTmizEAIV9cP5rGnzBsD0R1/GZY6EpJhu4lHEyfnQbx6YLdr8MVI
PaL58hRCxoZNqwVrM+faYByBLsizp+8Ptg1rxk390RPwdq+yw6lgrbpdhS9GIP5E
2A49OeFJ8yIFANTz3HNOVLLgvek6L+K35dwuCulfJjZXq4/7INVOzC1j2sHT2EX7
Onhmj5Rwjs57jO3qDxLS6E17rYziuCfa/h2eKJjHrQ3Vrad3PZam2AqaUTGRxoj3
mYEk5tthd+U6swuSD/3Rj5LMjSxy7EpYwW6Z9UVhzMXnRMMLJg3FLJncSlWjHWpk
vjV4pGSUZhAXLmzrE+qxitrHamGR95S+jj2ahw4c5t5hzFZZ9izK+GHSIYjmT15V
VKh/fFQ1ZvMqBA==
=Ba03
-----END PGP SIGNATURE-----
--=-=-=--

