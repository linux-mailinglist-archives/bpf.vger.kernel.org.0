Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE7454E1A
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 20:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhKQTo0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 17 Nov 2021 14:44:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240567AbhKQToV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 14:44:21 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJdrM8032602
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 11:41:21 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccuxsd2vu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 11:41:21 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 11:41:20 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0E5BB98F1136; Wed, 17 Nov 2021 11:41:17 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add btf_dedup case with duplicated structs within CU
Date:   Wed, 17 Nov 2021 11:41:14 -0800
Message-ID: <20211117194114.347675-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117194114.347675-1-andrii@kernel.org>
References: <20211117194114.347675-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: PAKJ2OHytBf8k86KYMSt6gCpg2fn23A3
X-Proofpoint-ORIG-GUID: PAKJ2OHytBf8k86KYMSt6gCpg2fn23A3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=755 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1034 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111170086
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add an artificial minimal example simulating compilers producing two
different types within a single CU that correspond to identical struct
definitions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/btf_dedup_split.c          | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 9d3b8d7a1537..94ff9757557a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -314,6 +314,117 @@ static void test_split_struct_duped() {
 	btf__free(btf1);
 }
 
+static void btf_add_dup_struct_in_cu(struct btf *btf, int start_id)
+{
+#define ID(n) (start_id + n)
+	btf__set_pointer_size(btf, 8); /* enforce 64-bit arch */
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);    /* [1] int */
+
+	btf__add_struct(btf, "s", 8);                   /* [2] struct s { */
+	btf__add_field(btf, "a", ID(3), 0, 0);          /*      struct anon a; */
+	btf__add_field(btf, "b", ID(4), 0, 0);          /*      struct anon b; */
+							/* } */
+
+	btf__add_struct(btf, "(anon)", 8);              /* [3] struct anon { */
+	btf__add_field(btf, "f1", ID(1), 0, 0);         /*      int f1; */
+	btf__add_field(btf, "f2", ID(1), 32, 0);        /*      int f2; */
+							/* } */
+
+	btf__add_struct(btf, "(anon)", 8);              /* [4] struct anon { */
+	btf__add_field(btf, "f1", ID(1), 0, 0);         /*      int f1; */
+	btf__add_field(btf, "f2", ID(1), 32, 0);        /*      int f2; */
+							/* } */
+#undef ID
+}
+
+static void test_split_dup_struct_in_cu()
+{
+	struct btf *btf1, *btf2;
+	int err;
+
+	/* generate the base data.. */
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf_add_dup_struct_in_cu(btf1, 0);
+
+	VALIDATE_RAW_BTF(
+			btf1,
+			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[2] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=3 bits_offset=0\n"
+			"\t'b' type_id=4 bits_offset=0",
+			"[3] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=1 bits_offset=0\n"
+			"\t'f2' type_id=1 bits_offset=32",
+			"[4] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=1 bits_offset=0\n"
+			"\t'f2' type_id=1 bits_offset=32");
+
+	/* ..dedup them... */
+	err = btf__dedup(btf1, NULL, NULL);
+	if (!ASSERT_OK(err, "btf_dedup"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+			btf1,
+			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[2] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=3 bits_offset=0\n"
+			"\t'b' type_id=3 bits_offset=0",
+			"[3] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=1 bits_offset=0\n"
+			"\t'f2' type_id=1 bits_offset=32");
+
+	/* and add the same data on top of it */
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf_add_dup_struct_in_cu(btf2, 3);
+
+	VALIDATE_RAW_BTF(
+			btf2,
+			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[2] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=3 bits_offset=0\n"
+			"\t'b' type_id=3 bits_offset=0",
+			"[3] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=1 bits_offset=0\n"
+			"\t'f2' type_id=1 bits_offset=32",
+			"[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[5] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=6 bits_offset=0\n"
+			"\t'b' type_id=7 bits_offset=0",
+			"[6] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=4 bits_offset=0\n"
+			"\t'f2' type_id=4 bits_offset=32",
+			"[7] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=4 bits_offset=0\n"
+			"\t'f2' type_id=4 bits_offset=32");
+
+	err = btf__dedup(btf2, NULL, NULL);
+	if (!ASSERT_OK(err, "btf_dedup"))
+		goto cleanup;
+
+	/* after dedup it should match the original data */
+	VALIDATE_RAW_BTF(
+			btf2,
+			"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+			"[2] STRUCT 's' size=8 vlen=2\n"
+			"\t'a' type_id=3 bits_offset=0\n"
+			"\t'b' type_id=3 bits_offset=0",
+			"[3] STRUCT '(anon)' size=8 vlen=2\n"
+			"\t'f1' type_id=1 bits_offset=0\n"
+			"\t'f2' type_id=1 bits_offset=32");
+
+cleanup:
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
 void test_btf_dedup_split()
 {
 	if (test__start_subtest("split_simple"))
@@ -322,4 +433,6 @@ void test_btf_dedup_split()
 		test_split_struct_duped();
 	if (test__start_subtest("split_fwd_resolve"))
 		test_split_fwd_resolve();
+	if (test__start_subtest("split_dup_struct_in_cu"))
+		test_split_dup_struct_in_cu();
 }
-- 
2.30.2

