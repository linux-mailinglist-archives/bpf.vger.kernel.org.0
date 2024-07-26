Return-Path: <bpf+bounces-35715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862F93CFFB
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 10:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F789283E44
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA2176AD5;
	Fri, 26 Jul 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LswBZDZ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2417836A
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984178; cv=none; b=iZmjZ6luWtAudJ52ETdng0w9hfhpKZQWBH5SEYec1MTV5Qv/8EOkduryC0pcG2D9l85FrIVBMDH7UcuxpHLipmb85FGpiWFmwI1pMO9xofuND3wtpUV9a9EkRSwEXVhd+6BPyMrdvZIhuhhpsfXYpYNQ9whssnBFEZYCwVLUmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984178; c=relaxed/simple;
	bh=KUfooIJ8skAH2DfD1RUDOkI/ajVCinML9YKoUVSKDUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJTCaTbnVGBD1mFa3g82VL1XAYpgj2q/bfGXkHb/FpsRgnwHJwlNxKelznxxivQhtKnlDETA+aDgs8qr6loDr2QKzmKVSRxPxlDN2MTw97IbfYkJs2P/Yl06p4j/EmZ0IXHk3UzoCMbyXVA6Q4Axxsj2rAcj1RtQr5d6xRBgiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LswBZDZ7; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5a4c36f66c3so1480725a12.3
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721984175; x=1722588975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFbFIVHkPK2UqrN7rh36uBgPf7D38onpRqNoKGRGQDE=;
        b=LswBZDZ7eiT22FZDpfP/bRV6sicNKd0N9Ocp9kmX6GsfW4SFKpmUvUzmRP5JyWtY+B
         WiEsXdyITO8M6FanGP0LbCPbi5zHtgybxW9lcnAK9z1fUT51KAHMDz4D9XFzWnsfpL5J
         ik2gH6ccYLamwoaCCpXtQkyh972qaX682CBLOCg5L2YsR+YBNa0lLTj4b/ZTJjvAGFPd
         DBnvyLScgi8/QhUZJNe1+ZFSzIcXFK6bSGKgZ/SSLBgPVapOjC05Zelylrr3PbvwJ95N
         pqyUpZ3LeNRVNNhz/TABn+74OwjBRgwK1Q2X/8dkKL+0dYpL0+yGXu1u5PxQ6uj3A6Mh
         j6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984175; x=1722588975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFbFIVHkPK2UqrN7rh36uBgPf7D38onpRqNoKGRGQDE=;
        b=m9RbW03wtJq3IUsfaRhhfHJmHrW5/BP9PoAUtsJoam7p/+0SA4AfvtggFyyflvZVS8
         LxQvJuvGVUGe7dVPT+EmV18xxjv+N+7Lu9UCv9Y1ro/RwS6zS6LZPMG8yXQfhSeHYrEW
         ZxzRwMvEmOsFtgC4LrnF6DZimbrlkyGrQWMsCKmKGtj5+LcVBHFZO8WmIT1AVJAOQjN0
         6pSncKCEGL9Tel6Ix6ac0OV4GpG8+1ytQTh10LRzLAYuX1CNTqyCB653SVZIez4X1Rfg
         GkQht/GteEwilEIG5Hb88lY9DfmTzzPxE5VKcbSOJAbKRO51MphssfbC6D4A0qgxLe2A
         36lQ==
X-Gm-Message-State: AOJu0Yy62itsbQYlYgQgFukuvdCxg6atk5XVshZ+cmmmGTlQKIW7NHmj
	sxGTtsSijjNHQzo1xNCjXiNos4CG/tgSy75KAxKDX8nrbWrncxemALa1mufZip/nBTBMqqN1yw/
	CMnQOPTiicn4ZEDDUd32W7ar+4e4kslvGmBSlVgWw7QKlgZU2XHjX5rvW8fpEu7GU9TebL4GOr6
	8Aktx9b5Y1NC8uksWfUhdzeOuUIrVubrKuPXFsOkMwZRG6wQKUzOCP7365gSojYIp3Ew==
X-Google-Smtp-Source: AGHT+IEkJGTzmnbtX/ixGr/hdKtkig38/dfMGXy0WgZqI8VKGsQHO8XjGv/hY9dxS2ifKQWVC4K45hZRzUwZR10NqTHE
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:aa7:c499:0:b0:57d:4bd0:388c with
 SMTP id 4fb4d7f45d1cf-5ac2bfdad17mr3974a12.3.1721984174608; Fri, 26 Jul 2024
 01:56:14 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:56:03 +0000
In-Reply-To: <20240726085604.2369469-1-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726085604.2369469-1-mattbobrowski@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726085604.2369469-3-mattbobrowski@google.com>
Subject: [PATCH v3 bpf-next 2/3] selftests/bpf: add negative tests for new VFS
 based BPF kfuncs
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org, jannh@google.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, jolsa@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, 
	Matt Bobrowski <mattbobrowski@google.com>
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

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  26 +++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_vfs_reject.c | 196 ++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_vfs_reject.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 828556cdc2f0..8a1ed62b4ed1 100644
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
+ *	trusted/referenced.
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
index 000000000000..27666a8ef78a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -0,0 +1,196 @@
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
+	struct task_struct *fp;
+
+	fp = (struct task_struct *)&x;
+	/* Can't pass random frame pointer to bpf_get_task_exe_file(). */
+	acquired = bpf_get_task_exe_file(fp);
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
+SEC("lsm/file_open")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_get_task_exe_file")
+int BPF_PROG(put_file_kfunc_not_sleepable, struct file *file)
+{
+	struct file *acquired;
+
+	/* Can't call bpf_get_task_file() from non-sleepable BPF LSM program
+	 * types.
+	 */
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
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
+SEC("tp_btf/task_newtask")
+__failure __msg("calling kernel function bpf_get_task_exe_file is not allowed")
+int BPF_PROG(get_task_exe_file_kfunc_not_lsm_prog, struct task_struct *task)
+{
+	struct file *acquired;
+
+	/* bpf_get_task_exe_file() can only be called from a sleepable BPF LSM
+	 * program type.
+	 */
+	acquired = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+
+	bpf_put_file(acquired);
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
+SEC("fentry/vfs_open")
+__failure __msg("calling kernel function bpf_path_d_path is not allowed")
+int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
+{
+	/* Calling bpf_path_d_path() from a non-sleepable and non-LSM
+	 * BPF program isn't permitted.
+	 */
+	bpf_path_d_path(path, buf, sizeof(buf));
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
+char _license[] SEC("license") = "GPL";
-- 
2.46.0.rc1.232.g9752f9e123-goog


