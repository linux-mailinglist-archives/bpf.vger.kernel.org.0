Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63C1798D9
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCDTTS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 14:19:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgCDTTI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 14:19:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id r7so3894580wro.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFJzrlCBeUNXzi702ufSxzOXOuvd1PMRBS96iGNg/tM=;
        b=IqQgVbHT9Cmy4E2b0jZiCTlAR9gQhNniwrP/JnlPvzHfY1gNSt3sOpXDkJafgd3LIN
         3mCpc/kuMro091Jcp7onzbuHx/gV9Ti9Ff//+c1dC563KMechZVlrYbL0IZBGONg82SP
         LtDwzJEcpPYPL+FhpSltuh2zQtCJ04E6WQ4cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFJzrlCBeUNXzi702ufSxzOXOuvd1PMRBS96iGNg/tM=;
        b=dRqTTlHPhcA9Y6vpdY60btE4Z3g5geSW32GVjlB9HpclTByyTEqPtmSZ3Tf0QRtork
         m9stDEEuv3s+VDQ7c3wU2iaCOit7nUJX4DlvaGa7XgdIoaVse8rDocp1fx5PULKT3z5M
         /dAl8ArKjwvbPpvVRu/6w9XeQtiJcw1iUC6nkJTqB3jiuQdI8amCreTu226kkc1zfyJM
         YEGRp/ALf8pD2ppk1UhKBiWUGiqRKEsgxGBJ3hKJ1s3nuE30FYQ44McJKfLmPNIoSE3F
         fZ1FqeVQWNtYCSwyFH74Vr8k3Y7sauARqhPqQVhqNUiEr3CgfXDZd2W67FhsPEwpiiFM
         G3pA==
X-Gm-Message-State: ANhLgQ0zDC3jflwKRK+V5fjgTx8fJ74vifbhO3OUkWOrEOV0l9SvdwO4
        6Awt2oVvk3CHOA6uHBk1LGjr+g==
X-Google-Smtp-Source: ADFU+vsIWUFRS/dORTqcKGBtqLMYyMDhGtTNh8/Z92p8gQrkwkMhTJ0vVXAPstl4T64BTpqLvrU2cg==
X-Received: by 2002:adf:f584:: with SMTP id f4mr3633105wro.77.1583349544898;
        Wed, 04 Mar 2020 11:19:04 -0800 (PST)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w9sm2018556wrn.35.2020.03.04.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:19:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 6/7] bpf: Add test ops for BPF_PROG_TYPE_TRACING
Date:   Wed,  4 Mar 2020 20:18:52 +0100
Message-Id: <20200304191853.1529-7-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304191853.1529-1-kpsingh@chromium.org>
References: <20200304191853.1529-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The current fexit and fentry tests rely on a different program to
exercise the functions they attach to. Instead of doing this, implement
the test operations for tracing which will also be used for
BPF_MODIFY_RETURN in a subsequent patch.

Also, clean up the fexit test to use the generated skeleton.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h                           | 10 +++
 kernel/trace/bpf_trace.c                      |  1 +
 net/bpf/test_run.c                            | 37 +++++++---
 .../selftests/bpf/prog_tests/fentry_fexit.c   | 12 +---
 .../selftests/bpf/prog_tests/fentry_test.c    | 14 ++--
 .../selftests/bpf/prog_tests/fexit_test.c     | 69 ++++++-------------
 6 files changed, 67 insertions(+), 76 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f748b31e5888..40c53924571d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1156,6 +1156,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr);
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr);
+int bpf_prog_test_run_tracing(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr);
 int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr);
@@ -1313,6 +1316,13 @@ static inline int bpf_prog_test_run_skb(struct bpf_prog *prog,
 	return -ENOTSUPP;
 }
 
+static inline int bpf_prog_test_run_tracing(struct bpf_prog *prog,
+					    const union bpf_attr *kattr,
+					    union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
+
 static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 						   const union bpf_attr *kattr,
 						   union bpf_attr __user *uattr)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 07764c761073..363e0a2c75cf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1266,6 +1266,7 @@ const struct bpf_verifier_ops tracing_verifier_ops = {
 };
 
 const struct bpf_prog_ops tracing_prog_ops = {
+	.test_run = bpf_prog_test_run_tracing,
 };
 
 static bool raw_tp_writable_prog_is_valid_access(int off, int size,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 1cd7a1c2f8b2..3600f098e7c6 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -160,18 +160,37 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
 		kfree(data);
 		return ERR_PTR(-EFAULT);
 	}
-	if (bpf_fentry_test1(1) != 2 ||
-	    bpf_fentry_test2(2, 3) != 5 ||
-	    bpf_fentry_test3(4, 5, 6) != 15 ||
-	    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
-	    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
-	    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111) {
-		kfree(data);
-		return ERR_PTR(-EFAULT);
-	}
+
 	return data;
 }
 
+int bpf_prog_test_run_tracing(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr)
+{
+	int err = -EFAULT;
+
+	switch (prog->expected_attach_type) {
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+		if (bpf_fentry_test1(1) != 2 ||
+		    bpf_fentry_test2(2, 3) != 5 ||
+		    bpf_fentry_test3(4, 5, 6) != 15 ||
+		    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
+		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
+		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111)
+			goto out;
+		break;
+	default:
+		goto out;
+	}
+
+	err = 0;
+out:
+	trace_bpf_test_finish(&err);
+	return err;
+}
+
 static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
 {
 	void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 235ac4f67f5b..83493bd5745c 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -1,22 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "test_pkt_access.skel.h"
 #include "fentry_test.skel.h"
 #include "fexit_test.skel.h"
 
 void test_fentry_fexit(void)
 {
-	struct test_pkt_access *pkt_skel = NULL;
 	struct fentry_test *fentry_skel = NULL;
 	struct fexit_test *fexit_skel = NULL;
 	__u64 *fentry_res, *fexit_res;
 	__u32 duration = 0, retval;
-	int err, pkt_fd, i;
+	int err, prog_fd, i;
 
-	pkt_skel = test_pkt_access__open_and_load();
-	if (CHECK(!pkt_skel, "pkt_skel_load", "pkt_access skeleton failed\n"))
-		return;
 	fentry_skel = fentry_test__open_and_load();
 	if (CHECK(!fentry_skel, "fentry_skel_load", "fentry skeleton failed\n"))
 		goto close_prog;
@@ -31,8 +26,8 @@ void test_fentry_fexit(void)
 	if (CHECK(err, "fexit_attach", "fexit attach failed: %d\n", err))
 		goto close_prog;
 
-	pkt_fd = bpf_program__fd(pkt_skel->progs.test_pkt_access);
-	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v6, sizeof(pkt_v6),
+	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
 	CHECK(err || retval, "ipv6",
 	      "err %d errno %d retval %d duration %d\n",
@@ -49,7 +44,6 @@ void test_fentry_fexit(void)
 	}
 
 close_prog:
-	test_pkt_access__destroy(pkt_skel);
 	fentry_test__destroy(fentry_skel);
 	fexit_test__destroy(fexit_skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_test.c b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
index 5cc06021f27d..04ebbf1cb390 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_test.c
@@ -1,20 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
-#include "test_pkt_access.skel.h"
 #include "fentry_test.skel.h"
 
 void test_fentry_test(void)
 {
-	struct test_pkt_access *pkt_skel = NULL;
 	struct fentry_test *fentry_skel = NULL;
-	int err, pkt_fd, i;
+	int err, prog_fd, i;
 	__u32 duration = 0, retval;
 	__u64 *result;
 
-	pkt_skel = test_pkt_access__open_and_load();
-	if (CHECK(!pkt_skel, "pkt_skel_load", "pkt_access skeleton failed\n"))
-		return;
 	fentry_skel = fentry_test__open_and_load();
 	if (CHECK(!fentry_skel, "fentry_skel_load", "fentry skeleton failed\n"))
 		goto cleanup;
@@ -23,10 +18,10 @@ void test_fentry_test(void)
 	if (CHECK(err, "fentry_attach", "fentry attach failed: %d\n", err))
 		goto cleanup;
 
-	pkt_fd = bpf_program__fd(pkt_skel->progs.test_pkt_access);
-	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v6, sizeof(pkt_v6),
+	prog_fd = bpf_program__fd(fentry_skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
+	CHECK(err || retval, "test_run",
 	      "err %d errno %d retval %d duration %d\n",
 	      err, errno, retval, duration);
 
@@ -39,5 +34,4 @@ void test_fentry_test(void)
 
 cleanup:
 	fentry_test__destroy(fentry_skel);
-	test_pkt_access__destroy(pkt_skel);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_test.c b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
index d2c3655dd7a3..78d7a2765c27 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_test.c
@@ -1,64 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
+#include "fexit_test.skel.h"
 
 void test_fexit_test(void)
 {
-	struct bpf_prog_load_attr attr = {
-		.file = "./fexit_test.o",
-	};
-
-	char prog_name[] = "fexit/bpf_fentry_testX";
-	struct bpf_object *obj = NULL, *pkt_obj;
-	int err, pkt_fd, kfree_skb_fd, i;
-	struct bpf_link *link[6] = {};
-	struct bpf_program *prog[6];
+	struct fexit_test *fexit_skel = NULL;
+	int err, prog_fd, i;
 	__u32 duration = 0, retval;
-	struct bpf_map *data_map;
-	const int zero = 0;
-	u64 result[6];
+	__u64 *result;
 
-	err = bpf_prog_load("./test_pkt_access.o", BPF_PROG_TYPE_SCHED_CLS,
-			    &pkt_obj, &pkt_fd);
-	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
-		return;
-	err = bpf_prog_load_xattr(&attr, &obj, &kfree_skb_fd);
-	if (CHECK(err, "prog_load fail", "err %d errno %d\n", err, errno))
-		goto close_prog;
+	fexit_skel = fexit_test__open_and_load();
+	if (CHECK(!fexit_skel, "fexit_skel_load", "fexit skeleton failed\n"))
+		goto cleanup;
 
-	for (i = 0; i < 6; i++) {
-		prog_name[sizeof(prog_name) - 2] = '1' + i;
-		prog[i] = bpf_object__find_program_by_title(obj, prog_name);
-		if (CHECK(!prog[i], "find_prog", "prog %s not found\n", prog_name))
-			goto close_prog;
-		link[i] = bpf_program__attach_trace(prog[i]);
-		if (CHECK(IS_ERR(link[i]), "attach_trace", "failed to link\n"))
-			goto close_prog;
-	}
-	data_map = bpf_object__find_map_by_name(obj, "fexit_te.bss");
-	if (CHECK(!data_map, "find_data_map", "data map not found\n"))
-		goto close_prog;
+	err = fexit_test__attach(fexit_skel);
+	if (CHECK(err, "fexit_attach", "fexit attach failed: %d\n", err))
+		goto cleanup;
 
-	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v6, sizeof(pkt_v6),
+	prog_fd = bpf_program__fd(fexit_skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
 				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
+	CHECK(err || retval, "test_run",
 	      "err %d errno %d retval %d duration %d\n",
 	      err, errno, retval, duration);
 
-	err = bpf_map_lookup_elem(bpf_map__fd(data_map), &zero, &result);
-	if (CHECK(err, "get_result",
-		  "failed to get output data: %d\n", err))
-		goto close_prog;
-
-	for (i = 0; i < 6; i++)
-		if (CHECK(result[i] != 1, "result", "bpf_fentry_test%d failed err %ld\n",
-			  i + 1, result[i]))
-			goto close_prog;
+	result = (__u64 *)fexit_skel->bss;
+	for (i = 0; i < 6; i++) {
+		if (CHECK(result[i] != 1, "result",
+			  "fexit_test%d failed err %lld\n", i + 1, result[i]))
+			goto cleanup;
+	}
 
-close_prog:
-	for (i = 0; i < 6; i++)
-		if (!IS_ERR_OR_NULL(link[i]))
-			bpf_link__destroy(link[i]);
-	bpf_object__close(obj);
-	bpf_object__close(pkt_obj);
+cleanup:
+	fexit_test__destroy(fexit_skel);
 }
-- 
2.20.1

