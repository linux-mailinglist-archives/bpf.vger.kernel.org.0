Return-Path: <bpf+bounces-7148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4A771CBF
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 11:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C3D1C209D1
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824FC8C0;
	Mon,  7 Aug 2023 09:00:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282BC2DF
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02640C433C7;
	Mon,  7 Aug 2023 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691398833;
	bh=rd4PiPHvQFmoacLWFoTv/0Eyp1Igc9qd6VNck/4UW1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfSOGw3Zvn3kFtle4ykBUr7dLRVvzpq6tL9HuqR9eIC77adrJ+gtPBZRAXeM5KynP
	 CYHsHwtigdW8WB1lLHH+kOXfVORlO/G8yVuFtQokEEkMqQaoVWmuvy1X1CoojaYtvB
	 etlN4S4hODrQTFbCkNLCwHp2/LyQWXDcCm3CyAkM99aEjPOAAF9LxTZ64go9KwIBrU
	 bDV3ycrM7sPhGqKP+XRTM/KzWNgq7qWeeM4qU8WKVrU01CEdFNZhu3zZXwEUN02aDh
	 5cR69vRRCT7TnNZuE6kXPrD/eIQqXmb+q6qRp8wJL2EsLCVlGRs3m9AruJ4SExj1m+
	 naW7eQLRl1FUg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv3 bpf-next 3/3] selftests/bpf: Add bpf_get_func_ip test for uprobe inside function
Date: Mon,  7 Aug 2023 10:59:56 +0200
Message-ID: <20230807085956.2344866-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807085956.2344866-1-jolsa@kernel.org>
References: <20230807085956.2344866-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding get_func_ip test for uprobe inside function that validates
the get_func_ip helper returns correct probe address value.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 46 +++++++++++++++++--
 .../bpf/progs/get_func_ip_uprobe_test.c       | 18 ++++++++
 2 files changed, 60 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 114cdbc04caf..c40242dfa8fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -51,11 +51,17 @@ static void test_function_entry(void)
 	get_func_ip_test__destroy(skel);
 }
 
-/* test6 is x86_64 specific because of the instruction
- * offset, disabling it for all other archs
- */
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
@@ -67,6 +73,9 @@ static void test_function_body(void)
 	if (!ASSERT_OK_PTR(skel, "get_func_ip_test__open"))
 		return;
 
+	/* test6 is x86_64 specific and is disabled by default,
+	 * enable it for body test.
+	 */
 	bpf_program__set_autoload(skel->progs.test6, true);
 
 	err = get_func_ip_test__load(skel);
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


