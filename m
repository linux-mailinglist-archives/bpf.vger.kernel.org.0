Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30FB4439D2
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhKBXho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:37:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhKBXhn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 19:37:43 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LZj4Z006650
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 16:35:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yV9eNydbtuV4V15vifsf21aUybt3/ZVpH/BundjH2hk=;
 b=PZlhUx6ccgxrBhMJFuBceJPHg+M8y/A0h8ODIdnQy5eNzBj0TVeTbtX2DYb7D2WUOD79
 MWwKo1sD4BRGkgGIsUn90k2fIskCIQHkseHXVtgYZXneuxZZNP37naLc5ZyoCuJ0ci9N
 wbh3A8kG1UQBDSUoyKkSNPmwR3sWWy3b+Jo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dcmrrn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 16:35:08 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 16:35:06 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5AC681DE8025; Tue,  2 Nov 2021 16:35:05 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 1/2] dwarf_loader: support typedef DW_TAG_LLVM_annotation
Date:   Tue, 2 Nov 2021 16:35:05 -0700
Message-ID: <20211102233505.1025198-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102233500.1024582-1-yhs@fb.com>
References: <20211102233500.1024582-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: T6sCE8Vao51EBwh45u_AS2dfhobxCaam
X-Proofpoint-ORIG-GUID: T6sCE8Vao51EBwh45u_AS2dfhobxCaam
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

llvm commit ([1]) added support for btf_decl_tag attribute
with typedef declaration. Eventually, DW_TAG_LLVM_annotation
tag may appear inside dwarf typedef declaration tag.

kernel support for typedef BTF_KIND_DECL_TAG support
is introduced in [2]. There is no additional libbpf
change needed as the previous libbpf BTF_KIND_DECL_TAG
support is generic enough to cover new typedef use
cases.

This patch added parsing of DW_TAG_LLVM_annotation
for dwarf typedef decl.

  $ cat t.c
  $ clang -O2 -g -c t.c
  $ llvm-dwarfdump --debug-info t.o
    ......
    0x00000033:   DW_TAG_typedef
                    DW_AT_type      (0x00000051 "structure ")
                    DW_AT_name      ("__t")
                    DW_AT_decl_file ("/home/yhs/t.c")
                    DW_AT_decl_line (3)

    0x0000003e:     DW_TAG_LLVM_annotation
                      DW_AT_name    ("btf_decl_tag")
                      DW_AT_const_value     ("tag1")

    0x00000047:     DW_TAG_LLVM_annotation
                      DW_AT_name    ("btf_decl_tag")
                      DW_AT_const_value     ("tag2")

    0x00000050:     NULL

Previously, pahole will issue a warning if typedef tag
contains any child tag. I removed this warning since
it is not true any more. Note that dwarf standard doesn't
prevent typedef decl tag from having nested tags.
In the future if we need to process any tag inside
typedef tag, we can just add code to process it.

  [1] https://reviews.llvm.org/D110127
  [2] https://lore.kernel.org/bpf/20211021195628.4018847-1-yhs@fb.com

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c5bda81..f748bd7 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1296,11 +1296,8 @@ static struct tag *die__create_new_typedef(Dwarf_Die=
 *die, struct cu *cu, struct
 	if (tdef =3D=3D NULL)
 		return NULL;
=20
-	if (dwarf_haschildren(die)) {
-		struct dwarf_tag *dtag =3D tdef->namespace.tag.priv;
-		fprintf(stderr, "%s: DW_TAG_typedef %llx WITH children!\n",
-			__func__, (unsigned long long)dtag->id);
-	}
+	if (add_child_llvm_annotations(die, -1, conf, &tdef->namespace.annots))
+		return NULL;
=20
 	return &tdef->namespace.tag;
 }
--=20
2.30.2

