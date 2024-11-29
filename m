Return-Path: <bpf+bounces-45877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DB9DE77A
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F585282316
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83419F430;
	Fri, 29 Nov 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="OyIPVmqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EED19E806
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886762; cv=none; b=mpHq6PsV57AATh4ID5WJBvLxp0ZpR59VXSNdKlgeZ3RXVhQjpAbL+OB3XOrZX3wuuhM+juh90hpec2bOosmrv8gRrTTlV+ov2cDMo7SwfIdvJ+Rvpqdu0F9OsyMBTUUfx579bQhLiIsxeiJpCJfO4RbIhMP56wML9qj5dkDTOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886762; c=relaxed/simple;
	bh=q8kIqdjFR8VhaEdljaQIv0ADCkAKL0LE5LW/UB27fy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IB2EeleHv5czWl0qWgBB+lvFzjHoPo9OEBhyG9mgH8HfRz1eNq/IfaLaS0RjBbeF1UemLsJAxu86KKoJ+n5RAOME5ZcBPrPUUBRnJYbQ9ckf3kPH4PTl2Lk9yyGhKRc6BzouTnQRKtUwp+7Z/BC/oqOu/H0cbzJ6knnKke1YRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=OyIPVmqw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa503cced42so259419966b.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886759; x=1733491559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZaeN35fXOQqFjsexfjmHkmqsK002i7Hw/kubNXFYbg=;
        b=OyIPVmqwd/tU1/bZzj9OG/87zrWBsg4UsK+hXJwBZQXED48I053DlhHbseH0lvwkv9
         cXptBYqV7Sq9JMbVPwP7HKYQ1fub2mVlKki9iq6R6ziCNRxqZF/YL3Hu2IZc/z4UjEuk
         yhWCewSVwVClzEDicZseMB8GktAywzwIJynMHEaCdidbctnGgamGKGLPz1tLWUijpT7L
         8m+YNT9KU9084M+20MkBrOJWxuTTSkR4VN5EzeOHJuHkgn4VlLmPIkuQ5KR2zF3pMrWf
         TEaZiTud9Tv8G2Bwo3oJH6Jlvj6EjqUgr1iIDYGDYLxCMTcMU9f6c/9pBzzHyLp463/o
         2CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886759; x=1733491559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZaeN35fXOQqFjsexfjmHkmqsK002i7Hw/kubNXFYbg=;
        b=fWpKpB7nR3HvxureIBdHkctmalHvO1Z+s13qg1DjQTqIQFWKEtP8Cn5CT+zqhESFwt
         AycaL+60qbg//MDbkmEwrB/HZtKbxkYtiZeD35UEqx1n8WY3B7OJtGx06zbW1IZndGL3
         YUYjlEol6+2uWT+4qo2JflvWqTy9IISu6Bi5h0cbNmkwmSAeZucK5k0CVHkT85hDghPG
         CzUDMf5xfws+Jk7yXz6ag9ueTRDGkIha2P/lnReKW5pgidDqbOFUPWEx6OYGrO0lKHPd
         uMY/ps3ZZgBVkDwA35rfIAu1n1tI4eFys48f0NiMN6leSNV9wGAkDbKDWhoh6S8CC6xk
         V8XA==
X-Gm-Message-State: AOJu0YxH6Ezc7DsL0CxoiNG381hS1HQgklaUZC5RNRgjA8Dq8IEMsvUG
	tFnsc5HtT1IbDpxa4a6LQebPbQF+e4ulYJDKl7VFMZaL2a3Ukatvr27tMr+/gU3q+spg/ORBOwJ
	h
X-Gm-Gg: ASbGncv2pJLPlSbxKf15RDFuJZG9ivNY4Ueum9GXQ+kjC22Y4KsMa0BWvmXBpTz4A0o
	/ipI6V76NnxBBGaTo7/rcb8jkzv4Smnt7fxuntidZ0Mr7J4dBbSwGuSHSzEqTKX5TgW2PNJXWxl
	s4clAOdMMxJwOl74pd2ATWya7klbvFMEWrDOXAAxsUMd7IbqpvFLWZ/RaNBD+HXq25d8BkwYT+P
	6Hxw2VxTPIGtokDaixlv9IRV6OwDn0+V5zTArgDWldXs8p7Vpfd5AZdDnYAJbE=
X-Google-Smtp-Source: AGHT+IF0/9EsYDvYxR3fHRo5Qxe8yrVRhF0RCHzuSwYOorP3eGHPDy65yoWEHUNYNRyQ27cOMt7nNg==
X-Received: by 2002:a17:906:2932:b0:aa5:396a:c9e8 with SMTP id a640c23a62f3a-aa580f27899mr629685566b.23.1732886758386;
        Fri, 29 Nov 2024 05:25:58 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:57 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v3 bpf-next 5/7] selftests/bpf: Add tests for fd_array_cnt
Date: Fri, 29 Nov 2024 13:28:11 +0000
Message-Id: <20241129132813.1452294-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129132813.1452294-1-aspsk@isovalent.com>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
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
 kernel/bpf/verifier.c                         |  30 +-
 .../selftests/bpf/prog_tests/fd_array.c       | 340 ++++++++++++++++++
 2 files changed, 355 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fd_array.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d172f6974fd7..7102d85f580d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22620,7 +22620,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->ops = bpf_verifier_ops[env->prog->type];
 	ret = init_fd_array(env, attr, uattr);
 	if (ret)
-		goto err_free_aux_data;
+		goto err_release_maps;
 
 	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
 	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
@@ -22773,11 +22773,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
 				  &log_true_size, sizeof(log_true_size))) {
 		ret = -EFAULT;
-		goto err_release_maps;
+		goto err_ext;
 	}
 
 	if (ret)
-		goto err_release_maps;
+		goto err_ext;
 
 	if (env->used_map_cnt) {
 		/* if program passed verifier, update used_maps in bpf_prog_info */
@@ -22787,7 +22787,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 		if (!env->prog->aux->used_maps) {
 			ret = -ENOMEM;
-			goto err_release_maps;
+			goto err_ext;
 		}
 
 		memcpy(env->prog->aux->used_maps, env->used_maps,
@@ -22801,7 +22801,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 							  GFP_KERNEL);
 		if (!env->prog->aux->used_btfs) {
 			ret = -ENOMEM;
-			goto err_release_maps;
+			goto err_ext;
 		}
 
 		memcpy(env->prog->aux->used_btfs, env->used_btfs,
@@ -22817,15 +22817,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 	adjust_btf_func(env);
 
-err_release_maps:
-	if (!env->prog->aux->used_maps)
-		/* if we didn't copy map pointers into bpf_prog_info, release
-		 * them now. Otherwise free_used_maps() will release them.
-		 */
-		release_maps(env);
-	if (!env->prog->aux->used_btfs)
-		release_btfs(env);
-
+err_ext:
 	/* extension progs temporarily inherit the attach_type of their targets
 	   for verification purposes, so set it back to zero before returning
 	 */
@@ -22838,7 +22830,15 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-err_free_aux_data:
+err_release_maps:
+	if (!env->prog->aux->used_maps)
+		/* if we didn't copy map pointers into bpf_prog_info, release
+		 * them now. Otherwise free_used_maps() will release them.
+		 */
+		release_maps(env);
+	if (!env->prog->aux->used_btfs)
+		release_btfs(env);
+
 	vfree(env->insn_aux_data);
 	kvfree(env->insn_hist);
 err_free_env:
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


