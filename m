Return-Path: <bpf+bounces-560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D870399B
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 19:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85D7280F1C
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78176FC1B;
	Mon, 15 May 2023 17:44:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35622FBF6
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E2FC433EF;
	Mon, 15 May 2023 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684172640;
	bh=InLf1Tw5b2pCZIBk6BFn6OWKVf3tBsDAE0r1X+/jVuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KU27NtmcyFyg666SNMSpu3ZNzj9Ud6cj2E3hEkDRUkAagU0oF6YGS/JSW2ryK3kph
	 1t+KR+O1oDzm7qXJSsoNaidnk+qQky0Rl8MYlIpYJmLAQeU5S+h23xYnxX6N26nByz
	 Z5c2EBTqSPLF/43UcRxAvj7fBUYkjkskDi4X0j9VK7ymWdQU8EHxEUPbyOTKIFWZM1
	 r4LyEN0XWK9L9OVf0fCUXeQukS8mWp446PAZBP86ntArriSp2cA7knFeMsM96uue0p
	 VLzztvU4eWsNwISvij2mh2BdYTxq4HJDgjtSSYxTPY6GdCqMyVqRyHO0ASHpg0P2Al
	 pao8fxw8NaNfw==
Date: Mon, 15 May 2023 18:43:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Ze Gao <zegao2021@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ze Gao <zegao@tencent.com>,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] Make fpobe + rethook immune to recursion
Message-ID: <20230515-dominion-botch-e0b9291bcea3@spud>
References: <20230515031314.7836-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dqLazd8WcdDsY/XF"
Content-Disposition: inline
In-Reply-To: <20230515031314.7836-1-zegao@tencent.com>


--dqLazd8WcdDsY/XF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 11:13:09AM +0800, Ze Gao wrote:
> Current fprobe and rethook has some pitfalls and may introduce kernel sta=
ck recusion, especially in
> massive tracing scenario.
>=20
> For example, if (DEBUG_PREEMPT | TRACE_PREEMPT_TOGGLE) , preempt_count_{a=
dd, sub} can be traced via
> ftrace, if we happens to use fprobe + rethook based on ftrace to hook on =
those functions,=20
> recursion is introduced in functions like rethook_trampoline_handler and =
leads to kernel crash
> because of stack overflow.

This patch series is a bit confusing. The RISC-V list got 2 cover letters
and 2 patch 4s, but not any of the rest of the series. Please at least
send the whole series to the list so our patchwork automation can be run
against it. And mark it as v2 while you are at it.

Thanks,
Conor.

--dqLazd8WcdDsY/XF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGJvWwAKCRB4tDGHoIJi
0j9VAQCg19aD+YHZwreeVgv/iHphWBuLDk8i96FhqjjGX2NOiwEA6/jsuqh1ILFe
CqUFzOZWPPeZCLFUHSr939+zcR5isgs=
=bf8c
-----END PGP SIGNATURE-----

--dqLazd8WcdDsY/XF--

