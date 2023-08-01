Return-Path: <bpf+bounces-6532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB076AA02
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 09:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A10F1C20DD5
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28876AB9;
	Tue,  1 Aug 2023 07:30:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B526125
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF8CC433C7;
	Tue,  1 Aug 2023 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690875038;
	bh=sW/8OPAHvrKFhRzmxu7ojl7UKg60cJy2hTzhVW2+Wn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGJvPpqHRpMLpWd5DW+2KViMX0NgKAHQ2H7ZwrKi5SCfR4958v5pccW8PvM+jB4QN
	 cm+raMRDoE79oaDGQc7P6QTHtmO//RJe/gVEaJwiSCxq1IJLMin/Bn8ixho/1upkxt
	 Lw0MekDlkmP1ZsgJZ3wizdunOY62z7DiBB3raxqNs2rBay3+CTCJ6lTeCmVblG4WyM
	 RAe6wPXG0EkvdkJ70t/Xd7ubZoAmAC+b3aRDPOohU/WSKD8NzEeHZuCCiD9+xOm0Di
	 fG0yM8UahkMllv6iGSmZwbkfmiiAK511xy3jU5dzXltpJXVjg1fPLax+bA9p/SKsXu
	 Kd9hQFXpyCiiQ==
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add bpf_get_func_ip test for uprobe inside function
Date: Tue,  1 Aug 2023 09:30:02 +0200
Message-ID: <20230801073002.1006443-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801073002.1006443-1-jolsa@kernel.org>
References: <20230801073002.1006443-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding get_func_ip test for uprobe inside function that validates
the get_func_ip helper returns correct probe address value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 40 ++++++++++++++++++-
 .../bpf/progs/get_func_ip_uprobe_test.c       | 18 +++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 114cdbc04caf..f199220ad6de 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -55,7 +55,16 @@ static void test_function_entry(void)
  * offset, disabling it for all other archs
  */
 #ifdef __x86_64__
-static void test_function_body(void)
+extern void uprobe_trigger_body(void);
+asm(
+".globl uprobe_trigger_body\n"
+".type uprobe_trigger_body, @function\n"
+"uprobe_trigger_body:\n"
+"	nop\n"
+"	ret\n"
+);
+
+static void test_function_body_kprobe(void)
 {
 	struct get_func_ip_test *skel = NULL;
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -90,6 +99,35 @@ static void test_function_body(void)
 	bpf_link__destroy(link6);
 	get_func_ip_test__destroy(skel);
 }
+
+static void test_function_body_uprobe(void)
+{
+	struct get_func_ip_uprobe_test *skel = NULL;
+	int err;
+
+	skel = get_func_ip_uprobe_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_ip_uprobe_test__open_and_load"))
+		return;
+
+	err = get_func_ip_uprobe_test__attach(skel);
+	if (!ASSERT_OK(err, "get_func_ip_test__attach"))
+		goto cleanup;
+
+	skel->bss->uprobe_trigger_body = (unsigned long) uprobe_trigger_body;
+
+	uprobe_trigger_body();
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+
+cleanup:
+	get_func_ip_uprobe_test__destroy(skel);
+}
+
+static void test_function_body(void)
+{
+	test_function_body_kprobe();
+	test_function_body_uprobe();
+}
 #else
 #define test_function_body()
 #endif
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
new file mode 100644
index 000000000000..052f8a4345a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+unsigned long uprobe_trigger_body;
+
+__u64 test1_result = 0;
+SEC("uprobe//proc/self/exe:uprobe_trigger_body+1")
+int BPF_UPROBE(test1)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test1_result = (const void *) addr == (const void *) uprobe_trigger_body + 1;
+	return 0;
+}
-- 
2.41.0


