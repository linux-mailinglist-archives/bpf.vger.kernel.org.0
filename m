Return-Path: <bpf+bounces-16582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFA8035D3
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C34B20ACD
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549EA28694;
	Mon,  4 Dec 2023 14:03:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592DCF3
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 06:03:26 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SkQP52Jdmz4f3kFv
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:03:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7A0901A0C18
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:03:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHShAl3G1l+wflCg--.13401S7;
	Mon, 04 Dec 2023 22:03:23 +0800 (CST)
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
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf v5 3/7] bpf: Set need_defer as false when clearing fd array during map free
Date: Mon,  4 Dec 2023 22:04:21 +0800
Message-Id: <20231204140425.1480317-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231204140425.1480317-1-houtao@huaweicloud.com>
References: <20231204140425.1480317-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHShAl3G1l+wflCg--.13401S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAw13trWDJFW7Cr4Dtw47Jwb_yoWrWFW5pF
	yktr4Uurs5Jr43Ww4rXa95W3s0yrn5Xw4DJF9Yy34YyFyfWr93ZF4xGa48Krn09a48ZrnF
	9F42y397Gay0krDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Both map deletion operation, map release and map free operation use
fd_array_map_delete_elem() to remove the element from fd array and
need_defer is always true in fd_array_map_delete_elem(). For the map
deletion operation and map release operation, need_defer=true is
necessary, because the bpf program, which accesses the element in fd
array, may still alive. However for map free operation, it is certain
that the bpf program which owns the fd array has already been exited, so
setting need_defer as false is appropriate for map free operation.

So fix it by adding need_defer parameter to bpf_fd_array_map_clear() and
adding a new helper __fd_array_map_delete_elem() to handle the map
deletion, map release and map free operations correspondingly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/arraymap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f9aed5909d6e..4a4a67956e21 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -871,7 +871,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	return 0;
 }
 
-static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
+static long __fd_array_map_delete_elem(struct bpf_map *map, void *key, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	void *old_ptr;
@@ -890,13 +890,18 @@ static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
 	}
 
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(map, old_ptr, true);
+		map->ops->map_fd_put_ptr(map, old_ptr, need_defer);
 		return 0;
 	} else {
 		return -ENOENT;
 	}
 }
 
+static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return __fd_array_map_delete_elem(map, key, true);
+}
+
 static void *prog_fd_array_get_ptr(struct bpf_map *map,
 				   struct file *map_file, int fd)
 {
@@ -925,13 +930,13 @@ static u32 prog_fd_array_sys_lookup_elem(void *ptr)
 }
 
 /* decrement refcnt of all bpf_progs that are stored in this map */
-static void bpf_fd_array_map_clear(struct bpf_map *map)
+static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		fd_array_map_delete_elem(map, &i);
+		__fd_array_map_delete_elem(map, &i, need_defer);
 }
 
 static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
@@ -1110,7 +1115,7 @@ static void prog_array_map_clear_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_array_aux,
 					   work)->map;
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, true);
 	bpf_map_put(map);
 }
 
@@ -1260,7 +1265,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 	for (i = 0; i < array->map.max_entries; i++) {
 		ee = READ_ONCE(array->ptrs[i]);
 		if (ee && ee->map_file == map_file)
-			fd_array_map_delete_elem(map, &i);
+			__fd_array_map_delete_elem(map, &i, true);
 	}
 	rcu_read_unlock();
 }
@@ -1268,7 +1273,7 @@ static void perf_event_fd_array_release(struct bpf_map *map,
 static void perf_event_fd_array_map_free(struct bpf_map *map)
 {
 	if (map->map_flags & BPF_F_PRESERVE_ELEMS)
-		bpf_fd_array_map_clear(map);
+		bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1304,7 +1309,7 @@ static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_de
 
 static void cgroup_fd_array_free(struct bpf_map *map)
 {
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
@@ -1349,7 +1354,7 @@ static void array_of_map_free(struct bpf_map *map)
 	 * is protected by fdget/fdput.
 	 */
 	bpf_map_meta_free(map->inner_map_meta);
-	bpf_fd_array_map_clear(map);
+	bpf_fd_array_map_clear(map, false);
 	fd_array_map_free(map);
 }
 
-- 
2.29.2


