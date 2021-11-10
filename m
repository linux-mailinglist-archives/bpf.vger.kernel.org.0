Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA244BB07
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhKJFXW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:23:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41558 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhKJFXW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:23:22 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA51MHs029905
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:20:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uAY7RKYQk9k/5hjy8wCjqlxOHilHmU6Zg/B8JtP1PLo=;
 b=dD7XNcxlNFUWvxx153g0Xt8MaXOuLptMXLMFv7TeWs67TPWN4yNlhSkjR0O53GtxIm/T
 gHIUqtz4F8PmrQAMbG8t4OgMFs8cHlsxTi5ck6ZCh3PEiY8RRSjAo9hJuJGdD1ZF+Kyt
 ebphLKHsu63IRXoPUUcF/uCltagaFlZfI58= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c87jg83pq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:20:34 -0800
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:20:31 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2FDA22361225; Tue,  9 Nov 2021 21:20:28 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 09/10] selftests/bpf: Clarify llvm dependency with btf_tag selftest
Date:   Tue, 9 Nov 2021 21:20:28 -0800
Message-ID: <20211110052028.372604-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4ilv2Kq-WhMffRyb4KqYLr37QNFbLMb-
X-Proofpoint-ORIG-GUID: 4ilv2Kq-WhMffRyb4KqYLr37QNFbLMb-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=906
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_tag selftest needs certain llvm versions (>=3D llvm14).
Make it clear in the selftests README.rst file.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index 5e287e445f75..42ef250c7acc 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -204,16 +204,17 @@ __ https://reviews.llvm.org/D93563
 btf_tag test and Clang version
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
-The btf_tag selftest require LLVM support to recognize the btf_decl_tag at=
tribute.
-It was introduced in `Clang 14`__.
+The btf_tag selftest requires LLVM support to recognize the btf_decl_tag a=
nd
+btf_type_tag attributes. They are introduced in `Clang 14` [0_, 1_].
=20
-Without it, the btf_tag selftest will be skipped and you will observe:
+Without them, the btf_tag selftest will be skipped and you will observe:
=20
 .. code-block:: console
=20
   #<test_num> btf_tag:SKIP
=20
-__ https://reviews.llvm.org/D111588
+.. _0: https://reviews.llvm.org/D111588
+.. _1: https://reviews.llvm.org/D111199
=20
 Clang dependencies for static linking tests
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.30.2

