Return-Path: <bpf+bounces-34043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3D929C80
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F36F1F21C3E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A01179AD;
	Mon,  8 Jul 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4iCZRxAA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R10/S8Mj"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CF1CD15;
	Mon,  8 Jul 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421491; cv=none; b=AqgPg1NAVNNKdJL71/JsZ30Ob0QfLoZaudbL6F3I05/kALrLP2qpFskTURUyGwk6+vmGM7KJBXDL0musIiPZ/d4EwAVEGJTJK9cmv3+qr8BulKjEZf8oQO3UGSnyJ0JF7f/6VpkpKhrB6i3Seomf3L7FFRkGimyP2tgiaR8ZgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421491; c=relaxed/simple;
	bh=YDWJ71ySH9PSDUOkMbL//TQGDlBWMRYEpclPL1HQ34s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEopVlq7EtpUs70t5sFxTASfCqsNkYnJzH38FBClElWtJKjLsIZ1ehhnjzcdNq2UiwDhFcQYBKAoVQAP9BMjJLVXtp1j0W1GBPid0QK2rmaXlrBZYAdbvNwiPIyGEnLvutErWCc04Zn2YMpZvTTXAkjzv922x1HCxpg8GuiRBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4iCZRxAA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R10/S8Mj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720421487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSogFxSiEFX+iVqpDcSRPS2yy5AUBU3Y928D6RpPBbc=;
	b=4iCZRxAAF+qNUv9U7b1oMhzCKgMFDfCUQyedzfVF4Q5hjuATLxXZ5D3o+wqniRRDHXT7PZ
	GLsOUPU3JG9oyiDWhEioJaQj5xR4YvxbLLPTi4zjPe6Jql6OkbToVIxOwxddxF/tvGGLeu
	hvXyl7vqIdmxARbwx2GZxsoid3PVTvmIRIu/pBOJ0u/AvKD0HfLCrnVR+h413xNrOBP4Nt
	9cFM6XzM5XtD2LwIenMgilIrGpRyo+tb4LZ6I5M+C2gkzPXkOePaKzUu3Z2+8nm1wqOqAQ
	3SoJ5RnZd71lSKHAVR44pF6bG9pBhRk8WH1uFsbnn3Kb+qgY1r8di7DNBImbVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720421487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSogFxSiEFX+iVqpDcSRPS2yy5AUBU3Y928D6RpPBbc=;
	b=R10/S8Mjx724FBJfCRLDH1si8XrMNAHAVza2jMd/O5K47FqJ/io+H9lSK5ohaELgjabaof
	7eTHpfq+5GZg4nDQ==
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Benjamin Steinke
 <benjamin.steinke@woks-audio.com>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>
Cc: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei
 Starovoitov <ast@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub
 Kicinski <kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 0/4] igb: Add support for
 AF_XDP zero-copy
In-Reply-To: <AS4PR07MB8412F92231A7C6E9FFAF13ED90DF2@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20230804084051.14194-1-sriram.yagnaraman@est.tech>
 <878qyq9838.fsf@kurt.kurt.home> <3253130.2gtjKKCVsX@desktop>
 <87cyo2fgnm.fsf@kurt.kurt.home>
 <AS4PR07MB8412F92231A7C6E9FFAF13ED90DF2@AS4PR07MB8412.eurprd07.prod.outlook.com>
Date: Mon, 08 Jul 2024 08:51:25 +0200
Message-ID: <87bk38fkb6.fsf@kurt.kurt.home>
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

On Fri Jul 05 2024, Sriram Yagnaraman wrote:
>> >> It seems like it hasn't been merged yet. Do you have any plans for
>> >> continuing to work on this?
>> >
>> > I can offer to do testing and debugging on real hardware if this helps.
>>=20
>> Great. Thanks!
>
> I have since changed my position at my company, and my new position
> doesn't allow me to contribute upstream to kernel unfortunately.  It
> would be great if one of you can take over this and get it delivered
> if possible.

Ok, I'll take it over.

>
> Glad that others find this patch useful as well.=20

Yeah, it's very useful :).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmaLjG0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgg8DD/4m6dxBxOZ97vfUSPDyC/ylGZpAyhHp
JXYgiBiEvhNInWbXTq7m+uDTRH1CPqHF3skmi63KnBtyWpte9jLu4XkOuqABdIpw
9Laq2qJKbG1iqy2pvsyJg9Vc41uaatOSvE72Dr1+6EqfOGltQiZ+Pohxgi9GTvoi
tJCs0onHuzM5OrO9tBO6HZOGnAKFYYDJYL7Cv6DVTvEyetumN56JFwCbScjBJwWm
RGA57geCepp6i3dFf8B4ex2AROZ6lO+4I2ZTTKADZd7uqNrOR6J4Ny3U+uHHvnTm
3TXIK0SzT0iJ/RAHgshm4oXpfHFwyYzNMxxmgcfj9Z6YLUNULEtq6lvVNi2CkVab
wEiaWLstW72KCaDewPFzRW1sZI6plpTPIZ+wrY6HXhXFOBnV0N3a7J9IEy6SZDYz
+oXlmfF5hCcEff6x9fAk6yppuHoMGasXAG6bWi5rUiBPsDVKrbghq6n95jENsBsv
PHUN/YnfxnRU7kAnB0SwGq5/eUzpX05Dia832XaBI5wiAsgYNsS8+jPYF3CP69YK
jEnPT3vUqrbjQzAFVCGX6Dg4yc+HV/+LriAjBQ2+rxkF2TkARS6rJ3jABX3MahYh
ejrpXrgjPO0KVSNGuoMoeXb1nLpKBOEUaPgoc+kEmLOBH68aZ8/+ate/pKRR/uTh
3v9hSKjFtK8KZg==
=upaM
-----END PGP SIGNATURE-----
--=-=-=--

