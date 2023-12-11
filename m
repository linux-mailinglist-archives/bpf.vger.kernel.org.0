Return-Path: <bpf+bounces-17390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B880C7F8
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29DE1F2158A
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA4374E4;
	Mon, 11 Dec 2023 11:27:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A45BD
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 03:27:46 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpfcG0T7bz4f3jq8
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3F5231A05FD
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 19:27:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxEp8nZlUTNnDQ--.13914S7;
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
Subject: [PATCH bpf-next 3/4] selftests/bpf: Add test for abnormal cnt during multi-kprobe attachment
Date: Mon, 11 Dec 2023 19:28:42 +0800
Message-Id: <20231211112843.4147157-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCnqxEp8nZlUTNnDQ--.13914S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw13Ar1rKF43Ww4fKF4kZwb_yoW8Zryrp3
	WSvw1akF4fXF1Iq3W2y3y2qFyI9Fs5urW5Cr1fXFyfZr1DA3W8XF1xKw4xtF93Cr9Yva1f
	A3sxtr90k3y8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
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
index 4041cfa670eb..a340b6047657 100644
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
+	if (!ASSERT_EQ(libbpf_get_error(link), -ENOMEM, "fail_6_error"))
+		goto cleanup;
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
-- 
2.29.2


