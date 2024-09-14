Return-Path: <bpf+bounces-39904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9A97910A
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA801F22E3F
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DD1CFEC5;
	Sat, 14 Sep 2024 13:37:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B481CF5E0
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321027; cv=none; b=LSCqjfOMx/fiUsLmi0ryDdVwEr/lEHdReV7QKPodBtA3gAzNHq5fAt4MsLVjgU4z2KlgcX2nP64PZReNVAUaw7qr44hvg3EvewyGSCXxYVqEsViV0A6dAjML0lTZWTUhIIjYBY7c4a4Xy8KqJ2DKChW0ZGaWi4gGFN8SjnJDftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321027; c=relaxed/simple;
	bh=y6nCdWO8qLK20kmuH06EI8PyrDGRhJj1ZBYOD2DKw+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCQYs3mcvd46vacBSawahD3n49MYDUIPw3E7GFUx7dIl7WKnY9w5K4MeAvc0qDuXPaX76OiuqpD600kDNMfTMHOBC80+7ACy6FfaC/pdtdnjWmsXqlhE8Eun+kv7gyYwF8R0bo4Tw9rS6E3y8b5FLXj2S5vZPRtYgDURmyVIKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X5XJx6KKsz4f3jkY
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 21:36:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A26E91A018D
	for <bpf@vger.kernel.org>; Sat, 14 Sep 2024 21:37:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8R3keVmnUI4BQ--.14337S6;
	Sat, 14 Sep 2024 21:37:00 +0800 (CST)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add more test case for field flattening
Date: Sat, 14 Sep 2024 21:37:03 +0800
Message-Id: <20240914133703.1920767-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20240914133703.1920767-1-houtao@huaweicloud.com>
References: <20240914133703.1920767-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8R3keVmnUI4BQ--.14337S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy8tr1UGFyDtF4xXw1rXrb_yoWxury8pa
	48X340krWxtF1xG34UCa97GFWSgw1kZF4Fgr98C34avFy7Jr97ZF48K3WUJr1YgrZY9w1f
	Aryvvws3Wa1kCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIID7
	DUUUU
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
 .../selftests/bpf/progs/cpumask_common.h      |  5 ++
 .../selftests/bpf/progs/cpumask_failure.c     | 35 +++++++++
 .../selftests/bpf/progs/cpumask_success.c     | 78 ++++++++++++++++++-
 4 files changed, 117 insertions(+), 2 deletions(-)

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
 
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index b979e91f55f0..4ece7873ba60 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -7,6 +7,11 @@
 #include "errno.h"
 #include <stdbool.h>
 
+/* Should use BTF_FIELDS_MAX, but it is not always available in vmlinux.h,
+ * so use the hard-coded number as a workaround.
+ */
+#define CPUMASK_KPTR_FIELDS_MAX 11
+
 int err;
 
 #define private(name) SEC(".bss." #name) __attribute__((aligned(8)))
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index a988d2823b52..b40b52548ffb 100644
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
+	struct kptr_nested_array_2 d_2[CPUMASK_KPTR_FIELDS_MAX + 1];
+};
+
+struct kptr_nested_array {
+	struct kptr_nested_array_1 d_1;
+};
+
+private(MASK_NESTED) static struct kptr_nested_array global_mask_nested_arr;
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
+	prev = bpf_kptr_xchg(&global_mask_nested_arr.d_1.d_2[CPUMASK_KPTR_FIELDS_MAX].mask, local);
+	if (prev) {
+		bpf_cpumask_release(prev);
+		err = 3;
+		return 0;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index fd8106831c32..80ee469b0b60 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -31,11 +31,59 @@ struct kptr_nested_deep {
 	struct kptr_nested_pair ptr_pairs[3];
 };
 
+struct kptr_nested_deep_array_1_2 {
+	int dummy;
+	struct bpf_cpumask __kptr * mask[CPUMASK_KPTR_FIELDS_MAX];
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
+	struct kptr_nested_deep_array_2_2 d_2[CPUMASK_KPTR_FIELDS_MAX];
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
+	struct kptr_nested_deep_array_3_1 d_1[CPUMASK_KPTR_FIELDS_MAX];
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
+	for (i = 0; i < CPUMASK_KPTR_FIELDS_MAX; i++)
+		_global_mask_array_rcu(&global_mask_nested_deep_array_1.d_1.d_2.mask[i], NULL);
+
+	for (i = 0; i < CPUMASK_KPTR_FIELDS_MAX; i++)
+		_global_mask_array_rcu(&global_mask_nested_deep_array_2.d_1.d_2[i].mask, NULL);
+
+	for (i = 0; i < CPUMASK_KPTR_FIELDS_MAX; i++)
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


