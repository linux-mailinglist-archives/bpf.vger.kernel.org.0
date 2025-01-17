Return-Path: <bpf+bounces-49142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33EBA146F5
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7EE188E7E4
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2F1FC3;
	Fri, 17 Jan 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KIsEmq8B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709110E4
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072890; cv=none; b=u4N0s8gSaJePAH3DmbjHo51qp3ZUjq6Ha0BTecb933bbOkqs2R4HkeNEIKS3PQGp1N5V/kPvyrO8ggTAJBQR7MkjIetBMlBuCR5UI+kRLnf9jewJTtzv3yPh5wzaCMkqN6wfIDQPH25i8vu4Md7Ey88depff0sctXu00pFlptzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072890; c=relaxed/simple;
	bh=u3DxTae53gohQbJZTsXL/05XNhSXChMYjJx/TcjL80E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu8ztMrD8sjMBkB8rAAQ3eN13On+vXLXQZcrvHPGwQP31Nfx/Z5ISKesIzHoufx7G2BXV18TjsSVR9ZpA9fY3Dq/AoUIYBUPvClT5nygC19WrHJP03cnY1ipLdbHCZ4nYgGKtou8HozJclm6uxfN0l00VkF8xX+taD2ZKivIvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KIsEmq8B; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737072885; x=1737332085;
	bh=u3DxTae53gohQbJZTsXL/05XNhSXChMYjJx/TcjL80E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KIsEmq8B1Q0dZPJyxibVCxgP6ZbcQ5/RSQWpdqZSf9pAHXZIAtL5YYHgQH12WoL6O
	 p3tZddrcCw5d4kSTQd51yI+/KCW9WsaYjfLqp72T/eDzkCVxfvcEg3JKn70mS6pV/B
	 1FtXapGMeA4DYaFJm1+GnTPwx5VCwHxnZjv3vyNOOES3MoqE/MsFXsLbQbQAC9JBMa
	 LCSsZiY1AEYWwiCuYpF6/VGikFMFv/XDZZseWjvmq8AT3bcOz0DIqE5+YYDC4cwZ75
	 XYp4OCCXHo49ttYopvAa0U1awkaaO/2xeBtjJ5Fdu8RQIBvad+fCeYTkjZdrKRcbo8
	 xH3P5lPa6Ukog==
Date: Fri, 17 Jan 2025 00:14:40 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: alan.maguire@oracle.com, andrii@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <NnLpoVqF_D4cItx1TyXTZt52XYESyQTsGDwZDgrjOzRJ5tEBVS9OtvQJT68ToG__5rxtMqh_ud23O7AQDWLaU332LavRdLfmRIA7SzCVrTk=@pm.me>
In-Reply-To: <CAEf4Bzawp=RazHAu=K8WjhhU=A9nSu08OTcov3JScyotxi8GhA@mail.gmail.com>
References: <20250110023138.659519-1-ihor.solodrai@pm.me> <Z4El7MpHaaj2YX32@x1> <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me> <gPqr61y-AW0EUZ6chsBf2VapMfPv3lcgMFNv9ZG9Whx27iDVUWv8OMw0mTxJw2ptx9jrGxNbNBMOXmmmzhElig3VeabYlWlaGlPD6jSAYsY=@pm.me> <CAEf4Bzawp=RazHAu=K8WjhhU=A9nSu08OTcov3JScyotxi8GhA@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: ab192063dcdc672aab577c0c86ab0a08c10272af
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, January 16th, 2025 at 3:41 PM, Andrii Nakryiko <andrii.nakryik=
o@gmail.com> wrote:

>=20
>=20
> On Wed, Jan 15, 2025 at 1:06=E2=80=AFPM Ihor Solodrai ihor.solodrai@pm.me=
 wrote:
>=20
> > On Friday, January 10th, 2025 at 7:58 AM, Ihor Solodrai ihor.solodrai@p=
m.me wrote:
> >=20
> > > On Friday, January 10th, 2025 at 5:51 AM, Arnaldo Carvalho de Melo ac=
me@kernel.org wrote:
> > >=20
> > > > On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
> > > >=20
> > > > > BPF CI caught a segfault on aarch64 and s390x [1] after recent me=
rges
> > > > > into the master branch.
> > > >=20
> > > > In the past the libbpf github actions was tracking the tmp.master (=
it would
> > > > be better to track "next") branch and I was looking at when it pass=
ed to
> > > > then move "next" to master, that would be great to have so that we
> > > > wouldn't be having these bugs in the git history, avoiding force pu=
shes.
> > >=20
> > > libbpf CI is still tracking tmp.master:
> > >=20
> > > https://github.com/libbpf/libbpf/actions/runs/12696027660/job/3538920=
6487
> > >=20
> > > However it only runs once a day. BPF CI runs more frequently due to t=
he
> > > volume of incoming patches. As of recently, BPF CI has been using "ma=
ster".
> > > Yesterday, when I saw the failures, I switched BPF CI to v1.28.
> > >=20
> > > I think the right way to approach this is for libbpf/libbpf to track =
"next",
> > > and BPF CI use "master". Then, most importantly, only merge next into=
 master
> > > after libbpf CI has passed.
> > >=20
> > > This can potentially be automated, but would require push access to t=
he
> > > pahole repo. Until then, a maintainer would need to manually check th=
e
> > > libbpf CI status here:
> > >=20
> > > https://github.com/libbpf/libbpf/actions/workflows/test.yml
> > >=20
> > > Another thing is that libbpf CI only tests x86_64 currently.
> > > We could add aarch64 to libbpf, or migrate pahole staging job to
> > > kernel-patches/vmtest (which is almost identical to BPF CI).
> >=20
> > Hi everyone.
> >=20
> > I looked into adding aarch64 to libbpf/libbpf CI: we can't do that
> > because Github does not provide hosted Linux aarch64 runners, only
> > macs [1].
> >=20
> > Since BPF CI already has all the infrastructure in place, I figured
> > it's going to be relatively easy to set up an additional workflow
> > specifically for pahole.
> >=20
> > Here is how it looks like:
> > https://github.com/kernel-patches/vmtest/actions/runs/12796621827
> >=20
> > This is basically a simplified BPF CI run: build pahole, build kernel
> > with gcc, build selftests/bpf with clang-18 and run test_progs (only
> > one runner, but we can run more if appropriate).
> >=20
> > I am thinking to set it up to run once a week, testing pahole/next.
> > If we do that, tmp.master tracking on libbpf/libbpf can be removed.
>=20
>=20
> Why not daily? I was even thinking of running it as part of patch
> testing to catch regressions as early as possible, but then we'd have
> red CI for any small pahole regression, which would be cumbersome. So
> perhaps a daily separate run that wouldn't affect upstream patches?

We can run daily, that's not an issue. I was thinking weekly, because
there isn't much activity on the pahole side usually.

>=20
> > I also thought about email notifications to dwarves list, like we have
> > for BPF CI. Unfortunately, there is no nice-and-easy way to set this
> > up: we either have to maintain a dummy email account and use a
> > third-party action (like [2]), or we could add a code path to Kernel
> > Patches Daemon that currently handles BPF CI notifications. I don't
> > like either way.
> >=20
> > Alternatively, maintainers could subscribe to github notifications on
> > kernel-patches/bpf (aka "watch"), but that might be too noisy as there
> > is a lot of activity there. Of course, you could check the CI runs
> > without any notifications too.
>=20
>=20
> Can you send email from inside the CI itself? E.g., if pahole build
> fails or selftests fail, explicitly send email before failing CI run?
> Just one idea, don't have anything better.

Yeah, this is what I meant by using third-party action.
The issue with it is that you need to provide mail server credentials,
which are passed to a third-party code. So, to do that a bot-ty email
account needs to be created and maintained somewhere.

>=20
> > Alan, Arnaldo, Andrii, please let me know if you have any suggestions
> > or objections.
> >=20
> > [1] https://docs.github.com/en/actions/using-github-hosted-runners/usin=
g-github-hosted-runners/about-github-hosted-runners#standard-github-hosted-=
runners-for-public-repositories
> > [2] https://github.com/marketplace/actions/send-email
> >=20
> > > [...]

