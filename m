Return-Path: <bpf+bounces-17374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2380C208
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6097280DA7
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD29208A6;
	Mon, 11 Dec 2023 07:37:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E17DB
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 23:37:44 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpYVm6n8Hz4f3l1r
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 15:37:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D24D71A09BE
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 15:37:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xFBvHZlF2ZYDQ--.7860S5;
	Mon, 11 Dec 2023 15:37:41 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 1/2] bpf: Reduce the scope of rcu_read_lock when updating fd map
Date: Mon, 11 Dec 2023 15:38:42 +0800
Message-Id: <20231211073843.1888058-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231211073843.1888058-1-houtao@huaweicloud.com>
References: <20231211073843.1888058-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xFBvHZlF2ZYDQ--.7860S5
X-Coremail-Antispam: 1UD129KBjvJXoW7CryUJrW5tFWrtryUtw4ktFb_yoW8KFykpa
	95KFyxKw40qr17u343X3Wv9rWUJw15X3srZFZ5t34Fyry2qrn2gr1UKas3XFyakF1DAFW8
	X3Wa93yFkayUXrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
callbacks and only uses rcu-read-lock for the underlying update
operations in bpf_fd_{array,htab}_map_update_elem().

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/arraymap.c | 2 ++
 kernel/bpf/hashtab.c  | 2 ++
 kernel/bpf/syscall.c  | 4 ----
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 8d365bda9a8b..6cf47bcb7b83 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -863,7 +863,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 		map->ops->map_poke_run(map, index, old_ptr, new_ptr);
 		mutex_unlock(&array->aux->poke_mutex);
 	} else {
+		rcu_read_lock();
 		old_ptr = xchg(array->ptrs + index, new_ptr);
+		rcu_read_unlock();
 	}
 
 	if (old_ptr)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5b9146fa825f..4c28fd51ac01 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2523,7 +2523,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
 
+	rcu_read_lock();
 	ret = htab_map_update_elem(map, key, &ptr, map_flags);
+	rcu_read_unlock();
 	if (ret)
 		map->ops->map_fd_put_ptr(map, ptr, false);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a76467fda558..019d18d33d63 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -183,15 +183,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		err = bpf_percpu_cgroup_storage_update(map, key, value,
 						       flags);
 	} else if (IS_FD_ARRAY(map)) {
-		rcu_read_lock();
 		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
 						   flags);
-		rcu_read_unlock();
 	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-		rcu_read_lock();
 		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
 						  flags);
-		rcu_read_unlock();
 	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
 		/* rcu_read_lock() is not needed */
 		err = bpf_fd_reuseport_array_update_elem(map, key, value,
-- 
2.29.2


