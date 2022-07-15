Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E821E575AFF
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGOFb5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 01:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOFb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:31:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4F79EE5
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:55 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENcYRu000829
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:55 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3haktc594a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:55 -0700
Received: from twshared35153.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 22:31:52 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 682E41C5C58EE; Thu, 14 Jul 2022 22:31:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/4] bpf: fix potential 32-bit overflow when accessing ARRAY map element
Date:   Thu, 14 Jul 2022 22:31:43 -0700
Message-ID: <20220715053146.1291891-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220715053146.1291891-1-andrii@kernel.org>
References: <20220715053146.1291891-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CGAo_rkIMojaXNsVmmsyFDKvi85jOyAN
X-Proofpoint-ORIG-GUID: CGAo_rkIMojaXNsVmmsyFDKvi85jOyAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BPF array map is bigger than 4GB, element pointer calculation can
overflow because both index and elem_size are u32. Fix this everywhere
by forcing 64-bit multiplication. Extract this formula into separate
small helper and use it consistently in various places.

Speculative-preventing formula utilizing index_mask trick is left as is,
but explicit u64 casts are added in both places.

Fixes: c85d69135a91 ("bpf: move memory size checks to bpf_map_charge_init()")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/arraymap.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index fe40d3b9458f..1d05d63e6fa5 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -156,6 +156,11 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
 	return &array->map;
 }
 
+static void *array_map_elem_ptr(struct bpf_array* array, u32 index)
+{
+	return array->value + (u64)array->elem_size * index;
+}
+
 /* Called from syscall or from eBPF program */
 static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 {
@@ -165,7 +170,7 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	if (unlikely(index >= array->map.max_entries))
 		return NULL;
 
-	return array->value + array->elem_size * (index & array->index_mask);
+	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
 static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
@@ -339,7 +344,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		       value, map->value_size);
 	} else {
 		val = array->value +
-			array->elem_size * (index & array->index_mask);
+			(u64)array->elem_size * (index & array->index_mask);
 		if (map_flags & BPF_F_LOCK)
 			copy_map_value_locked(map, val, value, false);
 		else
@@ -408,8 +413,7 @@ static void array_map_free_timers(struct bpf_map *map)
 		return;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		bpf_timer_cancel_and_free(array->value + array->elem_size * i +
-					  map->timer_off);
+		bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
@@ -420,7 +424,7 @@ static void array_map_free(struct bpf_map *map)
 
 	if (map_value_has_kptrs(map)) {
 		for (i = 0; i < array->map.max_entries; i++)
-			bpf_map_free_kptrs(map, array->value + array->elem_size * i);
+			bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
 		bpf_map_free_kptr_off_tab(map);
 	}
 
@@ -556,7 +560,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -575,7 +579,7 @@ static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
 	       return array->pptrs[index];
-	return array->value + array->elem_size * index;
+	return array_map_elem_ptr(array, index);
 }
 
 static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
@@ -690,7 +694,7 @@ static int bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_
 		if (is_percpu)
 			val = this_cpu_ptr(array->pptrs[i]);
 		else
-			val = array->value + array->elem_size * i;
+			val = array_map_elem_ptr(array, i);
 		num_elems++;
 		key = i;
 		ret = callback_fn((u64)(long)map, (u64)(long)&key,
-- 
2.30.2

