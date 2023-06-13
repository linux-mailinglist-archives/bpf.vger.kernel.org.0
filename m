Return-Path: <bpf+bounces-2483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4872DB16
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA2F2811AB
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6E53B3;
	Tue, 13 Jun 2023 07:37:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F43D90
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 07:37:14 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD967AA;
	Tue, 13 Jun 2023 00:37:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QgL3j1yWpz4f3mmx;
	Tue, 13 Jun 2023 15:37:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3X7OdHIhkfcdhLg--.52188S6;
	Tue, 13 Jun 2023 15:37:07 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: [PATCH bpf-next v6 2/5] selftests/bpf: Output the correct error code for pthread APIs
Date: Tue, 13 Jun 2023 16:09:18 +0800
Message-Id: <20230613080921.1623219-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230613080921.1623219-1-houtao@huaweicloud.com>
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3X7OdHIhkfcdhLg--.52188S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45Gw1Duw48uF4ruFWkXrb_yoW8Xry3pw
	4rGa4UtFWrAF4jyw1UJa10yFyakwn7Xay3Xr4fJF4fZa47WFW5uryxKFyFqFs8CrW0q3Z8
	ArnI9w45ZFs7JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The return value of pthread API is the error code when the called
API fails, so output the return value instead of errno.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bench.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index d9c080ac1796..0b5d2b5303c9 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -441,12 +441,14 @@ static void setup_timer()
 static void set_thread_affinity(pthread_t thread, int cpu)
 {
 	cpu_set_t cpuset;
+	int err;
 
 	CPU_ZERO(&cpuset);
 	CPU_SET(cpu, &cpuset);
-	if (pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset)) {
+	err = pthread_setaffinity_np(thread, sizeof(cpuset), &cpuset);
+	if (err) {
 		fprintf(stderr, "setting affinity to CPU #%d failed: %d\n",
-			cpu, errno);
+			cpu, -err);
 		exit(1);
 	}
 }
@@ -605,7 +607,7 @@ static void setup_benchmark(void)
 				     bench->consumer_thread, (void *)(long)i);
 		if (err) {
 			fprintf(stderr, "failed to create consumer thread #%d: %d\n",
-				i, -errno);
+				i, -err);
 			exit(1);
 		}
 		if (env.affinity)
@@ -624,7 +626,7 @@ static void setup_benchmark(void)
 				     bench->producer_thread, (void *)(long)i);
 		if (err) {
 			fprintf(stderr, "failed to create producer thread #%d: %d\n",
-				i, -errno);
+				i, -err);
 			exit(1);
 		}
 		if (env.affinity)
-- 
2.29.2


