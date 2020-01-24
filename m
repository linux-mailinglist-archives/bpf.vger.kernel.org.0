Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C526149004
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgAXVRZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:17:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33541 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387436AbgAXVRY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 16:17:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 34EB96ED3;
        Fri, 24 Jan 2020 16:17:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Jan 2020 16:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Hdjj2f7GL7mXR
        XrLkPhEpfZGgTfws9l4BcxNMa7aa5g=; b=p+BmpU5xnEgekAB+vu1B7c1llSEUx
        8VLMxLUQq4PHtl2BCmncQnGKrhl06lRcygbMTXcwQIhHgyAVgw/Fvf6EhvLM/IYv
        lLssNz6p+/VXbaj1tj0CH7vk/hX8YFz056oHR0DMK5roRiJnJJ5wHJ8HUKa5EWfY
        TSSZcpPcUFvzXcTWyFPo5nluCwM5NOqGTqImFvhRYj/tvDyFCdtECaTE6q9kO+tx
        9XSZBJ/FJ5NJSUKnUxs3FK/TMp/KBuicMBOUQEukayCiGbYjWtgZVUDiLIV+FyDt
        VS6EbtN/SLuNbm/8hRp++gQOlzES1/c2kSUa55Cyqj5h9vRV4TuCgvOtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Hdjj2f7GL7mXRXrLkPhEpfZGgTfws9l4BcxNMa7aa5g=; b=FiB294UC
        TmlgumkXAD1D+OI2PoyzLd3hbaoj9JlWKmQAzJqR58124OVe1AOPDmjhLNb/OMNq
        DHjWY5CClaREHGasQ1DvCd/qgVWCLphGQ1MznZq4zIff41V1GGvSujcV4glyMDoC
        79UqX9Z77ntdVM3dj34QaWFsUEQH1nxUZ504NiaqU3d++AVBdP2e/fUtwYHvnWE8
        kvDNCInmWjiuPnyLII/HZx9vJ0t2qU6aQJ0DskejMVnKCOPwqCiNAPbr+pGLop4l
        ceDr269pOYIkEUYLB8X8nEmGuHM0d8kMynZ8WjNWGfTI9SFNbviDzbQVVLuX30XW
        kD54JPiangDppQ==
X-ME-Sender: <xms:5F4rXufaK0ykMu3yqLJAt2GhnARVbyD51vAZSZzCgMcJXTh6z_OCdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrgeenucevlhhush
    htvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:5F4rXvN-eldXtZV6bUtNHmaGKjXozs_OE6YHoO0yKOu57iC4pp5WUA>
    <xmx:5F4rXkhtJH083itIzMFxEBIp_Tz_mCaNMvvE8lWDanD2cUoYhIv5ow>
    <xmx:5F4rXq1FMQqdNbgqfqgUjYplB6UPyCOGc31atwJKBavRZvxkWNzN_A>
    <xmx:5F4rXqeLUFL2bquHg200MRdiKCFKxQ3n2zpB6Hj0CNqad38lY8kfBg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prnvpn05.thefacebook.com [199.201.64.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 96C273062B0E;
        Fri, 24 Jan 2020 16:17:22 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: add bpf_perf_prog_read_branches() selftest
Date:   Fri, 24 Jan 2020 13:17:05 -0800
Message-Id: <20200124211705.24759-4-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124211705.24759-1-dxu@dxuuu.xyz>
References: <20200124211705.24759-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to test:

* default bpf_perf_prog_read_branches() behavior
* BPF_F_GET_BR_SIZE flag behavior
* using helper to write to stack
* using helper to write to map

Tested by running:

    # ./test_progs -t perf_branches
    #27 perf_branches:OK
    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/perf_branches.c  | 112 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  74 ++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
new file mode 100644
index 000000000000..54a982a6c513
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -0,0 +1,112 @@
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
+static void on_sample(void *ctx, int cpu, void *data, __u32 size)
+{
+	int pbe_size = sizeof(struct perf_branch_entry);
+	int required_size = ((struct output *)data)->required_size;
+	int written_stack = ((struct output *)data)->written_stack;
+	int written_map = ((struct output *)data)->written_map;
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
+void test_perf_branches(void)
+{
+	int err, i, pfd = -1, duration = 0, ok = 0;
+	struct perf_buffer_opts pb_opts = {};
+	struct perf_event_attr attr = {};
+	struct perf_buffer *pb;
+	struct bpf_link *link;
+	volatile int j = 0;
+	cpu_set_t cpu_set;
+
+
+	struct test_perf_branches *skel;
+	skel = test_perf_branches__open_and_load();
+	if (CHECK(!skel, "test_perf_branches_load",
+		  "perf_branches skeleton failed\n"))
+		goto out_destroy;
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
+	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
+		goto out_destroy;
+
+	/* attach perf_event */
+	link = bpf_program__attach_perf_event(skel->progs.perf_branches, pfd);
+	if (CHECK(IS_ERR(link), "attach_perf_event", "err %ld\n", PTR_ERR(link)))
+		goto out_close_perf;
+
+	/* set up perf buffer */
+	pb_opts.sample_cb = on_sample;
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
+out_close_perf:
+	close(pfd);
+out_destroy:
+	test_perf_branches__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
new file mode 100644
index 000000000000..6811ad5839e7
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
+	output.written_stack =
+		bpf_perf_prog_read_branches(ctx, entries,
+					    sizeof(entries), 0);
+	/* ignore spurious events */
+	if (!output.written_stack)
+		return 1;
+
+	/* get required size */
+	output.required_size =
+		bpf_perf_prog_read_branches(ctx, NULL, 0, BPF_F_GET_BR_SIZE);
+
+	/* write to map */
+	value = bpf_map_lookup_elem(&scratch_map, &key);
+	if (value)
+		output.written_map =
+			bpf_perf_prog_read_branches(ctx,
+						    value,
+						    30 * sizeof(struct fake_perf_branch_entry),
+						    0);
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

