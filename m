Return-Path: <bpf+bounces-49158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F603A14880
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 04:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B624D7A406B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB21E22E6;
	Fri, 17 Jan 2025 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="r19igKrF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979625A643
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 03:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084771; cv=none; b=gw/bZrdATdFb64/a6AalUxVkpOZBAqAvVvvJ/+CXdMVWO8cVcHZV9/fz1LbOYwKNG/as0hxDZEDcK/Iqc08lHz65KYN1dwTT9cqpA8MvaQexWUwNsIz/dtBoFG/ttsfLGEaTlxNlYNsglhoSwZZI0T/y/kkBEiHlmSw1TKvcRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084771; c=relaxed/simple;
	bh=23ScoMATgzX+3eTDIQrPqASefalj4hRIB+wHszj5YmE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWKhvOAdHJ7nZ5GZCDSiQPMaa37cAYflFrujJrY+9judhLelV2ArP1/SvyQkAUOh238Dq2HXzvG8l8LN9pal2pYvBoZ8Wcv/9KW2YkHmx3q7cEFqxJm40bXwKGivYip96WtYnyAlN0FFSX7wHw4e9YCwFxcl4eMbVmECRoTj7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=r19igKrF; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737084761; x=1737343961;
	bh=23ScoMATgzX+3eTDIQrPqASefalj4hRIB+wHszj5YmE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=r19igKrFSe0mlNfoTVyzne+YCEPlt9DuCU6imh5tuBxttKokt16QWRRsm43U+3jyB
	 0JUNdqpYDJnemDmgApaSBgeQEtkprz4752/g/K4fjyk4t8XdLbROsymJaC7pv98ru5
	 sLs4iWnyR6SNCYjt1zOooZ4VbTnuEh54blpk2b04Ju97Ae4UrGMomvosgcRFTtLdTu
	 t6SWTUOqrgJF+ZVAzO8nxgJU6XzXWgAE/ajPHWHS3oIUMVy2K0wGJ88pGiyXFyB1IW
	 DDs9I5wHVetz6XhGnao/8iOvpQQtd1+RmlWSb2Jr25KR1BvvxPYVQphrsF1uY2+VtL
	 YCwTenvnjz2zA==
Date: Fri, 17 Jan 2025 03:32:36 +0000
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, Andrew Pinski <pinskia@gmail.com>, Yonghong Song <yhs@fb.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
Message-ID: <8zWDbpQS-9sjNHlLlLHFNncS_8_Tl0clkrX-Jst-1FeRJWHWYpPQe9DLdKTQwfPoLX8Grb0tB-714dcMOFsdTRBd0-ZcYwpkqe-HgGXkenc=@pm.me>
In-Reply-To: <87bjw6qpje.fsf@oracle.com>
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me> <Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me> <87bjw6qpje.fsf@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 80906411438b23fe667c69944ff703e9cc688b5b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, January 16th, 2025 at 3:58 PM, Jose E. Marchesi <jose.marchesi=
@oracle.com> wrote:

>=20
> [...]
> > >=20
> > > Effective BPF selftests denylist for GCC BPF is located here:
> > > https://github.com/kernel-patches/vmtest/blob/master/ci/vmtest/config=
s/DENYLIST.test_progs-bpf_gcc
> >=20
> > The announcement triggered an off-list discussion among BPF devs about
> > how to handle the test running, given the long denylist.
> >=20
> > The problem is that any new test is now a potential subject to
> > debugging whether the test needs changes, or GCC doesn't work for it.
> >=20
> > As of now, an important missing piece on GCC side is the decl_tags
> > support, as they are heavily used by BPF selftests. See a message from
> > Yonghong Song:
> > https://gcc.gnu.org/pipermail/gcc-patches/2025-January/673841.html
> >=20
> > Some discussed suggestions:
> > * Run test_progs-bpf_gcc with "allowed to fail", so that the
> > pipeline is never blocked
> > * Only run GCC BPF compilation, and don't execute the tests
>=20
>=20
> I think that this is the best solution for now, and the most useful.
>=20
> As soon as we achieve passing all the selftests (hopefully soon) then we
> can change the CI to flag regressions on test run failures as well.

Ok. I disabled the execution of the test_progs-bpf_gcc test runner for now.

I think we should check on the state of the tests again after decl_tags
support is landed.

Thanks.

>=20
> > * Flip denylist to allowlist to prevent regressions, but not force
> > new tests to work with GCC
> >=20
> > Input from GCC devs will be much appreciated.
> >=20
> > Thanks.
> >=20
> > > When a patch is submitted to BPF, normally a corresponding PR for
> > > kernel-patches/bpf github repo is automatically created to trigger a
> > > BPF CI run for this change. PRs opened manually will do that too, and
> > > this can be used to test patches before submission.
> > >=20
> > > Since the CI automatically pulls latest GCC snapshot, a change in GCC
> > > can potentially cause CI failures unrelated to Linux changes being
> > > tested. This is not the only dependency like that, of course.
> > >=20
> > > In such situations, a change is usually made in CI code to mitigate
> > > the failure in order to unblock the pipeline for patches. If that
> > > happens with GCC, someone (most likely me) will have to reach out to
> > > GCC team. I guess gcc@gcc.gnu.org would be the default point of
> > > contact, but if there are specific people who should be notified
> > > please let me know.

