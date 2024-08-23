Return-Path: <bpf+bounces-38001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3A95D977
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 01:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0987028345E
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 23:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303411C8228;
	Fri, 23 Aug 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VCtoP+Cz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F55FBBA
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454410; cv=none; b=C3kcmlkbw2On4uL4Z7bzP6J75/wIZjPaLPIbSHUs5+Sx00Km1F0FHL9r5fHDHJy8Cx6UOObaJ9U8SMr6ctcmaz4fhG3wGZVT4gHRvwAs/7SkO50zQQbeEa49PFKW7DH9NU1ulEvAsHJHg/pWqevZcftvh5X1QSi9t3KuxejuW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454410; c=relaxed/simple;
	bh=WxVNxIiGANoTUbZp5l7oAcKlEWIEaTrRCB+WpqKBnmI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CCRvlzB494H4wF0+KlnmYHgZK4DLN5KCq8pPcUP3mAUi35IvJM9ohiuFtPd2kNHZyDn8l8uFXBBC3RffQawQ7qZ+dN2s69hCo/NyX8KqkIQt3bjIrG9FzY+5hgwJx+MafECFvLMLPxGKejKLuyO3wdarB1T2+UHdb4Vue5VCHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VCtoP+Cz; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1724454400; x=1724713600;
	bh=DBjRTH8B+SlGB/0QJow3p0kxri4lryy+00X9ua+lR2I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VCtoP+CzLef4Jzn9846rdLJzzctZPlduh7NxDCbHV1L3s6cFGoaYAIWexTiXhizSP
	 dHzryjXWbS0jTGbKGd4JCV+8Smy5aEn6pIh9Xus9PSV5lGQRuewfMh6JjPrQxDsjr1
	 7Cx73czye/0lksviAPZYKQ5ATBKE4+4vzeG0r7pT+c1hEweYGs9/KCi2dnp7MpfkrE
	 gYw1OWeGh1WvhysDitHOdCBYiM9RTBkmGlR5L8fGPKuBY0TVQ57cMtqpsY7QvtEKmZ
	 xsvTby5+qZTQSi1To9AmrmDqM0SNzq1Dvrj6FlMuum4E5D7g8+tofWtXOmwGfjbSOr
	 /EKWLVdsqceuQ==
Date: Fri, 23 Aug 2024 23:06:35 +0000
To: bpf <bpf@vger.kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: compare vmlinux.h checksum when building %.bpf.o
Message-ID: <TCvb-R45mBUJOpoW3V-tLkH2XppfNXYbkv7Ph0ae8J9MZKWFvQ3nkJw74KKMbMzzpAvbwXBwRuBmhFOtHl0-jLLrIALH-_2_Zp-MZ9pPXPo=@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9214dca4a85a1db2969198f45182e5bd7950b7e0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

%.bpf.o objects depend on vmlinux.h, which makes them transitively
dependent on unnecessary libbpf headers. However vmlinux.h doesn't
actually change as often.

Compute and save vmlinux.h checksum, and change $(TRUNNER_BPF_OBJS)
dependencies so that they are rebuilt only if vmlinux.h contents was
changed. Also explicitly list libbpf headers required for test progs.

Example of build time improvement (after first clean build):
  $ touch ../../../lib/bpf/bpf.h
  $ time make -j8
Before: real  1m37.592s
After:  real  0m27.310s

You may notice that the speed gain is caused by skipping %.bpf.o gen.

Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=3Dp1jdT=
fKC7i0XVuYoHUQ@mail.gmail.com

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index ec7d425c4022..4f23d9ddc8b8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -407,6 +407,14 @@ else
 =09$(Q)cp "$(VMLINUX_H)" $@
 endif
=20
+VMLINUX_H_CHECKSUM :=3D $(INCLUDE_DIR)/vmlinux.h.md5
+
+$(VMLINUX_H_CHECKSUM): $(INCLUDE_DIR)/vmlinux.h
+=09$(shell md5sum $(INCLUDE_DIR)/vmlinux.h > .tmp.md5)
+=09$(shell md5sum -c .tmp.md5 $(VMLINUX_H_CHECKSUM) --status \
+=09=09|| cp -f .tmp.md5 $(VMLINUX_H_CHECKSUM))
+=09$(shell rm .tmp.md5)
+
 $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids=09\
 =09=09       $(TOOLSDIR)/bpf/resolve_btfids/main.c=09\
 =09=09       $(TOOLSDIR)/lib/rbtree.c=09=09=09\
@@ -515,6 +523,12 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
 LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
=20
+HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)=09=09\
+=09=09=09$(addprefix $(BPFDIR)/,=09bpf_core_read.h=09\
+=09=09=09                        bpf_endian.h=09\
+=09=09=09=09=09=09bpf_helpers.h=09\
+=09=09=09                        bpf_tracing.h)
+
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relie=
s on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
@@ -564,9 +578,8 @@ $(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs :=3D y
 $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:=09=09=09=09\
 =09=09     $(TRUNNER_BPF_PROGS_DIR)/%.c=09=09=09\
 =09=09     $(TRUNNER_BPF_PROGS_DIR)/*.h=09=09=09\
-=09=09     $$(INCLUDE_DIR)/vmlinux.h=09=09=09=09\
-=09=09     $(wildcard $(BPFDIR)/bpf_*.h)=09=09=09\
-=09=09     $(wildcard $(BPFDIR)/*.bpf.h)=09=09=09\
+=09=09     $(VMLINUX_H_CHECKSUM)=09=09=09=09\
+=09=09     $(HEADERS_FOR_BPF_OBJS)=09=09=09=09\
 =09=09     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 =09$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,=09=09=09\
 =09=09=09=09=09  $(TRUNNER_BPF_CFLAGS)         \
--=20
2.34.1



