Return-Path: <bpf+bounces-47856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D19A0111A
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 00:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D653A477D
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C801BEF73;
	Fri,  3 Jan 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kjppWpp4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2269192D6A
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735948155; cv=none; b=bBgYCoqYxyC9Fp4Leg/iVqxjy/ErEU0D7XFVFsyREfpoh4UczXEE8bbQtLHvZ1lQN/CgNcDDCOpy4XJ1twFbLS7iuHHDyaQw80kx5k30MT+8F6gE3h4RCJ4FCCs0QLBfvl+ItAHBhfj34y3YvFbsxzd91K0esOthQI9pYVYmCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735948155; c=relaxed/simple;
	bh=cZ7HIv8nsrYyEIXp0Own9U6NiX1cyx6btzT83Qv8sxk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF+OL8ojycEtq9yGt2AIBru7vkzrXe35QYxQblNBpvPmBKyfpU/xGjC6f54XrKogYNdMRjRoNDJy16Q6eKCxZVFNCNCpfWVMhk005pYDeahFcTd/1GD2xq9PKxXgFdw/m/vWFy4cSW1dnkEFE4vUl6WWIEw/RimyBTcGjSruci0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kjppWpp4; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735948137; x=1736207337;
	bh=U6ayVFW1X1b5H3gvMEBfYf1BtTqBAM9KVBCHBAvwo/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=kjppWpp469aYFWrHYw4AwkGC3BDcdFNxkOTokFxUyQLt2N/y59reGQ/0stMPmQhDS
	 qNNYGVmlQKg1w8kBlSTbQTseLwUVY4fMObkSDCf8Y3RcNwtrmo3E7ILxzS8XEQffyL
	 IafeLl6EJ6uLbAEMZaFvkarHmLBAWHXGQ/gcdkMxtRQgZaTdpBjB822IRGLtlpIZLe
	 q2zZ3lFuMLW9YwxEPR0dCWB4eZnpMd16tlsVJXete08LrTZ+YWciXKcvoVMVq+BBoJ
	 MqVo0R8FzpQ7HwWyfO/KBE9lUZ2B+yEQnV/Kf2lJobux3LoQpGTADUV9pWpvM9i7PO
	 tJgLCStqvRnPQ==
Date: Fri, 03 Jan 2025 23:48:52 +0000
To: bpf <bpf@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, Yonghong Song <yonghong.song@linux.dev>, Andrew Pinski <pinskia@gmail.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
Message-ID: <EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=@pm.me>
In-Reply-To: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 4ce83146b47650ea6f27b19616e873c7a57e75cc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone.

I built and ran selftests/bpf with GCC 15-20241229, and would like to
share my findings.

Building required small adjustments in the Makefile, besides -std=3Dgnu17

With the following change we can mitigate int64_t issue:

+progs/test_cls_redirect.c-CFLAGS :=3D -nostdinc
+progs/test_cls_redirect_dynptr.c-CFLAGS :=3D -nostdinc
+progs/test_cls_redirect_subprogs.c-CFLAGS :=3D -nostdinc

Then, the compiler complains about an uninitialized variable in
progs/verifier_bpf_fastcall.c and progs/verifier_search_pruning.c
(full log at [1]):

    In file included from progs/verifier_bpf_fastcall.c:7:
    progs/verifier_bpf_fastcall.c: In function =E2=80=98may_goto_interactio=
n=E2=80=99:
    progs/bpf_misc.h:153:42: error: =E2=80=98<Uc098>=E2=80=99 is used unini=
tialized [-Werror=3Duninitialized]
      153 | #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
          |                                          ^~~~~~~~~~~~~~~~
    progs/verifier_bpf_fastcall.c:652:11: note: in expansion of macro =
=E2=80=98__imm_insn=E2=80=99
      652 |           __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND=
, 0, 0, +1 /* offset */, 0))
          |           ^~~~~~~~~~
    /ci/workspace/tools/testing/selftests/bpf/../../../include/linux/filter=
.h:299:28: note: =E2=80=98({anonymous})=E2=80=99 declared here
      299 |         ((struct bpf_insn) {                                   =
 \
          |                            ^
    progs/bpf_misc.h:153:53: note: in definition of macro =E2=80=98__imm_in=
sn=E2=80=99
      153 | #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
          |                                                     ^~~~
    progs/verifier_bpf_fastcall.c:652:32: note: in expansion of macro =
=E2=80=98BPF_RAW_INSN=E2=80=99
      652 |           __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND=
, 0, 0, +1 /* offset */, 0))

BPF_RAW_INSN expands into struct init expr (include/linux/filter.h):

    #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)=09=09=09\
    =09((struct bpf_insn) {=09=09=09=09=09\
    =09=09.code  =3D CODE,=09=09=09=09=09\
    =09=09.dst_reg =3D DST,=09=09=09=09=09\
    =09=09.src_reg =3D SRC,=09=09=09=09=09\
    =09=09.off   =3D OFF,=09=09=09=09=09\
    =09=09.imm   =3D IMM })

This can be silenced with:

+progs/verifier_bpf_fastcall.c-CFLAGS :=3D -Wno-error
+progs/verifier_search_pruning.c-CFLAGS :=3D -Wno-error

Then the selftests/bpf build completes successfully, although libbpf
prints a lot of warnings like these on GEN-SKEL:

    [...]
    libbpf: elf: skipping section(3) .data (size 0)
    libbpf: elf: skipping section(4) .data (size 0)
    libbpf: elf: skipping unrecognized data section(13) .comment
    libbpf: elf: skipping unrecognized data section(9) .comment
    libbpf: elf: skipping unrecognized data section(12) .comment
    libbpf: elf: skipping unrecognized data section(7) .comment
    [...]

Test .bpf.o files are compiled regardless. Full log at [2].

Running all tests at once, as is usually done on CI, produces a too
cluttered log. I wrote a script to run each test individually in a
separate qemu instance and collect the logs.

187/581 of toplevel tests fail on current bpf-next [3]. Many tests
have subtests: toplevel test passes if all of its subtests pass.

You can find the archive with per-test logs at [4].

[1] https://gist.github.com/theihor/10b2425e6780fcfebb80aeceafba7678
[2] https://gist.github.com/theihor/9e96643ca730365cf79cea8445e40aeb
[3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3D96ea081ed52bf077cad6d00153b6fba68e510767
[4] https://github.com/kernel-patches/bpf/blob/8f2e62702ee17675464ab00d97d8=
9d599922de20/tools/testing/selftests/bpf/gcc-bpf-selftests-logs.tgz


