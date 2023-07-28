Return-Path: <bpf+bounces-6145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2C0766188
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6978D2825BF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09DB1FC6;
	Fri, 28 Jul 2023 01:58:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21717D0;
	Fri, 28 Jul 2023 01:58:31 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D3273D;
	Thu, 27 Jul 2023 18:58:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RBrQ82rscz4f3nqZ;
	Fri, 28 Jul 2023 09:58:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCX_7K_IMNkBXLmOw--.17170S6;
	Fri, 28 Jul 2023 09:58:26 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	houtao1@huawei.com
Subject: [RFC PATCH bpf-next 2/2] bpf, cpumap: Clean up bpf_cpu_map_entry directly in cpu_map_free
Date: Fri, 28 Jul 2023 10:30:30 +0800
Message-Id: <20230728023030.1906124-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230728023030.1906124-1-houtao@huaweicloud.com>
References: <20230728023030.1906124-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX_7K_IMNkBXLmOw--.17170S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWDZry7GryxWF4DWF1Dtrb_yoW8Zw48pF
	y3GryUGw48XrsFk3yrXw48A342qws2ga4UJ34Fk34rA3ZrJr97JFWrKFZ7Cry3ursagr45
	uF12gFWqkay7ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC9aPUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

After synchronize_rcu(), both the dettached XDP program and
xdp_do_flush() are completed, and the only user of bpf_cpu_map_entry
will be cpu_map_kthread_run(), so instead of calling
__cpu_map_entry_replace() to empty queue and do cleanup after a RCU
grace period, do these things directly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/cpumap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 24f39c37526f..f8e2b24320c0 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -554,16 +554,15 @@ static void cpu_map_free(struct bpf_map *map)
 	/* At this point bpf_prog->aux->refcnt == 0 and this map->refcnt == 0,
 	 * so the bpf programs (can be more than one that used this map) were
 	 * disconnected from events. Wait for outstanding critical sections in
-	 * these programs to complete. The rcu critical section only guarantees
-	 * no further "XDP/bpf-side" reads against bpf_cpu_map->cpu_map.
-	 * It does __not__ ensure pending flush operations (if any) are
-	 * complete.
+	 * these programs to complete. synchronize_rcu() below not only
+	 * guarantees no further "XDP/bpf-side" reads against
+	 * bpf_cpu_map->cpu_map, but also ensure pending flush operations
+	 * (if any) are complete.
 	 */
-
 	synchronize_rcu();
 
-	/* For cpu_map the remote CPUs can still be using the entries
-	 * (struct bpf_cpu_map_entry).
+	/* The only possible user of bpf_cpu_map_entry is
+	 * cpu_map_kthread_run().
 	 */
 	for (i = 0; i < cmap->map.max_entries; i++) {
 		struct bpf_cpu_map_entry *rcpu;
@@ -572,8 +571,8 @@ static void cpu_map_free(struct bpf_map *map)
 		if (!rcpu)
 			continue;
 
-		/* bq flush and cleanup happens after RCU grace-period */
-		__cpu_map_entry_replace(cmap, i, NULL); /* call_rcu */
+		/* Empty queue and do cleanup directly */
+		__cpu_map_entry_free(&rcpu->free_work.work);
 	}
 	bpf_map_area_free(cmap->cpu_map);
 	bpf_map_area_free(cmap);
-- 
2.29.2


