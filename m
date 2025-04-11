Return-Path: <bpf+bounces-55779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D3A86585
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01C1442972
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABBF25D1E0;
	Fri, 11 Apr 2025 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtaGs9lI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C32367DC;
	Fri, 11 Apr 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396180; cv=none; b=IuyUuA9JNh0AaqhIE+NqXyRJHRjnxDyAtmBFZmdbRS8LdAn5/I0UR5OkZHeX92FyUNmmAcqhLcpcoNhvRk2zzy3UR9PjWcd8DcgNzD6Cr04WijGFnoCe+IogpaxDsN0w4yYUicdtR666mil1j4HeeRKJhpI97pmNOgXB/xYGObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396180; c=relaxed/simple;
	bh=u2G2avLNzeJZIWuSk3EYSAjDjFZH5u/1BD15kdtjQQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL3gh41jo+1qn2AYb2WPBc8fraLwyZpgmxA76LItE3iYdBO3CVcuEcMNo4bXuHxYkNY07cDKrJ9aMieQ38jrKG369zqfWoQ4sFUV9f08gOm8nj900FZ/eE5EZkuysMZJu3m2nVs4r5Be1nSV8FiuQYnh+bwkOsQ5mQ7gILZ0SbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtaGs9lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8CBC4CEE2;
	Fri, 11 Apr 2025 18:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744396180;
	bh=u2G2avLNzeJZIWuSk3EYSAjDjFZH5u/1BD15kdtjQQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtaGs9lIoHjXpi6ccBKGqovtaDk2y7dhiKpm+X/zlpYXEaAtxtRCmqodAc7w9sBva
	 VSG6OKjYlCcv0L1lvJcnhgMlaGBeYG17ELO5AOgjciphVVp7KENusO6x0Xvet63mEU
	 4P1lTqMX+FRRDKzXxI5M5KlfjRRXxJQo18H5ybOdXREGs9Pr1csv9ePepY/YMLQqZL
	 RlpD3Q4ulsZkO+6Ncgk++ARkkHZQZLBWhwsMgdPoMpRI27Qlp00bJRm12N6S0o7Ld2
	 2sP7hfOQ7joPgry+5FYHvGuuAdX1CZWd1Vkfdi2NLJ2zfKGJ023lzrn7aLD0X3pCMo
	 oSReWJTH0YwXQ==
Date: Fri, 11 Apr 2025 19:29:34 +0100
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
Message-ID: <714c7710-0a09-456d-98af-7ad054e610f4@sirena.org.uk>
References: <20250227185822.810321199@goodmis.org>
 <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
 <20250410131745.04c126eb@gandalf.local.home>
 <c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
 <20250411124552.36564a07@gandalf.local.home>
 <2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
 <20250411131254.3e6155ea@gandalf.local.home>
 <350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
 <9dafc156-1272-4039-a9c0-3448a1bd6d1f@sirena.org.uk>
 <20250411142427.3abfb3c3@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u6fO85aT4x8pct6g"
Content-Disposition: inline
In-Reply-To: <20250411142427.3abfb3c3@gandalf.local.home>
X-Cookie: You will be awarded some great honor.


--u6fO85aT4x8pct6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 02:24:27PM -0400, Steven Rostedt wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Yeah, if I bodge ftracetest to be a bash script then the test runs fine
> > so it'll be a bashism.  We're running the tests in a Debian rootfs so
> > /bin/sh will be dash.

> Interesting, as one of the ftracetests checks for bashisms:

>   test.d/selftest/bashisms.tc

> Did it not catch something?

# not ok 90 Meta-selftest: Checkbashisms # UNRESOLVED

Which will be because checkbashishms is not installed.

--u6fO85aT4x8pct6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5X40ACgkQJNaLcl1U
h9BmIAf+ODoY7TzuFhRRTzmjkPd+DbEYSXAnImqyi79A7/afX9vx1S5fm8Hh1Cg9
s1RY93bWd2PvCyIm1qVw9dZHgVE5gTYmswlSpkgdp+u7C0BKXHVBD0vtC00heOva
XnKUSX+H3KA0/q90CU0BEYRiOBq587tu7ZnOKKSaFnYUafk7Nng1iHJikHvpQUW4
qbTNB3zPHSxX57/E2bIk03UlFKQXJm5vvxXvobpyYi5a+XAubXGPT43NvSd6kDe7
HBcaVO2cKP+TGIip81JouI2HH3CAAk2QjvK8pgxJ1czeTgoJ+KC4CRedC98lHVsJ
0KAmjwCL9xv4e2DBC5DR4xwvgJ7C/g==
=snXU
-----END PGP SIGNATURE-----

--u6fO85aT4x8pct6g--

