Return-Path: <bpf+bounces-13779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADB27DDB79
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 04:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F5AB20DE7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF97139E;
	Wed,  1 Nov 2023 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E21399
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 03:23:50 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48875EA
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:23:49 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SKsmC6qtYz4f3lwn
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 22BF91A0172
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHHt6+xEFlSpMJEg--.58519S6;
	Wed, 01 Nov 2023 11:23:45 +0800 (CST)
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
	Anton Protopopov <aspsk@isovalent.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 2/3] selftests/bpf: Export map_update_retriable()
Date: Wed,  1 Nov 2023 11:24:54 +0800
Message-Id: <20231101032455.3808547-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231101032455.3808547-1-houtao@huaweicloud.com>
References: <20231101032455.3808547-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHHt6+xEFlSpMJEg--.58519S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UKF45JF4DZF1DXr1kKrg_yoW5Wr17pa
	yrZa98KF4ftFy3Xr17tw42gayfCan7Xa1qyr1vqr9rZr1DJrn7Zr40gF1rArnrWrWFq3Z3
	A3yIgryFya1xXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Export map_update_retriable() to make it usable for other map_test
cases. These cases may only need retry for specific errno, so add
a new callback parameter to let map_update_retriable() decide whether or
not the errno is retriable.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/test_maps.c | 17 ++++++++++++-----
 tools/testing/selftests/bpf/test_maps.h |  5 +++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 7fc00e423e4dd..767e0693df106 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1396,13 +1396,18 @@ static void test_map_stress(void)
 #define MAX_DELAY_US 50000
 #define MIN_DELAY_RANGE_US 5000
 
-static int map_update_retriable(int map_fd, const void *key, const void *value,
-				int flags, int attempts)
+static bool retry_for_again_or_busy(int err)
+{
+	return (err == EAGAIN || err == EBUSY);
+}
+
+int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
+			 retry_for_error_fn need_retry)
 {
 	int delay = rand() % MIN_DELAY_RANGE_US;
 
 	while (bpf_map_update_elem(map_fd, key, value, flags)) {
-		if (!attempts || (errno != EAGAIN && errno != EBUSY))
+		if (!attempts || !need_retry(errno))
 			return -errno;
 
 		if (delay <= MAX_DELAY_US / 2)
@@ -1445,11 +1450,13 @@ static void test_update_delete(unsigned int fn, void *data)
 		key = value = i;
 
 		if (do_update) {
-			err = map_update_retriable(fd, &key, &value, BPF_NOEXIST, MAP_RETRIES);
+			err = map_update_retriable(fd, &key, &value, BPF_NOEXIST, MAP_RETRIES,
+						   retry_for_again_or_busy);
 			if (err)
 				printf("error %d %d\n", err, errno);
 			assert(err == 0);
-			err = map_update_retriable(fd, &key, &value, BPF_EXIST, MAP_RETRIES);
+			err = map_update_retriable(fd, &key, &value, BPF_EXIST, MAP_RETRIES,
+						   retry_for_again_or_busy);
 			if (err)
 				printf("error %d %d\n", err, errno);
 			assert(err == 0);
diff --git a/tools/testing/selftests/bpf/test_maps.h b/tools/testing/selftests/bpf/test_maps.h
index f6fbca761732f..e4ac704a536c1 100644
--- a/tools/testing/selftests/bpf/test_maps.h
+++ b/tools/testing/selftests/bpf/test_maps.h
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 
 #define CHECK(condition, tag, format...) ({				\
 	int __ret = !!(condition);					\
@@ -16,4 +17,8 @@
 
 extern int skips;
 
+typedef bool (*retry_for_error_fn)(int err);
+int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
+			 retry_for_error_fn need_retry);
+
 #endif
-- 
2.29.2


