Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF0C34BB3E
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhC1GRd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 02:17:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18534 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhC1GRW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 02:17:22 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12S6F55T016851
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:17:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Q5E7mLs9Sk8U6lIrVwiDz55ytDSTtsvck/ERnEM81fk=;
 b=Rr0JMIVS/EMHKndk26H0INzytdzDno/bLaos3mMvcA3G6ngNK/fg9wb8dIwOPr61yYky
 k3iD1XKL4Hn+u+cgOY1BwSgQugcilxH07CH9C3sLT4HPe9SPHVH+mJQdYJHuVrH9UV/H
 VgWismOs0oofhfwMDcMwJ/P56HccPalOQ3Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37jmc4004m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:17:22 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 27 Mar 2021 23:17:05 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CCD4BC8F3CE; Sat, 27 Mar 2021 23:16:56 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves v2 2/3] dwarf_loader: factor out common code to initialize a cu
Date:   Sat, 27 Mar 2021 23:16:56 -0700
Message-ID: <20210328061656.1956360-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328061646.1955678-1-yhs@fb.com>
References: <20210328061646.1955678-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BOyNjViA6MotoQqc2PQvincc8TjbCZEo
X-Proofpoint-GUID: BOyNjViA6MotoQqc2PQvincc8TjbCZEo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_04:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Both cus__load_debug_types() and cus__load_module()
created new cu's followed by initialization. The
initialization codes are identical so let us refactor
into a common function which can be used later as
well when dealing with merging cu's.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5a1e860..aa6372a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2411,6 +2411,23 @@ static int finalize_cu_immediately(struct cus *cus=
, struct cu *cu,
 	return lsk;
 }
=20
+static int cu__set_common(struct cu *cu, struct conf_load *conf,
+			  Dwfl_Module *mod, Elf *elf)
+{
+	cu->uses_global_strings =3D true;
+	cu->elf =3D elf;
+	cu->dwfl =3D mod;
+	cu->extra_dbg_info =3D conf ? conf->extra_dbg_info : 0;
+	cu->has_addr_info =3D conf ? conf->get_addr_info : 0;
+
+	GElf_Ehdr ehdr;
+	if (gelf_getehdr(elf, &ehdr) =3D=3D NULL)
+		return DWARF_CB_ABORT;
+
+	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
+	return 0;
+}
+
 static int cus__load_debug_types(struct cus *cus, struct conf_load *conf=
,
 				 Dwfl_Module *mod, Dwarf *dw, Elf *elf,
 				 const char *filename,
@@ -2434,22 +2451,11 @@ static int cus__load_debug_types(struct cus *cus,=
 struct conf_load *conf,
=20
 			cu =3D cu__new("", pointer_size, build_id,
 				     build_id_len, filename);
-			if (cu =3D=3D NULL) {
+			if (cu =3D=3D NULL ||
+			    cu__set_common(cu, conf, mod, elf) !=3D 0) {
 				return DWARF_CB_ABORT;
 			}
=20
-			cu->uses_global_strings =3D true;
-			cu->elf =3D elf;
-			cu->dwfl =3D mod;
-			cu->extra_dbg_info =3D conf ? conf->extra_dbg_info : 0;
-			cu->has_addr_info =3D conf ? conf->get_addr_info : 0;
-
-			GElf_Ehdr ehdr;
-			if (gelf_getehdr(elf, &ehdr) =3D=3D NULL) {
-				return DWARF_CB_ABORT;
-			}
-			cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
-
 			if (dwarf_cu__init(dcup) !=3D 0)
 				return DWARF_CB_ABORT;
=20
@@ -2528,19 +2534,8 @@ static int cus__load_module(struct cus *cus, struc=
t conf_load *conf,
 		const char *name =3D attr_string(cu_die, DW_AT_name);
 		struct cu *cu =3D cu__new(name ?: "", pointer_size,
 					build_id, build_id_len, filename);
-		if (cu =3D=3D NULL)
-			return DWARF_CB_ABORT;
-		cu->uses_global_strings =3D true;
-		cu->elf =3D elf;
-		cu->dwfl =3D mod;
-		cu->extra_dbg_info =3D conf ? conf->extra_dbg_info : 0;
-		cu->has_addr_info =3D conf ? conf->get_addr_info : 0;
-
-		GElf_Ehdr ehdr;
-		if (gelf_getehdr(elf, &ehdr) =3D=3D NULL) {
+		if (cu =3D=3D NULL || cu__set_common(cu, conf, mod, elf) !=3D 0)
 			return DWARF_CB_ABORT;
-		}
-		cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
=20
 		struct dwarf_cu dcu;
=20
--=20
2.30.2

