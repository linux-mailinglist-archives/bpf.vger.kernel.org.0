Return-Path: <bpf+bounces-39603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E697506F
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF42F28E3C1
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BD186607;
	Wed, 11 Sep 2024 11:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B37DA81
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052758; cv=none; b=oMSMdzCXPPh66Ra25uzVu6scaxxzlrDMru3sfD4Q2Z1ilhQuaj72jBv3nUSz1Tr2DRwKCG205TJvQWFNh8QZVcmkxvMUbPIJXKQST9SiaMJkNnEtsMiekPyajmubUzbNSongHGHNm5kkugBkJJvsFcIgJaoQhaUryIVi6FGYbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052758; c=relaxed/simple;
	bh=zyD9fHM3lQEUOQxwhYfV3DKmxeEisgL7x6qFE2HyTn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IROlaOdfP6GlHMR2TCDPPAd7D+uUhM/b8XQOwW3IEwqxbK7PkQg3DEUADxPPmpwE8Fv7dODYE4q/wlUduuM2rZySxNhKLPai+dfvqp0NURPCrTnR+k8v3X+9e9wZRuUzCryOgsHnWvGWZJWm3LRUR19OJsz1+/l+95DHj2cp+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X3d5r1KFPz4f3l23
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 19:05:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6A38A1A07B6
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 19:05:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMiMeeFmB9sSBA--.4297S6;
	Wed, 11 Sep 2024 19:05:52 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [RESEND][PATCH bpf 2/2] selftests/bpf: Add more test case for field flattening
Date: Wed, 11 Sep 2024 19:05:57 +0800
Message-Id: <20240911110557.2759801-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240911110557.2759801-1-houtao@huaweicloud.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMiMeeFmB9sSBA--.4297S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy8tr1UGF4xuF1xuF48JFb_yoWxJw1Dpa
	48X34vkrWxtF1fG34UCa97GFWSgw1kZFW5Wr90k34avFW7tr97ZF48K3WUJr1YgrZYgw1x
	Aryvvws3Wa1kCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add three success test cases to test the flattening of array of nested
struct. For these three tests, the number of special fields in map is
BTF_FIELDS_MAX, but the array is defined in structs with different
nested level.

Add one failure test case for the flattening as well. In the test case,
the number of special fields in map is BTF_FIELDS_MAX + 1. It will make
btf_parse_fields() in map_create() return -E2BIG, the creation of map
will succeed, but the load of program will fail because the btf_record
is invalid for the map.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_failure.c     | 35 +++++++++
 .../selftests/bpf/progs/cpumask_success.c     | 78 ++++++++++++++++++-
 3 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index 2570bd4b0cb2..e58a04654238 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -23,6 +23,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_global_mask_array_l2_rcu",
 	"test_global_mask_nested_rcu",
 	"test_global_mask_nested_deep_rcu",
+	"test_global_mask_nested_deep_array_rcu",
 	"test_cpumask_weight",
 };
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index a988d2823b52..e9cb93ce9533 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -10,6 +10,21 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct kptr_nested_array_2 {
+	struct bpf_cpumask __kptr * mask;
+};
+
+struct kptr_nested_array_1 {
+	/* Make btf_parse_fields() in map_create() return -E2BIG */
+	struct kptr_nested_array_2 d_2[BTF_FIELDS_MAX + 1];
+};
+
+struct kptr_nested_array {
+	struct kptr_nested_array_1 d_1;
+};
+
+private(MASK_NESTED) static struct kptr_nested_array global_mask_nested_array;
+
 /* Prototype for all of the program trace events below:
  *
  * TRACE_EVENT(task_newtask,
@@ -187,3 +202,23 @@ int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *task, u64 c
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__failure __msg("has no valid kptr")
+int BPF_PROG(test_invalid_nested_array, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *local, *prev;
+
+	local = create_cpumask();
+	if (!local)
+		return 0;
+
+	prev = bpf_kptr_xchg(&global_mask_nested_array.d_1.d_2[BTF_FIELDS_MAX].mask, local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index fd8106831c32..c634a34dec51 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -31,11 +31,59 @@ struct kptr_nested_deep {
 	struct kptr_nested_pair ptr_pairs[3];
 };
 
+struct kptr_nested_deep_array_1_2 {
+	int dummy;
+	struct bpf_cpumask __kptr * mask[BTF_FIELDS_MAX];
+};
+
+struct kptr_nested_deep_array_1_1 {
+	int dummy;
+	struct kptr_nested_deep_array_1_2 d_2;
+};
+
+struct kptr_nested_deep_array_1 {
+	long dummy;
+	struct kptr_nested_deep_array_1_1 d_1;
+};
+
+struct kptr_nested_deep_array_2_2 {
+	long dummy[2];
+	struct bpf_cpumask __kptr * mask;
+};
+
+struct kptr_nested_deep_array_2_1 {
+	int dummy;
+	struct kptr_nested_deep_array_2_2 d_2[BTF_FIELDS_MAX];
+};
+
+struct kptr_nested_deep_array_2 {
+	long dummy;
+	struct kptr_nested_deep_array_2_1 d_1;
+};
+
+struct kptr_nested_deep_array_3_2 {
+	long dummy[2];
+	struct bpf_cpumask __kptr * mask;
+};
+
+struct kptr_nested_deep_array_3_1 {
+	int dummy;
+	struct kptr_nested_deep_array_3_2 d_2;
+};
+
+struct kptr_nested_deep_array_3 {
+	long dummy;
+	struct kptr_nested_deep_array_3_1 d_1[BTF_FIELDS_MAX];
+};
+
 private(MASK) static struct bpf_cpumask __kptr * global_mask_array[2];
 private(MASK) static struct bpf_cpumask __kptr * global_mask_array_l2[2][1];
 private(MASK) static struct bpf_cpumask __kptr * global_mask_array_one[1];
 private(MASK) static struct kptr_nested global_mask_nested[2];
 private(MASK_DEEP) static struct kptr_nested_deep global_mask_nested_deep;
+private(MASK_1) static struct kptr_nested_deep_array_1 global_mask_nested_deep_array_1;
+private(MASK_2) static struct kptr_nested_deep_array_2 global_mask_nested_deep_array_2;
+private(MASK_3) static struct kptr_nested_deep_array_3 global_mask_nested_deep_array_3;
 
 static bool is_test_task(void)
 {
@@ -543,12 +591,21 @@ static int _global_mask_array_rcu(struct bpf_cpumask **mask0,
 		goto err_exit;
 	}
 
-	/* [<mask 0>, NULL] */
-	if (!*mask0 || *mask1) {
+	/* [<mask 0>, *] */
+	if (!*mask0) {
 		err = 2;
 		goto err_exit;
 	}
 
+	if (!mask1)
+		goto err_exit;
+
+	/* [*, NULL] */
+	if (*mask1) {
+		err = 3;
+		goto err_exit;
+	}
+
 	local = create_cpumask();
 	if (!local) {
 		err = 9;
@@ -631,6 +688,23 @@ int BPF_PROG(test_global_mask_nested_deep_rcu, struct task_struct *task, u64 clo
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_global_mask_nested_deep_array_rcu, struct task_struct *task, u64 clone_flags)
+{
+	int i;
+
+	for (i = 0; i < BTF_FIELDS_MAX; i++)
+		_global_mask_array_rcu(&global_mask_nested_deep_array_1.d_1.d_2.mask[i], NULL);
+
+	for (i = 0; i < BTF_FIELDS_MAX; i++)
+		_global_mask_array_rcu(&global_mask_nested_deep_array_2.d_1.d_2[i].mask, NULL);
+
+	for (i = 0; i < BTF_FIELDS_MAX; i++)
+		_global_mask_array_rcu(&global_mask_nested_deep_array_3.d_1[i].d_2.mask, NULL);
+
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_cpumask_weight, struct task_struct *task, u64 clone_flags)
 {
-- 
2.29.2


