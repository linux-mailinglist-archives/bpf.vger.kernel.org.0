Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038535E2F7
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbhDMPem (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 11:34:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345197AbhDMPej (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 11:34:39 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DFQXdT027135
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JMPLZuc/6km7QOVuox6fHp2lxrcTKoN61IfDOcVBqug=;
 b=G8zSpMJmh5CcoDJwx1I31kE9MvOR/v8Jrg+YdmIF5RBqKXAvOI6rUFcVAw5ANjPcGpMu
 esd5zs3iGq62mwHHs48Xm/cKdukuzik3IeHu4ZOTa39EKvueohKhGD1sUNTEYfnQhgDN
 ln7tHPizKdMmvX6Xz4biRj143ePFnmbB9Ng= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37w4k82yeu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 08:34:16 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Apr 2021 08:34:14 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 05BD8161F3A3; Tue, 13 Apr 2021 08:34:14 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v3 1/5] selftests: set CC to clang in lib.mk if LLVM is set
Date:   Tue, 13 Apr 2021 08:34:13 -0700
Message-ID: <20210413153413.3027426-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413153408.3027270-1-yhs@fb.com>
References: <20210413153408.3027270-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RD0hq2z637XLhILu46qKb17aQ9-dhOfg
X-Proofpoint-GUID: RD0hq2z637XLhILu46qKb17aQ9-dhOfg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_09:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=755
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130108
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

