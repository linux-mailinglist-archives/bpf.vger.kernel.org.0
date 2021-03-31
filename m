Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417C34F560
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhCaAQp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 20:16:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232467AbhCaAQg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Mar 2021 20:16:36 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12V05BUe008121
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 17:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=DP/oAbaLKJ61xhmWTYPxD7SAy/6hMsxribzBfBRmUtM=;
 b=pnp/Ouq60xlkNISgbm/KgZw6E6OqhUDglybUbeuR2EpD8/VUCMdYcAXMWQ80+Wzg+f1D
 VbCf5pcqC1IXjvr+FNWTy1V0zVjfsDySV3mZFGiJeiEuVo2IVl92zjL3WWPj5td/3323
 VdrwOuwNgbDk+yCGuVatKTkwNSASnkow3fQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37maa2s8fb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 17:16:36 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 17:16:34 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6018DE148D2; Tue, 30 Mar 2021 17:16:23 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH kbuild v2] kbuild: add -grecord-gcc-switches to clang build
Date:   Tue, 30 Mar 2021 17:16:23 -0700
Message-ID: <20210331001623.2778934-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jfIwuOph2F_78WrgTl1YMqecrc-Kqz1r
X-Proofpoint-GUID: jfIwuOph2F_78WrgTl1YMqecrc-Kqz1r
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_13:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300175
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

If there is no easy indicator for whether the vmlinux
is compiled with lto or not, pahole will need to
go to each cu to iterates all die's to find out
whether there is a cross-cu reference, for example,
for one vmlinux I built locally with clang lto,
5 cu's need to be visited before finding there is
a cross-cu reference. To visit all cu's just proving
there is no cross-cu reference is a heavy penalty
for most pahole users whose codes may not be compiled
with lto.

One way to get whether vmlinux is built with lto or not
is through compilation flags. Currently gcc seems putting
compilation flags into dwarf DW_AT_producer tag if -g
is specified, while clang needs explicit flag
-grecord-gcc-switches.
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

To solve out use case, the flag is added when clang lto
(thin-lto or full-lto) is enabled. With this patch, build
with clang 13 trunk (make -j60 LLVM=3D1 LLVM_IAS=3D1):
   ...
   DW_AT_producer    ("clang version 13.0.0 (https://github.com/llvm/llvm-p=
roject.git
                       11bf268864afbe35ad317e6354c51440d5184911)
                       /home/yhs/work/llvm-project/llvm/build.cur/install/b=
in/clang-13 -MMD
                       -MF arch/x86/kernel/.ebda.o.d -nostdinc ...")
   DW_AT_language    (DW_LANG_C89)
   DW_AT_name        ("/home/yhs/work/bpf-next/arch/x86/kernel/ebda.c")

pahole can just check top die of the dwarf cu to find the compilation flags.
With detailed compilation flags, in [1], pahole is able to quickly
decide whether merging cu's is a right choice or not.

 [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/

I tested with latest bpf-next, but the patch is also applied cleanly on
top of latest linus tree.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

Changelogs:
 v1 -> v2:
   . guard with CONFIG_LTO_CLANG instead of CONFIG_CC_IS_CLANG

diff --git a/Makefile b/Makefile
index d4784d181123..74001f2ccf23 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,14 @@ dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) :=3D 5
 DEBUG_CFLAGS	+=3D -gdwarf-$(dwarf-version-y)
 endif
=20
+# gcc emits compilation flags in dwarf DW_AT_producer by default
+# while clang needs explicit flag. Let us enable compilation
+# flags emission if compiled with clang lto which helps
+# application distinguish lto vs. non-lto build.
+ifdef CONFIG_LTO_CLANG
+DEBUG_CFLAGS	+=3D -grecord-gcc-switches
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+=3D $(call cc-option, -femit-struct-debug-baseonly) \
 		   $(call cc-option,-fno-var-tracking)
--=20
2.30.2

