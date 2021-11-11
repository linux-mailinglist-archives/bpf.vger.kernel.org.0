Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E20B44DE79
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhKKX3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:29:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56734 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233119AbhKKX3J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:29:09 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ABN4gb0031824
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tBwZY5DJMJI2ahD/od5TQpeZhpzbVRL/8y3nCbHkPYI=;
 b=HUWuRj31z6Z7cFCbi1kpzTu6Ky4vRaoLkJdDd6r2wy/O0wjVFaUkENJ7CHOYthhbg5a1
 BPkAGLFKrbMGGrYuQQ/zhDX+VU1mkzbegeuWzw8G2zDCmPmIbBIiraXLH9h4WbXqHcO6
 cGzVgfuj89PztIRrbVoUtk8YX19bFxcwdnA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c9brfggtt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:19 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:26:17 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 613E624B3E1D; Thu, 11 Nov 2021 15:26:10 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 05/10] selftests/bpf: Add BTF_KIND_TYPE_TAG unit tests
Date:   Thu, 11 Nov 2021 15:26:10 -0800
Message-ID: <20211111232610.789922-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: csw-MThVhJ3vXeu75b3Afg0HKk1GHFbn
X-Proofpoint-GUID: csw-MThVhJ3vXeu75b3Afg0HKk1GHFbn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=968 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TYPE_TAG unit tests.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

