Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1F61EC16
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 08:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKGHax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 02:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiKGHai (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 02:30:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADDED68
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 23:29:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5NCz4d4Wz4f3m0Y
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:29:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCXu9jws2hjwsx6AA--.50928S4;
        Mon, 07 Nov 2022 15:29:54 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, houtao1@huawei.com
Subject: [PATCH bpf-next] bpf: Pass map file to .map_update_batch directly
Date:   Mon,  7 Nov 2022 15:55:37 +0800
Message-Id: <20221107075537.1445644-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXu9jws2hjwsx6AA--.50928S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWUJF48AryUAFy5uF4xtFb_yoWxJrW3pF
        WrKFy7Gr48WFW7Xr4aqa1UWay3Zr40gw15KrWktayFywnFgr929Fy8ta97ur4Yvr1DJr48
        J3W2qFW8Z3yxArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Currently generic_map_update_batch() will get map file from
attr->batch.map_fd and pass it to bpf_map_update_value(). The problem is
map_fd may have been closed or reopened as a different file type and
generic_map_update_batch() doesn't check the validity of map_fd.

It doesn't incur any problem as for now, because only
BPF_MAP_TYPE_PERF_EVENT_ARRAY uses the passed map file and it doesn't
support batch update operation. But it is better to fix the potential
use of an invalid map file.

Checking the validity of map file returned from fdget() in
generic_map_update_batch() can not fix the problem, because the returned
map file may be different with map file got in bpf_map_do_batch() due to
the reopening of fd, so just passing the map file directly to
.map_update_batch() in bpf_map_do_batch().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  |  5 +++--
 kernel/bpf/syscall.c | 31 ++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..20cfe88ee6df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -85,7 +85,8 @@ struct bpf_map_ops {
 	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
 					   const union bpf_attr *attr,
 					   union bpf_attr __user *uattr);
-	int (*map_update_batch)(struct bpf_map *map, const union bpf_attr *attr,
+	int (*map_update_batch)(struct bpf_map *map, struct file *map_file,
+				const union bpf_attr *attr,
 				union bpf_attr __user *uattr);
 	int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
 				union bpf_attr __user *uattr);
@@ -1776,7 +1777,7 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
 int  generic_map_lookup_batch(struct bpf_map *map,
 			      const union bpf_attr *attr,
 			      union bpf_attr __user *uattr);
-int  generic_map_update_batch(struct bpf_map *map,
+int  generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 			      const union bpf_attr *attr,
 			      union bpf_attr __user *uattr);
 int  generic_map_delete_batch(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85532d301124..cb8a87277bf8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -175,8 +175,8 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
 		synchronize_rcu();
 }
 
-static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
-				void *value, __u64 flags)
+static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
+				void *key, void *value, __u64 flags)
 {
 	int err;
 
@@ -190,7 +190,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
 		   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
 		return sock_map_update_elem_sys(map, key, value, flags);
 	} else if (IS_FD_PROG_ARRAY(map)) {
-		return bpf_fd_array_map_update_elem(map, f.file, key, value,
+		return bpf_fd_array_map_update_elem(map, map_file, key, value,
 						    flags);
 	}
 
@@ -205,12 +205,12 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
 						       flags);
 	} else if (IS_FD_ARRAY(map)) {
 		rcu_read_lock();
-		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
+		err = bpf_fd_array_map_update_elem(map, map_file, key, value,
 						   flags);
 		rcu_read_unlock();
 	} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
 		rcu_read_lock();
-		err = bpf_fd_htab_map_update_elem(map, f.file, key, value,
+		err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
 						  flags);
 		rcu_read_unlock();
 	} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
@@ -1390,7 +1390,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_key;
 	}
 
-	err = bpf_map_update_value(map, f, key, value, attr->flags);
+	err = bpf_map_update_value(map, f.file, key, value, attr->flags);
 
 	kvfree(value);
 free_key:
@@ -1576,16 +1576,14 @@ int generic_map_delete_batch(struct bpf_map *map,
 	return err;
 }
 
-int generic_map_update_batch(struct bpf_map *map,
+int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 			     const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
 {
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	u32 value_size, cp, max_count;
-	int ufd = attr->batch.map_fd;
 	void *key, *value;
-	struct fd f;
 	int err = 0;
 
 	if (attr->batch.elem_flags & ~BPF_F_LOCK)
@@ -1612,7 +1610,6 @@ int generic_map_update_batch(struct bpf_map *map,
 		return -ENOMEM;
 	}
 
-	f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
 	for (cp = 0; cp < max_count; cp++) {
 		err = -EFAULT;
 		if (copy_from_user(key, keys + cp * map->key_size,
@@ -1620,7 +1617,7 @@ int generic_map_update_batch(struct bpf_map *map,
 		    copy_from_user(value, values + cp * value_size, value_size))
 			break;
 
-		err = bpf_map_update_value(map, f, key, value,
+		err = bpf_map_update_value(map, map_file, key, value,
 					   attr->batch.elem_flags);
 
 		if (err)
@@ -1633,7 +1630,6 @@ int generic_map_update_batch(struct bpf_map *map,
 
 	kvfree(value);
 	kvfree(key);
-	fdput(f);
 	return err;
 }
 
@@ -4435,6 +4431,15 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 		err = fn(map, attr, uattr);	\
 	} while (0)
 
+#define BPF_DO_BATCH_WITH_FILE(fn)			\
+	do {						\
+		if (!fn) {				\
+			err = -ENOTSUPP;		\
+			goto err_put;			\
+		}					\
+		err = fn(map, f.file, attr, uattr);	\
+	} while (0)
+
 static int bpf_map_do_batch(const union bpf_attr *attr,
 			    union bpf_attr __user *uattr,
 			    int cmd)
@@ -4470,7 +4475,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	else if (cmd == BPF_MAP_LOOKUP_AND_DELETE_BATCH)
 		BPF_DO_BATCH(map->ops->map_lookup_and_delete_batch);
 	else if (cmd == BPF_MAP_UPDATE_BATCH)
-		BPF_DO_BATCH(map->ops->map_update_batch);
+		BPF_DO_BATCH_WITH_FILE(map->ops->map_update_batch);
 	else
 		BPF_DO_BATCH(map->ops->map_delete_batch);
 err_put:
-- 
2.29.2

