Return-Path: <bpf+bounces-45736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB739DAC28
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D048028118B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340E201025;
	Wed, 27 Nov 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0sT49/q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF420101A
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726739; cv=none; b=hELOddLycSRM47ps84lRP+jZIi//IR1LYhBXD48QJmiCIeBjqbAOiUyL6uY4tikLlS+KNBAq//Qjl5t9rzX9dVpt3ij1eRbeMO/UpXra6KG0uZ4RsM6vV4nbhUq0ufDCqkUyMNt6yYHPhJGrttGsvb8d79fcB8kKiYOh6bxtLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726739; c=relaxed/simple;
	bh=oKNzaaFVrJSwLEjaY/JdfG+ePoPPd5PC28IvTt9EK5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeztjkCW86joXkvy6ZJrwrNG3mwLR3p3Rc6IKxxNNW6i9dUs2iyoF5nuQAag3F29Is1PUm6FwSHk/H3fK3372M9I70LKQGK0O5VjvJyDKyty8CTishiQHkFWdiBaPXyRpxQUwwwXQ+EWLB+Viv4a2qa0QRZAvP/a8tp2ayeUdpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0sT49/q; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434a10588f3so25028435e9.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732726735; x=1733331535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8aGK/nurJ0pFhZLLXoFWXyWjNsdaRzGcZ9s/k3JCAY=;
        b=e0sT49/q2b06swBHFvninU21V++rEeJoqk5tYZFbKY1Y3XD4emBfvwRXxhAnWKnxZZ
         WUBx/0kOrqMd/Pd+kFiKE+pITxnLJ58s7ReGGTHlURtS6h1f4so9mXiydQKqCZglAPBe
         +8wVtaqmr+4mFh8Hd2o+yG5R9IzCBNpP7+qrjYUljDHFii/omfpgJdUfBRf9/treFn2o
         g3F7o001NGpH08++3Sy3aScAuLIBXw6KTJKJ24cInqVW3FKTWD5oQ2ce0ISxs7+vaNde
         D4WneRLhqUwxUYl6Bb0r/80LY7Ng+KdfYUEbpILWG8RLNVlrVk6jEqXXXYjkDnYo+Hnu
         fd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732726735; x=1733331535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8aGK/nurJ0pFhZLLXoFWXyWjNsdaRzGcZ9s/k3JCAY=;
        b=iAAMdutdVOPPqar8KPHQnDbR1+J6XiSGxY+E1ZckN+i0x9GLT8Eupyw9fxA2iFLwoG
         IacF3evEp0l3xo5MnCplO+G9iGFG7SzrkDbFRRfFrs8+PQLmnZJNSI9GZBWFMmrQYYu8
         sd15sl0Lsdg7CbAwZYCRR8wIngKi4lZAGyBfp8QH4CMHdHbluezmorradcJYXStBI2bj
         y26vocyDmzN3svLpx0NT+14qjX0P5LlCrCL1+aN7mUOSaOLmvW50W7JHhtZAUNwsEPOM
         B1s0U+v5Eh7QCOSIJh9cbQpghvHJpfMJnkLV4c+86n7a0bNTv+ZjoQZudCrW+H7fxW3n
         j4MA==
X-Gm-Message-State: AOJu0YwH2SMdLMuNoCUpBz1VEUGG59HkMtZvLQL2cd9O5Sw1PNw4YNj+
	W7G3L75qhUd6pMWitaoJKVb9X1RCBoZDiXtIf1gA6OEm+Zr5EcmSnsh+/vHgWX8=
X-Gm-Gg: ASbGncuam8Yk/WWMB5OX86xgaCswiYWspn3KG0YNEVI4hNUHqxD89vDQbHpp5EKS9/q
	1wl/FRgyzVPbjJ6yV7RJIGMutx2lCVqHHHqL/L4NF1BBRqIJqKCplmqY6B1V+XxKRgUOq7XjVa9
	ZwFegvwu0hWcmCQJpOWc9yUJLtUQ4z2tK9/Zx634FYIOuy18MVrhDeL1NvfRquIanGPvw1cdwQt
	pLYmK9xZd0FCdfjtxycNn0yeP5/s71UC4gioBtMDCvv7WtgILVWmSy5PwtIqM2XTYmWSyX8s7Qa
X-Google-Smtp-Source: AGHT+IHljOnRHYVJzQUMzKfTGXP6CpFCCLrnxkj0IDk4bRH4zyD6t5ivZftuYZHzg3lX2Pq2IDFqbA==
X-Received: by 2002:a05:600c:1c18:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-434a9dc3dc3mr37448275e9.13.1732726735357;
        Wed, 27 Nov 2024 08:58:55 -0800 (PST)
Received: from localhost (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm26242655e9.37.2024.11.27.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:58:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Add IRQ save/restore tests
Date: Wed, 27 Nov 2024 08:58:46 -0800
Message-ID: <20241127165846.2001009-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127165846.2001009-1-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12505; h=from:subject; bh=oKNzaaFVrJSwLEjaY/JdfG+ePoPPd5PC28IvTt9EK5A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR0+5+Fa3OBgf44+T2tWcV8lK44O9pee3XLaltCWF GTepBNSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dPuQAKCRBM4MiGSL8RyskoD/ sGiBd4dSYkyFeuA6Nb2pW/wCJPCcl+FgwSZyIJrEb8VmYBIEFWgsxDNlI+hkFsU3VinVYEQSyfybbF HvjLPszNeE1TsQ2Y39HVcr/8Jdo8uHdxHE+sQDQlBzCU1vaq3rRf0R2rB3Rr7cFmtRa22+1Ds5l1Je YJRyze5LZrdBuuQguWoVZHdWc1+YZpZJRqZHenP6EROzDiXB6GwXpLuL3drw1qNnCsX/rsH6oxjLVX oBtbrB6McoanNCcCS5mYgqRuLhr4NhDXA1ib3APTSvhXuX+eHEiag5Wcynd8gpONF83BeTNXnyRwdy mTphIri/SrrXZ6xER2/yyZVVWVncPPytHmqTJuyo/pIvoAK49zpi0rp8WRxT4Fz3MT3tAHkk/+35QZ 2+7RPdT/18kCprzZw4rpIRo5HCNzBSuoAHCixeIqxgPuaPjlITYD3nW1JlovTq90EdNZjUweJ/STDm 93tqiO6n5emeo30k/s8p04OsANJpZNCw+3DMVavD9SHy4qJbTo9oIuAwAfow9y9j5dLiJLZO0Esp+v tH1waHBBn3V5RUghaoknV9ZuAgQ6tdewXvOQkOBVNPN0H/m8MfbFln50BZmT6GMw0ufxN5RTS/0b+l wN/rhh6ygnOp2seFWFOCVJZ3zqj+UZy+n2hWNX5h30DuBmY81sTzlcmmO+3Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Include tests that check for rejection in erroneous cases, like
unbalanced IRQ-disabled counts, within and across subprogs, invalid IRQ
flag state or input to kfuncs, behavior upon overwriting IRQ saved state
on stack, interaction with sleepable kfuncs/helpers, global functions,
and out of order restore. Include some success scenarios as well to
demonstrate usage.

#128/1   irq/irq_save_bad_arg:OK
#128/2   irq/irq_restore_bad_arg:OK
#128/3   irq/irq_restore_missing_2:OK
#128/4   irq/irq_restore_missing_3:OK
#128/5   irq/irq_restore_missing_3_minus_2:OK
#128/6   irq/irq_restore_missing_1_subprog:OK
#128/7   irq/irq_restore_missing_2_subprog:OK
#128/8   irq/irq_restore_missing_3_subprog:OK
#128/9   irq/irq_restore_missing_3_minus_2_subprog:OK
#128/10  irq/irq_balance:OK
#128/11  irq/irq_balance_n:OK
#128/12  irq/irq_balance_subprog:OK
#128/13  irq/irq_global_subprog:OK
#128/14  irq/irq_restore_ooo:OK
#128/15  irq/irq_restore_ooo_3:OK
#128/16  irq/irq_restore_3_subprog:OK
#128/17  irq/irq_restore_4_subprog:OK
#128/18  irq/irq_restore_ooo_3_subprog:OK
#128/19  irq/irq_restore_invalid:OK
#128/20  irq/irq_save_invalid:OK
#128/21  irq/irq_restore_iter:OK
#128/22  irq/irq_save_iter:OK
#128/23  irq/irq_flag_overwrite:OK
#128/24  irq/irq_flag_overwrite_partial:OK
#128/25  irq/irq_sleepable_helper:OK
#128/26  irq/irq_sleepable_kfunc:OK
#128     irq:OK
Summary: 1/26 PASSED, 0 SKIPPED, 0 FAILED

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/irq.c       | 397 ++++++++++++++++++
 2 files changed, 399 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index d9f65adb456b..b1b4d69c407a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -98,6 +98,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "irq.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -225,6 +226,7 @@ void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
+void test_irq(void)			      { RUN(irq); }
 
 void test_verifier_mtu(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
new file mode 100644
index 000000000000..b5056ac17384
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+unsigned long global_flags;
+
+extern void bpf_local_irq_save(unsigned long *) __weak __ksym;
+extern void bpf_local_irq_restore(unsigned long *) __weak __ksym;
+extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+
+SEC("?tc")
+__failure __msg("arg#0 doesn't point to an irq flag on stack")
+int irq_save_bad_arg(struct __sk_buff *ctx)
+{
+	bpf_local_irq_save(&global_flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("arg#0 doesn't point to an irq flag on stack")
+int irq_restore_bad_arg(struct __sk_buff *ctx)
+{
+	bpf_local_irq_restore(&global_flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_2(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_save(&flags3);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3_minus_2(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_save(&flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_restore(&flags2);
+	return 0;
+}
+
+static __noinline void local_irq_save(unsigned long *flags)
+{
+	bpf_local_irq_save(flags);
+}
+
+static __noinline void local_irq_restore(unsigned long *flags)
+{
+	bpf_local_irq_restore(flags);
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_1_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_2_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_local_irq_save-ed region")
+int irq_restore_missing_3_minus_2_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	local_irq_restore(&flags3);
+	local_irq_restore(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__success
+int irq_balance(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__success
+int irq_balance_n(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	local_irq_restore(&flags3);
+	local_irq_restore(&flags2);
+	local_irq_restore(&flags1);
+	return 0;
+}
+
+static __noinline void local_irq_balance(void)
+{
+	unsigned long flags;
+
+	local_irq_save(&flags);
+	local_irq_restore(&flags);
+}
+
+static __noinline void local_irq_balance_n(void)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save(&flags1);
+	local_irq_save(&flags2);
+	local_irq_save(&flags3);
+	local_irq_restore(&flags3);
+	local_irq_restore(&flags2);
+	local_irq_restore(&flags1);
+}
+
+SEC("?tc")
+__success
+int irq_balance_subprog(struct __sk_buff *ctx)
+{
+	local_irq_balance();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("sleepable helper bpf_copy_from_user#")
+int irq_sleepable_helper(void *ctx)
+{
+	unsigned long flags;
+	u32 data;
+
+	local_irq_save(&flags);
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within IRQ-disabled region")
+int irq_sleepable_kfunc(void *ctx)
+{
+	unsigned long flags;
+	u32 data;
+
+	local_irq_save(&flags);
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	local_irq_restore(&flags);
+	return 0;
+}
+
+int __noinline global_local_irq_balance(void)
+{
+	local_irq_balance_n();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("global function calls are not allowed with IRQs disabled")
+int irq_global_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	global_local_irq_balance();
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_ooo(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_restore(&flags1);
+	bpf_local_irq_restore(&flags2);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_ooo_3(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags2);
+	bpf_local_irq_restore(&flags2);
+	bpf_local_irq_save(&flags3);
+	bpf_local_irq_restore(&flags1);
+	bpf_local_irq_restore(&flags3);
+	return 0;
+}
+
+static __noinline void local_irq_save_3(unsigned long *flags1, unsigned long *flags2,
+					unsigned long *flags3)
+{
+	local_irq_save(flags1);
+	local_irq_save(flags2);
+	local_irq_save(flags3);
+}
+
+SEC("?tc")
+__success
+int irq_restore_3_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save_3(&flags1, &flags2, &flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_restore(&flags2);
+	bpf_local_irq_restore(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_4_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+	unsigned long flags4;
+
+	local_irq_save_3(&flags1, &flags2, &flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_save(&flags4);
+	bpf_local_irq_restore(&flags4);
+	bpf_local_irq_restore(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("cannot restore irq state out of order")
+int irq_restore_ooo_3_subprog(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags2;
+	unsigned long flags3;
+
+	local_irq_save_3(&flags1, &flags2, &flags3);
+	bpf_local_irq_restore(&flags3);
+	bpf_local_irq_restore(&flags2);
+	bpf_local_irq_save(&flags3);
+	bpf_local_irq_restore(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_restore_invalid(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+	unsigned long flags = 0xfaceb00c;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected uninitialized")
+int irq_save_invalid(struct __sk_buff *ctx)
+{
+	unsigned long flags1;
+
+	bpf_local_irq_save(&flags1);
+	bpf_local_irq_save(&flags1);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_restore_iter(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+
+	bpf_iter_num_new(&it, 0, 42);
+	bpf_local_irq_restore((unsigned long *)&it);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference id=1")
+int irq_save_iter(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+
+	/* Ensure same sized slot has st->ref_obj_id set, so we reject based on
+	 * slot_type != STACK_IRQ_FLAG...
+	 */
+	_Static_assert(sizeof(it) == sizeof(unsigned long), "broken iterator size");
+
+	bpf_iter_num_new(&it, 0, 42);
+	bpf_local_irq_save((unsigned long *)&it);
+	bpf_local_irq_restore((unsigned long *)&it);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_flag_overwrite(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	flags = 0xdeadbeef;
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("expected an initialized")
+int irq_flag_overwrite_partial(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	*(((char *)&flags) + 1) = 0xff;
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


