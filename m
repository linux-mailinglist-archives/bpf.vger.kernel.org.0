Return-Path: <bpf+bounces-46005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE429E2178
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5892EB26F40
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903DF1F4266;
	Tue,  3 Dec 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XOD5I5rF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0E61E009F
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233727; cv=none; b=Q5FzPkUag0dcv0BaTV0bq2RfCRYBDp2WVIzy5pUrEAWI2qpMDdaqOPyruWlZuwKPoL9XLDh6bHvDbVWOCIXQz2G/IBKhqekNXcd3YtkufUaAcjE+puY/BG0ggkzd9kgF/rrNela2TTehEc1WyZb2wVX217NDngSALlzKCZlOKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233727; c=relaxed/simple;
	bh=Z+QUCdSTrd5VOI9bV/ZQ8fC88OkhdNeOag6YTpZXwdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfOspj47QFZLMsgW0Y048b1zuakrqw6bIBWQ+GxmE0w7G1Iw0tbl5sdX0pxCJlQY8MmRL7UNXWBkNMWi1PhQA7+Xijfr4d4mRwMKpnDZyeGzjkgKmii5wAvzgVUpT17zSMrXfk8sWqflTP7DR7qdhlvxOshqQTIpUAjKMTEK+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XOD5I5rF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso57910581fa.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733233723; x=1733838523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uNq3UCmJLmTcvC/Yf3jhS1IU/A57iUFvR49X2lBeoU=;
        b=XOD5I5rFwt7IzE+a0hPgyR2NDf+iNdT3qDQibVxJVO5oR9MbrV4beNnZI9D371Y/Hr
         QEifcrlfm+eeNvxH3fjMjwmbJOMTXtwqlRiQZMatkHWRy/QfJsNW3u+zcfANE9pUvZAR
         x0ZKQ9z/EZlk+4+WHgP+3jgfkwCtn58kxvSvY86So/32tvnMCpi7/tf6LG2QsG2z7Urv
         s1ggnhQpx8tRxCvyRcquunm8Rz+CMcM91BSwYis4aX/QiLk0g+iSuJBn6YOvWACDsKUz
         RcqvQuPC0WddCXaW5v+yUeqG9mFhP8RZOGziOe+M4KiBEvrqKpKqOcmpU03psJaGgDDi
         R6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233723; x=1733838523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uNq3UCmJLmTcvC/Yf3jhS1IU/A57iUFvR49X2lBeoU=;
        b=tEut5pYyKkmKtoLdlkLZvmqaD6UjoQjbNf8Pxp7Nybif5UNAnRgouUJUYw3OU+X1f6
         F6kleMsHB7IZmZ6x5xTKQxoIUlgiM2vmfVow5xpAcnASDjnerfmI2GcLt4cXGnDd+pq/
         +51CQ/w26YczCU0LC0O25VUA5bxp8IamWG5WRnkkRPnpyhcon0u0dLsnLI8wt0O/ejPd
         mrUMUChhgvclyMdCKeXmLmIbezgoeQxQyibegBZyWDDISYvGk9W+17EkGyQKzxLGRWKj
         TQcOnfKoHcCeK9wW615FZJ2bexD2rAq2i61FeHV3ukW7OGXAGIr/oKqOT4l7DriIJFbi
         NTDA==
X-Gm-Message-State: AOJu0Yy5rywJgXAuCpf3Iw1TafUT0ve+ugr2GVBBK1CshLGlivUSQISL
	YmIlcUnZrSdZWFkd3tcS9wjLtkBfM5nts7zBz2V39rNkEzwQvtr4bB34E3ssz0tjBSMGKZ/16BE
	F
X-Gm-Gg: ASbGnctYvvniAqSjOd0seSGR/QrdkM1qLJKbtvce5NFYQLbGLLKNPNiJXtb567RrD7l
	/HUJw7Fqwe5Xg8/pmSug/qeIv9HCmi9tc1jeypR/K4noD4trLgPspThoabSC1m8/VX++r7D/2x4
	qmpViabZEZfWZZa1bYbqED/9Fr30F0oUsZ5ltHduF8XMwBJPzmLCTBq9SHixaMIjlQSCAz52USA
	cXzDJuHTZj5WtWqnJ/3dBIkeUuElFQSqTAg5KTtMrAlTcN+NYZm+8XhnSnIMGc=
X-Google-Smtp-Source: AGHT+IGLXf8dA5IqmjeQYUIzocYCWLaT7Iy0fxpoUMJprYvArVTFEKPPCHP+UCcSu7drWWhxcpZm0Q==
X-Received: by 2002:a05:651c:1549:b0:2fb:4b1f:973f with SMTP id 38308e7fff4ca-30009c73846mr13089341fa.7.1733233722764;
        Tue, 03 Dec 2024 05:48:42 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d098330dd2sm6243394a12.14.2024.12.03.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:48:42 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 5/7] selftests/bpf: Add tests for fd_array_cnt
Date: Tue,  3 Dec 2024 13:50:50 +0000
Message-Id: <20241203135052.3380721-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203135052.3380721-1-aspsk@isovalent.com>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
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
 .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
 1 file changed, 340 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
new file mode 100644
index 000000000000..1d4bff4a1269
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include <linux/btf.h>
+#include <bpf/bpf.h>
+
+#include "../test_btf.h"
+
+static inline int new_map(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	const char *name = NULL;
+	__u32 max_entries = 1;
+	__u32 value_size = 8;
+	__u32 key_size = 4;
+
+	return bpf_map_create(BPF_MAP_TYPE_ARRAY, name,
+			      key_size, value_size,
+			      max_entries, &opts);
+}
+
+static int new_btf(void)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, opts);
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
+
+	return bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
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
+static int __load_test_prog(int map_fd, const int *fd_array, int fd_array_cnt)
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
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+
+	opts.fd_array = fd_array;
+	opts.fd_array_cnt = fd_array_cnt;
+
+	return bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, ARRAY_SIZE(insns), &opts);
+}
+
+static int load_test_prog(const int *fd_array, int fd_array_cnt)
+{
+	int map_fd;
+	int ret;
+
+	map_fd = new_map();
+	if (!ASSERT_GE(map_fd, 0, "new_map"))
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
+	extra_fds[0] = new_map();
+	if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
+		goto cleanup;
+	extra_fds[1] = new_map();
+	if (!ASSERT_GE(extra_fds[1], 0, "new_map"))
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
+	extra_fds[0] = extra_fds[2] = new_map();
+	if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
+		goto cleanup;
+	extra_fds[1] = extra_fds[3] = new_map();
+	if (!ASSERT_GE(extra_fds[1], 0, "new_map"))
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
+	extra_fds[0] = new_map();
+	if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
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
+	extra_fds[0] = new_map();
+	if (!ASSERT_GE(extra_fds[0], 0, "new_map"))
+		goto cleanup;
+	extra_fds[1] = new_btf();
+	if (!ASSERT_GE(extra_fds[1], 0, "new_btf"))
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
+ * Test that a program with too big fd_array can't be loaded.
+ */
+static void check_fd_array_cnt__fd_array_too_big(void)
+{
+	int extra_fds[65];
+	int prog_fd = -1;
+	int i;
+
+	for (i = 0; i < 65; i++) {
+		extra_fds[i] = new_map();
+		if (!ASSERT_GE(extra_fds[i], 0, "new_map"))
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
+	if (test__start_subtest("fd-array-2big"))
+		check_fd_array_cnt__fd_array_too_big();
+}
-- 
2.34.1


