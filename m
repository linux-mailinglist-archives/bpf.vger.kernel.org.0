Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D84439D5
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhKBXiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:38:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49236 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhKBXh4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 19:37:56 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2La0KO003887
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 16:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=P5d+poJcon1741CJ3u9XR6weHHom5/UpQ0U/mTt5ugY=;
 b=neTPNTdOdPylGdjcalCBLRCZtaIekxq/WDVIT37APacvHsSeMYODjELXU8DPCvzDxZgB
 lWnydvBsIhvR8+HwEqVmmT13CeGBq80VUp1dCiTUtKSrVuB4nR4TXITKsy1krKWB0ezs
 SWiXdEMkn9BRVfxVFO9g6WQ8qTuaV+tfDjY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dcs0s1y-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 16:35:18 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 16:35:17 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8AC2F1DE8031; Tue,  2 Nov 2021 16:35:10 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 2/2] btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag attributes
Date:   Tue, 2 Nov 2021 16:35:10 -0700
Message-ID: <20211102233510.1025414-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102233500.1024582-1-yhs@fb.com>
References: <20211102233500.1024582-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SSr4ZjVXgfm9jkPe0WAhGDcON6pVwZHx
X-Proofpoint-ORIG-GUID: SSr4ZjVXgfm9jkPe0WAhGDcON6pVwZHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=882 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Emit BTF BTF_KIND_DECL_TAGs for btf_decl_tag attributes attached to
typedef declarations. The following is a simple example:
  $ cat t.c
    #define __tag1 __attribute__((btf_decl_tag("tag1")))
    #define __tag2 __attribute__((btf_decl_tag("tag2")))
    typedef struct { int a; int b; } __t __tag1 __tag2;
    __t g;
  $ clang -O2 -g -c t.c
  $ pahole -JV t.o
    btf_encoder__new: 't.o' doesn't have '.data..percpu' section
    Found 0 per-CPU variables!
    File t.o:
    [1] TYPEDEF __t type_id=3D2
    [2] STRUCT (anon) size=3D8
            a type_id=3D3 bits_offset=3D0
            b type_id=3D3 bits_offset=3D32
    [3] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
    [4] DECL_TAG tag1 type_id=3D1 component_idx=3D-1
    [5] DECL_TAG tag2 type_id=3D1 component_idx=3D-1

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 40f6aa3..117656e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1438,9 +1438,21 @@ int btf_encoder__encode_cu(struct btf_encoder *enc=
oder, struct cu *cu)
=20
 	cu__for_each_type(cu, core_id, pos) {
 		struct namespace *ns;
+		const char *tag_name;
=20
-		if (pos->tag !=3D DW_TAG_structure_type && pos->tag !=3D DW_TAG_union_=
type)
+		switch (pos->tag) {
+		case DW_TAG_structure_type:
+			tag_name =3D "struct";
+			break;
+		case DW_TAG_union_type:
+			tag_name =3D "union";
+			break;
+		case DW_TAG_typedef:
+			tag_name =3D "typedef";
+			break;
+		default:
 			continue;
+		}
=20
 		btf_type_id =3D type_id_off + core_id;
 		ns =3D tag__namespace(pos);
@@ -1448,8 +1460,7 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu)
 			tag_type_id =3D btf_encoder__add_decl_tag(encoder, annot->value, btf_=
type_id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with co=
mponent_idx %d\n",
-					annot->value, pos->tag =3D=3D DW_TAG_structure_type ? "struct" : "u=
nion",
-					namespace__name(ns), annot->component_idx);
+					annot->value, tag_name, namespace__name(ns), annot->component_idx);
 				goto out;
 			}
 		}
--=20
2.30.2

