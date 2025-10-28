Return-Path: <bpf+bounces-72538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10166C15219
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46E0461013
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC3335BAC;
	Tue, 28 Oct 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC7LnhKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF35335085
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660915; cv=none; b=k9ZtjdOyDT+YZTO/YqXbxZbx4hKUa/SGVc4vaJrCQq6K5eFXthM+Vj/4sL1tdj2Pfm53xqv1EtyDWLMmaaobDzxDPRdRp8fNiym1l0fvzKRya5bbm9qtuwGYQX/YoB6/RdJafPGKtN7b56gLwXp6xZnuN8Sn9BOLk8QazwGgfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660915; c=relaxed/simple;
	bh=jlh96jab4Aod/oCjZNOi2tAQgov/Ge8ISscAgnZScHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Scj4kB2dJYTqi1RBDP/DqAqppZW+FmzdgRedQTTaWn1tO7vpnkwFjUO+yxiwWKfd6zXcxGy/xXR+O22g1cXBcMRXc74dBQH807b8Z73ZHhPB2KAwiHvW5H4DgBMHWoq8K/7MPiN2BND3YTxgS+sN+NMnuSOnidqoLrbPVdlBl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC7LnhKi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4270a3464bcso4653024f8f.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660911; x=1762265711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeLDLKKCljBi6oUMJPHoCrmpzmYoTKQ5hnKMdfJiDdc=;
        b=mC7LnhKiSAbCZK6qrqk4hWMVZ7IX7OtDT2O11uTmQYgF7Y2rKxf+OO7fnLR7Dhi5+v
         I3/iRezz5UAdWdAMbUS/pabnMNipttqHzSEHXu5o/8KNe4V0oGvGrZeqjjWvZcXZNPqG
         lufhkHCLmN3GlL2/kMrXgaon9UfuihBMCe8QzGb+28x3tYs/sJdzeq0zXM0J+QOMHYwO
         T8BMtR0+U4w99++WQd20ID8WUAP0F2QI2RF7grChBvhYImKIHSA7IM4tHK4VbveWjj20
         4moku3EhvgieKTT6He0p31ryl7cbhKjM/2dlyY87i0tFBKI9GMwgknUCygsRKrtGevrF
         GaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660911; x=1762265711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeLDLKKCljBi6oUMJPHoCrmpzmYoTKQ5hnKMdfJiDdc=;
        b=BCkvucenXZQiNC61H1KGepIKYtVyOas1cdwvMZWPha+KLdo1n5XZffUubmZuyO8asy
         aNWniCb9hgCU/KgO0YO0KfzcEvaizsxsRXWRtok2+XZbxeUR1Ps0SSg0fKq7bI2tN2lv
         MLnbFMXK0LNlEQKAK+3Svr+5tWUhnux1nTE+sYon2jw4PcWnvy3bELGMXfGOOaq4Z0Hd
         EumkfP+PBhmBRu8ud75b9REy2m3SosmTKusP/vjw5iIgP3Ju6gtDfl2J8OSTMxRaLln0
         6gRXXyWbV6CiYZVVW7kNQ/XiD09r9ew49a1x7+vz9649SQldrf1yYY/0hoE6YVTEYIU4
         mMGA==
X-Gm-Message-State: AOJu0Yw1rOQyeYjXc3F2w28OPcSm5MG0w8y9C6ZivjUesO72uFuRvSDF
	8u827t2Pe0Os1zL4OU5rhbj9O2TTEBfCoJgSCBFrnGTOaLQp/CnmuPcRFOLWpQ==
X-Gm-Gg: ASbGncuca25mEBD5cS75QnS+WXS+VszMqu1RXyBliZnbObt2O4JOkLOmH7n/NcgMpGg
	MiZ8Bv/R47Bb8tQxOGEqU2zHjZay4yrSqf4zaHauyHn6qU66NhaF/8Q2ZZa3XN3BPWDhEEiZZGw
	QlPFKTLAI3K9whJX/8mLGqJ5zIUzsgcZBqd58joKqgaC0v/C08S2MoSje51cVquZEtvm1/t5srr
	otSs1Dl8Q8xw8CiOgxomNYsjiIalO+AGISFuFf56JQEK7rAlx8ciXzarSFlC6W66kwE2PN/74/H
	Ddu7CHNNKg5lEPdmuiykSa6YGzUra4QRxviUkrAZN1WXq4U93uXQ7+BlslErPTM/uMGUX8eiElV
	7Le+z8Zt617mI4o0E4WnDrF8bZ8MKqwCcC62VIQ9CqAu+6/EL/D1UEhzD9uGMZj0+UlAm3R0VxG
	v/caxOf6aUoIq00bPN9Jw=
X-Google-Smtp-Source: AGHT+IE0Qt9pY16I7rEQSLKIOdXYJAvBSnoQ9U+Ji0QcORQy9mK022J43RzupwJ7zwlZB8Qf+g6r/g==
X-Received: by 2002:a05:6000:144d:b0:3f9:bc33:2fab with SMTP id ffacd0b85a97d-429a7e86d73mr3435404f8f.60.1761660911260;
        Tue, 28 Oct 2025 07:15:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:10 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 02/11] selftests/bpf: add selftests for new insn_array map
Date: Tue, 28 Oct 2025 14:20:40 +0000
Message-Id: <20251028142049.1324520-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 409 ++++++++++++++++++
 1 file changed, 409 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
new file mode 100644
index 000000000000..96ee9c9984f1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf/bpf.h>
+#include <test_progs.h>
+
+#ifdef __x86_64__
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
+static void __check_success(struct bpf_insn *insns, __u32 insn_cnt, __u32 *map_in, __u32 *map_out)
+{
+	struct bpf_insn_array_value val = {};
+	int prog_fd = -1, map_fd, i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, insn_cnt);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < insn_cnt; i++) {
+		val.orig_off = map_in[i];
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = prog_load(insns, insn_cnt, &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < insn_cnt; i++) {
+		char buf[64];
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		snprintf(buf, sizeof(buf), "val.xlated_off should be equal map_out[%d]", i);
+		ASSERT_EQ(val.xlated_off, map_out[i], buf);
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
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
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, 1, 2, 3, 4, 5};
+
+	__check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
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
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, 1, 4, 5, 8, 9};
+
+	__check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
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
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, -1, 1, -1, 2, 3};
+
+	__check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
+}
+
+/*
+ * Same test as check_deletions, but also add code which adds instructions
+ */
+static void check_deletions_with_functions(void)
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
+	__u32 map_in[] =  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9, 10};
+	__u32 map_out[] = {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9, 10};
+
+	__check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
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
+	val.orig_off = ARRAY_SIZE(insns); /* too big */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
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
+	val.orig_off = 1; /* middle of 16-byte instruction */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
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
+/* Once map was initialized, it should be frozen */
+static void check_load_unfrozen_map(void)
+{
+	struct bpf_insn insns[] = {
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
+		val.orig_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)"))
+		goto cleanup;
+
+	/* correctness: now freeze the map, the program should load fine */
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
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
+		val.orig_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
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
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
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
+static void __test_bpf_insn_array(void)
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
+	if (test__start_subtest("deletions-with-functions"))
+		check_deletions_with_functions();
+
+	/* Check all kinds of operations and related restrictions */
+
+	if (test__start_subtest("incorrect-index"))
+		check_incorrect_index();
+
+	if (test__start_subtest("load-unfrozen-map"))
+		check_load_unfrozen_map();
+
+	if (test__start_subtest("no-map-reuse"))
+		check_no_map_reuse();
+
+	if (test__start_subtest("bpf-side-ops"))
+		check_bpf_side();
+}
+#else
+static void __test_bpf_insn_array(void)
+{
+	test__skip();
+}
+#endif
+
+void test_bpf_insn_array(void)
+{
+	__test_bpf_insn_array();
+}
-- 
2.34.1


