Return-Path: <bpf+bounces-17986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EAE814525
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 11:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A83284894
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F919445;
	Fri, 15 Dec 2023 10:06:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC018C18
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ss4cG5Czyz4f3m6j
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:06:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C11041A09B1
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:06:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQsLJXxlJTfVDg--.54090S8;
	Fri, 15 Dec 2023 18:06:11 +0800 (CST)
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
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Don't use libbpf_get_error() in kprobe_multi_test
Date: Fri, 15 Dec 2023 18:07:07 +0800
Message-Id: <20231215100708.2265609-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHlQsLJXxlJTfVDg--.54090S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kKr4kCF1ruFy3Ar4UXFb_yoW5Kw1DpF
	sYqw1qyayrX348X3WUJa9Fv3W09r1DZry5Grs7Ww43Zrn7XFyxtFyxKFW2gFn8urykKw45
	ArWYvF4UCFWUXFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Since libbpf v1.0, libbpf doesn't return error code embedded into the
pointer iteself, libbpf_get_error() is deprecated and it is basically
the same as using -errno directly.

So replace the invocations of libbpf_get_error() by -errno in
kprobe_multi_test. For libbpf_get_error() in test_attach_api_fails(),
saving -errno before invoking ASSERT_xx() macros just in case that
errno is overwritten by these macros. However, the invocation of
libbpf_get_error() in get_syms() should be kept intact, because
hashmap__new() still returns a pointer with embedded error code.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/kprobe_multi_test.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 4041cfa670eb..6079611b5df4 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -222,6 +222,7 @@ static void test_attach_api_fails(void)
 		"bpf_fentry_test2",
 	};
 	__u64 cookies[2];
+	int saved_error;
 
 	addrs[0] = ksym_get_addr("bpf_fentry_test1");
 	addrs[1] = ksym_get_addr("bpf_fentry_test2");
@@ -238,10 +239,11 @@ static void test_attach_api_fails(void)
 	/* fail_1 - pattern and opts NULL */
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     NULL, NULL);
+	saved_error = -errno;
 	if (!ASSERT_ERR_PTR(link, "fail_1"))
 		goto cleanup;
 
-	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_1_error"))
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_1_error"))
 		goto cleanup;
 
 	/* fail_2 - both addrs and syms set */
@@ -252,10 +254,11 @@ static void test_attach_api_fails(void)
 
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     NULL, &opts);
+	saved_error = -errno;
 	if (!ASSERT_ERR_PTR(link, "fail_2"))
 		goto cleanup;
 
-	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_2_error"))
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_2_error"))
 		goto cleanup;
 
 	/* fail_3 - pattern and addrs set */
@@ -266,10 +269,11 @@ static void test_attach_api_fails(void)
 
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     "ksys_*", &opts);
+	saved_error = -errno;
 	if (!ASSERT_ERR_PTR(link, "fail_3"))
 		goto cleanup;
 
-	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_3_error"))
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_3_error"))
 		goto cleanup;
 
 	/* fail_4 - pattern and cnt set */
@@ -280,10 +284,11 @@ static void test_attach_api_fails(void)
 
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     "ksys_*", &opts);
+	saved_error = -errno;
 	if (!ASSERT_ERR_PTR(link, "fail_4"))
 		goto cleanup;
 
-	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_4_error"))
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_4_error"))
 		goto cleanup;
 
 	/* fail_5 - pattern and cookies */
@@ -294,10 +299,11 @@ static void test_attach_api_fails(void)
 
 	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
 						     "ksys_*", &opts);
+	saved_error = -errno;
 	if (!ASSERT_ERR_PTR(link, "fail_5"))
 		goto cleanup;
 
-	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"))
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_5_error"))
 		goto cleanup;
 
 cleanup:
-- 
2.29.2


