Return-Path: <bpf+bounces-33423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1291CBF5
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEE71F2248A
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2313BBED;
	Sat, 29 Jun 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erS07F0E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4B41C67
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654496; cv=none; b=mmjdQGVKlLDlE9iRenPfzSr5njDdvxTGjPjYQ3Ld98RMXCobbHJSHIQMdTlUKStZ0bBUj7DTLZcr4oIIvPtuCUMKq/7hPVT84fp9ZF1/Ee1OLykcmbaP6tvF8+HYG+bELxsiVa3dXewY1t2VhnCTVrhOGX8dyWxkk6eK8q4G2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654496; c=relaxed/simple;
	bh=9cS3JMvs1ouLlWFF2l5AwH8CGdOc7Scuk490FSU4RI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLfLRxnWQ9yppQ6CCj7UZZ+iySkN5BUfsWFjgyjXD8YhRr1H0f8Ox6A5fO61+sNBZkDUm4g86ewPRa3DsmHL7hJUBcoHpSYXxETDI7VrZ6h+ZOU+Bb2la/htgm7bQbcs87HruOEW1iqUKLOkJ0IcHxTh+UciAbotGvPnjDMftWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erS07F0E; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-376e6c5ce0eso5180775ab.1
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654493; x=1720259293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQibrfHYTiGdeEU72XTGkGyEeLqNF+8UUhWKxDocg1k=;
        b=erS07F0E4BH7pgQ4MymfnrazLfPCtpcBEWWMB6BDV2BpwUgNWswmLSsHxfUKUS9lvJ
         zzfra3HAVPUg/bxeSBu1B1b02RXRJCRyOGBKinNp2lbv6omnw5m/nIM1tMjBNayIoeUW
         gDDxswi1O9vIkyaTnNRgKenxezMWq9drR5hlE+YbXmsl1mLn1+cl/ycXHmogAGVVkfgw
         GYKSm3t0mBwmSBA+ZJhmXaET2KkArmjUR9oT9jPHZQMHSoQN2/gv/ZvlNLuEpDuHqR5O
         dRX55ahLqp7rBXnvaW1oWxiCimTtyh+WBoR4fO2basBWk2hyngK1Vv/A5CGngTpJ9kS/
         CWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654493; x=1720259293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQibrfHYTiGdeEU72XTGkGyEeLqNF+8UUhWKxDocg1k=;
        b=OLOcumOoud5cRbq0eXTA9LO8oQ7Oo/5lt5UhZACOB95mtI7gFdmDlhHdtYJTGDaYR9
         QzN3Ik+W80hw7UVid8UCVk/NrmPODxXryapAkTS65VaAQmBQyD0GVWM/L4AZbCCwhNUT
         mrdNz/oBZka6tsWl1/oEsnIv4ovDbhgfitF8ukA67G+xkeEzU6IGtOtKgGGEFpiVdEub
         dt0xL0fJK9T8KxGgsgxpHoATMPdalQOXpR0IqwM5YIbMqVCFrKJ93rRftQEbGfMB6PhC
         sIU5yCozJGRZd0rRZD7Moaax58CoFozJsYUschISECc2QklnHrPNgjTqRSrquIJv0KHd
         Pohw==
X-Gm-Message-State: AOJu0Yyo65DhtLjAl+U1FhR8fyP0AE9AJ19ThsTv/tRWARHkxiacIQx5
	/Y63p3KtnmMQlnsO9KA134oEu0SprFfG+tL73AfTJdC2St5QiW/6nY6LYg==
X-Google-Smtp-Source: AGHT+IENLa4vfQ4K4Bjs5fDaWUikrQFRRjYc9I7M1BPNSAR+ekyGoV0+bdfAohg75I0Lcm2pkMFN4Q==
X-Received: by 2002:a05:6e02:1fe8:b0:374:aa60:a5c3 with SMTP id e9e14a558f8ab-37cd2bee935mr5634835ab.28.1719654493511;
        Sat, 29 Jun 2024 02:48:13 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:13 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 8/8] selftests/bpf: test no_caller_saved_registers spill/fill removal
Date: Sat, 29 Jun 2024 02:47:33 -0700
Message-ID: <20240629094733.3863850-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests for no_caller_saved_registers processing logic
(see verifier.c:match_and_mark_nocsr_pattern()):
- a canary positive test case;
- various tests with broken patterns;
- tests with read/write fixed/varying stack access that violate nocsr
  stack access contract;
- tests with multiple subprograms.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   7 +
 .../selftests/bpf/progs/verifier_nocsr.c      | 437 ++++++++++++++++++
 2 files changed, 444 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_nocsr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6816ff064516..8e056c36c549 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
+#include "verifier_nocsr.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_raw_stack.skel.h"
@@ -171,6 +172,12 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
+void test_verifier_nocsr(void)
+{
+#if defined(__x86_64__)
+	RUN(verifier_nocsr);
+#endif /* __x86_64__ */
+}
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
new file mode 100644
index 000000000000..5ddc2c97ada6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define __xlated_bpf_get_smp_processor_id		\
+	__xlated(": w0 = ")				\
+	__xlated(": r0 = &(void __percpu *)(r0)")	\
+	__xlated(": r0 = *(u32 *)(r0 +0)")
+
+SEC("raw_tp")
+__xlated("4: r5 = 5")
+__xlated_bpf_get_smp_processor_id
+__xlated("8: exit")
+__success
+__naked void simple(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 24) = r2;"
+	"*(u64 *)(r10 - 32) = r3;"
+	"*(u64 *)(r10 - 40) = r4;"
+	"*(u64 *)(r10 - 48) = r5;"
+	"call %[bpf_get_smp_processor_id];"
+	"r5 = *(u64 *)(r10 - 48);"
+	"r4 = *(u64 *)(r10 - 40);"
+	"r3 = *(u64 *)(r10 - 32);"
+	"r2 = *(u64 *)(r10 - 24);"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r2 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_reg_in_pattern1(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -16) = r6")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r6 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_reg_in_pattern2(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"*(u64 *)(r10 - 16) = r6;"
+	"call %[bpf_get_smp_processor_id];"
+	"r6 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -16) = r0")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r0 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_reg_in_pattern3(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"*(u64 *)(r10 - 16) = r0;"
+	"call %[bpf_get_smp_processor_id];"
+	"r0 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("2: *(u64 *)(r2 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("6: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void wrong_base_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = r10;"
+	"*(u64 *)(r2 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r2 = 1")
+__success
+__naked void wrong_insn_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = 1;"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("2: *(u64 *)(r10 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("6: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void wrong_off_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u32 *)(r10 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r1 = *(u32 *)(r10 -16)")
+__success
+__naked void wrong_size_in_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u32 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u32 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("2: *(u32 *)(r10 -8) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("6: r1 = *(u32 *)(r10 -8)")
+__success
+__naked void partial_pattern(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	"*(u32 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 16);"
+	"r1 = *(u32 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("0: r1 = 1")
+__xlated("1: r2 = 2")
+/* not patched, spills for -8, -16 not removed */
+__xlated("2: *(u64 *)(r10 -8) = r1")
+__xlated("3: *(u64 *)(r10 -16) = r2")
+__xlated_bpf_get_smp_processor_id
+__xlated("7: r2 = *(u64 *)(r10 -16)")
+__xlated("8: r1 = *(u64 *)(r10 -8)")
+/* patched, spills for -16, -24 removed */
+__xlated_bpf_get_smp_processor_id
+__xlated("12: exit")
+__success
+__naked void min_stack_offset(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 2;"
+	/* this call won't be patched */
+	"*(u64 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 16);"
+	"r1 = *(u64 *)(r10 - 8);"
+	/* this call would be patched */
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 24) = r2;"
+	"call %[bpf_get_smp_processor_id];"
+	"r2 = *(u64 *)(r10 - 24);"
+	"r1 = *(u64 *)(r10 - 16);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_fixed_read(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 = *(u64 *)(r1 - 0);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_fixed_write(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r1 - 0) = r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("10: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void bad_varying_read(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 0);" /* random scalar value */
+	"r6 &= 0x7;"		 /* r6 range [0..7] */
+	"r6 += 0x2;"		 /* r6 range [2..9] */
+	"r7 = 0;"
+	"r7 -= r6;"		 /* r7 range [-9..-2] */
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += r7;"
+	"r1 = *(u8 *)(r1 - 0);" /* touches slot [-16..-9] where spills are stored */
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("10: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void bad_varying_write(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 0);" /* random scalar value */
+	"r6 &= 0x7;"		 /* r6 range [0..7] */
+	"r6 += 0x2;"		 /* r6 range [2..9] */
+	"r7 = 0;"
+	"r7 -= r6;"		 /* r7 range [-9..-2] */
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += r7;"
+	"*(u8 *)(r1 - 0) = r7;" /* touches slot [-16..-9] where spills are stored */
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void bad_write_in_subprog(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call bad_write_in_subprog_aux;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+__used
+__naked static void bad_write_in_subprog_aux(void)
+{
+	asm volatile (
+	"r0 = 1;"
+	"*(u64 *)(r1 - 0) = r0;"	/* invalidates nocsr contract for caller: */
+	"exit;"				/* caller stack at -8 used outside of the pattern */
+	::: __clobber_all);
+}
+
+SEC("raw_tp")
+/* main, not patched */
+__xlated("1: *(u64 *)(r10 -8) = r1")
+__xlated_bpf_get_smp_processor_id
+__xlated("5: r1 = *(u64 *)(r10 -8)")
+__xlated("9: call pc+1")
+__xlated("10: exit")
+/* subprogram, patched */
+__xlated("11: r1 = 1")
+__xlated_bpf_get_smp_processor_id
+__xlated("15: exit")
+__success
+__naked void invalidate_one_subprog(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 = *(u64 *)(r1 - 0);"
+	"call invalidate_one_subprog_aux;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+__used
+__naked static void invalidate_one_subprog_aux(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+/* main */
+__xlated("0: r1 = 1")
+__xlated_bpf_get_smp_processor_id
+__xlated("4: call pc+1")
+__xlated("5: exit")
+/* subprogram */
+__xlated("6: r1 = 1")
+__xlated_bpf_get_smp_processor_id
+__xlated("10: *(u64 *)(r10 -16) = r1")
+__xlated("11: exit")
+__success
+__naked void subprogs_use_independent_offsets(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"call subprogs_use_independent_offsets_aux;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+__used
+__naked static void subprogs_use_independent_offsets_aux(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 24);"
+	"*(u64 *)(r10 - 16) = r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.45.2


