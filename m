Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C359644DFBF
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 02:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhKLB3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 20:29:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38984 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhKLB3p (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 20:29:45 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC132gV032068
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:26:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JxGTakDttQgQvlZAQYrsJuIqF4OBOk+Cra7ejpZAjjk=;
 b=Zbej3t6NF7e3OKCUKWpKSqhuQL20W7NE5MYD94KF7d+zJO7PomQ4x+6H9CZWr/RPvH7w
 LN4PXyboCUncWMcMU8h9e7EiUxzZ4ZBdEgynTcNZEQi8QhT/OHr6rfbB6cJzTklQr3Af
 vomhwsybzRMZkaSOBFx1i94Tx5q/37nsu0Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9br6s6m6-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 17:26:55 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 17:26:52 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8B28324C5BCA; Thu, 11 Nov 2021 17:26:51 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 09/10] selftests/bpf: Clarify llvm dependency with btf_tag selftest
Date:   Thu, 11 Nov 2021 17:26:51 -0800
Message-ID: <20211112012651.1508549-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112012604.1504583-1-yhs@fb.com>
References: <20211112012604.1504583-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kXD-XRoT-nuYwOLk6ns9ngfabQlRxZxw
X-Proofpoint-ORIG-GUID: kXD-XRoT-nuYwOLk6ns9ngfabQlRxZxw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=887 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_tag selftest needs certain llvm versions (>=3D llvm14).
Make it clear in the selftests README.rst file.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

