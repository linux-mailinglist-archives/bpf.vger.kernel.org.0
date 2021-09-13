Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E804097EF
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhIMPxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:53:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241230AbhIMPxr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:53:47 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF4OtG009900
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=voX3+o6JtaphOpxol7ryrgfyb9eYbmsu3jSPrIR3IaU=;
 b=SvDGxiM+mHGDj2jf1S6bSsyVM8vp0F0qEY8FCGbmiPlcf370+sjwdACCRWo05reEp81p
 RKyhFquzfHyD1cF/XIozMu/TDZiFOCC+AWdodr1LbXfo/g/EBEiADtP/Qiy1ex3nlWnq
 gBNbz/oQHOUXpIMnawAfusGsV/TdmkIujrQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xp33h2h-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 08:52:31 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:52:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F21CF7279102; Mon, 13 Sep 2021 08:52:21 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 11/11] docs/bpf: add documentation for BTF_KIND_TAG
Date:   Mon, 13 Sep 2021 08:52:21 -0700
Message-ID: <20210913155221.3729990-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ECy7SJrL3U7AQG_soQX4vrrQ7s3fHZdc
X-Proofpoint-ORIG-GUID: ECy7SJrL3U7AQG_soQX4vrrQ7s3fHZdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TAG documentation in btf.rst.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 846354cd2d69..9fff578a0a35 100644
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
@@ -465,6 +466,30 @@ map definition.
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
+If ``btf_tag.component_idx =3D -1``, the btf_tag attribute is
+applied to a valid ``type``. Otherwise, the btf_tag attribute is
+applied to a ``struct``/``union`` member or a ``func`` argument,
+and ``btf_tag.component_idx`` should be a valid index (starting from 0)
+pointing to a member or an argument.
+
 3. BTF Kernel API
 *****************
=20
--=20
2.30.2

