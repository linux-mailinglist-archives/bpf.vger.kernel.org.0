Return-Path: <bpf+bounces-47724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D09FEC20
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 02:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAEA1882E5B
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 01:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DFABE5E;
	Tue, 31 Dec 2024 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kSuSe7DK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2B7FD
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735608388; cv=none; b=MfnWsk1abtIknyA3yydR61Lq/4sjD1xUdPQTSRp5KpdiMhe9sFpcZk6HcazXPaEbIn/wSisbYMJFTMRKcgUQmG14eKsOEYdonvZR8B2XSyCxw6fo5Vy5Ebs4BHDB4ESgfd5ooIXKBkcGhIoCFTYcJdVxNsbHHyGe2wx6pe2VBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735608388; c=relaxed/simple;
	bh=Z++VGEGJDdcxpsKzULiH/OeJO/HaWH1F7AlyAsTHxh0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbKrklRZYqpCfdszsAUgs96OfJ2mCIt7YQ26k699CSvPl4Ip44iPbUfdPvvz606l2YP8+c/oNmZciJGfiJFIqmd5LaMg00jZKqiHSSmp1NvjXouVsdwj3qbm4XE7DcbaA6gN4UZpX1MS6en4ys4uc3NbE/gmB4T8FWHe+yuoKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kSuSe7DK; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735608375; x=1735867575;
	bh=Z++VGEGJDdcxpsKzULiH/OeJO/HaWH1F7AlyAsTHxh0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=kSuSe7DKVaLXo9vt93VazJn7k4xaF2Vr6mzp/hb53ung+1gsCRgG16yc/wmIxB4nD
	 fpynCgpqqiMvIxp/+FnTO01YTQT93M5CyUFgSEKodx9bSaoaHrC/0AIh6E3+QqNqbb
	 5UKuzLSL1FQZ2QlyIEGXA+FnOwi7CZpvlUw1QQb2iT3nNiFIOT3mC/B+r/FDIWZF9d
	 uy94hOzt684v7TG2vEFPMijClxNke+LVa0ueYq+PcTU2KcesKILsgRwWb51Zx1g+So
	 DkjJpeKrtYqSOO2Yt4rUZWmqjA9V9fu7x9R+y3IUA75PIecnYjfo0bzPZbqR9evJhV
	 waKuTIU317ZWg==
Date: Tue, 31 Dec 2024 01:26:12 +0000
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski <pinskia@gmail.com>, Sam James <sam@gentoo.org>, Andrew Pinski via Gcc <gcc@gcc.gnu.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
Message-ID: <K9N2BZvW85sXom0Rjc28rKGhmfsmBWsFCgcHkOJz3g3ae9YseEPmygt9Nh1eTbIb354-4gGt59x_ONDF4_BWmj4RFdHplByhh_jog6dBymY=@pm.me>
In-Reply-To: <CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi8WFcvQ@mail.gmail.com>
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me> <CA+=Sn1ktCrXZMjrC0b1TNxfz1BnQfG24XUdVuktS8kRWeEP2kA@mail.gmail.com> <87v7v0oqla.fsf@gentoo.org> <7ZXLMz0XIsj0YzKNHVoLZ1JrCshOqeGCldUFbX3f8F14s0opaXTpmjfzZH2E10v0b2SFXk2x-DVTN5wGuUqPJQDhA3sOcVm7GeiGzKLRhRI=@pm.me> <CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi8WFcvQ@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: dec9984f4b1185fa329fd1ce9fb2123b1c229264
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 30th, 2024 at 4:42 PM, Alexei Starovoitov <alexei.staro=
voitov@gmail.com> wrote:

>=20
>=20
> On Mon, Dec 30, 2024 at 12:59=E2=80=AFPM Ihor Solodrai ihor.solodrai@pm.m=
e wrote:
>=20
> > On Monday, December 30th, 2024 at 12:36 PM, Sam James sam@gentoo.org wr=
ote:
> >=20
> > > Andrew Pinski via Gcc gcc@gcc.gnu.org writes:
> > >=20
> > > > On Mon, Dec 30, 2024 at 12:11=E2=80=AFPM Ihor Solodrai via Gcc gcc@=
gcc.gnu.org wrote:
> > > >=20
> > > > > Hello everyone.
> > > > >=20
> > > > > I picked up the work adding GCC BPF backend to BPF CI pipeline [1=
],
> > > > > originally done by Cupertino Miranda [2].
> > > > >=20
> > > > > I encountered issues compiling BPF objects for selftests/bpf with
> > > > > recent GCC 15 snapshots. An additional test runner binary is supp=
osed
> > > > > to be generated by tools/testing/selftests/bpf/Makefile if BPF_GC=
C is
> > > > > set to a directory with GCC binaries for BPF backend. The runner
> > > > > binary depends on BPF binaries, which are produced by GCC.
> > > > >=20
> > > > > The first issue is compilation errors on vmlinux.h:
> > > > >=20
> > > > > In file included from progs/linked_maps1.c:4:
> > > > > /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h=
:8483:9: error: expected identifier before =E2=80=98false=E2=80=99
> > > > > 8483 | false =3D 0,
> > > > > | ^~~~~
> > > > >=20
> > > > > A snippet from vmlinux.h:
> > > > >=20
> > > > > enum {
> > > > > false =3D 0,
> > > > > true =3D 1,
> > > > > };
> > > > >=20
> > > > > And:
> > > > >=20
> > > > > /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h=
:23539:15: error: two or more data types in declaration specifiers
> > > > > 23539 | typedef _Bool bool;
> > > > > | ^~~~
> > > > >=20
> > > > > Full log at [3], and also at [4].
> > > >=20
> > > > These are simple, the selftests/bpf programs need to compile with
> > > > -std=3Dgnu17 or -std=3Dgnu11 since GCC has changed the default to C=
23
> > > > which defines false and bool as keywords now and can't be redeclare=
d
> > > > like before.
> > >=20
> > > Yes, the kernel has various issues like this:
> > > https://lore.kernel.org/linux-kbuild/20241119044724.GA2246422@thelio-=
3990X/.
> > >=20
> > > Unfortunately, not all the Makefiles correctly declare that they need
> > > gnu11.
> > >=20
> > > Clang will hit issues like this too when they change default to gnu23=
.
> >=20
> > Andrew, Sam, thank you for a swift response.
> >=20
> > vmlinux.h is generated code, so for the booleans perhaps it's more
> > appropriate to generate a condition, for example:
> >=20
> > #if STDC_VERSION < 202311L
> > enum {
> > false =3D 0,
> > true =3D 1,
> > };
> > #endif
> >=20
> > Any drawbacks to this?
>=20
>=20
> By special hacking this specific enum in bpftool ?
> Feels like overkill when just adding -std=3Dgnu17 will do.

Yeah. I've tried both the flag and a btf_dump hack today, and the hack
is indeed an overkill, assuming we don't care about generating
C23-compilant vmlinux.h. To conditionalize the declarations both the
enum and typedef _Bool have to be matched, so it's actually two hacks.
Although we do use hacks like this, noticed an interesting example
today [1].

Regardless of how the bool-related error is fixed (with STDC_VERSION
condition or std flag), I get the same int64 errors with GCC
15-20241229 when building selftests/bpf [2].

[1] https://github.com/libbpf/libbpf/blob/master/src/btf_dump.c#L1198-L1201
[2] https://gist.github.com/theihor/7e3341c5a1e1209a744994143abd9e62

>=20
> > Also if vmlinux was built with GCC C23 then I assume DWARF wouldn't
> > contain the debug info for the enum, hence it wouldn't be present in
> > vmlinux.h.
> >=20
> > I don't think downgrading the standard for a relatively new backend
> > makes sense, especially in the context of CI testing.
>=20
>=20
> I don't see why not. The flag affects the front-end while CI adds
> the test coverage to gcc bpf backend.



