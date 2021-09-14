Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0541140BB72
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhINWcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:32:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235137AbhINWcQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:32:16 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG1gvt002071
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UeeAzsGnBMzlzaroa59Vi50q0aqo9ypVM8/Kn2r0a58=;
 b=a+9/jhxvjPqqhvB/gYLawXCtrnJtZlcIC7htQ1yt1rOfNnEIbxm7+wRxdB0bkRTO9Gu/
 t8P/WjLlA9M2erG5sFgA5eqoRYKtD7gTiYH+Lw8Ae5m8SAg5savsGqkMRWr9GKhTCJa9
 yk0Qs4qc1jlh1y7Gi56s9z/VH+ldC0X8+jA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b2uq0ks5h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:58 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:56 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CE0127382266; Tue, 14 Sep 2021 15:30:52 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 09/11] selftests/bpf: test BTF_KIND_TAG for deduplication
Date:   Tue, 14 Sep 2021 15:30:52 -0700
Message-ID: <20210914223052.248535-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: wddwwT9kJvPgIBQx3lDKPjBzu59FMua2
X-Proofpoint-GUID: wddwwT9kJvPgIBQx3lDKPjBzu59FMua2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add unit tests for BTF_KIND_TAG deduplication for
  - struct and struct member
  - variable
  - func and func argument

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 192 +++++++++++++++++--
 1 file changed, 175 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index b4e86a8423cb..9c85d7d27409 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6664,27 +6664,33 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_MEMBER_ENC(NAME_NTH(4), 5, 64),	/* const int *a;	*/
 				BTF_MEMBER_ENC(NAME_NTH(5), 2, 128),	/* int b[16];		*/
 				BTF_MEMBER_ENC(NAME_NTH(6), 1, 640),	/* int c;		*/
-				BTF_MEMBER_ENC(NAME_NTH(8), 13, 672),	/* float d;		*/
+				BTF_MEMBER_ENC(NAME_NTH(8), 15, 672),	/* float d;		*/
 			/* ptr -> [3] struct s */
 			BTF_PTR_ENC(3),							/* [4] */
 			/* ptr -> [6] const int */
 			BTF_PTR_ENC(6),							/* [5] */
 			/* const -> [1] int */
 			BTF_CONST_ENC(1),						/* [6] */
+			/* tag -> [3] struct s */
+			BTF_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
+			/* tag -> [3] struct s, member 1 */
+			BTF_TAG_ENC(NAME_NTH(2), 3, 1),					/* [8] */
=20
 			/* full copy of the above */
-			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),	/* [7] */
-			BTF_TYPE_ARRAY_ENC(7, 7, 16),					/* [8] */
-			BTF_STRUCT_ENC(NAME_NTH(2), 5, 88),				/* [9] */
-				BTF_MEMBER_ENC(NAME_NTH(3), 10, 0),
-				BTF_MEMBER_ENC(NAME_NTH(4), 11, 64),
-				BTF_MEMBER_ENC(NAME_NTH(5), 8, 128),
-				BTF_MEMBER_ENC(NAME_NTH(6), 7, 640),
-				BTF_MEMBER_ENC(NAME_NTH(8), 13, 672),
-			BTF_PTR_ENC(9),							/* [10] */
-			BTF_PTR_ENC(12),						/* [11] */
-			BTF_CONST_ENC(7),						/* [12] */
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [13] */
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),	/* [9] */
+			BTF_TYPE_ARRAY_ENC(9, 9, 16),					/* [10] */
+			BTF_STRUCT_ENC(NAME_NTH(2), 5, 88),				/* [11] */
+				BTF_MEMBER_ENC(NAME_NTH(3), 12, 0),
+				BTF_MEMBER_ENC(NAME_NTH(4), 13, 64),
+				BTF_MEMBER_ENC(NAME_NTH(5), 10, 128),
+				BTF_MEMBER_ENC(NAME_NTH(6), 9, 640),
+				BTF_MEMBER_ENC(NAME_NTH(8), 15, 672),
+			BTF_PTR_ENC(11),						/* [12] */
+			BTF_PTR_ENC(14),						/* [13] */
+			BTF_CONST_ENC(9),						/* [14] */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [15] */
+			BTF_TAG_ENC(NAME_NTH(2), 11, -1),				/* [16] */
+			BTF_TAG_ENC(NAME_NTH(2), 11, 1),				/* [17] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0int\0s\0next\0a\0b\0c\0float\0d"),
@@ -6701,14 +6707,16 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_MEMBER_ENC(NAME_NTH(1), 5, 64),	/* const int *a;	*/
 				BTF_MEMBER_ENC(NAME_NTH(2), 2, 128),	/* int b[16];		*/
 				BTF_MEMBER_ENC(NAME_NTH(3), 1, 640),	/* int c;		*/
-				BTF_MEMBER_ENC(NAME_NTH(4), 7, 672),	/* float d;		*/
+				BTF_MEMBER_ENC(NAME_NTH(4), 9, 672),	/* float d;		*/
 			/* ptr -> [3] struct s */
 			BTF_PTR_ENC(3),							/* [4] */
 			/* ptr -> [6] const int */
 			BTF_PTR_ENC(6),							/* [5] */
 			/* const -> [1] int */
 			BTF_CONST_ENC(1),						/* [6] */
-			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [7] */
+			BTF_TAG_ENC(NAME_NTH(2), 3, -1),				/* [7] */
+			BTF_TAG_ENC(NAME_NTH(2), 3, 1),					/* [8] */
+			BTF_TYPE_FLOAT_ENC(NAME_NTH(7), 4),				/* [9] */
 			BTF_END_RAW,
 		},
 		BTF_STR_SEC("\0a\0b\0c\0d\0int\0float\0next\0s"),
@@ -6833,9 +6841,11 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
+			BTF_TAG_ENC(NAME_TBD, 13, -1),					/* [15] tag */
+			BTF_TAG_ENC(NAME_TBD, 13, 1),					/* [16] tag */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P"),
 	},
 	.expect =3D {
 		.raw_types =3D {
@@ -6859,9 +6869,11 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
+			BTF_TAG_ENC(NAME_TBD, 13, -1),					/* [15] tag */
+			BTF_TAG_ENC(NAME_TBD, 13, 1),					/* [16] tag */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P"),
 	},
 	.opts =3D {
 		.dont_resolve_fwds =3D false,
@@ -7010,6 +7022,152 @@ const struct btf_dedup_test dedup_tests[] =3D {
 		.dedup_table_size =3D 1
 	},
 },
+{
+	.descr =3D "dedup: func/func_arg/var tags",
+	.input =3D {
+		.raw_types =3D {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* static int t */
+			BTF_VAR_ENC(NAME_NTH(1), 1, 0),			/* [2] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
+			BTF_FUNC_ENC(NAME_NTH(4), 2),			/* [4] */
+			/* tag -> t */
+			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [6] */
+			/* tag -> func */
+			BTF_TAG_ENC(NAME_NTH(5), 4, -1),		/* [7] */
+			BTF_TAG_ENC(NAME_NTH(5), 4, -1),		/* [8] */
+			/* tag -> func arg a1 */
+			BTF_TAG_ENC(NAME_NTH(5), 4, 1),			/* [9] */
+			BTF_TAG_ENC(NAME_NTH(5), 4, 1),			/* [10] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_VAR_ENC(NAME_NTH(1), 1, 0),			/* [2] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(3), 1),
+			BTF_FUNC_ENC(NAME_NTH(4), 2),			/* [4] */
+			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			BTF_TAG_ENC(NAME_NTH(5), 4, -1),		/* [6] */
+			BTF_TAG_ENC(NAME_NTH(5), 4, 1),			/* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0a1\0a2\0f\0tag"),
+	},
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
+	},
+},
+{
+	.descr =3D "dedup: func/func_param tags",
+	.input =3D {
+		.raw_types =3D {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
+			/* void f(int a1, int a2) */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [4] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 4),			/* [5] */
+			/* tag -> f: tag1, tag2 */
+			BTF_TAG_ENC(NAME_NTH(4), 3, -1),		/* [6] */
+			BTF_TAG_ENC(NAME_NTH(5), 3, -1),		/* [7] */
+			/* tag -> f/a2: tag1, tag2 */
+			BTF_TAG_ENC(NAME_NTH(4), 3, 1),			/* [8] */
+			BTF_TAG_ENC(NAME_NTH(5), 3, 1),			/* [9] */
+			/* tag -> f: tag1, tag3 */
+			BTF_TAG_ENC(NAME_NTH(4), 5, -1),		/* [10] */
+			BTF_TAG_ENC(NAME_NTH(6), 5, -1),		/* [11] */
+			/* tag -> f/a2: tag1, tag3 */
+			BTF_TAG_ENC(NAME_NTH(4), 5, 1),			/* [12] */
+			BTF_TAG_ENC(NAME_NTH(6), 5, 1),			/* [13] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
+			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
+			BTF_TAG_ENC(NAME_NTH(4), 3, -1),		/* [4] */
+			BTF_TAG_ENC(NAME_NTH(5), 3, -1),		/* [5] */
+			BTF_TAG_ENC(NAME_NTH(6), 3, -1),		/* [6] */
+			BTF_TAG_ENC(NAME_NTH(4), 3, 1),			/* [7] */
+			BTF_TAG_ENC(NAME_NTH(5), 3, 1),			/* [8] */
+			BTF_TAG_ENC(NAME_NTH(6), 3, 1),			/* [9] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0a1\0a2\0f\0tag1\0tag2\0tag3"),
+	},
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
+	},
+},
+{
+	.descr =3D "dedup: struct/struct_member tags",
+	.input =3D {
+		.raw_types =3D {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [2] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [3] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
+			/* tag -> t: tag1, tag2 */
+			BTF_TAG_ENC(NAME_NTH(4), 2, -1),		/* [4] */
+			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [5] */
+			/* tag -> t/m2: tag1, tag2 */
+			BTF_TAG_ENC(NAME_NTH(4), 2, 1),			/* [6] */
+			BTF_TAG_ENC(NAME_NTH(5), 2, 1),			/* [7] */
+			/* tag -> t: tag1, tag3 */
+			BTF_TAG_ENC(NAME_NTH(4), 3, -1),		/* [8] */
+			BTF_TAG_ENC(NAME_NTH(6), 3, -1),		/* [9] */
+			/* tag -> t/m2: tag1, tag3 */
+			BTF_TAG_ENC(NAME_NTH(4), 3, 1),			/* [10] */
+			BTF_TAG_ENC(NAME_NTH(6), 3, 1),			/* [11] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_STRUCT_ENC(NAME_NTH(1), 2, 8),		/* [2] */
+				BTF_MEMBER_ENC(NAME_NTH(2), 1, 0),
+				BTF_MEMBER_ENC(NAME_NTH(3), 1, 32),
+			BTF_TAG_ENC(NAME_NTH(4), 2, -1),		/* [3] */
+			BTF_TAG_ENC(NAME_NTH(5), 2, -1),		/* [4] */
+			BTF_TAG_ENC(NAME_NTH(6), 2, -1),		/* [5] */
+			BTF_TAG_ENC(NAME_NTH(4), 2, 1),			/* [6] */
+			BTF_TAG_ENC(NAME_NTH(5), 2, 1),			/* [7] */
+			BTF_TAG_ENC(NAME_NTH(6), 2, 1),			/* [8] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	},
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
+	},
+},
=20
 };
=20
--=20
2.30.2

