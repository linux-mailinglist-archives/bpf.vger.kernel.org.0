Return-Path: <bpf+bounces-48981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50345A12D52
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37893A184A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F661DC98A;
	Wed, 15 Jan 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b1F8k4Bv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA21DE8BA;
	Wed, 15 Jan 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975200; cv=none; b=iuRbqlHg9HaHa9qCYqOcEGs0Ou8TAF+8IcNIgxSanVilH7BQD2muAosnn+bj+uLkDnIxOQdG/+Bgvq+4yepy174j6bvAmS9qwJgO2mtkytMS3hOwwi3/tnVoKCGAUkKJfCUNEaDRcoub3pg68b7Nvph6hOXIdP1kHaxWRfK+WkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975200; c=relaxed/simple;
	bh=BwXBZdjniMy8l0V+t9X74ykLwZ6r39E4swnwcLwMJQU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIRWZNjCvnWY0pBZNyVSxucY3YFr2xM0D1hD9MvP6iRY5vVB8pszfpJzrH9CW7dQRcyy+61izXS7wUxhI6HsPGdN9rS8p2JsL4HKh1VjqOFtOdwigoDDtE0sul7YtO125TXHzZokesFL77Jr+iljlmSrE/U6WNr6coQzrVAmnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b1F8k4Bv; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736975190; x=1737234390;
	bh=BwXBZdjniMy8l0V+t9X74ykLwZ6r39E4swnwcLwMJQU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=b1F8k4Bvjcz0tq3oC4lv0U+23GRcGIWg8UX5zDfVdndFbEse7dI6ZN6tC13R3igSm
	 FeaPn1wKEe/RBnxXEkYKYp/wT23snKN6sN+ogSMIuqUOCh0QhIzJLH+anq5zdjYtbK
	 S6zJI9VSVlYtKFFsBWU4pP6hBF801PDtIqlHj1MnbkZGid5eolhkuLwgGlOr3IQmL7
	 gcNFPePmgNDCm8m0mpj/2T9W+dR3dgwby4d75/ZLVgntYMAmLdW1GcALu/odmw7VYT
	 P2yCClTaqxgYWibSV2wa/wkUjVqDWcJp5rzvtbqSiyFEM+ykFzA/e8iO5id2Cvuzlk
	 lfcR7T9EJWDKQ==
Date: Wed, 15 Jan 2025 21:06:24 +0000
To: alan.maguire@oracle.com, andrii@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <gPqr61y-AW0EUZ6chsBf2VapMfPv3lcgMFNv9ZG9Whx27iDVUWv8OMw0mTxJw2ptx9jrGxNbNBMOXmmmzhElig3VeabYlWlaGlPD6jSAYsY=@pm.me>
In-Reply-To: <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me>
References: <20250110023138.659519-1-ihor.solodrai@pm.me> <Z4El7MpHaaj2YX32@x1> <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 197dabba017696fa3d42679465c7c0305121d3b5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 10th, 2025 at 7:58 AM, Ihor Solodrai <ihor.solodrai@pm.m=
e> wrote:

>=20
> On Friday, January 10th, 2025 at 5:51 AM, Arnaldo Carvalho de Melo acme@k=
ernel.org wrote:
>=20
> > On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
> >=20
> > > BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> > > into the master branch.
> >=20
> > In the past the libbpf github actions was tracking the tmp.master (it w=
ould
> > be better to track "next") branch and I was looking at when it passed t=
o
> > then move "next" to master, that would be great to have so that we
> > wouldn't be having these bugs in the git history, avoiding force pushes=
.
>=20
>=20
> libbpf CI is still tracking tmp.master:
>=20
> https://github.com/libbpf/libbpf/actions/runs/12696027660/job/35389206487
>=20
> However it only runs once a day. BPF CI runs more frequently due to the
> volume of incoming patches. As of recently, BPF CI has been using "master=
".
> Yesterday, when I saw the failures, I switched BPF CI to v1.28.
>=20
> I think the right way to approach this is for libbpf/libbpf to track "nex=
t",
> and BPF CI use "master". Then, most importantly, only merge next into mas=
ter
> after libbpf CI has passed.
>=20
> This can potentially be automated, but would require push access to the
> pahole repo. Until then, a maintainer would need to manually check the
> libbpf CI status here:
>=20
> https://github.com/libbpf/libbpf/actions/workflows/test.yml
>=20
> Another thing is that libbpf CI only tests x86_64 currently.
> We could add aarch64 to libbpf, or migrate pahole staging job to
> kernel-patches/vmtest (which is almost identical to BPF CI).

Hi everyone.

I looked into adding aarch64 to libbpf/libbpf CI: we can't do that
because Github does not provide hosted Linux aarch64 runners, only
macs [1].

Since BPF CI already has all the infrastructure in place, I figured
it's going to be relatively easy to set up an additional workflow
specifically for pahole.

Here is how it looks like:
https://github.com/kernel-patches/vmtest/actions/runs/12796621827

This is basically a simplified BPF CI run: build pahole, build kernel
with gcc, build selftests/bpf with clang-18 and run test_progs (only
one runner, but we can run more if appropriate).

I am thinking to set it up to run once a week, testing pahole/next.
If we do that, tmp.master tracking on libbpf/libbpf can be removed.

I also thought about email notifications to dwarves list, like we have
for BPF CI. Unfortunately, there is no nice-and-easy way to set this
up: we either have to maintain a dummy email account and use a
third-party action (like [2]), or we could add a code path to Kernel
Patches Daemon that currently handles BPF CI notifications. I don't
like either way.

Alternatively, maintainers could subscribe to github notifications on
kernel-patches/bpf (aka "watch"), but that might be too noisy as there
is a lot of activity there. Of course, you could check the CI runs
without any notifications too.

Alan, Arnaldo, Andrii, please let me know if you have any suggestions
or objections.

[1] https://docs.github.com/en/actions/using-github-hosted-runners/using-gi=
thub-hosted-runners/about-github-hosted-runners#standard-github-hosted-runn=
ers-for-public-repositories
[2] https://github.com/marketplace/actions/send-email

>=20
> [...]



