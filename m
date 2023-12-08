Return-Path: <bpf+bounces-17132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49A80A08E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4431C20B19
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E2E15EA3;
	Fri,  8 Dec 2023 10:23:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78971706
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:22:56 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SmnJr02JFz4f3kpV
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 525D31A0ECE
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:22:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxF57nJlY85LDA--.46390S10;
	Fri, 08 Dec 2023 18:22:54 +0800 (CST)
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
Subject: [PATCH bpf-next 6/7] bpf: Only call maybe_wait_bpf_programs() when at least one map operation succeeds
Date: Fri,  8 Dec 2023 18:23:54 +0800
Message-Id: <20231208102355.2628918-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231208102355.2628918-1-houtao@huaweicloud.com>
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxF57nJlY85LDA--.46390S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWDtFWUZw1kur1fCFyDZFb_yoWDXr4kpF
	W8KFy7Ar1kurZrX3yava1rXa47Zr10qw15t3y8Ga4Fkr4kWr17CFW0gFW2vF1Yvr15Awsa
	qF12qa4rX3yxCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

There is no need to call maybe_wait_bpf_programs() if all operations in
batched update, deletion, or lookup_and_deletion fail. So only call
maybe_wait_bpf_programs() if at least one map operation succeeds.

Similar with uattr->batch.count which is used to return the number of
succeeded map operations to userspace application, use attr->batch.count
to record the number of succeeded map operations in kernel. Sometimes
these two number may be different. For example, in
__htab_map_lookup_and_delete_batch(do_delete=true), it is possible that
10 items in current bucket have been successfully deleted, but copying
the deleted keys to userspace application fails, attr->batch.count will
be 10 but uattr->batch.count will be 0 instead.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h  | 14 +++++++-------
 kernel/bpf/hashtab.c | 20 +++++++++++---------
 kernel/bpf/syscall.c | 21 ++++++++++++++-------
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f7aa255c634f..a0c4d696a231 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -81,17 +81,17 @@ struct bpf_map_ops {
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
-	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
+	int (*map_lookup_batch)(struct bpf_map *map, union bpf_attr *attr,
 				union bpf_attr __user *uattr);
 	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
 					  void *value, u64 flags);
 	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
-					   const union bpf_attr *attr,
+					   union bpf_attr *attr,
 					   union bpf_attr __user *uattr);
 	int (*map_update_batch)(struct bpf_map *map, struct file *map_file,
-				const union bpf_attr *attr,
+				union bpf_attr *attr,
 				union bpf_attr __user *uattr);
-	int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
+	int (*map_delete_batch)(struct bpf_map *map, union bpf_attr *attr,
 				union bpf_attr __user *uattr);
 
 	/* funcs callable from userspace and from eBPF programs */
@@ -2095,13 +2095,13 @@ void bpf_map_area_free(void *base);
 bool bpf_map_write_active(const struct bpf_map *map);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
 int  generic_map_lookup_batch(struct bpf_map *map,
-			      const union bpf_attr *attr,
+			      union bpf_attr *attr,
 			      union bpf_attr __user *uattr);
 int  generic_map_update_batch(struct bpf_map *map, struct file *map_file,
-			      const union bpf_attr *attr,
+			      union bpf_attr *attr,
 			      union bpf_attr __user *uattr);
 int  generic_map_delete_batch(struct bpf_map *map,
-			      const union bpf_attr *attr,
+			      union bpf_attr *attr,
 			      union bpf_attr __user *uattr);
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5b9146fa825f..b777bd8d4f8d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1673,7 +1673,7 @@ static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
 
 static int
 __htab_map_lookup_and_delete_batch(struct bpf_map *map,
-				   const union bpf_attr *attr,
+				   union bpf_attr *attr,
 				   union bpf_attr __user *uattr,
 				   bool do_delete, bool is_lru_map,
 				   bool is_percpu)
@@ -1708,6 +1708,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	attr->batch.count = 0;
 	if (put_user(0, &uattr->batch.count))
 		return -EFAULT;
 
@@ -1845,6 +1846,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		}
 		dst_key += key_size;
 		dst_val += value_size;
+		attr->batch.count++;
 	}
 
 	htab_unlock_bucket(htab, b, batch, flags);
@@ -1900,7 +1902,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 }
 
 static int
-htab_percpu_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
+htab_percpu_map_lookup_batch(struct bpf_map *map, union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, false,
@@ -1909,7 +1911,7 @@ htab_percpu_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
 
 static int
 htab_percpu_map_lookup_and_delete_batch(struct bpf_map *map,
-					const union bpf_attr *attr,
+					union bpf_attr *attr,
 					union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, true,
@@ -1917,7 +1919,7 @@ htab_percpu_map_lookup_and_delete_batch(struct bpf_map *map,
 }
 
 static int
-htab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
+htab_map_lookup_batch(struct bpf_map *map, union bpf_attr *attr,
 		      union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, false,
@@ -1926,7 +1928,7 @@ htab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
 
 static int
 htab_map_lookup_and_delete_batch(struct bpf_map *map,
-				 const union bpf_attr *attr,
+				 union bpf_attr *attr,
 				 union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, true,
@@ -1935,7 +1937,7 @@ htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 static int
 htab_lru_percpu_map_lookup_batch(struct bpf_map *map,
-				 const union bpf_attr *attr,
+				 union bpf_attr *attr,
 				 union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, false,
@@ -1944,7 +1946,7 @@ htab_lru_percpu_map_lookup_batch(struct bpf_map *map,
 
 static int
 htab_lru_percpu_map_lookup_and_delete_batch(struct bpf_map *map,
-					    const union bpf_attr *attr,
+					    union bpf_attr *attr,
 					    union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, true,
@@ -1952,7 +1954,7 @@ htab_lru_percpu_map_lookup_and_delete_batch(struct bpf_map *map,
 }
 
 static int
-htab_lru_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
+htab_lru_map_lookup_batch(struct bpf_map *map, union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, false,
@@ -1961,7 +1963,7 @@ htab_lru_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
 
 static int
 htab_lru_map_lookup_and_delete_batch(struct bpf_map *map,
-				     const union bpf_attr *attr,
+				     union bpf_attr *attr,
 				     union bpf_attr __user *uattr)
 {
 	return __htab_map_lookup_and_delete_batch(map, attr, uattr, true,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index efda2353a7d5..d2641e51a1a7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1695,7 +1695,7 @@ static int map_get_next_key(union bpf_attr *attr)
 }
 
 int generic_map_delete_batch(struct bpf_map *map,
-			     const union bpf_attr *attr,
+			     union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
 {
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
@@ -1715,6 +1715,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	attr->batch.count = 0;
 	if (put_user(0, &uattr->batch.count))
 		return -EFAULT;
 
@@ -1742,6 +1743,8 @@ int generic_map_delete_batch(struct bpf_map *map,
 			break;
 		cond_resched();
 	}
+
+	attr->batch.count = cp;
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
 
@@ -1751,7 +1754,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 }
 
 int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
-			     const union bpf_attr *attr,
+			     union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
 {
 	void __user *values = u64_to_user_ptr(attr->batch.values);
@@ -1774,6 +1777,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	if (!max_count)
 		return 0;
 
+	attr->batch.count = 0;
 	if (put_user(0, &uattr->batch.count))
 		return -EFAULT;
 
@@ -1802,6 +1806,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 		cond_resched();
 	}
 
+	attr->batch.count = cp;
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
 
@@ -1813,9 +1818,8 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 
 #define MAP_LOOKUP_RETRIES 3
 
-int generic_map_lookup_batch(struct bpf_map *map,
-				    const union bpf_attr *attr,
-				    union bpf_attr __user *uattr)
+int generic_map_lookup_batch(struct bpf_map *map, union bpf_attr *attr,
+			     union bpf_attr __user *uattr)
 {
 	void __user *uobatch = u64_to_user_ptr(attr->batch.out_batch);
 	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
@@ -1838,6 +1842,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	attr->batch.count = 0;
 	if (put_user(0, &uattr->batch.count))
 		return -EFAULT;
 
@@ -1903,6 +1908,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (err == -EFAULT)
 		goto free_buf;
 
+	attr->batch.count = cp;
 	if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
 		    (cp && copy_to_user(uobatch, prev_key, map->key_size))))
 		err = -EFAULT;
@@ -4926,7 +4932,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 		err = fn(__VA_ARGS__);		\
 	} while (0)
 
-static int bpf_map_do_batch(const union bpf_attr *attr,
+static int bpf_map_do_batch(union bpf_attr *attr,
 			    union bpf_attr __user *uattr,
 			    int cmd)
 {
@@ -4966,7 +4972,8 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 		BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
 err_put:
 	if (has_write) {
-		maybe_wait_bpf_programs(map);
+		if (attr->batch.count)
+			maybe_wait_bpf_programs(map);
 		bpf_map_write_active_dec(map);
 	}
 	fdput(f);
-- 
2.29.2


