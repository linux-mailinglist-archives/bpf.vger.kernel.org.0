Return-Path: <bpf+bounces-70440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BDCBBF231
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FD73BF823
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47502586CE;
	Mon,  6 Oct 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMXR5GGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898121A38F9
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780966; cv=none; b=mrXsx869I++J3m9X+AByOW68aBwXvJB5h5Ro/O4DJa0KQyodGY5sOhd3e5xh3E1s9UD/IvBzghS5+K4yqCIJQ2JbiwZ0a52uWtksf8WnfneYx6D0HdrxK+8uSoCgmazSITyNZg0jEl72X92yb2laN/0RYn9FNzC/r5Gc8rgXggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780966; c=relaxed/simple;
	bh=3xPXXCjfK9GbtChX+bA5ZVIpukPBLvaGsx0HYLyTFwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYadgA664T6NKJ8EEMUtszbok+MovES9rlfYjqabrhUX+IgRdUBpZCxsKQuoAPKi5XMKBXhWAjoO0x6H+nAneiPyuUdoNzP/BBIY5ZmTwdeeYT4mlWp/VBwCHTLMCRo6QQNOksPHp6OiQ68uMKGLq/bZKP7c4vgpPmY25z1cgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMXR5GGw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e542196c7so35869185e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780963; x=1760385763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px9sItLMifxRSbYsil/6DVR5o7xXXHJUyHlIWz+CMOA=;
        b=VMXR5GGwXoLxCFpbq1J8mieCzJECiqQjNdMoELn+dP3YEfQxEzF64JtdxXs8ruICLe
         Smuly7AT1dJJigxY3Ib+YlvGSoAHc/Sxxr4a4rVG0trmi8uYunXejXYr3kwJdwb1EdPa
         ogftrtdSGPO0cGLi2GlnMCFBrtsuP3qOZUSgzpfFqFghHSdb541BqtM6XEbgMBQY5roP
         e+GtCve+BZZdM3KCprASqpg8bSCsBt521tkXkfCrGLQqRsamr3haX2LBeJ01FqApVUn1
         1xtUnQkcssmVcebu0ZbiqVxAX+GvG6LM2hyP01s6ZcFJyDZdtdpNsXAjWdu0W7y3ZCwR
         v2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780963; x=1760385763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px9sItLMifxRSbYsil/6DVR5o7xXXHJUyHlIWz+CMOA=;
        b=NnDkjgoAE+zw4J+BScz5hUG7h8NGNZS2mNxUWl46gLUlrYbaa1jq/y6ukTJ/k1EBUj
         /ndU0R9iMWUHEHXltuZNgwRspJ0bIqx/BKd07t0ggxGvoN3oEtJSwimL8uKQzavPlk0s
         gN7NlR1zFVG8dgw7+p4mbFyeWMFijO1+h97NEBNJOGNz0Zf0EzYZl/qgl1Ozr+lSkxl2
         uDXTSfmNj5xOXjq66AuFDVX5bdRChC48nxciSpIQbyNqCX/cxI1EpeYQ7Fl0AlSZn7Rb
         l0lyZlrFFuMRX92Q4q4Zz0TJFmlAdxd2Azj59KeySbmoYffOYwduzBi0zVuE9gLHNosD
         YCJQ==
X-Gm-Message-State: AOJu0Yz3Vj5QXSTPHBuaYr9NHlXBZXNHhQf7u7dwHZGJIOP/LKWhtZNr
	THCLkgEEc+0NEIeIQeBnYEIBp0HHjUglMRUNpGQTX8pH5Rp4UQocA/YLJXZleg==
X-Gm-Gg: ASbGnctd1bIZDoiXtNyD6EnTo298djTRUXRZPlky1bqdexI0k1sT4MPMAwbZo2LJ+7T
	E80Tz3My9OAozdVZNO1ZZSSeC2dJXjjCVcsDwZBZLghPw51EZ53e1iouiPJCK9udodmukn3BDWM
	1exwyn7/LYymqhJWGIIX+4xG6N8poIKy3278LrAeTjBKBPPIA2/n3/HO7pH8xgH1/KEblc3Qa7L
	Yiu6xNy8sxpp79ffjPX4rB+n+Kv6qpfj6Jj1BLKkYu9l3OpY+hB3CUpUuqC/UtT/Lpx8U4rrnZj
	uGNt+wEvO5lV2Q11QUI3rK8fU8/QRRIoBVCVZ4cDiIHc2RqWToIHNuEs9FDdhhiCtutrdAyaDPy
	ewSujg+2jdXXWrZTS9qL9Qc3xx5K1iPAfnsU9VJOAZM/hL28BNAv16CqU
X-Google-Smtp-Source: AGHT+IGfYrkkeXddyfZIJZokeV/E6D3YiAY6dYvL/BF/X0jStE/ZK/7iolhlSMrNYYkWSn8agprimA==
X-Received: by 2002:a7b:ca44:0:b0:46d:e5bd:2ba4 with SMTP id 5b1f17b1804b1-46fa29ffedemr3526385e9.18.1759780962467;
        Mon, 06 Oct 2025 13:02:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72343260sm170436925e9.4.2025.10.06.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:02:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: add bpf_wq tests
Date: Mon,  6 Oct 2025 21:02:36 +0100
Message-ID: <20251006200237.252611-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
References: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_wq selftests to verify:
 * BPF program using non-constant offset of struct bpf_wq is rejected
 * BPF program using map with no BTF for storing struct bpf_wq is
 rejected

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/wq.c   | 48 +++++++++++++++++++
 .../testing/selftests/bpf/progs/wq_failures.c | 23 +++++++++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 99e438fe12ac..13c124fff365 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Benjamin Tissoires */
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include "wq.skel.h"
 #include "wq_failures.skel.h"
 
+static void test_failure_map_no_btf(void);
+
 void serial_test_wq(void)
 {
 	struct wq *wq_skel = NULL;
@@ -11,6 +14,9 @@ void serial_test_wq(void)
 
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
 
+	if (test__start_subtest("test_failure_map_no_btf"))
+		test_failure_map_no_btf();
+
 	RUN_TESTS(wq);
 
 	/* re-run the success test to check if the timer was actually executed */
@@ -38,3 +44,45 @@ void serial_test_failures_wq(void)
 {
 	RUN_TESTS(wq_failures);
 }
+
+static void test_failure_map_no_btf(void)
+{
+	char log[8192];
+	struct btf *vmlinux_btf = libbpf_find_kernel_btf();
+	int kfunc_id = btf__find_by_name_kind(vmlinux_btf, "bpf_wq_init", BTF_KIND_FUNC);
+	int map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "map_no_btf", sizeof(__u32), sizeof(__u64),
+				    100, NULL);
+	struct bpf_insn prog[] = {
+		/* key = 42 on stack at [fp-4] */
+		BPF_MOV64_IMM(BPF_REG_0, 42), /* r0 = 42 */
+		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp-4) = 42 */
+
+		/* r1 = &map (patched from map_fd), r2 = &key */
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd), /* r1 = map */
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10), /* r2 = fp */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp-4 (key addr) */
+
+		/* map_val = bpf_map_lookup_elem(map, &key) */
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem), /* r0 = map_val or NULL */
+
+		/* if (!map_val) goto out; */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4), /* if (r0 == NULL) skip next 4 insns */
+
+		/* wq = (void *)(map_val + 0);  -> use r0 as arg1 directly */
+		BPF_MOV64_REG(BPF_REG_1, BPF_REG_0), /* r1 = wq (= val ptr) */
+
+		/* bpf_wq_init(wq, &map, 0) */
+		BPF_LD_MAP_FD(BPF_REG_2, map_fd), /* r2 = map */
+		BPF_MOV64_IMM(BPF_REG_3, 0), /* r3 = flags (0) */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0,
+			     kfunc_id), /* r0 = bpf_wq_init(wq, &map, 0) */
+		BPF_EXIT_INSN(), /* return -3 */
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .log_size = sizeof(log), .log_buf = log,
+		    .log_level = 2);
+	int r = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", prog, ARRAY_SIZE(prog), &opts);
+
+	ASSERT_NEQ(r, 0, "prog load failed");
+	ASSERT_HAS_SUBSTR(log, "map 'map_no_btf' has to have BTF in order to use bpf_wq",
+			  "log complains no map BTF");
+}
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 4240211a1900..d06f6d40594a 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -142,3 +142,26 @@ long test_wrong_wq_pointer_offset(void *ctx)
 
 	return -22;
 }
+
+SEC("tc")
+__log_level(2)
+__failure
+__msg(": (85) call bpf_wq_init#")
+__msg("R1 doesn't have constant offset. bpf_wq has to be at the constant offset")
+long test_bad_wq_off(void *ctx)
+{
+	struct elem *val;
+	struct bpf_wq *wq;
+	int key = 42;
+	u64 unknown;
+
+	val = bpf_map_lookup_elem(&array, &key);
+	if (!val)
+		return -2;
+
+	unknown = bpf_get_prandom_u32();
+	wq = &val->w + unknown;
+	if (bpf_wq_init(wq, &array, 0) != 0)
+		return -3;
+	return 0;
+}
-- 
2.51.0


