Return-Path: <bpf+bounces-55599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFEA8341C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 00:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1663B19E2DDF
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 22:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735921B18C;
	Wed,  9 Apr 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLD8E5p/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6426ACB;
	Wed,  9 Apr 2025 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238062; cv=none; b=TH7v6CrjgGerfxOm5E59EsX/WywDivuAS69EaxZHJOE9flUjx6hgZe7GbD5EHBd6+jmvwCRJbvJcRZ0NLHiiZnHOkf0cJEQJoUMlUows+PhqpjYv44fzpWID/FRn3YDHlSxG4HEnLpkgZFakzLurtvO7atdQkhUmuf8il8VG4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238062; c=relaxed/simple;
	bh=gmOYp4s9nc5Kx5WbhVn4dgwRNBQqeNH3HhdTyYK58YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb2XfL9LNHWaac00yu59TNkNSn/P0xIOHawTuCeWXsRykO33IkBgE1oakqMOfQ8XWyiklMzpbJfSqnyA0BvdbXwPe/Lr4vrDwklMqLdbVhpwizPwmWFwSQeXEVrAnX9A0G5aEbz78FLeJizN/HGLmIVmEZ1Hq0Nb9kqyN1L+8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLD8E5p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B90C4CEE2;
	Wed,  9 Apr 2025 22:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744238062;
	bh=gmOYp4s9nc5Kx5WbhVn4dgwRNBQqeNH3HhdTyYK58YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLD8E5p/BeTYeY/SUm/Ay3O7Xgf/Y0NeYtUiXHz0zlzHLXVU6pzwcj939aN/NCY2w
	 BYRGvXEQRj0Phxvi55L4VdES+GxbuHVUlyhS+XVozoncgcxVca+2V19My6NaaUx37u
	 vUBOcajVpBH/a2vslsEENyiifZd+/aR4156vhF2QpmG8YnqUwBCKcJEHfBqCacTc0b
	 Obbfwnuve4rsMmq/FVcIxLtb/kS8UdTZikncuHWiJnkag2ZZs4U8GHe7erbBNEW4d+
	 MvGiLhdcO/kWSV6H4bmtvjS5gpyvjciXFg4Cml7me9iVO6PFGphpsv0Q/d3mGqkuQV
	 +nfPFRVsnv8ug==
Date: Wed, 9 Apr 2025 23:34:16 +0100
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
Message-ID: <ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
References: <20250227185804.639525399@goodmis.org>
 <20250227185822.810321199@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DHuvGhJEzs16pwP+"
Content-Disposition: inline
In-Reply-To: <20250227185822.810321199@goodmis.org>
X-Cookie: Yow!  Are we laid back yet?


--DHuvGhJEzs16pwP+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 01:58:06PM -0500, Steven Rostedt wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
>=20
> Wire up the code to print function arguments in the function graph
> tracer. This functionality can be enabled/disabled during runtime with
> options/funcgraph-args.

We've been seeing the PID filters selftest failing for a while on
several arm64 systems, a bisect I managed to run without running into
any confounding issues pointed to this patch which is in mainline as
ff5c9c576e75.  It's in the ftrace code, but I'm not immediately seeing
the relevance.  Output from a failing run:

 6190 18:38:41.261255  # not ok 48 ftrace - function pid filters
 6191 18:38:41.274039  # # execute: /lava-922575/1/tests/2_kselftest-ftrace=
/automated/linux/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc
 6192 18:38:41.285261  # # + checkreq /lava-922575/1/tests/2_kselftest-ftra=
ce/automated/linux/kselftest/ftrace/test.d/ftrace/func-filter-pid.tc
 6193 18:38:41.296551  # # + grep ^#[ t]*requires: /lava-922575/1/tests/2_k=
selftest-ftrace/automated/linux/kselftest/ftrace/test.d/ftrace/func-filter-=
pid.tc
 6194 18:38:41.307877  # # + cut -f2- -d:
 6195 18:38:41.308157  # # + requires=3D set_ftrace_pid set_ftrace_filter f=
unction:tracer
 6196 18:38:41.319397  # # + eval check_requires  set_ftrace_pid set_ftrace=
_filter function:tracer
 6197 18:38:41.319681  # # + check_requires set_ftrace_pid set_ftrace_filte=
r function:tracer
 6198 18:38:41.319905  # # + p=3Dset_ftrace_pid
 6199 18:38:41.330653  # # + r=3Dset_ftrace_pid
 6200 18:38:41.330936  # # + t=3Dset_ftrace_pid
 6201 18:38:41.331161  # # + [ set_ftrace_pid !=3D set_ftrace_pid ]
 6202 18:38:41.331367  # # + [ set_ftrace_pid !=3D set_ftrace_pid ]
 6203 18:38:41.342045  # # + [ set_ftrace_pid !=3D set_ftrace_pid ]
 6204 18:38:41.342330  # # + [ ! -e set_ftrace_pid ]
 .......
 6364 18:39:15.411636  # # + grep -v 7190
 6365 18:39:15.411865  # # + wc -l
 6366 18:39:15.412073  # # + count_other=3D3
 6367 18:39:15.412554  # # + [ 2 -eq 0 -o 3 -ne 0 ]
 6368 18:39:15.412773  # # + fail PID filtering not working?
 6369 18:39:15.422776  # # + do_reset
 6370 18:39:15.423055  # # + [ 1 -eq 1 ]
 6371 18:39:15.423278  # # + echo nofunction-fork
 6372 18:39:15.423485  # # + [ 1 -eq 1 ]
 6373 18:39:15.423681  # # + echo 0
 6374 18:39:15.423873  # # + echo PID filtering not working?
 6375 18:39:15.434095  # # PID filtering not working?
 6376 18:39:15.434377  # # + exit_fail
 6377 18:39:15.434602  # # + exit 1

bisect log:

git bisect start
# status: waiting for both good and bad commits
# good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
# status: waiting for bad commit, 1 good commit known
# bad: [46086739de22d72319e37c37a134d32db52e1c5c] Add linux-next specific f=
iles for 20250409
git bisect bad 46086739de22d72319e37c37a134d32db52e1c5c
# bad: [390513642ee6763c7ada07f0a1470474986e6c1c] io_uring: always do atomi=
c put from iowq
git bisect bad 390513642ee6763c7ada07f0a1470474986e6c1c
# good: [9b960d8cd6f712cb2c03e2bdd4d5ca058238037f] Merge tag 'for-6.15/bloc=
k-20250322' of git://git.kernel.dk/linux
git bisect good 9b960d8cd6f712cb2c03e2bdd4d5ca058238037f
# good: [023b1e9d265ca0662111a9df23d22b4632717a8a] Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/netdev/net
git bisect good 023b1e9d265ca0662111a9df23d22b4632717a8a
# good: [3a90a72aca0a98125f0c7350ffb7cc63665f8047] Merge tag 'asm-generic-6=
=2E15-2' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
git bisect good 3a90a72aca0a98125f0c7350ffb7cc63665f8047
# good: [4a4b30ea80d8cb5e8c4c62bb86201f4ea0d9b030] Merge tag 'bcachefs-2025=
-03-24' of git://evilpiepirate.org/bcachefs
git bisect good 4a4b30ea80d8cb5e8c4c62bb86201f4ea0d9b030
# bad: [a7e135fe59a516b2a981fc5820e7a1e2118b427e] Merge tag 'probes-v6.15' =
of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect bad a7e135fe59a516b2a981fc5820e7a1e2118b427e
# bad: [31eb415bf6f06c90fdd9b635caf3a6c5110a38b6] Merge tag 'ftrace-v6.15' =
of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect bad 31eb415bf6f06c90fdd9b635caf3a6c5110a38b6
# good: [e8eac9fc4832976af800628ba8cbd351edc7f841] ext4: remove unneeded fo=
rward declaration in namei.c
git bisect good e8eac9fc4832976af800628ba8cbd351edc7f841
# good: [129245cfbd6d79c6d603f357f428010ccc0f0ee7] ext4: correct the error =
handle in ext4_fallocate()
git bisect good 129245cfbd6d79c6d603f357f428010ccc0f0ee7
# good: [dc208c69c033d3caba0509da1ae065d2b5ff165f] scripts/sorttable: Allow=
 matches to functions before function entry
git bisect good dc208c69c033d3caba0509da1ae065d2b5ff165f
# bad: [5ba8f4a39ecd160c7b6ef8ef1373375799710a97] function_graph: Remove th=
e unused variable func
git bisect bad 5ba8f4a39ecd160c7b6ef8ef1373375799710a97
# good: [533c20b062d7c25cbcbadb31e3ecb95a08ddb877] ftrace: Add print_functi=
on_args()
git bisect good 533c20b062d7c25cbcbadb31e3ecb95a08ddb877
# bad: [c7a60a733c373eed0094774c141bf2934237e7ff] ftrace: Have funcgraph-ar=
gs take affect during tracing
git bisect bad c7a60a733c373eed0094774c141bf2934237e7ff
# bad: [ff5c9c576e754563b3be4922c3968bc3b0269541] ftrace: Add support for f=
unction argument to graph tracer
git bisect bad ff5c9c576e754563b3be4922c3968bc3b0269541
# first bad commit: [ff5c9c576e754563b3be4922c3968bc3b0269541] ftrace: Add =
support for function argument to graph tracer

--DHuvGhJEzs16pwP+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf29ecACgkQJNaLcl1U
h9C/RQf/cS98rzGre4Btito8xfRMWxN4iL8li9UjZ1s/+dqwsIjH/FFivQ9mapwD
EjnwgdeGvMHOVbFDNnFwLtCEWudaobj1tRxBRya6jXRuIOCbwJfQgt65ZdvsFLWa
z3ZzdgX4jfJPzjxE4mbpnwkfbWy7dtsj5+wtLM07vrBt6lLePfTgS9A4gLvLjOum
jK0dzHTQb9nYgWmpI1pMatNYDcsuhCLDimamEf1qEfu1HDF/gz5Nck1wDZ2BfJGu
xGb0GqRT1JxjpqxyHjXXNjN9keQ88BMAfDs2gU0X50eIkqvR3IVOPw+8uYL+FEpz
4dVW2KbvSN6ohrRWxdJfrVIe6DC6VQ==
=/9p0
-----END PGP SIGNATURE-----

--DHuvGhJEzs16pwP+--

