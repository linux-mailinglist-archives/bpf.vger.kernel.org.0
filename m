Return-Path: <bpf+bounces-37507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B268E956C71
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 15:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D23B2479F
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438C16CD13;
	Mon, 19 Aug 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2XorCVz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNJUkd5B"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D316CD15;
	Mon, 19 Aug 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075372; cv=none; b=YHdWIU9g7wTfbrd/vuYl+ESiuQpZHHDYS9BHzU0lgMFT+7rm0uNuBK12jMLE9JzEts2FOXx5O/BxCUgnleJEkHmZXPXSQXQE+hfjLKNBId4q28Q2wMkCj3tifFor32vlnFczObwWBrNFp6cuNQ2wCGpw8TsQskR2Wekuc6R4G3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075372; c=relaxed/simple;
	bh=pUQ16/btL6LsJgdEorngz/acoyyiJzWSh+XrIvmYTy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qq0iVWiTh/wGuAfHGxsGo7dDLU4ORBZodcQfJqiz2/syFr8TLpIqTAUdf5CjzdILKJdSbKAwXQyH+XY1sKjQFvGEQawReZj3GFGyaNEH32AF3OoqUQsTpRSzo/kdUtKYsj382lXEzSDWi4Un8OOrOpCYwbUnKjBBI/lkQO31t/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2XorCVz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNJUkd5B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724074882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUQ16/btL6LsJgdEorngz/acoyyiJzWSh+XrIvmYTy8=;
	b=m2XorCVzHsJPQV1Kc6zSBLjJ53sMA5fko1vIF2CyOwIMT+fVEhwvCcvOR7b5tjYnv6X4rv
	F74+9HOGIHBQKmmjgDBhI9rlmcdlhyKEbSUcwyuWwYkmMIP45/YZ5QRMD9wZl3tGeeagw7
	QxwJ0f5yr7byGtikAHIoOehZifQTNkw+tRkmaHW6sqxs3cL/8Br+8VO9/4Y85KVwsJAcHQ
	AFQ2r+upd8X6qDOSIza67nuG5GNB3oYpnm+0G41CMEenAsP6hLtAoeANPojQQWTo00NIqr
	JdxwJLzTed8ZWYqJEzJAagewK1guQLnieBuYBGeNkgG5A47W2dS8X92VyB+ivg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724074882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUQ16/btL6LsJgdEorngz/acoyyiJzWSh+XrIvmYTy8=;
	b=jNJUkd5BRM0hucGXYCtGhedWJYGlPnaFtdVEVO8eskSF+8x+N0jNz1u0v0F92RVfq1/jTN
	mwyu2oGWqaDC7iCw==
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo
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
In-Reply-To: <ZsNGf66OjbqQSTid@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
 <20240711-b4-igb_zero_copy-v6-4-4bfb68773b18@linutronix.de>
 <ZsNGf66OjbqQSTid@boxer>
Date: Mon, 19 Aug 2024 15:41:20 +0200
Message-ID: <87r0ak8wan.fsf@kurt.kurt.home>
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
> On Fri, Aug 16, 2024 at 11:24:03AM +0200, Kurt Kanzenbach wrote:
>> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>>=20
>> Add the following ring flag:
>> - IGB_RING_FLAG_TX_DISABLED (when xsk pool is being setup)
>>=20
>> Add a xdp_buff array for use with XSK receive batch API, and a pointer
>> to xsk_pool in igb_adapter.
>>=20
>> Add enable/disable functions for TX and RX rings.
>> Add enable/disable functions for XSK pool.
>> Add xsk wakeup function.
>>=20
>> None of the above functionality will be active until
>> NETDEV_XDP_ACT_XSK_ZEROCOPY is advertised in netdev->xdp_features.
>>=20
>> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
>
> Sriram's mail bounces unfortunately, is it possible to grab his current
> address?

His current email address is in the Cc list. However, i wasn't sure if
it's okay to update the From and SoB of these patches?

>
> You could also update the copyright date in igb_xsk.c.

Ditto for the copyright. It probably has to be something like
Copyright(c) 2023 Ericsson?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmbDS4ATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtwLD/wMYoKgJ1Pa0gm0Q9aimGe57wpD4Sbj
AZrRXoMdsGzmtxopJ3+E5Mm7Unktmm2917I6EAK/c8mkvRZpEfztA4mZBs2RyB5J
dZf65q7R+NqrPYuKuwbzAlzsVOW7NKmfmvpgrZUZwuYfVkOvjfhaktX2wqo2uiVR
nEMWZeNJ8YY2qkkfJYYXo9Fj4r9RloKXRM6W2gdUm5hVtMgBzCkztXP25LwxJ4+k
7xG+DaafDuh7aZnHT9D+pacurZnHVnEIvEnRw5GZdqoh7FQVzWRODSBTRnN17Tru
8sEdw7ixTHSOLKcguU/LlZl6uGXKeDYwub/cLEZEPEoxDZ3EXeuVKD6drrZ7yD0R
5oZ5YgFSuJwXNYwvv6s7qJbkC3hg9AUSFGn1spuM8TCGrY3FpJbvmq5olgJO7hus
mlrhxybXySGN0OVnHjJgCjAVkSs19btO1fgA/5tfHYu9ElGCTCvxvy5RkU5vyvqj
sguYTT31Hw8JcsHXTm5C3iRO4/ioIZpk9SCSdLWg6vK0kW2PaHK07kmUn4Utu1yD
m4BdJ0rqaAh893VyIgnLuT1bDen2z/W1xCsc/mJXHGs6OiPr0V/CyuK169V+/lyN
YX65UAYwFx3brkoogTwezeOg9yGOYWPdo17eeRgMlglC5RVDW6pXw7yXw+yStNAA
KY41tZQEKrfLxg==
=wTs0
-----END PGP SIGNATURE-----
--=-=-=--

