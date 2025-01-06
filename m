Return-Path: <bpf+bounces-47994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46856A02FFB
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF47A1CF2
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071F15886C;
	Mon,  6 Jan 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CYpk6eaJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192D360
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189703; cv=none; b=c209FiP9kTPfBELLA+sgjqwbKyUrpEHmoBeuj6fiL/Z9bkNluEi1UWrdYAWtt1mbUu1idC/+Kk1Z6Q4yIlW9iVAU1WMslfIxuQCYhX24FdzGWwJ//KgiEBih98XTYtwh5v9EdFL+UV9pJ1KvqJUz/71ItZJBryyBIDos9KZCaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189703; c=relaxed/simple;
	bh=l03Hu9MgEgLTOseOMMn8jtduWWLtlNlvCIrI/u4Xso0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YvSjwhjD0osG3mACkm/2EEI7BN4gA6mLAWR75iuwaLk83kzR/Qrn/7bAvap2ds5hP6x9SrGEFbR2i1Sal3rtUwaQDMLQFHvIgz5zzuwi+bGs9KKPsoLyGiUSuoR7AvfrRKcgXh4PfQnxwRxNLNvnsa5vsmXnbEpb+5wWdl755bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CYpk6eaJ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736189693; x=1736448893;
	bh=dlK5DQBmMyxjMDMtBPSJksjiq2zPTVTWZkeBzvlWzY4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=CYpk6eaJGxanNsdipPoQ9wimcP/CBvj2+Q2BFCkHd28ZaO/NgFVLCZoRu9I4XnzMU
	 xeC68YTvLrpkPe8ifVjGKNXq0hsBf9sK2KOVWbb3PShHAx30KKkfcPRVPPAVL4JNj5
	 OlebdBbOAhPDMMLxKT2sinGxQvHHkirSUk4ZDF+izOQYMraikucbHAAG+XvBFS9l92
	 +whqUjsAZWwxDdHWeTKssC3TubJ7J1PfKoE9Tw2sZpTurK690pKW3PJ6A+SuOvuaQq
	 9uuWARCj2ddOUvbo33OPEa2JaJnUqBhY58FB6wyizRtHo6t3sC1T3yT2zeXOUVIdmd
	 fRBf+bJU4qUJg==
Date: Mon, 06 Jan 2025 18:54:50 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: jose.marchesi@oracle.com, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH v2] selftests/bpf: workarounds for GCC BPF build
Message-ID: <20250106185447.951609-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: b9348061072cbef882cc1919fd4405843c09cd05
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
  * Pass -std=3Dgnu17 to gcc in order to avoid errors on bool types
    declarations in vmlinux.h
  * Pass -fno-strict-aliasing for tests that trigger uninitialized
    variable warning on BPF_RAW_INSNS [2]

[1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2qi=
6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me/
[2] https://lore.kernel.org/bpf/87pll3c8bt.fsf@oracle.com/

CC: Jose E. Marchesi <jose.marchesi@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

---

v1: https://lore.kernel.org/bpf/20250104001751.1869849-1-ihor.solodrai@pm.m=
e/

 tools/testing/selftests/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index eb4d21651aa7..b043791fe6db 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -69,6 +69,10 @@ progs/timer_crash.c-CFLAGS :=3D -fno-strict-aliasing
 progs/test_global_func9.c-CFLAGS :=3D -fno-strict-aliasing
 progs/verifier_nocsr.c-CFLAGS :=3D -fno-strict-aliasing
=20
+# Uninitialized variable warning on BPF_RAW_INSN
+progs/verifier_bpf_fastcall.c-CFLAGS :=3D -fno-strict-aliasing
+progs/verifier_search_pruning.c-CFLAGS :=3D -fno-strict-aliasing
+
 # Some utility functions use LLVM libraries
 jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
=20
@@ -507,7 +511,7 @@ endef
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



