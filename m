Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18F914731A
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 22:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgAWVXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 16:23:43 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44341 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729543AbgAWVXm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 16:23:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0A15044FF;
        Thu, 23 Jan 2020 16:23:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 16:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5DxMvThetCUFM
        q0cx0StunBdQUiwxEXUDSwsxVjfahE=; b=ka/KA7HI2a/Df0P4c9Z+Lw8OBSyYn
        ki66o6dJhMKit7O0Q+qkpIQfntqCMMyNuVDnDDbooOlKSUoCmMzTCwP1EJRPZOrv
        jRMaeqOfyFRSGBwtGNdlc5lc89us+gT/AyTsPvLSSsAKWuPlssGPCdgLlMvZe7cM
        Ky5fm7JpLv2HuoCEipWAHRPMQ8NPfrtufxd7eHlgWu0WtdZ5bFTOZN3j36llKiS2
        NAvjKVvSGj54ESkfgUCeLZ0XpOMhyLiE0iaGxboFTFzynh2q3eKJRalDaLPsReaV
        Ms6JlegPMMn6nPKfGCiyC/JztzX9jJhkYbXS635EYHIXme7F0+H5K1ZMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5DxMvThetCUFMq0cx0StunBdQUiwxEXUDSwsxVjfahE=; b=aZ4aniOl
        BYevepIiTJovpFBTMV7y8Q7uAxZhIJcS12jSoqM+0Qncti4uNEZ7G06kCg3WpqZe
        lDH1Ey9jmCylJC+g2cEWruRuyTYmUcfihb9Xj/bN5wM0ji+Hw/Rscq2BsMKg94M/
        YiwoWZzO7wODWpv4up1KiUN7ZcD1sOHXwZNzxHtaR/pI9+b/PXd7m5RhVaGQIegT
        fuqsVyQvPmShn01rDFUI2MEx2UYtshKw5Uaxg6F+dlCPcXlf+dDqhSNYxMYdjtxc
        /OgSw7bxByO6IIggEReu/V37UPMtEOFfwMwjG+8mCloIyWbhskOmo/nc9AhZDf3d
        Amqdl36JRorVYw==
X-ME-Sender: <xms:3Q4qXouXGGIljr0ZDKeXKwm99gCDaxrdeIsC-cGO-CGPVSGC669qCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrudefheenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihu
    uhhurdighiii
X-ME-Proxy: <xmx:3Q4qXv6yPDQJNYZpUB3m1uYfiTuyKNXcpCMqx3HhJxFfc9FF4T1qXA>
    <xmx:3Q4qXnuuz9TiPtHoH_4IoVWCPl3DpycxBXDAm0MxWxWNmISCA9CcMQ>
    <xmx:3Q4qXh6mhEjND6PF1qk3t7JfaReoOohZovQUq0cNI4GRF1yPIwpeww>
    <xmx:3g4qXp3jfNwf2NbTq2OwEoO8I4TGsKJBiwQi-Gi6Cp6QlZZU04owWA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9508F3060ACE;
        Thu, 23 Jan 2020 16:23:40 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v3 bpf-next 3/3] selftests/bpf: add bpf_perf_prog_read_branches() selftest
Date:   Thu, 23 Jan 2020 13:23:12 -0800
Message-Id: <20200123212312.3963-4-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200123212312.3963-1-dxu@dxuuu.xyz>
References: <20200123212312.3963-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/perf_branches.c  | 106 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  39 +++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
new file mode 100644
index 000000000000..f8d7356a6507
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+
+static void on_sample(void *ctx, int cpu, void *data, __u32 size)
+{
+	int pbe_size = sizeof(struct perf_branch_entry);
+	int ret = *(int *)data, duration = 0;
+
+	// It's hard to validate the contents of the branch entries b/c it
+	// would require some kind of disassembler and also encoding the
+	// valid jump instructions for supported architectures. So just check
+	// the easy stuff for now.
+	CHECK(ret < 0, "read_branches", "err %d\n", ret);
+	CHECK(ret % pbe_size != 0, "read_branches",
+	      "bytes written=%d not multiple of struct size=%d\n",
+	      ret, pbe_size);
+
+	*(int *)ctx = 1;
+}
+
+void test_perf_branches(void)
+{
+	int err, prog_fd, i, pfd = -1, duration = 0, ok = 0;
+	const char *file = "./test_perf_branches.o";
+	const char *prog_name = "perf_event";
+	struct perf_buffer_opts pb_opts = {};
+	struct perf_event_attr attr = {};
+	struct bpf_map *perf_buf_map;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	struct perf_buffer *pb;
+	struct bpf_link *link;
+	volatile int j = 0;
+	cpu_set_t cpu_set;
+
+	/* load program */
+	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
+	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno)) {
+		obj = NULL;
+		goto out_close;
+	}
+
+	prog = bpf_object__find_program_by_title(obj, prog_name);
+	if (CHECK(!prog, "find_probe", "prog '%s' not found\n", prog_name))
+		goto out_close;
+
+	/* load map */
+	perf_buf_map = bpf_object__find_map_by_name(obj, "perf_buf_map");
+	if (CHECK(!perf_buf_map, "find_perf_buf_map", "not found\n"))
+		goto out_close;
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
+		goto out_close;
+
+	/* attach perf_event */
+	link = bpf_program__attach_perf_event(prog, pfd);
+	if (CHECK(IS_ERR(link), "attach_perf_event", "err %ld\n", PTR_ERR(link)))
+		goto out_close_perf;
+
+	/* set up perf buffer */
+	pb_opts.sample_cb = on_sample;
+	pb_opts.ctx = &ok;
+	pb = perf_buffer__new(bpf_map__fd(perf_buf_map), 1, &pb_opts);
+	if (CHECK(IS_ERR(pb), "perf_buf__new", "err %ld\n", PTR_ERR(pb)))
+		goto out_detach;
+
+	/* generate some branches on cpu 0 */
+	CPU_ZERO(&cpu_set);
+	CPU_SET(0, &cpu_set);
+	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
+	if (err && CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
+		goto out_free_pb;
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
+out_close:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
new file mode 100644
index 000000000000..d818079c7778
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_trace_helpers.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} perf_buf_map SEC(".maps");
+
+struct fake_perf_branch_entry {
+	__u64 _a;
+	__u64 _b;
+	__u64 _c;
+};
+
+SEC("perf_event")
+int perf_branches(void *ctx)
+{
+	int ret;
+	struct fake_perf_branch_entry entries[4];
+
+	ret = bpf_perf_prog_read_branches(ctx,
+					  entries,
+					  sizeof(entries));
+	/* ignore spurious events */
+	if (!ret)
+		return 1;
+
+	bpf_perf_event_output(ctx, &perf_buf_map, BPF_F_CURRENT_CPU,
+			      &ret, sizeof(ret));
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.21.1

