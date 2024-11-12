Return-Path: <bpf+bounces-44602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6519C50AB
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 09:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60827B2852D
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 08:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C620EA20;
	Tue, 12 Nov 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5gHShOX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCC20C01C;
	Tue, 12 Nov 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400025; cv=none; b=iuACoofth6agngYz0Yi6x2JNgY0HTcInuZ5kNXyb7hPZPArGsjAN3NdP4mUZH336t8CsFoSVVcfhAaKZHQ+l1L+W4Rd4SOXssz2jkq5wFYfuJ8RLnxiOeSQVqcMW4QNKWNIrGvnAKLB8i2RIHV5QTaIzqk9UXve34QHmdOy59ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400025; c=relaxed/simple;
	bh=yGbQ5LZb3K4ouo5/IVAj2bIoOta5TOuCDkkqCTX1MBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjiIhSi3HfNU1ljDTHpD8TBBXk1C5xdoRNP0Bn/44VDXyefcMv9s1WGsVII4ryi8DOfcL/Nfx5I63+Tj48Q0JwTk7XFObAGM+rSe7h19wHe5F6ABVjd5fzjHkIxlMNeGIa9AEdQH8IqXNwv/PMfjcdiQqybNoIko7eiKCX0ZMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5gHShOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC85CC4CECD;
	Tue, 12 Nov 2024 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731400024;
	bh=yGbQ5LZb3K4ouo5/IVAj2bIoOta5TOuCDkkqCTX1MBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5gHShOXD/p6HLBG9i2FWZ2kOmGzzEtuKdoBl8pUrlg6suqNLLfT7KmMAotVTEy+y
	 /sl0AzajPOy2BbJS85DRA2fl0mr1d6cjbeZ563c6Uy4zFK16ZHH0MyLPagZtlJt8pR
	 YkDsFcCagSFzV+trDp6FbJ3Kyv5Q4QYEYMgpREPFf6EX0xn6KGwOMEY/OGZcofNipi
	 396mCvApPcrA8ooNA7aupOssX6BDiMFBOjbMPfKdF14WqvVgFoXLAqbVjMsB4RN/Sj
	 CvFMn0ZFSxJG/x9RvI+WwNcb3RfZpz4QGXK5ztS0J+AuCcBOflR6X2+u5xPwWdFN7z
	 Fs9YKoOdr2NQQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 4/4] selftest/bpf: Test inode local storage recursion prevention
Date: Tue, 12 Nov 2024 00:26:00 -0800
Message-ID: <20241112082600.298035-7-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112082600.298035-1-song@kernel.org>
References: <20241112082600.298035-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest for recursion prevention logic of bpf local storage.

When inode local storage function is traced, helpers that access inode
local storage should return -EBUSY.

The recurring program is attached to inode_storage_lookup(). This is not
an ideal target for recursion tests. However, given that the target
function have to take "struct inode *" argument, there isn't a better
target function for the tests.

Test results showed that inode_storage_lookup() is inlined in s390x.
Work around this by adding this test to DENYLIST.s390x.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../bpf/prog_tests/inode_local_storage.c      | 72 +++++++++++++++
 .../bpf/progs/inode_storage_recursion.c       | 90 +++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inode_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/inode_storage_recursion.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 3ebd77206f98..6b8c9c9ec754 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -1,5 +1,6 @@
 # TEMPORARY
 # Alphabetical order
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
+inode_localstorage/recursion             # target function (inode_storage_lookup) is inlined on s390)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_iterating_callbacks
diff --git a/tools/testing/selftests/bpf/prog_tests/inode_local_storage.c b/tools/testing/selftests/bpf/prog_tests/inode_local_storage.c
new file mode 100644
index 000000000000..a9d9f77216f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/inode_local_storage.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <stdio.h>
+#include <sys/stat.h>
+#include <test_progs.h>
+#include "inode_storage_recursion.skel.h"
+
+#define TDIR "/tmp/inode_local_storage"
+#define TDIR_PARENT "/tmp"
+
+static void test_recursion(void)
+{
+	struct inode_storage_recursion *skel;
+	struct bpf_prog_info info;
+	__u32 info_len = sizeof(info);
+	int err, prog_fd, map_fd, inode_fd = -1;
+	long value;
+
+	skel = inode_storage_recursion__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->test_pid = getpid();
+
+	err = inode_storage_recursion__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	err = mkdir(TDIR, 0755);
+	if (!ASSERT_OK(err, "mkdir " TDIR))
+		goto out;
+
+	inode_fd = open(TDIR_PARENT, O_RDONLY | O_CLOEXEC);
+	if (!ASSERT_OK_FD(inode_fd, "open inode_fd"))
+		goto out;
+
+	/* Detach so that the following lookup won't trigger
+	 * trace_inode_storage_lookup and further change the values.
+	 */
+	inode_storage_recursion__detach(skel);
+	map_fd = bpf_map__fd(skel->maps.inode_map);
+	err = bpf_map_lookup_elem(map_fd, &inode_fd, &value);
+	ASSERT_OK(err, "lookup inode_map");
+
+	/* Check trace_inode_mkdir for the reason that value == 201 */
+	ASSERT_EQ(value, 201, "inode_map value");
+	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
+
+	prog_fd = bpf_program__fd(skel->progs.trace_inode_mkdir);
+	memset(&info, 0, sizeof(info));
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_OK(err, "get prog info");
+	ASSERT_EQ(info.recursion_misses, 0, "trace_inode_mkdir prog recursion");
+
+	prog_fd = bpf_program__fd(skel->progs.trace_inode_storage_lookup);
+	memset(&info, 0, sizeof(info));
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	ASSERT_OK(err, "get prog info");
+	ASSERT_EQ(info.recursion_misses, 3, "trace_inode_storage_lookup prog recursion");
+
+out:
+	rmdir(TDIR);
+	close(inode_fd);
+	inode_storage_recursion__destroy(skel);
+}
+
+void test_inode_localstorage(void)
+{
+	if (test__start_subtest("recursion"))
+		test_recursion();
+}
diff --git a/tools/testing/selftests/bpf/progs/inode_storage_recursion.c b/tools/testing/selftests/bpf/progs/inode_storage_recursion.c
new file mode 100644
index 000000000000..0ad36f8c6e04
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/inode_storage_recursion.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#ifndef EBUSY
+#define EBUSY 16
+#endif
+
+char _license[] SEC("license") = "GPL";
+int nr_del_errs;
+int test_pid;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} inode_map SEC(".maps");
+
+/* inode_storage_lookup is not an ideal hook for recursion tests, as it
+ * is static and more likely to get inlined. However, there isn't a
+ * better function for the test. This is because we need to call
+ * bpf_inode_storage_* helpers with an inode intput. Unlike task local
+ * storage, for which we can use bpf_get_current_task_btf() to get task
+ * pointer with BTF, for inode local storage, we need the get the inode
+ * pointer from function arguments. Other functions, such as,
+ * bpf_local_storage_get() does not take inode as input.
+ */
+SEC("fentry/inode_storage_lookup")
+int BPF_PROG(trace_inode_storage_lookup, struct inode *inode)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	long *ptr;
+	int err;
+
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	/* This doesn't have BPF_LOCAL_STORAGE_GET_F_CREATE, so it will
+	 * not trigger on the first call of bpf_inode_storage_get() below.
+	 *
+	 * This is called twice, recursion_misses += 2.
+	 */
+	ptr = bpf_inode_storage_get(&inode_map, inode, 0, 0);
+	if (ptr) {
+		*ptr += 1;
+
+		/* This is called once, recursion_misses += 1. */
+		err = bpf_inode_storage_delete(&inode_map, inode);
+		if (err == -EBUSY)
+			nr_del_errs++;
+	}
+
+	return 0;
+}
+
+SEC("fentry/security_inode_mkdir")
+int BPF_PROG(trace_inode_mkdir, struct inode *dir,
+	     struct dentry *dentry,
+	     int mode)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	long *ptr;
+
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	/* Trigger trace_inode_storage_lookup, the first time */
+	ptr = bpf_inode_storage_get(&inode_map, dir, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	/* trace_inode_storage_lookup cannot get ptr, so *ptr is 0.
+	 * Set ptr to 200.
+	 */
+	if (ptr && !*ptr)
+		*ptr = 200;
+
+	/* Trigger trace_inode_storage_lookup, the second time.
+	 * trace_inode_storage_lookup can now get ptr and increase the
+	 * value. Now the value is 201.
+	 */
+	bpf_inode_storage_get(&inode_map, dir, 0,
+			      BPF_LOCAL_STORAGE_GET_F_CREATE);
+
+	return 0;
+
+}
-- 
2.43.5


