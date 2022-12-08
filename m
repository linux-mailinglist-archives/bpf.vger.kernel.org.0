Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759906475D3
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLHS5g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Dec 2022 13:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLHS5f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 13:57:35 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41919EA
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 10:57:32 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8IaLPl024987
        for <bpf@vger.kernel.org>; Thu, 8 Dec 2022 10:57:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3maqx7bwbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 10:57:31 -0800
Received: from twshared4568.42.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 10:57:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id EF8D4231D99B1; Thu,  8 Dec 2022 10:57:13 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        =?UTF-8?q?Per=20Sundstr=C3=B6m=20XP?= 
        <per.xp.sundstrom@ericsson.com>
Subject: [PATCH bpf-next 3/6] selftests/bpf: add non-standardly sized enum tests for btf_dump
Date:   Thu, 8 Dec 2022 10:57:00 -0800
Message-ID: <20221208185703.2681797-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221208185703.2681797-1-andrii@kernel.org>
References: <20221208185703.2681797-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lesp8iiRpjjwbhsI07_i_k2CkQiTQEpd
X-Proofpoint-ORIG-GUID: lesp8iiRpjjwbhsI07_i_k2CkQiTQEpd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_11,2022-12-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add few custom enum definitions testing mode(byte) and mode(word)
attributes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/btf_dump_test_case_syntax.c     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 4ee4748133fe..26fffb02ed10 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -25,6 +25,39 @@ typedef enum {
 	H = 2,
 } e3_t;
 
+/* ----- START-EXPECTED-OUTPUT ----- */
+/*
+ *enum e_byte {
+ *	EBYTE_1 = 0,
+ *	EBYTE_2 = 1,
+ *} __attribute__((mode(byte)));
+ *
+ */
+/* ----- END-EXPECTED-OUTPUT ----- */
+enum e_byte {
+	EBYTE_1,
+	EBYTE_2,
+} __attribute__((mode(byte)));
+
+/* ----- START-EXPECTED-OUTPUT ----- */
+/*
+ *enum e_word {
+ *	EWORD_1 = 0LL,
+ *	EWORD_2 = 1LL,
+ *} __attribute__((mode(word)));
+ *
+ */
+/* ----- END-EXPECTED-OUTPUT ----- */
+enum e_word {
+	EWORD_1,
+	EWORD_2,
+} __attribute__((mode(word))); /* force to use 8-byte backing for this enum */
+
+/* ----- START-EXPECTED-OUTPUT ----- */
+enum e_big {
+	EBIG_1 = 1000000000000ULL,
+};
+
 typedef int int_t;
 
 typedef volatile const int * volatile const crazy_ptr_t;
@@ -224,6 +257,9 @@ struct root_struct {
 	enum e2 _2;
 	e2_t _2_1;
 	e3_t _2_2;
+	enum e_byte _100;
+	enum e_word _101;
+	enum e_big _102;
 	struct struct_w_typedefs _3;
 	anon_struct_t _7;
 	struct struct_fwd *_8;
-- 
2.30.2

