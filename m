Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB941516F
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhIVUeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Sep 2021 16:34:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29832 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237309AbhIVUeH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:34:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MIlSm5003616
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q5br02y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:32:36 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 13:32:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C617A4B04ECA; Wed, 22 Sep 2021 13:32:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kafai@fb.com>, <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC bpf-next 3/4] selftests/bpf: implement custom Bloom filter purely in BPF
Date:   Wed, 22 Sep 2021 13:32:23 -0700
Message-ID: <20210922203224.912809-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922203224.912809-1-andrii@kernel.org>
References: <20210922203224.912809-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: kqBTFsT_bb6c4lPOpzDZPyVVO6vMy0JF
X-Proofpoint-GUID: kqBTFsT_bb6c4lPOpzDZPyVVO6vMy0JF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_08,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=905
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

And integrate it into existing benchmarks (on BPF side). Posting this
separately from user-space benchmark to emphasize how little code is
necessary on BPF side to make this work.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/progs/bloom_filter_map.c    | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_map.c b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
index 3ae2f9bb5968..ee7bbde1af45 100644
--- a/tools/testing/selftests/bpf/progs/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
@@ -64,9 +64,43 @@ const __u32 drop_key  = 1;
 const __u32 false_hit_key = 2;
 
 const volatile bool hashmap_use_bloom_filter = true;
+const volatile bool hashmap_use_custom_bloom_filter = false;
+
+
+__u64 bloom_val = 0;
+static __u64 bloom_arr[256 * 1024]; /* enough for 1mln max_elems w/ 10 hash funcs */
+const volatile __u32 bloom_mask;
+const volatile __u32 bloom_hash_cnt;
+const volatile __u32 bloom_seed;
 
 int error = 0;
 
+static void bloom_add(const void *data, __u32 sz)
+{
+	__u32 i = 0, h;
+
+	for (i = 0; i < bloom_hash_cnt; i++) {
+		h = bpf_jhash_mem(data, sz, bloom_seed + i);
+		__sync_fetch_and_or(&bloom_arr[(h / 64) & bloom_mask], 1ULL << (h % 64));
+	}
+}
+
+bool bloom_contains(__u64 val)
+{
+	__u32 i = 0, h;
+	__u32 seed = bloom_seed, msk = bloom_mask;
+	__u64 v, *arr = bloom_arr;
+
+	for (i = bloom_hash_cnt; i > 0; i--) {
+		h = bpf_jhash_mem(&val, sizeof(val), seed);
+		v = arr[(h / 64) & msk];
+		if (!((v >> (h % 64)) & 1))
+			return false;
+		seed++;
+	}
+	return true;
+}
+
 static __always_inline void log_result(__u32 key, __u32 val)
 {
 	__u32 cpu = bpf_get_smp_processor_id();
@@ -99,6 +133,20 @@ check_elem(struct bpf_map *map, __u32 *key, __u64 *val,
 	return 0;
 }
 
+static __u64
+check_elem_custom(struct bpf_map *map, __u32 *key, __u64 *val,
+	   struct callback_ctx *data)
+{
+	if (!bloom_contains(*val)) {
+		error |= 1;
+		return 1; /* stop the iteration */
+	}
+
+	log_result(hit_key, 1);
+
+	return 0;
+}
+
 SEC("fentry/__x64_sys_getpgid")
 int prog_bloom_filter(void *ctx)
 {
@@ -110,6 +158,26 @@ int prog_bloom_filter(void *ctx)
 	return 0;
 }
 
+SEC("fentry/__x64_sys_getpgid")
+int prog_custom_bloom_filter(void *ctx)
+{
+	bpf_for_each_map_elem(&map_random_data, check_elem_custom, NULL, 0);
+
+	return 0;
+}
+
+__u32 bloom_err = 0;
+__u32 bloom_custom_hit = 0;
+__u32 bloom_noncustom_hit = 0;
+
+SEC("fentry/__x64_sys_getpgid")
+int prog_custom_bloom_filter_add(void *ctx)
+{
+	bloom_add(&bloom_val, sizeof(bloom_val));
+
+	return 0;
+}
+
 SEC("fentry/__x64_sys_getpgid")
 int prog_bloom_filter_inner_map(void *ctx)
 {
@@ -145,6 +213,15 @@ int prog_bloom_filter_hashmap_lookup(void *ctx)
 		val.data32[0] = /*i; */ bpf_get_prandom_u32();
 		val.data32[1] = /*i + 1;*/ bpf_get_prandom_u32();
 
+		if (hashmap_use_custom_bloom_filter)
+		{
+			if (!bloom_contains(val.data64)) {
+				hits++;
+				//custom_hit = true;
+				//__sync_fetch_and_add(&bloom_custom_hit, 1);
+				continue;
+			}
+		} 
 		if (hashmap_use_bloom_filter)
 		{
 			err = bpf_map_peek_elem(&map_bloom_filter, &val);
@@ -160,11 +237,13 @@ int prog_bloom_filter_hashmap_lookup(void *ctx)
 			}
 		}
 
+		//bloom_err += (custom_hit != noncustom_hit);
+
 		result = bpf_map_lookup_elem(&hashmap, &val);
 		if (result) {
 			hits++;
 		} else {
-			if (hashmap_use_bloom_filter)
+			if (hashmap_use_custom_bloom_filter || hashmap_use_bloom_filter)
 				false_hits++;
 			drops++;
 		}
-- 
2.30.2

