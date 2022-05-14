Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A012526F17
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiENDNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 23:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiENDNs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 23:13:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE034A966
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:47 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24DNXb3D017144
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NLs0dOU1w9/RbA+XcqgopKifa1qrWGt34pzRuA6l81A=;
 b=rLjcMsPPua3om/Fj4bltIKYe7vANlV4F49V2oI7uBPJ7o2mWk3JTV9pZalkCdMEMSDJa
 sW9UkYNRAen+6CEuqHCLvnNEhmNtwSL+0HQrS9chMrfuucvtIh3ru5zYPLjXekAVWTGB
 uTfMvs8wd3O9PKfrBribQa0Ue3fog9e46PA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g1cxefsuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:46 -0700
Received: from twshared35748.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 20:13:45 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8342CA45F6C8; Fri, 13 May 2022 20:13:40 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 15/18] selftests/bpf: Test BTF_KIND_ENUM64 for deduplication
Date:   Fri, 13 May 2022 20:13:40 -0700
Message-ID: <20220514031340.3246580-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514031221.3240268-1-yhs@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tYD7YUtJmZNN7WBRfJ535dx_Z3x0FTXI
X-Proofpoint-GUID: tYD7YUtJmZNN7WBRfJ535dx_Z3x0FTXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a few unit tests for BTF_KIND_ENUM64 deduplication.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 97 +++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index a986ee56c5f7..edb387163baa 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7016,9 +7016,12 @@ static struct btf_dedup_test dedup_tests[] =3D {
 			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
 			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
 			BTF_TYPE_TAG_ENC(NAME_TBD, 8),					/* [18] type_tag */
+			BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 2), 8),	/* [1=
9] enum64 */
+				BTF_ENUM64_ENC(NAME_TBD, 0, 0),
+				BTF_ENUM64_ENC(NAME_TBD, 1, 1),
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R\0S=
\0T\0U"),
 	},
 	.expect =3D {
 		.raw_types =3D {
@@ -7046,9 +7049,12 @@ static struct btf_dedup_test dedup_tests[] =3D {
 			BTF_DECL_TAG_ENC(NAME_TBD, 13, 1),				/* [16] decl_tag */
 			BTF_DECL_TAG_ENC(NAME_TBD, 7, -1),				/* [17] decl_tag */
 			BTF_TYPE_TAG_ENC(NAME_TBD, 8),					/* [18] type_tag */
+			BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 2), 8),	/* [1=
9] enum64 */
+				BTF_ENUM64_ENC(NAME_TBD, 0, 0),
+				BTF_ENUM64_ENC(NAME_TBD, 1, 1),
 			BTF_END_RAW,
 		},
-		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R"),
+		BTF_STR_SEC("\0A\0B\0C\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0N\0O\0P\0Q\0R\0S=
\0T\0U"),
 	},
 },
 {
@@ -7509,6 +7515,91 @@ static struct btf_dedup_test dedup_tests[] =3D {
 		BTF_STR_SEC("\0tag1\0t\0m"),
 	},
 },
+{
+	.descr =3D "dedup: enum64, standalone",
+	.input =3D {
+		.raw_types =3D {
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 123),
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 123),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 123),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val"),
+	},
+},
+{
+	.descr =3D "dedup: enum64, fwd resolution",
+	.input =3D {
+		.raw_types =3D {
+			/* [1] fwd enum64 'e1' before full enum */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
+			/* [2] full enum64 'e1' after fwd */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 123),
+			/* [3] full enum64 'e2' before fwd */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(4), 0, 456),
+			/* [4] fwd enum64 'e2' after full enum */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 0), 8),
+			/* [5] incompatible full enum64 with different value */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 0, 321),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0e2\0e2_val"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			/* [1] full enum64 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 123),
+			/* [2] full enum64 'e2' */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(4), 0, 456),
+			/* [3] incompatible full enum64 with different value */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 8),
+				BTF_ENUM64_ENC(NAME_NTH(2), 0, 321),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0e2\0e2_val"),
+	},
+},
+{
+	.descr =3D "dedup: enum and enum64, no dedup",
+	.input =3D {
+		.raw_types =3D {
+			/* [1] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			/* [2] enum64 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 4),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val"),
+	},
+	.expect =3D {
+		.raw_types =3D {
+			/* [1] enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 1),
+			/* [2] enum64 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM64, 0, 1), 4),
+				BTF_ENUM64_ENC(NAME_NTH(2), 1, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val"),
+	},
+},
=20
 };
=20
@@ -7533,6 +7624,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + sizeof(__u32);
 	case BTF_KIND_ENUM:
 		return base_size + vlen * sizeof(struct btf_enum);
+	case BTF_KIND_ENUM64:
+		return base_size + vlen * sizeof(struct btf_enum64);
 	case BTF_KIND_ARRAY:
 		return base_size + sizeof(struct btf_array);
 	case BTF_KIND_STRUCT:
--=20
2.30.2

