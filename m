Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3C436BA1
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 21:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhJUT7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 15:59:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50042 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231924AbhJUT7M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 15:59:12 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LJaul6030850
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9/6KoYeaSpvqNdPWCxyT+XAW8/r01DoOIKd0v9IZmDw=;
 b=UZrVy9N84Zsq2/A2RK1ohCQvOIs6m8cxoLSc+oUhtZ+ePv8GF64iZccPZqQpf5swPWmG
 +qB592EB8NMsZxO0UnuqmywPhvJns3af5FinVI5mQtLoBHizwoGNJ8zmuRmAgXTPSMck
 9fM7UjrNdkSY+fLpZkkxWjYMdJoe/+5MqeU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bu677vsnr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:56 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 12:56:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1337D151687D; Thu, 21 Oct 2021 12:56:49 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/5] docs/bpf: update documentation for BTF_KIND_DECL_TAG typedef support
Date:   Thu, 21 Oct 2021 12:56:49 -0700
Message-ID: <20211021195649.4020514-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021195622.4018339-1-yhs@fb.com>
References: <20211021195622.4018339-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: FlocaoYe6vQtN1jcmAymhr1nJFnC-nPB
X-Proofpoint-GUID: FlocaoYe6vQtN1jcmAymhr1nJFnC-nPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_05,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=799 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add BTF_KIND_DECL_TAG typedef support in btf.rst.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/btf.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 9e5b4a98af76..9ad4218a751f 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -474,7 +474,7 @@ No additional type data follow ``btf_type``.
  * ``info.kind_flag``: 0
  * ``info.kind``: BTF_KIND_DECL_TAG
  * ``info.vlen``: 0
- * ``type``: ``struct``, ``union``, ``func`` or ``var``
+ * ``type``: ``struct``, ``union``, ``func``, ``var`` or ``typedef``
=20
 ``btf_type`` is followed by ``struct btf_decl_tag``.::
=20
@@ -483,8 +483,8 @@ No additional type data follow ``btf_type``.
     };
=20
 The ``name_off`` encodes btf_decl_tag attribute string.
-The ``type`` should be ``struct``, ``union``, ``func`` or ``var``.
-For ``var`` type, ``btf_decl_tag.component_idx`` must be ``-1``.
+The ``type`` should be ``struct``, ``union``, ``func``, ``var`` or ``typ=
edef``.
+For ``var`` or ``typedef`` type, ``btf_decl_tag.component_idx`` must be =
``-1``.
 For the other three types, if the btf_decl_tag attribute is
 applied to the ``struct``, ``union`` or ``func`` itself,
 ``btf_decl_tag.component_idx`` must be ``-1``. Otherwise,
--=20
2.30.2

