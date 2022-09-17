Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9845BB901
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIQPNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIQPN2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:13:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DF30F6B
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:13:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MVDt80LxQzKNpq
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 23:11:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMO5CVjskryAw--.61987S7;
        Sat, 17 Sep 2022 23:13:23 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next 03/10] bpf: Support bpf_dynptr-typed map key for bpf syscall
Date:   Sat, 17 Sep 2022 23:31:18 +0800
Message-Id: <20220917153125.2001645-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220917153125.2001645-1-houtao@huaweicloud.com>
References: <20220917153125.2001645-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMO5CVjskryAw--.61987S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWDJry3AryfWFy8Cr45KFg_yoWfuFyrpF
        4kCrWfZrWFqFy7JrWDJa10vw40qws2gw17GrZ3K34rCFsrXr9xZr18tFWvgr90vFyDGr4S
        qrWkKayrZ348ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Userspace application uses bpf syscall to lookup or update bpf map. It
passes a pointer of fixed-size buffer to kernel to represent the map
key. To support map with variable-length key, introduce bpf_dynptr_user
to allow userspace to pass a pointer of bpf_dynptr_user to specify the
address and the length of key buffer. And in order to represent dynptr
from userspace, adding a new dynptr type: BPF_DYNPTR_TYPE_USER. Because
BPF_DYNPTR_TYPE_USER-typed dynptr is not available for bpf program, so
verifier doesn't need update.

To distinguish map with fixed-size key from map with variable-length
one, add a new map flag: BPF_F_DYNPTR_KEY to do that. For map which
enables BPF_F_DYNPTR_KEY, key btf type must be bpf_dynptr and the lower
32-bits of map_extra is used to specify the maximum size of dynptr key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h            |   2 +
 include/uapi/linux/bpf.h       |   9 +++
 kernel/bpf/syscall.c           | 108 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |   8 +++
 4 files changed, 113 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8da4a8190413..5060d7aee08c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2641,6 +2641,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_LOCAL,
 	/* Underlying data is a ringbuf record */
 	BPF_DYNPTR_TYPE_RINGBUF,
+	/* Points to memory copied from/to userspace */
+	BPF_DYNPTR_TYPE_USER,
 };
 
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3df78c56c1bf..77a2828f8148 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1246,6 +1246,9 @@ enum {
 
 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Map with bpf_dynptr-typed key */
+	BPF_F_DYNPTR_KEY	= (1U << 13),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -6775,6 +6778,12 @@ struct bpf_timer {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_dynptr_user {
+	__u64 data;
+	__u32 size;
+	__u32 :32;
+} __attribute__((aligned(8)));
+
 struct bpf_dynptr {
 	__u64 :64;
 	__u64 :64;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dab156f09f8d..fd15c13cef24 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -151,6 +151,11 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
+static inline bool is_dynptr_key(const struct bpf_map *map)
+{
+	return map->map_flags & BPF_F_DYNPTR_KEY;
+}
+
 static u32 bpf_map_value_size(const struct bpf_map *map)
 {
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -994,7 +999,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	/* Some maps allow key to be unspecified. */
 	if (btf_key_id) {
 		key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
-		if (!key_type || key_size != map->key_size)
+		if (!key_type || key_size != map->key_size ||
+		    (is_dynptr_key(map) && !btf_type_is_bpf_dynptr(btf, key_type)))
 			return -EINVAL;
 	} else {
 		key_type = btf_type_by_id(btf, 0);
@@ -1089,9 +1095,16 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
 
-	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
-	    attr->map_extra != 0)
+	if (attr->map_flags & BPF_F_DYNPTR_KEY) {
+		/* The lower 32-bits of map_extra specifies the maximum size
+		 * of bpf_dynptr-typed key
+		 */
+		if (!attr->btf_key_type_id || !attr->map_extra || (attr->map_extra >> 32) ||
+		    bpf_dynptr_check_size(attr->map_extra))
+			return -EINVAL;
+	} else if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER && attr->map_extra != 0) {
 		return -EINVAL;
+	}
 
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
@@ -1280,8 +1293,39 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *__bpf_copy_key(void __user *ukey, u64 key_size)
+static void *bpf_copy_from_dynptr_ukey(bpfptr_t ukey)
 {
+	struct bpf_dynptr_kern *kptr;
+	struct bpf_dynptr_user uptr;
+	bpfptr_t data;
+
+	if (copy_from_bpfptr(&uptr, ukey, sizeof(uptr)))
+		return ERR_PTR(-EFAULT);
+
+	if (!uptr.size || bpf_dynptr_check_size(uptr.size))
+		return ERR_PTR(-EINVAL);
+
+	/* Allocate and free bpf_dynptr_kern and its data together */
+	kptr = kvmalloc(sizeof(*kptr) + uptr.size, GFP_USER | __GFP_NOWARN);
+	if (!kptr)
+		return ERR_PTR(-ENOMEM);
+
+	data = make_bpfptr(uptr.data, bpfptr_is_kernel(ukey));
+	if (copy_from_bpfptr(&kptr[1], data, uptr.size)) {
+		kvfree(kptr);
+		return ERR_PTR(-EFAULT);
+	}
+
+	bpf_dynptr_init(kptr, &kptr[1], BPF_DYNPTR_TYPE_USER, 0, uptr.size);
+
+	return kptr;
+}
+
+static void *__bpf_copy_key(void __user *ukey, u64 key_size, bool dynptr)
+{
+	if (dynptr)
+		return bpf_copy_from_dynptr_ukey(USER_BPFPTR(ukey));
+
 	if (key_size)
 		return vmemdup_user(ukey, key_size);
 
@@ -1291,8 +1335,11 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
 	return NULL;
 }
 
-static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
+static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size, bool dynptr)
 {
+	if (dynptr)
+		return bpf_copy_from_dynptr_ukey(ukey);
+
 	if (key_size)
 		return kvmemdup_bpfptr(ukey, key_size);
 
@@ -1302,6 +1349,34 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 	return NULL;
 }
 
+static void *bpf_new_dynptr_key(u32 key_size)
+{
+	struct bpf_dynptr_kern *kptr;
+
+	kptr = kvmalloc(sizeof(*kptr) + key_size, GFP_USER | __GFP_NOWARN);
+	if (kptr)
+		bpf_dynptr_init(kptr, &kptr[1], BPF_DYNPTR_TYPE_USER, 0, key_size);
+	return kptr;
+}
+
+static int bpf_copy_to_dynptr_ukey(struct bpf_dynptr_user __user *uptr,
+				   struct bpf_dynptr_kern *kptr)
+{
+	unsigned int size;
+	u64 udata;
+
+	if (get_user(udata, &uptr->data))
+		return -EFAULT;
+
+	/* Also zeroing the reserved field in uptr */
+	size = bpf_dynptr_get_size(kptr);
+	if (copy_to_user(u64_to_user_ptr(udata), kptr->data + kptr->offset, size) ||
+	    put_user(size, &uptr->size) || put_user(0, &uptr->size + 1))
+		return -EFAULT;
+
+	return 0;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
 
@@ -1337,7 +1412,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(ukey, map->key_size, is_dynptr_key(map));
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1377,7 +1452,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
-
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
@@ -1410,7 +1484,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(ukey, map->key_size, is_dynptr_key(map));
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1458,7 +1532,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(ukey, map->key_size, is_dynptr_key(map));
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1514,7 +1588,7 @@ static int map_get_next_key(union bpf_attr *attr)
 	}
 
 	if (ukey) {
-		key = __bpf_copy_key(ukey, map->key_size);
+		key = __bpf_copy_key(ukey, map->key_size, is_dynptr_key(map));
 		if (IS_ERR(key)) {
 			err = PTR_ERR(key);
 			goto err_put;
@@ -1524,7 +1598,10 @@ static int map_get_next_key(union bpf_attr *attr)
 	}
 
 	err = -ENOMEM;
-	next_key = kvmalloc(map->key_size, GFP_USER);
+	if (is_dynptr_key(map))
+		next_key = bpf_new_dynptr_key(map->map_extra);
+	else
+		next_key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!next_key)
 		goto free_key;
 
@@ -1540,8 +1617,11 @@ static int map_get_next_key(union bpf_attr *attr)
 	if (err)
 		goto free_next_key;
 
-	err = -EFAULT;
-	if (copy_to_user(unext_key, next_key, map->key_size) != 0)
+	if (is_dynptr_key(map))
+		err = bpf_copy_to_dynptr_ukey(unext_key, next_key);
+	else
+		err = copy_to_user(unext_key, next_key, map->key_size) != 0 ? -EFAULT : 0;
+	if (err)
 		goto free_next_key;
 
 	err = 0;
@@ -1815,7 +1895,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(ukey, map->key_size, is_dynptr_key(map));
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3df78c56c1bf..600c3fcee37a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1246,6 +1246,8 @@ enum {
 
 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+/* Map with bpf_dynptr-typed key */
+	BPF_F_DYNPTR_KEY	= (1U << 13),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -6775,6 +6777,12 @@ struct bpf_timer {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_dynptr_user {
+	__u64 data;
+	__u32 size;
+	__u32 :32;
+} __attribute__((aligned(8)));
+
 struct bpf_dynptr {
 	__u64 :64;
 	__u64 :64;
-- 
2.29.2

