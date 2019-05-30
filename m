Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93212EA02
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 03:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfE3BEY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 21:04:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727216AbfE3BEY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 May 2019 21:04:24 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4U11Y5C015925
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=7XSmOe3GQlyJ48EQBpnuA5PGtxGRmQFUanPna2Qk/Co=;
 b=B0Gug89Im7qprfmnvtm3nqq3slZv4GXCCyCohzelBxeWDi9sBCer3pDTaWRVqwhd1xv3
 mBpf0lOPPguSCWbBEbM3lZyAxhr7XbQg0L3B3949/Y4ibSdEPds6OQi3jaPqOFKX9YeD
 rwSOaii+aFE0eTEI1A1rKzQHQp7KZvJTRZo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2st2yjre5w-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:22 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 29 May 2019 18:04:08 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id B46F4129321E9; Wed, 29 May 2019 18:04:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 5/5] bpf: move memory size checks to bpf_map_charge_init()
Date:   Wed, 29 May 2019 18:03:59 -0700
Message-ID: <20190530010359.2499670-6-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530010359.2499670-1-guro@fb.com>
References: <20190530010359.2499670-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Most bpf map types doing similar checks and bytes to pages
conversion during memory allocation and charging.

Let's unify these checks by moving them into bpf_map_charge_init().

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/bpf.h           |  2 +-
 kernel/bpf/arraymap.c         |  8 +-------
 kernel/bpf/cpumap.c           |  5 +----
 kernel/bpf/devmap.c           |  5 +----
 kernel/bpf/hashtab.c          |  7 +------
 kernel/bpf/local_storage.c    |  5 +----
 kernel/bpf/lpm_trie.c         |  7 +------
 kernel/bpf/queue_stack_maps.c |  4 ----
 kernel/bpf/reuseport_array.c  | 10 ++--------
 kernel/bpf/stackmap.c         |  8 +-------
 kernel/bpf/syscall.c          |  9 +++++++--
 kernel/bpf/xskmap.c           |  5 +----
 net/core/bpf_sk_storage.c     |  4 +---
 net/core/sock_map.c           |  8 +-------
 14 files changed, 20 insertions(+), 67 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6187203b0414..3997c0038062 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -602,7 +602,7 @@ void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
 void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
-int bpf_map_charge_init(struct bpf_map_memory *mem, u32 pages);
+int bpf_map_charge_init(struct bpf_map_memory *mem, size_t size);
 void bpf_map_charge_finish(struct bpf_map_memory *mem);
 void bpf_map_charge_move(struct bpf_map_memory *dst,
 			 struct bpf_map_memory *src);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3552da4407d9..0349cbf23cdb 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -117,14 +117,8 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 
 	/* make sure there is no u32 overflow later in round_up() */
 	cost = array_size;
-	if (cost >= U32_MAX - PAGE_SIZE)
-		return ERR_PTR(-ENOMEM);
-	if (percpu) {
+	if (percpu)
 		cost += (u64)attr->max_entries * elem_size * num_possible_cpus();
-		if (cost >= U32_MAX - PAGE_SIZE)
-			return ERR_PTR(-ENOMEM);
-	}
-	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
 	ret = bpf_map_charge_init(&mem, cost);
 	if (ret < 0)
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index c633c8d68023..b31a71909307 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -106,12 +106,9 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	/* make sure page count doesn't overflow */
 	cost = (u64) cmap->map.max_entries * sizeof(struct bpf_cpu_map_entry *);
 	cost += cpu_map_bitmap_size(attr) * num_possible_cpus();
-	if (cost >= U32_MAX - PAGE_SIZE)
-		goto free_cmap;
 
 	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	ret = bpf_map_charge_init(&cmap->map.memory,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	ret = bpf_map_charge_init(&cmap->map.memory, cost);
 	if (ret) {
 		err = ret;
 		goto free_cmap;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 371bd880ed58..5ae7cce5ef16 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -108,12 +108,9 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 	/* make sure page count doesn't overflow */
 	cost = (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *);
 	cost += dev_map_bitmap_size(attr) * num_possible_cpus();
-	if (cost >= U32_MAX - PAGE_SIZE)
-		goto free_dtab;
 
 	/* if map size is larger than memlock limit, reject it */
-	err = bpf_map_charge_init(&dtab->map.memory,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	err = bpf_map_charge_init(&dtab->map.memory, cost);
 	if (err)
 		goto free_dtab;
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b0bdc7b040ad..d92e05d9979b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -360,13 +360,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 	       cost += (u64) htab->elem_size * num_possible_cpus();
 
-	if (cost >= U32_MAX - PAGE_SIZE)
-		/* make sure page count doesn't overflow */
-		goto free_htab;
-
 	/* if map size is larger than memlock limit, reject it */
-	err = bpf_map_charge_init(&htab->map.memory,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	err = bpf_map_charge_init(&htab->map.memory, cost);
 	if (err)
 		goto free_htab;
 
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index e49bfd4f4f6d..addd6fdceec8 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -273,7 +273,6 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_cgroup_storage_map *map;
 	struct bpf_map_memory mem;
-	u32 pages;
 	int ret;
 
 	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
@@ -293,9 +292,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 		/* max_entries is not used and enforced to be 0 */
 		return ERR_PTR(-EINVAL);
 
-	pages = round_up(sizeof(struct bpf_cgroup_storage_map), PAGE_SIZE) >>
-		PAGE_SHIFT;
-	ret = bpf_map_charge_init(&mem, pages);
+	ret = bpf_map_charge_init(&mem, sizeof(struct bpf_cgroup_storage_map));
 	if (ret < 0)
 		return ERR_PTR(ret);
 
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 6345a8d2dcd0..09334f13a8a0 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -573,13 +573,8 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	cost_per_node = sizeof(struct lpm_trie_node) +
 			attr->value_size + trie->data_size;
 	cost += (u64) attr->max_entries * cost_per_node;
-	if (cost >= U32_MAX - PAGE_SIZE) {
-		ret = -E2BIG;
-		goto out_err;
-	}
 
-	ret = bpf_map_charge_init(&trie->map.memory,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	ret = bpf_map_charge_init(&trie->map.memory, cost);
 	if (ret)
 		goto out_err;
 
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 224cb0fd8f03..f697647ceb54 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -73,10 +73,6 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
 
 	size = (u64) attr->max_entries + 1;
 	cost = queue_size = sizeof(*qs) + size * attr->value_size;
-	if (cost >= U32_MAX - PAGE_SIZE)
-		return ERR_PTR(-E2BIG);
-
-	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
 	ret = bpf_map_charge_init(&mem, cost);
 	if (ret < 0)
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 5c6e25b1b9b1..50c083ba978c 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -152,7 +152,7 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 	int err, numa_node = bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
 	struct bpf_map_memory mem;
-	u64 cost, array_size;
+	u64 array_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
@@ -160,13 +160,7 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 	array_size = sizeof(*array);
 	array_size += (u64)attr->max_entries * sizeof(struct sock *);
 
-	/* make sure there is no u32 overflow later in round_up() */
-	cost = array_size;
-	if (cost >= U32_MAX - PAGE_SIZE)
-		return ERR_PTR(-ENOMEM);
-	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-
-	err = bpf_map_charge_init(&mem, cost);
+	err = bpf_map_charge_init(&mem, array_size);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 8da24ca65d97..3d86072d8e32 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -117,14 +117,8 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	n_buckets = roundup_pow_of_two(attr->max_entries);
 
 	cost = n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
-	if (cost >= U32_MAX - PAGE_SIZE)
-		return ERR_PTR(-E2BIG);
 	cost += n_buckets * (value_size + sizeof(struct stack_map_bucket));
-	if (cost >= U32_MAX - PAGE_SIZE)
-		return ERR_PTR(-E2BIG);
-
-	err = bpf_map_charge_init(&mem,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	err = bpf_map_charge_init(&mem, cost);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 351cc434c4ad..b3e83712b982 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -205,11 +205,16 @@ static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
 		atomic_long_sub(pages, &user->locked_vm);
 }
 
-int bpf_map_charge_init(struct bpf_map_memory *mem, u32 pages)
+int bpf_map_charge_init(struct bpf_map_memory *mem, size_t size)
 {
-	struct user_struct *user = get_current_user();
+	u32 pages = round_up(size, PAGE_SIZE) >> PAGE_SHIFT;
+	struct user_struct *user;
 	int ret;
 
+	if (size >= U32_MAX - PAGE_SIZE)
+		return -E2BIG;
+
+	user = get_current_user();
 	ret = bpf_charge_memlock(user, pages);
 	if (ret) {
 		free_uid(user);
diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
index a329dab7c7a4..22066c28ba61 100644
--- a/kernel/bpf/xskmap.c
+++ b/kernel/bpf/xskmap.c
@@ -37,12 +37,9 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 
 	cost = (u64)m->map.max_entries * sizeof(struct xdp_sock *);
 	cost += sizeof(struct list_head) * num_possible_cpus();
-	if (cost >= U32_MAX - PAGE_SIZE)
-		goto free_m;
 
 	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	err = bpf_map_charge_init(&m->map.memory,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	err = bpf_map_charge_init(&m->map.memory, cost);
 	if (err)
 		goto free_m;
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 621a0b07ff11..f40e3d35fd9c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -626,7 +626,6 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	struct bpf_sk_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
-	u32 pages;
 	u64 cost;
 	int ret;
 
@@ -638,9 +637,8 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	smap->bucket_log = ilog2(roundup_pow_of_two(num_possible_cpus()));
 	nbuckets = 1U << smap->bucket_log;
 	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
-	pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
-	ret = bpf_map_charge_init(&smap->map.memory, pages);
+	ret = bpf_map_charge_init(&smap->map.memory, cost);
 	if (ret < 0) {
 		kfree(smap);
 		return ERR_PTR(ret);
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 1028c922a149..52d4faeee18b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -44,13 +44,7 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 
 	/* Make sure page count doesn't overflow. */
 	cost = (u64) stab->map.max_entries * sizeof(struct sock *);
-	if (cost >= U32_MAX - PAGE_SIZE) {
-		err = -EINVAL;
-		goto free_stab;
-	}
-
-	err = bpf_map_charge_init(&stab->map.memory,
-				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	err = bpf_map_charge_init(&stab->map.memory, cost);
 	if (err)
 		goto free_stab;
 
-- 
2.20.1

