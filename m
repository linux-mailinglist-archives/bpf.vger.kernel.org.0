Return-Path: <bpf+bounces-3787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69F74377F
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575E9280FEB
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E1A957;
	Fri, 30 Jun 2023 08:37:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1848A932
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E87C433C0;
	Fri, 30 Jun 2023 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688114268;
	bh=uQYpmbKAmDCIi1un+cBvbzpAOhvrbixTe8hrpSWPGSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uy/90XVKsIV85oBKTE4jNuiIfwdpbbRRkXJq+BezNJTZcqNogSR4MyuAghF1xY1wn
	 uESlAA0y5p6DIqLS3IRBAOZgUwCRTxIRtzuVDWx/TEZShBozaOWxfdUf8b+eNfIvMj
	 Df9/htoheITht/ucmCm3sWbGELLTo5RxbiGaSJ0co2V+VW05w0VXb0tJ5OjnK/r7fM
	 VJ64qxdqabvzGiDy3fjvalfn+8Nh3Vwy0WKsATVE0iL53FozAezFGkaBbNPPyqr7Gv
	 Rua1+jlLUyPotvqjErdhJqSCIA2nqnZ8Wm2rjo2AFQ0dT+cEARRdyUi9cNTHAidiyy
	 IDBpYFJMazFiA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf-next 20/26] selftests/bpf: Add uprobe_multi test program
Date: Fri, 30 Jun 2023 10:33:38 +0200
Message-ID: <20230630083344.984305-21-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083344.984305-1-jolsa@kernel.org>
References: <20230630083344.984305-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe_multi test program that defines 50k uprobe_multi_func_*
functions and will serve as attach point for uprobe_multi bench test
in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile       |  5 ++
 tools/testing/selftests/bpf/uprobe_multi.c | 53 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ad6b585e0d7c..acf7c9a29082 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -567,6 +567,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
+		       $(OUTPUT)/uprobe_multi				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
@@ -670,6 +671,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/uprobe_multi: uprobe_multi.c
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
+
 EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
new file mode 100644
index 000000000000..115a7f6cebfa
--- /dev/null
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+
+#define __PASTE(a, b) a##b
+#define PASTE(a, b) __PASTE(a, b)
+
+#define NAME(name, idx) PASTE(name, idx)
+
+#define DEF(name, idx)  int NAME(name, idx)(void) { return 0; }
+#define CALL(name, idx) NAME(name, idx)();
+
+#define F(body, name, idx) body(name, idx)
+
+#define F10(body, name, idx) \
+	F(body, PASTE(name, idx), 0) F(body, PASTE(name, idx), 1) F(body, PASTE(name, idx), 2) \
+	F(body, PASTE(name, idx), 3) F(body, PASTE(name, idx), 4) F(body, PASTE(name, idx), 5) \
+	F(body, PASTE(name, idx), 6) F(body, PASTE(name, idx), 7) F(body, PASTE(name, idx), 8) \
+	F(body, PASTE(name, idx), 9)
+
+#define F100(body, name, idx) \
+	F10(body, PASTE(name, idx), 0) F10(body, PASTE(name, idx), 1) F10(body, PASTE(name, idx), 2) \
+	F10(body, PASTE(name, idx), 3) F10(body, PASTE(name, idx), 4) F10(body, PASTE(name, idx), 5) \
+	F10(body, PASTE(name, idx), 6) F10(body, PASTE(name, idx), 7) F10(body, PASTE(name, idx), 8) \
+	F10(body, PASTE(name, idx), 9)
+
+#define F1000(body, name, idx) \
+	F100(body, PASTE(name, idx), 0) F100(body, PASTE(name, idx), 1) F100(body, PASTE(name, idx), 2) \
+	F100(body, PASTE(name, idx), 3) F100(body, PASTE(name, idx), 4) F100(body, PASTE(name, idx), 5) \
+	F100(body, PASTE(name, idx), 6) F100(body, PASTE(name, idx), 7) F100(body, PASTE(name, idx), 8) \
+	F100(body, PASTE(name, idx), 9)
+
+#define F10000(body, name, idx) \
+	F1000(body, PASTE(name, idx), 0) F1000(body, PASTE(name, idx), 1) F1000(body, PASTE(name, idx), 2) \
+	F1000(body, PASTE(name, idx), 3) F1000(body, PASTE(name, idx), 4) F1000(body, PASTE(name, idx), 5) \
+	F1000(body, PASTE(name, idx), 6) F1000(body, PASTE(name, idx), 7) F1000(body, PASTE(name, idx), 8) \
+	F1000(body, PASTE(name, idx), 9)
+
+F10000(DEF, uprobe_multi_func_, 0)
+F10000(DEF, uprobe_multi_func_, 1)
+F10000(DEF, uprobe_multi_func_, 2)
+F10000(DEF, uprobe_multi_func_, 3)
+F10000(DEF, uprobe_multi_func_, 4)
+
+int main(void)
+{
+	F10000(CALL, uprobe_multi_func_, 0)
+	F10000(CALL, uprobe_multi_func_, 1)
+	F10000(CALL, uprobe_multi_func_, 2)
+	F10000(CALL, uprobe_multi_func_, 3)
+	F10000(CALL, uprobe_multi_func_, 4)
+	return 0;
+}
-- 
2.41.0


