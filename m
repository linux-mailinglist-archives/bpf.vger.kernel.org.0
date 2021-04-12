Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463C335C8B9
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhDLO3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 10:29:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48940 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241768AbhDLO3m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 10:29:42 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CETGJH029967
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LnSkRrEzzj9hjlPxrFdVSseq7lBuWls5Y18seJhV5Tk=;
 b=PGh+KcRq9HQOU8CdlC6cuVcih8C0wanBUJCqXMv8FoI2J24tfSNXdNrfgTqUWRCC37PI
 ys8+pLaWNxj8JS66dqpbfh/G+aCDLLBkwY8QiEwCkgQDcC8WNOfWB3n3cS4ZtZ2pXA9P
 nmEy3n27aFDw6lRELilQVOYhCR+FX8JTOCw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37uurwnf4u-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:24 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 07:29:21 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 901891569A8A; Mon, 12 Apr 2021 07:29:16 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v2 2/5] tools: allow proper CC/CXX/... override with LLVM=1 in Makefile.include
Date:   Mon, 12 Apr 2021 07:29:16 -0700
Message-ID: <20210412142916.267725-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412142905.266942-1-yhs@fb.com>
References: <20210412142905.266942-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -LOneZqkjiBYMz57GSN53dnhZ519WjI-
X-Proofpoint-GUID: -LOneZqkjiBYMz57GSN53dnhZ519WjI-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

selftests/bpf/Makefile includes tools/scripts/Makefile.include.
With the following command
  make -j60 LLVM=3D1 LLVM_IAS=3D1  <=3D=3D=3D compile kernel
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1 V=3D1
some files are still compiled with gcc. This patch
fixed the case if CC/AR/LD/CXX/STRIP is allowed to be
overridden, it will be written to clang/llvm-ar/..., instead of
gcc binaries. The definition of CC_NO_CLANG is also relocated
to the place after the above CC is defined.

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/scripts/Makefile.include | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
index a402f32a145c..91130648d8e6 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -39,8 +39,6 @@ EXTRA_WARNINGS +=3D -Wundef
 EXTRA_WARNINGS +=3D -Wwrite-strings
 EXTRA_WARNINGS +=3D -Wformat
=20
-CC_NO_CLANG :=3D $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang=
__"; echo $$?)
-
 # Makefiles suck: This macro sets a default value of $(2) for the
 # variable named by $(1), unless the variable has been set by
 # environment or command line. This is necessary for CC and AR
@@ -52,12 +50,22 @@ define allow-override
     $(eval $(1) =3D $(2)))
 endef
=20
+ifneq ($(LLVM),)
+$(call allow-override,CC,clang)
+$(call allow-override,AR,llvm-ar)
+$(call allow-override,LD,ld.lld)
+$(call allow-override,CXX,clang++)
+$(call allow-override,STRIP,llvm-strip)
+else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a=
 prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
 $(call allow-override,AR,$(CROSS_COMPILE)ar)
 $(call allow-override,LD,$(CROSS_COMPILE)ld)
 $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+endif
+
+CC_NO_CLANG :=3D $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang=
__"; echo $$?)
=20
 ifneq ($(LLVM),)
 HOSTAR  ?=3D llvm-ar
--=20
2.30.2

