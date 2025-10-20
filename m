Return-Path: <bpf+bounces-71474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D79BF3E4B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AA3A4E6AB2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1F2F1FF6;
	Mon, 20 Oct 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhOVYHly"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEE2F25F2
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999161; cv=none; b=gzNzZN+hxB5dAIOYADFdVKhFMcMor4gr+cWpeeeRLULTiuEJm3qWgZrLhDStzo03MXyu0arQMSOOsAM68Fy/HfZrROqX0iiy7C37CdSLTl+N2XGaDnki6byajtwFp4KBtTWx3fcPM4ZhqKNAEbBg25H/RQea87wI7zOjDW/QH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999161; c=relaxed/simple;
	bh=56FGUXlTiKkpqP1zu/BuvDFnb9sLgZpedyWgJpGKKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovLVShpjdR2ap5tFV3emdgFEaNZjNPsHPqLY3sesyRts44PXAAtP9MJjF6SVMhissJ6iUWY+wFP748phFNJmfpRsp5pCyIV9gdRLPzP5FghNoMFJ5AH+LGacfDfL7TaiJ81cz7qsTt/8dUrg+qf0YpzhwxKONdf7HkwW4WI0f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhOVYHly; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47157119d8bso6332895e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999158; x=1761603958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqCubwY1XA7kTVWQGkx2zuNH8AdEZuyeCEEffIaxRT4=;
        b=JhOVYHlyS9qYYROoqGEOJTgAB4GFsDqd8+GcZVFAGl45B5uIR/jtvVU0MY6nvVA+u1
         5qlY+jNWiAZIEZIiRFE5YJh8/emHyAabQ/I9SXuDK2AwWg6SN53nTEWuUpoNFDcPEHOu
         JNJHkaCUmLPVETt/b2sXjMmR1bT7ErwUW+2cqJGa14oAiCHqZZH9+RkIMN41Al2yD/Qb
         7hItWcAcelg1GlZwZQnB4elU/9QgJluI7yD1ivr2ASVqtoSob8I28a1nJq6eE88AfRpf
         sLhvTNnb62Z2th++NLr57gS/Gc4UJpCUkPjrLJ9622gaBHXOMetUZVSf2I5+1qbAeV2F
         Uqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999158; x=1761603958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqCubwY1XA7kTVWQGkx2zuNH8AdEZuyeCEEffIaxRT4=;
        b=YGTy22rtO8ZWnk3veS1AbXx6QirX4VAKrkTEd3x27PgkUUaOn9LzW1/zNSN1mhTdSI
         bjNoBY5rLwZWOvKm5jU/1vmjZns5yzXTOvJ/8qEErL7geLHq8UKAHHwlDlNmTxDhwaAH
         41FZUofvY4g2sW4dB2TAvT0HmY2vfUMHP3aqwhab3OzKiA5/XxEny5UuO/dDvU3la2md
         HHkQdBEcr/uaxcziuTTo1QpAhj+1EPn/cxqIeJyVCi/gLHb4DJ2DZAMwjlgalMtauL2o
         DuwEVfozdPYMbF1nWx8+9I0EkQ4ou5deCGOf8MmqGyVGM8f29ceHEtce4do+hZ8I0+Pp
         EV7A==
X-Gm-Message-State: AOJu0YzqROrEB27ecO70o3Um+O+ByY2LyZEcRBvXc+Uo3jCyg2WsRuMC
	STr1D7x0ITZWUp44tKILgMArx+RvWny7hHsmRRYQb1RvIfneAms8VRiu7zi/bg==
X-Gm-Gg: ASbGnctyMGfLmdULDqCWfJAs3rFaOcbpXGTceU5PpIJzEeKt1HtJMMwhwNPqwQXIK9c
	/0EnJH9c+dh3Y5vTUsbtzKy9C/FAx/cBbImpZ3CzeBfbjmGfwhep3x6Yo4DGqVL4RI3UTBIvgXt
	pBh4gmyfC/Pbw4C19Ltfsd7cWSmJNy9WSno3zymaj9OgO62m0YdCLztiD2XY96DaaPBx7O/QKfw
	UoLUDoYfpWYdi42i9VncjLQUHx1Cq2eyiHvSB1Y2yBNg/egzZSvD3AJXED6whmWcVh+ZbTfeaY0
	cmvCakEGKq8NZLuVRPMh4/ZVxzMkq1xHUy1Y+aFzuTDq2zzxNKP9a9w996H3u3DTU7J7V++WCkX
	tS2qhoCnV3MGCYKQh2qnj0HAlIJtSdpPqoGHrit3kP7vDMc2fNZv/K4E5IEy3rE5IEePhHQ==
X-Google-Smtp-Source: AGHT+IGacz/7+0tJAbe4byCjKCLNguJl+gdirDgf6KbVUm6JBgRUd/EsvwCGZKU5DWCnWW8gZDvhKQ==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr120631445e9.6.1760999157550;
        Mon, 20 Oct 2025 15:25:57 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm164275065e9.11.2025.10.20.15.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 10/10] selftests/bpf: add file dynptr tests
Date: Mon, 20 Oct 2025 23:25:38 +0100
Message-ID: <20251020222538.932915-11-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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
---
 .../selftests/bpf/prog_tests/file_reader.c    | 118 ++++++++++++
 .../testing/selftests/bpf/progs/file_reader.c | 178 ++++++++++++++++++
 .../selftests/bpf/progs/file_reader_fail.c    |  52 +++++
 3 files changed, 348 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
new file mode 100644
index 000000000000..e13c445dc407
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -0,0 +1,118 @@
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
+	char data[256];
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = &data, .repeat = 1,
+		    .data_size_in = sizeof(data));
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
+	skel->bss->user_buf = file_contents;
+	skel->rodata->user_buf_sz = sizeof(file_contents);
+	skel->bss->pid = getpid();
+	skel->bss->user_ptr = (char *)user_ptr;
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
index 000000000000..695ef6392771
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -0,0 +1,178 @@
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
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 10000000);
+} ringbuf SEC(".maps");
+
+struct elem {
+	struct file *file;
+	struct bpf_task_work tw;
+};
+
+int pid = 0;
+int err, run_success = 0;
+char *user_buf;
+const char *user_ptr;
+volatile const __u32 user_buf_sz;
+
+static int validate_file_read(struct file *file);
+static int task_work_callback(struct bpf_map *map, void *key, void *value);
+
+SEC("lsm/file_open")
+int on_open_expect_fault(void *c)
+{
+	struct bpf_dynptr dynptr;
+	struct file *file;
+	char *rbuf = NULL;
+	int local_err = 1;
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
+	rbuf = bpf_ringbuf_reserve(&ringbuf, user_buf_sz, 0);
+	if (!rbuf)
+		goto out;
+
+	local_err = bpf_dynptr_read(rbuf, user_buf_sz, &dynptr, 0, 0);
+	if (local_err == -EFAULT) { /* Expect page fault */
+		local_err = 0;
+		run_success = 1;
+	}
+out:
+	if (rbuf)
+		bpf_ringbuf_discard(rbuf, 0);
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
+	validate_file_read(file);
+	bpf_put_file(file);
+	return 0;
+}
+
+static int verify_dynptr_read(struct bpf_dynptr *ptr, u32 off, char *user_buf, u32 len)
+{
+	char *rbuf = NULL;
+	int err = 1, i;
+
+	rbuf = bpf_ringbuf_reserve(&ringbuf, len, 0);
+	if (!rbuf)
+		goto cleanup;
+
+	if (bpf_dynptr_read(rbuf, len, ptr, off, 0))
+		goto cleanup;
+
+	/* Verify file contents read from BPF is the same as the one read from userspace */
+	bpf_for(i, 0, len)
+	{
+		if (rbuf[i] != user_buf[i])
+			goto cleanup;
+	}
+	err = 0;
+
+cleanup:
+	if (rbuf)
+		bpf_ringbuf_discard(rbuf, 0);
+	return err;
+}
+
+static int validate_file_read(struct file *file)
+{
+	struct bpf_dynptr dynptr;
+	int local_err = 1, off;
+	char *ubuf = NULL;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto cleanup_file;
+
+	ubuf = bpf_ringbuf_reserve(&ringbuf, user_buf_sz, 0);
+	if (!ubuf)
+		goto cleanup_all;
+
+	local_err = bpf_copy_from_user(ubuf, user_buf_sz, user_buf);
+	if (local_err)
+		goto cleanup_all;
+
+	local_err = verify_dynptr_read(&dynptr, 0, ubuf, user_buf_sz);
+	off = 1;
+	local_err = local_err ?: verify_dynptr_read(&dynptr, off, ubuf + off, user_buf_sz - off);
+	off = user_buf_sz - 1;
+	local_err = local_err ?: verify_dynptr_read(&dynptr, off, ubuf + off, user_buf_sz - off);
+	/* Read file with random offset and length */
+	off = 4097;
+	local_err = local_err ?: verify_dynptr_read(&dynptr, off, ubuf + off, 100);
+
+	/* Adjust dynptr, verify read */
+	local_err = local_err ?: bpf_dynptr_adjust(&dynptr, off, off + 1);
+	local_err = local_err ?: verify_dynptr_read(&dynptr, 0, ubuf + off, 1);
+	/* Can't read more than 1 byte */
+	local_err = local_err ?: verify_dynptr_read(&dynptr, 0, ubuf + off, 2) == 0;
+	/* Can't read with far offset */
+	local_err = local_err ?: verify_dynptr_read(&dynptr, 1, ubuf + off, 1) == 0;
+cleanup_all:
+	if (ubuf)
+		bpf_ringbuf_discard(ubuf, 0);
+cleanup_file:
+	bpf_dynptr_file_discard(&dynptr);
+	if (local_err)
+		err = local_err;
+	else
+		run_success = 1;
+	return 0;
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


