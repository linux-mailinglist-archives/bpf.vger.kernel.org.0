Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ABE34BB70
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 08:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhC1Gll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 02:41:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27008 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229489AbhC1GlZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 02:41:25 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12S6MXem019182
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=4aMQ0d7nVWf5RJY7bmJVdqF15kyrPfmFwFZYaduyr88=;
 b=rUTzNsy7PktzbJJ+KZurN1mXwlaeuG4fCU37TP8fkqB/IYJzxPBgWpGGh+M396NXyRvk
 otNP+LL3b33koMpImoLnXJDa8K7ddjhE1jWZm5T8MPPoN43rwKpv21+F2n0A+zP6MlrH
 Uq/zIG4aG8IoapdsG8Bml88Jr8+CgMWb5bI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37j0cpkarw-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:41:24 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 27 Mar 2021 23:41:23 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B784FC9198D; Sat, 27 Mar 2021 23:41:21 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH kbuild] kbuild: add -grecord-gcc-switches to clang build
Date:   Sat, 27 Mar 2021 23:41:21 -0700
Message-ID: <20210328064121.2062927-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KyIL0M1209amXcn6rupFDG7W5kPKDB7c
X-Proofpoint-ORIG-GUID: KyIL0M1209amXcn6rupFDG7W5kPKDB7c
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_04:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=857
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Putting compilation flags in dwarf is helpful in that
it tells what potential transformations may have
happened to generate the final binary. Furthermore,
we have a particular usecase in [1] where pahole wants
to detect whether vmlinux is compiled with clang lto
or not, and if vmlinux is compiled with clang lto,
pahole will merge all debuginfo cu's into one pahole cu.

Currently gcc seems put compilation flags into
dwarf DW_AT_producer tag if -g is specified, while
clang needs explicit flag -grecord-gcc-switches.
For example,
 build with gcc 8.4.1 (make -j60):
   ...
   DW_AT_producer    ("GNU C89 8.4.1 20200928 (Red Hat 8.4.1-1) -mno-sse -m=
no-mmx -mno-sse2 ...")
   DW_AT_language    (DW_LANG_C89)
   DW_AT_name        ("/home/yhs/work/bpf-next/arch/x86/kernel/ebda.c")

 build with clang 13 trunk (make -j60 LLVM=3D1):
   ...
   DW_AT_producer    ("clang version 13.0.0 (https://github.com/llvm/llvm-p=
roject.git
                       11bf268864afbe35ad317e6354c51440d5184911)")
   DW_AT_language    (DW_LANG_C89)
   DW_AT_name        ("/home/yhs/work/bpf-next/arch/x86/kernel/ebda.c")

 With this patch, build with clang 13 trunk:
   ...
   DW_AT_producer    ("clang version 13.0.0 (https://github.com/llvm/llvm-p=
roject.git
                       11bf268864afbe35ad317e6354c51440d5184911)
                       /home/yhs/work/llvm-project/llvm/build.cur/install/b=
in/clang-13 -MMD
                       -MF arch/x86/kernel/.ebda.o.d -nostdinc ...")
   DW_AT_language    (DW_LANG_C89)
   DW_AT_name        ("/home/yhs/work/bpf-next/arch/x86/kernel/ebda.c")

 With detailed compilation flags information, in [1], pahole is able to qui=
ckly
 decide whether merging cu's is a right choice or not.

 [1] https://lore.kernel.org/bpf/20210328061646.1955678-1-yhs@fb.com/T

I tested with latest bpf-next, but the patch is also applied cleanly on
top of latest linus tree.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index d4784d181123..ab0119beb42d 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,12 @@ dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) :=3D 5
 DEBUG_CFLAGS	+=3D -gdwarf-$(dwarf-version-y)
 endif
=20
+# gcc emits compilation flags in dwarf DW_AT_producer by default
+# while clang needs explicit flag. Add this flag explicitly.
+ifdef CONFIG_CC_IS_CLANG
+DEBUG_CFLAGS	+=3D -grecord-gcc-switches
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+=3D $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
--=20
2.30.2

