Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C110144DFC2
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 02:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhKLBal (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 20:30:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29410 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231470AbhKLBal (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 20:30:41 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC132mj032094
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:27:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4ozWJivqtOVYCqxq1+Xi9/b5WTYJo9fZ1P5dKoo2Rkk=;
 b=SzSRWAy3ZSehj2wyC+g4w07QEDYDISmk9SVD5/IU8kkI1ptchkQ0v86vVWyopvJN6zJo
 3l4m8QyXTBK2nAX5KUD26yB4hGJH8E2FO8PFgriBZG23xkRboawKj2lxua85dJEPc6ZE
 QyBN9WmFV6w+zu69lASpq0+j8RhbuiLLfl4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9br6s6st-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:27:51 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 17:26:40 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D757024C5B66; Thu, 11 Nov 2021 17:26:35 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 06/10] selftests/bpf: Test BTF_KIND_DECL_TAG for deduplication
Date:   Thu, 11 Nov 2021 17:26:35 -0800
Message-ID: <20211112012635.1506853-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112012604.1504583-1-yhs@fb.com>
References: <20211112012604.1504583-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: _whw_oAc2qKz4vOBXgiQrDVYyQBfIq4A
X-Proofpoint-ORIG-GUID: _whw_oAc2qKz4vOBXgiQrDVYyQBfIq4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=935 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TYPE_TAG duplication unit tests.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 139 ++++++++++++++++++-
 1 file changed, 135 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 88510a2d9858..4aa6343dc4c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6878,15 +6878,16 @@ static struct btf_dedup_test dedup_tests[] =3D {
 			BTF_RESTRICT_ENC(8),						/* [11] restrict */
 			BTF_FUNC_PROTO_ENC(1, 2),					/* [12] func_proto */
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
-				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
 			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] decl_tag */
 			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
 			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
+			BTF_TYPE_TAG_ENC(NAME_TBD, 8),					/* [18] type_tag */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
 	},
 	.expect =3D {
 		.raw_types =3D {
@@ -6907,15 +6908,16 @@ static struct btf_dedup_test dedup_tests[] =3D {
 			BTF_RESTRICT_ENC(8),						/* [11] restrict */
 			BTF_FUNC_PROTO_ENC(1, 2),					/* [12] func_proto */
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
-				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
+				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 18),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
 			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] decl_tag */
 			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
 			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
+			BTF_TYPE_TAG_ENC(NAME_TBD, 8),					/* [18] type_tag */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
 	},
 },
 {
@@ -7221,6 +7223,135 @@ static struct btf_dedup_test dedup_tests[] =3D {
 		BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
 	},
 },
+{
+	.descr =3D "dedup: btf_type_tag #1",
+	.input =3D {
+		.raw_types =3D {
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [5] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),		/* [6] */
+			BTF_PTR_ENC(6),					/* [7] */
+			/* ptr -> tag1 -> int */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [8] */
+			BTF_PTR_ENC(8),					/* [9] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* ptr -> tag1 -> int */
+			BTF_PTR_ENC(2),					/* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+},
+{
+	.descr =3D "dedup: btf_type_tag #2",
+	.input =3D {
+		.raw_types =3D {
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* ptr -> tag2 -> int */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [5] */
+			BTF_PTR_ENC(5),					/* [6] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* ptr -> tag2 -> int */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [5] */
+			BTF_PTR_ENC(5),					/* [6] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+},
+{
+	.descr =3D "dedup: btf_type_tag #3",
+	.input =3D {
+		.raw_types =3D {
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* ptr -> tag1 -> tag2 -> int */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [5] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),		/* [6] */
+			BTF_PTR_ENC(6),					/* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			/* ptr -> tag2 -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* ptr -> tag1 -> tag2 -> int */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 1),		/* [5] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 5),		/* [6] */
+			BTF_PTR_ENC(6),					/* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+},
+{
+	.descr =3D "dedup: btf_type_tag #4",
+	.input =3D {
+		.raw_types =3D {
+			/* ptr -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_PTR_ENC(2),					/* [3] */
+			/* ptr -> tag1 -> long */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),	/* [4] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),		/* [5] */
+			BTF_PTR_ENC(5),					/* [6] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			/* ptr -> tag1 -> int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_PTR_ENC(2),					/* [3] */
+			/* ptr -> tag1 -> long */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 64, 8),	/* [4] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 4),		/* [5] */
+			BTF_PTR_ENC(5),					/* [6] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1"),
+	},
+},
=20
 };
=20
--=20
2.30.2

