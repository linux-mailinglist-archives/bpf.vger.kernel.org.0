Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8445444DE7D
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhKKX3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:29:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233119AbhKKX3f (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:29:35 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ABN4ijj031907
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uVehdkB3+qWtuYGqhYCRCo+VupSAY2T+5cAOH7RThss=;
 b=bY8joiBqs5roUDptMKpD/h/LTZIACVPrsYAyGKGbbCktbvj2ROWvF1i3rOQYlBM8XK7U
 5trzNPiJagwEgydnD09G6WoOww3foCRrmUrjoBLP/swyh1F1KlTIgkGsVicbrWjxx/AS
 xxDE3FRjDRqJ0kW0OQmiNDJtExoCF4W+otE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c9brfggws-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:45 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:26:44 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 69C5324B3F22; Thu, 11 Nov 2021 15:26:40 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 10/10] docs/bpf: Update documentation for BTF_KIND_TYPE_TAG support
Date:   Thu, 11 Nov 2021 15:26:39 -0800
Message-ID: <20211111232640.793157-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: b4Z-wT-BygM-o4NHnHDEgZHcVbh2w4jm
X-Proofpoint-GUID: b4Z-wT-BygM-o4NHnHDEgZHcVbh2w4jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TYPE_TAG documentation in btf.rst.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 9ad4218a751f..d0ec40d00c28 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -86,6 +86,7 @@ sequentially and type id is assigned to each recognized=
 type starting from id
     #define BTF_KIND_DATASEC        15      /* Section      */
     #define BTF_KIND_FLOAT          16      /* Floating point       */
     #define BTF_KIND_DECL_TAG       17      /* Decl Tag     */
+    #define BTF_KIND_TYPE_TAG       18      /* Type Tag     */
=20
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -107,7 +108,7 @@ Each type contains the following common data::
          * "size" tells the size of the type it is describing.
          *
          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-         * FUNC, FUNC_PROTO and DECL_TAG.
+         * FUNC, FUNC_PROTO, DECL_TAG and TYPE_TAG.
          * "type" is a type_id referring to another type.
          */
         union {
@@ -492,6 +493,16 @@ the attribute is applied to a ``struct``/``union`` m=
ember or
 a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
 valid index (starting from 0) pointing to a member or an argument.
=20
+2.2.17 BTF_KIND_TYPE_TAG
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+ * ``name_off``: offset to a non-empty string
+ * ``info.kind_flag``: 0
+ * ``info.kind``: BTF_KIND_TYPE_TAG
+ * ``info.vlen``: 0
+ * ``type``: the type with ``btf_type_tag`` attribute
+
 3. BTF Kernel API
 *****************
=20
--=20
2.30.2

