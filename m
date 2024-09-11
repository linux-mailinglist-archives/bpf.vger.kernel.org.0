Return-Path: <bpf+bounces-39566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5FB9748BD
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719C92882BC
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 03:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD284C62E;
	Wed, 11 Sep 2024 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c5e2kSJz"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E13BBC1;
	Wed, 11 Sep 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025850; cv=none; b=IM+kO1Q6zvICXvyBnDjfcG0a5COs/nw86AJeDvzp+CLhgtRoLEUUK7XRSCHxxoJkdGtqkM8guxWphshlZa8WJd7cmI90IdXcccLYPOEQmvdGwjVpG7zkJ4OhjicSQBQNaJZ2kYBe+2GwpXeyrCUZn7sk9xXf8K67rfnXKbCOjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025850; c=relaxed/simple;
	bh=4V+o6xOF2BFgYnCzSjcordwRIpxNLpcxS0O+NDe1ONA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jz+nrw9xR4z6eIflAnxdNFEzc/Lx7+4WmrsvnFiNXoug0Neb3blGsDzVKI9C5Lh+inBwgai5kYSrdP14whJGcnVH5VOiXPo/noH4nqxfp3+JgJyoXCwEFIN2F5plXs9ULIi4AMIW/N8VPrGJyAe7u3/uRrW70tuXBJ9LM9TMPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c5e2kSJz; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726025845; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SOGc0CENSL2/DXx0M8NVYDMuHPQIXtS8C8mm/FIM4aw=;
	b=c5e2kSJzsRJEb6y76ASc5GxK3Y0XWULct5+seZ8PR1KW/kdljw2s3Wp1dfei5QmaC86u4Y2pA2DuJSNMZdRbuuWuTfHgpazpiB1ahKn11sc+v2OvTrAOA68DwErEYbfMbH0aGbB9tiJq3kUSqv6YpdefcW2OVEL4VVDtpm4hL7s=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WEmEW0P_1726025842)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 11:37:23 +0800
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
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: Add test for __nullable suffix in tp_btf
Date: Wed, 11 Sep 2024 11:37:16 +0800
Message-Id: <20240911033719.91468-3-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240911033719.91468-1-lulie@linux.alibaba.com>
References: <20240911033719.91468-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tracepoint with __nullable suffix in bpf_testmod, and add cases
for it:

$ ./test_progs -t "tp_btf_nullable"
 #406/1   tp_btf_nullable/handle_tp_btf_nullable_bare1:OK
 #406/2   tp_btf_nullable/handle_tp_btf_nullable_bare2:OK
 #406     tp_btf_nullable:OK
 Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  6 +++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
 .../bpf/prog_tests/tp_btf_nullable.c          | 14 +++++++++++
 .../bpf/progs/test_tp_btf_nullable.c          | 24 +++++++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c

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
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c b/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
new file mode 100644
index 0000000000000..accc42e01f8a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tp_btf_nullable.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "test_tp_btf_nullable.skel.h"
+
+void test_tp_btf_nullable(void)
+{
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	RUN_TESTS(test_tp_btf_nullable);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
new file mode 100644
index 0000000000000..bba3e37f749b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "bpf_misc.h"
+
+SEC("tp_btf/bpf_testmod_test_nullable_bare")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	return nullable_ctx->len;
+}
+
+SEC("tp_btf/bpf_testmod_test_nullable_bare")
+int BPF_PROG(handle_tp_btf_nullable_bare2, struct bpf_testmod_test_read_ctx *nullable_ctx)
+{
+	if (nullable_ctx)
+		return nullable_ctx->len;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.32.0.3.g01195cf9f


