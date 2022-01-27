Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28E49E68A
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiA0Pqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:46:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243118AbiA0Pqb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:46:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RFTYnK012536
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+XbZuVMKCoqzMy29o8hBVHTjcjeO0FrrW6O3oFKp3nA=;
 b=icZenvcXJVvOrbzQfcHpXvXdO0eZtaWRzBFZRDhjON3VUleAMdy2ajR/19S8PwJ+9Y91
 lOWOIO4NC/ZGpcXw1yydxBAgMtAvYrJUYWdN8oy6IIMlSvEfPt7gRqmSxhRUOMNikn17
 KwF+88Hmtun/QsNMmMvNGb9GXvLhs/8NYxs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujva3bpw-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:31 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 07:46:27 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 287E75A22BCB; Thu, 27 Jan 2022 07:46:22 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: specify pahole version requirement for btf_tag test
Date:   Thu, 27 Jan 2022 07:46:22 -0800
Message-ID: <20220127154622.663337-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127154555.650886-1-yhs@fb.com>
References: <20220127154555.650886-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -Ox3Ud8Ui7bzlamplVZxG1ahSn4JQyz1
X-Proofpoint-ORIG-GUID: -Ox3Ud8Ui7bzlamplVZxG1ahSn4JQyz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 mlxlogscore=921 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270096
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

