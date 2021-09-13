Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F124097EC
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbhIMPxf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:53:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343789AbhIMPxa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:53:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18DF4MHs025572
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JhTZ14dYm/DVkZpU5k09CmaSYJLUgo+flzgsVc+rWys=;
 b=YbkbWOgqAb2AOCfQNZsXS9akcsq/dkEagJ0yVpMXkDYuzWvuKm110+pUUo8Xz+6qB6LQ
 vttjNAaJGgWcMO0RabGwUbsaSQqZOfkpBZ+uPZd8XFq+Qc7qd+ikjluisYaifRtY8FoD
 GH2sgbps/VeAgftapdbgpjEfS8kNF8x15Mk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b215pjw5p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:14 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:52:11 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 71C1672790B6; Mon, 13 Sep 2021 08:52:11 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: test BTF_KIND_TAG for deduplication
Date:   Mon, 13 Sep 2021 08:52:11 -0700
Message-ID: <20210913155211.3728854-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 5D8rptqm4mZAI1XE3d2uw9inULfVse29
X-Proofpoint-ORIG-GUID: 5D8rptqm4mZAI1XE3d2uw9inULfVse29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109130103
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
 tools/testing/selftests/bpf/prog_tests/btf.c | 91 ++++++++++++++++----
 1 file changed, 74 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 21b122f72a55..1ef0346be7b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6642,27 +6642,33 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
@@ -6679,14 +6685,16 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
@@ -6811,9 +6819,11 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
@@ -6837,9 +6847,11 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
@@ -6988,6 +7000,51 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
=20
 };
=20
--=20
2.30.2

