Return-Path: <bpf+bounces-11619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AC7BC809
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 15:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6881C20BAB
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B1C27EE0;
	Sat,  7 Oct 2023 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEC1945D
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 13:50:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619DC5
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 06:50:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S2mrN6Sc0z4f3kk7
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 21:49:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnvdz9YSFl4YF2CQ--.30763S10;
	Sat, 07 Oct 2023 21:49:58 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
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
	houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH bpf-next 6/6] selftests/bpf: Add more test cases for bpf memory allocator
Date: Sat,  7 Oct 2023 21:51:06 +0800
Message-Id: <20231007135106.3031284-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231007135106.3031284-1-houtao@huaweicloud.com>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnvdz9YSFl4YF2CQ--.30763S10
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr45GF1rur1fJw4ftrWDJwb_yoWfXw1fpF
	y0yrySyr1kWF1Ig34Yvw4UC34rZF4fXw15GrZ5WFyUury5X34UArn5Ca4UJF95GFZ2gr45
	Aas0gF97KF4xA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Add the following 3 test cases for bpf memory allocator:
1) Do allocation in bpf program and free through map free
2) Do batch per-cpu allocation and per-cpu free in bpf program
3) Do per-cpu allocation in bpf program and free through map free

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/test_bpf_ma.c    |  20 +-
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 180 +++++++++++++++++-
 2 files changed, 193 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
index 0cca4e8ae38e..d3491a84b3b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
@@ -9,9 +9,10 @@
 
 #include "test_bpf_ma.skel.h"
 
-void test_test_bpf_ma(void)
+static void do_bpf_ma_test(const char *name)
 {
 	struct test_bpf_ma *skel;
+	struct bpf_program *prog;
 	struct btf *btf;
 	int i, err;
 
@@ -34,6 +35,11 @@ void test_test_bpf_ma(void)
 		skel->rodata->data_btf_ids[i] = id;
 	}
 
+	prog = bpf_object__find_program_by_name(skel->obj, name);
+	if (!ASSERT_OK_PTR(prog, "invalid prog name"))
+		goto out;
+	bpf_program__set_autoload(prog, true);
+
 	err = test_bpf_ma__load(skel);
 	if (!ASSERT_OK(err, "load"))
 		goto out;
@@ -48,3 +54,15 @@ void test_test_bpf_ma(void)
 out:
 	test_bpf_ma__destroy(skel);
 }
+
+void test_test_bpf_ma(void)
+{
+	if (test__start_subtest("batch_alloc_free"))
+		do_bpf_ma_test("test_batch_alloc_free");
+	if (test__start_subtest("free_through_map_free"))
+		do_bpf_ma_test("test_free_through_map_free");
+	if (test__start_subtest("batch_percpu_alloc_free"))
+		do_bpf_ma_test("test_batch_percpu_alloc_free");
+	if (test__start_subtest("percpu_free_through_map_free"))
+		do_bpf_ma_test("test_percpu_free_through_map_free");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
index ecde41ae0fc8..b685a4aba6bd 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -37,10 +37,20 @@ int pid = 0;
 		__type(key, int); \
 		__type(value, struct map_value_##_size); \
 		__uint(max_entries, 128); \
-	} array_##_size SEC(".maps");
+	} array_##_size SEC(".maps")
 
-static __always_inline void batch_alloc_free(struct bpf_map *map, unsigned int batch,
-					     unsigned int idx)
+#define DEFINE_ARRAY_WITH_PERCPU_KPTR(_size) \
+	struct map_value_percpu_##_size { \
+		struct bin_data_##_size __percpu_kptr * data; \
+	}; \
+	struct { \
+		__uint(type, BPF_MAP_TYPE_ARRAY); \
+		__type(key, int); \
+		__type(value, struct map_value_percpu_##_size); \
+		__uint(max_entries, 128); \
+	} array_percpu_##_size SEC(".maps")
+
+static __always_inline void batch_alloc(struct bpf_map *map, unsigned int batch, unsigned int idx)
 {
 	struct generic_map_value *value;
 	unsigned int i, key;
@@ -65,6 +75,14 @@ static __always_inline void batch_alloc_free(struct bpf_map *map, unsigned int b
 			return;
 		}
 	}
+}
+
+static __always_inline void batch_free(struct bpf_map *map, unsigned int batch, unsigned int idx)
+{
+	struct generic_map_value *value;
+	unsigned int i, key;
+	void *old;
+
 	for (i = 0; i < batch; i++) {
 		key = i;
 		value = bpf_map_lookup_elem(map, &key);
@@ -81,8 +99,72 @@ static __always_inline void batch_alloc_free(struct bpf_map *map, unsigned int b
 	}
 }
 
+static __always_inline void batch_percpu_alloc(struct bpf_map *map, unsigned int batch,
+					       unsigned int idx)
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
+		/* per-cpu allocator may not be able to refill in time */
+		new = bpf_percpu_obj_new_impl(data_btf_ids[idx], NULL);
+		if (!new)
+			continue;
+
+		old = bpf_kptr_xchg(&value->data, new);
+		if (old) {
+			bpf_percpu_obj_drop(old);
+			err = 2;
+			return;
+		}
+	}
+}
+
+static __always_inline void batch_percpu_free(struct bpf_map *map, unsigned int batch,
+					      unsigned int idx)
+{
+	struct generic_map_value *value;
+	unsigned int i, key;
+	void *old;
+
+	for (i = 0; i < batch; i++) {
+		key = i;
+		value = bpf_map_lookup_elem(map, &key);
+		if (!value) {
+			err = 3;
+			return;
+		}
+		old = bpf_kptr_xchg(&value->data, NULL);
+		if (!old)
+			continue;
+		bpf_percpu_obj_drop(old);
+	}
+}
+
+#define CALL_BATCH_ALLOC(size, batch, idx) \
+	batch_alloc((struct bpf_map *)(&array_##size), batch, idx)
+
 #define CALL_BATCH_ALLOC_FREE(size, batch, idx) \
-	batch_alloc_free((struct bpf_map *)(&array_##size), batch, idx)
+	do { \
+		batch_alloc((struct bpf_map *)(&array_##size), batch, idx); \
+		batch_free((struct bpf_map *)(&array_##size), batch, idx); \
+	} while (0)
+
+#define CALL_BATCH_PERCPU_ALLOC(size, batch, idx) \
+	batch_percpu_alloc((struct bpf_map *)(&array_percpu_##size), batch, idx)
+
+#define CALL_BATCH_PERCPU_ALLOC_FREE(size, batch, idx) \
+	do { \
+		batch_percpu_alloc((struct bpf_map *)(&array_percpu_##size), batch, idx); \
+		batch_percpu_free((struct bpf_map *)(&array_percpu_##size), batch, idx); \
+	} while (0)
 
 DEFINE_ARRAY_WITH_KPTR(8);
 DEFINE_ARRAY_WITH_KPTR(16);
@@ -97,8 +179,21 @@ DEFINE_ARRAY_WITH_KPTR(1024);
 DEFINE_ARRAY_WITH_KPTR(2048);
 DEFINE_ARRAY_WITH_KPTR(4096);
 
-SEC("fentry/" SYS_PREFIX "sys_nanosleep")
-int test_bpf_mem_alloc_free(void *ctx)
+/* per-cpu kptr doesn't support bin_data_8 which is a zero-sized array */
+DEFINE_ARRAY_WITH_PERCPU_KPTR(16);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(32);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(64);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(96);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(128);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(192);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(256);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(512);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(1024);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(2048);
+DEFINE_ARRAY_WITH_PERCPU_KPTR(4096);
+
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int test_batch_alloc_free(void *ctx)
 {
 	if ((u32)bpf_get_current_pid_tgid() != pid)
 		return 0;
@@ -121,3 +216,76 @@ int test_bpf_mem_alloc_free(void *ctx)
 
 	return 0;
 }
+
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int test_free_through_map_free(void *ctx)
+{
+	if ((u32)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	/* Alloc 128 8-bytes objects in batch to trigger refilling,
+	 * then free these objects through map free.
+	 */
+	CALL_BATCH_ALLOC(8, 128, 0);
+	CALL_BATCH_ALLOC(16, 128, 1);
+	CALL_BATCH_ALLOC(32, 128, 2);
+	CALL_BATCH_ALLOC(64, 128, 3);
+	CALL_BATCH_ALLOC(96, 128, 4);
+	CALL_BATCH_ALLOC(128, 128, 5);
+	CALL_BATCH_ALLOC(192, 128, 6);
+	CALL_BATCH_ALLOC(256, 128, 7);
+	CALL_BATCH_ALLOC(512, 64, 8);
+	CALL_BATCH_ALLOC(1024, 32, 9);
+	CALL_BATCH_ALLOC(2048, 16, 10);
+	CALL_BATCH_ALLOC(4096, 8, 11);
+
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int test_batch_percpu_alloc_free(void *ctx)
+{
+	if ((u32)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	/* Alloc 128 16-bytes per-cpu objects in batch to trigger refilling,
+	 * then free 128 16-bytes per-cpu objects in batch to trigger freeing.
+	 */
+	CALL_BATCH_PERCPU_ALLOC_FREE(16, 128, 1);
+	CALL_BATCH_PERCPU_ALLOC_FREE(32, 128, 2);
+	CALL_BATCH_PERCPU_ALLOC_FREE(64, 128, 3);
+	CALL_BATCH_PERCPU_ALLOC_FREE(96, 128, 4);
+	CALL_BATCH_PERCPU_ALLOC_FREE(128, 128, 5);
+	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
+	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
+	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
+	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
+	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
+	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
+
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
+int test_percpu_free_through_map_free(void *ctx)
+{
+	if ((u32)bpf_get_current_pid_tgid() != pid)
+		return 0;
+
+	/* Alloc 128 16-bytes per-cpu objects in batch to trigger refilling,
+	 * then free these object through map free.
+	 */
+	CALL_BATCH_PERCPU_ALLOC(16, 128, 1);
+	CALL_BATCH_PERCPU_ALLOC(32, 128, 2);
+	CALL_BATCH_PERCPU_ALLOC(64, 128, 3);
+	CALL_BATCH_PERCPU_ALLOC(96, 128, 4);
+	CALL_BATCH_PERCPU_ALLOC(128, 128, 5);
+	CALL_BATCH_PERCPU_ALLOC(192, 128, 6);
+	CALL_BATCH_PERCPU_ALLOC(256, 128, 7);
+	CALL_BATCH_PERCPU_ALLOC(512, 64, 8);
+	CALL_BATCH_PERCPU_ALLOC(1024, 32, 9);
+	CALL_BATCH_PERCPU_ALLOC(2048, 16, 10);
+	CALL_BATCH_PERCPU_ALLOC(4096, 8, 11);
+
+	return 0;
+}
-- 
2.29.2


