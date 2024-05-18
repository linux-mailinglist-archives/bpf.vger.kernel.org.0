Return-Path: <bpf+bounces-29992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF598C8F70
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 05:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE48282B61
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 03:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E497523A;
	Sat, 18 May 2024 03:28:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C84C96;
	Sat, 18 May 2024 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716002882; cv=none; b=YQ+9eQW/1iepNrdMrFXOXyUjlqQMaHBB9/l37C3nPwFAHmBjWcf0A/60qxbMfvpxRT0RpwIxLXaQVJyCNneVpvzJ3CoRrygHofA/3rRKELHB54s9a8kbndgcFvP2y92BEJ5CREbXIcYhn1VU06uR6xyKivuExCMaD2z+aG3gFfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716002882; c=relaxed/simple;
	bh=v+KkXqM1aTC/ca92oWVFBc85dE9cNvxkrd2UsoVbGR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2ag2VfR/08+GjtpJJvbeMNnazJ3fzFps9ZGkF8SpPpHc4OdMK2Mr7uWjCiYLKvC0NjnzUPcRP0x/su63FmEjtU9JS9XmA0vSzDBwOax6dmZW29nL826rOFc+01l62zFf1QY9DfUsZH0jxbZjm491CkwWSaAllGh72awzV/GsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vh8R71bHdz4f3jsb;
	Sat, 18 May 2024 11:27:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 00D111A016E;
	Sat, 18 May 2024 11:27:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgC3Gf05IEhmkYcnNQ--.13474S4;
	Sat, 18 May 2024 11:27:55 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Menglong Dong <imagedong@tencent.com>,
	Pu Lehui <pulehui@gmail.com>
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Factor out many args tests from tracing_struct
Date: Sat, 18 May 2024 03:28:55 +0000
Message-Id: <20240518032856.2721688-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240518032856.2721688-1-pulehui@huaweicloud.com>
References: <20240518032856.2721688-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3Gf05IEhmkYcnNQ--.13474S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry7Gr13JFWxKrWDAr4kXrb_yoWxWFy7pa
	409w1UtF4rJr48Wry8Aa1UZr4Sgrs3ZF1jyry7J3sYvFyxt3sFqF1kKa4jy3Z8G3y5uwnx
	AFWqyFs8Ar4UAF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbp6wtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Factor out many args tests from tracing_struct and rename some function
names to make more sense.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 32 ++++++++--
 .../selftests/bpf/progs/tracing_struct.c      | 54 ----------------
 .../bpf/progs/tracing_struct_many_args.c      | 62 +++++++++++++++++++
 3 files changed, 90 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_many_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index fe0fb0c9849a..2820fd912f2f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -3,8 +3,9 @@
 
 #include <test_progs.h>
 #include "tracing_struct.skel.h"
+#include "tracing_struct_many_args.skel.h"
 
-static void test_fentry(void)
+static void test_struct_args(void)
 {
 	struct tracing_struct *skel;
 	int err;
@@ -55,6 +56,26 @@ static void test_fentry(void)
 
 	ASSERT_EQ(skel->bss->t6, 1, "t6 ret");
 
+	tracing_struct__detach(skel);
+destroy_skel:
+	tracing_struct__destroy(skel);
+}
+
+static void test_struct_many_args(void)
+{
+	struct tracing_struct_many_args *skel;
+	int err;
+
+	skel = tracing_struct_many_args__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_struct_many_args__open_and_load"))
+		return;
+
+	err = tracing_struct_many_args__attach(skel);
+	if (!ASSERT_OK(err, "tracing_struct_many_args__attach"))
+		goto destroy_skel;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
 	ASSERT_EQ(skel->bss->t7_a, 16, "t7:a");
 	ASSERT_EQ(skel->bss->t7_b, 17, "t7:b");
 	ASSERT_EQ(skel->bss->t7_c, 18, "t7:c");
@@ -74,12 +95,15 @@ static void test_fentry(void)
 	ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
 	ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
 
-	tracing_struct__detach(skel);
+	tracing_struct_many_args__detach(skel);
 destroy_skel:
-	tracing_struct__destroy(skel);
+	tracing_struct_many_args__destroy(skel);
 }
 
 void test_tracing_struct(void)
 {
-	test_fentry();
+	if (test__start_subtest("struct_args"))
+		test_struct_args();
+	if (test__start_subtest("struct_many_args"))
+		test_struct_many_args();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/testing/selftests/bpf/progs/tracing_struct.c
index 515daef3c84b..c435a3a8328a 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -18,11 +18,6 @@ struct bpf_testmod_struct_arg_3 {
 	int b[];
 };
 
-struct bpf_testmod_struct_arg_4 {
-	u64 a;
-	int b;
-};
-
 long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
 __u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
 long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
@@ -30,9 +25,6 @@ long t3_a, t3_b, t3_c_a, t3_c_b, t3_ret;
 long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
 long t5_ret;
 int t6;
-long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
-long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
-
 
 SEC("fentry/bpf_testmod_test_struct_arg_1")
 int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int, b, int, c)
@@ -138,50 +130,4 @@ int BPF_PROG2(test_struct_arg_11, struct bpf_testmod_struct_arg_3 *, a)
 	return 0;
 }
 
-SEC("fentry/bpf_testmod_test_struct_arg_7")
-int BPF_PROG2(test_struct_arg_12, __u64, a, void *, b, short, c, int, d,
-	      void *, e, struct bpf_testmod_struct_arg_4, f)
-{
-	t7_a = a;
-	t7_b = (long)b;
-	t7_c = c;
-	t7_d = d;
-	t7_e = (long)e;
-	t7_f_a = f.a;
-	t7_f_b = f.b;
-	return 0;
-}
-
-SEC("fexit/bpf_testmod_test_struct_arg_7")
-int BPF_PROG2(test_struct_arg_13, __u64, a, void *, b, short, c, int, d,
-	      void *, e, struct bpf_testmod_struct_arg_4, f, int, ret)
-{
-	t7_ret = ret;
-	return 0;
-}
-
-SEC("fentry/bpf_testmod_test_struct_arg_8")
-int BPF_PROG2(test_struct_arg_14, __u64, a, void *, b, short, c, int, d,
-	      void *, e, struct bpf_testmod_struct_arg_4, f, int, g)
-{
-	t8_a = a;
-	t8_b = (long)b;
-	t8_c = c;
-	t8_d = d;
-	t8_e = (long)e;
-	t8_f_a = f.a;
-	t8_f_b = f.b;
-	t8_g = g;
-	return 0;
-}
-
-SEC("fexit/bpf_testmod_test_struct_arg_8")
-int BPF_PROG2(test_struct_arg_15, __u64, a, void *, b, short, c, int, d,
-	      void *, e, struct bpf_testmod_struct_arg_4, f, int, g,
-	      int, ret)
-{
-	t8_ret = ret;
-	return 0;
-}
-
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
new file mode 100644
index 000000000000..8bd696dc81d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct bpf_testmod_struct_arg_4 {
+	u64 a;
+	int b;
+};
+
+long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
+long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
+
+SEC("fentry/bpf_testmod_test_struct_arg_7")
+int BPF_PROG2(test_struct_many_args_1, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f)
+{
+	t7_a = a;
+	t7_b = (long)b;
+	t7_c = c;
+	t7_d = d;
+	t7_e = (long)e;
+	t7_f_a = f.a;
+	t7_f_b = f.b;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_7")
+int BPF_PROG2(test_struct_many_args_2, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f, int, ret)
+{
+	t7_ret = ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_8")
+int BPF_PROG2(test_struct_many_args_3, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f, int, g)
+{
+	t8_a = a;
+	t8_b = (long)b;
+	t8_c = c;
+	t8_d = d;
+	t8_e = (long)e;
+	t8_f_a = f.a;
+	t8_f_b = f.b;
+	t8_g = g;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_8")
+int BPF_PROG2(test_struct_many_args_4, __u64, a, void *, b, short, c, int, d,
+	      void *, e, struct bpf_testmod_struct_arg_4, f, int, g,
+	      int, ret)
+{
+	t8_ret = ret;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


