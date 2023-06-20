Return-Path: <bpf+bounces-2898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D9E736674
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440A7280237
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFEC121;
	Tue, 20 Jun 2023 08:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE64400
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5001C433C8;
	Tue, 20 Jun 2023 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250330;
	bh=312L5F6cdVsRkgnYrkxOgjWdtvKQGM5SNUZWfdSMF+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnyF1yLFSCxyMz1ChDsUzI1o71JA3lhY3kJVSwcMKQHKXssKATItoSMd4+yjYapee
	 3cdaPIOr1n3bodtK4XyMbKTiTSqQ/zS75l2ZSvI6qvo/ihooejmm8YlFohP8n3TXes
	 DDQr2fjpvWsyBmpSYL/yUi/WNzenAsLSfQ3RpCgfmGjkd6ofQTC6UTxH98pki6Aidm
	 3XV+hasj9XPLMim2x/jmhix5rlT0QAUFuZkrMxr+WdrW+iL+eaQVOuHuzGFYKUQAuM
	 HqTKh5nkF+UdmfB1wVLjfNo3MRwSrRovU6R7Nf39P7RGZ88MLx5HUpX70p/m9YBb4+
	 mHNkgkgGvgMfg==
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
Subject: [PATCHv2 bpf-next 18/24] selftests/bpf: Add uprobe_multi test program
Date: Tue, 20 Jun 2023 10:35:44 +0200
Message-ID: <20230620083550.690426-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
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
index 538df8fb8c42..26ecdd117f71 100644
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


