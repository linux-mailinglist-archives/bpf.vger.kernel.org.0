Return-Path: <bpf+bounces-49217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F0A15612
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38851887319
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B31A2545;
	Fri, 17 Jan 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="sL4F5FYQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8541A23A9
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136545; cv=none; b=UH/+IfNkuC71NzZzhonzXspY6qEiqWqAWo6FKoQbhLDCZgFizrcf3M+aMY3uKyJcKZWlU0jA3aymdsRe4k5hXFDoX5BsHSypJvglX5LYSnqJf4kJ639SYqhkAYTViWGFzEZWrZTLBkWHzhwaXtxxTEW5pSa/fdp5YVezDdeYmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136545; c=relaxed/simple;
	bh=I07rn8h81be6RbBm2AHPSR3EU88miw6hQCBTc4pvf+Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrDuSYioyGw6KfxzlCDs4Zha54FiV8PZn/Eho0TtPKaRsEEzRMigPePNyaUt4YBbnK6bX7mbAJ3B7VibY2FMZsNXHIS6QaBnFu+A34kpCuzn+07gmAF+p5m7zWWH2IGF9DjpLtlSFXKvcESEvqN6s5zK3oQ5eXeDhGZgyj31eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=sL4F5FYQ; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737136527; x=1737395727;
	bh=I07rn8h81be6RbBm2AHPSR3EU88miw6hQCBTc4pvf+Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=sL4F5FYQa5IyliI2qTw1h0AGViHeL1WLv0YGe+mp0vuaSw9rSTKhfanhMMYGukvT7
	 8LTUIx0kVrPdxgkJh29P/OJ3rwdv2woMS+6sMj9z8gZUAQ9WQAJAZNUdjjEXLcf8+l
	 SfOH8ZIGBArRMMA1t+q6TAWFdYk1clxhbuYHI99E2NY2iW2zW0jTfIW16WeU2HgYfy
	 T7wxh8cEXqnKpb13IIKkL3nwDgeY6YlCqEB3ivHFh3/4i6TS4YexxRoYJsBZEIYSbK
	 HMh1Y3cwcKGdViID+E/zxxA+5OXTlY5zG4KPsm9m1Kk2/P5NKaciGuZyHcXBdG/kZP
	 i3ZUX04TCsmOA==
Date: Fri, 17 Jan 2025 17:55:21 +0000
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, Andrew Pinski <pinskia@gmail.com>, Yonghong Song <yhs@fb.com>
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
Message-ID: <zp_HRUf7wzFwZMVqR2IwXRMf-WtdNZP-ocWWflDG0nDLg2FXZ0Jt91ztxfBxdHurGC_z4C5M5qPIspVTFMAXG5_hFuDwZRMNmXKak3UnLXk=@pm.me>
In-Reply-To: <87ldv9k9e3.fsf@oracle.com>
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me> <Yb09J1CvDUk4Mi2bgm3Pd3FJGMi-s3fvc9aftbrOtE4ccqzgwrkalnjKcEA2Y3RB_obEww6EG737pTfyqm6Wyf8fqMRBpaPUA8gH_58GYT4=@pm.me> <87bjw6qpje.fsf@oracle.com> <8zWDbpQS-9sjNHlLlLHFNncS_8_Tl0clkrX-Jst-1FeRJWHWYpPQe9DLdKTQwfPoLX8Grb0tB-714dcMOFsdTRBd0-ZcYwpkqe-HgGXkenc=@pm.me> <87ldv9k9e3.fsf@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9a38d434b925fe8efc5d5a2096a54da35635085c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 17th, 2025 at 2:44 AM, Jose E. Marchesi <jose.marchesi@o=
racle.com> wrote:

> [...]
>
> > Ok. I disabled the execution of the test_progs-bpf_gcc test runner for =
now.
> >=20
> > I think we should check on the state of the tests again after decl_tags
> > support is landed.
>=20
>=20
> Thank you. Sounds like a plan :)
>=20
> Is it possible to configure the CI to send an email to certain
> recipients when the build of the selftests with GCC fails? That would
> help us to keep an eye on the patches and either fix GCC or provide
> advise on how to fix the selftest in case it contains bad C.

In principle, yes. In practice email notifications are not that
straightforward.

Currently a BPF patch submitter gets a notification about the status
of the CI pipeline for their patch. This makes sense, recipient is
obvious in this case.

In case of GCC (or any other CI dependency for that matter), it is
necessary to determine the potential cause before sending
notifications. There are all kinds of things that might have caused a
failure independent of the target being tested: could be a bug in CI
scripts, or github could have changed runner configuration, or a merge
commit from (Linux) upstream broke something, etc.

Point is, dependency maintainers (GCC team in this case) don't want to
get notifications for *all* such failures, because you will have to
ignore most of them, and so they become noise. A boy crying wolf kind
of thing.

The other issue is that maintaining email notifications is an
operational overhead, meaning that the system managing the
notifications needs to be looked after. Currently for BPF CI it's
Kernel Patches Daemon instance maintained by Meta engineers [1].

As it stands, if there is problem with GCC that affects BPF CI, you
can be assured it'll be reported, because it will block the testing of
the BPF patches.

I suggest GCC BPF team to think about setting up your own automated
testing infrastructure, focused on testing the GCC compiler. Maybe you
already have something like that, I don't know. You certainly
shouldn't rely exclusively on BPF CI for testing the BPF backend.

[1] https://github.com/facebookincubator/kernel-patches-daemon

>=20
> > Thanks.
> >=20
> > [...]


