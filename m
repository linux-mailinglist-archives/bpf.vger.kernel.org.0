Return-Path: <bpf+bounces-50226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B851A24349
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550901889885
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120611F3FDB;
	Fri, 31 Jan 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im9pBRlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285B1F3D38;
	Fri, 31 Jan 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351769; cv=none; b=kAwjP7VYPXj9dZAu98mlVd8emU7Tb6OR3Q5wxA+yH6rxZvP9A5ja/lcl+yagq5JAuh7BdhMjgaI1c2q0GNCOTa5DyyTAeffxxfcPbmXHk6QqGSEkXv+XX7XMHxhAooBxf+iKKmpXQIxHTHqB56NEFUIyDo8BMLvEe65jJ3p8ams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351769; c=relaxed/simple;
	bh=KFrnSOYoyPuxNOt/FuXtfX4w07l7a5dNldJmOMjDc/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMe5iCJ37AXNjOrasDaJNs9hdvUWhVO9FraI1U2eZ3pbitu1NK/y+8YrY7YFfmnL8GDyOvzxacFLELIz13gliyGhojtSF44m4FFRyCC7NrEeFo1njpvlblYDyy/V3AlWPQLsdb0uqadLX6Six8dn2C3nSksu0hp0LIqUu/LsmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im9pBRlW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso3239146a91.3;
        Fri, 31 Jan 2025 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351767; x=1738956567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VE1mjTWAjK2f8mnRBq6Pc8Xh+C0vPWa7z7jgNYsPk8=;
        b=Im9pBRlWOspF7mh4Ifwd6on2htHvqniwAo07vjO9Qa7tIG8GqoyhzpJUg5MAH++3ci
         h7DSKlsxQ0ArfHigWSNTCyh20YxzQtFyJvKL03CFuojTMzf8IEvkDMNOExAUZZs/Lbyw
         Uwt461Xb5qHbyYCJqapieeMgXSeXxcG/5RwQkzUHwVa/UrgLFhisCcyY+dwm1n6zvyio
         ZgBOJrcLFH4zCsG7BMQxYGIaq80DNTR4d1kD+Z+N41AgYkAcIK0cXe+e5sw+FLQeUgin
         QEn4P7nnsg9At6T7yrnjVt70zVtDBsMKdiB1kkryigpoDwWOeEoeQkroCg9FvxtvvUnI
         xN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351767; x=1738956567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VE1mjTWAjK2f8mnRBq6Pc8Xh+C0vPWa7z7jgNYsPk8=;
        b=DYXZ5XmllFQzz1Q1oVTLx2aBE/r4jwWRE8mqqyq2TE4vufz63shMLFKnRg8NvlQ+ER
         QpBziGhwzBcYY+bKmNP50VwolpwQMhwOhxWhmB+Dcsse9sDKsGbSX5G5UmZOav0r9KQR
         TFHX0e/EB3JD2T2czBi7brgl41BgEzjRn5hgtO+Rp2O75YnvrbjrJ/3maUyJY7DUf60i
         yAr0GewoKZgxjsZMIWwx/NoRC5FBgnZC9lMaKM4OZU/yyQKuCo6nKoQHru3sX3Cqfm4L
         ebP05tuYdFTVNrH5vZEcinW57Byup8Hz/K5RBn7R8rjPBpvQWALpsxmoNRrZShtzstb2
         Gy7g==
X-Gm-Message-State: AOJu0YxU6r1SniemvjciPqLgxjvB7BL+81tiVgB6FrzWarvBP6d2RO4D
	RFUWhz/Ihopnfy/ueaYJfYYLPRQ2NbLNs/naj4mj1rQPPPuYnyPQGjcV42x20B4=
X-Gm-Gg: ASbGnctLnqRRlk+qug54GabPe2ViQmequ8nk1bM2wvk8RrSfSnH0i9NyCAWj8L3SSvX
	MuvYpLTq0Hu2cRmEJiZbJ+1v/PaH8fEOuh4pP4Jo+DB2tD5Eezy4A6/XTQUJu7NiAY0A/usmHke
	Dh+NkEQi8kIfX34/es0BS8ZR4ca7A3zCfpgUFBgHhyLqJsD0Lj4XpZ6zyTvWrDFEi3itF23gEpu
	QrkpyAytk5J0GyDKMvaVKdmN/U1U64hhl8Jco/E3nktOPRmzkcb/7fgGwSzmW2W3JLOM/fevK6h
	WAMv/zW7OFO7cZdC3JWLW1SxYhUQqnVcYsHTGp2q3Ro4OsqOvYUylSzlXql+Cfd53Q==
X-Google-Smtp-Source: AGHT+IHeP0WZnlh3IOjIJfedvQ4f5dqbo6l98X0OwbCowK/uCdwALebtAttGbwDgmozRpQjS59P74w==
X-Received: by 2002:a17:90b:5445:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2f83abdeb6fmr18883584a91.9.1738351767020;
        Fri, 31 Jan 2025 11:29:27 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:26 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/18] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Fri, 31 Jan 2025 11:28:44 -0800
Message-ID: <20250131192912.133796-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Test struct_ops programs returning referenced kptr. When the return type
of a struct_ops operator is pointer to struct, the verifier should
only allow programs that return a scalar NULL or a non-local kptr with the
correct type in its unmodified form.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../prog_tests/test_struct_ops_kptr_return.c  | 16 +++++++++
 .../bpf/progs/struct_ops_kptr_return.c        | 30 ++++++++++++++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 26 ++++++++++++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 34 +++++++++++++++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 25 ++++++++++++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 30 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  8 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  4 +++
 8 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
new file mode 100644
index 000000000000..467cc72a3588
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
@@ -0,0 +1,16 @@
+#include <test_progs.h>
+
+#include "struct_ops_kptr_return.skel.h"
+#include "struct_ops_kptr_return_fail__wrong_type.skel.h"
+#include "struct_ops_kptr_return_fail__invalid_scalar.skel.h"
+#include "struct_ops_kptr_return_fail__nonzero_offset.skel.h"
+#include "struct_ops_kptr_return_fail__local_kptr.skel.h"
+
+void test_struct_ops_kptr_return(void)
+{
+	RUN_TESTS(struct_ops_kptr_return);
+	RUN_TESTS(struct_ops_kptr_return_fail__wrong_type);
+	RUN_TESTS(struct_ops_kptr_return_fail__invalid_scalar);
+	RUN_TESTS(struct_ops_kptr_return_fail__nonzero_offset);
+	RUN_TESTS(struct_ops_kptr_return_fail__local_kptr);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
new file mode 100644
index 000000000000..36386b3c23a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * allow a referenced kptr or a NULL pointer to be returned. A referenced kptr to task
+ * here is acquried automatically as the task argument is tagged with "__ref".
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(kptr_return, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	if (dummy % 2) {
+		bpf_task_release(task);
+		return NULL;
+	}
+	return task;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
new file mode 100644
index 000000000000..caeea158ef69
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
@@ -0,0 +1,26 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a non-zero scalar value.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+__failure __msg("At program exit the register R0 has smin=1 smax=1 should have been in [0, 0]")
+struct task_struct *BPF_PROG(kptr_return_fail__invalid_scalar, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	bpf_task_release(task);
+	return (struct task_struct *)1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__invalid_scalar,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
new file mode 100644
index 000000000000..b8b4f05c3d7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
@@ -0,0 +1,34 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a local kptr.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
+struct task_struct *BPF_PROG(kptr_return_fail__local_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *t;
+
+	bpf_task_release(task);
+
+	t = bpf_obj_new(typeof(*task));
+	if (!t)
+		return NULL;
+
+	return t;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__local_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
new file mode 100644
index 000000000000..7ddeb28c2329
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
@@ -0,0 +1,25 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a modified referenced kptr.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+__failure __msg("dereference of modified trusted_ptr_ ptr R0 off={{[0-9]+}} disallowed")
+struct task_struct *BPF_PROG(kptr_return_fail__nonzero_offset, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	return (struct task_struct *)&task->jobctl;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__nonzero_offset,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
new file mode 100644
index 000000000000..6a2dd5367802
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a referenced kptr of the wrong type.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
+struct task_struct *BPF_PROG(kptr_return_fail__wrong_type, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *ret;
+
+	ret = (struct task_struct *)bpf_cgroup_acquire(cgrp);
+	bpf_task_release(task);
+
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)kptr_return_fail__wrong_type,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 802cbd871035..89dc502de9d4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1182,11 +1182,19 @@ static int bpf_testmod_ops__test_refcounted(int dummy,
 	return 0;
 }
 
+static struct task_struct *
+bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
+				      struct cgroup *cgrp)
+{
+	return NULL;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
+	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c57b2f9dab10..c9fab51f16e2 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct cgroup;
 
 struct bpf_testmod_test_read_ctx {
 	char *buf;
@@ -38,6 +39,9 @@ struct bpf_testmod_ops {
 	int (*unsupported_ops)(void);
 	/* Used to test ref_acquired arguments. */
 	int (*test_refcounted)(int dummy, struct task_struct *task);
+	/* Used to test returning referenced kptr. */
+	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
+						    struct cgroup *cgrp);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
-- 
2.47.1


