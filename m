Return-Path: <bpf+bounces-17665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B95810FD3
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A804C1C20B30
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739B24202;
	Wed, 13 Dec 2023 11:24:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA9D0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 03:24:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SqtRg1MJ0z4f3jqG
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6AAF01A08DC
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 19:24:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3OhBqlHllBOIgDg--.15138S8;
	Wed, 13 Dec 2023 19:24:32 +0800 (CST)
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add test for abnormal cnt during multi-kprobe attachment
Date: Wed, 13 Dec 2023 19:25:31 +0800
Message-Id: <20231213112531.3775079-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3OhBqlHllBOIgDg--.15138S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13Ar1rKF43Ww4fKF4kZwb_yoW8Zryrp3
	WSv34akF4fXF12qw12y3y2qFy09Fs5urW5Cr4fXFyfZw1DA3W8WF1xKw4xtF93Cr9Yya1f
	A3sxtr98C3y8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
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

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 4041cfa670eb..802554d4ee24 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -300,6 +300,20 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"))
 		goto cleanup;
 
+	/* fail_6 - abnormal cnt */
+	opts.addrs = (const unsigned long *) addrs;
+	opts.syms = NULL;
+	opts.cnt = INT_MAX;
+	opts.cookies = NULL;
+
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
+						     NULL, &opts);
+	if (!ASSERT_ERR_PTR(link, "fail_6"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_6_error"))
+		goto cleanup;
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
-- 
2.29.2


