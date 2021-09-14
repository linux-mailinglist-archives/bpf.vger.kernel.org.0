Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25B40BB74
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhINWc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:32:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235137AbhINWcZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:32:25 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG32CY027599
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3k/KvDVC8HlUlPCkYpaSwSZxE7jyxdEoNbCeTgtRcG4=;
 b=W131z/tSI9/vx1/t0ulxWrGNhMM+jIok7NmZEdl0SsVD/AhMWiPuctFCic/P/8pYB3Gn
 YLOOZWnODuysYkhzulocS5oUHO3bZecavA9C9n9Eo9B0/cAGVXDhhyjT7Jxx4Z/O+sbN
 66ewYtz2dS05XobV18nrQiuFkaQOM+Idk5k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b2k1rp8me-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:31:07 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:31:06 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 7B5EB738227D; Tue, 14 Sep 2021 15:31:03 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 11/11] docs/bpf: add documentation for BTF_KIND_TAG
Date:   Tue, 14 Sep 2021 15:31:03 -0700
Message-ID: <20210914223103.249100-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 7F3bVU42LicltZuZxPc4MtfKFPtiy54T
X-Proofpoint-ORIG-GUID: 7F3bVU42LicltZuZxPc4MtfKFPtiy54T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TAG documentation in btf.rst.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 846354cd2d69..1bfe4072f5fc 100644
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
@@ -106,7 +107,7 @@ Each type contains the following common data::
          * "size" tells the size of the type it is describing.
          *
          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-         * FUNC and FUNC_PROTO.
+         * FUNC, FUNC_PROTO and TAG.
          * "type" is a type_id referring to another type.
          */
         union {
@@ -465,6 +466,32 @@ map definition.
=20
 No additional type data follow ``btf_type``.
=20
+2.2.17 BTF_KIND_TAG
+~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+ * ``name_off``: offset to a non-empty string
+ * ``info.kind_flag``: 0
+ * ``info.kind``: BTF_KIND_TAG
+ * ``info.vlen``: 0
+ * ``type``: ``struct``, ``union``, ``func`` or ``var``
+
+``btf_type`` is followed by ``struct btf_tag``.::
+
+    struct btf_tag {
+        __u32   component_idx;
+    };
+
+The ``name_off`` encodes btf_tag attribute string.
+The ``type`` should be ``struct``, ``union``, ``func`` or ``var``.
+For ``var`` type, ``btf_tag.component_idx`` must be ``-1``.
+For the other three types, if the btf_tag attribute is
+applied to the ``struct``, ``union`` or ``func`` itself,
+``btf_tag.component_idx`` must be ``-1``. Otherwise,
+the attribute is applied to a ``struct``/``union`` member or
+a ``func`` argument, and ``btf_tag.component_idx`` should be a
+valid index (starting from 0) pointing to a member or an argument.
+
 3. BTF Kernel API
 *****************
=20
--=20
2.30.2

