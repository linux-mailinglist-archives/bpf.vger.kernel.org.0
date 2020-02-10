Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A186C158417
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 21:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBJUIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 15:08:10 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56281 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727653AbgBJUIJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Feb 2020 15:08:09 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 23C498121;
        Mon, 10 Feb 2020 15:08:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 10 Feb 2020 15:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=0bk2vkHQhjOpH
        5NKlIz3kCWYq7Vt7kQrSyvdyRQNkI4=; b=fCINOIEfCFwYf0aKy1oBFBoMZPhbD
        BX7+pNay3yylXDZsVuAFVB72njxtR88HqkeIkQq1uxAzxVVj7DM9m8/7SKx9IikL
        SwB8IO+EhGcDNWLMn8ZTnDLdX8FtVjHX5lEBb2nIs7b2hDm8wUCPZWtZ/z0S5r5g
        ZCx/ykOXHyuBbUaRcEUqdUygedNwt4BEVx6lPLOPAhA3aUubVPkqJa3dnraI55Mu
        xlvURL+lxMzyB//B0XAi472xLbza8iXUP61nDTJXBEAAOP8+MAD6zFOd+titc9TV
        c42vHpx6I54y/ncMwVfjq/aQd7QHm5t4gBor6rnNUAokU5cPdSQzPQ+lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0bk2vkHQhjOpH5NKlIz3kCWYq7Vt7kQrSyvdyRQNkI4=; b=X8JFBTf/
        NqmHk7tqzhcgYnTpLzwAO3s/ZeBitLLHW8O+hddzMs4OQFrcloMptV4CJTwX1ouu
        yI64re1vzB26pluKZKNmk4hAyVLb2vA7EpEJsQFh92NABqtwKnCStHXqFE8SlZxy
        VodVfIJKC/crqbsfb65imcBVdjnI+TcQGSfrhOD9EKWi/sllre1E4giwVqPF1lNQ
        s53fVFkeiCChEQRKLgt6J2CfUQtOeSjGRaTybO/OY9AKBPqg5zZJAEpkosla1OZ5
        Ue2eUevxM9PstkPySjRndeNShVnXDCH5gSEblRUYfsHFCW/ZvtNdu+mrd7ohkC/J
        KfLhVbxACTFkbA==
X-ME-Sender: <xms:KLhBXubzN2lgHhlmCZ_83Ac_papyfGw-PjKcqU__YiT3-wqmbdI6Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:KLhBXn-9QwT_xmiVFnljmUoobO5eAa22HSIvnhJbhr9dDPLM7xStug>
    <xmx:KLhBXmL1tPGBmNey0XWgiiWJ__Yv1lq6SidWXifCGi6YND6Doa2D7A>
    <xmx:KLhBXitoD76CXcCWSMVcqXJYc_DNdOTRVNtDG7HswQbR4M62veSyjg>
    <xmx:KLhBXsMQTQwIQwajsFUeegaRlg0U3Tykb3NGvXMqZ19mjhrGVgv4Sw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 96DE43060272;
        Mon, 10 Feb 2020 15:08:06 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v7 bpf-next RESEND 2/2] selftests/bpf: add bpf_read_branch_records() selftest
Date:   Mon, 10 Feb 2020 12:07:37 -0800
Message-Id: <20200210200737.13866-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200210200737.13866-1-dxu@dxuuu.xyz>
References: <20200210200737.13866-1-dxu@dxuuu.xyz>
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
* using helper to write to map

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
 .../selftests/bpf/prog_tests/perf_branches.c  | 182 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  74 +++++++
 3 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1d74a2bd234..3004470b7269 100644
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
+ *		*buf_size* bytes.
+ *	Return
+ *		On success, number of bytes written to *buf*. On error, a
+ *		negative value.
+ *
+ *		The *flags* can be set to **BPF_F_GET_BRANCH_RECORDS_SIZE** to
+ *		instead	return the number of bytes required to store all the
+ *		branch entries. If this flag is set, *buf* may be NULL.
+ *
+ *		**-EINVAL** if arguments invalid or **buf_size** not a multiple
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
index 000000000000..bceefaea85b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "test_perf_branches.skel.h"
+
+struct output {
+	int required_size;
+	int written_stack;
+	int written_map;
+};
+
+static void on_good_sample(void *ctx, int cpu, void *data, __u32 size)
+{
+	int required_size = ((struct output *)data)->required_size;
+	int written_stack = ((struct output *)data)->written_stack;
+	int written_map = ((struct output *)data)->written_map;
+	int pbe_size = sizeof(struct perf_branch_entry);
+	int duration = 0;
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
+	CHECK(written_map < 0, "read_branches_map", "err %d\n", written_map);
+	CHECK(written_map % pbe_size != 0, "read_branches_map",
+	      "map bytes written=%d not multiple of struct size=%d\n",
+	      written_map, pbe_size);
+	CHECK(written_map < written_stack, "read_branches_size",
+	      "written_map=%d < written_stack=%d\n", written_map, written_stack);
+
+	*(int *)ctx = 1;
+}
+
+static void on_bad_sample(void *ctx, int cpu, void *data, __u32 size)
+{
+	int required_size = ((struct output *)data)->required_size;
+	int written_stack = ((struct output *)data)->written_stack;
+	int written_map = ((struct output *)data)->written_map;
+	int duration = 0;
+
+	CHECK((required_size != -EINVAL && required_size != -ENOENT),
+	      "read_branches_size", "err %d\n", required_size);
+	CHECK((written_stack != -EINVAL && written_stack != -ENOENT),
+	      "read_branches_stack", "written %d\n", written_stack);
+	CHECK((written_map != -EINVAL && written_map != -ENOENT),
+	      "read_branches_map", "written %d\n", written_map);
+
+	*(int *)ctx = 1;
+}
+
+static void test_perf_branches_common(int perf_fd, void *sample_cb)
+{
+	struct perf_buffer_opts pb_opts = {};
+	int err, i, duration = 0, ok = 0;
+	struct test_perf_branches *skel;
+	struct perf_buffer *pb;
+	struct bpf_link *link;
+	volatile int j = 0;
+	cpu_set_t cpu_set;
+
+	skel = test_perf_branches__open_and_load();
+	if (CHECK(!skel, "test_perf_branches_load",
+		  "perf_branches skeleton failed\n"))
+		goto out_destroy;
+
+	/* attach perf_event */
+	link = bpf_program__attach_perf_event(skel->progs.perf_branches, perf_fd);
+	if (CHECK(IS_ERR(link), "attach_perf_event", "err %ld\n", PTR_ERR(link)))
+		goto out_destroy;
+
+	/* set up perf buffer */
+	pb_opts.sample_cb = sample_cb;
+	pb_opts.ctx = &ok;
+	pb = perf_buffer__new(bpf_map__fd(skel->maps.perf_buf_map), 1, &pb_opts);
+	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
+		goto out_detach;
+
+	/* generate some branches on cpu 0 */
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
+		goto out_free_pb;
+	/* spin the loop for a while (random high number) */
+	for (i = 0; i < 1000000; ++i)
+		++j;
+
+	/* read perf buffer */
+	err = perf_buffer__poll(pb, 500);
+	if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
+		goto out_free_pb;
+
+	if (CHECK(!ok, "ok", "not ok\n"))
+		goto out_free_pb;
+
+out_free_pb:
+	perf_buffer__free(pb);
+out_detach:
+	bpf_link__destroy(link);
+out_destroy:
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
+	test_perf_branches_common(pfd, on_good_sample);
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
+	test_perf_branches_common(pfd, on_bad_sample);
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
index 000000000000..60327d512400
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <stddef.h>
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_trace_helpers.h"
+
+struct fake_perf_branch_entry {
+	__u64 _a;
+	__u64 _b;
+	__u64 _c;
+};
+
+struct output {
+	int required_size;
+	int written_stack;
+	int written_map;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} perf_buf_map SEC(".maps");
+
+typedef struct fake_perf_branch_entry fpbe_t[30];
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, fpbe_t);
+} scratch_map SEC(".maps");
+
+SEC("perf_event")
+int perf_branches(void *ctx)
+{
+	struct fake_perf_branch_entry entries[4] = {0};
+	struct output output = {0};
+	__u32 key = 0, *value;
+
+	/* write to stack */
+	output.written_stack = bpf_read_branch_records(ctx, entries,
+						       sizeof(entries), 0);
+	/* ignore spurious events */
+	if (!output.written_stack)
+		return 1;
+
+	/* get required size */
+	output.required_size =
+		bpf_read_branch_records(ctx, NULL, 0,
+					BPF_F_GET_BRANCH_RECORDS_SIZE);
+
+	/* write to map */
+	value = bpf_map_lookup_elem(&scratch_map, &key);
+	if (value)
+		output.written_map =
+			bpf_read_branch_records(ctx,
+						value,
+						30 * sizeof(struct fake_perf_branch_entry),
+						0);
+
+	/* ignore spurious events */
+	if (!output.written_map)
+		return 1;
+
+	bpf_perf_event_output(ctx, &perf_buf_map, BPF_F_CURRENT_CPU,
+			      &output, sizeof(output));
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.21.1

