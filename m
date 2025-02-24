Return-Path: <bpf+bounces-52421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05C7A42D5A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F3C3AC3A2
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C02207A3A;
	Mon, 24 Feb 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5PSnbYP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4F1A5BA1;
	Mon, 24 Feb 2025 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427596; cv=none; b=BmAzkFSq9akBxZUzsqFUxr81ajoi5PpJ6ULLAq8OJ7irqFdmIEXEVnSxT72k8ku2jptJxzfygMEL9hQFnyvMRGnMNKLFJ4rfMSkpLpfR7M7HIKPpDaxpt69WxBGchLjtsbLoR4LBOxyIo037OlRN7+ks8wIHY6a3z7W2aK22n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427596; c=relaxed/simple;
	bh=MQRG0wCElGkAgnXGUfFa/phfVU4AAiqsQ2KYJcjrJs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnfO3+wUHOoghFfBabr/K1aBTXc8eHCdJ/ysEzFlTpN3y5XhW6PiIyFYssMrj+Ap8fvF6Z5sFs9sUETNhDWYfg9fweARCxlGvCbj3VEx0ygJsJIct9n/uu/bqSHdCChRXQ00U9UhFwG6k8fuGctfZmJJw8tFrfwZCgUaGx+Cveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5PSnbYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92A4C4CED6;
	Mon, 24 Feb 2025 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427595;
	bh=MQRG0wCElGkAgnXGUfFa/phfVU4AAiqsQ2KYJcjrJs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5PSnbYP4YgwsftEmZ8YZ825gzDSojyh/8X2Q6bWNmKvJU/Gs+oWMwashqIOOBqgk
	 UX18EdBSEGTcVGe6M95Pc/nRJ+Ne9x95agmGRhCS0+A4oDBluqiYzjRVfVrw7ptYrt
	 ihkDswwM1AGmZQw5+5d8TTbmsZopkjNKjOX7avQocLHqWQOiSxsD4R1h5MeNxVEmwL
	 JsunjM8s8RUSDEUUIKJiAxnBeCcbLFgx0wO7HGi51S9UqgTzmWKMT4csXhinjLDaIo
	 Lhkg2kKDJi8B3cv2pHQrKJV213a8MFaqNkvy8kt4KWNiuTZOkEldGxNH5oICFMA9lR
	 Tyv9VTeskbPxg==
Date: Mon, 24 Feb 2025 20:06:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 4/6] scripts/sorttable: Zero out weak functions in
 mcount_loc table
Message-ID: <5225b07b-a9b2-4558-9d5f-aa60b19f6317@sirena.org.uk>
References: <20250218195918.255228630@goodmis.org>
 <20250218200022.883095980@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y1RTCqJAl8VZ6A/p"
Content-Disposition: inline
In-Reply-To: <20250218200022.883095980@goodmis.org>
X-Cookie: Do not flush.


--y1RTCqJAl8VZ6A/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 02:59:22PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When a function is annotated as "weak" and is overridden, the code is not
> removed. If it is traced, the fentry/mcount location in the weak function
> will be referenced by the "__mcount_loc" section. This will then be added
> to the available_filter_functions list. Since only the address of the
> functions are listed, to find the name to show, a search of kallsyms is
> used.

This breaks builds with ftrace on architectures without KASLR, one
affected configuration is bcm2835_defconfig:

/home/broonie/git/bisect/kernel/trace/ftrace.c: In function 'ftrace_process=
_locs':
/home/broonie/git/bisect/kernel/trace/ftrace.c:7057:24: error: implicit dec=
laration of function 'kaslr_offset' [-Werror=3Dimplicit-function-declaratio=
n]
 7057 |         kaslr =3D !mod ? kaslr_offset() : 0;
      |                        ^~~~~~~~~~~~

since that happens to enable CONFIG_FUNCTION_TRACER but doesn't have
KASLR, we don't have stubs for KASLR on architectures that don't have
it.  It also looks like from a quick glance at least RISC-V will fail to
link since it only provides kaslr_offset() with RANDOMIZE_BASE enabled.
This all feels a bit footgunish.

--y1RTCqJAl8VZ6A/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme80UMACgkQJNaLcl1U
h9D0kQf+LOWnc5+uG7Nh+lw1IM17Kz4TpwJ61yMifGEeuryxBvycLlVXCTeHEAIq
c7HSB66JzXtv5G9t9gzAkbeVmqYDVAtbhytC3F6yo8X/qpPncogEWepaMByDvprX
HCCFf0oSdJlk2RPmofn2aVfzCcuAomhv2d96jBz73PlJ44WSxY8LdHmAgCoYcFvd
LL5HefmNAKADaNA5Kp6zLspUNtUAsuwMH/ki69FVNctvN19ZkyiL7m/+nsV5uPCv
41qzmSbcqPcNVsCqNocD4fefEk2HZARIqg8TGX0QhliWO0vQkrW+7z97xs1o8zcM
o9EInP1vqJLx6DQQ0u2h3xxeLNEekA==
=pRxx
-----END PGP SIGNATURE-----

--y1RTCqJAl8VZ6A/p--

