Return-Path: <bpf+bounces-9497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E492B79880B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D501C20C2B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C556AA5;
	Fri,  8 Sep 2023 13:39:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC263DE
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:39:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2C1BF4
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:39:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rhxzp6rVpz4f3l83
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:39:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHVqkPJPtkRmSwCg--.44307S8;
	Fri, 08 Sep 2023 21:39:35 +0800 (CST)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf 4/4] selftests/bpf: Test all valid alloc sizes for bpf mem allocator
Date: Fri,  8 Sep 2023 21:39:23 +0800
Message-Id: <20230908133923.2675053-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230908133923.2675053-1-houtao@huaweicloud.com>
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHVqkPJPtkRmSwCg--.44307S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4fWryxCr4kWF4DAFy8AFb_yoW7ur1xpa
	40yFyYyrWfXw1xuryS9w429F1rXFs5Zw15JryxWFyUZr1rtryxtr1kKFy8tF93trWvgr4r
	Aa4agFWfGrs7A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Add a test to test all possible and valid allocation size for bpf
memory allocator. For each possible allocation size, the test uses
the following two steps to test the alloc and free path:

1) allocate N (N > high_watermark) objects to trigger the refill
   executed in irq_work.
2) free N objects to trigger the freeing executed in irq_work.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/test_bpf_ma.c    |  50 +++++++
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 123 ++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_ma.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
new file mode 100644
index 000000000000..0cca4e8ae38e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <bpf/btf.h>
+#include <test_progs.h>
+
+#include "test_bpf_ma.skel.h"
+
+void test_test_bpf_ma(void)
+{
+	struct test_bpf_ma *skel;
+	struct btf *btf;
+	int i, err;
+
+	skel = test_bpf_ma__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	btf = bpf_object__btf(skel->obj);
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(skel->rodata->data_sizes); i++) {
+		char name[32];
+		int id;
+
+		snprintf(name, sizeof(name), "bin_data_%u", skel->rodata->data_sizes[i]);
+		id = btf__find_by_name_kind(btf, name, BTF_KIND_STRUCT);
+		if (!ASSERT_GT(id, 0, "bin_data"))
+			goto out;
+		skel->rodata->data_btf_ids[i] = id;
+	}
+
+	err = test_bpf_ma__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto out;
+
+	err = test_bpf_ma__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	skel->bss->pid = getpid();
+	usleep(1);
+	ASSERT_OK(skel->bss->err, "test error");
+out:
+	test_bpf_ma__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
new file mode 100644
index 000000000000..ecde41ae0fc8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+struct generic_map_value {
+	void *data;
+};
+
+char _license[] SEC("license") = "GPL";
+
+const unsigned int data_sizes[] = {8, 16, 32, 64, 96, 128, 192, 256, 512, 1024, 2048, 4096};
+const volatile unsigned int data_btf_ids[ARRAY_SIZE(data_sizes)] = {};
+
+int err = 0;
+int pid = 0;
+
+#define DEFINE_ARRAY_WITH_KPTR(_size) \
+	struct bin_data_##_size { \
+		char data[_size - sizeof(void *)]; \
+	}; \
+	struct map_value_##_size { \
+		struct bin_data_##_size __kptr * data; \
+		/* To emit BTF info for bin_data_xx */ \
+		struct bin_data_##_size not_used; \
+	}; \
+	struct { \
+		__uint(type, BPF_MAP_TYPE_ARRAY); \
+		__type(key, int); \
+		__type(value, struct map_value_##_size); \
+		__uint(max_entries, 128); \
+	} array_##_size SEC(".maps");
+
+static __always_inline void batch_alloc_free(struct bpf_map *map, unsigned int batch,
+					     unsigned int idx)
+{
+	struct generic_map_value *value;
+	unsigned int i, key;
+	void *old, *new;
+
+	for (i = 0; i < batch; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value) {
+			err = 1;
+			return;
+		}
+		new = bpf_obj_new_impl(data_btf_ids[idx], NULL);
+		if (!new) {
+			err = 2;
+			return;
+		}
+		old = bpf_kptr_xchg(&value->data, new);
+		if (old) {
+			bpf_obj_drop(old);
+			err = 3;
+			return;
+		}
+	}
+	for (i = 0; i < batch; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value) {
+			err = 4;
+			return;
+		}
+		old = bpf_kptr_xchg(&value->data, NULL);
+		if (!old) {
+			err = 5;
+			return;
+		}
+		bpf_obj_drop(old);
+	}
+}
+
+#define CALL_BATCH_ALLOC_FREE(size, batch, idx) \
+	batch_alloc_free((struct bpf_map *)(&array_##size), batch, idx)
+
+DEFINE_ARRAY_WITH_KPTR(8);
+DEFINE_ARRAY_WITH_KPTR(16);
+DEFINE_ARRAY_WITH_KPTR(32);
+DEFINE_ARRAY_WITH_KPTR(64);
+DEFINE_ARRAY_WITH_KPTR(96);
+DEFINE_ARRAY_WITH_KPTR(128);
+DEFINE_ARRAY_WITH_KPTR(192);
+DEFINE_ARRAY_WITH_KPTR(256);
+DEFINE_ARRAY_WITH_KPTR(512);
+DEFINE_ARRAY_WITH_KPTR(1024);
+DEFINE_ARRAY_WITH_KPTR(2048);
+DEFINE_ARRAY_WITH_KPTR(4096);
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int test_bpf_mem_alloc_free(void *ctx)
+{
+	if ((u32)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	/* Alloc 128 8-bytes objects in batch to trigger refilling,
+	 * then free 128 8-bytes objects in batch to trigger freeing.
+	 */
+	CALL_BATCH_ALLOC_FREE(8, 128, 0);
+	CALL_BATCH_ALLOC_FREE(16, 128, 1);
+	CALL_BATCH_ALLOC_FREE(32, 128, 2);
+	CALL_BATCH_ALLOC_FREE(64, 128, 3);
+	CALL_BATCH_ALLOC_FREE(96, 128, 4);
+	CALL_BATCH_ALLOC_FREE(128, 128, 5);
+	CALL_BATCH_ALLOC_FREE(192, 128, 6);
+	CALL_BATCH_ALLOC_FREE(256, 128, 7);
+	CALL_BATCH_ALLOC_FREE(512, 64, 8);
+	CALL_BATCH_ALLOC_FREE(1024, 32, 9);
+	CALL_BATCH_ALLOC_FREE(2048, 16, 10);
+	CALL_BATCH_ALLOC_FREE(4096, 8, 11);
+
+	return 0;
+}
-- 
2.29.2


