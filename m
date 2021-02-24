Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8D3247A1
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhBXXq5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:46:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233951AbhBXXqz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:46:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONfr3r075104;
        Wed, 24 Feb 2021 18:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0L2wrBTLIhtnVJjeXl4sYVacc64Xh+qloma6nTrMc60=;
 b=Vj2yC57yY5C4WopktHtiITNA7R1vlVwbKRu2tHKdQ9/Oa4z69IV508i6YBGYjJXhc6jQ
 TPlvQludCjlDR2GK1WXn+6UxZCDzc7hGP3kyYtSUh2wq86fpCj1TWYm05Lu9jF76dzAA
 WKb9kIOYVuXK9nrvCdypMIHsyr84ohDNCXRBCl4XOESQDuaYqhY3UNbmbuo8+hIYVFda
 Dx7X260K6V4CiKOT/sAd+lV96HRL9amNWE1rbgjmKrn6Ulm0thrGgBewyfuRzrXIdpQB
 PHNgum30CJ/ZgbEOMSNh8kRK8+UGRlx99Ehw5u00jZ16tDIZCCsfg89ydl/o/Aik/zHC IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wy5eja6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:59 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONgOZY080684;
        Wed, 24 Feb 2021 18:45:58 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36wy5eja59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:58 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONjuQu001970;
        Wed, 24 Feb 2021 23:45:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 36tt28a30q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:45:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONjrOZ12452270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:45:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BD5D42041;
        Wed, 24 Feb 2021 23:45:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CB9D4203F;
        Wed, 24 Feb 2021 23:45:52 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:45:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 bpf-next 8/9] selftests/bpf: Add BTF_KIND_FLOAT to the existing deduplication tests
Date:   Thu, 25 Feb 2021 00:45:34 +0100
Message-Id: <20210224234535.106970-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224234535.106970-1-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240184
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Check that floats don't interfere with struct deduplication, that they
are not merged with another kinds and that floats of different sizes are
not merged with each other.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 43 ++++++++++++++------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 11d98d3cf949..0457ae32b270 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6411,11 +6411,12 @@ const struct btf_dedup_test dedup_tests[] = {
 			/* int[16] */
 			BTF_TYPE_ARRAY_ENC(1, 1, 16),					/* [2] */
 			/* struct s { */
-			BTF_STRUCT_ENC(NAME_NTH(2), 4, 84),				/* [3] */
+			BTF_STRUCT_ENC(NAME_NTH(2), 5, 88),				/* [3] */
 				BTF_MEMBER_ENC(NAME_NTH(3), 4, 0),	/* struct s *next;	*/
 				BTF_MEMBER_ENC(NAME_NTH(4), 5, 64),	/* const int *a;	*/
 				BTF_MEMBER_ENC(NAME_NTH(5), 2, 128),	/* int b[16];		*/
 				BTF_MEMBER_ENC(NAME_NTH(6), 1, 640),	/* int c;		*/
+				BTF_MEMBER_ENC(NAME_NTH(8), 13, 672),	/* float d;		*/
 			/* ptr -> [3] struct s */
 			BTF_PTR_ENC(3),							/* [4] */
 			/* ptr -> [6] const int */
@@ -6426,39 +6427,43 @@ const struct btf_dedup_test dedup_tests[] = {
 			/* full copy of the above */
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),	/* [7] */
 			BTF_TYPE_ARRAY_ENC(7, 7, 16),					/* [8] */
-			BTF_STRUCT_ENC(NAME_NTH(2), 4, 84),				/* [9] */
+			BTF_STRUCT_ENC(NAME_NTH(2), 5, 88),				/* [9] */
 				BTF_MEMBER_ENC(NAME_NTH(3), 10, 0),
 				BTF_MEMBER_ENC(NAME_NTH(4), 11, 64),
 				BTF_MEMBER_ENC(NAME_NTH(5), 8, 128),
 				BTF_MEMBER_ENC(NAME_NTH(6), 7, 640),
+				BTF_MEMBER_ENC(NAME_NTH(8), 13, 672),
 			BTF_PTR_ENC(9),							/* [10] */
 			BTF_PTR_ENC(12),						/* [11] */
 			BTF_CONST_ENC(7),						/* [12] */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [13] */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0int\0s\0next\0a\0b\0c\0"),
+		BTF_STR_SEC("\0int\0s\0next\0a\0b\0c\0float\0d"),
 	},
 	.expect = {
 		.raw_types = {
 			/* int */
-			BTF_TYPE_INT_ENC(NAME_NTH(4), BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 			/* int[16] */
 			BTF_TYPE_ARRAY_ENC(1, 1, 16),					/* [2] */
 			/* struct s { */
-			BTF_STRUCT_ENC(NAME_NTH(6), 4, 84),				/* [3] */
-				BTF_MEMBER_ENC(NAME_NTH(5), 4, 0),	/* struct s *next;	*/
+			BTF_STRUCT_ENC(NAME_NTH(8), 5, 88),				/* [3] */
+				BTF_MEMBER_ENC(NAME_NTH(7), 4, 0),	/* struct s *next;	*/
 				BTF_MEMBER_ENC(NAME_NTH(1), 5, 64),	/* const int *a;	*/
 				BTF_MEMBER_ENC(NAME_NTH(2), 2, 128),	/* int b[16];		*/
 				BTF_MEMBER_ENC(NAME_NTH(3), 1, 640),	/* int c;		*/
+				BTF_MEMBER_ENC(NAME_NTH(4), 7, 672),	/* float d;		*/
 			/* ptr -> [3] struct s */
 			BTF_PTR_ENC(3),							/* [4] */
 			/* ptr -> [6] const int */
 			BTF_PTR_ENC(6),							/* [5] */
 			/* const -> [1] int */
 			BTF_CONST_ENC(1),						/* [6] */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [7] */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0a\0b\0c\0int\0next\0s"),
+		BTF_STR_SEC("\0a\0b\0c\0d\0int\0float\0next\0s"),
 	},
 	.opts = {
 		.dont_resolve_fwds = false,
@@ -6579,9 +6584,10 @@ const struct btf_dedup_test dedup_tests[] = {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
+			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N"),
 	},
 	.expect = {
 		.raw_types = {
@@ -6604,16 +6610,17 @@ const struct btf_dedup_test dedup_tests[] = {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
+			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N"),
 	},
 	.opts = {
 		.dont_resolve_fwds = false,
 	},
 },
 {
-	.descr = "dedup: no int duplicates",
+	.descr = "dedup: no int/float duplicates",
 	.input = {
 		.raw_types = {
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 8),
@@ -6628,9 +6635,15 @@ const struct btf_dedup_test dedup_tests[] = {
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 27, 8),
 			/* different byte size */
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
+			/* all allowed sizes */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0int\0some other int"),
+		BTF_STR_SEC("\0int\0some other int\0float"),
 	},
 	.expect = {
 		.raw_types = {
@@ -6646,9 +6659,15 @@ const struct btf_dedup_test dedup_tests[] = {
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 27, 8),
 			/* different byte size */
 			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
+			/* all allowed sizes */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 2),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 4),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 8),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 12),
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(3), 16),
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0int\0some other int"),
+		BTF_STR_SEC("\0int\0some other int\0float"),
 	},
 	.opts = {
 		.dont_resolve_fwds = false,
-- 
2.29.2

