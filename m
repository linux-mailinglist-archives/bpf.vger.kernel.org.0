Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814F549E68B
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiA0Pqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:46:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12384 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243120AbiA0Pqc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:46:32 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RFTXSV013081
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=014yT/mw6bbh3Id0CZDdXxIo1HyLhW69KglGu9QAXo4=;
 b=V10AWVbBVWtF0KpyssIaV+xm0hl45RZLfVw60PTtpfZJiWp/FsuMm+NQmoKW4yXqloNO
 VjIBOGxqPDNOmTS+8j26nZdsfUOoeMnPDRh8ORfUvIUz8yy9PxZzP1ByBwAIhmZ4XB/F
 5LVHMnSmuWQ3wzu1Qv8s5Wke8accKZSflEk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujv3ucfu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:31 -0800
Received: from twshared3205.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 07:46:30 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6905C5A22BE1; Thu, 27 Jan 2022 07:46:27 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v3 6/6] docs/bpf: clarify how btf_type_tag gets encoded in the type chain
Date:   Thu, 27 Jan 2022 07:46:27 -0800
Message-ID: <20220127154627.665163-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127154555.650886-1-yhs@fb.com>
References: <20220127154555.650886-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mXgFyAjl9qOdeJMxh5hLc-BDw_bKEUnR
X-Proofpoint-GUID: mXgFyAjl9qOdeJMxh5hLc-BDw_bKEUnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=897 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Clarify where the BTF_KIND_TYPE_TAG gets encoded in the type chain,
so applications and kernel can properly parse them.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index ab08852e53ae..7940da9bc6c1 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -503,6 +503,19 @@ valid index (starting from 0) pointing to a member o=
r an argument.
  * ``info.vlen``: 0
  * ``type``: the type with ``btf_type_tag`` attribute
=20
+Currently, ``BTF_KIND_TYPE_TAG`` is only emitted for pointer types.
+It has the following btf type chain:
+::
+
+  ptr -> [type_tag]*
+      -> [const | volatile | restrict | typedef]*
+      -> base_type
+
+Basically, a pointer type points to zero or more
+type_tag, then zero or more const/volatile/restrict/typedef
+and finally the base type. The base type is one of
+int, ptr, array, struct, union, enum, func_proto and float types.
+
 3. BTF Kernel API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.30.2

