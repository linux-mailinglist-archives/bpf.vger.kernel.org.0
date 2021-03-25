Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273CC348970
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 07:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYGxy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 02:53:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60754 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhCYGxd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 02:53:33 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12P6i8MG012094
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 23:53:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MBeP5zF/AXazYMbbkVm421GWjxInhr5Fh1zvcgIM5Ng=;
 b=p1QceDf4Frunouqan3UHdfYbeHPe1KXofo1HFH+gwecHap6ekjQJJLjwY8rDzdJuSotO
 SVeqfSfNJKoGT10CcCWjdaqatN2EU4Y8OIkX6UPtO+yK3fT/kJ8crTjWds8nMYaWISzA
 aBD5v6LnfejPzTlmM9rtfq4eE2M5esvq38o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37fn33tm64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 23:53:32 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 23:53:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5296AAE26C7; Wed, 24 Mar 2021 23:53:27 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves 2/3] dwarf_loader: factor out common code to initialize a cu
Date:   Wed, 24 Mar 2021 23:53:27 -0700
Message-ID: <20210325065327.3122071-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325065316.3121287-1-yhs@fb.com>
References: <20210325065316.3121287-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_01:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250049
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
index a02ef23..dc66df0 100644
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

