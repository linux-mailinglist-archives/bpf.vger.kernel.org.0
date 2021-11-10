Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050544BB05
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhKJFXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:23:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhKJFXC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:23:02 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA4221Y026672
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:20:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3rvf83v795B5xC5902QKKvIjbnU81mTjzmFmeYzwltg=;
 b=fIMhPM8mlkrLlUF8opjjJJAvPI9SDnw008Nu+BIaoGwKywEogBjMDmyzgO3a9OJBuQPw
 gejZRw3PV8UQ4v1iA+9sizfUPZTXCIJKliOzJiFJMatzJ48dcvvm2F1Yfe/+GP6DQ65P
 bHjJQ1FLo/CmfGdSiHxt6NdHFPFc3mG5bIc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c828phyy7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:20:15 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:20:12 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 080EA23611A9; Tue,  9 Nov 2021 21:20:01 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 04/10] selftests/bpf: Test libbpf API function btf__add_type_tag()
Date:   Tue, 9 Nov 2021 21:20:01 -0800
Message-ID: <20211110052001.370523-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: wHs9--fatzRRX1VdN57xs3HqxHU6Uiyh
X-Proofpoint-GUID: wHs9--fatzRRX1VdN57xs3HqxHU6Uiyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=963
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add unit tests for btf__add_type_tag().

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/btf_helpers.c     |  4 +-
 .../selftests/bpf/prog_tests/btf_write.c      | 67 +++++++++++--------
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/se=
lftests/bpf/btf_helpers.c
index 3d1a748d09d8..89e717961c43 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -25,11 +25,12 @@ static const char * const btf_kind_str_mapping[] =3D =
{
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
+	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
 };
=20
 static const char *btf_kind_str(__u16 kind)
 {
-	if (kind > BTF_KIND_DECL_TAG)
+	if (kind > BTF_KIND_TYPE_TAG)
 		return "UNKNOWN";
 	return btf_kind_str_mapping[kind];
 }
@@ -109,6 +110,7 @@ int fprintf_btf_type_raw(FILE *out, const struct btf =
*btf, __u32 id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_TYPE_TAG:
 		fprintf(out, " type_id=3D%u", t->type);
 		break;
 	case BTF_KIND_ARRAY: {
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
index b912eeb0b6b4..addf99c05896 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -297,6 +297,16 @@ static void gen_btf(struct btf *btf)
 	ASSERT_EQ(btf_decl_tag(t)->component_idx, 1, "tag_component_idx");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 19),
 		     "[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1", "raw_dump"=
);
+
+	/* TYPE_TAG */
+	id =3D btf__add_type_tag(btf, "tag1", 1);
+	ASSERT_EQ(id, 20, "tag_id");
+	t =3D btf__type_by_id(btf, 20);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "tag1", "tag_value")=
;
+	ASSERT_EQ(btf_kind(t), BTF_KIND_TYPE_TAG, "tag_kind");
+	ASSERT_EQ(t->type, 1, "tag_type");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 20),
+		     "[20] TYPE_TAG 'tag1' type_id=3D1", "raw_dump");
 }
=20
 static void test_btf_add()
@@ -337,7 +347,8 @@ static void test_btf_add()
 		"[17] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
 		"\ttype_id=3D1 offset=3D4 size=3D8",
 		"[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1",
-		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1");
+		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1",
+		"[20] TYPE_TAG 'tag1' type_id=3D1");
=20
 	btf__free(btf);
 }
@@ -359,7 +370,7 @@ static void test_btf_add_btf()
 	gen_btf(btf2);
=20
 	id =3D btf__add_btf(btf1, btf2);
-	if (!ASSERT_EQ(id, 20, "id"))
+	if (!ASSERT_EQ(id, 21, "id"))
 		goto cleanup;
=20
 	VALIDATE_RAW_BTF(
@@ -391,35 +402,37 @@ static void test_btf_add_btf()
 		"\ttype_id=3D1 offset=3D4 size=3D8",
 		"[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1",
 		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1",
+		"[20] TYPE_TAG 'tag1' type_id=3D1",
=20
 		/* types appended from the second BTF */
-		"[20] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNE=
D",
-		"[21] PTR '(anon)' type_id=3D20",
-		"[22] CONST '(anon)' type_id=3D24",
-		"[23] VOLATILE '(anon)' type_id=3D22",
-		"[24] RESTRICT '(anon)' type_id=3D23",
-		"[25] ARRAY '(anon)' type_id=3D21 index_type_id=3D20 nr_elems=3D10",
-		"[26] STRUCT 's1' size=3D8 vlen=3D2\n"
-		"\t'f1' type_id=3D20 bits_offset=3D0\n"
-		"\t'f2' type_id=3D20 bits_offset=3D32 bitfield_size=3D16",
-		"[27] UNION 'u1' size=3D8 vlen=3D1\n"
-		"\t'f1' type_id=3D20 bits_offset=3D0 bitfield_size=3D16",
-		"[28] ENUM 'e1' size=3D4 vlen=3D2\n"
+		"[21] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNE=
D",
+		"[22] PTR '(anon)' type_id=3D21",
+		"[23] CONST '(anon)' type_id=3D25",
+		"[24] VOLATILE '(anon)' type_id=3D23",
+		"[25] RESTRICT '(anon)' type_id=3D24",
+		"[26] ARRAY '(anon)' type_id=3D22 index_type_id=3D21 nr_elems=3D10",
+		"[27] STRUCT 's1' size=3D8 vlen=3D2\n"
+		"\t'f1' type_id=3D21 bits_offset=3D0\n"
+		"\t'f2' type_id=3D21 bits_offset=3D32 bitfield_size=3D16",
+		"[28] UNION 'u1' size=3D8 vlen=3D1\n"
+		"\t'f1' type_id=3D21 bits_offset=3D0 bitfield_size=3D16",
+		"[29] ENUM 'e1' size=3D4 vlen=3D2\n"
 		"\t'v1' val=3D1\n"
 		"\t'v2' val=3D2",
-		"[29] FWD 'struct_fwd' fwd_kind=3Dstruct",
-		"[30] FWD 'union_fwd' fwd_kind=3Dunion",
-		"[31] ENUM 'enum_fwd' size=3D4 vlen=3D0",
-		"[32] TYPEDEF 'typedef1' type_id=3D20",
-		"[33] FUNC 'func1' type_id=3D34 linkage=3Dglobal",
-		"[34] FUNC_PROTO '(anon)' ret_type_id=3D20 vlen=3D2\n"
-		"\t'p1' type_id=3D20\n"
-		"\t'p2' type_id=3D21",
-		"[35] VAR 'var1' type_id=3D20, linkage=3Dglobal-alloc",
-		"[36] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
-		"\ttype_id=3D20 offset=3D4 size=3D8",
-		"[37] DECL_TAG 'tag1' type_id=3D35 component_idx=3D-1",
-		"[38] DECL_TAG 'tag2' type_id=3D33 component_idx=3D1");
+		"[30] FWD 'struct_fwd' fwd_kind=3Dstruct",
+		"[31] FWD 'union_fwd' fwd_kind=3Dunion",
+		"[32] ENUM 'enum_fwd' size=3D4 vlen=3D0",
+		"[33] TYPEDEF 'typedef1' type_id=3D21",
+		"[34] FUNC 'func1' type_id=3D35 linkage=3Dglobal",
+		"[35] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D2\n"
+		"\t'p1' type_id=3D21\n"
+		"\t'p2' type_id=3D22",
+		"[36] VAR 'var1' type_id=3D21, linkage=3Dglobal-alloc",
+		"[37] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
+		"\ttype_id=3D21 offset=3D4 size=3D8",
+		"[38] DECL_TAG 'tag1' type_id=3D36 component_idx=3D-1",
+		"[39] DECL_TAG 'tag2' type_id=3D34 component_idx=3D1",
+		"[40] TYPE_TAG 'tag1' type_id=3D21");
=20
 cleanup:
 	btf__free(btf1);
--=20
2.30.2

