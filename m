Return-Path: <bpf+bounces-18642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0B81D38F
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFF1C21524
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94715CA48;
	Sat, 23 Dec 2023 10:39:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E5946D
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sy0zJ5vDMz4f3jsQ
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 18:39:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B06CC1A08FC
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 18:39:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH1QvquIZljMSpEQ--.5375S7;
	Sat, 23 Dec 2023 18:39:43 +0800 (CST)
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
	Eduard Zingerman <eddyz87@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test the inlining of bpf_kptr_xchg()
Date: Sat, 23 Dec 2023 18:40:42 +0800
Message-Id: <20231223104042.1432300-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231223104042.1432300-1-houtao@huaweicloud.com>
References: <20231223104042.1432300-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH1QvquIZljMSpEQ--.5375S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1DCFy8WF1UKFy7WFWfZrb_yoW5Zryrpa
	yrKFy5tr4Iq3W7C3yxGF47XFZ3Kan5urWYqrWfurWUAF1UZ34kXF1kKFs8tFnxXrWYvryr
	ZF1ftrn5CF1rJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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

The test uses bpf_prog_get_info_by_fd() to obtain the xlated
instructions of the program first. Since these instructions have
already been rewritten by the verifier, the tests then checks whether
the rewritten instructions are as expected.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/prog_tests/kptr_xchg_inline.c         | 51 +++++++++++++++++++
 .../selftests/bpf/progs/kptr_xchg_inline.c    | 28 ++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_inline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
new file mode 100644
index 000000000000..5a4bee1cf970
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <test_progs.h>
+
+#include "linux/filter.h"
+#include "kptr_xchg_inline.skel.h"
+
+void test_kptr_xchg_inline(void)
+{
+	struct kptr_xchg_inline *skel;
+	struct bpf_insn *insn = NULL;
+	struct bpf_insn exp;
+	unsigned int cnt;
+	int err;
+
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+
+	skel = kptr_xchg_inline__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+
+	err = get_xlated_program(bpf_program__fd(skel->progs.kptr_xchg_inline), &insn, &cnt);
+	if (!ASSERT_OK(err, "prog insn"))
+		goto out;
+
+	/* The original instructions are:
+	 * r1 = map[id:xxx][0]+0
+	 * r2 = 0
+	 * call bpf_kptr_xchg#yyy
+	 *
+	 * call bpf_kptr_xchg#yyy will be inlined as:
+	 * r0 = r2
+	 * r0 = atomic64_xchg((u64 *)(r1 +0), r0)
+	 */
+	if (!ASSERT_GT(cnt, 5, "insn cnt"))
+		goto out;
+
+	exp = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
+	if (!ASSERT_OK(memcmp(&insn[3], &exp, sizeof(exp)), "mov"))
+		goto out;
+
+	exp = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
+	if (!ASSERT_OK(memcmp(&insn[4], &exp, sizeof(exp)), "xchg"))
+		goto out;
+out:
+	free(insn);
+	kptr_xchg_inline__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c b/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
new file mode 100644
index 000000000000..1db7909828d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct bin_data {
+	char blob[32];
+};
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+private(kptr) struct bin_data __kptr * ptr;
+
+SEC("tc")
+int kptr_xchg_inline(void *ctx)
+{
+	void *old;
+
+	old = bpf_kptr_xchg(&ptr, NULL);
+	if (old)
+		bpf_obj_drop(old);
+
+	return 0;
+}
-- 
2.29.2


