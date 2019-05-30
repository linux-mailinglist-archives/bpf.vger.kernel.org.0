Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604342EA03
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 03:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfE3BEb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 21:04:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727210AbfE3BEM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 May 2019 21:04:12 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4U13PJ8031851
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nybg4e/0/fcxULEeUJFLlNPvtrBKsy7klIrVaDR3wmY=;
 b=qORwcabKi6pfL6QAA67dOaXqsYl7UwF1FWfH8P+Bxq5L3J6Fe/G3Yi0Ev3R0RCw3JMB3
 p9ZPqHzeZOTDM26QrJH0mh1OGsX31IZuFw0FwdmYM+56xIP2azu2MTZmRtgnSW6Ihi9c
 WPZgCjifcVQOYgk+QLQ3hs1h5t1AaqSHFbg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2st1638tng-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:09 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 29 May 2019 18:04:07 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id B0A90129321E7; Wed, 29 May 2019 18:04:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 4/5] bpf: rework memlock-based memory accounting for maps
Date:   Wed, 29 May 2019 18:03:58 -0700
Message-ID: <20190530010359.2499670-5-guro@fb.com>
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

In order to unify the existing memlock charging code with the
memcg-based memory accounting, which will be added later, let's
rework the current scheme.

Currently the following design is used:
  1) .alloc() callback optionally checks if the allocation will likely
     succeed using bpf_map_precharge_memlock()
  2) .alloc() performs actual allocations
  3) .alloc() callback calculates map cost and sets map.memory.pages
  4) map_create() calls bpf_map_init_memlock() which sets map.memory.user
     and performs actual charging; in case of failure the map is
     destroyed
  <map is in use>
  1) bpf_map_free_deferred() calls bpf_map_release_memlock(), which
     performs uncharge and releases the user
  2) .map_free() callback releases the memory

The scheme can be simplified and made more robust:
  1) .alloc() calculates map cost and calls bpf_map_charge_init()
  2) bpf_map_charge_init() sets map.memory.user and performs actual
    charge
  3) .alloc() performs actual allocations
  <map is in use>
  1) .map_free() callback releases the memory
  2) bpf_map_charge_finish() performs uncharge and releases the user

The new scheme also allows to reuse bpf_map_charge_init()/finish()
functions for memcg-based accounting. Because charges are performed
before actual allocations and uncharges after freeing the memory,
no bogus memory pressure can be created.

In cases when the map structure is not available (e.g. it's not
created yet, or is already destroyed), on-stack bpf_map_memory
structure is used. The charge can be transferred with the
bpf_map_charge_move() function.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/bpf.h           |  5 ++-
 kernel/bpf/arraymap.c         | 10 +++--
 kernel/bpf/cpumap.c           |  8 ++--
 kernel/bpf/devmap.c           | 13 ++++---
 kernel/bpf/hashtab.c          | 11 +++---
 kernel/bpf/local_storage.c    |  9 +++--
 kernel/bpf/lpm_trie.c         |  5 +--
 kernel/bpf/queue_stack_maps.c |  9 +++--
 kernel/bpf/reuseport_array.c  |  9 +++--
 kernel/bpf/stackmap.c         | 30 ++++++++-------
 kernel/bpf/syscall.c          | 69 +++++++++++++++++------------------
 kernel/bpf/xskmap.c           |  9 +++--
 net/core/bpf_sk_storage.c     |  8 ++--
 net/core/sock_map.c           |  5 ++-
 14 files changed, 112 insertions(+), 88 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 980b7a9bdd21..6187203b0414 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -600,9 +600,12 @@ struct bpf_map *__bpf_map_get(struct fd f);
 struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
-int bpf_map_precharge_memlock(u32 pages);
 int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
 void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
+int bpf_map_charge_init(struct bpf_map_memory *mem, u32 pages);
+void bpf_map_charge_finish(struct bpf_map_memory *mem);
+void bpf_map_charge_move(struct bpf_map_memory *dst,
+			 struct bpf_map_memory *src);
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 8fda24e78193..3552da4407d9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -83,6 +83,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	u32 elem_size, index_mask, max_entries;
 	bool unpriv = !capable(CAP_SYS_ADMIN);
 	u64 cost, array_size, mask64;
+	struct bpf_map_memory mem;
 	struct bpf_array *array;
 
 	elem_size = round_up(attr->value_size, 8);
@@ -125,23 +126,26 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	}
 	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
-	ret = bpf_map_precharge_memlock(cost);
+	ret = bpf_map_charge_init(&mem, cost);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
 	/* allocate all map elements and zero-initialize them */
 	array = bpf_map_area_alloc(array_size, numa_node);
-	if (!array)
+	if (!array) {
+		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
+	}
 	array->index_mask = index_mask;
 	array->map.unpriv_array = unpriv;
 
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
-	array->map.memory.pages = cost;
+	bpf_map_charge_move(&array->map.memory, &mem);
 	array->elem_size = elem_size;
 
 	if (percpu && bpf_array_alloc_percpu(array)) {
+		bpf_map_charge_finish(&array->map.memory);
 		bpf_map_area_free(array);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 035268add724..c633c8d68023 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -108,10 +108,10 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	cost += cpu_map_bitmap_size(attr) * num_possible_cpus();
 	if (cost >= U32_MAX - PAGE_SIZE)
 		goto free_cmap;
-	cmap->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
 	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	ret = bpf_map_precharge_memlock(cmap->map.memory.pages);
+	ret = bpf_map_charge_init(&cmap->map.memory,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
 	if (ret) {
 		err = ret;
 		goto free_cmap;
@@ -121,7 +121,7 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	cmap->flush_needed = __alloc_percpu(cpu_map_bitmap_size(attr),
 					    __alignof__(unsigned long));
 	if (!cmap->flush_needed)
-		goto free_cmap;
+		goto free_charge;
 
 	/* Alloc array for possible remote "destination" CPUs */
 	cmap->cpu_map = bpf_map_area_alloc(cmap->map.max_entries *
@@ -133,6 +133,8 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	return &cmap->map;
 free_percpu:
 	free_percpu(cmap->flush_needed);
+free_charge:
+	bpf_map_charge_finish(&cmap->map.memory);
 free_cmap:
 	kfree(cmap);
 	return ERR_PTR(err);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index f6c57efb1d0d..371bd880ed58 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -111,10 +111,9 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 	if (cost >= U32_MAX - PAGE_SIZE)
 		goto free_dtab;
 
-	dtab->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-
-	/* if map size is larger than memlock limit, reject it early */
-	err = bpf_map_precharge_memlock(dtab->map.memory.pages);
+	/* if map size is larger than memlock limit, reject it */
+	err = bpf_map_charge_init(&dtab->map.memory,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
 	if (err)
 		goto free_dtab;
 
@@ -125,19 +124,21 @@ static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
 						__alignof__(unsigned long),
 						GFP_KERNEL | __GFP_NOWARN);
 	if (!dtab->flush_needed)
-		goto free_dtab;
+		goto free_charge;
 
 	dtab->netdev_map = bpf_map_area_alloc(dtab->map.max_entries *
 					      sizeof(struct bpf_dtab_netdev *),
 					      dtab->map.numa_node);
 	if (!dtab->netdev_map)
-		goto free_dtab;
+		goto free_charge;
 
 	spin_lock(&dev_map_lock);
 	list_add_tail_rcu(&dtab->list, &dev_map_list);
 	spin_unlock(&dev_map_lock);
 
 	return &dtab->map;
+free_charge:
+	bpf_map_charge_finish(&dtab->map.memory);
 free_dtab:
 	free_percpu(dtab->flush_needed);
 	kfree(dtab);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 15bf228d2e98..b0bdc7b040ad 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -364,10 +364,9 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		/* make sure page count doesn't overflow */
 		goto free_htab;
 
-	htab->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-
-	/* if map size is larger than memlock limit, reject it early */
-	err = bpf_map_precharge_memlock(htab->map.memory.pages);
+	/* if map size is larger than memlock limit, reject it */
+	err = bpf_map_charge_init(&htab->map.memory,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
 	if (err)
 		goto free_htab;
 
@@ -376,7 +375,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 					   sizeof(struct bucket),
 					   htab->map.numa_node);
 	if (!htab->buckets)
-		goto free_htab;
+		goto free_charge;
 
 	if (htab->map.map_flags & BPF_F_ZERO_SEED)
 		htab->hashrnd = 0;
@@ -409,6 +408,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	prealloc_destroy(htab);
 free_buckets:
 	bpf_map_area_free(htab->buckets);
+free_charge:
+	bpf_map_charge_finish(&htab->map.memory);
 free_htab:
 	kfree(htab);
 	return ERR_PTR(err);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 574325276650..e49bfd4f4f6d 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -272,6 +272,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_cgroup_storage_map *map;
+	struct bpf_map_memory mem;
 	u32 pages;
 	int ret;
 
@@ -294,16 +295,18 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 	pages = round_up(sizeof(struct bpf_cgroup_storage_map), PAGE_SIZE) >>
 		PAGE_SHIFT;
-	ret = bpf_map_precharge_memlock(pages);
+	ret = bpf_map_charge_init(&mem, pages);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
 	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
 			   __GFP_ZERO | GFP_USER, numa_node);
-	if (!map)
+	if (!map) {
+		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
+	}
 
-	map->map.memory.pages = pages;
+	bpf_map_charge_move(&map->map.memory, &mem);
 
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&map->map, attr);
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 8e423a582760..6345a8d2dcd0 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -578,9 +578,8 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 		goto out_err;
 	}
 
-	trie->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-
-	ret = bpf_map_precharge_memlock(trie->map.memory.pages);
+	ret = bpf_map_charge_init(&trie->map.memory,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
 	if (ret)
 		goto out_err;
 
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 8a510e71d486..224cb0fd8f03 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -67,6 +67,7 @@ static int queue_stack_map_alloc_check(union bpf_attr *attr)
 static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
 {
 	int ret, numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_map_memory mem = {0};
 	struct bpf_queue_stack *qs;
 	u64 size, queue_size, cost;
 
@@ -77,19 +78,21 @@ static struct bpf_map *queue_stack_map_alloc(union bpf_attr *attr)
 
 	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
-	ret = bpf_map_precharge_memlock(cost);
+	ret = bpf_map_charge_init(&mem, cost);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
 	qs = bpf_map_area_alloc(queue_size, numa_node);
-	if (!qs)
+	if (!qs) {
+		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset(qs, 0, sizeof(*qs));
 
 	bpf_map_init_from_attr(&qs->map, attr);
 
-	qs->map.memory.pages = cost;
+	bpf_map_charge_move(&qs->map.memory, &mem);
 	qs->size = size;
 
 	raw_spin_lock_init(&qs->lock);
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 819515242739..5c6e25b1b9b1 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -151,6 +151,7 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 {
 	int err, numa_node = bpf_map_attr_numa_node(attr);
 	struct reuseport_array *array;
+	struct bpf_map_memory mem;
 	u64 cost, array_size;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -165,18 +166,20 @@ static struct bpf_map *reuseport_array_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
-	err = bpf_map_precharge_memlock(cost);
+	err = bpf_map_charge_init(&mem, cost);
 	if (err)
 		return ERR_PTR(err);
 
 	/* allocate all map elements and zero-initialize them */
 	array = bpf_map_area_alloc(array_size, numa_node);
-	if (!array)
+	if (!array) {
+		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
-	array->map.memory.pages = cost;
+	bpf_map_charge_move(&array->map.memory, &mem);
 
 	return &array->map;
 }
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 08d4efff73ac..8da24ca65d97 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -89,6 +89,7 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 {
 	u32 value_size = attr->value_size;
 	struct bpf_stack_map *smap;
+	struct bpf_map_memory mem;
 	u64 cost, n_buckets;
 	int err;
 
@@ -116,40 +117,43 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	n_buckets = roundup_pow_of_two(attr->max_entries);
 
 	cost = n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
+	if (cost >= U32_MAX - PAGE_SIZE)
+		return ERR_PTR(-E2BIG);
+	cost += n_buckets * (value_size + sizeof(struct stack_map_bucket));
 	if (cost >= U32_MAX - PAGE_SIZE)
 		return ERR_PTR(-E2BIG);
 
+	err = bpf_map_charge_init(&mem,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
+	if (err)
+		return ERR_PTR(err);
+
 	smap = bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
-	if (!smap)
+	if (!smap) {
+		bpf_map_charge_finish(&mem);
 		return ERR_PTR(-ENOMEM);
-
-	err = -E2BIG;
-	cost += n_buckets * (value_size + sizeof(struct stack_map_bucket));
-	if (cost >= U32_MAX - PAGE_SIZE)
-		goto free_smap;
+	}
 
 	bpf_map_init_from_attr(&smap->map, attr);
 	smap->map.value_size = value_size;
 	smap->n_buckets = n_buckets;
-	smap->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-
-	err = bpf_map_precharge_memlock(smap->map.memory.pages);
-	if (err)
-		goto free_smap;
 
 	err = get_callchain_buffers(sysctl_perf_event_max_stack);
 	if (err)
-		goto free_smap;
+		goto free_charge;
 
 	err = prealloc_elems_and_freelist(smap);
 	if (err)
 		goto put_buffers;
 
+	bpf_map_charge_move(&smap->map.memory, &mem);
+
 	return &smap->map;
 
 put_buffers:
 	put_callchain_buffers();
-free_smap:
+free_charge:
+	bpf_map_charge_finish(&mem);
 	bpf_map_area_free(smap);
 	return ERR_PTR(err);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index df14e63806c8..351cc434c4ad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -188,19 +188,6 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr)
 	map->numa_node = bpf_map_attr_numa_node(attr);
 }
 
-int bpf_map_precharge_memlock(u32 pages)
-{
-	struct user_struct *user = get_current_user();
-	unsigned long memlock_limit, cur;
-
-	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	cur = atomic_long_read(&user->locked_vm);
-	free_uid(user);
-	if (cur + pages > memlock_limit)
-		return -EPERM;
-	return 0;
-}
-
 static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
 	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
@@ -214,29 +201,40 @@ static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 
 static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
 {
-	atomic_long_sub(pages, &user->locked_vm);
+	if (user)
+		atomic_long_sub(pages, &user->locked_vm);
 }
 
-static int bpf_map_init_memlock(struct bpf_map *map)
+int bpf_map_charge_init(struct bpf_map_memory *mem, u32 pages)
 {
 	struct user_struct *user = get_current_user();
 	int ret;
 
-	ret = bpf_charge_memlock(user, map->memory.pages);
+	ret = bpf_charge_memlock(user, pages);
 	if (ret) {
 		free_uid(user);
 		return ret;
 	}
-	map->memory.user = user;
-	return ret;
+
+	mem->pages = pages;
+	mem->user = user;
+
+	return 0;
 }
 
-static void bpf_map_release_memlock(struct bpf_map *map)
+void bpf_map_charge_finish(struct bpf_map_memory *mem)
 {
-	struct user_struct *user = map->memory.user;
+	bpf_uncharge_memlock(mem->user, mem->pages);
+	free_uid(mem->user);
+}
 
-	bpf_uncharge_memlock(user, map->memory.pages);
-	free_uid(user);
+void bpf_map_charge_move(struct bpf_map_memory *dst,
+			 struct bpf_map_memory *src)
+{
+	*dst = *src;
+
+	/* Make sure src will not be used for the redundant uncharging. */
+	memset(src, 0, sizeof(struct bpf_map_memory));
 }
 
 int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
@@ -304,11 +302,13 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
 static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
+	struct bpf_map_memory mem;
 
-	bpf_map_release_memlock(map);
+	bpf_map_charge_move(&mem, &map->memory);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
+	bpf_map_charge_finish(&mem);
 }
 
 static void bpf_map_put_uref(struct bpf_map *map)
@@ -550,6 +550,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 static int map_create(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_map_memory mem;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -574,7 +575,7 @@ static int map_create(union bpf_attr *attr)
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name);
 	if (err)
-		goto free_map_nouncharge;
+		goto free_map;
 
 	atomic_set(&map->refcnt, 1);
 	atomic_set(&map->usercnt, 1);
@@ -584,20 +585,20 @@ static int map_create(union bpf_attr *attr)
 
 		if (!attr->btf_value_type_id) {
 			err = -EINVAL;
-			goto free_map_nouncharge;
+			goto free_map;
 		}
 
 		btf = btf_get_by_fd(attr->btf_fd);
 		if (IS_ERR(btf)) {
 			err = PTR_ERR(btf);
-			goto free_map_nouncharge;
+			goto free_map;
 		}
 
 		err = map_check_btf(map, btf, attr->btf_key_type_id,
 				    attr->btf_value_type_id);
 		if (err) {
 			btf_put(btf);
-			goto free_map_nouncharge;
+			goto free_map;
 		}
 
 		map->btf = btf;
@@ -609,15 +610,11 @@ static int map_create(union bpf_attr *attr)
 
 	err = security_bpf_map_alloc(map);
 	if (err)
-		goto free_map_nouncharge;
-
-	err = bpf_map_init_memlock(map);
-	if (err)
-		goto free_map_sec;
+		goto free_map;
 
 	err = bpf_map_alloc_id(map);
 	if (err)
-		goto free_map;
+		goto free_map_sec;
 
 	err = bpf_map_new_fd(map, f_flags);
 	if (err < 0) {
@@ -633,13 +630,13 @@ static int map_create(union bpf_attr *attr)
 
 	return err;
 
-free_map:
-	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
-free_map_nouncharge:
+free_map:
 	btf_put(map->btf);
+	bpf_map_charge_move(&mem, &map->memory);
 	map->ops->map_free(map);
+	bpf_map_charge_finish(&mem);
 	return err;
 }
 
diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
index f816ee1a0fa0..a329dab7c7a4 100644
--- a/kernel/bpf/xskmap.c
+++ b/kernel/bpf/xskmap.c
@@ -40,10 +40,9 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 	if (cost >= U32_MAX - PAGE_SIZE)
 		goto free_m;
 
-	m->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-
 	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	err = bpf_map_precharge_memlock(m->map.memory.pages);
+	err = bpf_map_charge_init(&m->map.memory,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
 	if (err)
 		goto free_m;
 
@@ -51,7 +50,7 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 
 	m->flush_list = alloc_percpu(struct list_head);
 	if (!m->flush_list)
-		goto free_m;
+		goto free_charge;
 
 	for_each_possible_cpu(cpu)
 		INIT_LIST_HEAD(per_cpu_ptr(m->flush_list, cpu));
@@ -65,6 +64,8 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 
 free_percpu:
 	free_percpu(m->flush_list);
+free_charge:
+	bpf_map_charge_finish(&m->map.memory);
 free_m:
 	kfree(m);
 	return ERR_PTR(err);
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 92581c3ff220..621a0b07ff11 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -640,13 +640,16 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
 	pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
 
-	ret = bpf_map_precharge_memlock(pages);
-	if (ret < 0)
+	ret = bpf_map_charge_init(&smap->map.memory, pages);
+	if (ret < 0) {
+		kfree(smap);
 		return ERR_PTR(ret);
+	}
 
 	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
 				 GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
+		bpf_map_charge_finish(&smap->map.memory);
 		kfree(smap);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -659,7 +662,6 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
 	smap->cache_idx = (unsigned int)atomic_inc_return(&cache_idx) %
 		BPF_SK_STORAGE_CACHE_SIZE;
-	smap->map.memory.pages = pages;
 
 	return &smap->map;
 }
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 4eb5b6a1b29f..1028c922a149 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -49,8 +49,8 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 		goto free_stab;
 	}
 
-	stab->map.memory.pages = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
-	err = bpf_map_precharge_memlock(stab->map.memory.pages);
+	err = bpf_map_charge_init(&stab->map.memory,
+				  round_up(cost, PAGE_SIZE) >> PAGE_SHIFT);
 	if (err)
 		goto free_stab;
 
@@ -60,6 +60,7 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 	if (stab->sks)
 		return &stab->map;
 	err = -ENOMEM;
+	bpf_map_charge_finish(&stab->map.memory);
 free_stab:
 	kfree(stab);
 	return ERR_PTR(err);
-- 
2.20.1

