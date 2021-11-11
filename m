Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C744DE77
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhKKX2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:28:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37930 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhKKX2y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:28:54 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABNKqMw031790
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VGzWXxwe0xjTQKcrKXPP+FuiYOLYaan5Pc29qZZioT0=;
 b=aH8gkbZ5Oq7kIZMmINCiOQ/3MDd7DXJU6iPrjisvU59kUZLYonDcjVOFjnAK/4zboeSa
 RNI7EKPg9q2fTqFKdQGQ0ArUVDbtICfFVefvWA58smuhbIC/Zbv8+DKfBMVx4G4j3aF2
 UQmCYL5hAlHw7dzbnxsdGrbQ8Bm5d0WOJjk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9bp7rdwk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:05 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:26:03 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3D38224B3DCA; Thu, 11 Nov 2021 15:25:59 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 03/10] bpftool: Support BTF_KIND_TYPE_TAG
Date:   Thu, 11 Nov 2021 15:25:59 -0800
Message-ID: <20211111232559.788814-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 1MMh4qdF72vGUHUvL2_AINOZZWXB9S-s
X-Proofpoint-ORIG-GUID: 1MMh4qdF72vGUHUvL2_AINOZZWXB9S-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=877
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpftool support for BTF_KIND_TYPE_TAG.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 015d2758f826..e77dda35d1de 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -39,6 +39,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =3D=
 {
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
 	[BTF_KIND_DECL_TAG]	=3D "DECL_TAG",
+	[BTF_KIND_TYPE_TAG]	=3D "TYPE_TAG",
 };
=20
 struct btf_attach_point {
@@ -142,6 +143,7 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_TYPE_TAG:
 		if (json_output)
 			jsonw_uint_field(w, "type_id", t->type);
 		else
--=20
2.30.2

