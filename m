Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5544BB08
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhKJFX1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:23:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhKJFX1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:23:27 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA4dO3f032165
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:20:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aGwqNNuEq/SdnmEHQB8AcUtSqN/JXLzf7kaDcI48gnI=;
 b=N21IpDTOHzC1RRyfIO6XRe/WeKGMUcXhi/nHzwzjwIjtALyZQjRdqzfQC7JMiyhk9tnW
 Eei3Gh05wfIVbyNaqNpANGjUd9YS8drMEMo783fUf8KZyMX5OQAYZXucVPzmXZDGhb1u
 dQFAk3x/qb8G4H0XkEbifbyDIhbyv0qAGfU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c828pj03a-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:20:40 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:20:36 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 66E1F2361239; Tue,  9 Nov 2021 21:20:33 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/10] docs/bpf: Update documentation for BTF_KIND_TYPE_TAG support
Date:   Tue, 9 Nov 2021 21:20:33 -0800
Message-ID: <20211110052033.372886-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: hMWGaUnEPyTIBdBL7rLViw-KA7F8FIO_
X-Proofpoint-GUID: hMWGaUnEPyTIBdBL7rLViw-KA7F8FIO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_TYPE_TAG documentation in btf.rst.

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

