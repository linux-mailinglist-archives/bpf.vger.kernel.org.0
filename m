Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603B940BB71
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhINWcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:32:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61592 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235137AbhINWcI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:32:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EKFxh6016027
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BAmddFvyPAZbZ3tSmHHINawKpApXgi7b/STKGoWs7Tc=;
 b=BnXUx8XFIC1HSqxP+m9BQTjewiVF/YFaONre+/curmhQ8vvYH8vC01cjTPUeqdkLXQLn
 aC3K1/EfXWaBd5H/YVbBdHMasni1vNLbtfUN7GvDu/kmz6qr2CfoW2oG/X1v75OlfTj8
 MwkS3Nb/gpmJ2utBMl+Kg01I7RcWoW52ulM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2s334m3t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:50 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:48 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5A3477382251; Tue, 14 Sep 2021 15:30:47 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 08/11] selftests/bpf: add BTF_KIND_TAG unit tests
Date:   Tue, 14 Sep 2021 15:30:47 -0700
Message-ID: <20210914223047.248223-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9k4OnDXTPI67LghW6nS-DO5urAVX7hNR
X-Proofpoint-ORIG-GUID: 9k4OnDXTPI67LghW6nS-DO5urAVX7hNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test good and bad variants of BTF_KIND_TAG encoding.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 245 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   3 +
 2 files changed, 248 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ad39f4d588d0..b4e86a8423cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3661,6 +3661,249 @@ static struct btf_raw_test raw_tests[] =3D {
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
+		BTF_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_TAG_ENC(NAME_TBD, 2, 0),
+		BTF_TAG_ENC(NAME_TBD, 2, 1),
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
+		BTF_UNION_ENC(NAME_TBD, 2, 4),			/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_TAG_ENC(NAME_TBD, 2, 0),
+		BTF_TAG_ENC(NAME_TBD, 2, 1),
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
+		BTF_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_TAG_ENC(NAME_TBD, 3, -1),
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
+		BTF_TAG_ENC(NAME_TBD, 3, -1),
+		BTF_TAG_ENC(NAME_TBD, 3, 0),
+		BTF_TAG_ENC(NAME_TBD, 3, 1),
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
+	.descr =3D "tag test #5, invalid value",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TAG_ENC(0, 2, -1),
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
+	.err_str =3D "Invalid value",
+},
+{
+	.descr =3D "tag test #6, invalid target type",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TAG_ENC(NAME_TBD, 1, -1),
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
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 0, 1), 2), (0),
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
+	.descr =3D "tag test #8, invalid kflag",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_TAG, 1, 0), 2), (-1),
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
+	.err_str =3D "Invalid btf_info kind_flag",
+},
+{
+	.descr =3D "tag test #9, var, invalid component_idx",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_TAG_ENC(NAME_TBD, 2, 0),
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
+	.err_str =3D "Invalid component_idx",
+},
+{
+	.descr =3D "tag test #10, struct member, invalid component_idx",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
+		BTF_TAG_ENC(NAME_TBD, 2, 2),
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
+	.err_str =3D "Invalid component_idx",
+},
+{
+	.descr =3D "tag test #11, func parameter, invalid component_idx",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
+		BTF_TAG_ENC(NAME_TBD, 3, 2),
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
+	.err_str =3D "Invalid component_idx",
+},
+{
+	.descr =3D "tag test #12, < -1 component_idx",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+		BTF_FUNC_ENC(NAME_TBD, 2),			/* [3] */
+		BTF_TAG_ENC(NAME_TBD, 3, -2),
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
+	.err_str =3D "Invalid component_idx",
+},
+
 }; /* struct btf_raw_test raw_tests[] */
=20
 static const char *get_next_str(const char *start, const char *end)
@@ -6801,6 +7044,8 @@ static int btf_type_size(const struct btf_type *t)
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
index e2394eea4b7f..0619e06d745e 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -69,4 +69,7 @@
 #define BTF_TYPE_FLOAT_ENC(name, sz) \
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_FLOAT, 0, 0), sz)
=20
+#define BTF_TAG_ENC(value, type, component_idx)	\
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TAG, 0, 0), type), (component=
_idx)
+
 #endif /* _TEST_BTF_H */
--=20
2.30.2

