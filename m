Return-Path: <bpf+bounces-54313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B487A67660
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D753B3484
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05B20E313;
	Tue, 18 Mar 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="fbVsDIIy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE046426
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308194; cv=none; b=AJt9AoIO2zYHTV1Se74ZvhTdXRiiEIDUVSlBcKGg3QNUARLuK1ZkYZ435V+6i6ZzTNOuGM3OjO2w0+ebRwgRVznRcq+pj82bFmXiCu4oicDzTM879LWERhnnYHR/290F4t5ePoZoWHwBQVyW5q4l+LFPsW/iiPa3s2oVO5HWyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308194; c=relaxed/simple;
	bh=4eTrUINBYRpc7KJSUKfr8lB9LwvO1MpFKZJu4VvxrdI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRacHeJTOap6fW3SfnOx4Kd9HuK5BluUcuJefAptDBLoL34Gt++wpbmQiTGi2AEWUxjxXXoJufd2DZgBe+KDeWEIIp8z+zJOAfR5AlnvfSfnMWRLCN3HEZx01ZdQ5T29xYnYCCezCP5UgsvNW3j229MhDmK6wJ9Q3T6M9OxI5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=fbVsDIIy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948021a45so34003525e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308189; x=1742912989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qz2mTia/LqdSzYi68dMF7GBnw5h//CT5sjru8mhRUzc=;
        b=fbVsDIIyYt/qWK2suFeA+ocsMDhdRJPbCC+ahr1IuMIHqNgGenmZ6W1xIQxRG1hikD
         E/YAB1I/juY01qkdZOdAe7/dYDj0R0PLPxLskZtwYy/jxYVGRcKhbx/hMUM/7sjHjubl
         FJtqsgIWrTlKPkGT7FhkIk7Vrj2SidGru0eYDcUimb/dz9JhZtW2UaZW5G/XAZ05/Au1
         qrVOoX9F9Bi5TuxHrMmPCi9XH7+PL+58NWam9/60Y1jUn+4pQ0/Q1YLvVpv5x8e3wIko
         FF23Py06XxIuO2r7hKc1b+vvrjGYvE6ZN6N2fX4J5n4Q6NPHPhcQ9oKNh9SFtMLYXb2M
         tPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308189; x=1742912989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz2mTia/LqdSzYi68dMF7GBnw5h//CT5sjru8mhRUzc=;
        b=qtjJOlHA1R6DffTHJU0ns2WJ9I2OY5ItVItSWKGyU1q4dl/HHvM/7V8qdnE0qJhrVn
         Yn9ScZWFxTXlWULqaG2OkBSiSpWT4NIzKSNUulu3ktmOya5h54/DCjCLPSBYvLNVMKJk
         CgQ5fFrgAUopecwzsOXpWXCR1O0Ir2aSKd1umBYCwO9ekEcHQrykSq+QJS05GQ4JhN67
         o1IQ0OMjvAh0f/yePpjDOf/iKnnamj5lLr5dvw2PMaOy0qQy629IMM8YnEk+H05mPcOd
         w16yqEI7Wz6dwbB+8jVyFSDJsyKeMmVCxZEXSDQZc1E3w3bzOtXiut9UkeHdiAhKa2Rb
         cdZw==
X-Gm-Message-State: AOJu0YwQOVf6X6Em4vvTI2iUwaBSEh5uJwZDto9LrPqgxsD3A7E/AzQu
	CCTfoLeQirE+9+1pllYwAghCfmvRoQZWEq5JIQC7AFNDMcLJyA8qr75Hf4BMwZWxHaV5FTk+EGt
	T
X-Gm-Gg: ASbGnctphZEjn95duHf5AWPE6t+9pA2y+JT8ZKEo9nDqUHMvbeaYhyWWH86HydRnOIq
	MmEuH9J2JxJ+7wmGicla3b7/mSi/RiS5ZbJaMxa+Y5BDlE5vMp2cEY8lLBzsHxQdCsS5mTQVmb8
	DXA5YQvOdpyMymqu903ECWPNIBdZSp6I148pTIB7TR/nckBaZvY9RWwda2WPtxARAbEdo1UG912
	P93kiVpqcFAoHLzr368wZ0F8jVQWvBSy1G0FCaRYtn+XfNgbtwijZPpD/4X1K0jpf8QcSWxGLUu
	Xei+XcBB/pd23oars4ZG3aUs3jEZMi2BVj7oklCgP/SwM2ioVYu2PKUouA==
X-Google-Smtp-Source: AGHT+IFaaWt2I0CD7CdJJ1MGqmpm77dD+k+YNttJh9jReNdrj/O+XGplTeMseK7LuUPvtDfzevjCRw==
X-Received: by 2002:a5d:598c:0:b0:391:1473:336a with SMTP id ffacd0b85a97d-3971f4119f0mr16952057f8f.36.1742308188968;
        Tue, 18 Mar 2025 07:29:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:48 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 03/14] selftests/bpf: add selftests for new insn_set map
Date: Tue, 18 Mar 2025 14:33:07 +0000
Message-Id: <20250318143318.656785-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests are split in two parts.

The `bpf_insn_set_ops` test checks that the map is managed properly:

  * Incorrect instruction indexes are rejected
  * Non-sorted and non-unique indexes are rejected
  * Unfrozen maps are not accepted
  * Two programs can't use the same map
  * BPF progs can't operate the map

The `bpf_insn_set_reloc` part validates, as best as it can do it from user
space, that instructions are relocated properly:

  * no relocations => map is the same
  * expected relocations when instructions are added
  * expected relocations when instructions are deleted
  * expected relocations when multiple functions are present

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_set.c   | 639 ++++++++++++++++++
 1 file changed, 639 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
new file mode 100644
index 000000000000..796980bd4fcb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_set.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf/bpf.h>
+#include <test_progs.h>
+
+static inline int map_create(__u32 map_type, __u32 max_entries)
+{
+	const char *map_name = "insn_set";
+	__u32 key_size = 4;
+	__u32 value_size = 4;
+
+	return bpf_map_create(map_type, map_name, key_size, value_size, max_entries, NULL);
+}
+
+/*
+ * Load a program, which will not be anyhow mangled by the verifier.  Add an
+ * insn_set map pointing to every instruction. Check that it hasn't changed
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
+	int prog_fd, map_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &i, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		return;
+
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		__u32 val;
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val, i, "val should be equal i");
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
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int key, val;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	key = 0;
+	val = ARRAY_SIZE(insns); /* too big */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(prog_fd, -1, "program should have been rejected (prog_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EINVAL, "program should have been rejected (errno != EINVAL)"))
+		goto cleanup;
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
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int key, val;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	key = 0;
+	val = 1; /* middle of 16-byte instruction */
+	if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &key, &val, 0), 0, "bpf_map_update_elem"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(prog_fd, -1, "program should have been rejected (prog_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EINVAL, "program should have been rejected (errno != EINVAL)"))
+		goto cleanup;
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
+static void check_not_sorted(void)
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
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int i, val;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val = ARRAY_SIZE(insns) - i - 1; /* reverse indexes */
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(prog_fd, -1, "program should have been rejected (prog_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EINVAL, "program should have been rejected (errno != EINVAL)"))
+		goto cleanup;
+
+cleanup:
+	close(map_fd);
+}
+
+static void check_not_unique(void)
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
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int i, val;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val = 1;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	errno = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(prog_fd, -1, "program should have been rejected (prog_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EINVAL, "program should have been rejected (errno != EINVAL)"))
+		goto cleanup;
+
+cleanup:
+	close(map_fd);
+}
+
+static void check_not_sorted_or_unique(void)
+{
+	check_not_sorted();
+	check_not_unique();
+}
+
+/*
+ * Load a program with two patches (get jiffies, for simplicity). Add an
+ * insn_set map pointing to every instruction. Check how it was relocated
+ * after the program load.
+ */
+static void check_relocate_simple(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_jiffies64),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, 1, 4, 5, 8, 9};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &map_in[i], 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		return;
+
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		__u32 val;
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/*
+ * Verifier can delete code in two cases: nops & dead code. From the relocation
+ * point of view, the two cases look the same, so test using the simplest
+ * method: by loading some nops
+ */
+static void check_relocate_deletions(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 0), /* nop */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	__u32 map_in[] = {0, 1, 2, 3, 4, 5};
+	__u32 map_out[] = {0, -1, 1, -1, 2, 3};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &map_in[i], 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		return;
+
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		__u32 val;
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+static void check_relocate_with_functions(void)
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
+	int prog_fd, map_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	__u32 map_in[] =  { 0, 1,  2, 3, 4, 5, /* func */  6, 7,  8, 9, 10};
+	__u32 map_out[] = {-1, 0, -1, 3, 4, 5, /* func */ -1, 6, -1, 9, 10};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &map_in[i], 0), 0,
+			       "bpf_map_update_elem"))
+			goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
+
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		__u32 val;
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val, map_out[i], "val should be equal map_out[i]");
+	}
+
+cleanup:
+	close(prog_fd);
+	close(map_fd);
+}
+
+/* Once map was initialized, it should be frozen */
+static void check_load_unfrozen_map(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, map_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &i, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+
+	errno = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(prog_fd, -1, "program should have been rejected (prog_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EINVAL, "program should have been rejected (errno != EINVAL)"))
+		goto cleanup;
+
+	/* cirrectness: now freeze the map, the program should load fine */
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		return;
+
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		__u32 val;
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val, i, "val should be equal i");
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
+	int prog_fd, map_fd, extra_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(&map_fd),
+		.fd_array_cnt = 1,
+	};
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &i, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		return;
+
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		__u32 val;
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		ASSERT_EQ(val, i, "val should be equal i");
+	}
+
+	errno = 0;
+	extra_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(extra_fd, -1, "program should have been rejected (extra_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EBUSY, "program should have been rejected (errno != EBUSY)"))
+		goto cleanup;
+
+	/* correctness: check that prog is still loadable without fd_array */
+	attr.fd_array_cnt = 0;
+	extra_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
+		goto cleanup;
+	close(extra_fd);
+
+cleanup:
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
+	int prog_fd, map_fd;
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+	};
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_SET, 1);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	/* otherwise will be rejected as unfrozen */
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		return;
+
+	insns[0].imm = map_fd;
+
+	errno = 0;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+	if (!ASSERT_EQ(prog_fd, -1, "program should have been rejected (prog_fd != -1)"))
+		goto cleanup;
+	if (!ASSERT_EQ(errno, EINVAL, "program should have been rejected (errno != EINVAL)"))
+		goto cleanup;
+
+	/* correctness: check that prog is still loadable with normal map */
+	close(map_fd);
+	map_fd = map_create(BPF_MAP_TYPE_ARRAY, 1);
+	insns[0].imm = map_fd;
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
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
+/* Test how relocations work */
+void test_bpf_insn_set_reloc(void)
+{
+	if (test__start_subtest("one2one"))
+		check_one_to_one_mapping();
+
+	if (test__start_subtest("relocate-simple"))
+		check_relocate_simple();
+
+	if (test__start_subtest("relocate-deletions"))
+		check_relocate_deletions();
+
+	if (test__start_subtest("relocate-multiple-functions"))
+		check_relocate_with_functions();
+}
+
+/* Check all kinds of operations and related restrictions */
+void test_bpf_insn_set_ops(void)
+{
+	if (test__start_subtest("incorrect-index"))
+		check_incorrect_index();
+
+	if (test__start_subtest("not-sorted-or-unique"))
+		check_not_sorted_or_unique();
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
-- 
2.34.1


