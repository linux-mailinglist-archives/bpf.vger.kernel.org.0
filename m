Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13FA41B494
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhI1Q6V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:58:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11002 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241939AbhI1Q6R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:58:17 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SFYIY2009517
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bc5t58pch-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:37 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:56:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3304F50F9D04; Tue, 28 Sep 2021 09:20:46 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 04/10] selftests/bpf: normalize all the rest SEC() uses
Date:   Tue, 28 Sep 2021 09:19:40 -0700
Message-ID: <20210928161946.2512801-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928161946.2512801-1-andrii@kernel.org>
References: <20210928161946.2512801-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 3IgNF0lD5oObHUbJbkiO_q8Y8A0c-t9a
X-Proofpoint-ORIG-GUID: 3IgNF0lD5oObHUbJbkiO_q8Y8A0c-t9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Normalize all the other non-conforming SEC() usages across all
selftests. This is in preparation for libbpf to start to enforce
stricter SEC() rules in libbpf 1.0 mode.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/flow_dissector.c |  4 +--
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 30 +++++++++----------
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  3 +-
 .../bpf/progs/cg_storage_multi_isolated.c     |  4 +--
 .../bpf/progs/cg_storage_multi_shared.c       |  4 +--
 .../selftests/bpf/progs/sockopt_multi.c       |  5 ++--
 .../selftests/bpf/progs/test_cgroup_link.c    |  4 +--
 .../bpf/progs/test_misc_tcp_hdr_options.c     |  2 +-
 .../selftests/bpf/progs/test_sk_lookup.c      |  6 ++--
 .../selftests/bpf/progs/test_sockmap_listen.c |  2 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |  2 +-
 .../bpf/progs/test_tcp_hdr_options.c          |  2 +-
 12 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 225714f71ac6..ac54e3f91d42 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -458,9 +458,9 @@ static int init_prog_array(struct bpf_object *obj, struct bpf_map *prog_array)
 		return -1;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
-		snprintf(prog_name, sizeof(prog_name), "flow_dissector/%i", i);
+		snprintf(prog_name, sizeof(prog_name), "flow_dissector_%d", i);
 
-		prog = bpf_object__find_program_by_title(obj, prog_name);
+		prog = bpf_object__find_program_by_name(obj, prog_name);
 		if (!prog)
 			return -1;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
index 51fac975b316..bc34f7773444 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
-static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
+static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title, const char *name)
 {
 	enum bpf_attach_type attach_type;
 	enum bpf_prog_type prog_type;
@@ -15,23 +15,23 @@ static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
 		return -1;
 	}
 
-	prog = bpf_object__find_program_by_title(obj, title);
+	prog = bpf_object__find_program_by_name(obj, name);
 	if (!prog) {
-		log_err("Failed to find %s BPF program", title);
+		log_err("Failed to find %s BPF program", name);
 		return -1;
 	}
 
 	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
 			      attach_type, BPF_F_ALLOW_MULTI);
 	if (err) {
-		log_err("Failed to attach %s BPF program", title);
+		log_err("Failed to attach %s BPF program", name);
 		return -1;
 	}
 
 	return 0;
 }
 
-static int prog_detach(struct bpf_object *obj, int cgroup_fd, const char *title)
+static int prog_detach(struct bpf_object *obj, int cgroup_fd, const char *title, const char *name)
 {
 	enum bpf_attach_type attach_type;
 	enum bpf_prog_type prog_type;
@@ -42,7 +42,7 @@ static int prog_detach(struct bpf_object *obj, int cgroup_fd, const char *title)
 	if (err)
 		return -1;
 
-	prog = bpf_object__find_program_by_title(obj, title);
+	prog = bpf_object__find_program_by_name(obj, name);
 	if (!prog)
 		return -1;
 
@@ -89,7 +89,7 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	 * - child:  0x80 -> 0x90
 	 */
 
-	err = prog_attach(obj, cg_child, "cgroup/getsockopt/child");
+	err = prog_attach(obj, cg_child, "cgroup/getsockopt", "_getsockopt_child");
 	if (err)
 		goto detach;
 
@@ -113,7 +113,7 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	 * - parent: 0x90 -> 0xA0
 	 */
 
-	err = prog_attach(obj, cg_parent, "cgroup/getsockopt/parent");
+	err = prog_attach(obj, cg_parent, "cgroup/getsockopt", "_getsockopt_parent");
 	if (err)
 		goto detach;
 
@@ -157,7 +157,7 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	 * - parent: unexpected 0x40, EPERM
 	 */
 
-	err = prog_detach(obj, cg_child, "cgroup/getsockopt/child");
+	err = prog_detach(obj, cg_child, "cgroup/getsockopt", "_getsockopt_child");
 	if (err) {
 		log_err("Failed to detach child program");
 		goto detach;
@@ -198,8 +198,8 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	}
 
 detach:
-	prog_detach(obj, cg_child, "cgroup/getsockopt/child");
-	prog_detach(obj, cg_parent, "cgroup/getsockopt/parent");
+	prog_detach(obj, cg_child, "cgroup/getsockopt", "_getsockopt_child");
+	prog_detach(obj, cg_parent, "cgroup/getsockopt", "_getsockopt_parent");
 
 	return err;
 }
@@ -236,7 +236,7 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 
 	/* Attach child program and make sure it adds 0x10. */
 
-	err = prog_attach(obj, cg_child, "cgroup/setsockopt");
+	err = prog_attach(obj, cg_child, "cgroup/setsockopt", "_setsockopt");
 	if (err)
 		goto detach;
 
@@ -263,7 +263,7 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 
 	/* Attach parent program and make sure it adds another 0x10. */
 
-	err = prog_attach(obj, cg_parent, "cgroup/setsockopt");
+	err = prog_attach(obj, cg_parent, "cgroup/setsockopt", "_setsockopt");
 	if (err)
 		goto detach;
 
@@ -289,8 +289,8 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 	}
 
 detach:
-	prog_detach(obj, cg_child, "cgroup/setsockopt");
-	prog_detach(obj, cg_parent, "cgroup/setsockopt");
+	prog_detach(obj, cg_child, "cgroup/setsockopt", "_setsockopt");
+	prog_detach(obj, cg_parent, "cgroup/setsockopt", "_setsockopt");
 
 	return err;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index 95a5a0778ed7..f266c757b3df 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -19,9 +19,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-int _version SEC("version") = 1;
 #define PROG(F) PROG_(F, _##F)
-#define PROG_(NUM, NAME) SEC("flow_dissector/"#NUM) int bpf_func##NAME
+#define PROG_(NUM, NAME) SEC("flow_dissector") int flow_dissector_##NUM
 
 /* These are the identifiers of the BPF programs that will be used in tail
  * calls. Name is limited to 16 characters, with the terminating character and
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
index a25373002055..3f81ff92184c 100644
--- a/tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_isolated.c
@@ -20,7 +20,7 @@ struct {
 
 __u32 invocations = 0;
 
-SEC("cgroup_skb/egress/1")
+SEC("cgroup_skb/egress")
 int egress1(struct __sk_buff *skb)
 {
 	struct cgroup_value *ptr_cg_storage =
@@ -32,7 +32,7 @@ int egress1(struct __sk_buff *skb)
 	return 1;
 }
 
-SEC("cgroup_skb/egress/2")
+SEC("cgroup_skb/egress")
 int egress2(struct __sk_buff *skb)
 {
 	struct cgroup_value *ptr_cg_storage =
diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c b/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c
index a149f33bc533..d662db27fe4a 100644
--- a/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi_shared.c
@@ -20,7 +20,7 @@ struct {
 
 __u32 invocations = 0;
 
-SEC("cgroup_skb/egress/1")
+SEC("cgroup_skb/egress")
 int egress1(struct __sk_buff *skb)
 {
 	struct cgroup_value *ptr_cg_storage =
@@ -32,7 +32,7 @@ int egress1(struct __sk_buff *skb)
 	return 1;
 }
 
-SEC("cgroup_skb/egress/2")
+SEC("cgroup_skb/egress")
 int egress2(struct __sk_buff *skb)
 {
 	struct cgroup_value *ptr_cg_storage =
diff --git a/tools/testing/selftests/bpf/progs/sockopt_multi.c b/tools/testing/selftests/bpf/progs/sockopt_multi.c
index 9d8c212dde9f..177a59069dae 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_multi.c
@@ -4,9 +4,8 @@
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
-__u32 _version SEC("version") = 1;
 
-SEC("cgroup/getsockopt/child")
+SEC("cgroup/getsockopt")
 int _getsockopt_child(struct bpf_sockopt *ctx)
 {
 	__u8 *optval_end = ctx->optval_end;
@@ -29,7 +28,7 @@ int _getsockopt_child(struct bpf_sockopt *ctx)
 	return 1;
 }
 
-SEC("cgroup/getsockopt/parent")
+SEC("cgroup/getsockopt")
 int _getsockopt_parent(struct bpf_sockopt *ctx)
 {
 	__u8 *optval_end = ctx->optval_end;
diff --git a/tools/testing/selftests/bpf/progs/test_cgroup_link.c b/tools/testing/selftests/bpf/progs/test_cgroup_link.c
index 77e47b9e4446..4faba88e45a5 100644
--- a/tools/testing/selftests/bpf/progs/test_cgroup_link.c
+++ b/tools/testing/selftests/bpf/progs/test_cgroup_link.c
@@ -6,14 +6,14 @@
 int calls = 0;
 int alt_calls = 0;
 
-SEC("cgroup_skb/egress1")
+SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
 	__sync_fetch_and_add(&calls, 1);
 	return 1;
 }
 
-SEC("cgroup_skb/egress2")
+SEC("cgroup_skb/egress")
 int egress_alt(struct __sk_buff *skb)
 {
 	__sync_fetch_and_add(&alt_calls, 1);
diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
index 6077a025092c..2c121c5d66a7 100644
--- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
@@ -293,7 +293,7 @@ static int handle_passive_estab(struct bpf_sock_ops *skops)
 	return check_active_hdr_in(skops);
 }
 
-SEC("sockops/misc_estab")
+SEC("sockops")
 int misc_estab(struct bpf_sock_ops *skops)
 {
 	int true_val = 1;
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index ac6f7f205e25..6c4d32c56765 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -84,13 +84,13 @@ int lookup_drop(struct bpf_sk_lookup *ctx)
 	return SK_DROP;
 }
 
-SEC("sk_reuseport/reuse_pass")
+SEC("sk_reuseport")
 int reuseport_pass(struct sk_reuseport_md *ctx)
 {
 	return SK_PASS;
 }
 
-SEC("sk_reuseport/reuse_drop")
+SEC("sk_reuseport")
 int reuseport_drop(struct sk_reuseport_md *ctx)
 {
 	return SK_DROP;
@@ -194,7 +194,7 @@ int select_sock_a_no_reuseport(struct bpf_sk_lookup *ctx)
 	return err ? SK_DROP : SK_PASS;
 }
 
-SEC("sk_reuseport/select_sock_b")
+SEC("sk_reuseport")
 int select_sock_b(struct sk_reuseport_md *ctx)
 {
 	__u32 key = KEY_SERVER_B;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
index a1cc58b10c7c..00f1456aaeda 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_listen.c
@@ -56,7 +56,7 @@ int prog_stream_verdict(struct __sk_buff *skb)
 	return verdict;
 }
 
-SEC("sk_skb/skb_verdict")
+SEC("sk_skb")
 int prog_skb_verdict(struct __sk_buff *skb)
 {
 	unsigned int *count;
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c b/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
index 2d31f66e4f23..3c69aa971738 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_skb_verdict_attach.c
@@ -9,7 +9,7 @@ struct {
 	__type(value, __u64);
 } sock_map SEC(".maps");
 
-SEC("sk_skb/skb_verdict")
+SEC("sk_skb")
 int prog_skb_verdict(struct __sk_buff *skb)
 {
 	return SK_DROP;
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
index 678bd0fad29e..5f4e87ee949a 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c
@@ -594,7 +594,7 @@ static int handle_parse_hdr(struct bpf_sock_ops *skops)
 	return CG_OK;
 }
 
-SEC("sockops/estab")
+SEC("sockops")
 int estab(struct bpf_sock_ops *skops)
 {
 	int true_val = 1;
-- 
2.30.2

