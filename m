Return-Path: <bpf+bounces-16861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFCA8069A9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 09:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA111F21553
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 08:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A419455;
	Wed,  6 Dec 2023 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNYsObk8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407A1A70D
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CA5C433C7;
	Wed,  6 Dec 2023 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701851472;
	bh=iW2ZiCQSejaQqfREBqpEm+IrAaybdGIcpxfymJhJkTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNYsObk8s5Vq8F3hauwg8zBTRM64OmIWLZ02W6k2AV+NVKEPZRFG/bCprgB/dpBXe
	 LcC7XD0vqxaFlvjerAoUe0V4WPzoMwUXTkhZZqET19fSucNHCpKf34X9e8AmR1ZMsb
	 Vw4LbbuYSA1M7kbjjMQ8g7RCQka9sTOio0KCimRNF0hG14L8YDoacWdLvAzY/xMzqi
	 y6HX8h9QxbeHNuZZHZWoVMgz9/l7bPZGkKjxtzAwzg9URt11FsdRr4e+sS5Qom9m3f
	 3quYIUXUKu1j/dbCMJ/sUg5CBXa7nk3pBF1DDlO4APjwiiqEEoSTEHtUx0PM0qCnal
	 UpEmmRXJVFM6w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCHv4 bpf 2/2] selftests/bpf: Add test for early update in prog_array_map_poke_run
Date: Wed,  6 Dec 2023 09:30:41 +0100
Message-ID: <20231206083041.1306660-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206083041.1306660-1-jolsa@kernel.org>
References: <20231206083041.1306660-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that tries to trigger the BUG_IN during early map update
in prog_array_map_poke_run function.

The idea is to share prog array map between thread that constantly
updates it and another one loading a program that uses that prog
array.

Eventually we will hit a place where the program is ok to be updated
(poke->tailcall_target_stable check) but the address is still not
registered in kallsyms, so the bpf_arch_text_poke returns -EINVAL
and cause imbalance for the next tail call update check, which will
fail with -EBUSY in bpf_arch_text_poke as described in previous fix.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 84 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_poke.c       | 32 +++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index fc6b2954e8f5..59993fc9c0d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
 #include <test_progs.h>
 #include <network_helpers.h>
+#include "tailcall_poke.skel.h"
+
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1105,6 +1108,85 @@ static void test_tailcall_bpf2bpf_fentry_entry(void)
 	bpf_object__close(tgt_obj);
 }
 
+#define JMP_TABLE "/sys/fs/bpf/jmp_table"
+
+static int poke_thread_exit;
+
+static void *poke_update(void *arg)
+{
+	__u32 zero = 0, prog1_fd, prog2_fd, map_fd;
+	struct tailcall_poke *call = arg;
+
+	map_fd = bpf_map__fd(call->maps.jmp_table);
+	prog1_fd = bpf_program__fd(call->progs.call1);
+	prog2_fd = bpf_program__fd(call->progs.call2);
+
+	while (!poke_thread_exit) {
+		bpf_map_update_elem(map_fd, &zero, &prog1_fd, BPF_ANY);
+		bpf_map_update_elem(map_fd, &zero, &prog2_fd, BPF_ANY);
+	}
+
+	return NULL;
+}
+
+/*
+ * We are trying to hit prog array update during another program load
+ * that shares the same prog array map.
+ *
+ * For that we share the jmp_table map between two skeleton instances
+ * by pinning the jmp_table to same path. Then first skeleton instance
+ * periodically updates jmp_table in 'poke update' thread while we load
+ * the second skeleton instance in the main thread.
+ */
+static void test_tailcall_poke(void)
+{
+	struct tailcall_poke *call, *test;
+	int err, cnt = 10;
+	pthread_t thread;
+
+	unlink(JMP_TABLE);
+
+	call = tailcall_poke__open_and_load();
+	if (!ASSERT_OK_PTR(call, "tailcall_poke__open"))
+		return;
+
+	err = bpf_map__pin(call->maps.jmp_table, JMP_TABLE);
+	if (!ASSERT_OK(err, "bpf_map__pin"))
+		goto out;
+
+	err = pthread_create(&thread, NULL, poke_update, call);
+	if (!ASSERT_OK(err, "new toggler"))
+		goto out;
+
+	while (cnt--) {
+		test = tailcall_poke__open();
+		if (!ASSERT_OK_PTR(test, "tailcall_poke__open"))
+			break;
+
+		err = bpf_map__set_pin_path(test->maps.jmp_table, JMP_TABLE);
+		if (!ASSERT_OK(err, "bpf_map__pin")) {
+			tailcall_poke__destroy(test);
+			break;
+		}
+
+		bpf_program__set_autoload(test->progs.test, true);
+		bpf_program__set_autoload(test->progs.call1, false);
+		bpf_program__set_autoload(test->progs.call2, false);
+
+		err = tailcall_poke__load(test);
+		tailcall_poke__destroy(test);
+		if (!ASSERT_OK(err, "tailcall_poke__load"))
+			break;
+	}
+
+	poke_thread_exit = 1;
+	ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
+
+out:
+	bpf_map__unpin(call->maps.jmp_table, JMP_TABLE);
+	tailcall_poke__destroy(call);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1139,4 +1221,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_fentry_fexit();
 	if (test__start_subtest("tailcall_bpf2bpf_fentry_entry"))
 		test_tailcall_bpf2bpf_fentry_entry();
+	if (test__start_subtest("tailcall_poke"))
+		test_tailcall_poke();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_poke.c b/tools/testing/selftests/bpf/progs/tailcall_poke.c
new file mode 100644
index 000000000000..c78b94b75e83
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_poke.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(test, int a)
+{
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(call1, int a)
+{
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(call2, int a)
+{
+	return 0;
+}
-- 
2.43.0


