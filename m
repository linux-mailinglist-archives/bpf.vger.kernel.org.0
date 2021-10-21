Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1216B436B9E
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhJUT7G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 15:59:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhJUT7G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 15:59:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LJbU3o026819
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=25knLBYx6qQX+7hl0v8l2HHFUCE/989kIqvd7T1QRQc=;
 b=N7AaVTmm2L9aX7YWsnAS7knpLjqOlaucgNZJ0xfttkcPlJdf4n9uxDrslepihRkWztFU
 2AhyZ0UVyoV3jMoR8IYbiev53J6YqMaAvMIPWwHF+32kVTvVs1cnrhv8QtYVM/HvY5+A
 0Y3EFiMhhYuXSSJ1YdmATeJXLR/fMEKzODw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3btxw3qa15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:49 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 12:56:48 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9AD81151682B; Thu, 21 Oct 2021 12:56:38 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: test deduplication for BTF_KIND_DECL_TAG typedef
Date:   Thu, 21 Oct 2021 12:56:38 -0700
Message-ID: <20211021195638.4019770-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021195622.4018339-1-yhs@fb.com>
References: <20211021195622.4018339-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GlHl7gjT9oqkrTz503bxOQByUxcLHURi
X-Proofpoint-GUID: GlHl7gjT9oqkrTz503bxOQByUxcLHURi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_05,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=925
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add unit tests for deduplication of BTF_KIND_DECL_TAG to typedef types.
Also changed a few comments from "tag" to "decl_tag" to match
BTF_KIND_DECL_TAG enum value name.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 47 +++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index a00418b8b252..3477f272560f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6877,11 +6877,12 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
-			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] tag */
-			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] decl_tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
 	},
 	.expect =3D {
 		.raw_types =3D {
@@ -6905,11 +6906,12 @@ const struct btf_dedup_test dedup_tests[] =3D {
 				BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 8),
 			BTF_FUNC_ENC(NAME_TBD, 12),					/* [13] func */
 			BTF_TYPE_FLOAT_ENC(NAME_TBD, 2),				/* [14] float */
-			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] tag */
-			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, -1),				/* [15] decl_tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
+			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q"),
 	},
 	.opts =3D {
 		.dont_resolve_fwds =3D false,
@@ -7204,6 +7206,39 @@ const struct btf_dedup_test dedup_tests[] =3D {
 		.dont_resolve_fwds =3D false,
 	},
 },
+{
+	.descr =3D "dedup: typedef tags",
+	.input =3D {
+		.raw_types =3D {
+			/* int */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [3] */
+			/* tag -> t: tag1, tag2 */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 2, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(3), 2, -1),		/* [5] */
+			/* tag -> t: tag1, tag3 */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 3, -1),		/* [6] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 3, -1),		/* [7] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_DECL_TAG_ENC(NAME_NTH(2), 2, -1),		/* [3] */
+			BTF_DECL_TAG_ENC(NAME_NTH(3), 2, -1),		/* [4] */
+			BTF_DECL_TAG_ENC(NAME_NTH(4), 2, -1),		/* [5] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0t\0tag1\0tag2\0tag3"),
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

