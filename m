Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC13A1B2701
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgDUNCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 09:02:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:53180 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgDUNCC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 09:02:02 -0400
Received: from 98.186.195.178.dynamic.wline.res.cust.swisscom.ch ([178.195.186.98] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jQsXJ-0003ho-3n; Tue, 21 Apr 2020 15:02:01 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     gregkh@linuxfoundation.org
Cc:     alexei.starovoitov@gmail.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, jannh@google.com, fontanalorenz@gmail.com,
        leodidonato@gmail.com, yhs@fb.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 5.4,5.5,5.6 3/4] bpf: Test_progs, add test to catch retval refine error handling
Date:   Tue, 21 Apr 2020 15:01:51 +0200
Message-Id: <20200421130152.14348-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421130152.14348-1-daniel@iogearbox.net>
References: <20200421130152.14348-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25789/Tue Apr 21 13:55:14 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ upstream commit d2db08c7a14e0b5eed6132baf258b80622e041a9 ]

Before this series the verifier would clamp return bounds of
bpf_get_stack() to [0, X] and this led the verifier to believe
that a JMP_JSLT 0 would be false and so would prune that path.

The result is anything hidden behind that JSLT would be unverified.
Add a test to catch this case by hiding an goto pc-1 behind the
check which will cause an infinite loop if not rejected.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/158560423908.10843.11783152347709008373.stgit@john-Precision-5820-Tower
---
 .../bpf/prog_tests/get_stack_raw_tp.c         |  5 ++++
 .../bpf/progs/test_get_stack_rawtp_err.c      | 26 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_stack_rawtp_err.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index eba9a970703b..925722217edf 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -82,6 +82,7 @@ static void get_stack_print_output(void *ctx, int cpu, void *data, __u32 size)
 void test_get_stack_raw_tp(void)
 {
 	const char *file = "./test_get_stack_rawtp.o";
+	const char *file_err = "./test_get_stack_rawtp_err.o";
 	const char *prog_name = "raw_tracepoint/sys_enter";
 	int i, err, prog_fd, exp_cnt = MAX_CNT_RAWTP;
 	struct perf_buffer_opts pb_opts = {};
@@ -93,6 +94,10 @@ void test_get_stack_raw_tp(void)
 	struct bpf_map *map;
 	cpu_set_t cpu_set;
 
+	err = bpf_prog_load(file_err, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err >= 0, "prog_load raw tp", "err %d errno %d\n", err, errno))
+		return;
+
 	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
 		return;
diff --git a/tools/testing/selftests/bpf/progs/test_get_stack_rawtp_err.c b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp_err.c
new file mode 100644
index 000000000000..8941a41c2a55
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_get_stack_rawtp_err.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define MAX_STACK_RAWTP 10
+
+SEC("raw_tracepoint/sys_enter")
+int bpf_prog2(void *ctx)
+{
+	__u64 stack[MAX_STACK_RAWTP];
+	int error;
+
+	/* set all the flags which should return -EINVAL */
+	error = bpf_get_stack(ctx, stack, 0, -1);
+	if (error < 0)
+		goto loop;
+
+	return error;
+loop:
+	while (1) {
+		error++;
+	}
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.20.1

