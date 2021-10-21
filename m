Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB94A436B9C
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 21:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJUT64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 15:58:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37326 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhJUT6z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 15:58:55 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LJatE2031497
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4Ydcj3TvevGCnnYesXDMNwLk/DC158NimeuZyR9OqMg=;
 b=rqn0txmt0VVk9D2MUnGBdJEyCN8/gauTXJx+MUwTx4vAVrnrZk1rdFLebiQcDS3B9WL4
 oTAmCbTQdHiv3UAVKiilJnMiI6pRwS8wlFV2RfQvaca67JXWTWL0uBF/mJDfwW8hqiMC
 EEiSlARrAikbsTHPV8niC5+xG7oL+9xEfw0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bu5b156nr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:38 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 12:56:36 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 677AC1516820; Thu, 21 Oct 2021 12:56:33 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: add BTF_KIND_DECL_TAG typedef unit tests
Date:   Thu, 21 Oct 2021 12:56:33 -0700
Message-ID: <20211021195633.4019472-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021195622.4018339-1-yhs@fb.com>
References: <20211021195622.4018339-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: frIgNWngbEFuVgjvxy4Qtpef5_Sqa6uS
X-Proofpoint-ORIG-GUID: frIgNWngbEFuVgjvxy4Qtpef5_Sqa6uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_05,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=890 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110210101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test good and bad variants of typedef BTF_KIND_DECL_TAG encoding.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index fa67f25bbef5..a00418b8b252 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3903,6 +3903,42 @@ static struct btf_raw_test raw_tests[] =3D {
 	.btf_load_err =3D true,
 	.err_str =3D "Invalid component_idx",
 },
+{
+	.descr =3D "decl_tag test #13, typedef, well-formed",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPEDEF_ENC(NAME_TBD, 1),			/* [2] */
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0t\0tag"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+},
+{
+	.descr =3D "decl_tag test #14, typedef, invalid component_idx",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPEDEF_ENC(NAME_TBD, 1),			/* [2] */
+		BTF_DECL_TAG_ENC(NAME_TBD, 2, 0),
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
=20
 }; /* struct btf_raw_test raw_tests[] */
=20
--=20
2.30.2

