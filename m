Return-Path: <bpf+bounces-7314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066647755C0
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4855281468
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6F18C0D;
	Wed,  9 Aug 2023 08:38:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA06AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 08:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C070C433C7;
	Wed,  9 Aug 2023 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691570310;
	bh=NIeWJgVrAw17naHEv0PHMRCgDQmSX5RUF9i7t4pViDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ic/sbv0FwqGoTzFf7BlZSUHrQspTFtRdW+vPd6PGCptPmCKeRoaWnI0EHzGq8Pbhe
	 0wrnB10BI60lvI0gBTHP6M7gyvU2+6p1igl+W0SpORu7wffC+jzJBDy0KphGBZUKcO
	 hxFcR2G/yW/m5QzCaSjOO5zwu28JekrjIyExTXCqGEBbW3PdxqjsjMHVvCOV4tecyx
	 p0pDTCkgCEoRU2DnyixFE19+RV+dOu9FmNUnw0Pib5X+BKVl6rD+Zo8aDAPbYJNVuE
	 lDKySKCIX/hPKDSSUorbePvuIZVP9jqiVuEDYr7wC/ks0jOs9wZ8G3Nw1K3/0ZIlL1
	 10ub3PCzJckDw==
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
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv7 bpf-next 22/28] selftests/bpf: Add uprobe_multi test program
Date: Wed,  9 Aug 2023 10:34:34 +0200
Message-ID: <20230809083440.3209381-23-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083440.3209381-1-jolsa@kernel.org>
References: <20230809083440.3209381-1-jolsa@kernel.org>
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
 tools/testing/selftests/bpf/uprobe_multi.c | 67 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e4e1e6492268..edef49fcd23e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -585,6 +585,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
+		       $(OUTPUT)/uprobe_multi				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
@@ -698,6 +699,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
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
index 000000000000..d19184103fa3
--- /dev/null
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
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
+static int bench(void)
+{
+	F10000(CALL, uprobe_multi_func_, 0)
+	F10000(CALL, uprobe_multi_func_, 1)
+	F10000(CALL, uprobe_multi_func_, 2)
+	F10000(CALL, uprobe_multi_func_, 3)
+	F10000(CALL, uprobe_multi_func_, 4)
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc != 2)
+		goto error;
+
+	if (!strcmp("bench", argv[1]))
+		return bench();
+
+error:
+	fprintf(stderr, "usage: %s <bench>\n", argv[0]);
+	return -1;
+}
-- 
2.41.0


