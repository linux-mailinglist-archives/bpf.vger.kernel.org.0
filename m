Return-Path: <bpf+bounces-17391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D524B80C7F9
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA2328170B
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE4374FD;
	Mon, 11 Dec 2023 11:27:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4ECF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 03:27:46 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpfcB69Qtz4f3m7R
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BFB9A1A099C
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxEp8nZlUTNnDQ--.13914S8;
	Mon, 11 Dec 2023 19:27:43 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add test for abnormal cnt during multi-uprobe attachment
Date: Mon, 11 Dec 2023 19:28:43 +0800
Message-Id: <20231211112843.4147157-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231211112843.4147157-1-houtao@huaweicloud.com>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxEp8nZlUTNnDQ--.13914S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xAF1rCw43Kr17Zw43Wrg_yoW5ZFWkpa
	sIvryakF4fXFy5X3y2yrWq9ryFvF4kur13CFyxWa4xArnrJF12qFn7KF4xAFn3JrZYva13
	Aw1Dtry7JrWUX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

If an abnormally huge cnt is used for multi-uprobes attachment, the
following warning will be reported:

  ------------[ cut here ]------------
  WARNING: CPU: 7 PID: 406 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
  Modules linked in: bpf_testmod(O)
  CPU: 7 PID: 406 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  RIP: 0010:kvmalloc_node+0xd9/0xe0
  ......
  Call Trace:
   <TASK>
   ? __warn+0x89/0x150
   ? kvmalloc_node+0xd9/0xe0
   bpf_uprobe_multi_link_attach+0x14a/0x480
   __sys_bpf+0x14a9/0x2bc0
   do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
   ......
   </TASK>
  ---[ end trace 0000000000000000 ]---

So add a test to ensure the warning is fixed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index ece260cf2c0b..379ee9cc6221 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -234,6 +234,45 @@ static void test_attach_api_syms(void)
 	test_attach_api("/proc/self/exe", NULL, &opts);
 }
 
+static void test_failed_link_api(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *path = "/proc/self/exe";
+	struct uprobe_multi *skel = NULL;
+	unsigned long *offsets = NULL;
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+	int link_fd = -1, err;
+
+	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets, STT_FUNC);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
+		return;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	/* abnormal cnt */
+	opts.uprobe_multi.path = path;
+	opts.uprobe_multi.offsets = offsets;
+	opts.uprobe_multi.cnt = INT_MAX;
+	opts.kprobe_multi.flags = 0;
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
+				  BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -ENOMEM, "no mem fail"))
+		goto cleanup;
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	uprobe_multi__destroy(skel);
+	free(offsets);
+}
+
 static void __test_link_api(struct child *child)
 {
 	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
@@ -311,7 +350,7 @@ static void __test_link_api(struct child *child)
 	free(offsets);
 }
 
-void test_link_api(void)
+static void test_link_api(void)
 {
 	struct child *child;
 
@@ -408,6 +447,8 @@ void test_uprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("link_api"))
 		test_link_api();
+	if (test__start_subtest("failed_link_api"))
+		test_failed_link_api();
 	if (test__start_subtest("bench_uprobe"))
 		test_bench_attach_uprobe();
 	if (test__start_subtest("bench_usdt"))
-- 
2.29.2


