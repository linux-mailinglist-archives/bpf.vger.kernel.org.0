Return-Path: <bpf+bounces-13778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8B7DDB76
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 04:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DBEB21121
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0571106;
	Wed,  1 Nov 2023 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE061374
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 03:23:49 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D3B4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:23:48 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SKsmG0NMRz4f3nVD
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AA871A016D
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHHt6+xEFlSpMJEg--.58519S5;
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
Subject: [PATCH bpf-next 1/3] selftests/bpf: Use value with enough-size when updating per-cpu map
Date: Wed,  1 Nov 2023 11:24:53 +0800
Message-Id: <20231101032455.3808547-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHHt6+xEFlSpMJEg--.58519S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4DJFy3KF1fur1DXry3CFg_yoW8ZrWrpa
	4xGFsI9Fn2qFyaq3yaqas0qry5trs7J348A34DAF4YyF1xWw1Sqr1Iya4UtF13uFyjg3Za
	y393tr1S9ayxArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When updating per-cpu map in map_percpu_stats test, patch_map_thread()
only passes 4-bytes-sized value to bpf_map_update_elem(). The expected
size of the value is 8 * num_possible_cpus(), so fix it by passing a
value with enough-size for per-cpu map update.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/map_tests/map_percpu_stats.c          | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 1a9eeefda9a87..8ad17d051ef8f 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -131,6 +131,12 @@ static bool is_lru(__u32 map_type)
 	       map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
 }
 
+static bool is_percpu(__u32 map_type)
+{
+	return map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+}
+
 struct upsert_opts {
 	__u32 map_type;
 	int map_fd;
@@ -150,17 +156,26 @@ static int create_small_hash(void)
 
 static void *patch_map_thread(void *arg)
 {
+	/* 8KB is enough for 1024 CPUs. And it is shared between N_THREADS. */
+	static __u8 blob[8 << 10];
 	struct upsert_opts *opts = arg;
+	void *val_ptr;
 	int val;
 	int ret;
 	int i;
 
 	for (i = 0; i < opts->n; i++) {
-		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
+		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
 			val = create_small_hash();
-		else
+			val_ptr = &val;
+		} else if (is_percpu(opts->map_type)) {
+			val_ptr = blob;
+		} else {
 			val = rand();
-		ret = bpf_map_update_elem(opts->map_fd, &i, &val, 0);
+			val_ptr = &val;
+		}
+
+		ret = bpf_map_update_elem(opts->map_fd, &i, val_ptr, 0);
 		CHECK(ret < 0, "bpf_map_update_elem", "key=%d error: %s\n", i, strerror(errno));
 
 		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
-- 
2.29.2


