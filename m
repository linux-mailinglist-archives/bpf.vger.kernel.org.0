Return-Path: <bpf+bounces-48609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BCA09ECD
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 00:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C0B3AA63C
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2555222574;
	Fri, 10 Jan 2025 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FJXEOZYF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA820A5D5
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552664; cv=none; b=n7YqMley/LfrUCK0X97kQLkjKH4x5wg9Aw9TDzMIpWfiTJiMp2G9g7VgnFsI7mc0OU9bzJb2CEqfMgIrX2q6LEkFa5LzGzvWfx40XiPI0WNZ8bPOOao/2rPzqTQN/jME+2rm375CKDmsfnzcC4NRdLclpN6agQg5Wr2LVFvmWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552664; c=relaxed/simple;
	bh=FVrlL78xSzmRrYFwAVMxT5SBgiyZToWTQHF7prn6Gv8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8iecBtOyIQV6ucs3AYJmg2vA+CBBkdXT6WwoERbFrX9oAcAOt2IGohXhoOlW5LaS55h8tD4Vm02X/eqf3T3vFnnu/RBMP/r79GUJ+QYASV+5lbnPg8WSx36yjG9El8xXJ1IGotbEvJGig6YKr2dRpKo4MKUXfFpD20QeZPN1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FJXEOZYF; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736552654; x=1736811854;
	bh=jSLlG0i6UdhUAY+JVYLlqobgyea5V9N6CMAaondFiAY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FJXEOZYFKBr6dedH5B+4h7xujQLTaWxRw1jeq15XY57Cvrk8sZ8BiyqI8eKhaD8Nx
	 Tbt0n1znA7UZEqXJyn7ByfG2oeyIcqb5fe/HjjJWN14BiHXH3A8C4Cuqwj/BzUiEqL
	 Lr/Eg6KsRkYEvAMQeK4b4c4fUxsEhiiGSwQi00eON7GXXuQe2GVcltwHXdmge6LcVj
	 rNVTBUzeQB4fsWrg9UaqB3skcEUpuBxlfLxMX3IqMseagu+4veSGHAR8PIJzShgdT1
	 7f9yN0XI3G4rp2COjZ3J3y/ThNcQHi38Yt16laNHzwjg66Wu80FhHoEDOPV4gddzBK
	 BXjzzOI4cC9Nw==
Date: Fri, 10 Jan 2025 23:44:08 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH] selftests/bpf: add -std=gnu11 to BPF_CFLAGS and CFLAGS
Message-ID: <aQ6AOJh7xmPLqca9GMQahFPCLjiCkrlDBEMh0UBm-zX4ngEkwJaDJv55lrwMRBuwaf_yrGH3LpKqBXl86kbdRIJLUcKZCUxKAx4uCBsxBeQ=@pm.me>
In-Reply-To: <CAEf4BzZ_2=CquVPBD-WgzkfSk5UAqyp1SOeZHTfD+OsVRiKPhw@mail.gmail.com>
References: <20250107235813.2964472-1-ihor.solodrai@pm.me> <CAEf4BzZ_2=CquVPBD-WgzkfSk5UAqyp1SOeZHTfD+OsVRiKPhw@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 466345006441015cee0186ff5b79e01b58bf8348
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 10th, 2025 at 3:34 PM, Andrii Nakryiko <andrii.nakryiko@=
gmail.com> wrote:

>=20
>=20
> On Tue, Jan 7, 2025 at 3:58=E2=80=AFPM Ihor Solodrai ihor.solodrai@pm.me =
wrote:
>=20
> > Latest versions of GCC BPF use C23 standard by default. This causes
> > compilation errors in vmlinux.h due to bool types declarations.
>=20
>=20
> Do you have an example of an error? Why can't we fix that to work with C2=
3?

See a thread here: https://lore.kernel.org/bpf/ZryncitpWOFICUSCu4HLsMIZ7zOu=
iH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteN=
bQ9I=3D@pm.me/

The one I ran into is about:

    enum {
    =09false =3D 0,
    =09true =3D 1,
    };

Which is illegal in C23, because true and false are reserved words.

>=20
> [...]

