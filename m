Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F34A8C58
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353735AbiBCTR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 14:17:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353734AbiBCTR5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 14:17:57 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213I6Ux7007278
        for <bpf@vger.kernel.org>; Thu, 3 Feb 2022 11:17:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d/6oZcbJ30i6umXwTlbwyD1stQb1/Q05sC4hnI004vc=;
 b=JgcbQhVm0P77irOa4Pyp6fdh3xig+4EMa24Vu4t1pZ4Uip8rK+ElNE8D5ovFl1+IHOy6
 0p3shLQKBeEJLzNXz7c3vMZYeCa1ReWFojDOVmzfjQkwNARcTzsVIF4kuGzXha0XRVQJ
 cHBwA+ShpD7VFme5A1bRJuaRmo6i5uHSvcw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e058jwkam-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 11:17:57 -0800
Received: from twshared19733.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 11:17:34 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9D8515EED8ED; Thu,  3 Feb 2022 11:17:32 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf 2/2] selftests/bpf: add a selftest for invalid func btf with btf decl_tag
Date:   Thu, 3 Feb 2022 11:17:32 -0800
Message-ID: <20220203191732.742285-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203191727.741862-1-yhs@fb.com>
References: <20220203191727.741862-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: K0-wh89yW5uSrNXKg-j73KzS7BnmLl_D
X-Proofpoint-ORIG-GUID: K0-wh89yW5uSrNXKg-j73KzS7BnmLl_D
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=626 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a selftest similar to [1] which exposed a kernel bug.
Without the fix in the previous patch, the similar kasan error will appear.

  [1] https://lore.kernel.org/bpf/0000000000009b6eaa05d71a8c06@google.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index 8ba53acf9eb4..1f20a27e8210 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3938,6 +3938,25 @@ static struct btf_raw_test raw_tests[] =3D {
 	.btf_load_err =3D true,
 	.err_str =3D "Invalid component_idx",
 },
+{
+	.descr =3D "decl_tag test #15, func, invalid func proto",
+	.raw_types =3D {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_DECL_TAG_ENC(NAME_TBD, 3, 0),		/* [2] */
+		BTF_FUNC_ENC(NAME_TBD, 8),			/* [3] */
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0tag\0func"),
+	.map_type =3D BPF_MAP_TYPE_ARRAY,
+	.map_name =3D "tag_type_check_btf",
+	.key_size =3D sizeof(int),
+	.value_size =3D 4,
+	.key_type_id =3D 1,
+	.value_type_id =3D 1,
+	.max_entries =3D 1,
+	.btf_load_err =3D true,
+	.err_str =3D "Invalid type_id",
+},
 {
 	.descr =3D "type_tag test #1",
 	.raw_types =3D {
--=20
2.30.2

