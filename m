Return-Path: <bpf+bounces-38958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132196D0EA
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 09:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C01285914
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC59194122;
	Thu,  5 Sep 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="InjgB6b3"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4EE19340B;
	Thu,  5 Sep 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522994; cv=none; b=tPk8uwroS0SEKk6cbknquvBy6s2xm+WmuRAUqOqfsYFRJXDkgjlk/Chv963EIO2cWszDt1GZXRMrLIGQbLAKo7WQ49Ww2EXXzA++7RzvA+tzzgxbTBuKEcwvH3ZcIrJBILAoP/XQ+pSJlViW4N9WuFAVhD3ZMzBsWGd7H6wxvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522994; c=relaxed/simple;
	bh=oJ5g20RlH+r1YZadkqhgMik60Qt05kzPuIVi50Voc/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9qJUKjULd7w/avGWQ7nDVs8O9vzmLp694nIQUrtw4nYN4O6iqbPcLWpm4ZRlLShIDIaSfmBIISNlogbdS5G86svE8mG7Cn2UBPJ264VJ8YGqUCI/+CNvc4sMODK0jonf9sdMk9KMLjH006z5vIKD90KGT7oz/QzLWBHJuJmkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=InjgB6b3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725522989; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JKqdxuX4Wa1ORQ7kxclAATsobclvetQtCCCwpC0uu+E=;
	b=InjgB6b3i6+KIKo+2wfWdXQiCn67ICIXq2MiYWR77x8ZKMKVEthyPLhtXQwMF9MNQEBg/NdzOKiII67GMLkzuRuXJDdP+obTZNtJbCl/bt15w45MrOnocCTnpIHDhwtWwNXRvYuzXOT4Q+g3U9AgDlTwBGqdCwRi0qOYi0Jqqos=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEKuTCT_1725522985)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 15:56:26 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	juntong.deng@outlook.com,
	jrife@google.com,
	alan.maguire@oracle.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	vmalik@redhat.com,
	cupertino.miranda@oracle.com,
	mattbobrowski@google.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Add test for __nullable suffix in tp_btf
Date: Thu,  5 Sep 2024 15:56:19 +0800
Message-Id: <20240905075622.66819-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240905075622.66819-1-lulie@linux.alibaba.com>
References: <20240905075622.66819-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tracepoint with __nullable suffix in bpf_testmod, and add a
failure load case:

$./test_progs -t "module_attach"
 #173/1   module_attach/handle_tp_btf_nullable_bare:OK
 #173     module_attach:OK
 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 .../bpf/bpf_testmod/bpf_testmod-events.h         |  6 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c      |  2 ++
 .../selftests/bpf/prog_tests/module_attach.c     | 14 +++++++++++++-
 .../bpf/progs/test_module_attach_fail.c          | 16 ++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_module_attach_fail.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 11ee801e75e7e..6c3b4d4f173ac 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -34,6 +34,12 @@ DECLARE_TRACE(bpf_testmod_test_write_bare,
 	TP_ARGS(task, ctx)
 );
 
+/* Used in bpf_testmod_test_read() to test __nullable suffix */
+DECLARE_TRACE(bpf_testmod_test_nullable_bare,
+	TP_PROTO(struct bpf_testmod_test_read_ctx *ctx__nullable),
+	TP_ARGS(ctx__nullable)
+);
+
 #undef BPF_TESTMOD_DECLARE_TRACE
 #ifdef DECLARE_TRACE_WRITABLE
 #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index c73d04bc9e9de..9649e7f09fc90 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -394,6 +394,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	if (bpf_testmod_loop_test(101) > 100)
 		trace_bpf_testmod_test_read(current, &ctx);
 
+	trace_bpf_testmod_test_nullable_bare(NULL);
+
 	/* Magic number to enable writable tp */
 	if (len == 64) {
 		struct bpf_testmod_test_writable_ctx writable = {
diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
index 6d391d95f96e0..961d8577d6fab 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include <stdbool.h>
 #include "test_module_attach.skel.h"
+#include "test_module_attach_fail.skel.h"
 #include "testing_helpers.h"
 
 static int duration;
@@ -33,7 +34,7 @@ static int trigger_module_test_writable(int *val)
 	return 0;
 }
 
-void test_module_attach(void)
+static void module_attach_succ(void)
 {
 	const int READ_SZ = 456;
 	const int WRITE_SZ = 457;
@@ -115,3 +116,14 @@ void test_module_attach(void)
 cleanup:
 	test_module_attach__destroy(skel);
 }
+
+static void module_attach_fail(void)
+{
+	RUN_TESTS(test_module_attach_fail);
+}
+
+void test_module_attach(void)
+{
+	module_attach_succ();
+	module_attach_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_module_attach_fail.c b/tools/testing/selftests/bpf/progs/test_module_attach_fail.c
new file mode 100644
index 0000000000000..0f848d8f2f5e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_module_attach_fail.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "bpf_misc.h"
+
+SEC("tp_btf/bpf_testmod_test_nullable_bare")
+__failure __msg("invalid mem access")
+int BPF_PROG(handle_tp_btf_nullable_bare, struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	return nullable_ctx->len;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.32.0.3.g01195cf9f


