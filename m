Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC86F4D72
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjEBXJj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 May 2023 19:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjEBXJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:09:36 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A86B3A94
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:09:31 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JX2V4031666
        for <bpf@vger.kernel.org>; Tue, 2 May 2023 16:09:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qatf9fbnv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 May 2023 16:09:30 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 2 May 2023 16:09:16 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EDCDF2FD4BCC5; Tue,  2 May 2023 16:06:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 04/10] bpf: remember if bpf_map was unprivileged and use that consistently
Date:   Tue, 2 May 2023 16:06:13 -0700
Message-ID: <20230502230619.2592406-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502230619.2592406-1-andrii@kernel.org>
References: <20230502230619.2592406-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eD0BvJ6DBAm5WLX5gLF-h-BqPqOp2jX9
X-Proofpoint-ORIG-GUID: eD0BvJ6DBAm5WLX5gLF-h-BqPqOp2jX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While some maps are allowed to be created with no extra privileges (like
CAP_BPF and/or CAP_NET_ADMIN), some parts of BPF verifier logic do care
about the presence of privileged for a given map.

One such place is Spectre v1 mitigations in ARRAY map. Another, extra
restrictions on maps having special embedded BTF-defined fields (like
spin lock, etc).

So record whether a map was privileged or not at the creation time and
don't recheck bpf_capable() anymore.

Handling Spectre v1 mitigation in ARRAY-like maps required a bit of code
acrobatics: extracting size adjustment into a separate
bpf_array_adjust_for_spec_v1() helper and calling it explicitly for
ARRAY, PERCPU_ARRAY, PROG_ARRAY, CGROUP_ARRAY, PERF_EVENT_ARRAY and
ARRAY_OF_MAPS to adjust passed in bpf_attrs, because these adjustments
have to happen before map creation. Alternative would be to extend
map_ops->map_alloc() callback with unprivileged flag, which seemed
excessive, as all other maps don't care, but could be done if preferred.

But once map->unpriv flag is recorded, handing BTF-defined fields was
a breeze, dropping bpf_capable() check buried deeper in map_check_btf()
validation logic.

Once extra bit that required consideration was remembering unprivileged
bit when dealing with map-in-maps and taking it into account when
checking map metadata compatibility. Given unprivileged bit is important
for correctness, it should be taken into account just like key and value
sizes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h     |  4 ++-
 kernel/bpf/arraymap.c   | 59 ++++++++++++++++++++++++-----------------
 kernel/bpf/map_in_map.c |  3 ++-
 kernel/bpf/syscall.c    | 25 +++++++++++++++--
 kernel/bpf/verifier.c   |  6 ++---
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 456f33b9d205..479657bb113e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -273,7 +273,7 @@ struct bpf_map {
 		bool jited;
 		bool xdp_has_frags;
 	} owner;
-	bool bypass_spec_v1;
+	bool unpriv;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 };
 
@@ -2058,6 +2058,8 @@ static inline bool bpf_bypass_spec_v1(void)
 	return perfmon_capable();
 }
 
+int bpf_array_adjust_for_spec_v1(union bpf_attr *attr);
+
 static inline bool bpf_bypass_spec_v4(void)
 {
 	return perfmon_capable();
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..a51d22a3afd1 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -77,18 +77,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-static struct bpf_map *array_map_alloc(union bpf_attr *attr)
+static u32 array_index_mask(u32 max_entries)
 {
-	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
-	int numa_node = bpf_map_attr_numa_node(attr);
-	u32 elem_size, index_mask, max_entries;
-	bool bypass_spec_v1 = bpf_bypass_spec_v1();
-	u64 array_size, mask64;
-	struct bpf_array *array;
-
-	elem_size = round_up(attr->value_size, 8);
-
-	max_entries = attr->max_entries;
+	u64 mask64;
 
 	/* On 32 bit archs roundup_pow_of_two() with max_entries that has
 	 * upper most bit set in u32 space is undefined behavior due to
@@ -98,17 +89,38 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	mask64 = 1ULL << mask64;
 	mask64 -= 1;
 
-	index_mask = mask64;
-	if (!bypass_spec_v1) {
-		/* round up array size to nearest power of 2,
-		 * since cpu will speculate within index_mask limits
-		 */
-		max_entries = index_mask + 1;
-		/* Check for overflows. */
-		if (max_entries < attr->max_entries)
-			return ERR_PTR(-E2BIG);
-	}
+	return (u32)mask64;
+}
+
+int bpf_array_adjust_for_spec_v1(union bpf_attr *attr)
+{
+	u32 max_entries, index_mask;
+
+	/* round up array size to nearest power of 2,
+	 * since cpu will speculate within index_mask limits
+	 */
+	index_mask = array_index_mask(attr->max_entries);
+	max_entries = index_mask + 1;
+	/* Check for overflows. */
+	if (max_entries < attr->max_entries)
+		return -E2BIG;
+
+	attr->max_entries = max_entries;
+	return 0;
+}
 
+static struct bpf_map *array_map_alloc(union bpf_attr *attr)
+{
+	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
+	int numa_node = bpf_map_attr_numa_node(attr);
+	u32 elem_size, index_mask, max_entries;
+	u64 array_size;
+	struct bpf_array *array;
+
+	elem_size = round_up(attr->value_size, 8);
+
+	max_entries = attr->max_entries;
+	index_mask = array_index_mask(max_entries);
 	array_size = sizeof(*array);
 	if (percpu) {
 		array_size += (u64) max_entries * sizeof(void *);
@@ -140,7 +152,6 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	if (!array)
 		return ERR_PTR(-ENOMEM);
 	array->index_mask = index_mask;
-	array->map.bypass_spec_v1 = bypass_spec_v1;
 
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&array->map, attr);
@@ -216,7 +227,7 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	if (!map->bypass_spec_v1) {
+	if (map->unpriv) {
 		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
 	} else {
@@ -1373,7 +1384,7 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	if (!map->bypass_spec_v1) {
+	if (map->unpriv) {
 		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 6);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
 	} else {
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 2c5c64c2a53b..21cb4be92097 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -41,6 +41,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		goto put;
 	}
 
+	inner_map_meta->unpriv = inner_map->unpriv;
 	inner_map_meta->map_type = inner_map->map_type;
 	inner_map_meta->key_size = inner_map->key_size;
 	inner_map_meta->value_size = inner_map->value_size;
@@ -69,7 +70,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	/* Misc members not needed in bpf_map_meta_equal() check. */
 	inner_map_meta->ops = inner_map->ops;
 	if (inner_map->ops == &array_map_ops) {
-		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
 		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
 		     container_of(inner_map, struct bpf_array, map)->index_mask;
 	}
@@ -98,6 +98,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->map_flags == meta1->map_flags &&
+		meta0->unpriv == meta1->unpriv &&
 		btf_record_equal(meta0->record, meta1->record);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 92127eaee467..ffc61a764fe5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1010,7 +1010,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
-		if (!bpf_capable()) {
+		if (map->unpriv) {
 			ret = -EPERM;
 			goto free_map_tab;
 		}
@@ -1100,6 +1100,7 @@ static int map_create(union bpf_attr *attr)
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
+	bool unpriv;
 	int f_flags;
 	int err;
 
@@ -1176,6 +1177,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_CPUMAP:
 		if (!bpf_capable())
 			return -EPERM;
+		unpriv = false;
 		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
@@ -1184,6 +1186,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_XSKMAP:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
+		unpriv = false;
 		break;
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
@@ -1198,18 +1201,36 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_USER_RINGBUF:
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
 	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
-		/* unprivileged */
+		/* unprivileged is OK, but we still record if we had CAP_BPF */
+		unpriv = !bpf_capable();
 		break;
 	default:
 		WARN(1, "unsupported map type %d", map_type);
 		return -EPERM;
 	}
 
+	/* ARRAY-like maps have special sizing provisions for mitigating Spectre v1 */
+	if (unpriv) {
+		switch (map_type) {
+		case BPF_MAP_TYPE_ARRAY:
+		case BPF_MAP_TYPE_PERCPU_ARRAY:
+		case BPF_MAP_TYPE_PROG_ARRAY:
+		case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+		case BPF_MAP_TYPE_CGROUP_ARRAY:
+		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+			err = bpf_array_adjust_for_spec_v1(attr);
+			if (err)
+				return err;
+			break;
+		}
+	}
+
 	map = ops->map_alloc(attr);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 	map->ops = ops;
 	map->map_type = map_type;
+	map->unpriv = unpriv;
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff4a8ab99f08..481aaf189183 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8731,11 +8731,9 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	}
 
 	if (!BPF_MAP_PTR(aux->map_ptr_state))
-		bpf_map_ptr_store(aux, meta->map_ptr,
-				  !meta->map_ptr->bypass_spec_v1);
+		bpf_map_ptr_store(aux, meta->map_ptr, meta->map_ptr->unpriv);
 	else if (BPF_MAP_PTR(aux->map_ptr_state) != meta->map_ptr)
-		bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON,
-				  !meta->map_ptr->bypass_spec_v1);
+		bpf_map_ptr_store(aux, BPF_MAP_PTR_POISON, meta->map_ptr->unpriv);
 	return 0;
 }
 
-- 
2.34.1

