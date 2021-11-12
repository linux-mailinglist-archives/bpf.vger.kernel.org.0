Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75844DFBC
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 02:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhKLB3b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 20:29:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233817AbhKLB3b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 20:29:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC0vPlV024616
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:26:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3ydq1cnGX6N9qEZH+Ap2NgdFgMNcvdtVH+0L2PJQi48=;
 b=gUq/k5ppLT+AJtBWzBJ52YzfE+76Svlo8YvI6+v8fRJQomLvnDff52Z2JytCx5yCqHvB
 U8zx0uWalhT7U8/C+t0DBHQzSZCLNCP9zmr47UqI31LK8aGO5gCvK73rpRL0dL5r/WaP
 DhJCHrdfG+kdTsuAgF1hYqWspcU0NaYQf1M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9cfvrw4j-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:26:41 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 17:26:40 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A0F9D24C5B58; Thu, 11 Nov 2021 17:26:30 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 05/10] selftests/bpf: Add BTF_KIND_TYPE_TAG unit tests
Date:   Thu, 11 Nov 2021 17:26:30 -0800
Message-ID: <20211112012630.1506095-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112012604.1504583-1-yhs@fb.com>
References: <20211112012604.1504583-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: rpqRmqyBt3rZJxP2tAKiclTHnTHh1uo4
X-Proofpoint-ORIG-GUID: rpqRmqyBt3rZJxP2tAKiclTHnTHh1uo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=972 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120005
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
index 1e8b36d74df2..88510a2d9858 100644
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
@@ -7222,6 +7239,7 @@ static int btf_type_size(const struct btf_type *t)
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

