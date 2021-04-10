Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D4535AF1E
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJQt6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 12:49:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234334AbhDJQt6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Apr 2021 12:49:58 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13AGncEW024146
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 09:49:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JMPLZuc/6km7QOVuox6fHp2lxrcTKoN61IfDOcVBqug=;
 b=kMJdDgc8ZW8r/CFDgVwi/aArRkxLu2r7PUo5IzoUHd5yKlzAdUNczxLLuKIM5sJvmHJO
 /o2eg5E0fI7ZG+eikUOn6uJAD/w//uENI6caLoAxLdBPsbtS+HVAptvRFqYqWX5Pm7DA
 0kaFhoAxMbgMJSWRZPjPYHVSPj171/qAGnw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37u82eshbe-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 09:49:43 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 10 Apr 2021 09:49:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7E9DA1450401; Sat, 10 Apr 2021 09:49:30 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next 1/5] selftests: set CC to clang in lib.mk if LLVM is set
Date:   Sat, 10 Apr 2021 09:49:30 -0700
Message-ID: <20210410164930.769251-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410164925.768741-1-yhs@fb.com>
References: <20210410164925.768741-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LBuceEE8AOH8dxtGhLRi1Ec2mD9vmiij
X-Proofpoint-ORIG-GUID: LBuceEE8AOH8dxtGhLRi1Ec2mD9vmiij
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-10_07:2021-04-09,2021-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=758 spamscore=0 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

selftests/bpf/Makefile includes lib.mk. With the following command
  make -j60 LLVM=3D1 LLVM_IAS=3D1  <=3D=3D=3D compile kernel
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1 V=3D1
some files are still compiled with gcc. This patch
fixed lib.mk issue which sets CC to gcc in all cases.

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/lib.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib=
.mk
index a5ce26d548e4..9a41d8bb9ff1 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,6 +1,10 @@
 # This mimics the top-level Makefile. We do it explicitly here so that t=
his
 # Makefile can operate with or without the kbuild infrastructure.
+ifneq ($(LLVM),)
+CC :=3D clang
+else
 CC :=3D $(CROSS_COMPILE)gcc
+endif
=20
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
--=20
2.30.2

