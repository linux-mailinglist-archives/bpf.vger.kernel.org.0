Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9953F61F
	for <lists+bpf@lfdr.de>; Tue,  7 Jun 2022 08:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiFGGab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jun 2022 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiFGGaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jun 2022 02:30:30 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACECBD6A
        for <bpf@vger.kernel.org>; Mon,  6 Jun 2022 23:30:30 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25751YJp015407
        for <bpf@vger.kernel.org>; Mon, 6 Jun 2022 23:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QnLQousHmfIqt9QE+5H/OC11xEeDxU0pjPg9USgxfhU=;
 b=VWhHdwmZG1tTQkSV1Ujkx92Cn8vpz99zxZnpyDBna3FzE+9x9/2nKzYMyDrTyCYwgeyo
 YlqHe9Ng3SbpH1PXPhoOn3KgkJN+Jm53JjO6URXGLxshsI4m2ZJMEi/VhEOzOYPgr7K9
 9eh6SIiMrXFwkdltLcdTAtATiQSF5v1qGVM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gg4wxd6y0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 06 Jun 2022 23:30:29 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 6 Jun 2022 23:30:27 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 43877B5213DE; Mon,  6 Jun 2022 23:27:24 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v5 17/17] docs/bpf: Update documentation for BTF_KIND_ENUM64 support
Date:   Mon, 6 Jun 2022 23:27:24 -0700
Message-ID: <20220607062724.3728215-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607062554.3716237-1-yhs@fb.com>
References: <20220607062554.3716237-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PhW2ynTWrD68dgQyZHht-ZJlK3JGgqPK
X-Proofpoint-GUID: PhW2ynTWrD68dgQyZHht-ZJlK3JGgqPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_02,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_ENUM64 documentation in btf.rst.
Also fixed a typo for section number for BTF_KIND_TYPE_TAG
from 2.2.17 to 2.2.18, and fixed a type size issue for
BTF_KIND_ENUM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 43 +++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 7940da9bc6c1..f49aeef62d0c 100644
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
@@ -281,10 +282,10 @@ modes exist:
=20
 ``struct btf_type`` encoding requirement:
   * ``name_off``: 0 or offset to a valid C identifier
-  * ``info.kind_flag``: 0
+  * ``info.kind_flag``: 0 for unsigned, 1 for signed
   * ``info.kind``: BTF_KIND_ENUM
   * ``info.vlen``: number of enum values
-  * ``size``: 4
+  * ``size``: 1/2/4/8
=20
 ``btf_type`` is followed by ``info.vlen`` number of ``struct btf_enum``.=
::
=20
@@ -297,6 +298,10 @@ The ``btf_enum`` encoding:
   * ``name_off``: offset to a valid C identifier
   * ``val``: any value
=20
+If the original enum value is signed and the size is less than 4,
+that value will be sign extended into 4 bytes. If the size is 8,
+the value will be truncated into 4 bytes.
+
 2.2.7 BTF_KIND_FWD
 ~~~~~~~~~~~~~~~~~~
=20
@@ -493,7 +498,7 @@ the attribute is applied to a ``struct``/``union`` me=
mber or
 a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
 valid index (starting from 0) pointing to a member or an argument.
=20
-2.2.17 BTF_KIND_TYPE_TAG
+2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
=20
 ``struct btf_type`` encoding requirement:
@@ -516,6 +521,32 @@ type_tag, then zero or more const/volatile/restrict/=
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
+If the original enum value is signed and the size is less than 8,
+that value will be sign extended into 8 bytes.
+
 3. BTF Kernel API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.30.2

