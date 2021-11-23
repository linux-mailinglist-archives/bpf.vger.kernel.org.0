Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58AA459B53
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 05:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhKWE7f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 23:59:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232317AbhKWE7e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 23:59:34 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AN13biX000986
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 20:56:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B92FYu3iv8rxoXs4iB9B5OsX82GG7G5AdWNm2hiQIRg=;
 b=aThqZyHAHszBSvbL6pFdEZz8soe39GQ509MSwMG2/pRbfVJfvy//T0PQQdUyecVt2A1P
 PpChZAYawqjh113PYtVeX9kMWj2VPhF0ROt1oGoYvuNPzMbygtu/qZ8aJZxfQRJ+UxKj
 mXEuhOLe2rvik1avRDUAXKqYGHO8aeNbU/E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3cgpa40x0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 20:56:27 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 20:56:26 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id CEE8C2CD498A; Mon, 22 Nov 2021 20:56:22 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 2/4] dutil: move DW_TAG_LLVM_annotation definition to dutil.h
Date:   Mon, 22 Nov 2021 20:56:22 -0800
Message-ID: <20211123045622.1388411-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123045612.1387544-1-yhs@fb.com>
References: <20211123045612.1387544-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: woYeUHtJt0iDOuV3YqvuSoJ7PTt-4B26
X-Proofpoint-GUID: woYeUHtJt0iDOuV3YqvuSoJ7PTt-4B26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_01,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=667 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230024
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

