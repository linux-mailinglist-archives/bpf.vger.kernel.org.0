Return-Path: <bpf+bounces-18092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3208815934
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 14:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FCE285DDE
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E07524A03;
	Sat, 16 Dec 2023 13:10:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9F25553
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ssmdp3Tghz4f3jXs
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 21:09:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 212F61A01CA
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 21:09:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHlQuboX1lBaU8Dw--.10750S6;
	Sat, 16 Dec 2023 21:09:52 +0800 (CST)
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
	kernel test robot <oliver.sang@intel.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Remove tests for zeroed-array kptr
Date: Sat, 16 Dec 2023 21:10:52 +0800
Message-Id: <20231216131052.27621-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231216131052.27621-1-houtao@huaweicloud.com>
References: <20231216131052.27621-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHlQuboX1lBaU8Dw--.10750S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtrWkXFWUGF1UWw13JrW5ZFb_yoWxWryDpw
	1FyrnakrnFgw1Iv3WYkw1I93sxZr4fKry5GrZ3WFyDWw15J3yUAF9xCrn3JF95GFWxWr1U
	Jwsaga4DKFs3Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_mem_alloc() doesn't support zero-sized allocation, so removing these
tests from test_bpf_ma test. After the removal, there will no definition
for bin_data_8, so remove 8 from data_sizes array and adjust the index
of data_btf_ids array in all test cases accordingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 100 +++++++++---------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
index b685a4aba6bd..069db9085e78 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -17,7 +17,7 @@ struct generic_map_value {
 
 char _license[] SEC("license") = "GPL";
 
-const unsigned int data_sizes[] = {8, 16, 32, 64, 96, 128, 192, 256, 512, 1024, 2048, 4096};
+const unsigned int data_sizes[] = {16, 32, 64, 96, 128, 192, 256, 512, 1024, 2048, 4096};
 const volatile unsigned int data_btf_ids[ARRAY_SIZE(data_sizes)] = {};
 
 int err = 0;
@@ -166,7 +166,7 @@ static __always_inline void batch_percpu_free(struct bpf_map *map, unsigned int
 		batch_percpu_free((struct bpf_map *)(&array_percpu_##size), batch, idx); \
 	} while (0)
 
-DEFINE_ARRAY_WITH_KPTR(8);
+/* kptr doesn't support bin_data_8 which is a zero-sized array */
 DEFINE_ARRAY_WITH_KPTR(16);
 DEFINE_ARRAY_WITH_KPTR(32);
 DEFINE_ARRAY_WITH_KPTR(64);
@@ -198,21 +198,20 @@ int test_batch_alloc_free(void *ctx)
 	if ((u32)bpf_get_current_pid_tgid() != pid)
 		return 0;
 
-	/* Alloc 128 8-bytes objects in batch to trigger refilling,
-	 * then free 128 8-bytes objects in batch to trigger freeing.
+	/* Alloc 128 16-bytes objects in batch to trigger refilling,
+	 * then free 128 16-bytes objects in batch to trigger freeing.
 	 */
-	CALL_BATCH_ALLOC_FREE(8, 128, 0);
-	CALL_BATCH_ALLOC_FREE(16, 128, 1);
-	CALL_BATCH_ALLOC_FREE(32, 128, 2);
-	CALL_BATCH_ALLOC_FREE(64, 128, 3);
-	CALL_BATCH_ALLOC_FREE(96, 128, 4);
-	CALL_BATCH_ALLOC_FREE(128, 128, 5);
-	CALL_BATCH_ALLOC_FREE(192, 128, 6);
-	CALL_BATCH_ALLOC_FREE(256, 128, 7);
-	CALL_BATCH_ALLOC_FREE(512, 64, 8);
-	CALL_BATCH_ALLOC_FREE(1024, 32, 9);
-	CALL_BATCH_ALLOC_FREE(2048, 16, 10);
-	CALL_BATCH_ALLOC_FREE(4096, 8, 11);
+	CALL_BATCH_ALLOC_FREE(16, 128, 0);
+	CALL_BATCH_ALLOC_FREE(32, 128, 1);
+	CALL_BATCH_ALLOC_FREE(64, 128, 2);
+	CALL_BATCH_ALLOC_FREE(96, 128, 3);
+	CALL_BATCH_ALLOC_FREE(128, 128, 4);
+	CALL_BATCH_ALLOC_FREE(192, 128, 5);
+	CALL_BATCH_ALLOC_FREE(256, 128, 6);
+	CALL_BATCH_ALLOC_FREE(512, 64, 7);
+	CALL_BATCH_ALLOC_FREE(1024, 32, 8);
+	CALL_BATCH_ALLOC_FREE(2048, 16, 9);
+	CALL_BATCH_ALLOC_FREE(4096, 8, 10);
 
 	return 0;
 }
@@ -223,21 +222,20 @@ int test_free_through_map_free(void *ctx)
 	if ((u32)bpf_get_current_pid_tgid() != pid)
 		return 0;
 
-	/* Alloc 128 8-bytes objects in batch to trigger refilling,
+	/* Alloc 128 16-bytes objects in batch to trigger refilling,
 	 * then free these objects through map free.
 	 */
-	CALL_BATCH_ALLOC(8, 128, 0);
-	CALL_BATCH_ALLOC(16, 128, 1);
-	CALL_BATCH_ALLOC(32, 128, 2);
-	CALL_BATCH_ALLOC(64, 128, 3);
-	CALL_BATCH_ALLOC(96, 128, 4);
-	CALL_BATCH_ALLOC(128, 128, 5);
-	CALL_BATCH_ALLOC(192, 128, 6);
-	CALL_BATCH_ALLOC(256, 128, 7);
-	CALL_BATCH_ALLOC(512, 64, 8);
-	CALL_BATCH_ALLOC(1024, 32, 9);
-	CALL_BATCH_ALLOC(2048, 16, 10);
-	CALL_BATCH_ALLOC(4096, 8, 11);
+	CALL_BATCH_ALLOC(16, 128, 0);
+	CALL_BATCH_ALLOC(32, 128, 1);
+	CALL_BATCH_ALLOC(64, 128, 2);
+	CALL_BATCH_ALLOC(96, 128, 3);
+	CALL_BATCH_ALLOC(128, 128, 4);
+	CALL_BATCH_ALLOC(192, 128, 5);
+	CALL_BATCH_ALLOC(256, 128, 6);
+	CALL_BATCH_ALLOC(512, 64, 7);
+	CALL_BATCH_ALLOC(1024, 32, 8);
+	CALL_BATCH_ALLOC(2048, 16, 9);
+	CALL_BATCH_ALLOC(4096, 8, 10);
 
 	return 0;
 }
@@ -251,17 +249,17 @@ int test_batch_percpu_alloc_free(void *ctx)
 	/* Alloc 128 16-bytes per-cpu objects in batch to trigger refilling,
 	 * then free 128 16-bytes per-cpu objects in batch to trigger freeing.
 	 */
-	CALL_BATCH_PERCPU_ALLOC_FREE(16, 128, 1);
-	CALL_BATCH_PERCPU_ALLOC_FREE(32, 128, 2);
-	CALL_BATCH_PERCPU_ALLOC_FREE(64, 128, 3);
-	CALL_BATCH_PERCPU_ALLOC_FREE(96, 128, 4);
-	CALL_BATCH_PERCPU_ALLOC_FREE(128, 128, 5);
-	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
-	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
-	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
-	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
-	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
-	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
+	CALL_BATCH_PERCPU_ALLOC_FREE(16, 128, 0);
+	CALL_BATCH_PERCPU_ALLOC_FREE(32, 128, 1);
+	CALL_BATCH_PERCPU_ALLOC_FREE(64, 128, 2);
+	CALL_BATCH_PERCPU_ALLOC_FREE(96, 128, 3);
+	CALL_BATCH_PERCPU_ALLOC_FREE(128, 128, 4);
+	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 5);
+	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 6);
+	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 7);
+	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 8);
+	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 9);
+	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 10);
 
 	return 0;
 }
@@ -275,17 +273,17 @@ int test_percpu_free_through_map_free(void *ctx)
 	/* Alloc 128 16-bytes per-cpu objects in batch to trigger refilling,
 	 * then free these object through map free.
 	 */
-	CALL_BATCH_PERCPU_ALLOC(16, 128, 1);
-	CALL_BATCH_PERCPU_ALLOC(32, 128, 2);
-	CALL_BATCH_PERCPU_ALLOC(64, 128, 3);
-	CALL_BATCH_PERCPU_ALLOC(96, 128, 4);
-	CALL_BATCH_PERCPU_ALLOC(128, 128, 5);
-	CALL_BATCH_PERCPU_ALLOC(192, 128, 6);
-	CALL_BATCH_PERCPU_ALLOC(256, 128, 7);
-	CALL_BATCH_PERCPU_ALLOC(512, 64, 8);
-	CALL_BATCH_PERCPU_ALLOC(1024, 32, 9);
-	CALL_BATCH_PERCPU_ALLOC(2048, 16, 10);
-	CALL_BATCH_PERCPU_ALLOC(4096, 8, 11);
+	CALL_BATCH_PERCPU_ALLOC(16, 128, 0);
+	CALL_BATCH_PERCPU_ALLOC(32, 128, 1);
+	CALL_BATCH_PERCPU_ALLOC(64, 128, 2);
+	CALL_BATCH_PERCPU_ALLOC(96, 128, 3);
+	CALL_BATCH_PERCPU_ALLOC(128, 128, 4);
+	CALL_BATCH_PERCPU_ALLOC(192, 128, 5);
+	CALL_BATCH_PERCPU_ALLOC(256, 128, 6);
+	CALL_BATCH_PERCPU_ALLOC(512, 64, 7);
+	CALL_BATCH_PERCPU_ALLOC(1024, 32, 8);
+	CALL_BATCH_PERCPU_ALLOC(2048, 16, 9);
+	CALL_BATCH_PERCPU_ALLOC(4096, 8, 10);
 
 	return 0;
 }
-- 
2.29.2


