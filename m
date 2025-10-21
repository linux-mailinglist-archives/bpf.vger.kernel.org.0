Return-Path: <bpf+bounces-71633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD526BF8824
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A91919C4D6F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CC527815E;
	Tue, 21 Oct 2025 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrmAwccH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8551A00CE
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077040; cv=none; b=f9gVLBzd9DWvx743NqVqa6nB+tM8/xxjdRRhASIo3TFht/QT/yRp6Zz6wPWquJweGXRAzVl8wqujkW4t9egOGdHvEMIfl8s32DgSogrArIJbM8gduBcV4Eg2mSkw9K2DfAImjCzW9kBrgTj1oA6AfDoSt+9E/NT/EDxF98M3RAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077040; c=relaxed/simple;
	bh=P6O1z+LyNk2xcZs3KkF81KgqLQ1HF3ZwSwSHIk0FuQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj+AY9hNLl8fxM8XeuEKo56jf4KYuo4PhjImXY1kGEQBgRUfoK2WLmcOycP0Pr7cHLzGGNpc+y22Op381z04G7BpCjHW4HUj9nSImCiLkJF3a5N7jZpOoyIdJDBiHTOm3jZb9hxqgDbk1ds9EWbk+lHCnoNvHbPkI1NZp4kJY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrmAwccH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427007b1fe5so3992697f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077034; x=1761681834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6af6S84scy6i2JNIp69tyQwBxlKwLay/FDQnhELadU=;
        b=KrmAwccHAUbRdOf1OqX4VPzxHBcQU5s5M+mYL90RBlueQSzpr2Q1rYRUTusIjELx+5
         dPf/RcFOerthD0VNr8OoNzxnEG8NjGSAW7LxYnSWoMYE39Ony02p0HlLlUzJfPMyyk4I
         Vwctp0V42VsvIv9y4m1ZC30nVGiPNANHCikSSp2avvQiamj7UU3L/aOB1AW1EwM5GVI4
         NXSqXco1tYmLyasyZS8yxVOxbyPH9dJeeNaelz6gilW+Og6nia5PPEPeZAXqW65RqtDl
         hlMdTGt+uoGC1KINEsqsyyN1F8nH5NkeIRtCvaI7jtnVOBrTyggaUC5eMLhzeXKY09jp
         437A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077034; x=1761681834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6af6S84scy6i2JNIp69tyQwBxlKwLay/FDQnhELadU=;
        b=WUe9JM5EosCPbzJ1ZYc0eE8xDt40W9j4U4Rtx4IiqkCjvcIgPGFQvUnLSJV004/Piu
         aQ6/h1neSgXfgTrcbvwG8qVYLsu7EGMsI5ZtmLH09hWnMWasyHDNpcmLoyKuELPURCbF
         fkn4BqotqoGWnv49ZfiBEuBugNLaMk71tRWgHDlJuS92Zx0mb5wa7vf4LjWPAXCKzP9E
         FXn8R9g+PZGGT7tIIBu0Q2RIV9ahKeBM9/QPt0G/itoMORbn14yT9y5d5qruTv3sWl2C
         tz6TZwDq2vI5KXwhyPCUib2jBtJDiXxRrllHOkTxuUn2SeHUk2esnkh++kcobz7s2wfX
         X+Tg==
X-Gm-Message-State: AOJu0YwLM8OrQk0l0fYsxyw4gGDc5EgkrWxSgtDUvB21l1qOH4ziKOo6
	50mGKSZT4bNHhReI/0awPgdZOlA2dK68pxIH/WXyylvzC9+KpEx/LACcY9iVzQ==
X-Gm-Gg: ASbGncsxdbSQdf9FJwl65m5Bn0c6bZb74DTn6Va74H0AcqRHyyrdKe+tOz43tjYDHn6
	YuQOuLKgYz86E858tVngUJfKWL7bJ3w2p+UVhxq8OwlrEWUzqO2hxHf3f4VpPE0zPC+SDGGmneu
	Jk9d3kw9emrARm9nqA3d491UbozzEm78avlupbgcwfcNrmv3EJMrfrVU2PuvAZR+BvMCkdQK4nX
	/8BkodcGkadbEyUdUWZ3VwTiyGwfst/B6jrP3i6cFGNjZsRV7iwjVEe4cWoVKAls76JLfbxzsMu
	E9yyE34GBL/Zh33h9g4q/8WE9Uoowx7aYMdnuKUqQQTPmkfe/+oUlLQ2OobsirQdxBV7wJJ/7Cq
	7SUBuniO7NCad6XUCUeWxxrIFknJDsoknK1okFQmUZBIhLeR5xCfSvEi31HPen1rmMrglnU0=
X-Google-Smtp-Source: AGHT+IF2t4ofkB01f0srh6kKqldlZ+pwclKWHfumfT8zD/RiBtHh3dTXYSdWfxaH3MZNDtUaoQnRmA==
X-Received: by 2002:a05:6000:2c0c:b0:427:928:78a0 with SMTP id ffacd0b85a97d-42709287a50mr11269711f8f.63.1761077034436;
        Tue, 21 Oct 2025 13:03:54 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b1260sm9671585e9.13.2025.10.21.13.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 10/10] selftests/bpf: add file dynptr tests
Date: Tue, 21 Oct 2025 21:03:34 +0100
Message-ID: <20251021200334.220542-11-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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


