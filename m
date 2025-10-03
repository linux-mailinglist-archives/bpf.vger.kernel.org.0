Return-Path: <bpf+bounces-70314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D17BB7721
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E883BB5E2
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B22BE7CD;
	Fri,  3 Oct 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8AOywVd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D062BE630
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507489; cv=none; b=VTjNx4pgNEKAUwGAd62mAnCGOSVagYFqF2F88K/CPQsvxTuta4oJBF3YPzmViS6rvkjoEANOvmYS/CgtHqQxqbJ+2r36NsS0ChICIGNGALV1nWwDSYIHurXu6gZ50/xDscN1dUin4zVNB61Udv/gP1Ut4JujnNzT0Qz1nRHQJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507489; c=relaxed/simple;
	bh=gJYMcFjjoobyr1a8CafZQDRkVKBPhcZoTJ97YwdXb70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SapPmUo7Lp7cMYQ7U0hOhJ3bLS1uvVuIZqVqzzNFb7fjP5rySP8mx9fSPylx5343j7NAM4yIcvDGYlKlOzDFZpHPWrUA4ffDhetiMu+PhHYY1odT4sL8mtl1D0ew2hNftI0J99tPcjJ19PT0cpiQ23sImCl8/Pd5GvsSIwza6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8AOywVd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso18117385e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507485; x=1760112285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beCI3XZXptyKkhu5ZRYHLLi7WsbjiQm4vqBKRxJy0qk=;
        b=D8AOywVdvxAzgP9SZjE340wqCXoX4/wRBNczuD59OBf6y/ddyzhs8I8eL3hX60DSAn
         uh1qv2V0OsrPocT6VgWSGsUZvIlCauIWFf//0JfATTDDJWM5mfzpfE1rwYD0GzUydUdU
         /E+RelLKlS+CSj0F9RK1mNUQEh73de9RMEvsz8Wo0FDeZjihl7takaXBA+JOOuscgZag
         V2wxq1gmfbWs2ApS4DVa+51eJ+hf4RMx5tlaJzb0bH3WX3Jf/Z4G+qF+3rv8i3uoHJQQ
         B3lCXQLXwsgAsNdecsZ0l2C7Pj7y6PSHRcOAm6StSZ9RFQAdy1UDEXauyiZOWgfM2BXJ
         H5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507485; x=1760112285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beCI3XZXptyKkhu5ZRYHLLi7WsbjiQm4vqBKRxJy0qk=;
        b=oTEt1vUoGTOO9ZCwFsWlWfwc3WaEh15VzE4+sKoyFN0RbR8eb5cJXfmg6MjlOFT1JB
         7jVA9jfJPH6l+L9hflhgzfFyFjiGd0IMHKM2dJtmWi+ZUw+uHDDZDKUCX0BXVgweDth5
         Jk/8vSxIB1jr6TCav6+IpUHw9j3jhvWu0K4FkBrr71xsKewmqlrebbS3XTCVirYK0Cqm
         VL1Tn3czKZypquM6yVxrZvMMjOfFLE42IDpxAJCWm4x5MLKvrlof/6lBTA9gsAoHW+ls
         lXxX9h20K259+k8TZ0j6/gJ6GY8AgGoM0UPjnaR2hIIFg/yKA15Qtry2hGi1z8C/zGfC
         ykeA==
X-Gm-Message-State: AOJu0Yy8RMUoRp8oyDyDiwUAXvGAi+gBI1nDb186gy3Fo8EEaSarvO7D
	H7nYYfKCBTG0Y3YILROf5wOn6EgX9oXEO/q5DshPzqFkBlBV9CqFS6BZZ0r5lw==
X-Gm-Gg: ASbGnctzIiZcSbtnXGsARogP4oGCk8F+ZWZ6SHuP6vyi3qpJsFLLlmAyqmHXimL/F4L
	koXSgEXT+UxS/l/JEEnlZZbFWMmFHkFRbU23OHDP4YctrCR/7d1Vur73QDaF9kutjyulzRcw4Ao
	9dg7KSRpzoE9OAWBel4jfaTAFZaG0U4gW39l5YokjaaigdsyJ7xMGo+h7WVYwlsrvESVwd3sJnL
	HDUbma0gfB/NblQVWk2dsImEFGkBFlLFrb/DYfT0vW3s7qHR8SpbFNWXxw9EToOgWGvORKXFDS2
	EfHC/KaMd93qHwuHNGGuI5vEixMd41RExrSOd77zwIZbvpcVGzWUdZhHo4dGSSniG+k0v8GwscT
	0XWKz1udazAj+HHxoLQ54NW2fXuQrCvWSJ1yi
X-Google-Smtp-Source: AGHT+IE+r1wKxJ5O34+3P1EM0CBEybVg2+bZ0rtge+fHmWeKE4eejO0ghvLofw8HNiJ8Hy2XPor9QQ==
X-Received: by 2002:a05:600c:408a:b0:46d:38c4:1ac9 with SMTP id 5b1f17b1804b1-46e68ba134bmr39024355e9.2.1759507484953;
        Fri, 03 Oct 2025 09:04:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ac750sm8541636f8f.24.2025.10.03.09.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:44 -0700 (PDT)
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
Subject: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
Date: Fri,  3 Oct 2025 17:04:16 +0100
Message-ID: <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
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

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/file_reader.c    |  81 ++++++
 .../testing/selftests/bpf/progs/file_reader.c | 241 ++++++++++++++++++
 .../selftests/bpf/progs/file_reader_fail.c    |  57 +++++
 3 files changed, 379 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_reader_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
new file mode 100644
index 000000000000..b314ad4326f1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "file_reader.skel.h"
+#include "file_reader_fail.skel.h"
+
+__thread int tls_counter;
+const char *user_ptr = "hello world";
+char file_contents[256000];
+
+enum file_reader_test {
+	VALIDATE_LARGE_FILE = 1,
+	SEARCH_ELF = 2,
+};
+
+static int initialize_file_contents(void)
+{
+	int fd;
+	ssize_t n;
+	int err = 0;
+
+	fd = open("/proc/self/exe", O_RDONLY);
+	if (!ASSERT_GT(fd, 0, "Open /proc/self/exe\n"))
+		return 1;
+
+	n = read(fd, file_contents, sizeof(file_contents));
+	if (!ASSERT_EQ(n, sizeof(file_contents), "Read /proc/self/exe\n"))
+		err = 1;
+
+	posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
+	close(fd);
+	return err;
+}
+
+static void run_test(enum file_reader_test test_type)
+{
+	struct file_reader *skel;
+	int err;
+	char data[256];
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = &data, .repeat = 1,
+		    .data_size_in = sizeof(data));
+
+	skel = file_reader__open();
+	if (!ASSERT_OK_PTR(skel, "file_reader__open"))
+		return;
+
+	skel->bss->user_ptr = (void *)user_ptr;
+	skel->bss->user_buf = file_contents;
+	skel->rodata->user_buf_sz = sizeof(file_contents);
+	skel->rodata->test_type = test_type;
+
+	err = file_reader__load(skel);
+	if (!ASSERT_OK(err, "file_reader__load"))
+		return;
+
+	err = initialize_file_contents();
+	if (!ASSERT_OK(err, "initialize file contents"))
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
+	if (test__start_subtest("test_large_file"))
+		run_test(VALIDATE_LARGE_FILE);
+	if (test__start_subtest("test_search_elf"))
+		run_test(SEARCH_ELF);
+
+	RUN_TESTS(file_reader_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
new file mode 100644
index 000000000000..9dd9a68f3563
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <string.h>
+#include <stdbool.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+#define ELFMAG "\177ELF"
+#define SELFMAG 4
+#define ET_NONE 0
+#define ET_REL 1
+#define ET_EXEC 2
+#define ET_DYN 3
+#define ET_CORE 4
+#define ET_LOPROC 0xff00
+#define ET_HIPROC 0xffff
+#define EI_CLASS 4
+#define ELFCLASS32 1
+#define ELFCLASS64 2
+#define STT_TLS 6
+
+#define ELF_ST_BIND(x) ((x) >> 4)
+#define ELF_ST_TYPE(x) ((x) & 0xf)
+#define ELF32_ST_BIND(x) ELF_ST_BIND(x)
+#define ELF32_ST_TYPE(x) ELF_ST_TYPE(x)
+#define ELF64_ST_BIND(x) ELF_ST_BIND(x)
+#define ELF64_ST_TYPE(x) ELF_ST_TYPE(x)
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
+enum file_reader_test {
+	VALIDATE_LARGE_FILE = 1,
+	SEARCH_ELF = 2,
+};
+
+int err;
+void *user_ptr;
+char buf[1024];
+char *user_buf;
+volatile const __u32 user_buf_sz;
+volatile const __s32 test_type = -1;
+
+static int process_vma(struct task_struct *task, struct vm_area_struct *vma, void *data);
+static int search_elf(struct file *file);
+static int validate_large_file_read(struct file *file);
+static int task_work_callback(struct bpf_map *map, void *key, void *value);
+
+SEC("raw_tp/sys_enter")
+int on_getpid(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct elem *work;
+	int key = 0;
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
+static int task_work_callback(struct bpf_map *map, void *key, void *value)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	bpf_find_vma(task, (unsigned long)user_ptr, process_vma, NULL, 0);
+	return 0;
+}
+
+static int process_vma(struct task_struct *task, struct vm_area_struct *vma, void *data)
+{
+	switch (test_type) {
+	case VALIDATE_LARGE_FILE:
+		err = validate_large_file_read(vma->vm_file);
+		break;
+	case SEARCH_ELF:
+		err = search_elf(vma->vm_file);
+		break;
+	default:
+		err = 1;
+	}
+	return err;
+}
+
+static int validate_large_file_read(struct file *file)
+{
+	struct bpf_dynptr dynptr;
+	int err, i;
+	char *rbuf1 = NULL, *rbuf2 = NULL;
+
+	if (!file) {
+		err = 1;
+		return 1;
+	}
+
+	err = bpf_dynptr_from_file(file, 0, &dynptr);
+	if (err)
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
+	bpf_dynptr_read(rbuf1, user_buf_sz, &dynptr, 0, 0);
+	bpf_copy_from_user(rbuf2, user_buf_sz, user_buf);
+	/* Verify file contents read from BPF is the same as the one read from userspace */
+	bpf_for(i, 0, user_buf_sz) {
+		if (i >= 256000 || rbuf1[i] != rbuf2[i]) {
+			err = 1;
+			break;
+		}
+	}
+
+cleanup_all:
+	if (rbuf1)
+		bpf_ringbuf_discard(rbuf1, 0);
+	if (rbuf2)
+		bpf_ringbuf_discard(rbuf2, 0);
+cleanup_file:
+	bpf_dynptr_file_discard(&dynptr);
+	return err ? 1 : 0;
+}
+
+/* Finds thread local variable `tls_counter` in this executable's ELF */
+static int search_elf(struct file *file)
+{
+	Elf64_Ehdr ehdr;
+	Elf64_Shdr shdrs;
+	Elf64_Shdr symtab, strtab, tmp;
+	const Elf64_Sym *symbol;
+	int count, off, i, e_shnum, e_shoff, e_shentsize, sections = 0;
+	const char *string;
+	struct bpf_dynptr dynptr;
+	const __u32 slen = 11;
+	static const char *needle = "tls_counter";
+
+	if (!file) {
+		err = 1;
+		return 1;
+	}
+
+	err = bpf_dynptr_from_file(file, 0, &dynptr);
+	if (err)
+		goto fail;
+
+	err = bpf_dynptr_read(&ehdr, sizeof(ehdr), &dynptr, 0, 0);
+	if (err)
+		goto fail;
+
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0)
+		goto fail;
+
+	if (ehdr.e_type != ET_EXEC && ehdr.e_type != ET_DYN)
+		goto fail;
+
+	if (ehdr.e_ident[EI_CLASS] != ELFCLASS64)
+		goto fail;
+
+	e_shnum = ehdr.e_shnum;
+	e_shoff = ehdr.e_shoff;
+	e_shentsize = ehdr.e_shentsize;
+
+	err = bpf_dynptr_read(&shdrs, sizeof(shdrs), &dynptr,
+			      e_shoff + e_shentsize * ehdr.e_shstrndx, 0);
+	if (err)
+		goto fail;
+
+	off = shdrs.sh_offset;
+
+	__builtin_memset(&symtab, 0, sizeof(symtab));
+	__builtin_memset(&strtab, 0, sizeof(strtab));
+	bpf_for(i, 0, e_shnum)
+	{
+		err = bpf_dynptr_read(&tmp, sizeof(Elf64_Shdr), &dynptr, e_shoff + e_shentsize * i,
+				      0);
+		if (err)
+			goto fail;
+
+		string = bpf_dynptr_slice(&dynptr, off + tmp.sh_name, buf, slen);
+		if (!string)
+			goto fail;
+
+		if (bpf_strncmp(string, slen, ".symtab") == 0) {
+			symtab = tmp;
+			++sections;
+		} else if (bpf_strncmp(string, slen, ".strtab") == 0) {
+			strtab = tmp;
+			++sections;
+		}
+		if (sections == 2)
+			break;
+	}
+	if (sections != 2)
+		goto fail;
+
+	count = symtab.sh_size / sizeof(Elf64_Sym);
+	bpf_for(i, 0, count)
+	{
+		symbol = bpf_dynptr_slice(&dynptr, symtab.sh_offset + sizeof(Elf64_Sym) * i, buf,
+					  sizeof(Elf64_Sym));
+		if (!symbol)
+			goto fail;
+		if (symbol->st_name == 0 || ELF64_ST_TYPE(symbol->st_info) != STT_TLS)
+			continue;
+		string = bpf_dynptr_slice(&dynptr, strtab.sh_offset + symbol->st_name, buf, slen);
+		if (!string)
+			goto fail;
+		if (bpf_strncmp(string, slen, needle) == 0)
+			goto success;
+	}
+fail:
+	err = 1;
+success:
+	bpf_dynptr_file_discard(&dynptr);
+	return err ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
new file mode 100644
index 000000000000..449c4f9a1c74
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -0,0 +1,57 @@
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
+char buf[256];
+
+static long process_vma_unreleased_ref(struct task_struct *task, struct vm_area_struct *vma,
+				       void *data)
+{
+	struct bpf_dynptr dynptr;
+
+	if (!vma->vm_file)
+		return 1;
+
+	err = bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
+	return err ? 1 : 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
+__failure __msg("Unreleased reference id=") int on_nanosleep_unreleased_ref(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unreleased_ref, NULL, 0);
+	return 0;
+}
+
+SEC("xdp")
+__failure __msg("Expected a dynptr of type file as arg #0")
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
+__failure __msg("Expected an initialized dynptr as arg #0")
+int xdp_no_dynptr_type(struct xdp_md *xdp)
+{
+	struct bpf_dynptr dynptr;
+
+	bpf_dynptr_file_discard(&dynptr);
+	return 0;
+}
-- 
2.51.0


