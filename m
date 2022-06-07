Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD053F618
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiFGG1N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiFGG1M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:27:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6680C4F
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:27:09 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25751Xi6025317
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hdxkgaT02m3zQDYS9cXYvtbDVli5AyRSAXMgVrYu7Qo=;
 b=QJ+qYjPZscTCOt5l5a/9vOFc/9C/JgbrWdpVFTPHmfVBPbyNw8AvZY2xN/TgRj+ITCLI
 D2+8ve+ok17dEOidA8sLbak8ZqR3TQLOaXSBUMoBAZZngEFANCAqSNdC7RYI768O4Vn6
 rDwKUPEU8ogO6l97WNpfuVkA2er+LXv9+9E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ghy4ggh1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:27:08 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:27:07 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 38256B5211FB; Mon,  6 Jun 2022 23:27:03 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 13/17] selftests/bpf: Test new enum kflag and enum64 API functions
Date:   Mon, 6 Jun 2022 23:27:03 -0700
Message-ID: <20220607062703.3724287-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BlUZ7sIGrqJnc6DthnVx-h54CAZfJ70b
X-Proofpoint-GUID: BlUZ7sIGrqJnc6DthnVx-h54CAZfJ70b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests to use the new enum kflag and enum64 API functions
in selftest btf_write.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/btf_helpers.c     |  25 +++-
 .../selftests/bpf/prog_tests/btf_write.c      | 126 +++++++++++++-----
 2 files changed, 114 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/se=
lftests/bpf/btf_helpers.c
index b5941d514e17..1c1c2c26690a 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -26,11 +26,12 @@ static const char * const btf_kind_str_mapping[] =3D =
{
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
+	[BTF_KIND_ENUM64]	=3D "ENUM64",
 };
=20
 static const char *btf_kind_str(__u16 kind)
 {
-	if (kind > BTF_KIND_TYPE_TAG)
+	if (kind > BTF_KIND_ENUM64)
 		return "UNKNOWN";
 	return btf_kind_str_mapping[kind];
 }
@@ -139,14 +140,32 @@ int fprintf_btf_type_raw(FILE *out, const struct bt=
f *btf, __u32 id)
 	}
 	case BTF_KIND_ENUM: {
 		const struct btf_enum *v =3D btf_enum(t);
+		const char *fmt_str;
=20
-		fprintf(out, " size=3D%u vlen=3D%u", t->size, vlen);
+		fmt_str =3D btf_kflag(t) ? "\n\t'%s' val=3D%d" : "\n\t'%s' val=3D%u";
+		fprintf(out, " encoding=3D%s size=3D%u vlen=3D%u",
+			btf_kflag(t) ? "SIGNED" : "UNSIGNED", t->size, vlen);
 		for (i =3D 0; i < vlen; i++, v++) {
-			fprintf(out, "\n\t'%s' val=3D%u",
+			fprintf(out, fmt_str,
 				btf_str(btf, v->name_off), v->val);
 		}
 		break;
 	}
+	case BTF_KIND_ENUM64: {
+		const struct btf_enum64 *v =3D btf_enum64(t);
+		const char *fmt_str;
+
+		fmt_str =3D btf_kflag(t) ? "\n\t'%s' val=3D%lld" : "\n\t'%s' val=3D%ll=
u";
+
+		fprintf(out, " encoding=3D%s size=3D%u vlen=3D%u",
+			btf_kflag(t) ? "SIGNED" : "UNSIGNED", t->size, vlen);
+		for (i =3D 0; i < vlen; i++, v++) {
+			fprintf(out, fmt_str,
+				btf_str(btf, v->name_off),
+				((__u64)v->val_hi32 << 32) | v->val_lo32);
+		}
+		break;
+	}
 	case BTF_KIND_FWD:
 		fprintf(out, " fwd_kind=3D%s", btf_kflag(t) ? "union" : "struct");
 		break;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
index addf99c05896..6e36de1302fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -9,6 +9,7 @@ static void gen_btf(struct btf *btf)
 	const struct btf_var_secinfo *vi;
 	const struct btf_type *t;
 	const struct btf_member *m;
+	const struct btf_enum64 *v64;
 	const struct btf_enum *v;
 	const struct btf_param *p;
 	int id, err, str_off;
@@ -171,7 +172,7 @@ static void gen_btf(struct btf *btf)
 	ASSERT_STREQ(btf__str_by_offset(btf, v->name_off), "v2", "v2_name");
 	ASSERT_EQ(v->val, 2, "v2_val");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 9),
-		     "[9] ENUM 'e1' size=3D4 vlen=3D2\n"
+		     "[9] ENUM 'e1' encoding=3DUNSIGNED size=3D4 vlen=3D2\n"
 		     "\t'v1' val=3D1\n"
 		     "\t'v2' val=3D2", "raw_dump");
=20
@@ -202,7 +203,7 @@ static void gen_btf(struct btf *btf)
 	ASSERT_EQ(btf_vlen(t), 0, "enum_fwd_kind");
 	ASSERT_EQ(t->size, 4, "enum_fwd_sz");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 12),
-		     "[12] ENUM 'enum_fwd' size=3D4 vlen=3D0", "raw_dump");
+		     "[12] ENUM 'enum_fwd' encoding=3DUNSIGNED size=3D4 vlen=3D0", "ra=
w_dump");
=20
 	/* TYPEDEF */
 	id =3D btf__add_typedef(btf, "typedef1", 1);
@@ -307,6 +308,48 @@ static void gen_btf(struct btf *btf)
 	ASSERT_EQ(t->type, 1, "tag_type");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 20),
 		     "[20] TYPE_TAG 'tag1' type_id=3D1", "raw_dump");
+
+	/* ENUM64 */
+	id =3D btf__add_enum64(btf, "e1", 8, true);
+	ASSERT_EQ(id, 21, "enum64_id");
+	err =3D btf__add_enum64_value(btf, "v1", -1);
+	ASSERT_OK(err, "v1_res");
+	err =3D btf__add_enum64_value(btf, "v2", 0x123456789); /* 4886718345 */
+	ASSERT_OK(err, "v2_res");
+	t =3D btf__type_by_id(btf, 21);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "e1", "enum64_name")=
;
+	ASSERT_EQ(btf_kind(t), BTF_KIND_ENUM64, "enum64_kind");
+	ASSERT_EQ(btf_vlen(t), 2, "enum64_vlen");
+	ASSERT_EQ(t->size, 8, "enum64_sz");
+	v64 =3D btf_enum64(t) + 0;
+	ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v1", "v1_name");
+	ASSERT_EQ(v64->val_hi32, 0xffffffff, "v1_val");
+	ASSERT_EQ(v64->val_lo32, 0xffffffff, "v1_val");
+	v64 =3D btf_enum64(t) + 1;
+	ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v2", "v2_name");
+	ASSERT_EQ(v64->val_hi32, 0x1, "v2_val");
+	ASSERT_EQ(v64->val_lo32, 0x23456789, "v2_val");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 21),
+		     "[21] ENUM64 'e1' encoding=3DSIGNED size=3D8 vlen=3D2\n"
+		     "\t'v1' val=3D-1\n"
+		     "\t'v2' val=3D4886718345", "raw_dump");
+
+	id =3D btf__add_enum64(btf, "e1", 8, false);
+	ASSERT_EQ(id, 22, "enum64_id");
+	err =3D btf__add_enum64_value(btf, "v1", 0xffffffffFFFFFFFF); /* 184467=
44073709551615 */
+	ASSERT_OK(err, "v1_res");
+	t =3D btf__type_by_id(btf, 22);
+	ASSERT_STREQ(btf__str_by_offset(btf, t->name_off), "e1", "enum64_name")=
;
+	ASSERT_EQ(btf_kind(t), BTF_KIND_ENUM64, "enum64_kind");
+	ASSERT_EQ(btf_vlen(t), 1, "enum64_vlen");
+	ASSERT_EQ(t->size, 8, "enum64_sz");
+	v64 =3D btf_enum64(t) + 0;
+	ASSERT_STREQ(btf__str_by_offset(btf, v64->name_off), "v1", "v1_name");
+	ASSERT_EQ(v64->val_hi32, 0xffffffff, "v1_val");
+	ASSERT_EQ(v64->val_lo32, 0xffffffff, "v1_val");
+	ASSERT_STREQ(btf_type_raw_dump(btf, 22),
+		     "[22] ENUM64 'e1' encoding=3DUNSIGNED size=3D8 vlen=3D1\n"
+		     "\t'v1' val=3D18446744073709551615", "raw_dump");
 }
=20
 static void test_btf_add()
@@ -332,12 +375,12 @@ static void test_btf_add()
 		"\t'f2' type_id=3D1 bits_offset=3D32 bitfield_size=3D16",
 		"[8] UNION 'u1' size=3D8 vlen=3D1\n"
 		"\t'f1' type_id=3D1 bits_offset=3D0 bitfield_size=3D16",
-		"[9] ENUM 'e1' size=3D4 vlen=3D2\n"
+		"[9] ENUM 'e1' encoding=3DUNSIGNED size=3D4 vlen=3D2\n"
 		"\t'v1' val=3D1\n"
 		"\t'v2' val=3D2",
 		"[10] FWD 'struct_fwd' fwd_kind=3Dstruct",
 		"[11] FWD 'union_fwd' fwd_kind=3Dunion",
-		"[12] ENUM 'enum_fwd' size=3D4 vlen=3D0",
+		"[12] ENUM 'enum_fwd' encoding=3DUNSIGNED size=3D4 vlen=3D0",
 		"[13] TYPEDEF 'typedef1' type_id=3D1",
 		"[14] FUNC 'func1' type_id=3D15 linkage=3Dglobal",
 		"[15] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D2\n"
@@ -348,7 +391,12 @@ static void test_btf_add()
 		"\ttype_id=3D1 offset=3D4 size=3D8",
 		"[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1",
 		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1",
-		"[20] TYPE_TAG 'tag1' type_id=3D1");
+		"[20] TYPE_TAG 'tag1' type_id=3D1",
+		"[21] ENUM64 'e1' encoding=3DSIGNED size=3D8 vlen=3D2\n"
+		"\t'v1' val=3D-1\n"
+		"\t'v2' val=3D4886718345",
+		"[22] ENUM64 'e1' encoding=3DUNSIGNED size=3D8 vlen=3D1\n"
+		"\t'v1' val=3D18446744073709551615");
=20
 	btf__free(btf);
 }
@@ -370,7 +418,7 @@ static void test_btf_add_btf()
 	gen_btf(btf2);
=20
 	id =3D btf__add_btf(btf1, btf2);
-	if (!ASSERT_EQ(id, 21, "id"))
+	if (!ASSERT_EQ(id, 23, "id"))
 		goto cleanup;
=20
 	VALIDATE_RAW_BTF(
@@ -386,12 +434,12 @@ static void test_btf_add_btf()
 		"\t'f2' type_id=3D1 bits_offset=3D32 bitfield_size=3D16",
 		"[8] UNION 'u1' size=3D8 vlen=3D1\n"
 		"\t'f1' type_id=3D1 bits_offset=3D0 bitfield_size=3D16",
-		"[9] ENUM 'e1' size=3D4 vlen=3D2\n"
+		"[9] ENUM 'e1' encoding=3DUNSIGNED size=3D4 vlen=3D2\n"
 		"\t'v1' val=3D1\n"
 		"\t'v2' val=3D2",
 		"[10] FWD 'struct_fwd' fwd_kind=3Dstruct",
 		"[11] FWD 'union_fwd' fwd_kind=3Dunion",
-		"[12] ENUM 'enum_fwd' size=3D4 vlen=3D0",
+		"[12] ENUM 'enum_fwd' encoding=3DUNSIGNED size=3D4 vlen=3D0",
 		"[13] TYPEDEF 'typedef1' type_id=3D1",
 		"[14] FUNC 'func1' type_id=3D15 linkage=3Dglobal",
 		"[15] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D2\n"
@@ -403,36 +451,46 @@ static void test_btf_add_btf()
 		"[18] DECL_TAG 'tag1' type_id=3D16 component_idx=3D-1",
 		"[19] DECL_TAG 'tag2' type_id=3D14 component_idx=3D1",
 		"[20] TYPE_TAG 'tag1' type_id=3D1",
+		"[21] ENUM64 'e1' encoding=3DSIGNED size=3D8 vlen=3D2\n"
+		"\t'v1' val=3D-1\n"
+		"\t'v2' val=3D4886718345",
+		"[22] ENUM64 'e1' encoding=3DUNSIGNED size=3D8 vlen=3D1\n"
+		"\t'v1' val=3D18446744073709551615",
=20
 		/* types appended from the second BTF */
-		"[21] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNE=
D",
-		"[22] PTR '(anon)' type_id=3D21",
-		"[23] CONST '(anon)' type_id=3D25",
-		"[24] VOLATILE '(anon)' type_id=3D23",
-		"[25] RESTRICT '(anon)' type_id=3D24",
-		"[26] ARRAY '(anon)' type_id=3D22 index_type_id=3D21 nr_elems=3D10",
-		"[27] STRUCT 's1' size=3D8 vlen=3D2\n"
-		"\t'f1' type_id=3D21 bits_offset=3D0\n"
-		"\t'f2' type_id=3D21 bits_offset=3D32 bitfield_size=3D16",
-		"[28] UNION 'u1' size=3D8 vlen=3D1\n"
-		"\t'f1' type_id=3D21 bits_offset=3D0 bitfield_size=3D16",
-		"[29] ENUM 'e1' size=3D4 vlen=3D2\n"
+		"[23] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNE=
D",
+		"[24] PTR '(anon)' type_id=3D23",
+		"[25] CONST '(anon)' type_id=3D27",
+		"[26] VOLATILE '(anon)' type_id=3D25",
+		"[27] RESTRICT '(anon)' type_id=3D26",
+		"[28] ARRAY '(anon)' type_id=3D24 index_type_id=3D23 nr_elems=3D10",
+		"[29] STRUCT 's1' size=3D8 vlen=3D2\n"
+		"\t'f1' type_id=3D23 bits_offset=3D0\n"
+		"\t'f2' type_id=3D23 bits_offset=3D32 bitfield_size=3D16",
+		"[30] UNION 'u1' size=3D8 vlen=3D1\n"
+		"\t'f1' type_id=3D23 bits_offset=3D0 bitfield_size=3D16",
+		"[31] ENUM 'e1' encoding=3DUNSIGNED size=3D4 vlen=3D2\n"
 		"\t'v1' val=3D1\n"
 		"\t'v2' val=3D2",
-		"[30] FWD 'struct_fwd' fwd_kind=3Dstruct",
-		"[31] FWD 'union_fwd' fwd_kind=3Dunion",
-		"[32] ENUM 'enum_fwd' size=3D4 vlen=3D0",
-		"[33] TYPEDEF 'typedef1' type_id=3D21",
-		"[34] FUNC 'func1' type_id=3D35 linkage=3Dglobal",
-		"[35] FUNC_PROTO '(anon)' ret_type_id=3D21 vlen=3D2\n"
-		"\t'p1' type_id=3D21\n"
-		"\t'p2' type_id=3D22",
-		"[36] VAR 'var1' type_id=3D21, linkage=3Dglobal-alloc",
-		"[37] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
-		"\ttype_id=3D21 offset=3D4 size=3D8",
-		"[38] DECL_TAG 'tag1' type_id=3D36 component_idx=3D-1",
-		"[39] DECL_TAG 'tag2' type_id=3D34 component_idx=3D1",
-		"[40] TYPE_TAG 'tag1' type_id=3D21");
+		"[32] FWD 'struct_fwd' fwd_kind=3Dstruct",
+		"[33] FWD 'union_fwd' fwd_kind=3Dunion",
+		"[34] ENUM 'enum_fwd' encoding=3DUNSIGNED size=3D4 vlen=3D0",
+		"[35] TYPEDEF 'typedef1' type_id=3D23",
+		"[36] FUNC 'func1' type_id=3D37 linkage=3Dglobal",
+		"[37] FUNC_PROTO '(anon)' ret_type_id=3D23 vlen=3D2\n"
+		"\t'p1' type_id=3D23\n"
+		"\t'p2' type_id=3D24",
+		"[38] VAR 'var1' type_id=3D23, linkage=3Dglobal-alloc",
+		"[39] DATASEC 'datasec1' size=3D12 vlen=3D1\n"
+		"\ttype_id=3D23 offset=3D4 size=3D8",
+		"[40] DECL_TAG 'tag1' type_id=3D38 component_idx=3D-1",
+		"[41] DECL_TAG 'tag2' type_id=3D36 component_idx=3D1",
+		"[42] TYPE_TAG 'tag1' type_id=3D23",
+		"[43] ENUM64 'e1' encoding=3DSIGNED size=3D8 vlen=3D2\n"
+		"\t'v1' val=3D-1\n"
+		"\t'v2' val=3D4886718345",
+		"[44] ENUM64 'e1' encoding=3DUNSIGNED size=3D8 vlen=3D1\n"
+		"\t'v1' val=3D18446744073709551615");
=20
 cleanup:
 	btf__free(btf1);
--=20
2.30.2

