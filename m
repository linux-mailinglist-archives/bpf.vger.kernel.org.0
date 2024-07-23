Return-Path: <bpf+bounces-35331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E993980C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76C22821DD
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50969139D16;
	Tue, 23 Jul 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="gsE76tnf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79334EC2
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699463; cv=none; b=dqGtW7z6+U2i9EzbEx9ZmbK5f4cWvVZ4yunt/GokHZJAqhDyJfxl2kMUf2uT2DK7xNv8qUvxYpHrLg7ek7BV5Uy7v+6BJmFxNgmdy5+bt/xBxxSbpu/oaUJs44z0pz/6fRra4D2j75sgeyf7oNrVkVN2kQsK312OJs4f0fH0GWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699463; c=relaxed/simple;
	bh=pPhs64sKUWoeIqmRTCdi94XwF5RafLEqjeJfCGQUf4s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEDN7C0dk9atmLKAMJ25OFy+iSymMONIJxC1QyfS7yOtsyYomxa8PalGJjWPSQJrwwwrK78y5uMdCoemXpTzRL3i9YM+9ZyPwXl5fpubKryFvz0/VyUjCWnw4950U54zwhCScS5iNw7XM9JuoFcowYCEvJOkD+HtCJvx4/qeQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=gsE76tnf; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721699453; x=1721958653;
	bh=6LisRnagmE88Ia9B4TkEPDgsOne1rr6l88s0ScHrKQU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gsE76tnffxwROZBECtGqo02OW/wNIqm0yshQqZDWam2iPxQhxf3wuUEfl5aQZ+ZY8
	 Zi6mYcMFFn6GOHEZ+Rt3QB7qJ41q1gxf+OjBYMlAT8w/q05fU8EsGfxMLZIE4Yu6mp
	 HYQVKACUoqjGCOrJjNh4fdecV6QkTTZzYNshsqv8I7d4oIbiyADVRRXAILYvxMm/ht
	 C7lWQZYNkP3Ti1lOT+LexDK5FqsOBcBP4mNfYZpqvof8KZ0T1LNm47LliX2SnJVg0z
	 HGFi6WSV8lm4ro2bycqEM5QI0RIN8WMPK6fhakwglewMa0I6gpC24NDY+KuUISUutj
	 DY0jJBIEf33/A==
Date: Tue, 23 Jul 2024 01:50:32 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, patchwork-bot+netdevbpf@kernel.org, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQMp-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=@pm.me>
In-Reply-To: <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me> <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org> <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com> <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: cabe0c1d0e3494e916a30b322078f34d6fe26cb4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, July 22nd, 2024 at 5:57 PM, Eduard Zingerman <eddyz87@gmail.com>=
 wrote:

> On Mon, 2024-07-22 at 17:39 -0700, Alexei Starovoitov wrote:
>=20
> [...]
>=20
> > Andrii, Ihor,
> >=20
> > not sure what happened, but 'make clean' now takes forever.
> > Pls take a look.
>=20
>=20
> It happens under certain conditions, here is a scenario that behaves
> badly for me:
> [...]

This is an oversight in the auto-dependency patch...

Make automagically rebuilds dependencies of included makefiles if they have=
 changed.

So, for example, if you do:

    $ make -j
    $ touch progs/verifier_and.c
    $ make clean

You'll get:

  CLNG-BPF [test_maps] verifier_and.bpf.o
  GEN-SKEL [test_progs] verifier_and.skel.h
  CLNG-BPF [test_maps] verifier_and.bpf.o
  GEN-SKEL [test_progs-cpuv4] verifier_and.skel.h
  CLNG-BPF [test_maps] verifier_and.bpf.o
  GEN-SKEL [test_progs-no_alu32] verifier_and.skel.h
  CLEAN   =20
  CLEAN   /opt/linux/tools/testing/selftests/bpf/bpf_testmod/Module.symvers
  CLEAN   eBPF_helpers-manpage
  CLEAN   eBPF_syscall-manpage

That is, dependencies of verifier_and.test.d are rebuilt, which would
be appropriate for other targets like test_progs.

I found a suggested workaround in makefile docs [1]:

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 05b234248..74f829952 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -608,7 +608,9 @@ $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.=
d:                     \
                            $(TRUNNER_BPF_SKELS_LINKED)                 \
                            $$(BPFOBJ) | $(TRUNNER_OUTPUT)
=20
+ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
+endif
=20
 $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:                          \
                       %.c                                              \

Basically, we can list the targets for which %.d files should be
ignored.

I suppose "clean" and "docs-clean" are the only relevant clean targets?

[1] https://www.gnu.org/software/make/manual/make.html#Goals



