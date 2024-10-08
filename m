Return-Path: <bpf+bounces-41192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D2994044
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC50F1F239EF
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEE1F12F0;
	Tue,  8 Oct 2024 06:59:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4271D0F60
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370753; cv=none; b=Q5WnnREAokEfQ5fpDA2jDI/8tvtNt06NBbE5UxZWaLsaTSxbfvvscOAfLXtfS59irD/FYgprR47KdBouwoqLq7cnEePeJxJmeg25k4V1n/uB1fvqcOAGG3DIA4PvmP8mPZlrgc9fh62KM9azRA+C+jq1igTSyDYe798S78AVnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370753; c=relaxed/simple;
	bh=y6nCdWO8qLK20kmuH06EI8PyrDGRhJj1ZBYOD2DKw+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KplwrE/l/BQ9W+37a1BQh4Jexrz6XdMkMUbfZbRMffoJ3DNIoyZCXZmkOYLqSgboAC3lDA1jLUF0ah8gJqd/imcYym1ZkU9V9AtI3Af0zbUlbYlax8QXIV/cqcyO+0Wgwwn8R7G6GLHupEjLQk9Y37tVYNq3sm0rKHzSqdlhNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN6Lf3LNxz4f3jY3
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 14:58:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4363C1A0568
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 14:59:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMg22ARnFIP_DQ--.38499S6;
	Tue, 08 Oct 2024 14:59:07 +0800 (CST)
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
	Kui-Feng Lee <thinker.li@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf RESEND 2/2] selftests/bpf: Add more test case for field flattening
Date: Tue,  8 Oct 2024 15:11:14 +0800
Message-Id: <20241008071114.3718177-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241008071114.3718177-1-houtao@huaweicloud.com>
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMg22ARnFIP_DQ--.38499S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy8tr1UGFyDtF4xXw1rXrb_yoWxury8pa
	48X340krWxtF1xG34UCa97GFWSgw1kZF4Fgr98C34avFy7Jr97ZF48K3WUJr1YgrZY9w1f
	Aryvvws3Wa1kCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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


