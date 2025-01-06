Return-Path: <bpf+bounces-48001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A7A0313D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE01886674
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26C1D6199;
	Mon,  6 Jan 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qc8+adco"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C56DDBC
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194663; cv=none; b=pmqxwUN2ox4uCaWZFuysAE277OpAbQN2pHIEJsnpkWQa90YjxzkToaGHoNDJQWOWdTGhMt2j32NM2yE4VKwZbUBnXh/bru9NIfuysd7dyITnm5Zf1Qejphk8ExgzZxxaCUfjPiKsjNixApCmiDVOVlpVvRgsXZ877DKy1JpIEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194663; c=relaxed/simple;
	bh=2cNpwm2qw3F8MJwZActzI0ra/mhoKkYvZLZ6eaTSG+g=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V9clUDshbZ6tYwrJBb1iwouLG237JAXb0T3s2ojqmwaN+tockXI2Yk26SlokHrB/bp0BCZe7F+iSTSNULf/bgH9u3/EQlLldLOjf7djusS9+dHbc/E04xUZWz7I0QD6pDCdpUvZrk0Y2FZ3/YwUOwGq2u7NZAH8qrHSeEsm8Qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qc8+adco; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736194653; x=1736453853;
	bh=z6f9E+dF1NRNY7eUQiacZaBfnCZtw/o9RigqR/fW6QA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=qc8+adcoROjSPV6UHuWkb4qE+zTv6APe0L6mhkjLeNxV+iHNv2fSWLKMVCroQVUcI
	 0UUR1yYjiGnpwScEo3suO0fPG/a6BrXDAxZjWpncJLt6NXXqYy5xh68n5HX9M77ljA
	 PzSEgei1S2a52IA+ON5tWiLl890fOKLSpKtajO77uK/1BsDBeAKQCnHo2ibmVDMpBf
	 gMgP4G7Dm24lwRUH3prYrA0k2zPM7gpFrivqsfNoWAb+5Yzsu+OYaQor+Qu6Q+9d7r
	 m9Yd/lfXCVRI2T15Mj2+gQTNeYJGLh+LCEsQ/TqsJxRljGiuz5NQPBciw8fWyQtGBp
	 X5r8VKEy/KCmg==
Date: Mon, 06 Jan 2025 20:17:31 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next] selftests/bpf: add -fno-strict-aliasing to BPF_CFLAGS
Message-ID: <20250106201728.1219791-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 953f3b3caa22e9a2fa1f545237798edcfa0c183b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Following the discussion at [1], set -fno-strict-aliasing flag for all
BPF object build rules. Remove now unnecessary <test>-CFLAGS variables.

[1] https://lore.kernel.org/bpf/20250106185447.951609-1-ihor.solodrai@pm.me=
/

CC: Jose E. Marchesi <jose.marchesi@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

---
 tools/testing/selftests/bpf/Makefile | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index eb4d21651aa7..d5be2f94deef 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -54,21 +54,6 @@ PCAP_LIBS=09:=3D $(shell $(PKG_CONFIG) --libs libpcap 2>=
/dev/null)
 LDLIBS +=3D $(PCAP_LIBS)
 CFLAGS +=3D $(PCAP_CFLAGS)
=20
-# The following tests perform type punning and they may break strict
-# aliasing rules, which are exploited by both GCC and clang by default
-# while optimizing.  This can lead to broken programs.
-progs/bind4_prog.c-CFLAGS :=3D -fno-strict-aliasing
-progs/bind6_prog.c-CFLAGS :=3D -fno-strict-aliasing
-progs/dynptr_fail.c-CFLAGS :=3D -fno-strict-aliasing
-progs/linked_list_fail.c-CFLAGS :=3D -fno-strict-aliasing
-progs/map_kptr_fail.c-CFLAGS :=3D -fno-strict-aliasing
-progs/syscall.c-CFLAGS :=3D -fno-strict-aliasing
-progs/test_pkt_md_access.c-CFLAGS :=3D -fno-strict-aliasing
-progs/test_sk_lookup.c-CFLAGS :=3D -fno-strict-aliasing
-progs/timer_crash.c-CFLAGS :=3D -fno-strict-aliasing
-progs/test_global_func9.c-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_nocsr.c-CFLAGS :=3D -fno-strict-aliasing
-
 # Some utility functions use LLVM libraries
 jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
=20
@@ -103,18 +88,6 @@ progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS :=3D =
-Wno-error
 progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS :=3D -Wno-error
 progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS :=3D -Wno-error
=20
-# The following tests do type-punning, via the __imm_insn macro, from
-# `struct bpf_insn' to long and then uses the value.  This triggers an
-# "is used uninitialized" warning in GCC due to strict-aliasing
-# rules.
-progs/verifier_ref_tracking.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_unpriv.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_cgroup_storage.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_ld_ind.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_map_ret_val.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_spill_fill.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
-progs/verifier_subprog_precision.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasin=
g
-progs/verifier_uninit.c-bpf_gcc-CFLAGS :=3D -fno-strict-aliasing
 endif
=20
 ifneq ($(CLANG_CPUV4),)
@@ -474,6 +447,7 @@ CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG)=
,$(CLANG_TARGET_ARCH))
 BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)=09\
 =09     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)=09=09=09\
 =09     -I$(abspath $(OUTPUT)/../usr/include)=09=09=09\
+=09     -fno-strict-aliasing =09=09=09=09=09\
 =09     -Wno-compare-distinct-pointer-types
 # TODO: enable me -Wsign-compare
=20
--=20
2.47.1



