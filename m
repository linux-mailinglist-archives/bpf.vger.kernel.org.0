Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3544DE7E
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhKKXcB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:32:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhKKXcB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:32:01 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABN2lca005587
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:29:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7Zk6dR1fNdlgYTU+tzo2DHHv2fj+BmIiQiPoRGcroCI=;
 b=mGa6FWjhzEItY+A6DPUTl3Y7yKnwfP4T894hfEk21HR/wHE60/R5xH4B4J2RqT+AK9VA
 O8OT7RNe2T+wBnevkOxxUJtuf/SKUPSAI7XfMV0jTC8xCAapMJgM22aKK1eyp6vk2hAH
 l7RE/w+wCHTh34vdV/KVEDaxX3mZQd6TgrY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k51yd8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:29:11 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:29:09 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1759D24B3E6C; Thu, 11 Nov 2021 15:26:18 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 06/10] selftests/bpf: Test BTF_KIND_DECL_TAG for deduplication
Date:   Thu, 11 Nov 2021 15:26:18 -0800
Message-ID: <20211111232618.790790-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GbtwgpeoHgJW1j3Is3f9uNGfkogQ5P9q
X-Proofpoint-GUID: GbtwgpeoHgJW1j3Is3f9uNGfkogQ5P9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=956 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TYPE_TAG duplication unit tests.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 151 ++++++++++++++++++-
 1 file changed, 147 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ebd0ead5f4bc..12424c910900 100644
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
@@ -7254,6 +7256,147 @@ const struct btf_dedup_test dedup_tests[] =3D {
 		.dont_resolve_fwds =3D false,
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
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
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
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
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
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
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
+	.opts =3D {
+		.dont_resolve_fwds =3D false,
+	},
+},
=20
 };
=20
--=20
2.30.2

