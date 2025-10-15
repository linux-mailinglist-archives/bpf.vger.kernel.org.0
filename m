Return-Path: <bpf+bounces-71029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A49BDF97D
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92E64357BF5
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098213375A2;
	Wed, 15 Oct 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6DfkiPL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCF335BC7
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544733; cv=none; b=b23/udkYZlVg6xw+peZeNuGW//7DElZnIPMQsQlJdV4CHQ1w1klQbxdM8koqeNKCvf8fA8dlDgRk2Vu46+RPsUNkWLKWgLpLYugwipU+3tDrg8HepV6AQLbGDTlGLmPkvoGebolpPH6jb7GSYOk8p1gl42w5fOde8zv6OHupim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544733; c=relaxed/simple;
	bh=EMGSzEyk1jG30EqsbUWJXOo06IFaKhW6GTX6I6gxho4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5gLk1yFayvGpINaSP3BphOqQlwzeyfHzKtmsIkrvftpovC4RPO4ouFdhPE8fDYrrnhtj2AtAxrmk/wVb0OA4oGBu08lNfKlun3UrTarQqf6r0ARtIjdGd4eA86nDrmnwLolzFH52vOXgRkveJzcIEopREf9IgfFDjTCgDXnA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6DfkiPL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b303f7469so47104095e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544730; x=1761149530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFoEHEzMHX3evbH5+YpE4UuVmXP7bc57MNVAuBp7bz4=;
        b=Z6DfkiPL1XWc5GIFi35QQE9Ya8VPKrg2DzGz+MRcFGpIHSzK3xyM1KXTgmKj5oJVwh
         YluBKyFH4UbPtihPOERN1cTWDYokqdwcBg733N/+bPJGDHzmPZ+fw4ykC5or52wMAQLc
         OD58Jq9al3bY7w3EFbCnm3OMxrldEjCS7vXQW4lqi/jjQV29YWNOYrOZx9ex+Pw0/E35
         dFHeRYGzGMm0hpmPoTYDzaZtK+p4hyrkHOt/m2A8qRKBxKBbFRlMeWY7LdMJPzj1ouRK
         o9iP1IMDGkArR5tE5xCv46q6zTqa7/XOEViFZopp1Il4kGOUk5iPNWZ6x9ufYmiRQDIw
         d/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544730; x=1761149530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFoEHEzMHX3evbH5+YpE4UuVmXP7bc57MNVAuBp7bz4=;
        b=fM7abkh1ySP3z1LK+ch6eMlg0RjfF/HYdQ4FFU3czSDB7/ne2kHRfan4mUOJuDhXWq
         4W63izGwu3Z4v14/70fLSEg7vTCJ4On2RGl5/J2cw/ez9Q6q0tM9KK8x0ynzJNZE7L07
         gn1REdqUhKcB78USmQlpVTBJxgngnL2HLL4cfyMbh8zdZR2CRoz7H9N7g462enVAjRWh
         WSBizHh5f795Ty2uF8UQAGQ1ts+s0fhCxmGcYiLAhFr5kvbE9NRzSgTMRPDRVjSZS9xE
         hpj9ECPH7rqR5jYey64tyK/2oClDc9Pt7kuFUsQqMhu69nxq0KcO+HO85wwVGkLp+/4m
         MQow==
X-Gm-Message-State: AOJu0YzQ2lvjqe1Mn5XB5E5blZykoKelnYFOdXnNe9q8QBYv6gxxsaij
	81W0waoKSIHF2eGNKI69cr+wHnX/F3iDrxOW6PO1OtMld/3sGrd3HeIsjBnnhw==
X-Gm-Gg: ASbGncvsDodaTYTELFTdPL2qonbMdY0jFJJkhaQDVSkSrGnkLiDjC83YxHKsoEE7H9/
	2FbU84I4jGUR27vcgGoXGZhxqOMgrw9p75gLrwy03usP72NVV/hfS+cBBce0MKY4FXFIb2VV4km
	pZg08X+3iThir7mz2A785uuoI+HxN8hKnN2sYgyz5vKf4D7bKLoPZNVrVsykDWGA91dGn6vM4hX
	2mzKCb0GZxyZRwHIwFBnxJ8xRJ6a3R+G3ShlY6rfPeHdFD5kji+Oi4C619OdU4Yd8YslHVbouho
	NtFMn2Jc4N/PyDeWT0TyF8d3PxnXZSLCq0MOs2GtSs0JXHTI+7KA7M7hS0/5menEidtgqOarMHC
	xIXa3D3v7L4xiE3zkIgsDyzOUR7gWCCKtk7popIaYV9UR3Fvfaqv522Rk/LofQ5BSYw==
X-Google-Smtp-Source: AGHT+IFiclgoGHys6O4aLoq+5kJW2skr3rbtv+IGei5tHeoCAdVInhg5qkztJkY7bF/Opjj5Xh6WCg==
X-Received: by 2002:a05:600c:314b:b0:46e:2109:f435 with SMTP id 5b1f17b1804b1-46fa9a966f6mr190234855e9.11.1760544729801;
        Wed, 15 Oct 2025 09:12:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483bcf9sm312853095e9.6.2025.10.15.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:09 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
Date: Wed, 15 Oct 2025 17:11:55 +0100
Message-ID: <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/prog_tests/file_reader.c    | 114 +++++++++++++
 .../testing/selftests/bpf/progs/file_reader.c | 157 ++++++++++++++++++
 2 files changed, 271 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
new file mode 100644
index 000000000000..f4f52dfcb2a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "file_reader.skel.h"
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
+	if (!ASSERT_GT(fd, 0, "Open /proc/self/exe\n"))
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
+	int err;
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
+		if (strcmp(bpf_program__name(prog), prog_name) == 0)
+			bpf_program__set_autoload(prog, true);
+		else
+			bpf_program__set_autoload(prog, false);
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
+	getpid();
+
+	ASSERT_EQ(skel->bss->err, 0, "err");
+cleanup:
+	file_reader__destroy(skel);
+}
+
+void test_file_reader(void)
+{
+	if (test__start_subtest("on_getpid_expect_fault"))
+		run_test("on_getpid_expect_fault");
+
+	if (test__start_subtest("on_getpid_validate_file_read"))
+		run_test("on_getpid_validate_file_read");
+}
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
new file mode 100644
index 000000000000..fce0b40367fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -0,0 +1,157 @@
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
+int err;
+char *user_buf;
+const char *user_ptr;
+volatile const __u32 user_buf_sz;
+
+static int validate_file_read(struct task_struct *task, struct vm_area_struct *vma, void *data);
+static int task_work_callback(struct bpf_map *map, void *key, void *value);
+static int dynptr_file_read_fault(struct task_struct *task, struct vm_area_struct *vma, void *data);
+
+SEC("raw_tp/sys_enter")
+int on_getpid_expect_fault(void *c)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	/* Verify that in non-sleepable context read faults */
+	bpf_find_vma(task, (unsigned long)user_ptr, dynptr_file_read_fault, NULL, 0);
+	return 0;
+}
+
+/* Tries to read user_buf_sz bytes from file dynptr, returns read error */
+static int dynptr_file_read_fault(struct task_struct *task, struct vm_area_struct *vma, void *data)
+{
+	struct bpf_dynptr dynptr;
+	struct file *file = vma->vm_file;
+	char *rbuf = NULL;
+	int local_err = 1;
+
+	if (!file) {
+		err = 1;
+		return 0;
+	}
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	rbuf = bpf_ringbuf_reserve(&ringbuf, user_buf_sz, 0);
+	if (!rbuf)
+		goto out;
+
+	local_err = bpf_dynptr_read(rbuf, user_buf_sz, &dynptr, 0, 0);
+	local_err = local_err == -EFAULT ? 0 : 1; /* Expect page fault */
+out:
+	if (rbuf)
+		bpf_ringbuf_discard(rbuf, 0);
+	bpf_dynptr_file_discard(&dynptr);
+	if (local_err)
+		err = local_err;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int on_getpid_validate_file_read(void *c)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct elem *work;
+	int key = 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
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
+
+	bpf_find_vma(task, (unsigned long)user_ptr, validate_file_read, NULL, 0);
+	return 0;
+}
+
+static int validate_file_read(struct task_struct *task, struct vm_area_struct *vma, void *data)
+{
+	struct bpf_dynptr dynptr;
+	int local_err = 1, i;
+	char *rbuf1 = NULL, *rbuf2 = NULL;
+	struct file *file = vma->vm_file;
+
+	if (!file) {
+		err = 1;
+		return 1;
+	}
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto cleanup_file;
+
+	rbuf1 = bpf_ringbuf_reserve(&ringbuf, user_buf_sz, 0);
+	if (!rbuf1)
+		goto cleanup_file;
+
+	rbuf2 = bpf_ringbuf_reserve(&ringbuf, user_buf_sz, 0);
+	if (!rbuf2)
+		goto cleanup_all;
+
+	if (bpf_dynptr_read(rbuf1, user_buf_sz, &dynptr, 0, 0))
+		goto cleanup_all;
+
+	bpf_copy_from_user(rbuf2, user_buf_sz, user_buf);
+	/* Verify file contents read from BPF is the same as the one read from userspace */
+	bpf_for(i, 0, user_buf_sz)
+	{
+		if (i >= 256000 || rbuf1[i] != rbuf2[i])
+			goto cleanup_all;
+	}
+	local_err = 0;
+
+cleanup_all:
+	if (rbuf1)
+		bpf_ringbuf_discard(rbuf1, 0);
+	if (rbuf2)
+		bpf_ringbuf_discard(rbuf2, 0);
+cleanup_file:
+	bpf_dynptr_file_discard(&dynptr);
+	if (local_err)
+		err = local_err;
+	return 0;
+}
-- 
2.51.0


