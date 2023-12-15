Return-Path: <bpf+bounces-17987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E3814527
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0EA4B22FC3
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789F19456;
	Fri, 15 Dec 2023 10:06:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F718C1A
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ss4cK52ylz4f3kpX
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:06:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4B4B71A0937
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:06:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQsLJXxlJTfVDg--.54090S9;
	Fri, 15 Dec 2023 18:06:12 +0800 (CST)
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
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Add test for abnormal cnt during multi-kprobe attachment
Date: Fri, 15 Dec 2023 18:07:08 +0800
Message-Id: <20231215100708.2265609-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231215100708.2265609-1-houtao@huaweicloud.com>
References: <20231215100708.2265609-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHlQsLJXxlJTfVDg--.54090S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13Ar1rKF43Ww4fKF4kZwb_yoW8ZF43p3
	WSvw13KF4fXF17t3W2ya12qFWI9Fs5urW5Cr4fXF1fZw1DAF1xXF1xKF4xtF9xCr9Yva13
	A3s2qrWqk3yUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

If an abnormally huge cnt is used for multi-kprobes attachment, the
following warning will be reported:

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 392 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
  Modules linked in: bpf_testmod(O)
  CPU: 1 PID: 392 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  ......
  RIP: 0010:kvmalloc_node+0xd9/0xe0
   ? __warn+0x89/0x150
   ? kvmalloc_node+0xd9/0xe0
   bpf_kprobe_multi_link_attach+0x87/0x670
   __sys_bpf+0x2a28/0x2bc0
   __x64_sys_bpf+0x1a/0x30
   do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
  RIP: 0033:0x7fbe067f0e0d
  ......
   </TASK>
  ---[ end trace 0000000000000000 ]---

So add a test to ensure the warning is fixed.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/kprobe_multi_test.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 6079611b5df4..05000810e28e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -306,6 +306,21 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_5_error"))
 		goto cleanup;
 
+	/* fail_6 - abnormal cnt */
+	opts.addrs = (const unsigned long *) addrs;
+	opts.syms = NULL;
+	opts.cnt = INT_MAX;
+	opts.cookies = NULL;
+
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
+						     NULL, &opts);
+	saved_error = -errno;
+	if (!ASSERT_ERR_PTR(link, "fail_6"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(saved_error, -E2BIG, "fail_6_error"))
+		goto cleanup;
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
-- 
2.29.2


