Return-Path: <bpf+bounces-49122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73AA1445B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66E33A77AB
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 22:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0EB1D86F1;
	Thu, 16 Jan 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="HX4ZFR7L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A6158520
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737065137; cv=none; b=KAL0MVr4dylAnxkLgViCEDpA8x2ksnCyuACrEcpopAMRDxFmRRBo2s1PBqMaJSqzAjKC0cy9MzMSCGIPa+Qf3cMJI4lS/KUZ0Z2BPjsIo56f11IvFcgqERBKpw4ZsC82nf4rGWAVMjqBO7cUk+qisELHjnhyw9UpTcdaN9e0SY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737065137; c=relaxed/simple;
	bh=CyxfSoKs72LyonfLfrTb2ST0ZL9BJgicIQKVV+oYTF8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mS8BclKFRO9C8jCUInpmkL+vgWHroad/8AVDomwhJqr5hIuXmjcJxZApTWvF7tRwSkjnBGHt6ZnUTUwbsjnSiE63MeZZbJdd3AHzFpTSzAi8xvKoNrjNKZgmYHW6t8aanXmptopXuoXEXyqAdj5Id5KdX4jkGHEcKg2Pv2hvlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=HX4ZFR7L; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737065128; x=1737324328;
	bh=BSlGkGj2RhYgXomQFLI65h9ovePGwt2N5RuftJNuE3o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HX4ZFR7L3Yi4V/hhSvgcJJpKkITGSutr2NUo82+eUDTWJhUarH286S63CEtNDwl9m
	 Cgc6UMtyyo1j3bIzYj1WpmZF7ikLTImJZTw/QcEalTdskpe86qxySc+ZvXzZ/3QJNu
	 6e0J3nF1E0eOikVVynrALWRUi2UzeeWUwRp8OahnYjUZwZUpJtncRQjx11/k9NzHNv
	 hWBGnxqSqNGFT/H8K0sZbEoAijcoxV8A9PcdJvPSW5ZM2CDomQ16AQKHEeIypBrL/v
	 HkHJGN26MP9NH3EntnEe+ueKX7pUzIYVlW7HCi0chXCASPP6evieLCyMEERF4aEWLH
	 e9xmUHea4QxNg==
Date: Thu, 16 Jan 2025 22:05:23 +0000
To: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, Andrew Pinski <pinskia@gmail.com>, Yonghong Song <yhs@fb.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
Message-ID: <Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me>
In-Reply-To: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 32c38ee2d05ff6daa73a68ed1dac7d3d76fe99a0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, January 16th, 2025 at 12:44 PM, Ihor Solodrai <ihor.solodrai@p=
m.me> wrote:

>=20
>=20
> Hi everyone.
>=20
> GCC BPF support in BPF CI has been landed.
>=20
> The BPF CI dashboard is here:
> https://github.com/kernel-patches/bpf/actions/workflows/test.yml
>=20
> A summary of what happens on CI (relevant to GCC BPF):
> * Linux Kernel is built on a target source revision
> * Latest snapshots of GCC 15 and binutils are downloaded
> * GCC BPF compiler is built and cached
> * selftests/bpf test runners are built with BPF_GCC variable set
> * BPF_GCC triggers a build of test_progs-bpf_gcc runner
> * The runner contains BPF binaries produced by GCC BPF
> * In a separate job, test_progs-bpf_gcc is executed within qemu
> against the target kernel
>=20
> GCC BPF is only tested on x86_64.
>=20
> On x86_64 we test the following toolchains for building the kernel and
> test runners: gcc-13 (ubuntu 24 default), clang-17, clang-18.
>=20
> An example of successful test run (you have to login to github to see
> the logs):
> https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/357369=
73856
>=20
> Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a half.
>=20
> Effective BPF selftests denylist for GCC BPF is located here:
> https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DE=
NYLIST.test_progs-bpf_gcc

The announcement triggered an off-list discussion among BPF devs about
how to handle the test running, given the long denylist.

The problem is that any new test is now a potential subject to
debugging whether the test needs changes, or GCC doesn't work for it.

As of now, an important missing piece on GCC side is the decl_tags
support, as they are heavily used by BPF selftests. See a message from
Yonghong Song:
https://gcc.gnu.org/pipermail/gcc-patches/2025-January/673841.html

Some discussed suggestions:
  * Run test_progs-bpf_gcc with "allowed to fail", so that the
    pipeline is never blocked
  * Only run GCC BPF *compilation*, and don't execute the tests
  * Flip denylist to allowlist to prevent regressions, but not force
    new tests to work with GCC

Input from GCC devs will be much appreciated.

Thanks.

>=20
> When a patch is submitted to BPF, normally a corresponding PR for
> kernel-patches/bpf github repo is automatically created to trigger a
> BPF CI run for this change. PRs opened manually will do that too, and
> this can be used to test patches before submission.
>=20
> Since the CI automatically pulls latest GCC snapshot, a change in GCC
> can potentially cause CI failures unrelated to Linux changes being
> tested. This is not the only dependency like that, of course.
>=20
> In such situations, a change is usually made in CI code to mitigate
> the failure in order to unblock the pipeline for patches. If that
> happens with GCC, someone (most likely me) will have to reach out to
> GCC team. I guess gcc@gcc.gnu.org would be the default point of
> contact, but if there are specific people who should be notified
> please let me know.


