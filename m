Return-Path: <bpf+bounces-29993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C8C8C8F73
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 05:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B931F22113
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 03:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0976D2E6;
	Sat, 18 May 2024 03:28:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1E5C96;
	Sat, 18 May 2024 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716002882; cv=none; b=tpIBh3CHojUDX1zvAMk5X/IpNq9lL5oGiF6Qz0cGoRp9S+M1qbvanZoQuJ5VV1d79r6gQRRnXL5RICRyltXX1heN3e7BMWCN6Q+nVFEnaW4hxpz7fEHkbaU4dK1GgqiMGsh3gZw4YfyKpVreYpKMfZs8ZufMjLfg2lrJkW7or3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716002882; c=relaxed/simple;
	bh=CNGtXVdSqTyJ7v3hujORB9f4UY1bMCnmKT/PFmfKLmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lsr8Eg6uFovMM/hOPYIth2OEiXEZqZEKpem6jkBgfTZ2AtJNuIqbeTEJa1evFN5l3jHHjobEsuBDD3eUuRay40AqaGUqZKVIGfgDktGHICzohHgohm4Yq3jwnYeYA55Q0zFqQaInp66WYBhV1F9i4bPGxANCVh8LAT2SpT5qCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vh8R72M4mz4f3jsq;
	Sat, 18 May 2024 11:27:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1E2981A01A7;
	Sat, 18 May 2024 11:27:56 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with SMTP id Syh0CgC3Gf05IEhmkYcnNQ--.13474S5;
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Add testcase where 7th argment is struct
Date: Sat, 18 May 2024 03:28:56 +0000
Message-Id: <20240518032856.2721688-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240518032856.2721688-1-pulehui@huaweicloud.com>
References: <20240518032856.2721688-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3Gf05IEhmkYcnNQ--.13474S5
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWxCryxGr1DCFW5Aw4xWFg_yoWxWFW8pa
	s7Xw1jyFWrJF47WryxGa1UZr4S9393Xr1UJFW7G3s0vry8t3s7JF1xKF4jyFn5W398uwnx
	AayqkFZ8Ca18JFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add testcase where 7th argument is struct for architectures with 8
argument registers, and increase the complexity of the struct.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 14 ++++++++
 .../bpf/progs/tracing_struct_many_args.c      | 35 +++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 0445ac38bc07..3c7c3e79aa93 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -6,6 +6,7 @@ kprobe_multi_test                                # needs CONFIG_FPROBE
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
 fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
 fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
+tracing_struct/struct_many_args                  # struct_many_args:FAIL:tracing_struct_many_args__attach unexpected error: -524
 fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 2a18bd320e92..28bf205b143f 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -53,6 +53,13 @@ struct bpf_testmod_struct_arg_4 {
 	int b;
 };
 
+struct bpf_testmod_struct_arg_5 {
+	char a;
+	short b;
+	int c;
+	long d;
+};
+
 __bpf_hook_start();
 
 noinline int
@@ -110,6 +117,15 @@ bpf_testmod_test_struct_arg_8(u64 a, void *b, short c, int d, void *e,
 	return bpf_testmod_test_struct_arg_result;
 }
 
+noinline int
+bpf_testmod_test_struct_arg_9(u64 a, void *b, short c, int d, void *e, char f,
+			      short g, struct bpf_testmod_struct_arg_5 h, long i)
+{
+	bpf_testmod_test_struct_arg_result = a + (long)b + c + d + (long)e +
+		f + g + h.a + h.b + h.c + h.d + i;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 noinline int
 bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
 	bpf_testmod_test_struct_arg_result = a->a;
@@ -269,6 +285,7 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_struct_arg_2 struct_arg2 = {2, 3};
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	struct bpf_testmod_struct_arg_4 struct_arg4 = {21, 22};
+	struct bpf_testmod_struct_arg_5 struct_arg5 = {23, 24, 25, 26};
 	int i = 1;
 
 	while (bpf_testmod_return_ptr(i))
@@ -283,6 +300,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 					    (void *)20, struct_arg4);
 	(void)bpf_testmod_test_struct_arg_8(16, (void *)17, 18, 19,
 					    (void *)20, struct_arg4, 23);
+	(void)bpf_testmod_test_struct_arg_9(16, (void *)17, 18, 19, (void *)20,
+					    21, 22, struct_arg5, 27);
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
index 2820fd912f2f..1e7ac6fc34bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -95,6 +95,20 @@ static void test_struct_many_args(void)
 	ASSERT_EQ(skel->bss->t8_g, 23, "t8:g");
 	ASSERT_EQ(skel->bss->t8_ret, 156, "t8 ret");
 
+	ASSERT_EQ(skel->bss->t9_a, 16, "t9:a");
+	ASSERT_EQ(skel->bss->t9_b, 17, "t9:b");
+	ASSERT_EQ(skel->bss->t9_c, 18, "t9:c");
+	ASSERT_EQ(skel->bss->t9_d, 19, "t9:d");
+	ASSERT_EQ(skel->bss->t9_e, 20, "t9:e");
+	ASSERT_EQ(skel->bss->t9_f, 21, "t9:f");
+	ASSERT_EQ(skel->bss->t9_g, 22, "t9:f");
+	ASSERT_EQ(skel->bss->t9_h_a, 23, "t9:h.a");
+	ASSERT_EQ(skel->bss->t9_h_b, 24, "t9:h.b");
+	ASSERT_EQ(skel->bss->t9_h_c, 25, "t9:h.c");
+	ASSERT_EQ(skel->bss->t9_h_d, 26, "t9:h.d");
+	ASSERT_EQ(skel->bss->t9_i, 27, "t9:i");
+	ASSERT_EQ(skel->bss->t9_ret, 258, "t9 ret");
+
 	tracing_struct_many_args__detach(skel);
 destroy_skel:
 	tracing_struct_many_args__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
index 8bd696dc81d9..ea634a818345 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_many_args.c
@@ -10,8 +10,16 @@ struct bpf_testmod_struct_arg_4 {
 	int b;
 };
 
+struct bpf_testmod_struct_arg_5 {
+	char a;
+	short b;
+	int c;
+	long d;
+};
+
 long t7_a, t7_b, t7_c, t7_d, t7_e, t7_f_a, t7_f_b, t7_ret;
 long t8_a, t8_b, t8_c, t8_d, t8_e, t8_f_a, t8_f_b, t8_g, t8_ret;
+long t9_a, t9_b, t9_c, t9_d, t9_e, t9_f, t9_g, t9_h_a, t9_h_b, t9_h_c, t9_h_d, t9_i, t9_ret;
 
 SEC("fentry/bpf_testmod_test_struct_arg_7")
 int BPF_PROG2(test_struct_many_args_1, __u64, a, void *, b, short, c, int, d,
@@ -59,4 +67,31 @@ int BPF_PROG2(test_struct_many_args_4, __u64, a, void *, b, short, c, int, d,
 	return 0;
 }
 
+SEC("fentry/bpf_testmod_test_struct_arg_9")
+int BPF_PROG2(test_struct_many_args_5, __u64, a, void *, b, short, c, int, d, void *, e,
+	      char, f, short, g, struct bpf_testmod_struct_arg_5, h, long, i)
+{
+	t9_a = a;
+	t9_b = (long)b;
+	t9_c = c;
+	t9_d = d;
+	t9_e = (long)e;
+	t9_f = f;
+	t9_g = g;
+	t9_h_a = h.a;
+	t9_h_b = h.b;
+	t9_h_c = h.c;
+	t9_h_d = h.d;
+	t9_i = i;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_9")
+int BPF_PROG2(test_struct_many_args_6, __u64, a, void *, b, short, c, int, d, void *, e,
+	      char, f, short, g, struct bpf_testmod_struct_arg_5, h, long, i, int, ret)
+{
+	t9_ret = ret;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


