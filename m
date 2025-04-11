Return-Path: <bpf+bounces-55733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2DAA85E1C
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32039A2810
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED82AEFB;
	Fri, 11 Apr 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmwbmXQy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0CF507;
	Fri, 11 Apr 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376447; cv=none; b=cXQkLMShj5JxU3vqZX0U1aMS7kLlQ9R2M7bPiVEmwKmtAxcB4G1D5gOK8GyyTagd9wEGmc4h1BFLF3MC7XHK8/78XQno0cfwpYBTsOJQhsb1OKseYrW19IXrKE1wJEQMyMXMmBzejiGgWuefj44VaE/JjX1fG3WLTUmxnhDkdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376447; c=relaxed/simple;
	bh=/ZEKz6Ap10nF4f/52Rp4RQNHrF7H+B+QSIeJAgxNiXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU/suN8w/58mdsqiboYH25SFD6BrnAOeWJR1/HG3F1eydIed6r3elZYnm5mZskE2ZN2bvlsizv9Cz2tx0DGRPp4HcbtUmJqZ45FjDROMiNAkyfhkFQ7Q90mD3xtVFbCZZ/L5rfD5albd3506zZz5+g74v2M8vMYYj432tVwnYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmwbmXQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CC0C4CEE2;
	Fri, 11 Apr 2025 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744376446;
	bh=/ZEKz6Ap10nF4f/52Rp4RQNHrF7H+B+QSIeJAgxNiXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmwbmXQyQmaNzgHM5UW7kxWwECHpgQNEF9au0fBDX2ruta6x6AKJpWdC+P6LfgpIh
	 1bNUvoPs0UxNdO46JXtL2n64TlINA5Gbw9Af3w2n1KLRSFkVrs+Nzujgtbzk22gH/r
	 EnxfCEFmaVPXNVbcXIA7sA+ZrvTmNadeVUu8ds9LZVUkrLzrxB0SXrQ78jdB8QHt0i
	 9TyOkFWoW4LJgBWvZWys5BRGMiaUjnNPrf0tT/pLdb8DBtDyCuZXdJnJuamIaRrNcj
	 Bj3Jrte8HMRNGYSv2vpJv9DY5WTSV4fwp8zv6AqvLNMAn1QpKg/bLo2dyu7aZrvQIH
	 BNDTq5hDMgWeA==
Date: Fri, 11 Apr 2025 14:00:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Zheng Yejian <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
 <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
 <20250410131745.04c126eb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4387NN2++IjFTy4"
Content-Disposition: inline
In-Reply-To: <20250410131745.04c126eb@gandalf.local.home>
X-Cookie: You will be awarded some great honor.


--t4387NN2++IjFTy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 01:17:45PM -0400, Steven Rostedt wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > We've been seeing the PID filters selftest failing for a while on
> > several arm64 systems, a bisect I managed to run without running into
> > any confounding issues pointed to this patch which is in mainline as
> > ff5c9c576e75.  It's in the ftrace code, but I'm not immediately seeing
> > the relevance.  Output from a failing run:

> Hmm, I wonder if there's junk being added into the trace.

> Can you add this patch, and show me the output when it fails again?

# # + cat trace
# # # tracer: function_graph
# # #
# # # CPU  TASK/PID         DURATION                  FUNCTION CALLS
# # # |     |    |           |   |                     |   |   |   |
# # 0)  ftracet-5190  | ! 537.633 us  |  kernel_clone(); /* ret=3D0x1470 */
# #=20
# # 0)  ftracet-5190  | ! 508.253 us  |  kernel_clone(); /* ret=3D0x1471 */
# #=20
# # 0)  ftracet-5190  | ! 215.716 us  |  kernel_clone(); /* ret=3D0x1476 */
# #=20
# # 0)  ftracet-5190  | ! 493.890 us  |  kernel_clone(); /* ret=3D0x147b */
# #=20
# # + fail PID filtering not working?

=2E..

# # + cat trace
# # # tracer: function_graph
# # #
# # # CPU  TASK/PID         DURATION                  FUNCTION CALLS
# # # |     |    |           |   |                     |   |   |   |
# # 0) ftracet-12279  | ! 598.118 us  |  kernel_clone(); /* ret=3D0x301f */
# #=20
# # 0) ftracet-12279  | ! 492.539 us  |  kernel_clone(); /* ret=3D0x3020 */
# #=20
# # 0) ftracet-12279  | ! 231.104 us  |  kernel_clone(); /* ret=3D0x3025 */
# #=20
# # 0) ftracet-12279  | ! 555.566 us  |  kernel_clone(); /* ret=3D0x302a */
# #=20
# # + fail PID filtering not working?

--t4387NN2++IjFTy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5EncACgkQJNaLcl1U
h9CrlAf/TNqY5kicOOZuvNtiEkPQN69ZobTjonV0uaJ4qa9bDB0xT8KeagqVfOvr
TKVIVNv3IN4fmq0lilq968zb7FFvUwlGaQwsxAzoJ89Vi9uHaKb7r9epBkjUekIn
2S0SyYKYahi5xgTMASJoaBH4Q2/NyVaihAepttjRab7U+J7GdUwGnYlGkOL9I467
fvRl1SAMMuL/D5z4E2fPDNKcK8XpCRirxgBx9IeFn+A6hMuyEspwnRGFDiByNj1a
t7+8liq5SUDObVOVFzvUsWeLwmaO36G1aAW5BVvPuUDnJpY++ekqiMMWy54P+mN8
S3LkIGFWwLUzuaCo0MVFuPSa8h5J+w==
=uNd9
-----END PGP SIGNATURE-----

--t4387NN2++IjFTy4--

