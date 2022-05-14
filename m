Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06AB526EFA
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiENDOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 23:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiENDOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 23:14:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736534A966
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:14:00 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DNXQJA000950
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=B5BGsW5kyuBS6V3+Q2kDiBq1sw2ninylxw203xdnZzs=;
 b=Z9AwFVVhXDo/xG5Dmk2qNEnnCmeBs5y8VunQLhsm+WY4xsTy53iJjg6DdWbOzaqH4lyC
 +1woWx1AYv15gCT3cFI0nOVmc4GGesFo2uchG2KLBPX6YnVSfCWbhkebt61ovHEGtSUp
 8sKP6af6x6UKBq1+Yv71V169Z4a6vX1OBSA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g1a0314dk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:59 -0700
Received: from twshared16483.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 20:13:58 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 3D4EBA45F6EF; Fri, 13 May 2022 20:13:56 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 18/18] docs/bpf: Update documentation for BTF_KIND_ENUM64 support
Date:   Fri, 13 May 2022 20:13:56 -0700
Message-ID: <20220514031356.3247576-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514031221.3240268-1-yhs@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: d1-MIUQPnUnAi1c_8y4UeWtYX74ZGd4u
X-Proofpoint-ORIG-GUID: d1-MIUQPnUnAi1c_8y4UeWtYX74ZGd4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_ENUM64 documentation in btf.rst.
Also fixed a typo for section number for BTF_KIND_TYPE_TAG
from 2.2.17 to 2.2.18.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 7940da9bc6c1..e2ddfb2b084d 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -74,7 +74,7 @@ sequentially and type id is assigned to each recognized=
 type starting from id
     #define BTF_KIND_ARRAY          3       /* Array        */
     #define BTF_KIND_STRUCT         4       /* Struct       */
     #define BTF_KIND_UNION          5       /* Union        */
-    #define BTF_KIND_ENUM           6       /* Enumeration  */
+    #define BTF_KIND_ENUM           6       /* Enumeration up to 32-bit =
values */
     #define BTF_KIND_FWD            7       /* Forward      */
     #define BTF_KIND_TYPEDEF        8       /* Typedef      */
     #define BTF_KIND_VOLATILE       9       /* Volatile     */
@@ -87,6 +87,7 @@ sequentially and type id is assigned to each recognized=
 type starting from id
     #define BTF_KIND_FLOAT          16      /* Floating point       */
     #define BTF_KIND_DECL_TAG       17      /* Decl Tag     */
     #define BTF_KIND_TYPE_TAG       18      /* Type Tag     */
+    #define BTF_KIND_ENUM64         19      /* Enumeration up to 64-bit =
values */
=20
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -101,10 +102,10 @@ Each type contains the following common data::
          * bits 24-28: kind (e.g. int, ptr, array...etc)
          * bits 29-30: unused
          * bit     31: kind_flag, currently used by
-         *             struct, union and fwd
+         *             struct, union, fwd, enum and enum64.
          */
         __u32 info;
-        /* "size" is used by INT, ENUM, STRUCT and UNION.
+        /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
          * "size" tells the size of the type it is describing.
          *
          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
@@ -281,7 +282,7 @@ modes exist:
=20
 ``struct btf_type`` encoding requirement:
   * ``name_off``: 0 or offset to a valid C identifier
-  * ``info.kind_flag``: 0
+  * ``info.kind_flag``: 0 for unsigned, 1 for signed
   * ``info.kind``: BTF_KIND_ENUM
   * ``info.vlen``: number of enum values
   * ``size``: 4
@@ -493,7 +494,7 @@ the attribute is applied to a ``struct``/``union`` me=
mber or
 a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
 valid index (starting from 0) pointing to a member or an argument.
=20
-2.2.17 BTF_KIND_TYPE_TAG
+2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
=20
 ``struct btf_type`` encoding requirement:
@@ -516,6 +517,29 @@ type_tag, then zero or more const/volatile/restrict/=
typedef
 and finally the base type. The base type is one of
 int, ptr, array, struct, union, enum, func_proto and float types.
=20
+2.2.19 BTF_KIND_ENUM64
+~~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+  * ``name_off``: 0 or offset to a valid C identifier
+  * ``info.kind_flag``: 0 for unsigned, 1 for signed
+  * ``info.kind``: BTF_KIND_ENUM64
+  * ``info.vlen``: number of enum values
+  * ``size``: 1/2/4/8
+
+``btf_type`` is followed by ``info.vlen`` number of ``struct btf_enum64`=
`.::
+
+    struct btf_enum64 {
+        __u32   name_off;
+        __u32   val_lo32;
+        __u32   val_hi32;
+    };
+
+The ``btf_enum64`` encoding:
+  * ``name_off``: offset to a valid C identifier
+  * ``val_lo32``: lower 32-bit value for a 64-bit value
+  * ``val_hi32``: high 32-bit value for a 64-bit value
+
 3. BTF Kernel API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.30.2

