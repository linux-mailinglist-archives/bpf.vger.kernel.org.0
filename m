Return-Path: <bpf+bounces-55776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C078A8654E
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D9E9A3B58
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E07258CE7;
	Fri, 11 Apr 2025 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzFy/D3j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F3021C183;
	Fri, 11 Apr 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395396; cv=none; b=hsOJ2SW7qVC6AJ3nTHf49BqzBvSBtSMNTLqLxsyMvX8oiI1ZkTK82LBLDXPH4mZrskhQZLguVgln1CLdRjnt2G/AxIeJ8kRMXmnEXf5+beAR9nu/No24M0J4+MX7rbqj3TlalMwOMLPrcORqMNOeqzjbs5S3lOCVThielrjflJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395396; c=relaxed/simple;
	bh=97CJDVIv7elwt7wEHhch9Ec7mXBTWpOIxu0q047UETo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llkP38Zx4q8HqGDIK8DsClfHH1+beyMZOODSVUXw5aDnHwNpRFemxEZYCPax4w6GUaKtS/HVhvSHEIB1KLQdh8jklGjC7/IpphR0Ii7kGEnut++tLZc7yRxNr2oCLNQ0YBmIhB/g2wEz3Oc3PJ3gt02tnMNNpG5yiBDwfl7cJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzFy/D3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B572DC4CEE2;
	Fri, 11 Apr 2025 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744395395;
	bh=97CJDVIv7elwt7wEHhch9Ec7mXBTWpOIxu0q047UETo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzFy/D3jJz8D/x+BYXWwdG+hwtew9TM0sLH2wlScG3ajcVa2LPSH2EO3bgR3nRx32
	 A2ARw69HTyd/7Xg/IbELGdCnQ5Utc2h5X+i0TJlZfUaWMsTS0vzmQ3ETs+wiRt4K8/
	 e6vCVD/jFj85FR9JI09af/AgViYKUkqMLL3Pu2sb2tJMOaYqU21q3gZOuW3+/FEZza
	 sN2pmBfjMYpaOC6Il3cAli37GN2z2yWNixhsDdYe8lF+Qxh9hg65Py4rYOchnPVbKh
	 vZ62g9Iod+Wpuf1ShwFhm9v3QPUTjf1MtrpC9HvwiKIdBFTHDDXX1r4JEKEzWgUlcb
	 Joh14hlVnwB+Q==
Date: Fri, 11 Apr 2025 19:16:29 +0100
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
Message-ID: <9dafc156-1272-4039-a9c0-3448a1bd6d1f@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
 <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
 <20250410131745.04c126eb@gandalf.local.home>
 <c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
 <20250411124552.36564a07@gandalf.local.home>
 <2edc0ba8-2f45-40dc-86d9-5ab7cea8938c@sirena.org.uk>
 <20250411131254.3e6155ea@gandalf.local.home>
 <350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H170P4jA6J8FG5IG"
Content-Disposition: inline
In-Reply-To: <350786cc-9e40-4396-ab95-4f10d69122fb@sirena.org.uk>
X-Cookie: You will be awarded some great honor.


--H170P4jA6J8FG5IG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 06:39:12PM +0100, Mark Brown wrote:
> On Fri, Apr 11, 2025 at 01:12:54PM -0400, Steven Rostedt wrote:
> > Mark Brown <broonie@kernel.org> wrote:

> > > # not ok 25 Checking dynamic events limitations

> > > which isn't flagged as a regression (there's some other UNRESOLVED ones).

> > Hmm, don't know about that one.

...

> which smells a bit of a shell incompatibility issue.  I'll try to find
> time to have a look.

Yeah, if I bodge ftracetest to be a bash script then the test runs fine
so it'll be a bashism.  We're running the tests in a Debian rootfs so
/bin/sh will be dash.

--H170P4jA6J8FG5IG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5XH0ACgkQJNaLcl1U
h9CGeAf+O3vXSWVrkdpLMZpe5T6g5JzYEJlokIjsViSRQ9L4iIXwohqixf3XJG3Z
sZ7KsbpSJPHbxTflLGpPnC3MwFp4ZtG7d9w0eegCro9WGMlfpcL3Wo2rSPttA882
OC8KNhDN7frA+FylfBe/8yh89eLjTB3dGO1WEw22yGuJL0Dwn4+U8wJMRbIU5Fs/
hD54R+DypzraIPB96AzhrRsav2jI32ZLRFCTnwg7hhoWd1wHwircs19AxeBzD/9C
VBW/W6b+Hhi7q99WWG2niI5nHi27oL/qFXxshS4Oj5SRd5Bvt6VSzUWYFq+PTI23
vgXHCo9RyMHICrubMCsBq09yXjf9dw==
=E6ir
-----END PGP SIGNATURE-----

--H170P4jA6J8FG5IG--

