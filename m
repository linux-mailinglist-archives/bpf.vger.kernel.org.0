Return-Path: <bpf+bounces-17663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5D810FD0
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90471F213C7
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA9241F3;
	Wed, 13 Dec 2023 11:24:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE0BBD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:24:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SqtRf4Zswz4f3jHf
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D8BF01A07AE
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3OhBqlHllBOIgDg--.15138S7;
	Wed, 13 Dec 2023 19:24:31 +0800 (CST)
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
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for abnormal cnt during multi-uprobe attachment
Date: Wed, 13 Dec 2023 19:25:30 +0800
Message-Id: <20231213112531.3775079-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231213112531.3775079-1-houtao@huaweicloud.com>
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3OhBqlHllBOIgDg--.15138S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xAF1rCw43Kr4DXr1UWrg_yoW5ArW8pa
	sIvry3KF4fXF1Yq3y2yrW2grySvF4kury5CFyxWa4fArnrtF12qFn7KFWxJFn3ArZYvanx
	Aw1Dtry7GrWUX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
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
 .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index ece260cf2c0b..0d2a4510e6cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -234,6 +234,35 @@ static void test_attach_api_syms(void)
 	test_attach_api("/proc/self/exe", NULL, &opts);
 }
 
+static void test_failed_link_api(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *path = "/proc/self/exe";
+	struct uprobe_multi *skel = NULL;
+	unsigned long offset = 0;
+	int link_fd = -1;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	/* abnormal cnt */
+	opts.uprobe_multi.path = path;
+	opts.uprobe_multi.offsets = &offset;
+	opts.uprobe_multi.cnt = INT_MAX;
+	opts.kprobe_multi.flags = 0;
+	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
+				  BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_ERR(link_fd, "link_fd"))
+		goto cleanup;
+	if (!ASSERT_EQ(link_fd, -EINVAL, "invalid cnt"))
+		goto cleanup;
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	uprobe_multi__destroy(skel);
+}
+
 static void __test_link_api(struct child *child)
 {
 	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
@@ -311,7 +340,7 @@ static void __test_link_api(struct child *child)
 	free(offsets);
 }
 
-void test_link_api(void)
+static void test_link_api(void)
 {
 	struct child *child;
 
@@ -408,6 +437,8 @@ void test_uprobe_multi_test(void)
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


