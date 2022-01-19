Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA9B494354
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357621AbiASW6D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 19 Jan 2022 17:58:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357650AbiASW57 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 17:57:59 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs7cQ000616
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:57:58 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp89yf2xq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:57:58 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 14:57:57 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DE5ACFB338A7; Wed, 19 Jan 2022 14:57:51 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: convert remaining legacy map definitions
Date:   Wed, 19 Jan 2022 14:57:39 -0800
Message-ID: <20220119225741.2944240-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119225741.2944240-1-andrii@kernel.org>
References: <20220119225741.2944240-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JjfhxXV6bSuGdRPlhzNviNr8HvCLg3zo
X-Proofpoint-GUID: JjfhxXV6bSuGdRPlhzNviNr8HvCLg3zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201190122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Converted few remaining legacy BPF map definition to BTF-defined ones.
For the remaining two bpf_map_def-based legacy definitions that we want
to keep for testing purposes until libbpf 1.0 release, guard them in
pragma to suppres deprecation warnings which will be added in libbpf in
the next commit.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/freplace_cls_redirect.c         | 12 +++++-----
 .../selftests/bpf/progs/sample_map_ret0.c     | 24 +++++++++----------
 .../selftests/bpf/progs/test_btf_haskv.c      |  3 +++
 .../selftests/bpf/progs/test_btf_newkv.c      |  3 +++
 .../selftests/bpf/progs/test_btf_nokv.c       | 12 +++++-----
 .../bpf/progs/test_skb_cgroup_id_kern.c       | 12 +++++-----
 .../testing/selftests/bpf/progs/test_tc_edt.c | 12 +++++-----
 .../bpf/progs/test_tcp_check_syncookie_kern.c | 12 +++++-----
 8 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c b/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
index 68a5a9db928a..7e94412d47a5 100644
--- a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
@@ -7,12 +7,12 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 
-struct bpf_map_def SEC("maps") sock_map = {
-	.type = BPF_MAP_TYPE_SOCKMAP,
-	.key_size = sizeof(int),
-	.value_size = sizeof(int),
-	.max_entries = 2,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 2);
+} sock_map SEC(".maps");
 
 SEC("freplace/cls_redirect")
 int freplace_cls_redirect_test(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/sample_map_ret0.c b/tools/testing/selftests/bpf/progs/sample_map_ret0.c
index 1612a32007b6..495990d355ef 100644
--- a/tools/testing/selftests/bpf/progs/sample_map_ret0.c
+++ b/tools/testing/selftests/bpf/progs/sample_map_ret0.c
@@ -2,19 +2,19 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-struct bpf_map_def SEC("maps") htab = {
-	.type = BPF_MAP_TYPE_HASH,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(long),
-	.max_entries = 2,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, long);
+	__uint(max_entries, 2);
+} htab SEC(".maps");
 
-struct bpf_map_def SEC("maps") array = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(long),
-	.max_entries = 2,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, long);
+	__uint(max_entries, 2);
+} array SEC(".maps");
 
 /* Sample program which should always load for testing control paths. */
 SEC(".text") int func()
diff --git a/tools/testing/selftests/bpf/progs/test_btf_haskv.c b/tools/testing/selftests/bpf/progs/test_btf_haskv.c
index 160ead6c67b2..07c94df13660 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_haskv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_haskv.c
@@ -9,12 +9,15 @@ struct ipv_counts {
 	unsigned int v6;
 };
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 struct bpf_map_def SEC("maps") btf_map = {
 	.type = BPF_MAP_TYPE_ARRAY,
 	.key_size = sizeof(int),
 	.value_size = sizeof(struct ipv_counts),
 	.max_entries = 4,
 };
+#pragma GCC diagnostic pop
 
 BPF_ANNOTATE_KV_PAIR(btf_map, int, struct ipv_counts);
 
diff --git a/tools/testing/selftests/bpf/progs/test_btf_newkv.c b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
index 1884a5bd10f5..762671a2e90c 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_newkv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_newkv.c
@@ -9,6 +9,8 @@ struct ipv_counts {
 	unsigned int v6;
 };
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 /* just to validate we can handle maps in multiple sections */
 struct bpf_map_def SEC("maps") btf_map_legacy = {
 	.type = BPF_MAP_TYPE_ARRAY,
@@ -16,6 +18,7 @@ struct bpf_map_def SEC("maps") btf_map_legacy = {
 	.value_size = sizeof(long long),
 	.max_entries = 4,
 };
+#pragma GCC diagnostic pop
 
 BPF_ANNOTATE_KV_PAIR(btf_map_legacy, int, struct ipv_counts);
 
diff --git a/tools/testing/selftests/bpf/progs/test_btf_nokv.c b/tools/testing/selftests/bpf/progs/test_btf_nokv.c
index 15e0f9945fe4..1dabb88f8cb4 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_nokv.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_nokv.c
@@ -8,12 +8,12 @@ struct ipv_counts {
 	unsigned int v6;
 };
 
-struct bpf_map_def SEC("maps") btf_map = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(struct ipv_counts),
-	.max_entries = 4,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(struct ipv_counts));
+	__uint(max_entries, 4);
+} btf_map SEC(".maps");
 
 __attribute__((noinline))
 int test_long_fname_2(void)
diff --git a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c b/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
index c304cd5b8cad..37aacc66cd68 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
@@ -10,12 +10,12 @@
 
 #define NUM_CGROUP_LEVELS	4
 
-struct bpf_map_def SEC("maps") cgroup_ids = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(__u64),
-	.max_entries = NUM_CGROUP_LEVELS,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u64);
+	__uint(max_entries, NUM_CGROUP_LEVELS);
+} cgroup_ids SEC(".maps");
 
 static __always_inline void log_nth_level(struct __sk_buff *skb, __u32 level)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
index bf28814bfde5..950a70b61e74 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_edt.c
@@ -17,12 +17,12 @@
 #define THROTTLE_RATE_BPS (5 * 1000 * 1000)
 
 /* flow_key => last_tstamp timestamp used */
-struct bpf_map_def SEC("maps") flow_map = {
-	.type = BPF_MAP_TYPE_HASH,
-	.key_size = sizeof(uint32_t),
-	.value_size = sizeof(uint64_t),
-	.max_entries = 1,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, uint32_t);
+	__type(value, uint64_t);
+	__uint(max_entries, 1);
+} flow_map SEC(".maps");
 
 static inline int throttle_flow(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
index cd747cd93dbe..6edebce563b5 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
@@ -16,12 +16,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-struct bpf_map_def SEC("maps") results = {
-	.type = BPF_MAP_TYPE_ARRAY,
-	.key_size = sizeof(__u32),
-	.value_size = sizeof(__u32),
-	.max_entries = 3,
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 3);
+} results SEC(".maps");
 
 static __always_inline __s64 gen_syncookie(void *data_end, struct bpf_sock *sk,
 					   void *iph, __u32 ip_size,
-- 
2.30.2

