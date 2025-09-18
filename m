Return-Path: <bpf+bounces-68755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F152B83CFC
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A28179869
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2672E0406;
	Thu, 18 Sep 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/wI1z5T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372D2D662D
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187966; cv=none; b=SCYVCG+lhBR//2w7X3OuV/C170l2sVFHL0EnSCLPmKFtlnsvLh3AeMSF0t9B0NhVdMVyyOdzZKgYXjsp/DTQ+Hbx5oVGs9n4qczerrsybBvpidrBb0PAydjhFUWS+UZUmvtRaPf3KqPbdFWBJcxcNvA7l00KLuGkcI+e0MnIjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187966; c=relaxed/simple;
	bh=RMRe0lD/KGZ/oCWCO5ZXAzWE8D81BNYFxqk2E769vT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9QeRhiai8qzlBPoP347ponexmJUoRML4TzV0bhyyVMsUTXzYNOtTqfSkx9TJ2ZO3CoBzD7/fSiS2iJ98gtBbBeWC2qaz3er1hs5vRBwAs12BSM9YV2tiMW/AKaui7G0lAI1bDcwu1e5oy6Ntx/8vVCCJ0I6hK07ojpFARoDwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/wI1z5T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dec026c78so6443475e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187962; x=1758792762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RoLHrgowWHdJ8wF3FW+pVWzKpom2uyKbwKZiSHlWAc=;
        b=M/wI1z5TECYSfFayXaYQDNz4r7iAFMd4Z2ngmD8zLjP4hDZ56Mn1cnMA3+7PNmUkKD
         lRMR/czRuzLgP8iYYpWvU2paLlxPgtrHtU/Ri45phOhjB278zUQqjmD+vwasmM+RhLLJ
         7FndjON+dJVcmvf3lGlFir7W0wx58e7+oaz6LreaB8sjcYPeBRYAy9Q5PctnARwqa1wO
         POEwrAXzjfEfdhRhcDod3wrQyJ5zbasXEkX2MiQ0jZcazm9pUXwV5ufjoX5mqS6midvu
         GJOTsuF5GdAvapv1yjxw008c2ibpZf4Z/4MOLsK/BlDJ8ZQ2lo+8Weq24W9Lza3qFpsd
         bF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187962; x=1758792762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RoLHrgowWHdJ8wF3FW+pVWzKpom2uyKbwKZiSHlWAc=;
        b=BGtNJTlN1zbpM7rpbRMT0L+gJemFCrSzMld5f2baJYDZsflO4YKVkf1e/5XbJkVmfv
         sh89szprAqhgV6cA0uQin+kjqAOUUmjqbnMJYC2VB/gwrjR7L48J8wbnWFhLr0WCq3Eo
         iEUilZ+Sc/ecJoa71sJnJimKCnFOJBwIG1SPnLweLjibgj4Dr+mpFlIm2YRwa7IIhzwM
         8ZAhZUb9VoIRq76iFo5OxsU6yLi88m/LalCxzDGZzE/SgC1BAbkEWKvP8+OnUDNLYQ8L
         1CMGD3wMLOwvPgpBQmAt4uXl4wNUX6UT3zIS01P9rUWUOKjsSsMKmBP61eN9IVksiaq3
         YnDg==
X-Gm-Message-State: AOJu0YwLA7KV87rTosbkpf2ep7BYJ0xKsYcSUBPxOFCwksvPl0B7EWBp
	br3Q99bc2r+vgTKkePll6YaeF8a2w2+R+5zMaARu4PM0WCoCWrpX+BhBtX/HiA==
X-Gm-Gg: ASbGnctpUMIHbUCRspKeFFQw+0l7lu44D/0eU/ru3MV5owQPXYFSFSgiC9DnFe+DLqn
	T2xQkQra90hdmdzJ6Iq8yXM4N8VM7m0SEBKpuqwYbiH5YH48/7XvXBvWAqtxWV7n7B+IfQQYiN2
	7oFt+q+UAsntENaxxGGOxay6Otv8BFumZ5IyPTRiVzfY+Fdj8moSNKHg+/RK9zgAXprXTMSJGj0
	6PfjcUbpoG44P+hWgEDYLMfki3AF6QC/OwhbmIfxGU3MJQCrMY3ABmy470yRWOkpuEZEefrYULx
	twc+EvpnYDNY1auIBhExtXMm4fDqqQQIl8LA5TbdkblZfyyU9U9PHxiClHN9WeyBHXwLgYDwK+l
	YIZV5mdov2Wd45okXPW1ubBpy0I7POT7btnJfbcOSfr7DNUOO1V9y+CU03X4K
X-Google-Smtp-Source: AGHT+IEBW6icH3yExE9ucgR1pkIQ98o7UpleqkwUcWnzvE0NiQjiayZ7g+4pKaTRqEsq3OUiWfrOVQ==
X-Received: by 2002:a05:6000:3112:b0:3de:293c:9377 with SMTP id ffacd0b85a97d-3ecdfa43691mr4840004f8f.63.1758187962213;
        Thu, 18 Sep 2025 02:32:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:41 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 04/13] selftests/bpf: add selftests for new insn_array map
Date: Thu, 18 Sep 2025 09:38:41 +0000
Message-Id: <20250918093850.455051-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following selftests for new insn_array map:

  * Incorrect instruction indexes are rejected
  * Two programs can't use the same map
  * BPF progs can't operate the map
  * no changes to code => map is the same
  * expected changes when instructions are added
  * expected changes when instructions are deleted
  * expected changes when multiple functions are present

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 405 ++++++++++++++++++
 1 file changed, 405 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
new file mode 100644
index 000000000000..f785132497d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf/bpf.h>
+#include <test_progs.h>
+
+static int map_create(__u32 map_type, __u32 max_entries)
+{
+	const char *map_name = "insn_array";
+	__u32 key_size = 4;
+	__u32 value_size = sizeof(struct bpf_insn_array_value);
+
+	return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
+}
+
+static int prog_load(struct bpf_insn *insns, __u32 insn_cnt, int *fd_array, __u32 fd_array_cnt)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+
+	opts.fd_array = fd_array;
+	opts.fd_array_cnt = fd_array_cnt;
+
+	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
+}
+
+/*
+ * Load a program, which will not be anyhow mangled by the verifier.  Add an
+ * insn_array map pointing to every instruction. Check that it hasn't changed
+ * after the program load.
+ */
+static void check_one_to_one_mapping(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	struct bpf_insn_array_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/*
+ * Try to load a program with a map which points to outside of the program
+ */
+static void check_out_of_bounds_index(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	struct bpf_insn_array_value val = {};
+	int key;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	key = 0;
+	val.xlated_off = ARRAY_SIZE(insns); /* too big */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)")) {
+		close(prog_fd);
+		goto cleanup;
+	}
+
+cleanup:
+	close(map_fd);
+}
+
+/*
+ * Try to load a program with a map which points to the middle of 16-bit insn
+ */
+static void check_mid_insn_index(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64(BPF_REG_0, 0), /* 2 x 8 */
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	struct bpf_insn_array_value val = {};
+	int key;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	key = 0;
+	val.xlated_off = 1; /* middle of 16-byte instruction */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)")) {
+		close(prog_fd);
+		goto cleanup;
+	}
+
+cleanup:
+	close(map_fd);
+}
+
+static void check_incorrect_index(void)
+{
+	check_out_of_bounds_index();
+	check_mid_insn_index();
+}
+
+/*
+ * Load a program with two patches (get jiffies, for simplicity). Add an
+ * insn_array map pointing to every instruction. Check how it was changed
+ * after the program load.
+ */
+static void check_simple(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, 1, 4, 5, 8, 9};
+	struct bpf_insn_array_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/*
+ * Verifier can delete code in two cases: nops & dead code. From insn
+ * array's point of view, the two cases are the same, so test using
+ * the simplest method: by loading some nops
+ */
+static void check_deletions(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, -1, 1, -1, 2, 3};
+	struct bpf_insn_array_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_with_functions(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	__u32 map_in[] =  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9, 10};
+	__u32 map_out[] = {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9, 10};
+	struct bpf_insn_array_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/* Map can be used only by one BPF program */
+static void check_no_map_reuse(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd, extra_fd = -1;
+	struct bpf_insn_array_value val = {};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
+	}
+
+	errno = 0;
+	extra_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(extra_fd, -EBUSY, "program should have been rejected (extra_fd != -EBUSY)"))
+		goto cleanup;
+
+	/* correctness: check that prog is still loadable without fd_array */
+	extra_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
+		goto cleanup;
+
+cleanup:
+	close(extra_fd);
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_bpf_no_lookup(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, 0),
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	insns[0].imm = map_fd;
+
+	errno = 0;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)"))
+		goto cleanup;
+
+	/* correctness: check that prog is still loadable with normal map */
+	close(map_fd);
+	map_fd = map_create(BPF_MAP_TYPE_ARRAY, 1);
+	insns[0].imm = map_fd;
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_bpf_side(void)
+{
+	check_bpf_no_lookup();
+}
+
+void test_bpf_insn_array(void)
+{
+	/* Test if offsets are adjusted properly */
+
+	if (test__start_subtest("one2one"))
+		check_one_to_one_mapping();
+
+	if (test__start_subtest("simple"))
+		check_simple();
+
+	if (test__start_subtest("deletions"))
+		check_deletions();
+
+	if (test__start_subtest("multiple-functions"))
+		check_with_functions();
+
+	/* Check all kinds of operations and related restrictions */
+
+	if (test__start_subtest("incorrect-index"))
+		check_incorrect_index();
+
+	if (test__start_subtest("no-map-reuse"))
+		check_no_map_reuse();
+
+	if (test__start_subtest("bpf-side-ops"))
+		check_bpf_side();
+}
-- 
2.34.1


