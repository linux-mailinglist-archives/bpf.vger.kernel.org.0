Return-Path: <bpf+bounces-79576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF6D3C35A
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C12C5061FF
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8523C1FCE;
	Tue, 20 Jan 2026 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCYUwpav"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB63C198F
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900597; cv=none; b=RxA70a/fdJ6yIQAggfZza0Kvk6qjklPJE05U0i23u2QuAhCu2iQe/mrKXNuO1pp+Gc1zAxHThjvTO9h4FtrdFJA4kO4bKrzlozysG5VTrNLIluGMIsOe4WECxBadVc/G8Mww2yFT4IgkQOnmV9HLElpD1tON7tBCwJqIbK3Ezro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900597; c=relaxed/simple;
	bh=AWwUtXDnBBlIVFqvwqV3PkvoRtkjmsZpKJKA3oV0/PA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o5+aBidQcc40v/X8dHt9qqGWAYVkdoAYxcC3b9CWFHSwdizhQr49Ua/rl9LgoqHbcXrnXOUjU+PYFq9tNFjgbjWFImsZejN7sECMyzJdCdaEEKA/kkfOl5RbeDZ5jyTADhewaNo/0pORrnjTGWTFAk+RA7b6vnDAG05EvqhKcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCYUwpav; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64ba9c07ea2so7076179a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768900593; x=1769505393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Av+cxaO0cc3vqH2vu0seCx236r1rlEUouhngnq/udCs=;
        b=dCYUwpavWYTPTWZxLibIiLsNTv0KyPYh7WIrvZLyIPKydlklPizAPWhJkKlX1H084y
         InIBpc9CE3PJw7xWEI4SKlSCrbvtfYQT6ncHO6g5otTxKBOXOlBfq5iiKtO9p8/By2VM
         3xWK8UdAgfjs0g7soEVeh49jOTlT0Tf1kRF61KcBKkdfzQ1PA4Kl8AyyNInLmRJ8R2qu
         IdfCZi/PjITGHa/Dx8iOGzqm23fymwYSD0/vR09gflGeZ9kUKd39qAU2RZdgahginukL
         4Jx3efQkeD5U0dJMShGH1l5Hetx6Beo0U15pKQrnQjoXZnV9iskNURw0CYy/WnIixu0I
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900593; x=1769505393;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Av+cxaO0cc3vqH2vu0seCx236r1rlEUouhngnq/udCs=;
        b=lK0df0VV8m9dLxCRqY7YX6WWR/cyINgXfMehYtVqei6jDNHtbSmxJkScPpUCXOV/nl
         VBhwxh6tBz2RXJ5Kew7qtSnQuW8aZgLLT1eJQLrrqSCwcb/SvELRUfJbtAF1lswabPhq
         N5K8NmcThuNh42BbH1MhnyW4T8KuTYiLtEO/FWIDG+rJhYo3+/FPDDjlxgtDVnuHTilK
         qRXq3VykcH/2Wfdpf6/JkFYjoJrRaySnzL2o8v4SHUhq8EV85RET/Shb2+jQhuFZDG99
         suOtfysREruaX5zz8pxfRcz9EE9cRVmsNT/ITFgDQwFGIEApyP3Lp5yQsmP+xRZFYxLT
         vPcg==
X-Gm-Message-State: AOJu0Yx/oupIE7VG7RCjfAAjel9LLkbyK8+YzubJbLJ5F99TvWQ3gEzk
	3800RRbP90gKZo5vGhZx4+Ve+j2Os0jkj142jxNx2CRLCL2nJXEEo2z+/mr2QVTY26OyUUIuqG3
	uRMDQDvoufh0U+adxp7+Sg0yBmDN2l6XkAULL5OAx6TZnqYytOXI/bV7PJQc9NFnuZ/Rfqj08e0
	FjTtu0j/pHcbwmGL7GumnIT7XRGOQYXw8YDayadS5jKuaNsJXufCAs4eBLpwg6dBLufRw14Q==
X-Received: from edrc22.prod.google.com ([2002:aa7:d616:0:b0:658:1cd:eb22])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:40cd:b0:64d:521e:15f8 with SMTP id 4fb4d7f45d1cf-654525cbe7bmr11748904a12.10.1768900593446;
 Tue, 20 Jan 2026 01:16:33 -0800 (PST)
Date: Tue, 20 Jan 2026 09:16:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120091630.3420452-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] selftests/bpf: update verifier test for default
 trusted pointer semantics
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace the verifier test for default trusted pointer semantics, which
previously relied on BPF kfunc bpf_get_root_mem_cgroup(), with a new
test utilizing dedicated BPF kfuncs defined within the bpf_testmod.

bpf_get_root_mem_cgroup() was modified such that it again relies on
KF_ACQUIRE semantics, therefore no longer making it a suitable
candidate to test BPF verifier default trusted pointer semantics
against.

Link: https://lore.kernel.org/bpf/20260113083949.2502978-2-mattbobrowski@google.com
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  4 +--
 .../bpf/progs/verifier_default_trusted_ptr.c  | 29 +++++++++++++++++
 .../selftests/bpf/progs/verifier_memcontrol.c | 32 -------------------
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 18 +++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  3 ++
 5 files changed, 52 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_default_trusted_ptr.c
 delete mode 100644 tools/testing/selftests/bpf/progs/verifier_memcontrol.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 38c5ba70100c..404799b7ec48 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -30,6 +30,7 @@
 #include "verifier_ctx.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
+#include "verifier_default_trusted_ptr.skel.h"
 #include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
@@ -61,7 +62,6 @@
 #include "verifier_masking.skel.h"
 #include "verifier_may_goto_1.skel.h"
 #include "verifier_may_goto_2.skel.h"
-#include "verifier_memcontrol.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
@@ -172,6 +172,7 @@ void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
+void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
 void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
@@ -203,7 +204,6 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
-void test_verifier_memcontrol(void)	      { RUN(verifier_memcontrol); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_mul(void)                  { RUN(verifier_mul); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_default_trusted_ptr.c b/tools/testing/selftests/bpf/progs/verifier_default_trusted_ptr.c
new file mode 100644
index 000000000000..fa3b656ad4fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_default_trusted_ptr.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2026 Google LLC.
+ */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+SEC("syscall")
+__success __retval(0)
+int test_default_trusted_ptr(void *ctx)
+{
+	struct prog_test_member *trusted_ptr;
+
+	trusted_ptr = bpf_kfunc_get_default_trusted_ptr_test();
+	/*
+	 * Test BPF kfunc bpf_get_default_trusted_ptr_test() returns a
+	 * PTR_TO_BTF_ID | PTR_TRUSTED, therefore it should be accepted when
+	 * passed to a BPF kfunc only accepting KF_TRUSTED_ARGS.
+	 */
+	bpf_kfunc_put_default_trusted_ptr_test(trusted_ptr);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_memcontrol.c b/tools/testing/selftests/bpf/progs/verifier_memcontrol.c
deleted file mode 100644
index 13564956f621..000000000000
--- a/tools/testing/selftests/bpf/progs/verifier_memcontrol.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2026 Google LLC.
- */
-
-#include <vmlinux.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
-
-SEC("syscall")
-__success __retval(0)
-int root_mem_cgroup_default_trusted(void *ctx)
-{
-	unsigned long usage;
-	struct mem_cgroup *root_mem_cgroup;
-
-	root_mem_cgroup = bpf_get_root_mem_cgroup();
-	if (!root_mem_cgroup)
-		return 1;
-
-	/*
-	 * BPF kfunc bpf_get_root_mem_cgroup() returns a PTR_TO_BTF_ID |
-	 * PTR_TRUSTED | PTR_MAYBE_NULL, therefore it should be accepted when
-	 * passed to a BPF kfunc only accepting KF_TRUSTED_ARGS.
-	 */
-	usage = bpf_mem_cgroup_usage(root_mem_cgroup);
-	__sink(usage);
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index bc07ce9d5477..8b49334536ca 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -254,6 +254,22 @@ __bpf_kfunc int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size)
 	return NULL;
 }
 
+static struct prog_test_member trusted_ptr;
+
+__bpf_kfunc struct prog_test_member *bpf_kfunc_get_default_trusted_ptr_test(void)
+{
+	return &trusted_ptr;
+}
+
+__bpf_kfunc void bpf_kfunc_put_default_trusted_ptr_test(struct prog_test_member *trusted_ptr)
+{
+	/*
+	 * This BPF kfunc doesn't actually have any put/KF_ACQUIRE
+	 * semantics. We're simply wanting to simulate a BPF kfunc that takes a
+	 * struct prog_test_member pointer as an argument.
+	 */
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -709,6 +725,8 @@ BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
+BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
+BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 2357a0340ffe..e0c4ea593af9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -164,4 +164,7 @@ int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
 int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux__prog) __ksym;
 
+struct prog_test_member *bpf_kfunc_get_default_trusted_ptr_test(void) __ksym;
+void bpf_kfunc_put_default_trusted_ptr_test(struct prog_test_member *trusted_ptr) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.52.0.457.g6b5491de43-goog


