Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4B145D0D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 21:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAVUXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 15:23:32 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:51427 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgAVUXc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 15:23:32 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 536A95241;
        Wed, 22 Jan 2020 15:23:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Jan 2020 15:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=B6/8oJXsr9XZS
        S6XJye1iDWSNpgFZi8UWgVVOMbMvTc=; b=McQIShDLeZfG5oCqRtyZq9lvRPT92
        4sifD80vPNg5EPVENCk4mkHBYiWv9GRhYivRLJ1VYb0ZNPxF/3hM4Rl94HyPuXaO
        votXT42SgPT5Br13B8JK6XQEuJFjW7jERWukc021RM9G/0eA1a7a9LttfbtH0wx6
        qi0FjHpfA8jwh4EpQ7uC084cRfz91ZMp4VWFDCR5Ifdd5DADLI7eSHQxdXEDdpzW
        RN2moyhwMl/v6wB/4oUuXWEvjPYrugkOQa/UHgYjtJ4uthzpOKy8Aju/r1JuN6iL
        QB4QgGQJCC6RHKE/K98vnffp9knxOHZkD9bz2yJ7A8oBcwZ5OFbw6HvXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=B6/8oJXsr9XZSS6XJye1iDWSNpgFZi8UWgVVOMbMvTc=; b=sS9LuZ1r
        qrgwEkFDJODQW3NFxGIJ55RxVKYXPBrkzu43evJiAXoLf4y5q93pfAfFTpsXPmKe
        OI0cJk4DmfdLX1zmsV2dL9b4gWuCQ9PR1iFoOSjkcm4jcApq/OQHxZsgrTEaO+Bf
        5x2SZjj4A8vG8Xsxni2AvDiuoeRMbJcQUXQMb4tES45wFRxIvc96OFPiS7r7SzbG
        Y7DP02ujE93o8aF9HmmOvdaGIG+RuNP4gDbO5HykDizunbgxkZfL+snsQEZJnn1/
        ZNQ7oXlbirV65IBL6cjj5Js2aSDONi5VVX8wsBsNsjB3quP4LMvjP31lkDA9XrCj
        Y3Q5+4mwINRzPA==
X-ME-Sender: <xms:Q68oXsfuz41UO51eBzcauzcUZwRRdW5Y7Fs1ofKoY1hru5gT-1XdVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecuvehluh
    hsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:Q68oXidqqIQbjF15uLw4LGqS1bLG08-r_1ZiR39XJEjrPCd75qu52Q>
    <xmx:Q68oXogpszpRv2dipAEub8wPEfjTuvv3fU5iJN7ZaecO5CMmA3tKWw>
    <xmx:Q68oXmTo9z1yXZ3HCV7X88poDbH35HG_bDtUH0gv1hKjMEGCMu-35w>
    <xmx:Q68oXiMbzsgNiM2eFFfFSnzg_XeWGGWNOQlcq_WsEXzNMpyai0BgVg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3497A3280063;
        Wed, 22 Jan 2020 15:23:29 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: add bpf_perf_prog_read_branches() selftest
Date:   Wed, 22 Jan 2020 12:22:20 -0800
Message-Id: <20200122202220.21335-4-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200122202220.21335-1-dxu@dxuuu.xyz>
References: <20200122202220.21335-1-dxu@dxuuu.xyz>
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
index 000000000000..1d8c3bf3ab39
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sched.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include "libbpf_internal.h"
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
+	if(CHECK(!ok, "ok", "not ok\n"))
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
index 000000000000..c210065e21c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <linux/ptrace.h>
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
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

