Return-Path: <bpf+bounces-49114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5272A14395
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AD816B8D3
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB979241696;
	Thu, 16 Jan 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PyGJ6hX4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78134236A9F
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060311; cv=none; b=FceJ39Zmgc+doEp+i1BCYskZJus5Zp4Kpvqpq8xJyOtSiuugnui/nv7VMRrsINZr693PfngsKIbcqr5r9VpPQG1imShgCimiOk0f1Qv8zFK7spQrD9DHr1go/mm10reRwwTpEGCWWVlr+Lq7cU9Q6ekYcJDVDwdAvldQqogl/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060311; c=relaxed/simple;
	bh=q+kL3CfiLCXEA+kNdg1CWHqmb7wCGdKjTjSOq/y/yfQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VeFl+Y+kqigBSzl091/DRmncDVkHMViG8f3JaXK1X1zI9vw/wR/QW6ZmIRDCfg9mZ91gC5vf2R0fq/RmqkImTGn8rN59hRqhZIcyycXOPj2MhAqiwqx3rBcG4m30zrkgSYjs1nsE1VxORD2gxpK6/EJhO6dDnL53q774XEWPlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PyGJ6hX4; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737060300; x=1737319500;
	bh=63jx38g1yZ6vKz/IYz/fxpxEnDim8ZY2HCVpjv3wJ+g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=PyGJ6hX4G5/FOR8EA+7UfSTMDqaRYM9mqzJbSmyBHcxrQmen1n3wNWOZXPQIHOZ39
	 to+OYLMrfMdPCzkVv3e8beOB6mt1bjbG0RZKIQB1zwbG0uu1bMkCHv3B1D+eOZSusi
	 LcSY/OHL/ah/NcP+Az+GWwowSvDXH9azsOq24i5uToK923sLRxHEzViL89ijWlky9p
	 d02bWzn6wdHtRtubJ88H7LlCnxmX5OMmPG94VKAmCcgH4pMxmujsRfBKpN2uCSk+aZ
	 n1NWUfzH69Tk4m2jtxTwH0rxoSQpL81KkjdiZKMMKh7f1gaV36kjqaTxEYSTcGS9Vl
	 quvLPh4X4vehw==
Date: Thu, 16 Jan 2025 20:44:54 +0000
To: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, Andrew Pinski <pinskia@gmail.com>
Subject: Announcement: GCC BPF is now being tested on BPF CI
Message-ID: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c8347efe34b21673c173f37438834c47ea437cc9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone.

GCC BPF support in BPF CI has been landed.

The BPF CI dashboard is here:
https://github.com/kernel-patches/bpf/actions/workflows/test.yml

A summary of what happens on CI (relevant to GCC BPF):
  * Linux Kernel is built on a target source revision
  * Latest snapshots of GCC 15 and binutils are downloaded
    * GCC BPF compiler is built and cached
  * selftests/bpf test runners are built with BPF_GCC variable set
    * BPF_GCC triggers a build of test_progs-bpf_gcc runner
    * The runner contains BPF binaries produced by GCC BPF
  * In a separate job, test_progs-bpf_gcc is executed within qemu
    against the target kernel

GCC BPF is only tested on x86_64.

On x86_64 we test the following toolchains for building the kernel and
test runners: gcc-13 (ubuntu 24 default), clang-17, clang-18.

An example of successful test run (you have to login to github to see
the logs):
https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/35736973=
856

Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a half.

Effective BPF selftests denylist for GCC BPF is located here:
https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/configs/DENY=
LIST.test_progs-bpf_gcc

When a patch is submitted to BPF, normally a corresponding PR for
kernel-patches/bpf github repo is automatically created to trigger a
BPF CI run for this change. PRs opened manually will do that too, and
this can be used to test patches before submission.

Since the CI automatically pulls latest GCC snapshot, a change in GCC
can potentially cause CI failures unrelated to Linux changes being
tested. This is not the only dependency like that, of course.

In such situations, a change is usually made in CI code to mitigate
the failure in order to unblock the pipeline for patches. If that
happens with GCC, someone (most likely me) will have to reach out to
GCC team. I guess gcc@gcc.gnu.org would be the default point of
contact, but if there are specific people who should be notified
please let me know.


