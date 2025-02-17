Return-Path: <bpf+bounces-51775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC0CA38BF8
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 20:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0187A1D75
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CB237708;
	Mon, 17 Feb 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXk1fTmn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3F236A73
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819218; cv=none; b=VJYqXmHjDyfJY56Q9Eai7lg1rsez+BhKgn2GfyQ4d26kmPcBCml+n3P7X0TaAXMLIohoWvy2gq5F6+/macWye+9Uz4p4CpTIBgkHwfEzLDj06fmwxxS0bDunEdzjCi2zDP/yP6FeRD9QSEDy80NxA6a7QitwIxAEdo5GIYoZnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819218; c=relaxed/simple;
	bh=bZPSWibOsANaz7ZbEEqrS1c15YjgUQxRlJwxAXP8d+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snpUYZNKb4b7cng8I4NLVsH/nFIHhyw5rz2cIWeOAvinCkT3tLqNsrf/9LITp6rgjfaxXnE9ZTRAxGGUewqKJ/3ThA+sBvTdx1ES5zFL+oVTXNy0GRt7Z7ZjwdxPVJ2qZddId0Zsrkek3S+/AeJJ3snPAG0lFlgh3rq7gWRKh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXk1fTmn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso6611593a91.1
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819216; x=1740424016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFGxacoBFQPZGC2G4SchBJvt8QD+rVWDAtRRENuZXKo=;
        b=JXk1fTmnIMtkvYDZNnBRBZlR1Xzi21DT70Zt+XqkTJDg9LSHFCP41d9uLVouUy+mSe
         tQ4Llzz4u45lwCgx+g7gS8lN1GWxyW3nl4ZkKeLXJNL8rpDfHcLSxTy3vyL3ets/OGCi
         tk1yqSyKLWRosA9ix9nbicVIP7xCfuoeZ/R1VTa0hjWbVVYKhhVpbWsl8G+3UXFM06NP
         egCO2GDxw5TL3m9bhlRT+wJS6YtZEELZrs0n7q+5F2F0MX0AzOd5TGsX6A85oA4dL1uz
         iD4CGc48ULnN6DREZCJRD3Wj9CVQ8FKxllOCSlKfsz4QEh1TK/UqX9WXxFal9T1y7K7K
         rhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819216; x=1740424016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFGxacoBFQPZGC2G4SchBJvt8QD+rVWDAtRRENuZXKo=;
        b=Mbze+RzxbABDxFE06W/uwnU8wOpmMEQunLudVeXSESJkfPyIRVlL5FhcYSz+KDrI1m
         VRjVlMPp7D5R/2sALq+3KlQt7lVY5m204fjcWT7RGgJeK34xAJbswIY+ed98j6pB2BF9
         ufr2N708J2q1/N/3a9LGy4brSw8jFNl+HXSTO/AeMddSl7vHVCt3f2R2+w8LuiDo7WbT
         sYks6Ir3RT8u1zD1nhzWLbaQrpMqJ/aefnh0CrQ2frY9WVCY8LaFukoO8TgJomhdaTYB
         sLBaGnw7yAvsjktZ8YXVCOmwL2l3w/6kE58KxGQTN2xaA24uhIJ/CSIgbraQ5w2QUPgd
         WQuA==
X-Gm-Message-State: AOJu0YxEbuLXT1n5mfDcdnTCkTMCnDqI3B/RFflxCL8QdmM7Eaanz0dT
	BiiiWUFxyMTt9E+5+x+IRNRFvP7bPNmI8yk14vJ852biR6/z4Io//VnPYA==
X-Gm-Gg: ASbGncvc1WnEsgflhyz5uvHRf2ZxkYGbaeanufjbzq8ei6NMt9zcEYJJbjA2x0vsjdD
	P1tCOvP8JUSOol9lnLL8/V5sQtO3g1ljpklv5ocAvtzh5LP9cHE6Z6NKi9udA4MyglTUSlkojwe
	etw1XMycVKf8ijOmup3OJ19NozKRKdqiFq7quKcsVvj0YpzcigCUGzGSuyNA2WbYwnW+QAdreB7
	oTJjXpDYpV60neOkdlQoznELG34OS2oyvghkgpvbmzTfFjJH7SzXTE8KYiSf3Vq9OZtkE2bWJ28
	ueT3QmRJJkVBxeumyvezkZib7j6416sO8yfjOJe49dVuAfpvAAr1ZqQLIk/l4UaeKQ==
X-Google-Smtp-Source: AGHT+IGGv+mrVy8kGHLonIcb879DHFVPl9q46oeWsGPmzJkZ1krLzmohsbu5iwaFf7mJbxo552wG6g==
X-Received: by 2002:a05:6a00:1707:b0:732:288b:c049 with SMTP id d2e1a72fcca58-73261784015mr16451059b3a.1.1739819215900;
        Mon, 17 Feb 2025 11:06:55 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265f98e18sm5039118b3a.106.2025.02.17.11.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:06:55 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Mon, 17 Feb 2025 11:06:40 -0800
Message-ID: <20250217190640.1748177-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217190640.1748177-1-ameryhung@gmail.com>
References: <20250217190640.1748177-1-ameryhung@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
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


