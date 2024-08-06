Return-Path: <bpf+bounces-36521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAAB949BC5
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 01:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E41F24141
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6358171E5F;
	Tue,  6 Aug 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ/ExSdB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67480043
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985402; cv=none; b=hDWASywU1g4Rq2KlwVzeq3waRPEufbXPb/tHiOESl/S9VQNrc3OiCyfT5dm/sFrDYjVP37lMgp1GEv1F7ncloGX3IVIrzU6NBEmFQKnzepSmX6tvPs/40/htppQGKh8Lt+J+it4yq9vkovNTOetGyhTUb9UuZUH4nMSFCufo1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985402; c=relaxed/simple;
	bh=YP9NKszvfzFeylX/jQuIG434nytIgkIquDDDfhlNZ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXhRqIVgdd4bjNd+gPdar+cHeqbFTz+rhycgxmaa7zkTX1FTE+7CDHqNbecqilqmIqjShN3u84Zz+N4vW4Dv9zH+KmsraZhLyRFj4NvNYdBO2PZtfpIFCoacVWALC5NpkqxXfR5zvd8tdCgSORhDmy+6u64yPolyqi5i0TagBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ/ExSdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD15C32786;
	Tue,  6 Aug 2024 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722985401;
	bh=YP9NKszvfzFeylX/jQuIG434nytIgkIquDDDfhlNZ5I=;
	h=From:To:Cc:Subject:Date:From;
	b=QZ/ExSdB0DngKWHxPmWF9dxr+L1RqPk7EhzXduAJ4WLYh2jdOB0S54PAwJ8HWFJPj
	 iVrOW5c3UkyxTFji7n8wNeyxrOAasaXnEspUz26DCfD9P2wX9Q3ZsfWBiyQCScPoKU
	 mmd5SohsqQd7A7gx1AicbWMfmG3ONKHBN29pA30krILcW7TbdC2w/Oa3ec/o1sbGHd
	 n8DBAQJx8SNIuZYlBvPPCXP2toVgJm91lQQ6X2KdtRCtSiwn6QwCDEyw+7T0juIduU
	 nvBo9CJsAQWWKSzd9XmXx8lM4o6ing3fnJYsurSm0wFlKZ4/lAYG4ZI2caIBdtIkef
	 G5TitAhHIKQ/A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl if available
Date: Tue,  6 Aug 2024 16:03:19 -0700
Message-ID: <20240806230319.869734-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing text-based /proc/<pid>/maps file, try to use
PROCMAP_QUERY ioctl() to simplify and speed up data fetching.
This logic is used to do uprobe file offset calculation, so any bugs in
this logic would manifest as failing uprobe BPF selftests.

This also serves as a simple demonstration of one of the intended uses.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c    |   3 +
 tools/testing/selftests/bpf/test_progs.h    |   2 +
 tools/testing/selftests/bpf/trace_helpers.c | 104 +++++++++++++++++---
 3 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 60fafa2f1ed7..bf262b42a488 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -33,6 +33,8 @@ __weak void backtrace_symbols_fd(void *const *buffer, int size, int fd)
 	dprintf(fd, "<backtrace not supported>\n");
 }
 
+int env_verbosity = 0;
+
 static bool verbose(void)
 {
 	return env.verbosity > VERBOSE_NONE;
@@ -862,6 +864,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 				return -EINVAL;
 			}
 		}
+		env_verbosity = env->verbosity;
 
 		if (verbose()) {
 			if (setenv("SELFTESTS_VERBOSE", "1", 1) == -1) {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index cb9d6d46826b..43e3136166b3 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -95,6 +95,8 @@ struct test_state {
 	FILE *stdout_saved;
 };
 
+extern int env_verbosity;
+
 struct test_env {
 	struct test_selector test_selector;
 	struct test_selector subtest_selector;
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 465d196c7165..1bfd881c0e07 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -10,6 +10,8 @@
 #include <pthread.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
 #include <linux/limits.h>
@@ -244,29 +246,91 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 	return err;
 }
 
+#ifdef PROCMAP_QUERY
+int env_verbosity __weak = 0;
+
+int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
+{
+	char path_buf[PATH_MAX], build_id_buf[20];
+	struct procmap_query q;
+	int err;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_flags = query_flags;
+	q.query_addr = (__u64)addr;
+	q.vma_name_addr = (__u64)path_buf;
+	q.vma_name_size = sizeof(path_buf);
+	q.build_id_addr = (__u64)build_id_buf;
+	q.build_id_size = sizeof(build_id_buf);
+
+	err = ioctl(fd, PROCMAP_QUERY, &q);
+	if (err < 0) {
+		err = -errno;
+		if (err == -ENOTTY)
+			return -EOPNOTSUPP; /* ioctl() not implemented yet */
+		if (err == -ENOENT)
+			return -ESRCH; /* vma not found */
+		return err;
+	}
+
+	if (env_verbosity >= 1) {
+		printf("VMA FOUND (addr %08lx): %08lx-%08lx %c%c%c%c %08lx %02x:%02x %ld %s (build ID: %s, %d bytes)\n",
+		       (long)addr, (long)q.vma_start, (long)q.vma_end,
+		       (q.vma_flags & PROCMAP_QUERY_VMA_READABLE) ? 'r' : '-',
+		       (q.vma_flags & PROCMAP_QUERY_VMA_WRITABLE) ? 'w' : '-',
+		       (q.vma_flags & PROCMAP_QUERY_VMA_EXECUTABLE) ? 'x' : '-',
+		       (q.vma_flags & PROCMAP_QUERY_VMA_SHARED) ? 's' : 'p',
+		       (long)q.vma_offset, q.dev_major, q.dev_minor, (long)q.inode,
+		       q.vma_name_size ? path_buf : "",
+		       q.build_id_size ? "YES" : "NO",
+		       q.build_id_size);
+	}
+
+	*start = q.vma_start;
+	*offset = q.vma_offset;
+	*flags = q.vma_flags;
+	return 0;
+}
+#else
+int procmap_query(int fd, const void *addr, size_t *start, size_t *offset, int *flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 ssize_t get_uprobe_offset(const void *addr)
 {
-	size_t start, end, base;
-	char buf[256];
-	bool found = false;
+	size_t start, base, end;
 	FILE *f;
+	char buf[256];
+	int err, flags;
 
 	f = fopen("/proc/self/maps", "r");
 	if (!f)
 		return -errno;
 
-	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
-		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
-			found = true;
-			break;
+	/* requested executable VMA only */
+	err = procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTABLE, &start, &base, &flags);
+	if (err == -EOPNOTSUPP) {
+		bool found = false;
+
+		while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
+			if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			fclose(f);
+			return -ESRCH;
 		}
+	} else if (err) {
+		fclose(f);
+		return err;
 	}
-
 	fclose(f);
 
-	if (!found)
-		return -ESRCH;
-
 #if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
 
 #define OP_RT_RA_MASK   0xffff0000UL
@@ -307,15 +371,25 @@ ssize_t get_rel_offset(uintptr_t addr)
 	size_t start, end, offset;
 	char buf[256];
 	FILE *f;
+	int err, flags;
 
 	f = fopen("/proc/self/maps", "r");
 	if (!f)
 		return -errno;
 
-	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
-		if (addr >= start && addr < end) {
-			fclose(f);
-			return (size_t)addr - start + offset;
+	err = procmap_query(fileno(f), (const void *)addr, 0, &start, &offset, &flags);
+	if (err == 0) {
+		fclose(f);
+		return (size_t)addr - start + offset;
+	} else if (err != -EOPNOTSUPP) {
+		fclose(f);
+		return err;
+	} else if (err) {
+		while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
+			if (addr >= start && addr < end) {
+				fclose(f);
+				return (size_t)addr - start + offset;
+			}
 		}
 	}
 
-- 
2.43.5


