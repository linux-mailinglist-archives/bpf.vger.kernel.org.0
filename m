Return-Path: <bpf+bounces-49477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79050A1911F
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD653AB5DA
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE5212D6F;
	Wed, 22 Jan 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ0qbUyc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AD212B02
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547510; cv=none; b=oTaMi6jFkSAnrlX9wCaVL+C5mM1dIWQCf5TykkTq0/R34825b4tTHkdYb0dFpTeBMNJ7E0BqgJpkWM+DdzMrlOfxEz51pERbHfYUEi0C+tBPMhONScTcCKZS0+drWJxR1zryTA4/fWgEjacdbFsZIxeT03q/x8Dn774bdGJPz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547510; c=relaxed/simple;
	bh=6N8caChTTQwsoKDFGtSSZ23N5E8qDbrZqDDSBdDAALs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMGUxdvrBPE8oaYEozpNgWBsqzs68u9ssEiTYhHcd4dAhsFDW0brrCZ/KAGzQVJTjKT5OJoL3QnCkGVnzZZxCpF+ZvtYXwwOBtbltEkj5vbutghn5RdMwyPtCEH2t0UXMekYgMh1rNFZbaMXfqD35LSX8k/ZkteJD1Hfh2tETCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ0qbUyc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so14260515ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 04:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737547508; x=1738152308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5o4Cb3BLqtPRwc3WDOy5KP44bfkuIkve46JbYHmSuw=;
        b=DZ0qbUycOiDewgoHj+9FPt9us6bcjkMY0s5tDKE/4Q8T30CPq4zQQEhHmzmS2n2Gy0
         8Wyk4f2bWWajUicn8PyKiKveW1VLDndJ/bd4grYuWG78P4QkCWaCF6yRigzKoVXKqc9l
         uhlLjBPdml0NSKoGcS+dmY/2woWMq2fGIJ2fB3VpTn4rZFobuvu2TC1W5+UVeb//d3c2
         /ki8DN9EgMuw2L1lIpQEzv7ae3DNb5N0SNbOb5zybrvdKmiL562isgGHhsT7cc9654lI
         4FYJvv6F8DCAFNDtTffx8x+ZSFX/ALgFCvFLa7Htc2/ZPwzvZUSFmJchRwhgjr+79g20
         IWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737547508; x=1738152308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5o4Cb3BLqtPRwc3WDOy5KP44bfkuIkve46JbYHmSuw=;
        b=DeGswjT6kKP+r3aKCVxJMNsK1duol/H9ijZLSUW/p35F60Fp04dC+hoAGB+KQ4Mstd
         wWXRye0uTgHjNoXimcjT7gXg3dzTn7jVkafoeczfpaKt5aReQl4msuhn4XKsie94P/sN
         WqVhWtGDlLpouXgXzWhbZEe9/6MFFRDP4Zb3BybZ7NW79sDOjejnwB+C8mpCGFLdkIBQ
         ZX8yr5nttRmWDfk0Le0ILkEJ2tBydeXNCjOGGOhfeddJvGDlJTc6M7Wx+3bPKQ7msY+D
         4SFC/vUAHcignWW+DnEC2n64FDqcpWlqjci/tHWIweW1F3L1d/lI2nSBuXSjdOqJ52lf
         yg1g==
X-Gm-Message-State: AOJu0YzKrKkRHwDixqDbYSTl4cKNce4BAlaYFUUHUxuDh9uH3aj04LFY
	MbAq7j72OFxKa7xMRaoCV3cpB+CXZoChuG/iPzLFV4JVVcydJcG16zqkrw==
X-Gm-Gg: ASbGncvnfkuqQIOBwuoNIYFJTE0Q1YQ27ZO7PDg1O+bqsjLUwJ207Vojvg5ZwoOXhQD
	h+9rJzzbMK2ujHJ+NNT3zBQ9en+UZjLz1h80EHb/Dr4Fj+d4EVYJE5/QxhGAgbt6jpBckCIlqhA
	Aexm/nvNEkmhqjdQoirUaf4FaSGI+Se+MrpWsocxH6ykQeS8JO4+Fz3sqnkaSHOUsIjwRCN03MX
	lCEtSaRsHPbz35dXniLdEOTYb2X5fm3i2jHTP6S369xntVhPOiUSNLlNEW7pjqT/A==
X-Google-Smtp-Source: AGHT+IFPYeStzu+P7q+OWRFbVeMYAKHOHH3ZQr9OmdFxrU0TLsPyd60p/Wy462tTbw5fzQ70rGx6Ig==
X-Received: by 2002:a05:6a21:9215:b0:1e1:b0e8:11dc with SMTP id adf61e73a8af0-1eb2176de74mr31026126637.21.1737547507520;
        Wed, 22 Jan 2025 04:05:07 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm11055732b3a.66.2025.01.22.04.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:05:06 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v1 7/7] selftests/bpf: test cases for compute_live_registers()
Date: Wed, 22 Jan 2025 04:04:42 -0800
Message-ID: <20250122120442.3536298-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122120442.3536298-1-eddyz87@gmail.com>
References: <20250122120442.3536298-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover instructions from each kind:
- assignment
- arithmetic
- store/load
- endian conversion
- atomics
- branches, conditional branches, may_goto, calls
- LD_ABS/LD_IND
- address_space_cast

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/compute_live_registers.c   |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  12 +
 .../bpf/progs/compute_live_registers.c        | 363 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotol.c      |   6 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |   6 +-
 5 files changed, 386 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
 create mode 100644 tools/testing/selftests/bpf/progs/compute_live_registers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/compute_live_registers.c b/tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
new file mode 100644
index 000000000000..285f20241fe1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/compute_live_registers.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "compute_live_registers.skel.h"
+#include "test_progs.h"
+
+void test_compute_live_registers(void)
+{
+	RUN_TESTS(compute_live_registers);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f45f4352feeb..2b34911439d4 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -208,4 +208,16 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
+     defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
+     defined(__TARGET_ARCH_loongarch)) &&				\
+	__clang_major__ >= 18
+#define CAN_USE_GOTOL
+#endif
+
+#if _clang_major__ >= 18
+#define CAN_USE_BPF_ST
+#endif
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
new file mode 100644
index 000000000000..988fdd442f55
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_arena_common.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} test_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+SEC("socket")
+__log_level(2)
+__msg(" 0: .......... (b7) r0 = 42")
+__msg(" 1: 0......... (bf) r1 = r0")
+__msg(" 2: .1........ (bf) r2 = r1")
+__msg(" 3: ..2....... (bf) r3 = r2")
+__msg(" 4: ...3...... (bf) r4 = r3")
+__msg(" 5: ....4..... (bf) r5 = r4")
+__msg(" 6: .....5.... (bf) r6 = r5")
+__msg(" 7: ......6... (bf) r7 = r6")
+__msg(" 8: .......7.. (bf) r8 = r7")
+__msg(" 9: ........8. (bf) r9 = r8")
+__msg("10: .........9 (bf) r0 = r9")
+__msg("11: 0......... (95) exit")
+__naked void assign_chain(void)
+{
+	asm volatile (
+		"r0 = 42;"
+		"r1 = r0;"
+		"r2 = r1;"
+		"r3 = r2;"
+		"r4 = r3;"
+		"r5 = r4;"
+		"r6 = r5;"
+		"r7 = r6;"
+		"r8 = r7;"
+		"r9 = r8;"
+		"r0 = r9;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("0: .......... (b7) r1 = 7")
+__msg("1: .1........ (07) r1 += 7")
+__msg("2: .......... (b7) r2 = 7")
+__msg("3: ..2....... (b7) r3 = 42")
+__msg("4: ..23...... (0f) r2 += r3")
+__msg("5: .......... (b7) r0 = 0")
+__msg("6: 0......... (95) exit")
+__naked void arithmetics(void)
+{
+	asm volatile (
+		"r1 = 7;"
+		"r1 += 7;"
+		"r2 = 7;"
+		"r3 = 42;"
+		"r2 += r3;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+#ifdef CAN_USE_BPF_ST
+SEC("socket")
+__log_level(2)
+__msg("  1: .1........ (07) r1 += -8")
+__msg("  2: .1........ (7a) *(u64 *)(r1 +0) = 7")
+__msg("  3: .1........ (b7) r2 = 42")
+__msg("  4: .12....... (7b) *(u64 *)(r1 +0) = r2")
+__msg("  5: .12....... (7b) *(u64 *)(r1 +0) = r2")
+__msg("  6: .......... (b7) r0 = 0")
+__naked void store(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"*(u64 *)(r1 +0) = 7;"
+		"r2 = 42;"
+		"*(u64 *)(r1 +0) = r2;"
+		"*(u64 *)(r1 +0) = r2;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+#endif
+
+SEC("socket")
+__log_level(2)
+__msg("1: ....4..... (07) r4 += -8")
+__msg("2: ....4..... (79) r5 = *(u64 *)(r4 +0)")
+__msg("3: ....45.... (07) r4 += -8")
+__naked void load(void)
+{
+	asm volatile (
+		"r4 = r10;"
+		"r4 += -8;"
+		"r5 = *(u64 *)(r4 +0);"
+		"r4 += -8;"
+		"r0 = r5;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("0: .1........ (61) r2 = *(u32 *)(r1 +0)")
+__msg("1: ..2....... (d4) r2 = le64 r2")
+__msg("2: ..2....... (bf) r0 = r2")
+__naked void endian(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 +0);"
+		"r2 = le64 r2;"
+		"r0 = r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg(" 8: 0......... (b7) r1 = 1")
+__msg(" 9: 01........ (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
+__msg("10: 01........ (c3) lock *(u32 *)(r0 +0) += r1")
+__msg("11: 01........ (db) r1 = atomic64_xchg((u64 *)(r0 +0), r1)")
+__msg("12: 01........ (bf) r2 = r0")
+__msg("13: .12....... (bf) r0 = r1")
+__msg("14: .12....... (db) r0 = atomic64_cmpxchg((u64 *)(r2 +0), r0, r1)")
+__naked void atomic(void)
+{
+	asm volatile (
+		"r2 = r10;"
+		"r2 += -8;"
+		"r1 = 0;"
+		"*(u64 *)(r2 +0) = r1;"
+		"r1 = %[test_map] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1f;"
+		"r1 = 1;"
+		"r1 = atomic_fetch_add((u64 *)(r0 +0), r1);"
+		".8byte %[add_nofetch];" /* same as "lock *(u32 *)(r0 +0) += r1;" */
+		"r1 = xchg_64(r0 + 0, r1);"
+		"r2 = r0;"
+		"r0 = r1;"
+		"r0 = cmpxchg_64(r2 + 0, r0, r1);"
+		"1: exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(test_map),
+		  __imm_insn(add_nofetch, BPF_ATOMIC_OP(BPF_W, BPF_ADD, BPF_REG_0, BPF_REG_1, 0))
+		: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("4: .12345.7.. (85) call bpf_trace_printk#6")
+__msg("5: 0......7.. (0f) r0 += r7")
+__naked void regular_call(void)
+{
+	asm volatile (
+		"r7 = 1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 1;"
+		"call %[bpf_trace_printk];"
+		"r0 += r7;"
+		"exit;"
+		:
+		: __imm(bpf_trace_printk)
+		: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("2: 012....... (25) if r1 > 0x7 goto pc+1")
+__msg("3: ..2....... (bf) r0 = r2")
+__naked void if1(void)
+{
+	asm volatile (
+		"r0 = 1;"
+		"r2 = 2;"
+		"if r1 > 0x7 goto +1;"
+		"r0 = r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("3: 0123...... (2d) if r1 > r3 goto pc+1")
+__msg("4: ..2....... (bf) r0 = r2")
+__naked void if2(void)
+{
+	asm volatile (
+		"r0 = 1;"
+		"r2 = 2;"
+		"r3 = 7;"
+		"if r1 > r3 goto +1;"
+		"r0 = r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("0: .......... (b7) r1 = 0")
+__msg("1: .1........ (b7) r2 = 7")
+__msg("2: .12....... (25) if r1 > 0x7 goto pc+4")
+__msg("3: .12....... (07) r1 += 1")
+__msg("4: .12....... (27) r2 *= 2")
+__msg("5: .12....... (05) goto pc+0")
+__msg("6: .12....... (05) goto pc-5")
+__msg("7: .......... (b7) r0 = 0")
+__msg("8: 0......... (95) exit")
+__naked void loop(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"r2 = 7;"
+		"if r1 > 0x7 goto +4;"
+		"r1 += 1;"
+		"r2 *= 2;"
+		"goto +0;"
+		"goto -5;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_trace_printk)
+		: __clobber_all);
+}
+
+#ifdef CAN_USE_GOTOL
+SEC("socket")
+__log_level(2)
+__msg("2: .123...... (25) if r1 > 0x7 goto pc+2")
+__msg("3: ..2....... (bf) r0 = r2")
+__msg("4: 0......... (06) gotol pc+1")
+__msg("5: ...3...... (bf) r0 = r3")
+__msg("6: 0......... (95) exit")
+__naked void gotol(void)
+{
+	asm volatile (
+		"r2 = 42;"
+		"r3 = 24;"
+		"if r1 > 0x7 goto +2;"
+		"r0 = r2;"
+		"gotol +1;"
+		"r0 = r3;"
+		"exit;"
+		:
+		: __imm(bpf_trace_printk)
+		: __clobber_all);
+}
+#endif
+
+SEC("socket")
+__log_level(2)
+__msg("0: 0......... (b7) r1 = 1")
+__msg("1: 01........ (e5) may_goto pc+1")
+__msg("2: 0......... (05) goto pc-3")
+__msg("3: .1........ (bf) r0 = r1")
+__msg("4: 0......... (95) exit")
+__naked void may_goto(void)
+{
+	asm volatile (
+	"1: r1 = 1;"
+	".8byte %[may_goto];"
+	"goto 1b;"
+	"r0 = r1;"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, +1 /* offset */, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__log_level(2)
+__msg("1: 0......... (18) r2 = 0x7")
+__msg("3: 0.2....... (0f) r0 += r2")
+__naked void ldimm64(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r2 = 0x7 ll;"
+		"r0 += r2;"
+		"exit;"
+		:
+		:: __clobber_all);
+}
+
+/* No rules specific for LD_ABS/LD_IND, default behaviour kicks in */
+SEC("socket")
+__log_level(2)
+__msg("2: 0123456789 (30) r0 = *(u8 *)skb[42]")
+__msg("3: 012.456789 (0f) r7 += r0")
+__msg("4: 012.456789 (b7) r3 = 42")
+__msg("5: 0123456789 (50) r0 = *(u8 *)skb[r3 + 0]")
+__msg("6: 0......7.. (0f) r7 += r0")
+__naked void ldabs(void)
+{
+	asm volatile (
+		"r6 = r1;"
+		"r7 = 0;"
+		"r0 = *(u8 *)skb[42];"
+		"r7 += r0;"
+		"r3 = 42;"
+		".8byte %[ld_ind];" /* same as "r0 = *(u8 *)skb[r3];" */
+		"r7 += r0;"
+		"r0 = r7;"
+		"exit;"
+		:
+		: __imm_insn(ld_ind, BPF_LD_IND(BPF_B, BPF_REG_3, 0))
+		: __clobber_all);
+}
+
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__log_level(2)
+__msg(" 6: .12345.... (85) call bpf_arena_alloc_pages")
+__msg(" 7: 0......... (bf) r1 = addr_space_cast(r0, 0, 1)")
+__msg(" 8: .1........ (b7) r2 = 42")
+__naked void addr_space_cast(void)
+{
+	asm volatile (
+		"r1 = %[arena] ll;"
+		"r2 = 0;"
+		"r3 = 1;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call %[bpf_arena_alloc_pages];"
+		"r1 = addr_space_cast(r0, 0, 1);"
+		"r2 = 42;"
+		"*(u64 *)(r1 +0) = r2;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_arena_alloc_pages),
+		  __imm_addr(arena)
+		: __clobber_all);
+}
+#endif
+
+/* to retain debug info for BTF generation */
+void kfunc_root(void)
+{
+	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/testing/selftests/bpf/progs/verifier_gotol.c
index 05a329ee45ee..d5d8f24df394 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -4,11 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
-	__clang_major__ >= 18
+#ifdef CAN_USE_GOTOL
 
 SEC("socket")
 __description("gotol, small_imm")
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index e54bb5385bc1..75dd922e4e9f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -407,11 +407,7 @@ l0_%=:	call %[bpf_jiffies64];		\
 	: __clobber_all);
 }
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
-	__clang_major__ >= 18
+#ifdef CAN_USE_GOTOL
 SEC("socket")
 __success __retval(0)
 __naked void gotol_and_may_goto(void)
-- 
2.47.1


