Return-Path: <bpf+bounces-16554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7AB80278E
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 21:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A51C2099D
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1618054;
	Sun,  3 Dec 2023 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mca7jgf2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F969DDCD
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 20:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F6CC433C7;
	Sun,  3 Dec 2023 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701636560;
	bh=kZPv8eEQRV/nxdvQLlKZGanrAVGrgcoeTB+PCQo8zjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mca7jgf2RWayf1tVvFTBYUwjHO78Vo7BJum08RPHcl3lg0YpBBPeleIpcNGD5P2dA
	 J0S+SZlzxe4nq6tmhYl04/fiD3BtaVvId/QF/IKwLR5PltvUR3qhRlOVvyuJajnil2
	 vX6I9NOpSGFsbTaYzZrcc/qElpbznq1wlU3ezSXJkY5hVelGyLdsDWl0B1c+ulTCU8
	 GSExxR2bDMdwQkd4RSuUdmHQvlwbZ4MkLW4zCoU3Jxm1UVmMAxb2wrz/270IRNkdV5
	 0vNUhONnw4lTPNjHEOXkTf76Y9f7+kKTCz7YazWI7Bv3TMFLsqZfaR2PlUppdVm2Fz
	 06EydUij4oAAA==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv3 bpf 2/2] selftests/bpf: Add test for early update in prog_array_map_poke_run
Date: Sun,  3 Dec 2023 21:48:51 +0100
Message-ID: <20231203204851.388654-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231203204851.388654-1-jolsa@kernel.org>
References: <20231203204851.388654-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that tries to trigger the BUG_ON during early map update
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
 .../selftests/bpf/prog_tests/tailcall_poke.c  | 74 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_poke.c       | 32 ++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
new file mode 100644
index 000000000000..f7e2c09fd772
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <test_progs.h>
+#include "tailcall_poke.skel.h"
+
+#define JMP_TABLE "/sys/fs/bpf/jmp_table"
+
+static int thread_exit;
+
+static void *update(void *arg)
+{
+	__u32 zero = 0, prog1_fd, prog2_fd, map_fd;
+	struct tailcall_poke *call = arg;
+
+	map_fd = bpf_map__fd(call->maps.jmp_table);
+	prog1_fd = bpf_program__fd(call->progs.call1);
+	prog2_fd = bpf_program__fd(call->progs.call2);
+
+	while (!thread_exit) {
+		bpf_map_update_elem(map_fd, &zero, &prog1_fd, BPF_ANY);
+		bpf_map_update_elem(map_fd, &zero, &prog2_fd, BPF_ANY);
+	}
+
+	return NULL;
+}
+
+void test_tailcall_poke(void)
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
+	err = pthread_create(&thread, NULL, update, call);
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
+	thread_exit = 1;
+	ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
+
+out:
+	bpf_map__unpin(call->maps.jmp_table, JMP_TABLE);
+	tailcall_poke__destroy(call);
+}
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


