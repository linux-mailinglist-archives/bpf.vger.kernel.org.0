Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4792544BB04
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhKJFXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:23:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37570 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229572AbhKJFXB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:23:01 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA54jDj021848
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:20:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pVZvUQ4oGDl+ZWGfchgL2qyCMTH6TAHM4H+ASn+2qp4=;
 b=rMVfeRzxeVYUp4Vp9JYfNUviwwupjR5hGM3j42hVsKB9d0bMqW2LyvlBoNjhEIG7za7k
 DJy+kK/DG8uj6UjA/ZnNKj2a95NIW1ZhIf24QccmF1KFh7+da7r0kOokkJb61bJbZWe2
 K6g0u0g3/SU5L+iT2eXH7imO1hyb6xtEUVw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7ys2u5xq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:20:14 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:20:13 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 7740823611D3; Tue,  9 Nov 2021 21:20:12 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 06/10] selftests/bpf: Test BTF_KIND_DECL_TAG for deduplication
Date:   Tue, 9 Nov 2021 21:20:12 -0800
Message-ID: <20211110052012.371411-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: S2O_X7-45V0NrtEiiZf6QcoVFXwUM2D6
X-Proofpoint-GUID: S2O_X7-45V0NrtEiiZf6QcoVFXwUM2D6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=848 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 46 ++++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ebd0ead5f4bc..91b19c41729f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6889,15 +6889,16 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
@@ -6918,15 +6919,16 @@ const struct btf_dedup_test dedup_tests[] =3D {
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
 	.opts =3D {
 		.dont_resolve_fwds =3D false,
@@ -7254,6 +7256,42 @@ const struct btf_dedup_test dedup_tests[] =3D {
 		.dont_resolve_fwds =3D false,
 	},
 },
+{
+	.descr =3D "dedup: btf_tag_type",
+	.input =3D {
+		.raw_types =3D {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			/* tag: tag1, tag2 */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			/* tag: tag1, tag2 */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [5] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 5),		/* [6] */
+			BTF_PTR_ENC(6),					/* [7] */
+			/* tag: tag1 */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [8] */
+			BTF_PTR_ENC(8),					/* [9] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPE_TAG_ENC(NAME_NTH(2), 2),		/* [3] */
+			BTF_PTR_ENC(3),					/* [4] */
+			BTF_PTR_ENC(2),					/* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0tag1\0tag2"),
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

