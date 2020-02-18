Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23490161F33
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 04:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgBRDFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 22:05:04 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:47621 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgBRDFB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Feb 2020 22:05:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8EB2569D;
        Mon, 17 Feb 2020 22:04:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 17 Feb 2020 22:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=QPKCO3oHhWWYW
        YfPjyyTe6+NFwD2bqD3WqbWbQQ20r0=; b=yymKlJA2c/D/CupluwLBLAwCA5HQ/
        qoizZIn63Kj32VKqas4VeZMNhK7Pef3TFOxyM26fHkolKfIGA9aW846nW0JZNKtC
        fhWPg4Qep6k8jnwK+AkvGaJv7Z9byeCNV0h86mI+/GeSQc93UkI9ljNHXv4w4nrD
        cevofhFXc+zNjX4JpLhhWYzPf/Qjiu2f3GPOnjN19CTJnEc3KtaYbIvdiOFstI79
        nUncvFZOBqew/yyyucaQtfvYqDKVr3rlGnprMrvz70447LRwTVto+99fhbH73SWO
        PXYYcCTVitm0PEd+um2TAAVc0PS8zgunHwi45tplvmshW4dxKT3q+mU6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QPKCO3oHhWWYWYfPjyyTe6+NFwD2bqD3WqbWbQQ20r0=; b=YJwvbEgj
        PKT4RV5GFn5R33eDw3B+bHlmmYW6WqeH6Tb1zFiJO6RrrFir65cBE/SPGBfYMwsF
        i37AXCC6TAGblvkuW036xsJUBNpYM73OWWl8IjW4Zs5ZxkxgvRnld7h6t1hbqpF2
        xD4tyDtfIA6a8gRR2fqUsrv2sDl2ZO3PlDLnEH7NOQoNKSG2OQPXaROk+xktHb+H
        Ht6XwQlqtFD6mAtALnARWTiGPsKDBwOM5XEZjqtOnNVZfE04W5RzFebaxJYIoISk
        yzJAU3TTh+vmuQ2reh/3vVfkyNJ6UM/VAXyHtvE6phxlgRgzND1w6tzjG8uphhvH
        CdGvLm+oqwdx7g==
X-ME-Sender: <xms:UlRLXqIB9-HN9Yn-5Z1DoDHcj_1XDOIWgiloXnw5PLh9SavZkbZijw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedtrddunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:UlRLXoPNtWMPFkiUF_930EW0W8ll0JMrd2D6X7iNeiDM53EKXB_6CQ>
    <xmx:UlRLXt-TWVove1wDknl3-ixBhFGC1ML24nXREeArWX396jE7QyC0tw>
    <xmx:UlRLXnjnONb6SH3QNpKei7HXGp6Ya3nYSzpFbVJxeG1e3ZsIcj5M-A>
    <xmx:WFRLXsMTUK1zPZ0ft1m5p3Y8kPa2rKsaLFu4vwGeiRWNjm52h2yyqEMTlEo>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.130.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 411EC3060BD1;
        Mon, 17 Feb 2020 22:04:49 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v8 bpf-next 2/2] selftests/bpf: add bpf_read_branch_records() selftest
Date:   Mon, 17 Feb 2020 19:04:32 -0800
Message-Id: <20200218030432.4600-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218030432.4600-1-dxu@dxuuu.xyz>
References: <20200218030432.4600-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to test:

* default bpf_read_branch_records() behavior
* BPF_F_GET_BRANCH_RECORDS_SIZE flag behavior
* error path on non branch record perf events
* using helper to write to stack
* using helper to write to global

On host with hardware counter support:

    # ./test_progs -t perf_branches
    #27/1 perf_branches_hw:OK
    #27/2 perf_branches_no_hw:OK
    #27 perf_branches:OK
    Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

On host without hardware counter support (VM):

    # ./test_progs -t perf_branches
    #27/1 perf_branches_hw:OK
    #27/2 perf_branches_no_hw:OK
    #27 perf_branches:OK
    Summary: 1/2 PASSED, 1 SKIPPED, 0 FAILED

Also sync tools/include/uapi/linux/bpf.h.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/include/uapi/linux/bpf.h                |  25 ++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 169 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  50 ++++++
 3 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1d74a2bd234..a7e59756853f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2892,6 +2892,25 @@ union bpf_attr {
  *		Obtain the 64bit jiffies
  *	Return
  *		The 64 bit jiffies
+ *
+ * int bpf_read_branch_records(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
+ *	Description
+ *		For an eBPF program attached to a perf event, retrieve the
+ *		branch records (struct perf_branch_entry) associated to *ctx*
+ *		and store it in	the buffer pointed by *buf* up to size
+ *		*size* bytes.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
+ *		instead	return the number of bytes required to store all the
+ *		branch entries. If this flag is set, *buf* may be NULL.
+ *
+ *		**-EINVAL** if arguments invalid or **size** not a multiple
+ *		of sizeof(struct perf_branch_entry).
+ *
+ *		**-ENOENT** if architecture does not support branch records.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3012,7 +3031,8 @@ union bpf_attr {
 	FN(probe_read_kernel_str),	\
 	FN(tcp_send_ack),		\
 	FN(send_signal_thread),		\
-	FN(jiffies64),
+	FN(jiffies64),			\
+	FN(read_branch_records),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -3091,6 +3111,9 @@ enum bpf_func_id {
 /* BPF_FUNC_sk_storage_get flags */
 #define BPF_SK_STORAGE_GET_F_CREATE	(1ULL << 0)
 
+/* BPF_FUNC_read_branch_records flags. */
+#define BPF_F_GET_BRANCH_RECORDS_SIZE	(1ULL << 0)
+
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
 	BPF_ADJ_ROOM_NET,
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
new file mode 100644
index 000000000000..424f8be431ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "test_perf_branches.skel.h"
+
+static void check_good_sample(struct test_perf_branches *skel)
+{
+	int written_global = skel->bss->written_global_out;
+	int required_size = skel->bss->required_size_out;
+	int written_stack = skel->bss->written_stack_out;
+	int pbe_size = sizeof(struct perf_branch_entry);
+	int duration = 0;
+
+	if (CHECK(!skel->bss->valid, "output not valid",
+		 "no valid sample from prog"))
+		return;
+
+	/*
+	 * It's hard to validate the contents of the branch entries b/c it
+	 * would require some kind of disassembler and also encoding the
+	 * valid jump instructions for supported architectures. So just check
+	 * the easy stuff for now.
+	 */
+	CHECK(required_size <= 0, "read_branches_size", "err %d\n", required_size);
+	CHECK(written_stack < 0, "read_branches_stack", "err %d\n", written_stack);
+	CHECK(written_stack % pbe_size != 0, "read_branches_stack",
+	      "stack bytes written=%d not multiple of struct size=%d\n",
+	      written_stack, pbe_size);
+	CHECK(written_global < 0, "read_branches_global", "err %d\n", written_global);
+	CHECK(written_global % pbe_size != 0, "read_branches_global",
+	      "global bytes written=%d not multiple of struct size=%d\n",
+	      written_global, pbe_size);
+	CHECK(written_global < written_stack, "read_branches_size",
+	      "written_global=%d < written_stack=%d\n", written_global, written_stack);
+}
+
+static void check_bad_sample(struct test_perf_branches *skel)
+{
+	int written_global = skel->bss->written_global_out;
+	int required_size = skel->bss->required_size_out;
+	int written_stack = skel->bss->written_stack_out;
+	int duration = 0;
+
+	if (CHECK(!skel->bss->valid, "output not valid",
+		 "no valid sample from prog"))
+		return;
+
+	CHECK((required_size != -EINVAL && required_size != -ENOENT),
+	      "read_branches_size", "err %d\n", required_size);
+	CHECK((written_stack != -EINVAL && written_stack != -ENOENT),
+	      "read_branches_stack", "written %d\n", written_stack);
+	CHECK((written_global != -EINVAL && written_global != -ENOENT),
+	      "read_branches_global", "written %d\n", written_global);
+}
+
+static void test_perf_branches_common(int perf_fd,
+				      void (*cb)(struct test_perf_branches *))
+{
+	struct test_perf_branches *skel;
+	int err, i, duration = 0;
+	bool detached = false;
+	struct bpf_link *link;
+	volatile int j = 0;
+	cpu_set_t cpu_set;
+
+	skel = test_perf_branches__open_and_load();
+	if (CHECK(!skel, "test_perf_branches_load",
+		  "perf_branches skeleton failed\n"))
+		return;
+
+	/* attach perf_event */
+	link = bpf_program__attach_perf_event(skel->progs.perf_branches, perf_fd);
+	if (CHECK(IS_ERR(link), "attach_perf_event", "err %ld\n", PTR_ERR(link)))
+		goto out_destroy_skel;
+
+	/* generate some branches on cpu 0 */
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
+		goto out_destroy;
+	/* spin the loop for a while (random high number) */
+	for (i = 0; i < 1000000; ++i)
+		++j;
+
+	test_perf_branches__detach(skel);
+	detached = true;
+
+	cb(skel);
+out_destroy:
+	bpf_link__destroy(link);
+out_destroy_skel:
+	if (!detached)
+		test_perf_branches__detach(skel);
+	test_perf_branches__destroy(skel);
+}
+
+static void test_perf_branches_hw(void)
+{
+	struct perf_event_attr attr = {0};
+	int duration = 0;
+	int pfd;
+
+	/* create perf event */
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.config = PERF_COUNT_HW_CPU_CYCLES;
+	attr.freq = 1;
+	attr.sample_freq = 4000;
+	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
+	attr.branch_sample_type = PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+
+	/*
+	 * Some setups don't support branch records (virtual machines, !x86),
+	 * so skip test in this case.
+	 */
+	if (pfd == -1) {
+		if (errno == ENOENT) {
+			printf("%s:SKIP:no PERF_SAMPLE_BRANCH_STACK\n",
+			       __func__);
+			test__skip();
+			return;
+		}
+		if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
+			return;
+	}
+
+	test_perf_branches_common(pfd, check_good_sample);
+
+	close(pfd);
+}
+
+/*
+ * Tests negative case -- run bpf_read_branch_records() on improperly configured
+ * perf event.
+ */
+static void test_perf_branches_no_hw(void)
+{
+	struct perf_event_attr attr = {0};
+	int duration = 0;
+	int pfd;
+
+	/* create perf event */
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
+	attr.freq = 1;
+	attr.sample_freq = 4000;
+	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
+		return;
+
+	test_perf_branches_common(pfd, check_bad_sample);
+
+	close(pfd);
+}
+
+void test_perf_branches(void)
+{
+	if (test__start_subtest("perf_branches_hw"))
+		test_perf_branches_hw();
+	if (test__start_subtest("perf_branches_no_hw"))
+		test_perf_branches_no_hw();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
new file mode 100644
index 000000000000..0f7e27d97567
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <stddef.h>
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_trace_helpers.h"
+
+int valid = 0;
+int required_size_out = 0;
+int written_stack_out = 0;
+int written_global_out = 0;
+
+struct {
+	__u64 _a;
+	__u64 _b;
+	__u64 _c;
+} fpbe[30] = {0};
+
+SEC("perf_event")
+int perf_branches(void *ctx)
+{
+	__u64 entries[4 * 3] = {0};
+	int required_size, written_stack, written_global;
+
+	/* write to stack */
+	written_stack = bpf_read_branch_records(ctx, entries, sizeof(entries), 0);
+	/* ignore spurious events */
+	if (!written_stack)
+		return 1;
+
+	/* get required size */
+	required_size = bpf_read_branch_records(ctx, NULL, 0,
+						BPF_F_GET_BRANCH_RECORDS_SIZE);
+
+	written_global = bpf_read_branch_records(ctx, fpbe, sizeof(fpbe), 0);
+	/* ignore spurious events */
+	if (!written_global)
+		return 1;
+
+	required_size_out = required_size;
+	written_stack_out = written_stack;
+	written_global_out = written_global;
+	valid = 1;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.21.1

