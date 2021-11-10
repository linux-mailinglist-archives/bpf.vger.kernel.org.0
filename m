Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9581F44BB44
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhKJFiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:38:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhKJFiU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:38:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA5SPpi024134
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:35:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tfCjNzQ2rQRKcEuF+O/mbAuG4abDU/XspOPKy2BNuRI=;
 b=oZMLgiSSMJFCdNbv+LOnheJsYGlFvKr/gh/loWnqyddjbtX+/tdb+U5RhuSphInlLvys
 vNk6ksi4fZBHyJQdHPT8DRy54SSSGbwOeMpaX4o7JJRgqwMUkhFglKUs1530u0k7MP1e
 xq9o9/8tf5Vyu7JKaXLemaCRcYnXnXBu7n4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7vm9mg11-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:35:32 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:20:10 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 401B223611C6; Tue,  9 Nov 2021 21:20:07 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 05/10] selftests/bpf: Add BTF_KIND_TYPE_TAG unit tests
Date:   Tue, 9 Nov 2021 21:20:07 -0800
Message-ID: <20211110052007.371167-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: JCFLpB-pWRpyV1w7N3fXpslFHnEf7pou
X-Proofpoint-ORIG-GUID: JCFLpB-pWRpyV1w7N3fXpslFHnEf7pou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=997 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TYPE_TAG unit tests.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index ebd1aa4d09d6..ebd0ead5f4bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3939,6 +3939,23 @@ static struct btf_raw_test raw_tests[] =3D {
 	.btf_load_err =3D true,
 	.err_str =3D "Invalid component_idx",
 },
+{
+	.descr =3D "type_tag test #1",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_TAG_ENC(NAME_TBD, 1),			/* [2] */
+		BTF_PTR_ENC(2),					/* [3] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+},
=20
 }; /* struct btf_raw_test raw_tests[] */
=20
@@ -7255,6 +7272,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FUNC:
 	case BTF_KIND_FLOAT:
+	case BTF_KIND_TYPE_TAG:
 		return base_size;
 	case BTF_KIND_INT:
 		return base_size + sizeof(__u32);
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selft=
ests/bpf/test_btf.h
index 32c7a57867da..128989bed8b7 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -72,4 +72,7 @@
 #define BTF_DECL_TAG_ENC(value, type, component_idx)	\
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), type), (comp=
onent_idx)
=20
+#define BTF_TYPE_TAG_ENC(value, type)	\
+	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
+
 #endif /* _TEST_BTF_H */
--=20
2.30.2

