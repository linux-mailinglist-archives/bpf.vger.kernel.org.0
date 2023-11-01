Return-Path: <bpf+bounces-13780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F87DDB77
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 04:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E6D1C20D98
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6732315A8;
	Wed,  1 Nov 2023 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B01390
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 03:23:50 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CCC2
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:23:49 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SKsmH1F2gz4f3nZy
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AAC6A1A0170
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHHt6+xEFlSpMJEg--.58519S7;
	Wed, 01 Nov 2023 11:23:46 +0800 (CST)
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
Subject: [PATCH bpf-next 3/3] selftsets/bpf: Retry map update for non-preallocated per-cpu map
Date: Wed,  1 Nov 2023 11:24:55 +0800
Message-Id: <20231101032455.3808547-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHHt6+xEFlSpMJEg--.58519S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4kGr45CrykGF1DuryDWrg_yoW5Jw43pa
	yfG3WYkrs2qrW3Kw15JayDW34Yvr4kW345Jrn5trWYy3WxWr17tr1xGFyYvF9xuF90qw1a
	y392yF1fuayxAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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

BPF CI failed due to map_percpu_stats_percpu_hash from time to time [1].
It seems that the failure reason is per-cpu bpf memory allocator may not
be able to allocate per-cpu pointer successfully and it can not refill
free llist timely, and bpf_map_update_elem() will return -ENOMEM.

So mitigate the problem by retrying the update operation for
non-preallocated per-cpu map.

[1]: https://github.com/kernel-patches/bpf/actions/runs/6713177520/job/18244865326?pr=5909

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/map_tests/map_percpu_stats.c          | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 8ad17d051ef8f..e152535e9e3ec 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -141,6 +141,7 @@ struct upsert_opts {
 	__u32 map_type;
 	int map_fd;
 	__u32 n;
+	bool retry_for_nomem;
 };
 
 static int create_small_hash(void)
@@ -154,6 +155,11 @@ static int create_small_hash(void)
 	return map_fd;
 }
 
+static bool retry_for_nomem_fn(int err)
+{
+	return err == ENOMEM;
+}
+
 static void *patch_map_thread(void *arg)
 {
 	/* 8KB is enough for 1024 CPUs. And it is shared between N_THREADS. */
@@ -175,7 +181,12 @@ static void *patch_map_thread(void *arg)
 			val_ptr = &val;
 		}
 
-		ret = bpf_map_update_elem(opts->map_fd, &i, val_ptr, 0);
+		/* 2 seconds may be enough ? */
+		if (opts->retry_for_nomem)
+			ret = map_update_retriable(opts->map_fd, &i, val_ptr, 0,
+						   40, retry_for_nomem_fn);
+		else
+			ret = bpf_map_update_elem(opts->map_fd, &i, val_ptr, 0);
 		CHECK(ret < 0, "bpf_map_update_elem", "key=%d error: %s\n", i, strerror(errno));
 
 		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
@@ -296,6 +307,13 @@ static void __test(int map_fd)
 	else
 		opts.n /= 2;
 
+	/* per-cpu bpf memory allocator may not be able to allocate per-cpu
+	 * pointer successfully and it can not refill free llist timely, and
+	 * bpf_map_update_elem() will return -ENOMEM. so just retry to mitigate
+	 * the problem temporarily.
+	 */
+	opts.retry_for_nomem = is_percpu(opts.map_type) && (info.map_flags & BPF_F_NO_PREALLOC);
+
 	/*
 	 * Upsert keys [0, n) under some competition: with random values from
 	 * N_THREADS threads. Check values, then delete all elements and check
-- 
2.29.2


