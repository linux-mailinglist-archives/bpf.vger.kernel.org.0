Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00FC403153
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbhIGXCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10620 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347270AbhIGXCg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:36 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187MwR86008595
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jwUYPAGPi02miBUI0f82fy10tJ7Nsvi2nZ0IwGDTmJ4=;
 b=EZrm+wBPuiJu2ev4FAQpkaEoe1P636iorKAelXHVAClHobMbeSyXCFXHEjLhfwU8L+kv
 BUKBWcLuV3Tb3W6qHokcsUD2a4FeD+McYdbTD+55u18QruhE1+eQZpNH4SLYHYt3l8Ol
 0ZBFEhNxhrQUYyyVpoAjYiUTLH4wzddHvyY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpgj77w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:28 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:01:26 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 480FA6E0C0E5; Tue,  7 Sep 2021 16:01:22 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: add BTF_KIND_TAG unit tests
Date:   Tue, 7 Sep 2021 16:01:22 -0700
Message-ID: <20210907230122.1959771-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: CjI3boNHnPFq7qbBegc2WiZkcn-mCjep
X-Proofpoint-GUID: CjI3boNHnPFq7qbBegc2WiZkcn-mCjep
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test good and bad variants of BTF_KIND_TAG encoding.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 223 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   6 +
 2 files changed, 229 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 649f87382c8d..5e07a2f61486 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3661,6 +3661,227 @@ static struct btf_raw_test raw_tests[] =3D {
 	.err_str =3D "Invalid type_size",
 },
=20
+{
+	.descr =3D "tag test #1, struct/member, well-formed",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
+		BTF_TAG_KIND_ENC(NAME_TBD, 2),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 2, 0),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 2, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0m1\0m2\0tag1\0tag2\0tag3"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 8,
+	.key_type_id =3D 1,
+	.value_type_id =3D 2,
+	.max_entries =3D 1,
+},
+{
+	.descr =3D "tag test #2, union/member, well-formed",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(NAME_TBD, 2, 4),			/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_TAG_KIND_ENC(NAME_TBD, 2),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 2, 0),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 2, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 2,
+	.max_entries =3D 1,
+},
+{
+	.descr =3D "tag test #3, variable, well-formed",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_VAR_ENC(NAME_TBD, 1, 1),			/* [3] */
+		BTF_TAG_KIND_ENC(NAME_TBD, 2),
+		BTF_TAG_KIND_ENC(NAME_TBD, 3),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0global\0tag1\0tag2"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+},
+{
+	.descr =3D "tag test #4, func/parameter, well-formed",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
+		BTF_TAG_KIND_ENC(NAME_TBD, 3),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 3, 0),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 3, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0arg1\0arg2\0f\0tag1\0tag2\0tag3"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+},
+{
+	.descr =3D "tag test #5, invalid name",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TAG_KIND_ENC(0, 2),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Invalid name",
+},
+{
+	.descr =3D "tag test #6, invalid target type",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TAG_KIND_ENC(NAME_TBD, 1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag1"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Invalid type",
+},
+{
+	.descr =3D "tag test #7, invalid vlen",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 1), 2), (0),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0tag1"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "vlen !=3D 0",
+},
+{
+	.descr =3D "tag test #8, kflag/comp_id mismatch ",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), 2), (1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0tag1"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "kflag/comp_id mismatch",
+},
+{
+	.descr =3D "tag test #9, invalid next_type",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), 2), (0),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0local\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Invalid next_type",
+},
+{
+	.descr =3D "tag test #10, struct member, invalid comp_id",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 2, 2),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0m1\0m2\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 8,
+	.key_type_id =3D 1,
+	.value_type_id =3D 2,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Invalid comp_id",
+},
+{
+	.descr =3D "tag test #11, func parameter, invalid comp_id",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
+		BTF_TAG_COMP_ID_ENC(NAME_TBD, 3, 2),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0arg1\0arg2\0f\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Invalid comp_id",
+},
+
 }; /* struct btf_raw_test raw_tests[] */
=20
 static const char *get_next_str(const char *start, const char *end)
@@ -6801,6 +7022,8 @@ static int btf_type_size(const struct btf_type *t)
 		return base_size + sizeof(struct btf_var);
 	case BTF_KIND_DATASEC:
 		return base_size + vlen * sizeof(struct btf_var_secinfo);
+	case BTF_KIND_TAG:
+		return base_size + sizeof(struct btf_tag);
 	default:
 		fprintf(stderr, "Unsupported BTF_KIND:%u\n", kind);
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selft=
ests/bpf/test_btf.h
index e2394eea4b7f..d0dcf5a9a8f1 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -69,4 +69,10 @@
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
=20
+#define BTF_TAG_KIND_ENC(name, type)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), type), (0)
+
+#define BTF_TAG_COMP_ID_ENC(name, type, comp_id)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (comp_id)
+
 #endif /* _TEST_BTF_H */
--=20
2.30.2

