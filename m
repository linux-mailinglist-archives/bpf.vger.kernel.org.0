Return-Path: <bpf+bounces-45161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD6F9D2327
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F891B22879
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BD1C2457;
	Tue, 19 Nov 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="IDDkuMT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16821C2334
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011198; cv=none; b=ShQpUg67nOQwPni1332QkwPKTCrIoH07FkX4r9d11V+nFFHpKPQp3dXQaoVaM2K3K4Wl9jdyRLq0P0UQ1wC7orFFpDMj8KnMfvzd/RTxEZ7rIXJankE2W4y5JC/placpz/CVwhp1j+hSXw6qp9hHfzV55cjg6VBJlJLUIlZOsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011198; c=relaxed/simple;
	bh=f8Av85VxaQvBl1rqr9M+ANEaYhHy8kFBZs4/XpxHRZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jy2f6O1bTKjMpxaoWZViaLlJYfJEmN5Hw6oXCtSixBPb3EIL4TheTx/33Wdfi+oiSJlsR0GyXWiKu1TqmYaBYZwnknrqEuv29nWZ9ZYlIWkscvQdndzs0gz7R2AZgo1beXenfNUCwsL6aRZpFV2zJ+w9qYXh1spkGbK/pTJpMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=IDDkuMT/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so123440366b.3
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 02:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732011195; x=1732615995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgM7y3e/xxOAPYuVfF9TjNfA1P98tNQ2LygYI7XstEM=;
        b=IDDkuMT/KyqK7LyLCpeHFk0+c82vh941YfABCa+tVLlIlLsPGdfFI1aQ+y+r3VhoUQ
         Kw2+NatmRbzhsTALex0+2HGabhbABVy4cKQUIIKWxgtEHN5XyjsJngrenJ/yi2I4QdTS
         K0nQJxA2PyF2L4ZjBC5aqdryr3DSQmazDEPMxhGn8t4nlIqK/toRu9SWb7ZtbyRZGuJy
         c+4CY9rtk5pWkKCmMT6F8QKOdiA3KBybzuDZFWs+VgGnJNvoLQGs0VRitsqgjOAm9hRJ
         4AJvA695sEC2xgfomAb+v94YhMNNTB4vPySu6ejb+pIR5TbnZlIqDk2yCnnFFHmXHHGV
         0yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011195; x=1732615995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgM7y3e/xxOAPYuVfF9TjNfA1P98tNQ2LygYI7XstEM=;
        b=TPceJRNM61/NiZELMGWsRMTJDXwColbGd0uZ8reD82r6NkJYwhkuq2BjL/5cWq2c7D
         qyFvI5bmtQff6TmW2iaz3tWJtl/kCCDyCmTsdVc5IXl9nMj8DZBjbdTopF9G8lbKDgmo
         uRypnGGjc0wYKKkoyCpsIzCAVQG2o9Par+fg2uYHdhO/wMeSpWWhp/wUUv1LDQHoMEjb
         X62Gb2/dyGh9Kc+WXGOXMQiryzPQU2HcuYYKAu5bgOzfe9NP0d1Cj0JSDOPAcM2/El6L
         KEdVfwNHX5+w4RBbinQmDYUFjaHdBj1RiMJmQXAjWIl2boBaA3Kfg0bxdvU5G6rcsu76
         6d4g==
X-Gm-Message-State: AOJu0Yw2sztnSauuE2jhtGf8nOb8Iw0FZk53UUmwAG/ZRSdlOJ+lKirs
	TfRMJEfryHKLmlD9amqOzdLjUpr3xgrjL4g+SXujtJI7kAXNGZsgtdOjOyvF+31z5e9B24UlQik
	d
X-Google-Smtp-Source: AGHT+IFN0/wm4Y52fdPmFxa6wvXzIgAwfSQIgiF1XhZFSLBhBR3GPr5VyqBYbIoOqlwZMVZh0XZyHg==
X-Received: by 2002:a17:906:c10a:b0:a99:5601:7dc1 with SMTP id a640c23a62f3a-aa483551fc8mr1440089866b.49.1732011194710;
        Tue, 19 Nov 2024 02:13:14 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7eee4sm629003066b.87.2024.11.19.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:13:13 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next 4/6] selftests/bpf: Add tests for fd_array_cnt
Date: Tue, 19 Nov 2024 10:15:50 +0000
Message-Id: <20241119101552.505650-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119101552.505650-1-aspsk@isovalent.com>
References: <20241119101552.505650-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new set of tests to test the new field in PROG_LOAD-related
part of bpf_attr: fd_array_cnt.

Add the following test cases:

  * fd_array_cnt/no-fd-array: program is loaded in a normal
    way, without any fd_array present

  * fd_array_cnt/fd-array-ok: pass two extra non-used maps,
    check that they're bound to the program

  * fd_array_cnt/fd-array-dup-input: pass a few extra maps,
    only two of which are unique

  * fd_array_cnt/fd-array-ref-maps-in-array: pass a map in
    fd_array which is also referenced from within the program

  * fd_array_cnt/fd-array-trash-input: pass array with some trash

  * fd_array_cnt/fd-array-with-holes: pass an array with holes (fd=0)

  * fd_array_cnt/fd-array-2big: pass too large array

All the tests above are using the bpf(2) syscall directly,
no libbpf involved.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../selftests/bpf/prog_tests/fd_array.c       | 381 ++++++++++++++++++
 1 file changed, 381 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
new file mode 100644
index 000000000000..1b47386e66c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include <linux/btf.h>
+#include <sys/syscall.h>
+#include <bpf/bpf.h>
+
+#include "../test_btf.h"
+
+static inline int _bpf_map_create(void)
+{
+	static union bpf_attr attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = 4,
+		.value_size = 8,
+		.max_entries = 1,
+	};
+
+	return syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+}
+
+static int _btf_create(void)
+{
+	struct btf_blob {
+		struct btf_header btf_hdr;
+		__u32 types[8];
+		__u32 str;
+	} raw_btf = {
+		.btf_hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct btf_blob, str) - offsetof(struct btf_blob, types),
+			.str_len = sizeof(raw_btf.str),
+		},
+		.types = {
+			/* long */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),  /* [1] */
+			/* unsigned long */
+			BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),  /* [2] */
+		},
+	};
+	static union bpf_attr attr = {
+		.btf_size = sizeof(raw_btf),
+	};
+
+	attr.btf = (long)&raw_btf;
+
+	return syscall(__NR_bpf, BPF_BTF_LOAD, &attr, sizeof(attr));
+}
+
+static bool map_exists(__u32 id)
+{
+	int fd;
+
+	fd = bpf_map_get_fd_by_id(id);
+	if (fd >= 0) {
+		close(fd);
+		return true;
+	}
+	return false;
+}
+
+static inline int bpf_prog_get_map_ids(int prog_fd, __u32 *nr_map_ids, __u32 *map_ids)
+{
+	__u32 len = sizeof(struct bpf_prog_info);
+	struct bpf_prog_info info = {
+		.nr_map_ids = *nr_map_ids,
+		.map_ids = ptr_to_u64(map_ids),
+	};
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		return -1;
+
+	*nr_map_ids = info.nr_map_ids;
+
+	return 0;
+}
+
+static int __load_test_prog(int map_fd, int *fd_array, int fd_array_cnt)
+{
+	/* A trivial program which uses one map */
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_XDP, /* we don't care */
+		.insns     = ptr_to_u64(insns),
+		.insn_cnt  = ARRAY_SIZE(insns),
+		.license   = ptr_to_u64("GPL"),
+		.fd_array = ptr_to_u64(fd_array),
+		.fd_array_cnt = fd_array_cnt,
+	};
+
+	return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+}
+
+static int load_test_prog(int *fd_array, int fd_array_cnt)
+{
+	int map_fd;
+	int ret;
+
+	map_fd = _bpf_map_create();
+	if (!ASSERT_GE(map_fd, 0, "_bpf_map_create"))
+		return map_fd;
+
+	ret = __load_test_prog(map_fd, fd_array, fd_array_cnt);
+	close(map_fd);
+
+	/* switch back to returning the actual value */
+	if (ret < 0)
+		return -errno;
+	return ret;
+}
+
+static bool check_expected_map_ids(int prog_fd, int expected, __u32 *map_ids, __u32 *nr_map_ids)
+{
+	int err;
+
+	err = bpf_prog_get_map_ids(prog_fd, nr_map_ids, map_ids);
+	if (!ASSERT_OK(err, "bpf_prog_get_map_ids"))
+		return false;
+	if (!ASSERT_EQ(*nr_map_ids, expected, "unexpected nr_map_ids"))
+		return false;
+
+	return true;
+}
+
+/*
+ * Load a program, which uses one map. No fd_array maps are present.
+ * On return only one map is expected to be bound to prog.
+ */
+static void check_fd_array_cnt__no_fd_array(void)
+{
+	__u32 map_ids[16];
+	__u32 nr_map_ids;
+	int prog_fd = -1;
+
+	prog_fd = load_test_prog(NULL, 0);
+	if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
+		return;
+	nr_map_ids = ARRAY_SIZE(map_ids);
+	check_expected_map_ids(prog_fd, 1, map_ids, &nr_map_ids);
+	close(prog_fd);
+}
+
+/*
+ * Load a program, which uses one map, and pass two extra, non-equal, maps in
+ * fd_array with fd_array_cnt=2. On return three maps are expected to be bound
+ * to the program.
+ */
+static void check_fd_array_cnt__fd_array_ok(void)
+{
+	int extra_fds[2] = { -1, -1 };
+	__u32 map_ids[16];
+	__u32 nr_map_ids;
+	int prog_fd = -1;
+
+	extra_fds[0] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
+		goto cleanup;
+	extra_fds[1] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[1], 0, "_bpf_map_create"))
+		goto cleanup;
+	prog_fd = load_test_prog(extra_fds, 2);
+	if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
+		goto cleanup;
+	nr_map_ids = ARRAY_SIZE(map_ids);
+	if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids))
+		goto cleanup;
+
+	/* maps should still exist when original file descriptors are closed */
+	close(extra_fds[0]);
+	close(extra_fds[1]);
+	if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map_ids[0] should exist"))
+		goto cleanup;
+	if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map_ids[1] should exist"))
+		goto cleanup;
+
+	/* some fds might be invalid, so ignore return codes */
+cleanup:
+	close(extra_fds[1]);
+	close(extra_fds[0]);
+	close(prog_fd);
+}
+
+/*
+ * Load a program with a few extra maps duplicated in the fd_array.
+ * After the load maps should only be referenced once.
+ */
+static void check_fd_array_cnt__duplicated_maps(void)
+{
+	int extra_fds[4] = { -1, -1, -1, -1 };
+	__u32 map_ids[16];
+	__u32 nr_map_ids;
+	int prog_fd = -1;
+
+	extra_fds[0] = extra_fds[2] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
+		goto cleanup;
+	extra_fds[1] = extra_fds[3] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[1], 0, "_bpf_map_create"))
+		goto cleanup;
+	prog_fd = load_test_prog(extra_fds, 4);
+	if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
+		goto cleanup;
+	nr_map_ids = ARRAY_SIZE(map_ids);
+	if (!check_expected_map_ids(prog_fd, 3, map_ids, &nr_map_ids))
+		goto cleanup;
+
+	/* maps should still exist when original file descriptors are closed */
+	close(extra_fds[0]);
+	close(extra_fds[1]);
+	if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map should exist"))
+		goto cleanup;
+	if (!ASSERT_EQ(map_exists(map_ids[1]), true, "map should exist"))
+		goto cleanup;
+
+	/* some fds might be invalid, so ignore return codes */
+cleanup:
+	close(extra_fds[1]);
+	close(extra_fds[0]);
+	close(prog_fd);
+}
+
+/*
+ * Check that if maps which are referenced by a program are
+ * passed in fd_array, then they will be referenced only once
+ */
+static void check_fd_array_cnt__referenced_maps_in_fd_array(void)
+{
+	int extra_fds[1] = { -1 };
+	__u32 map_ids[16];
+	__u32 nr_map_ids;
+	int prog_fd = -1;
+
+	extra_fds[0] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
+		goto cleanup;
+	prog_fd = __load_test_prog(extra_fds[0], extra_fds, 1);
+	if (!ASSERT_GE(prog_fd, 0, "BPF_PROG_LOAD"))
+		goto cleanup;
+	nr_map_ids = ARRAY_SIZE(map_ids);
+	if (!check_expected_map_ids(prog_fd, 1, map_ids, &nr_map_ids))
+		goto cleanup;
+
+	/* map should still exist when original file descriptor is closed */
+	close(extra_fds[0]);
+	if (!ASSERT_EQ(map_exists(map_ids[0]), true, "map should exist"))
+		goto cleanup;
+
+	/* some fds might be invalid, so ignore return codes */
+cleanup:
+	close(extra_fds[0]);
+	close(prog_fd);
+}
+
+/*
+ * Test that a program with trash in fd_array can't be loaded:
+ * only map and BTF file descriptors should be accepted.
+ */
+static void check_fd_array_cnt__fd_array_with_trash(void)
+{
+	int extra_fds[3] = { -1, -1, -1 };
+	int prog_fd = -1;
+
+	extra_fds[0] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
+		goto cleanup;
+	extra_fds[1] = _btf_create();
+	if (!ASSERT_GE(extra_fds[1], 0, "_btf_create"))
+		goto cleanup;
+
+	/* trash 1: not a file descriptor */
+	extra_fds[2] = 0xbeef;
+	prog_fd = load_test_prog(extra_fds, 3);
+	if (!ASSERT_EQ(prog_fd, -EBADF, "prog should have been rejected with -EBADF"))
+		goto cleanup;
+
+	/* trash 2: not a map or btf */
+	extra_fds[2] = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_GE(extra_fds[2], 0, "socket"))
+		goto cleanup;
+
+	prog_fd = load_test_prog(extra_fds, 3);
+	if (!ASSERT_EQ(prog_fd, -EINVAL, "prog should have been rejected with -EINVAL"))
+		goto cleanup;
+
+	/* some fds might be invalid, so ignore return codes */
+cleanup:
+	close(extra_fds[2]);
+	close(extra_fds[1]);
+	close(extra_fds[0]);
+}
+
+/*
+ * Test that a program with zeroes (= holes) in fd_array can be loaded:
+ * only map and BTF file descriptors should be accepted.
+ */
+static void check_fd_array_cnt__fd_array_with_holes(void)
+{
+	int extra_fds[4] = { -1, -1, -1, -1 };
+	int prog_fd = -1;
+
+	extra_fds[0] = _bpf_map_create();
+	if (!ASSERT_GE(extra_fds[0], 0, "_bpf_map_create"))
+		goto cleanup;
+	/* punch a hole*/
+	extra_fds[1] = 0;
+	extra_fds[2] = _btf_create();
+	if (!ASSERT_GE(extra_fds[1], 0, "_btf_create"))
+		goto cleanup;
+	/* punch a hole*/
+	extra_fds[3] = 0;
+
+	prog_fd = load_test_prog(extra_fds, 4);
+	ASSERT_GE(prog_fd, 0, "prog with holes should have been loaded");
+
+	/* some fds might be invalid, so ignore return codes */
+cleanup:
+	close(extra_fds[2]);
+	close(extra_fds[0]);
+	close(prog_fd);
+}
+
+/*
+ * Test that a program with too big fd_array can't be loaded.
+ */
+static void check_fd_array_cnt__fd_array_too_big(void)
+{
+	int extra_fds[65];
+	int prog_fd = -1;
+	int i;
+
+	for (i = 0; i < 65; i++) {
+		extra_fds[i] = _bpf_map_create();
+		if (!ASSERT_GE(extra_fds[i], 0, "_bpf_map_create"))
+			goto cleanup_fds;
+	}
+
+	prog_fd = load_test_prog(extra_fds, 65);
+	ASSERT_EQ(prog_fd, -E2BIG, "prog should have been rejected with -E2BIG");
+
+cleanup_fds:
+	while (i > 0)
+		close(extra_fds[--i]);
+}
+
+void test_fd_array_cnt(void)
+{
+	if (test__start_subtest("no-fd-array"))
+		check_fd_array_cnt__no_fd_array();
+
+	if (test__start_subtest("fd-array-ok"))
+		check_fd_array_cnt__fd_array_ok();
+
+	if (test__start_subtest("fd-array-dup-input"))
+		check_fd_array_cnt__duplicated_maps();
+
+	if (test__start_subtest("fd-array-ref-maps-in-array"))
+		check_fd_array_cnt__referenced_maps_in_fd_array();
+
+	if (test__start_subtest("fd-array-trash-input"))
+		check_fd_array_cnt__fd_array_with_trash();
+
+	if (test__start_subtest("fd-array-with-holes"))
+		check_fd_array_cnt__fd_array_with_holes();
+
+	if (test__start_subtest("fd-array-2big"))
+		check_fd_array_cnt__fd_array_too_big();
+}
-- 
2.34.1


