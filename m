Return-Path: <bpf+bounces-47859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15497A01146
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 01:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2611884A99
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CFC1EA65;
	Sat,  4 Jan 2025 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oOz1BVDp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CAC1CF9B
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949888; cv=none; b=AyYZT82yeQi10iQAODLu0Oy7LzuaIZKuIiZh3QlUIWQqj/T4xaDurbZbCh8pHJXOoW3DU3FQeeZt62YalkspdBQ57RHYMJxIcR30kDOcuxiqR+GR7OJrAm+njqMhprxapR28IqBDjoptSUA/m24Yuvvn4h5+SJMTRJKithSIqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949888; c=relaxed/simple;
	bh=EkgeDvsO6t9yM1O/Og5zk4VJdCI9Lp2ucECNBLclID0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JnVrA0RPwRdtby0rKXaDsCTOx4MFoITpGCs/Qg8AhsWqVNAQ457BejRkjUpovkEG0XKJ/L0HPyVqSeQlCYE8n8lIZkULHT/l7N0SWeXbjkN0iHqS5N4YI6mFSpK4QvKsr+UVqnll0wkad0w788qLRRSTE6xIw3U4I9FPT+R5llY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oOz1BVDp; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735949879; x=1736209079;
	bh=ib4NLQXTHs9yeFSGW7a95Zk8fX3eZOTvFcq5eC0GfMw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=oOz1BVDp3qKUVL9DPSyjisG1jjChLef541XgXavQDO8WpXcGC+aK7Eq6o+/4DrUkN
	 tC1n7nd9OhbKmyqZ03UUkoPgq0LtsJcsbCnDxVTSYeURSiviYYMRCcJS660+KMAGWZ
	 aMIwpLhWoIRo/dDswTSVK7BeTL1MXBX4Y1XCENNV1qUL9aMoHPL7L5T7tRrCm9/eeh
	 ChUYBjGVAMtZ0Abhr7KjBpps9eP5BJ3ppWM7mSRDm2IYFSpaCsA0c4j7tPFsV8DQWX
	 uiobGtRoA2wZiFOgfILvay4JMTSyumhARmSZxmyn2eQNOT7FwS5eNBviG9n+SXbMVH
	 fa/Wyl3QxgElA==
Date: Sat, 04 Jan 2025 00:17:54 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH] selftests/bpf: workarounds for GCC BPF build
Message-ID: <20250104001751.1869849-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: e8db50d40d5df44985b254125636665d27d969da
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Various compilation errors happen when BPF programs in selftests/bpf
are built with GCC BPF. For more details see the discussion at [1].

The changes only affect test_progs-bpf_gcc, which is built only if
BPF_GCC is set:
  * Pass -std=3Dgnu17 when  to avoid errors on bool
    types declarations in vmlinux.h
  * Pass -nostdinc for tests that trigger int64_t declaration
    collision due to a difference between gcc and clang stdint.h
  * Pass -Wno-error for tests that trigger uninitialized variable
    warning pm BPF_RAW_INSNS

[1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi=
6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 9e870e519c30..2e1fe53efa83 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -103,6 +103,15 @@ progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS :=3D=
 -Wno-error
 progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS :=3D -Wno-error
 progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS :=3D -Wno-error
=20
+# Uninitialized variable warning on BPF_RAW_INSN
+progs/verifier_bpf_fastcall.c-CFLAGS :=3D -Wno-error
+progs/verifier_search_pruning.c-CFLAGS :=3D -Wno-error
+
+# int64_t declaration collision
+progs/test_cls_redirect.c-CFLAGS :=3D -nostdinc
+progs/test_cls_redirect_dynptr.c-CFLAGS :=3D -nostdinc
+progs/test_cls_redirect_subprogs.c-CFLAGS :=3D -nostdinc
+
 # The following tests do type-punning, via the __imm_insn macro, from
 # `struct bpf_insn' to long and then uses the value.  This triggers an
 # "is used uninitialized" warning in GCC due to strict-aliasing
@@ -507,7 +516,7 @@ endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 =09$(call msg,GCC-BPF,$4,$2)
-=09$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $1 -o $2
+=09$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -s=
td=3Dgnu17 -c $1 -o $2
 endef
=20
 SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
--=20
2.47.1



