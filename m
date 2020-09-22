Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECB273BDD
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 09:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgIVH3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Sep 2020 03:29:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44180 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729634AbgIVH3x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Sep 2020 03:29:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08M70Smr027087
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 00:04:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TWKA/362Z4Sfry1/5te0HavQDohYlFdNSVMuX+6GcTA=;
 b=M7f+HLukp0nHxynVPXh1Z0hKb9Q3sfTUrynVFAQ2K1FMJ52wQEHSVEk68zFQmGXTpNGr
 JEDYNc7Xl9ZUjFy+G/2I1HIRlqksCC8OVJvYo3uAEfaLoirBuT1enDOZ4OZO+qW4JiIo
 XDelOaeOzk3dh2g/2pO9N0wphjA1SPVp97M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33p1g9scaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 00:04:55 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 00:04:55 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 55191294641C; Tue, 22 Sep 2020 00:04:53 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 bpf-next 07/11] bpf: selftest: Add ref_tracking verifier test for bpf_skc casting
Date:   Tue, 22 Sep 2020 00:04:53 -0700
Message-ID: <20200922070453.1921653-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200922070409.1914988-1-kafai@fb.com>
References: <20200922070409.1914988-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_05:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=13 clxscore=1015 phishscore=0 mlxlogscore=833 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220056
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patch tests for:
1. bpf_sk_release() can be called on a tcp_sock btf_id ptr.

2. Ensure the tcp_sock btf_id pointer cannot be used
   after bpf_sk_release().

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/verifier/ref_tracking.c     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/=
testing/selftests/bpf/verifier/ref_tracking.c
index 056e0273bf12..006b5bd99c08 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -854,3 +854,50 @@
 	.errstr =3D "Unreleased reference",
 	.result =3D REJECT,
 },
+{
+	"reference tracking: bpf_sk_release(btf_tcp_sock)",
+	.insns =3D {
+	BPF_SK_LOOKUP(sk_lookup_tcp),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_release),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_sk_release),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+	.result =3D ACCEPT,
+	.result_unpriv =3D REJECT,
+	.errstr_unpriv =3D "unknown func",
+},
+{
+	"reference tracking: use ptr from bpf_skc_to_tcp_sock() after release",
+	.insns =3D {
+	BPF_SK_LOOKUP(sk_lookup_tcp),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_release),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_sk_release),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+	.result =3D REJECT,
+	.errstr =3D "invalid mem access",
+	.result_unpriv =3D REJECT,
+	.errstr_unpriv =3D "unknown func",
+},
--=20
2.24.1

