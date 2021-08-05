Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814753E1F2B
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhHEXH7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 5 Aug 2021 19:07:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232896AbhHEXH7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Aug 2021 19:07:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175N1V6d019235
        for <bpf@vger.kernel.org>; Thu, 5 Aug 2021 16:07:44 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a8jhftpq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Aug 2021 16:07:44 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 16:07:43 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 46F573D405B3; Thu,  5 Aug 2021 16:07:36 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: rename reference_tracking BPF programs
Date:   Thu, 5 Aug 2021 16:07:34 -0700
Message-ID: <20210805230734.437914-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: U8JgzTq6QDkJKVnyl4R86l1WaPczdj9k
X-Proofpoint-ORIG-GUID: U8JgzTq6QDkJKVnyl4R86l1WaPczdj9k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_11:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=912 adultscore=0 suspectscore=0 phishscore=0 clxscore=1034
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF programs for reference_tracking selftest use "fail_" prefix to notify that
they are expected to fail. This is really confusing and inconvenient when
trying to grep through test_progs output to find *actually* failed tests. So
rename the prefix from "fail_" to "err_".

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reference_tracking.c  |  4 ++--
 .../selftests/bpf/progs/test_sk_lookup_kern.c      | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index de2688166696..4e91f4d6466c 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -34,8 +34,8 @@ void test_reference_tracking(void)
 		if (!test__start_subtest(title))
 			continue;
 
-		/* Expect verifier failure if test name has 'fail' */
-		if (strstr(title, "fail") != NULL) {
+		/* Expect verifier failure if test name has 'err' */
+		if (strstr(title, "err_") != NULL) {
 			libbpf_print_fn_t old_print_fn;
 
 			old_print_fn = libbpf_set_print(NULL);
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
index e83d0b48d80c..8249075f088f 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
@@ -91,7 +91,7 @@ int bpf_sk_lookup_test1(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/fail_use_after_free")
+SEC("classifier/err_use_after_free")
 int bpf_sk_lookup_uaf(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -106,7 +106,7 @@ int bpf_sk_lookup_uaf(struct __sk_buff *skb)
 	return family;
 }
 
-SEC("classifier/fail_modify_sk_pointer")
+SEC("classifier/err_modify_sk_pointer")
 int bpf_sk_lookup_modptr(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -121,7 +121,7 @@ int bpf_sk_lookup_modptr(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/fail_modify_sk_or_null_pointer")
+SEC("classifier/err_modify_sk_or_null_pointer")
 int bpf_sk_lookup_modptr_or_null(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -135,7 +135,7 @@ int bpf_sk_lookup_modptr_or_null(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/fail_no_release")
+SEC("classifier/err_no_release")
 int bpf_sk_lookup_test2(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -144,7 +144,7 @@ int bpf_sk_lookup_test2(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/fail_release_twice")
+SEC("classifier/err_release_twice")
 int bpf_sk_lookup_test3(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -156,7 +156,7 @@ int bpf_sk_lookup_test3(struct __sk_buff *skb)
 	return 0;
 }
 
-SEC("classifier/fail_release_unchecked")
+SEC("classifier/err_release_unchecked")
 int bpf_sk_lookup_test4(struct __sk_buff *skb)
 {
 	struct bpf_sock_tuple tuple = {};
@@ -173,7 +173,7 @@ void lookup_no_release(struct __sk_buff *skb)
 	bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple), BPF_F_CURRENT_NETNS, 0);
 }
 
-SEC("classifier/fail_no_release_subcall")
+SEC("classifier/err_no_release_subcall")
 int bpf_sk_lookup_test5(struct __sk_buff *skb)
 {
 	lookup_no_release(skb);
-- 
2.30.2

