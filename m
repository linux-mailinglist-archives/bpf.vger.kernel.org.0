Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C05403157
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbhIGXCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24556 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347032AbhIGXCx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 187MvuLL026552
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UbJLvjLomNhsDUjgSDahG3G24t5gmvxef4XV6aBZ5Ak=;
 b=UgbvmR8pkVAXwTpMlZv8414KQ5dV7P/Zr6gH8xCaS+kT8VkdUpGG1VS2n+/G+cV7kBGw
 YXJdQpn7vGIIB5o0DbeD6KTnrmkNRP/A6yxxyAzkBwId70BB0CBOQEZCzEr8Sc/ZePq0
 d1ohCk/ZTjJzjU7s/t/GrSJFR+cxTa3XZAk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3axcnxt96c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:45 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:01:43 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 310586E0C11C; Tue,  7 Sep 2021 16:01:38 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 9/9] docs/bpf: add documentation for BTF_KIND_TAG
Date:   Tue, 7 Sep 2021 16:01:38 -0700
Message-ID: <20210907230138.1960995-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Dw1nNVRSG9dZhncUJP-iBdd558OBUAsK
X-Proofpoint-ORIG-GUID: Dw1nNVRSG9dZhncUJP-iBdd558OBUAsK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 mlxlogscore=988 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TAG documentation in btf.rst.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 846354cd2d69..aff032686057 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -85,6 +85,7 @@ sequentially and type id is assigned to each recognized=
 type starting from id
     #define BTF_KIND_VAR            14      /* Variable     */
     #define BTF_KIND_DATASEC        15      /* Section      */
     #define BTF_KIND_FLOAT          16      /* Floating point       */
+    #define BTF_KIND_TAG            17      /* Tag          */
=20
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -99,14 +100,14 @@ Each type contains the following common data::
          * bits 24-28: kind (e.g. int, ptr, array...etc)
          * bits 29-30: unused
          * bit     31: kind_flag, currently used by
-         *             struct, union and fwd
+         *             struct, union, fwd and tag
          */
         __u32 info;
         /* "size" is used by INT, ENUM, STRUCT and UNION.
          * "size" tells the size of the type it is describing.
          *
          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-         * FUNC and FUNC_PROTO.
+         * FUNC, FUNC_PROTO and TAG.
          * "type" is a type_id referring to another type.
          */
         union {
@@ -465,6 +466,31 @@ map definition.
=20
 No additional type data follow ``btf_type``.
=20
+2.2.17 BTF_KIND_TAG
+~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+ * ``name_off``: offset to a non-empty string
+ * ``info.kind_flag``: 0 for tagging ``type``, 1 for tagging member/argu=
ment of the ``type``
+ * ``info.kind``: BTF_KIND_TAG
+ * ``info.vlen``: 0
+ * ``type``: ``struct``, ``union``, ``func`` or ``var``
+
+``btf_type`` is followed by ``struct btf_tag``.::
+
+    struct btf_tag {
+        __u32   comp_id;
+    };
+
+The ``name_off`` encodes btf_tag attribute string.
+If ``info.kind_flag`` is 1, the attribute is attached to the ``type``.
+If ``info.kind_flag`` is 0, the attribute is attached to either a
+``struct``/``union`` member or a ``func`` argument.
+Hence the ``type`` should be ``struct``, ``union`` or
+``func``, and ``btf_tag.comp_id``, starting from 0,
+indicates which member or argument is attached with
+the attribute.
+
 3. BTF Kernel API
 *****************
=20
--=20
2.30.2

