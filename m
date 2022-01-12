Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE52548CD00
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 21:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357426AbiALURx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 15:17:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21120 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1357421AbiALURv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Jan 2022 15:17:51 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20CIVHko020230
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 12:17:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+XbZuVMKCoqzMy29o8hBVHTjcjeO0FrrW6O3oFKp3nA=;
 b=AmEbwzkE/AWg+kCTTPZz0tjsrQt3p3+zeggfw5drUz5Qz/aunbILHA2cJoy9Kqtk2BfW
 H8LKMHej23Xv1m/XLiSVvpGNwtREKA4Ma1zydom0vj4fiDUssjhU5PYRwvSifd7ym5KA
 Z9S77cpwOMIWwx+m9n/GWsqvjoVT4rYLgDU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dj4b90ntr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 12:17:50 -0800
Received: from twshared7460.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 12:17:45 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id DDE5C4FCA207; Wed, 12 Jan 2022 12:15:17 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: specify pahole version requirement for btf_tag test
Date:   Wed, 12 Jan 2022 12:15:17 -0800
Message-ID: <20220112201517.1633142-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112201449.1620763-1-yhs@fb.com>
References: <20220112201449.1620763-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CfpztcTTjmGbKz6F_dKiVa0H-eS-VDNY
X-Proofpoint-ORIG-GUID: CfpztcTTjmGbKz6F_dKiVa0H-eS-VDNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_05,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 mlxlogscore=966 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Specify pahole version requirement (1.23) for btf_tag subtests
btf_type_tag_user_{mod1, mod2, vmlinux}.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selft=
ests/bpf/README.rst
index 42ef250c7acc..d099d91adc3b 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -206,6 +206,8 @@ btf_tag test and Clang version
=20
 The btf_tag selftest requires LLVM support to recognize the btf_decl_tag=
 and
 btf_type_tag attributes. They are introduced in `Clang 14` [0_, 1_].
+The subtests ``btf_type_tag_user_{mod1, mod2, vmlinux}`` also requires
+pahole version ``1.23``.
=20
 Without them, the btf_tag selftest will be skipped and you will observe:
=20
--=20
2.30.2

