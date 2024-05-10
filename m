Return-Path: <bpf+bounces-29523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A968C2A80
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B51F23CEC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF1B4CB28;
	Fri, 10 May 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi6ZXOnS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBD495F0;
	Fri, 10 May 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369059; cv=none; b=fIJ4z3ayod/0i87cB81NYSh8O5X5NavDM909YMxIVbn8JHK+XVc5xp7/Y8wGqzxpgieHGrXus7PvyvskmSCENVifPIOKxt/k7r9/YzBXITzHrdfuvw9DYKFwc2AkiJOtwC6EbmQvZnxb08/IMN+UsRbfnFKWGAk8Jwfi0Wb99Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369059; c=relaxed/simple;
	bh=TnBvzKVSRvp41lLaB77onR7QlVDU1ixHo+VfF51Mq7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/ESXTlfw5KWDqDN31aSOUStMOVeix/LY6GfsL6ouW4cbD5uhCFr+2HSwoLL6yPDtmYPKD077EUTDDMgOzVAdoZjb7O9xj2axzmGOapmByOR25nKJGVREfZJUNirDoQjSJQCgixWGov0SyYTeS65z5Qv/VZAQ2Mcbk2oCcwG6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi6ZXOnS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61be4b98766so27167057b3.3;
        Fri, 10 May 2024 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369056; x=1715973856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSXogPVCNCmUa6HtDLih4q+bEy2SsRVAx205AbGkGKg=;
        b=gi6ZXOnSzyWeWhqzd9D10bTo4RC1Ony2iGLGmTm4OkkCIq/CMgAAerTOElqiFdL4hg
         1+GgLj2VNHw8+9aOVct1v1qB63WGJZowEmsRdpHRHDPpD31itq47Vyn458Hiz/yb7G+O
         PzDMrFmUNi7fKvzYM1+Q5kLgiZF/ML10ElY/++9Y46VtHqEGINrJlph1YyHjXAs41M16
         rXD4V7ZaJd3gz/4y72PKoZJJelN4cpHlpGChB6Av7wgXyCLFzYIvojwzLty/get6havl
         rGZqEHwYVtfL5WUzxWVXGJvugzgUpefiD8XSyqZ7wiGAeoY8VOgXSFdsTf6Mtuxv5WwJ
         v/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369056; x=1715973856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSXogPVCNCmUa6HtDLih4q+bEy2SsRVAx205AbGkGKg=;
        b=GlD6zbOuQojky9n7T+PGFjhxse8Y/THB0RVl+4xfvRiTJZXASZ0XOmVdKyMewNi6IM
         ow1ioi87WN3KkgYFllF4eMVEBm50EBjXyWqJhhXlxAqj6UKK7JziQS6LvhF3jHZM93Yu
         /PiP3cC97xKmvcCBpaqKi8DZT4bCLD2bF2o0tw7a+1I3s0SifpBh3w4uu1+v5OcsTl9J
         6xLzJ4Z0wUYx69YB/RD+/n886xjmTVs2m2Ni6RFKAlUXzBt7+KbfhKeCngTrupyteXN1
         bprzT74ZIxho1QtFACefjmgoaQW5h6tn44ze9PCGnrDtBTzxhoiVQZSpy7uWzW+MyQGx
         J4Ug==
X-Gm-Message-State: AOJu0YwEzsdJ9KPywbXYJhfGIfU6psYqVcsQmQmbheDx7T9Y9c7eMU35
	rwoCvK18MHzGYc2noOduoJToUWmIKAmxedwRj9bzU2bk3ifV2rj2JlXYEg==
X-Google-Smtp-Source: AGHT+IFFS7V5SpqdI0/DgUAdStD7+RcaSrWqct0VDrd+gK7LOqjvCbiW4RQnfEk0inedxQpQ5ScDyg==
X-Received: by 2002:a81:6d0d:0:b0:61b:765b:cbea with SMTP id 00721157ae682-622aff427ffmr37756477b3.7.1715369055891;
        Fri, 10 May 2024 12:24:15 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 04/20] selftests/bpf: Test returning kptr from struct_ops programs
Date: Fri, 10 May 2024 19:23:56 +0000
Message-Id: <20240510192412.3297104-5-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test struct_ops programs returning kptr. The verifier should only allow
programs returning NULL or a non-local kptr with the correct type.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +
 .../prog_tests/test_struct_ops_kptr_return.c  | 87 +++++++++++++++++++
 .../bpf/progs/struct_ops_kptr_return.c        | 24 +++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 24 +++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 30 +++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 23 +++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 28 ++++++
 8 files changed, 228 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 64dcab25b539..097a8d1c2ef8 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -600,11 +600,19 @@ static int bpf_testmod_ops__test_ref_acquire(int dummy,
 	return 0;
 }
 
+static struct task_struct *
+bpf_testmod_ops__test_kptr_return(int dummy, struct task_struct *task__ref_acquired,
+				  struct cgroup *cgrp)
+{
+	return NULL;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_ref_acquire = bpf_testmod_ops__test_ref_acquire,
+	.test_kptr_return = bpf_testmod_ops__test_kptr_return,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index a0233990fb0e..6d24e1307b64 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct cgroup;
 
 struct bpf_testmod_test_read_ctx {
 	char *buf;
@@ -37,6 +38,9 @@ struct bpf_testmod_ops {
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
 	/* Used to test ref_acquired arguments. */
 	int (*test_ref_acquire)(int dummy, struct task_struct *task);
+	/* Used to test returning kptr. */
+	struct task_struct *(*test_kptr_return)(int dummy, struct task_struct *task,
+						struct cgroup *cgrp);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
new file mode 100644
index 000000000000..bc2fac39215a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
@@ -0,0 +1,87 @@
+#include <test_progs.h>
+
+#include "struct_ops_kptr_return.skel.h"
+#include "struct_ops_kptr_return_fail__wrong_type.skel.h"
+#include "struct_ops_kptr_return_fail__invalid_scalar.skel.h"
+#include "struct_ops_kptr_return_fail__nonzero_offset.skel.h"
+#include "struct_ops_kptr_return_fail__local_kptr.skel.h"
+
+/* Test that the verifier accepts a program that acquires a referenced
+ * kptr and releases the reference through return
+ */
+static void kptr_return(void)
+{
+	struct struct_ops_kptr_return *skel;
+
+	skel = struct_ops_kptr_return__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_kptr_return__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns a kptr of the
+ * wrong type
+ */
+static void kptr_return_fail__wrong_type(void)
+{
+	struct struct_ops_kptr_return_fail__wrong_type *skel;
+
+	skel = struct_ops_kptr_return_fail__wrong_type__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__wrong_type__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__wrong_type__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns a non-null scalar */
+static void kptr_return_fail__invalid_scalar(void)
+{
+	struct struct_ops_kptr_return_fail__invalid_scalar *skel;
+
+	skel = struct_ops_kptr_return_fail__invalid_scalar__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__invalid_scalar__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__invalid_scalar__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns kptr with non-zero offset */
+static void kptr_return_fail__nonzero_offset(void)
+{
+	struct struct_ops_kptr_return_fail__nonzero_offset *skel;
+
+	skel = struct_ops_kptr_return_fail__nonzero_offset__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__nonzero_offset__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__nonzero_offset__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns local kptr */
+static void kptr_return_fail__local_kptr(void)
+{
+	struct struct_ops_kptr_return_fail__local_kptr *skel;
+
+	skel = struct_ops_kptr_return_fail__local_kptr__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__local_kptr__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__local_kptr__destroy(skel);
+}
+
+void test_struct_ops_kptr_return(void)
+{
+	if (test__start_subtest("kptr_return"))
+		kptr_return();
+	if (test__start_subtest("kptr_return_fail__wrong_type"))
+		kptr_return_fail__wrong_type();
+	if (test__start_subtest("kptr_return_fail__invalid_scalar"))
+		kptr_return_fail__invalid_scalar();
+	if (test__start_subtest("kptr_return_fail__nonzero_offset"))
+		kptr_return_fail__nonzero_offset();
+	if (test__start_subtest("kptr_return_fail__local_kptr"))
+		kptr_return_fail__local_kptr();
+}
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
new file mode 100644
index 000000000000..34933a88e1f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
@@ -0,0 +1,24 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * allow a referenced kptr (acquired with "ref_acquired") to be leaked through return.
+ */
+SEC("struct_ops/test_kptr_return")
+struct task_struct *BPF_PROG(test_kptr_return, int dummy,
+	     struct task_struct *task, struct cgroup *cgrp)
+{
+	return task;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_kptr_return = (void *)test_kptr_return,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
new file mode 100644
index 000000000000..d479e3377496
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
@@ -0,0 +1,24 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a non-zero scalar value.
+ */
+SEC("struct_ops/test_kptr_return")
+struct task_struct *BPF_PROG(test_kptr_return, int dummy,
+	     struct task_struct *task, struct cgroup *cgrp)
+{
+	bpf_task_release(task);
+	return (struct task_struct *)1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_kptr_return = (void *)test_kptr_return,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
new file mode 100644
index 000000000000..9266987798ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a local kptr.
+ */
+SEC("struct_ops/test_kptr_return")
+struct task_struct *BPF_PROG(test_kptr_return, int dummy,
+	     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *t;
+
+	t = bpf_obj_new(typeof(*task));
+	if (!t)
+		return task;
+
+	return t;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_kptr_return = (void *)test_kptr_return,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
new file mode 100644
index 000000000000..1a369e9839f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
@@ -0,0 +1,23 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a modified referenced kptr.
+ */
+SEC("struct_ops/test_kptr_return")
+struct task_struct *BPF_PROG(test_kptr_return, int dummy,
+	     struct task_struct *task, struct cgroup *cgrp)
+{
+	return (struct task_struct *)&task->jobctl;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_kptr_return = (void *)test_kptr_return,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
new file mode 100644
index 000000000000..4128ea0b77f1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
@@ -0,0 +1,28 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a referenced kptr of the wrong type.
+ */
+SEC("struct_ops/test_kptr_return")
+struct task_struct *BPF_PROG(test_kptr_return, int dummy,
+	     struct task_struct *task, struct cgroup *cgrp)
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
+	.test_kptr_return = (void *)test_kptr_return,
+};
-- 
2.20.1


