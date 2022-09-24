Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F64B5E8D04
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiIXNS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIXNSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:23 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813ADB6547
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MZV0310lQz6S2lm
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S7;
        Sat, 24 Sep 2022 21:18:19 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 03/13] bpf: Support bpf_dynptr-typed map key in bpf syscall
Date:   Sat, 24 Sep 2022 21:36:10 +0800
Message-Id: <20220924133620.4147153-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220924133620.4147153-1-houtao@huaweicloud.com>
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S7
X-Coremail-Antispam: 1UD129KBjvJXoW3CF1rKw48Ar1DJw17Xw1DJrb_yoWkGr4UpF
        48CFyfZr4FqrW7JryDZa1vvw40qws2qw17G393Ga4rCFsFqr9xZr10qFWFgr909FyDJr43
        Jr40qrWFk34xArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
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

Userspace application uses bpf syscall to lookup or update bpf map. It
passes a pointer of fixed-size buffer to kernel to represent the map
key. To support map with variable-length key, introduce bpf_dynptr_user
to allow userspace to pass a pointer of bpf_dynptr_user to specify the
address and the length of key buffer. And in order to represent dynptr
from userspace, adding a new dynptr type: BPF_DYNPTR_TYPE_USER. Because
BPF_DYNPTR_TYPE_USER-typed dynptr is not available from bpf program, so
no verifier update is needed.

Add dynptr_key_off in bpf_map to distinguish map with fixed-size key
from map with variable-length. dynptr_key_off is less than zero for
fixed-size key and can only be zero for dynptr key.

For dynptr-key map, key btf type is bpf_dynptr and key size is 16, so
use the lower 32-bits of map_extra to specify the maximum size of dynptr
key.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h            |   8 +++
 include/uapi/linux/bpf.h       |   6 ++
 kernel/bpf/map_in_map.c        |   3 +
 kernel/bpf/syscall.c           | 121 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |   6 ++
 5 files changed, 125 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 66a18dc67b46..44bef4110179 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -216,6 +216,7 @@ struct bpf_map {
 	int spin_lock_off; /* >=0 valid offset, <0 error */
 	struct bpf_map_value_off *kptr_off_tab;
 	int timer_off; /* >=0 valid offset, <0 error */
+	int dynptr_key_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
 	u32 btf_key_type_id;
@@ -265,6 +266,11 @@ static inline bool map_value_has_kptrs(const struct bpf_map *map)
 	return !IS_ERR_OR_NULL(map->kptr_off_tab);
 }
 
+static inline bool map_key_has_dynptr(const struct bpf_map *map)
+{
+	return map->dynptr_key_off >= 0;
+}
+
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
 	if (unlikely(map_value_has_spin_lock(map)))
@@ -2654,6 +2660,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_LOCAL,
 	/* Underlying data is a kernel-produced ringbuf record */
 	BPF_DYNPTR_TYPE_RINGBUF,
+	/* Points to memory copied from/to userspace */
+	BPF_DYNPTR_TYPE_USER,
 };
 
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ead35f39f185..3466bcc9aeca 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6814,6 +6814,12 @@ struct bpf_timer {
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
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d560..8ba96337893b 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -52,6 +52,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->max_entries = inner_map->max_entries;
 	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
 	inner_map_meta->timer_off = inner_map->timer_off;
+	inner_map_meta->dynptr_key_off = inner_map->dynptr_key_off;
 	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
@@ -85,7 +86,9 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->timer_off == meta1->timer_off &&
+		meta0->dynptr_key_off == meta1->dynptr_key_off &&
 		meta0->map_flags == meta1->map_flags &&
+		meta0->map_extra == meta1->map_extra &&
 		bpf_map_equal_kptr_off_tab(meta0, meta1);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 372fad5ef3d3..70919155c4ed 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -996,6 +996,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
 		if (!key_type || key_size != map->key_size)
 			return -EINVAL;
+		map->dynptr_key_off = btf_find_dynptr(btf, key_type);
 	} else {
 		key_type = btf_type_by_id(btf, 0);
 		if (!map->ops->map_check_btf)
@@ -1089,10 +1090,6 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
 
-	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
-	    attr->map_extra != 0)
-		return -EINVAL;
-
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
 		return f_flags;
@@ -1119,6 +1116,7 @@ static int map_create(union bpf_attr *attr)
 
 	map->spin_lock_off = -EINVAL;
 	map->timer_off = -EINVAL;
+	map->dynptr_key_off = -EINVAL;
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
 	     * the bpf_prog.o must have BTF to begin with
@@ -1154,6 +1152,20 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
+	if (map_key_has_dynptr(map)) {
+		/* The lower 32-bits of map_extra specifies the maximum size
+		 * of bpf_dynptr-typed key
+		 */
+		if (!attr->map_extra || (attr->map_extra >> 32) ||
+		    bpf_dynptr_check_size((u32)attr->map_extra)) {
+			err = -EINVAL;
+			goto free_map;
+		}
+	} else if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER && attr->map_extra != 0) {
+		err = -EINVAL;
+		goto free_map;
+	}
+
 	err = bpf_map_alloc_off_arr(map);
 	if (err)
 		goto free_map;
@@ -1280,10 +1292,41 @@ int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	return -ENOTSUPP;
 }
 
-static void *__bpf_copy_key(void __user *ukey, u64 key_size)
+static void *bpf_copy_from_dynptr_ukey(bpfptr_t ukey)
+{
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
+static void *__bpf_copy_key(const struct bpf_map *map, void __user *ukey)
 {
-	if (key_size)
-		return vmemdup_user(ukey, key_size);
+	if (map_key_has_dynptr(map))
+		return bpf_copy_from_dynptr_ukey(USER_BPFPTR(ukey));
+
+	if (map->key_size)
+		return vmemdup_user(ukey, map->key_size);
 
 	if (ukey)
 		return ERR_PTR(-EINVAL);
@@ -1291,10 +1334,13 @@ static void *__bpf_copy_key(void __user *ukey, u64 key_size)
 	return NULL;
 }
 
-static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
+static void *___bpf_copy_key(const struct bpf_map *map, bpfptr_t ukey)
 {
-	if (key_size)
-		return kvmemdup_bpfptr(ukey, key_size);
+	if (map_key_has_dynptr(map))
+		return bpf_copy_from_dynptr_ukey(ukey);
+
+	if (map->key_size)
+		return kvmemdup_bpfptr(ukey, map->key_size);
 
 	if (!bpfptr_is_null(ukey))
 		return ERR_PTR(-EINVAL);
@@ -1302,6 +1348,38 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
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
+	struct {
+		unsigned int size;
+		unsigned int zero;
+	} tuple;
+	u64 udata;
+
+	if (copy_from_user(&udata, &uptr->data, sizeof(udata)))
+		return -EFAULT;
+
+	/* Also zeroing the reserved field in uptr */
+	tuple.size = bpf_dynptr_get_size(kptr);
+	tuple.zero = 0;
+	if (copy_to_user(u64_to_user_ptr(udata), kptr->data + kptr->offset, tuple.size) ||
+	    copy_to_user(&uptr->size, &tuple, sizeof(tuple)))
+		return -EFAULT;
+
+	return 0;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
 
@@ -1337,7 +1415,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1377,7 +1455,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
-
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
@@ -1410,7 +1487,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1458,7 +1535,7 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	key = ___bpf_copy_key(ukey, map->key_size);
+	key = ___bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
@@ -1514,7 +1591,7 @@ static int map_get_next_key(union bpf_attr *attr)
 	}
 
 	if (ukey) {
-		key = __bpf_copy_key(ukey, map->key_size);
+		key = __bpf_copy_key(map, ukey);
 		if (IS_ERR(key)) {
 			err = PTR_ERR(key);
 			goto err_put;
@@ -1524,7 +1601,10 @@ static int map_get_next_key(union bpf_attr *attr)
 	}
 
 	err = -ENOMEM;
-	next_key = kvmalloc(map->key_size, GFP_USER);
+	if (map_key_has_dynptr(map))
+		next_key = bpf_new_dynptr_key(map->map_extra);
+	else
+		next_key = kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!next_key)
 		goto free_key;
 
@@ -1540,8 +1620,11 @@ static int map_get_next_key(union bpf_attr *attr)
 	if (err)
 		goto free_next_key;
 
-	err = -EFAULT;
-	if (copy_to_user(unext_key, next_key, map->key_size) != 0)
+	if (map_key_has_dynptr(map))
+		err = bpf_copy_to_dynptr_ukey(unext_key, next_key);
+	else
+		err = copy_to_user(unext_key, next_key, map->key_size) != 0 ? -EFAULT : 0;
+	if (err)
 		goto free_next_key;
 
 	err = 0;
@@ -1815,7 +1898,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	key = __bpf_copy_key(ukey, map->key_size);
+	key = __bpf_copy_key(map, ukey);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ead35f39f185..3466bcc9aeca 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6814,6 +6814,12 @@ struct bpf_timer {
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

