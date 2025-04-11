Return-Path: <bpf+bounces-55773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B0A864F1
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 19:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987A94C2831
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B16241105;
	Fri, 11 Apr 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8c2fw+t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1421E0DD9;
	Fri, 11 Apr 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393153; cv=none; b=p5qXRrqymSBz0HXYXsAYL90YweFXFQNu9DFtIJHjHbcVOWzfROOsWfpL3mYugemJ47pbg4lfAsgmGuuEXJslmUgAq62m9+AdONWBnK/UjpZN/ZV5X0/v4Wkd/Mwo3G3P2fuLwu3QHA31EqGMtn+BOIJ/Ufwc+d1gZXpD5zHnGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393153; c=relaxed/simple;
	bh=vg7IgRdOXXWxOmnksER+VmkPMSbOnygUaoZ9aleekhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg4CUA15VE7wUKXvI0oL9X4MPJDec7Lh4cBWCVZr/1XbaVnDfx1YtQIVU1m33H2qsOEjE9h70qNDu7Jqh5XQGV2YGWDjlrlY+4xxzwLMdexaBN59CZtv38XltXfvTTBkJzYhW9v81qoZHUYPWZZhXgZjvyBr64aOvoeJOFvn5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8c2fw+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63969C4CEE8;
	Fri, 11 Apr 2025 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744393152;
	bh=vg7IgRdOXXWxOmnksER+VmkPMSbOnygUaoZ9aleekhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8c2fw+tbUYho9vwZ94zgfU7ymDA6d4XO6Kmf/hN0I8ficbS30Zd30msb0jRfCBo+
	 F/xsFj8uQ4y6REEG4bbvZqrwc66MeYB2yhGWcksD8vQB7wG2dA3VIIeZ+jIN8vi6Hl
	 GKGQk/L37pr1INnguElzoX1Dp2UwljT0tV/4cozogHHNPwv6JrVaIjPnKQASNnJHii
	 eGe0amunxDyNpRuKAKfDRe+DwHFrPmNDuB17s8Mamos03aaFpL2w37rdJIb3zOGlkO
	 hHYt9APFDHvyriG0G9PEKdi7ckjYjnsH7cV57s53bDeRTMNvZ1efsMsRlOnOiEj3En
	 JH/qNHbGrWgKg==
Date: Fri, 11 Apr 2025 18:39:05 +0100
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
Message-ID: <350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
 <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
 <20250410131745.04c126eb@gandalf.local.home>
 <c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
 <20250411124552.36564a07@gandalf.local.home>
 <2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
 <20250411131254.3e6155ea@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4yZ4AuyN960k5am"
Content-Disposition: inline
In-Reply-To: <20250411131254.3e6155ea@gandalf.local.home>
X-Cookie: You will be awarded some great honor.


--l4yZ4AuyN960k5am
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 01:12:54PM -0400, Steven Rostedt wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > That'll take a bit more arranging, I'm running these tests as batch jobs
> > in CI infrastructure.  I'll try to have a look.  The only other test
> > that actually failed was:

> > # not ok 25 Checking dynamic events limitations

> > which isn't flagged as a regression (there's some other UNRESOLVED ones).

> Hmm, don't know about that one.

The tail end of the log there is:

# # + TEST_STRING=p vfs_read 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
# # + TEST_STRING=p vfs_read 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128
# # + echo p vfs_read 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128
# # ./ftracetest: 16: echo: echo: I/O error

which smells a bit of a shell incompatibility issue.  I'll try to find
time to have a look.

--l4yZ4AuyN960k5am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5U7gACgkQJNaLcl1U
h9BV9QgAggpMP7vcZOw7vW/v1btFz0u8noa4OBFLsRVXcQcS2QsVRvEfN00apOCN
mkU1zyqJPWCj1BKSVGiNCoPN4qXyuVlFf4E7zFjviTJt3BwG26CgRMFBRPXRYz4t
AWZZIdkk3j38oodkVGxDWEZ1KN5SMelkotU0EENmtbBm7U3sa0Hp/gOWPNShuNcI
i3QwGf5dm9g/fyF5b8va6zSicI2kYsMmg5TzKc3cenuoUuTfFO5UBdT3IOMO+5F+
jsXirVCEjMcK3LZOx3g/fbHq8wN4bhO1rRD/9a5Fj5u2UlDTssWO/eXKGFGc0fDY
wUJ1GopQvxwp88O8IsvQJaiJi6aOeA==
=PcLN
-----END PGP SIGNATURE-----

--l4yZ4AuyN960k5am--

