Return-Path: <bpf+bounces-2895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2473666F
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80896280D2E
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F3C126;
	Tue, 20 Jun 2023 08:38:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DEAD2B
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC5CC433C0;
	Tue, 20 Jun 2023 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250301;
	bh=r/qCypdLDUAiuSd7OKqIYDN+uJTDFtEUejCrOrITWug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/fP81T0RI9Hz+5RyZYnWOa8+LW/9W4e6/MucrHEBko6Yc42z+fBt8JwOyTc0U1d9
	 oNdzs6WrEkG+H/kW8u3DqSRApLIslom15FEuAUIA2foYGfaf1k+UfD4kWfq50R96xe
	 1ukcwMXJ2h+T7U8LCQd1TTCgZX9ChZnSf95d0cvAldlu6BRcxPYSNVW92t6MURJED6
	 JP0Fvu4LACw5JAf4MWRxiTwv4XImjRyv2D18wexAmocYFFOiPoe+F1MlAeHTT0fdJN
	 ePO7SxSGBu8YWDwxqEhAfmKCN6uWpi1C9MggEzKb10tc0xnrSJAYqAT41ohVsUegQN
	 gLB9IkK5nG0VA==
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
Subject: [PATCHv2 bpf-next 15/24] selftests/bpf: Add uprobe_multi skel test
Date: Tue, 20 Jun 2023 10:35:41 +0200
Message-ID: <20230620083550.690426-16-jolsa@kernel.org>
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

Adding uprobe_multi test for skeleton load/attach functions,
to test skeleton auto attach for uprobe_multi link.

Test that bpf_get_func_ip works properly for uprobe_multi
attachment.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 76 ++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        | 91 +++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
new file mode 100644
index 000000000000..5cd1116bbb62
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <unistd.h>
+#include <test_progs.h>
+#include "uprobe_multi.skel.h"
+
+static char test_data[] = "test_data";
+
+noinline void uprobe_multi_func_1(void)
+{
+	asm volatile ("");
+}
+
+noinline void uprobe_multi_func_2(void)
+{
+	asm volatile ("");
+}
+
+noinline void uprobe_multi_func_3(void)
+{
+	asm volatile ("");
+}
+
+static void uprobe_multi_test_run(struct uprobe_multi *skel)
+{
+	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
+	skel->bss->uprobe_multi_func_2_addr = (__u64) uprobe_multi_func_2;
+	skel->bss->uprobe_multi_func_3_addr = (__u64) uprobe_multi_func_3;
+
+	skel->bss->user_ptr = test_data;
+	skel->bss->pid = getpid();
+
+	/* trigger all probes */
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	/*
+	 * There are 2 entry and 2 exit probe called for each uprobe_multi_func_[123]
+	 * function and each slepable probe (6) increments uprobe_multi_sleep_result.
+	 */
+	ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 2, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_2_result, 2, "uprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_3_result, 2, "uprobe_multi_func_3_result");
+
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_1_result, 2, "uretprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_2_result, 2, "uretprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uretprobe_multi_func_3_result, 2, "uretprobe_multi_func_3_result");
+
+	ASSERT_EQ(skel->bss->uprobe_multi_sleep_result, 6, "uprobe_multi_sleep_result");
+}
+
+static void test_skel_api(void)
+{
+	struct uprobe_multi *skel = NULL;
+	int err;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	err = uprobe_multi__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_multi__attach"))
+		goto cleanup;
+
+	uprobe_multi_test_run(skel);
+
+cleanup:
+	uprobe_multi__destroy(skel);
+}
+
+void test_uprobe_multi_test(void)
+{
+	if (test__start_subtest("skel_api"))
+		test_skel_api();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
new file mode 100644
index 000000000000..1eeb9b7b9cad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 uprobe_multi_func_1_addr = 0;
+__u64 uprobe_multi_func_2_addr = 0;
+__u64 uprobe_multi_func_3_addr = 0;
+
+__u64 uprobe_multi_func_1_result = 0;
+__u64 uprobe_multi_func_2_result = 0;
+__u64 uprobe_multi_func_3_result = 0;
+
+__u64 uretprobe_multi_func_1_result = 0;
+__u64 uretprobe_multi_func_2_result = 0;
+__u64 uretprobe_multi_func_3_result = 0;
+
+__u64 uprobe_multi_sleep_result = 0;
+
+int pid = 0;
+bool test_cookie = false;
+void *user_ptr = 0;
+
+static __always_inline bool verify_sleepable_user_copy(void)
+{
+	char data[9];
+
+	bpf_copy_from_user(data, sizeof(data), user_ptr);
+	return bpf_strncmp(data, sizeof(data), "test_data") == 0;
+}
+
+static void uprobe_multi_check(void *ctx, bool is_return, bool is_sleep)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return;
+
+	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
+	__u64 addr = bpf_get_func_ip(ctx);
+
+#define SET(__var, __addr, __cookie) ({			\
+	if (addr == __addr &&				\
+	   (!test_cookie || (cookie == __cookie)))	\
+		__var += 1;				\
+})
+
+	if (is_return) {
+		SET(uretprobe_multi_func_1_result, uprobe_multi_func_1_addr, 2);
+		SET(uretprobe_multi_func_2_result, uprobe_multi_func_2_addr, 3);
+		SET(uretprobe_multi_func_3_result, uprobe_multi_func_3_addr, 1);
+	} else {
+		SET(uprobe_multi_func_1_result, uprobe_multi_func_1_addr, 3);
+		SET(uprobe_multi_func_2_result, uprobe_multi_func_2_addr, 1);
+		SET(uprobe_multi_func_3_result, uprobe_multi_func_3_addr, 2);
+	}
+
+#undef SET
+
+	if (is_sleep && verify_sleepable_user_copy())
+		uprobe_multi_sleep_result += 1;
+}
+
+SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_*")
+int test_uprobe(struct pt_regs *ctx)
+{
+	uprobe_multi_check(ctx, false, false);
+	return 0;
+}
+
+SEC("uretprobe.multi//proc/self/exe:uprobe_multi_func_*")
+int test_uretprobe(struct pt_regs *ctx)
+{
+	uprobe_multi_check(ctx, true, false);
+	return 0;
+}
+
+SEC("uprobe.multi.s//proc/self/exe:uprobe_multi_func_*")
+int test_uprobe_sleep(struct pt_regs *ctx)
+{
+	uprobe_multi_check(ctx, false, true);
+	return 0;
+}
+
+SEC("uretprobe.multi.s//proc/self/exe:uprobe_multi_func_*")
+int test_uretprobe_sleep(struct pt_regs *ctx)
+{
+	uprobe_multi_check(ctx, true, true);
+	return 0;
+}
-- 
2.41.0


