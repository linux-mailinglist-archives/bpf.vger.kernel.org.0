Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5062B40F1EE
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhIQGMO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 17 Sep 2021 02:12:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244731AbhIQGMO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 02:12:14 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H4Y1Bl010539
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 23:10:52 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4m3srd2s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 23:10:52 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 23:10:51 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 20C284393018; Thu, 16 Sep 2021 23:10:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 9/9] selftests/bpf: switch sk_lookup selftests to strict SEC("sk_lookup") use
Date:   Thu, 16 Sep 2021 23:10:20 -0700
Message-ID: <20210917061020.821711-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917061020.821711-1-andrii@kernel.org>
References: <20210917061020.821711-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: MubnnqBKIbs0De3FOnKsHHTfjqLc2LPz
X-Proofpoint-GUID: MubnnqBKIbs0De3FOnKsHHTfjqLc2LPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_03,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update "sk_lookup/" definition to be a stand-alone type specifier,
with backwards-compatible prefix match logic in non-libbpf-1.0 mode.

Currently in selftests all the "sk_lookup/<whatever>" uses just use
<whatever> for duplicated unique name encoding, which is redundant as
BPF program's name (C function name) uniquely and descriptively
identifies the intended use for such BPF programs.

With libbpf's SEC_DEF("sk_lookup") definition updated, switch existing
sk_lookup programs to use "unqualified" SEC("sk_lookup") section names,
with no random text after it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c                        |  2 +-
 .../selftests/bpf/progs/test_sk_lookup.c      | 38 +++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f0846f609e26..8c70f02a4666 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8042,7 +8042,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
-	SEC_DEF("sk_lookup/",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
+	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 };
 
 #define MAX_TYPE_NAME_SIZE 32
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index 6c4d32c56765..48534d810391 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -72,13 +72,13 @@ static const __u16 DST_PORT = 7007; /* Host byte order */
 static const __u32 DST_IP4 = IP4(127, 0, 0, 1);
 static const __u32 DST_IP6[] = IP6(0xfd000000, 0x0, 0x0, 0x00000001);
 
-SEC("sk_lookup/lookup_pass")
+SEC("sk_lookup")
 int lookup_pass(struct bpf_sk_lookup *ctx)
 {
 	return SK_PASS;
 }
 
-SEC("sk_lookup/lookup_drop")
+SEC("sk_lookup")
 int lookup_drop(struct bpf_sk_lookup *ctx)
 {
 	return SK_DROP;
@@ -97,7 +97,7 @@ int reuseport_drop(struct sk_reuseport_md *ctx)
 }
 
 /* Redirect packets destined for port DST_PORT to socket at redir_map[0]. */
-SEC("sk_lookup/redir_port")
+SEC("sk_lookup")
 int redir_port(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -116,7 +116,7 @@ int redir_port(struct bpf_sk_lookup *ctx)
 }
 
 /* Redirect packets destined for DST_IP4 address to socket at redir_map[0]. */
-SEC("sk_lookup/redir_ip4")
+SEC("sk_lookup")
 int redir_ip4(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -139,7 +139,7 @@ int redir_ip4(struct bpf_sk_lookup *ctx)
 }
 
 /* Redirect packets destined for DST_IP6 address to socket at redir_map[0]. */
-SEC("sk_lookup/redir_ip6")
+SEC("sk_lookup")
 int redir_ip6(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -164,7 +164,7 @@ int redir_ip6(struct bpf_sk_lookup *ctx)
 	return err ? SK_DROP : SK_PASS;
 }
 
-SEC("sk_lookup/select_sock_a")
+SEC("sk_lookup")
 int select_sock_a(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -179,7 +179,7 @@ int select_sock_a(struct bpf_sk_lookup *ctx)
 	return err ? SK_DROP : SK_PASS;
 }
 
-SEC("sk_lookup/select_sock_a_no_reuseport")
+SEC("sk_lookup")
 int select_sock_a_no_reuseport(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -205,7 +205,7 @@ int select_sock_b(struct sk_reuseport_md *ctx)
 }
 
 /* Check that bpf_sk_assign() returns -EEXIST if socket already selected. */
-SEC("sk_lookup/sk_assign_eexist")
+SEC("sk_lookup")
 int sk_assign_eexist(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -238,7 +238,7 @@ int sk_assign_eexist(struct bpf_sk_lookup *ctx)
 }
 
 /* Check that bpf_sk_assign(BPF_SK_LOOKUP_F_REPLACE) can override selection. */
-SEC("sk_lookup/sk_assign_replace_flag")
+SEC("sk_lookup")
 int sk_assign_replace_flag(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -270,7 +270,7 @@ int sk_assign_replace_flag(struct bpf_sk_lookup *ctx)
 }
 
 /* Check that bpf_sk_assign(sk=NULL) is accepted. */
-SEC("sk_lookup/sk_assign_null")
+SEC("sk_lookup")
 int sk_assign_null(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk = NULL;
@@ -313,7 +313,7 @@ int sk_assign_null(struct bpf_sk_lookup *ctx)
 }
 
 /* Check that selected sk is accessible through context. */
-SEC("sk_lookup/access_ctx_sk")
+SEC("sk_lookup")
 int access_ctx_sk(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk1 = NULL, *sk2 = NULL;
@@ -379,7 +379,7 @@ int access_ctx_sk(struct bpf_sk_lookup *ctx)
  * are not covered because they give bogus results, that is the
  * verifier ignores the offset.
  */
-SEC("sk_lookup/ctx_narrow_access")
+SEC("sk_lookup")
 int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -553,7 +553,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 }
 
 /* Check that sk_assign rejects SERVER_A socket with -ESOCKNOSUPPORT */
-SEC("sk_lookup/sk_assign_esocknosupport")
+SEC("sk_lookup")
 int sk_assign_esocknosupport(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
@@ -578,28 +578,28 @@ int sk_assign_esocknosupport(struct bpf_sk_lookup *ctx)
 	return ret;
 }
 
-SEC("sk_lookup/multi_prog_pass1")
+SEC("sk_lookup")
 int multi_prog_pass1(struct bpf_sk_lookup *ctx)
 {
 	bpf_map_update_elem(&run_map, &KEY_PROG1, &PROG_DONE, BPF_ANY);
 	return SK_PASS;
 }
 
-SEC("sk_lookup/multi_prog_pass2")
+SEC("sk_lookup")
 int multi_prog_pass2(struct bpf_sk_lookup *ctx)
 {
 	bpf_map_update_elem(&run_map, &KEY_PROG2, &PROG_DONE, BPF_ANY);
 	return SK_PASS;
 }
 
-SEC("sk_lookup/multi_prog_drop1")
+SEC("sk_lookup")
 int multi_prog_drop1(struct bpf_sk_lookup *ctx)
 {
 	bpf_map_update_elem(&run_map, &KEY_PROG1, &PROG_DONE, BPF_ANY);
 	return SK_DROP;
 }
 
-SEC("sk_lookup/multi_prog_drop2")
+SEC("sk_lookup")
 int multi_prog_drop2(struct bpf_sk_lookup *ctx)
 {
 	bpf_map_update_elem(&run_map, &KEY_PROG2, &PROG_DONE, BPF_ANY);
@@ -623,7 +623,7 @@ static __always_inline int select_server_a(struct bpf_sk_lookup *ctx)
 	return SK_PASS;
 }
 
-SEC("sk_lookup/multi_prog_redir1")
+SEC("sk_lookup")
 int multi_prog_redir1(struct bpf_sk_lookup *ctx)
 {
 	int ret;
@@ -633,7 +633,7 @@ int multi_prog_redir1(struct bpf_sk_lookup *ctx)
 	return SK_PASS;
 }
 
-SEC("sk_lookup/multi_prog_redir2")
+SEC("sk_lookup")
 int multi_prog_redir2(struct bpf_sk_lookup *ctx)
 {
 	int ret;
-- 
2.30.2

