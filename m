Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83620454E80
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhKQUZ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 15:25:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12850 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239806AbhKQUZ1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 15:25:27 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHJwnxj014440
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:22:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B92FYu3iv8rxoXs4iB9B5OsX82GG7G5AdWNm2hiQIRg=;
 b=NA5TUekCMrDdcDJ9JNnyIrknRGXidTozm02Z0TGctt6V6X3SE9bgGje0pMZqudigq/Zo
 PxYb8PU4QI8un66jvqyuII/7uML59BAAhoS08Tr5Vc6ZFbajdPxjieQEBmKi+jYMBjs3
 uMEpooSnZEwuBOiIrXsYIWk6f8l+8HcI3fs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ccuxsdbvy-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:22:28 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 12:22:26 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B1AD428FBA2E; Wed, 17 Nov 2021 12:22:24 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 2/4] dutil: move DW_TAG_LLVM_annotation definition to dutil.h
Date:   Wed, 17 Nov 2021 12:22:24 -0800
Message-ID: <20211117202224.3269684-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117202214.3268824-1-yhs@fb.com>
References: <20211117202214.3268824-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: dhu6BVmGrtpjhSlCcwypYbxzXF3V7ixX
X-Proofpoint-ORIG-GUID: dhu6BVmGrtpjhSlCcwypYbxzXF3V7ixX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=685 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111170091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move DW_TAG_LLVM_annotation definition from dwarf_load.c to
dutil.h as it will be used later for btf_encoder.c.
There is no functionality change for this patch.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dutil.h        | 4 ++++
 dwarf_loader.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dutil.h b/dutil.h
index 25691ea..e45bba0 100644
--- a/dutil.h
+++ b/dutil.h
@@ -31,6 +31,10 @@
=20
 #define roundup(x,y) ((((x) + ((y) - 1)) / (y)) * (y))
=20
+#ifndef DW_TAG_LLVM_annotation
+#define DW_TAG_LLVM_annotation 0x6000
+#endif
+
 static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
 {
         return (n !=3D 0 && ((n & (n - 1)) =3D=3D 0));
diff --git a/dwarf_loader.c b/dwarf_loader.c
index cf005da..1b07a62 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -52,10 +52,6 @@
 #define DW_OP_addrx 0xa1
 #endif
=20
-#ifndef DW_TAG_LLVM_annotation
-#define DW_TAG_LLVM_annotation 0x6000
-#endif
-
 static pthread_mutex_t libdw__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
 static uint32_t hashtags__bits =3D 12;
--=20
2.30.2

