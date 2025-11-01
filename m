Return-Path: <bpf+bounces-73227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236BAC27C49
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE1C3BC504
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999B2F1FD7;
	Sat,  1 Nov 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moR8kLTA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92F2F1FC5
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994869; cv=none; b=ZBxHyXpo4CWWMvnHKS84phpyOLooGVlOw5d7f+n+TfqLw4BY6nk4OIGAq1TRNizemNGsR07uwvisldep2gfzuQmZyCnHwmUFeg5TniZG4QD1/FmZbIudjiJEwmChr2pUeSU5GQxaE8Ow9v0CQiuutDG3CTKVqV0/7axi81eqe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994869; c=relaxed/simple;
	bh=jlh96jab4Aod/oCjZNOi2tAQgov/Ge8ISscAgnZScHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFGDcMP4AJv/fdvSx6FVLiANjzMcCdl9liMpZ0YIPgKOwaNT0Zykaclk10yO8jvgehfK2b75rD5zrLuXqD4ZlcDrakS58EKx8PaHxickSoxynZnj4Dwfep8xBJqaZYspOvxDZB6GVmp1m5zhQdWZkNhsDHKUIIVI2iM+MKfE9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moR8kLTA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so16483185e9.3
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994865; x=1762599665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeLDLKKCljBi6oUMJPHoCrmpzmYoTKQ5hnKMdfJiDdc=;
        b=moR8kLTAVetE5CmJlL5Gvw/tX6YFGf7ukzhopK3yreZ4Ga7Vjt+pffwZx3gL2TZbbJ
         zGGmHmzesrEewIlv+LAY0U2pW5u2FXfwtlIw3HljyzLuUnOcgrzUU/dZHGLVhKyO1Ieg
         pfelWlOOfyjFyPwu/HNrluPv/3HoiOM16GAmdoQ3aZZsZdW/JbbBJBdX//SCKSYO0ukS
         ZkrjmYQdIEviDobNVcpIwEsv8ZtUyxyRkPeP6S4ZuKEc6A8OqIZyK6yYhT8on7/7SRFu
         1rRtIACIEmrul3hKnTIaBI3488L8+48cSrV8CrJ0rRFepHXnO81A2UmbcICdGpODSuRi
         7/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994865; x=1762599665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeLDLKKCljBi6oUMJPHoCrmpzmYoTKQ5hnKMdfJiDdc=;
        b=iiDMl0R+iCgmrQwXiUUOQbXTUR+WTm0qUG5iQOutk+bKkq57gS2I8CouzpkVksODG2
         vg7Bp7CCET/aG7gbXHktn/AaqKVAIYtnEjbgdi/ZlrUcnACp3G//NSj8BG2BrCcNEzLM
         vzOlGNOS2xZN1Mc2a1tpO+4MCqqkxw595/hbpT20P3/6IY6ZXvx9/a9Lbbjonj8sZVwW
         44/+YaJsUgpPouJiIECKlyEXSrivqem2wVGQVdpFiheM9nHSJpIwzJRNiC8l6qLbWCWt
         N8vdqxCD5i7eUPkTu38D8BEla0Jt+pFcUk5Y0rMGPjhOjg8GGLSCVIYssK/lgL96v3oL
         40xA==
X-Gm-Message-State: AOJu0YzpnEr2L6+AKRg+kDTdfKMyHO38ifsJfDd6IOuWHj3hTRPbnfiB
	FXYFoL4Aq3gHC+qPEsdHDbGQN9ZHbXgI9yH9Pm/b2garogmAhuXdehfH6VkYRQ==
X-Gm-Gg: ASbGncviJ9LOlV0XgOjbX2yyF7HWvvV38I1qGVPeEzwNBzODah4Rss/NPzeqZzDYVN/
	o7CgfWP4no0UKU8pA1UGDTdqYsKVk/ByWGlHtwECipH2zuZ/Ao5JCPvHsZIECY7yUr4xuBnw5OH
	xlgyWEO8HBFqKTDuSHukhT8hB33t5+t5dhsJcd8Ov4WHo9RtbacrxuryVVJdjbOkDSU8Rv+PjIo
	l1YBXIaXEGfGlhwttmtQXOCD1xIiJlqtU/w+xJHB++4g8U48wZB0RpyNJwMIhGh7/JNzAgrucYt
	Z07mraqmGa3c3dUHrCJLwi/tD7kokurCKnL6+9w9Z6DZkuHdDEOxoOB3VHam9FCNliAhuv9fVAB
	5c3XPaxooqMd1FjZolR/woqVpVOhGZYKAhTeXnH0qELfZW3VycKgos79MpV3Q9BfJuVBBb8Hwy5
	ii6agQHYKZimd4Gt+VGahY5e/kNvzqkA==
X-Google-Smtp-Source: AGHT+IEfPJo3z/qWlqqqqCjbjtEgpKvoY3VzHWxfJptPEW4YqSGqu3uWu/U0wurXGpL/MaMnmwqG/g==
X-Received: by 2002:a05:600c:4710:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-477308a8972mr54843905e9.40.1761994864178;
        Sat, 01 Nov 2025 04:01:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:03 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 02/11] selftests/bpf: add selftests for new insn_array map
Date: Sat,  1 Nov 2025 11:07:08 +0000
Message-Id: <20251101110717.2860949-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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


