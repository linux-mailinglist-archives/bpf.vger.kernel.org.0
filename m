Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE49575B01
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiGOFcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 01:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOFb7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:31:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2279EE5
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:58 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ENcXD4026829
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hat59t7c0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:31:58 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 22:31:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 769831C5C58F4; Thu, 14 Jul 2022 22:31:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/4] bpf: make uniform use of array->elem_size everywhere in arraymap.c
Date:   Thu, 14 Jul 2022 22:31:44 -0700
Message-ID: <20220715053146.1291891-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220715053146.1291891-1-andrii@kernel.org>
References: <20220715053146.1291891-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mc8N_pHaiOIDI7-8rOEnmsw70mxu1t5e
X-Proofpoint-ORIG-GUID: mc8N_pHaiOIDI7-8rOEnmsw70mxu1t5e
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

BPF_MAP_TYPE_ARRAY is rounding value_size to closest multiple of 8 and
stores that as array->elem_size for various memory allocations and
accesses.

But the code tends to re-calculate round_up(map->value_size, 8) in
multiple places instead of using array->elem_size. Cleaning this up and
making sure we always use array->size to avoid duplication of this
(admittedly simple) logic for consistency.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/arraymap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1d05d63e6fa5..98ee09155151 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -208,7 +208,7 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	struct bpf_insn *insn = insn_buf;
-	u32 elem_size = round_up(map->value_size, 8);
+	u32 elem_size = array->elem_size;
 	const int ret = BPF_REG_0;
 	const int map_ptr = BPF_REG_1;
 	const int index = BPF_REG_2;
@@ -277,7 +277,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
 	 */
-	size = round_up(map->value_size, 8);
+	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
@@ -381,7 +381,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	 * returned or zeros which were zero-filled by percpu_alloc,
 	 * so no kernel data leaks possible
 	 */
-	size = round_up(map->value_size, 8);
+	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
@@ -587,6 +587,7 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_seq_array_map_info *info = seq->private;
 	struct bpf_iter__bpf_map_elem ctx = {};
 	struct bpf_map *map = info->map;
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int off = 0, cpu = 0;
@@ -607,7 +608,7 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 			ctx.value = v;
 		} else {
 			pptr = v;
-			size = round_up(map->value_size, 8);
+			size = array->elem_size;
 			for_each_possible_cpu(cpu) {
 				bpf_long_memcpy(info->percpu_value_buf + off,
 						per_cpu_ptr(pptr, cpu),
@@ -637,11 +638,12 @@ static int bpf_iter_init_array_map(void *priv_data,
 {
 	struct bpf_iter_seq_array_map_info *seq_info = priv_data;
 	struct bpf_map *map = aux->map;
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	void *value_buf;
 	u32 buf_size;
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		buf_size = round_up(map->value_size, 8) * num_possible_cpus();
+		buf_size = array->elem_size * num_possible_cpus();
 		value_buf = kmalloc(buf_size, GFP_USER | __GFP_NOWARN);
 		if (!value_buf)
 			return -ENOMEM;
@@ -1326,7 +1328,7 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 				   struct bpf_insn *insn_buf)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
-	u32 elem_size = round_up(map->value_size, 8);
+	u32 elem_size = array->elem_size;
 	struct bpf_insn *insn = insn_buf;
 	const int ret = BPF_REG_0;
 	const int map_ptr = BPF_REG_1;
-- 
2.30.2

