Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC68353545
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhDCSmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 14:42:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230516AbhDCSmJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 3 Apr 2021 14:42:09 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 133IZDru015789
        for <bpf@vger.kernel.org>; Sat, 3 Apr 2021 11:42:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=i25EX9hXAwW0gzWdq5t+9gu1kPI5X50IDCUEkiaPwGI=;
 b=n6Cm/7Tht9q3l9KtAoxCQmzYtxePTy3Bb5o4w3ATHZgEdmmeDUyz+TP8M06LMlZRhW8A
 TjaythBm+gRv1YTdG22JCn4dG/dRyG1RYyGo8hK39hrLkg4buQGGL+57T8bNfNze6ptW
 metQ7kpwDux17OZC1PciI7zSCajbwXwA4sM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37pvprg50g-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 03 Apr 2021 11:42:06 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 3 Apr 2021 11:42:03 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id EE9781038B6E; Sat,  3 Apr 2021 11:41:58 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
Date:   Sat, 3 Apr 2021 11:41:58 -0700
Message-ID: <20210403184158.2834387-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xv50NJYOv8FpnV3mWJbI4XtMPK_WJPKN
X-Proofpoint-ORIG-GUID: xv50NJYOv8FpnV3mWJbI4XtMPK_WJPKN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-03_09:2021-04-01,2021-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=891 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, when DWARF5 is enabled in kernel, DEBUG_INFO_BTF
needs to be disabled. I hacked the kernel to enable DEBUG_INFO_BTF
like:
  --- a/lib/Kconfig.debug
  +++ b/lib/Kconfig.debug
  @@ -286,7 +286,6 @@ config DEBUG_INFO_DWARF5
          bool "Generate DWARF Version 5 debuginfo"
          depends on GCC_VERSION >=3D 50000 || CC_IS_CLANG
          depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf=
5_support.sh $(CC) $(CLANG_FLAGS))
  -       depends on !DEBUG_INFO_BTF
          help
and tried DWARF5 with latest trunk clang, thin-lto and no lto.
In both cases, I got a few additional failures like:
  $ ./test_progs -n 55/2
  ...
  libbpf: extern (var ksym) 'bpf_prog_active': failed to find BTF ID in k=
ernel BTF(s).
  libbpf: failed to load object 'kfunc_call_test_subprog'
  libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
  test_subprog:FAIL:skel unexpected error: 0
  #55/2 subprog:FAIL

Here, bpf_prog_active is a percpu global variable and pahole is supposed =
to
put into BTF, but it is not there.

Further analysis shows this is due to encoding difference between
DWARF4 and DWARF5. In DWARF5, a new section .debug_addr
and several new ops, e.g. DW_OP_addrx, are introduced.
DW_OP_addrx is actually an index into .debug_addr section starting
from an offset encoded with DW_AT_addr_base in DW_TAG_compile_unit.

For the above 'bpf_prog_active' example, with DWARF4, we have
  0x02281a96:   DW_TAG_variable
                  DW_AT_name      ("bpf_prog_active")
                  DW_AT_decl_file ("/home/yhs/work/bpf-next/include/linux=
/bpf.h")
                  DW_AT_decl_line (1170)
                  DW_AT_decl_column       (0x01)
                  DW_AT_type      (0x0226d171 "int")
                  DW_AT_external  (true)
                  DW_AT_declaration       (true)

  0x02292f04:   DW_TAG_variable
                  DW_AT_specification     (0x02281a96 "bpf_prog_active")
                  DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/sy=
scall.c")
                  DW_AT_decl_line (45)
                  DW_AT_location  (DW_OP_addr 0x28940)
For DWARF5, we have
  0x0138b0a1:   DW_TAG_variable
                  DW_AT_name      ("bpf_prog_active")
                  DW_AT_type      (0x013760b9 "int")
                  DW_AT_external  (true)
                  DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/sy=
scall.c")
                  DW_AT_decl_line (45)
                  DW_AT_location  (DW_OP_addrx 0x16)

This patch added support for DW_OP_addrx. With the patch, the above
failing bpf selftest and other similar failed selftests succeeded.
---
 dwarf_loader.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

NOTE: with this patch, at least for clang trunk, all bpf selftests
      are fine for DWARF5 w.r.t. compiler and pahole. Hopefully
      after pahole 1.21 release, we can remove DWARF5 dependence
      with !DEBUG_INFO_BTF.

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 82d7131..49336ac 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -401,8 +401,19 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **=
expr, size_t *exprlen)
 {
 	Dwarf_Attribute attr;
 	if (dwarf_attr(die, DW_AT_location, &attr) !=3D NULL) {
-		if (dwarf_getlocation(&attr, expr, exprlen) =3D=3D 0)
+		if (dwarf_getlocation(&attr, expr, exprlen) =3D=3D 0) {
+			/* DW_OP_addrx needs additional lookup for real addr. */
+			if (*exprlen !=3D 0 && expr[0]->atom =3D=3D DW_OP_addrx) {
+				Dwarf_Attribute addr_attr;
+				dwarf_getlocation_attr(&attr, expr[0], &addr_attr);
+
+				Dwarf_Addr address;
+				dwarf_formaddr (&addr_attr, &address);
+
+				expr[0]->number =3D address;
+			}
 			return 0;
+		}
 	}
=20
 	return 1;
@@ -626,6 +637,7 @@ static enum vscope dwarf__location(Dwarf_Die *die, ui=
nt64_t *addr, struct locati
 		Dwarf_Op *expr =3D location->expr;
 		switch (expr->atom) {
 		case DW_OP_addr:
+		case DW_OP_addrx:
 			scope =3D VSCOPE_GLOBAL;
 			*addr =3D expr[0].number;
 			break;
--=20
2.30.2

