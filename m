Return-Path: <bpf+bounces-36140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979BD942CF2
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 13:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2359F1F20616
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525921B013C;
	Wed, 31 Jul 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGzdrZ7T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B81B0128
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424127; cv=none; b=FX66x4yetNtXdw1b461Vxqvp7zJIBf5O25621i4jXlpRoTW8InutbINv6t9HrDQ0QkJpBG7FKtWTR550xtU45hpZY2fgo312Shj4/HR3hD4znKhIybgNhJK0cmdNf4rc6DO5NyBp6/pkjGk/8+UXq0ig1JYz7J7JyklcV0cOvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424127; c=relaxed/simple;
	bh=nDE9NqF6VorJNf0jXHJtUtUjLuKizS3Vk4XW9sI+17o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dR7oKdRHGVjqrMZxpc0S6qYH3IJNGAfuGozhYRQd+vpf7UyuHiLNMiQDfvPBhLNL49EtWpouOHrMmZeI1/xL9Mpp7iQz5ozFP32By3st9QuTY2irsiHj113aqE7h0/dDDoQ9sKQyleL0Zz37oUbwBXyKb0p3saJyszHziD1L+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGzdrZ7T; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a7d6a72ad99so262141566b.2
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722424124; x=1723028924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7GG0vSprBBOUJRCXP9BHnkFq1CioBdxNnkIZDa+DzE=;
        b=RGzdrZ7T5AKazNDVVqcX8ZOo9PgSqbIsV2NumR+UQcAv/kcIWoVkKSZ3ZPnyyq6kx+
         Qr3I0jE9hGmLDUHeBjhjFSrhp7KsSZTF6B9sDBxNlfJMhLAm7sK92iruO67T3Vmd9bdL
         5E48Cs3m74Kgr0XeKraNOQI17nt08ut+YXDfvN6MAaBKL2QuXVp1n6ZPXj+u81tmkdDx
         x6VvBCGMzXUXiiPJmJeQHzElsH1diEkax13AyF80LHaJ/RahV35V1NNi/z6++0SZ4O55
         GMF2tJnPciTyAd0yjXkiRYXTNjGKVZCVn2lfw8Y+WlxxmJfMQ8y2Qu/rX+BHU5fyH5sW
         xa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722424124; x=1723028924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7GG0vSprBBOUJRCXP9BHnkFq1CioBdxNnkIZDa+DzE=;
        b=nK9WPxbngWgM3aFs/ccJG2EVdOJ9IPqTBlxHnUnV4nL6yDu10gSAvGppDlShbvtm+E
         db7ZeAbmGhSHicj0CBxqP0qDvSUakfi3xeUSbQphDhvSPtm++DpJBuPC2noR1oqMP3Pp
         OSrb+kWLWDiqkS7PQCHIafCO0e+FETFc9BX8cgjONQi10ATHGUlITke1TYBSefBCoyv3
         pNGmeT3XZwPnqKPNojZQVSde0DvW6BoyKJBoqWjq0MB8kdQjqKb72Iw/0uC7pzxU1cv1
         ZZyXvSr5x9uSAbaJKIfQC35Nq5k4KfKXtzzb5P9IAy19N8iW31VtPOM4c/oXMLUXiOvE
         ISmQ==
X-Gm-Message-State: AOJu0Yxp6xtmJ5rA4ybbvmwwg350+IGDdQudpSdUrMzxl3RLDW+UmX6m
	4L0ylEn01gO0kUDR+rZqb/+SPF8VGyIfqWgdgjR0NVohXKnKQQn1q1JRdvz++i3Y0sc1a9hmvBj
	ZFEmubMFYnUgGbEnRIxC3R3LqwGSEJxn/oo4W6C+hU+Kmd3hQ7aqrq+9IxBORofRQB6ZlKohHUQ
	coW/185GHzFxY5OA51ABP5h5D1xoEyhhDofFSsZ9jyYSmFgSiGjd5ai2mU25e20tSOww==
X-Google-Smtp-Source: AGHT+IFfo7p7EKW5+dO1VaNll/ruC/0hriaNViiFUOpLjjla9Lp9nZ7ylsNkc58Ie9dqmwZhGQibGWephsXN0uR7EpKi
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:906:4ed2:b0:a7a:8c65:6429 with
 SMTP id a640c23a62f3a-a7d400ddb94mr1080566b.10.1722424124341; Wed, 31 Jul
 2024 04:08:44 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:08:32 +0000
In-Reply-To: <20240731110833.1834742-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240731110833.1834742-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240731110833.1834742-3-mattbobrowski@google.com>
Subject: [PATCH v4 bpf-next 2/3] selftests/bpf: add negative tests for new VFS
 based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a bunch of negative selftests responsible for asserting that the
BPF verifier successfully rejects a BPF program load when the
underlying BPF program misuses one of the newly introduced VFS based
BPF kfuncs.

The following VFS based BPF kfuncs are extensively tested within this
new selftest:

* struct file *bpf_get_task_exe_file(struct task_struct *);
* void bpf_put_file(struct file *);
* int bpf_path_d_path(struct path *, char *, size_t);

Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  26 +++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_vfs_reject.c | 161 ++++++++++++++++++
 3 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 828556cdc2f0..b0668f29f7b3 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -195,6 +195,32 @@ extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
  */
 extern void bpf_throw(u64 cookie) __ksym;
 
+/* Description
+ *	Acquire a reference on the exe_file member field belonging to the
+ *	mm_struct that is nested within the supplied task_struct. The supplied
+ *	task_struct must be trusted/referenced.
+ * Returns
+ *	A referenced file pointer pointing to the exe_file member field of the
+ *	mm_struct nested in the supplied task_struct, or NULL.
+ */
+extern struct file *bpf_get_task_exe_file(struct task_struct *task) __ksym;
+
+/* Description
+ *	Release a reference on the supplied file. The supplied file must be
+ *	acquired.
+ */
+extern void bpf_put_file(struct file *file) __ksym;
+
+/* Description
+ *	Resolve a pathname for the supplied path and store it in the supplied
+ *	buffer. The supplied path must be trusted/referenced.
+ * Returns
+ *	A positive integer corresponding to the length of the resolved pathname,
+ *	including the NULL termination character, stored in the supplied
+ *	buffer. On error, a negative integer is returned.
+ */
+extern int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz) __ksym;
+
 /* This macro must be used to mark the exception callback corresponding to the
  * main program. For example:
  *
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 67a49d12472c..14d74ba2188e 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -85,6 +85,7 @@
 #include "verifier_value_or_null.skel.h"
 #include "verifier_value_ptr_arith.skel.h"
 #include "verifier_var_off.skel.h"
+#include "verifier_vfs_reject.skel.h"
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
@@ -205,6 +206,7 @@ void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
 void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
+void test_verifier_vfs_reject(void)	      { RUN(verifier_vfs_reject); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
new file mode 100644
index 000000000000..d6d3f4fcb24c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/limits.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+static char buf[PATH_MAX];
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(get_task_exe_file_kfunc_null)
+{
+	struct file *acquired;
+
+	/* Can't pass a NULL pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(NULL);
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/inode_getxattr")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point to scalar, or struct with scalar")
+int BPF_PROG(get_task_exe_file_kfunc_fp)
+{
+	u64 x;
+	struct file *acquired;
+	struct task_struct *task;
+
+	task = (struct task_struct *)&x;
+	/* Can't pass random frame pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(task);
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(get_task_exe_file_kfunc_untrusted)
+{
+	struct file *acquired;
+	struct task_struct *parent;
+
+	/* Walking a trusted struct task_struct returned from
+	 * bpf_get_current_task_btf() yields an untrusted pointer.
+	 */
+	parent = bpf_get_current_task_btf()->parent;
+	/* Can't pass untrusted pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(parent);
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(get_task_exe_file_kfunc_unreleased)
+{
+	struct file *acquired;
+
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("release kernel function bpf_put_file expects")
+int BPF_PROG(put_file_kfunc_unacquired, struct file *file)
+{
+	/* Can't release an unacquired pointer. */
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(path_d_path_kfunc_null)
+{
+	/* Can't pass NULL value to bpf_path_d_path() kfunc. */
+	bpf_path_d_path(NULL, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_argument, struct task_struct *task)
+{
+	struct path *root;
+
+	/* Walking a trusted argument typically yields an untrusted
+	 * pointer. This is one example of that.
+	 */
+	root = &task->fs->root;
+	bpf_path_d_path(root, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
+{
+	struct path *pwd;
+	struct task_struct *current;
+
+	current = bpf_get_current_task_btf();
+	/* Walking a trusted pointer returned from bpf_get_current_task_btf()
+	 * yields an untrusted pointer.
+	 */
+	pwd = &current->fs->pwd;
+	bpf_path_d_path(pwd, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("kernel function bpf_path_d_path args#0 expected pointer to STRUCT path but R1 has a pointer to STRUCT file")
+int BPF_PROG(path_d_path_kfunc_type_mismatch, struct file *file)
+{
+	bpf_path_d_path((struct path *)&file->f_task_work, buf, sizeof(buf));
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("invalid access to map value, value_size=4096 off=0 size=8192")
+int BPF_PROG(path_d_path_kfunc_invalid_buf_sz, struct file *file)
+{
+	/* bpf_path_d_path() enforces a constraint on the buffer size supplied
+	 * by the BPF LSM program via the __sz annotation. buf here is set to
+	 * PATH_MAX, so let's ensure that the BPF verifier rejects BPF_PROG_LOAD
+	 * attempts if the supplied size and the actual size of the buffer
+	 * mismatches.
+	 */
+	bpf_path_d_path(&file->f_path, buf, PATH_MAX * 2);
+	return 0;
+}
+
+SEC("fentry/vfs_open")
+__failure __msg("calling kernel function bpf_path_d_path is not allowed")
+int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
+{
+	/* Calling bpf_path_d_path() from a non-LSM BPF program isn't permitted.
+	 */
+	bpf_path_d_path(path, buf, sizeof(buf));
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.46.0.rc2.264.g509ed76dc8-goog


