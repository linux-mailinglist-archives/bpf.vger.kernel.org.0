Return-Path: <bpf+bounces-72285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC9C0B383
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EA13B0572
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731628BA83;
	Sun, 26 Oct 2025 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUwSGhe2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0A26B0B3
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511162; cv=none; b=EsR0tR1sFkI9I3kWoKWaEcXHAhMVQ7ip/7xwSn5Osho77lGpiLR3t9XZsEPWEVg0AomAQrswWZTlX2Hs6/KKJsJcA4pZ43x3wwliT0/+dBhnyY3sEbZ+NGkpztS8v/iVlbxq83PltziEmIgsfp2yxaKiTGEJJQt2hsotSG/KKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511162; c=relaxed/simple;
	bh=zM3uuLaM66hbzygmVz3XurjGCPl99qJWZXwu/K53KM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjQ4PA8Rm0zYxLNX/12J0BBwfsHIwhIf4AXomtK01j6qRRBlHtrWyJ7optLotksPaQMg3WBeoB7hMUvbiXkxKFvJJKDOOkzfU3fN5EIpUKpc6239Glsu9UEyFfxTweI2Pe+tx9B4eh+ByzcrcSLzYnG917QKYg8mmTwTtU2NdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUwSGhe2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso7015355e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511159; x=1762115959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g65HdtnUMDhn5hfVkRaktZ1XapdpU6EaF5l3FAQ0RbE=;
        b=hUwSGhe26Em9poPreuSBF6ctrqtSevMv6kx3sKSHcmQO540E5E//0wy8D/oE8pss58
         pQ1XEOV1QHiAFZBRB9qJBlZ79ImiFmmfAPODghEC34hKW9oDztoirhzSPy3ZUJSO0QaX
         TIKOPnj+KbgeIDTbtpKxWOcHNF0X+7G+i3oKBDFFu4QAyQi38GWXi5bwGhKfD1Hii7KC
         CIyFTX2EziyyRbDY8121EhneEdt18bXyndtM+OzKtKmO13ZRLAZTHcHVz8XqbSX4ZmIS
         vaf2y8efOLkk5Jlp3A+bY8+pDmNR2LOwYfEW8h7O0lYrHouhVzozWbTIV8SvlQ9ute6z
         GPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511159; x=1762115959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g65HdtnUMDhn5hfVkRaktZ1XapdpU6EaF5l3FAQ0RbE=;
        b=mainWWoG3eKkpcrlAWKduHaAFcN3L04VA6fw/mMnZtRmw9JVVhaiojyqtsgsTg4DdC
         p7Tq28uxG1C8HDhkGaXDQeKOqOyuox50OD690h35mY5TaaG26VX8SW3h54pzoz2PtcFJ
         4ed6Z9k7X2sTiYhz7k80AR4uWCKnpOvZgJHxQ5mqqyLwLeMfTV0Tp86DokGZUJdM/KQ/
         nYIbjqcpStgvFgMz+u38snD2sYsE1W4w4wnZXc9IFGtFKIiedre+uDbzD2OVqYKkXCFd
         o7KSaI1aqPfkePLr72jm9DenfyQl31NHL1xvF5w1/ra5wSFYP63XNXUoD8zKjhu9/rRK
         rRgg==
X-Gm-Message-State: AOJu0Yy5RoopVYp81CjdEcJv3b5ITN4E4xTs535kBBndrJJQ6j2JXW+W
	v9x5DRNQe0s6jYgL3wNM2b2q+L2ZdkFnurVKvF9IkpvF76IURAEEdlk3+OLVwA==
X-Gm-Gg: ASbGncsfiLvzn3R9cM/yAwA1fg4V/Td9RLBTj4jZ3Jw0B0fpE0zT3fWBTa1KRVcu151
	i4ykvAzt8wYssod4QhAiXVVuP/s6prjpGbfLw9aZIl0iZIcJFl3N7usqcVV/txPOyTLXoqHNh8P
	8AZgzBqz/Gdz3b6+Gvs9Op/2P7/6QGTCIOEI6TmLUBRrtcfDNa+HezgCZa+SCLG3EsGquBxsDo+
	MliDeI2qzLPE1a5pMBoCqv2ivHJZHp2ZhDyhQAZASWCeeyp2cUnNjx+QYL+TlY/WVOuxiFLBsuK
	iqQDN5P+kqql3flSZzpu5t7OQECbquD3ZW4/PonW+CnGta8zGHXX6jjJ3lZHztH0/6DtDY+Sp1k
	3K9m5RKHuRbYnCfLVI/SxljsJCvzhnIY0rVvpFjsbK5HBcwzLV0fW0SqP0is=
X-Google-Smtp-Source: AGHT+IG5RBbZd8LZ5qz6icffHue/jRT+4qVpA0u/eQVqHGFkILWemmvcLjlw5wcB4OswtLhKavZohQ==
X-Received: by 2002:a05:600d:4382:b0:475:d891:ec8c with SMTP id 5b1f17b1804b1-475d891ed03mr42519725e9.3.1761511158699;
        Sun, 26 Oct 2025 13:39:18 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddcbe184sm47028055e9.2.2025.10.26.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:18 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 10/10] selftests/bpf: add file dynptr tests
Date: Sun, 26 Oct 2025 20:38:53 +0000
Message-ID: <20251026203853.135105-11-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing selftests for validating file-backed dynptr works as
expected.
 * validate implementation supports dynptr slice and read operations
 * validate destructors should be paired with initializers
 * validate sleepable progs can page in.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/file_reader.c    | 113 ++++++++++++++
 .../testing/selftests/bpf/progs/file_reader.c | 145 ++++++++++++++++++
 .../selftests/bpf/progs/file_reader_fail.c    |  52 +++++++
 3 files changed, 310 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
new file mode 100644
index 000000000000..2a034d43b73e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "file_reader.skel.h"
+#include "file_reader_fail.skel.h"
+#include <dlfcn.h>
+#include <sys/mman.h>
+
+const char *user_ptr = "hello world";
+char file_contents[256000];
+
+void *get_executable_base_addr(void)
+{
+	Dl_info info;
+
+	if (!dladdr((void *)&get_executable_base_addr, &info)) {
+		fprintf(stderr, "dladdr failed\n");
+		return NULL;
+	}
+
+	return info.dli_fbase;
+}
+
+static int initialize_file_contents(void)
+{
+	int fd, page_sz = sysconf(_SC_PAGESIZE);
+	ssize_t n = 0, cur, off;
+	void *addr;
+
+	fd = open("/proc/self/exe", O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "Open /proc/self/exe\n"))
+		return 1;
+
+	do {
+		cur = read(fd, file_contents + n, sizeof(file_contents) - n);
+		if (!ASSERT_GT(cur, 0, "read success"))
+			break;
+		n += cur;
+	} while (n < sizeof(file_contents));
+
+	close(fd);
+
+	if (!ASSERT_EQ(n, sizeof(file_contents), "Read /proc/self/exe\n"))
+		return 1;
+
+	addr = get_executable_base_addr();
+	if (!ASSERT_NEQ(addr, NULL, "get executable address"))
+		return 1;
+
+	/* page-align base file address */
+	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
+
+	for (off = 0; off < sizeof(file_contents); off += page_sz) {
+		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
+			       "madvise pageout"))
+			return errno;
+	}
+
+	return 0;
+}
+
+static void run_test(const char *prog_name)
+{
+	struct file_reader *skel;
+	struct bpf_program *prog;
+	int err, fd;
+
+	err = initialize_file_contents();
+	if (!ASSERT_OK(err, "initialize file contents"))
+		return;
+
+	skel = file_reader__open();
+	if (!ASSERT_OK_PTR(skel, "file_reader__open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		bpf_program__set_autoload(prog, strcmp(bpf_program__name(prog), prog_name) == 0);
+	}
+
+	memcpy(skel->bss->user_buf, file_contents, sizeof(file_contents));
+	skel->bss->pid = getpid();
+
+	err = file_reader__load(skel);
+	if (!ASSERT_OK(err, "file_reader__load"))
+		goto cleanup;
+
+	err = file_reader__attach(skel);
+	if (!ASSERT_OK(err, "file_reader__attach"))
+		goto cleanup;
+
+	fd = open("/proc/self/exe", O_RDONLY);
+	if (fd >= 0)
+		close(fd);
+
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->run_success, 1, "run_success");
+cleanup:
+	file_reader__destroy(skel);
+}
+
+void test_file_reader(void)
+{
+	if (test__start_subtest("on_open_expect_fault"))
+		run_test("on_open_expect_fault");
+
+	if (test__start_subtest("on_open_validate_file_read"))
+		run_test("on_open_validate_file_read");
+
+	if (test__start_subtest("negative"))
+		RUN_TESTS(file_reader_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
new file mode 100644
index 000000000000..2585f83b0ce5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "errno.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} arrmap SEC(".maps");
+
+struct elem {
+	struct file *file;
+	struct bpf_task_work tw;
+};
+
+char user_buf[256000];
+char tmp_buf[256000];
+
+int pid = 0;
+int err, run_success = 0;
+
+static int validate_file_read(struct file *file);
+static int task_work_callback(struct bpf_map *map, void *key, void *value);
+
+SEC("lsm/file_open")
+int on_open_expect_fault(void *c)
+{
+	struct bpf_dynptr dynptr;
+	struct file *file;
+	int local_err = 1;
+	__u32 user_buf_sz = sizeof(user_buf);
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	local_err = bpf_dynptr_read(tmp_buf, user_buf_sz, &dynptr, 0, 0);
+	if (local_err == -EFAULT) { /* Expect page fault */
+		local_err = 0;
+		run_success = 1;
+	}
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	if (local_err)
+		err = local_err;
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+int on_open_validate_file_read(void *c)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct elem *work;
+	int key = 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	work = bpf_map_lookup_elem(&arrmap, &key);
+	if (!work) {
+		err = 1;
+		return 0;
+	}
+	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback, NULL);
+	return 0;
+}
+
+/* Called in a sleepable context, read 256K bytes, cross check with user space read data */
+static int task_work_callback(struct bpf_map *map, void *key, void *value)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+
+	if (!file)
+		return 0;
+
+	err = validate_file_read(file);
+	if (!err)
+		run_success = 1;
+	bpf_put_file(file);
+	return 0;
+}
+
+static int verify_dynptr_read(struct bpf_dynptr *ptr, u32 off, char *user_buf, u32 len)
+{
+	int i;
+
+	if (bpf_dynptr_read(tmp_buf, len, ptr, off, 0))
+		return 1;
+
+	/* Verify file contents read from BPF is the same as the one read from userspace */
+	bpf_for(i, 0, len)
+	{
+		if (tmp_buf[i] != user_buf[i])
+			return 1;
+	}
+	return 0;
+}
+
+static int validate_file_read(struct file *file)
+{
+	struct bpf_dynptr dynptr;
+	int loc_err = 1, off;
+	__u32 user_buf_sz = sizeof(user_buf);
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto cleanup;
+
+	loc_err = verify_dynptr_read(&dynptr, 0, user_buf, user_buf_sz);
+	off = 1;
+	loc_err = loc_err ?: verify_dynptr_read(&dynptr, off, user_buf + off, user_buf_sz - off);
+	off = user_buf_sz - 1;
+	loc_err = loc_err ?: verify_dynptr_read(&dynptr, off, user_buf + off, user_buf_sz - off);
+	/* Read file with random offset and length */
+	off = 4097;
+	loc_err = loc_err ?: verify_dynptr_read(&dynptr, off, user_buf + off, 100);
+
+	/* Adjust dynptr, verify read */
+	loc_err = loc_err ?: bpf_dynptr_adjust(&dynptr, off, off + 1);
+	loc_err = loc_err ?: verify_dynptr_read(&dynptr, 0, user_buf + off, 1);
+	/* Can't read more than 1 byte */
+	loc_err = loc_err ?: verify_dynptr_read(&dynptr, 0, user_buf + off, 2) == 0;
+	/* Can't read with far offset */
+	loc_err = loc_err ?: verify_dynptr_read(&dynptr, 1, user_buf + off, 1) == 0;
+
+cleanup:
+	bpf_dynptr_file_discard(&dynptr);
+	return loc_err;
+}
diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
new file mode 100644
index 000000000000..32fe28ed2439
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int err;
+void *user_ptr;
+
+SEC("lsm/file_open")
+__failure
+__msg("Unreleased reference id=")
+int on_nanosleep_unreleased_ref(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+
+	if (!file)
+		return 0;
+
+	err = bpf_dynptr_from_file(file, 0, &dynptr);
+	return err ? 1 : 0;
+}
+
+SEC("xdp")
+__failure
+__msg("Expected a dynptr of type file as arg #0")
+int xdp_wrong_dynptr_type(struct xdp_md *xdp)
+{
+	struct bpf_dynptr dynptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &dynptr);
+	bpf_dynptr_file_discard(&dynptr);
+	return 0;
+}
+
+SEC("xdp")
+__failure
+__msg("Expected an initialized dynptr as arg #0")
+int xdp_no_dynptr_type(struct xdp_md *xdp)
+{
+	struct bpf_dynptr dynptr;
+
+	bpf_dynptr_file_discard(&dynptr);
+	return 0;
+}
-- 
2.51.0


