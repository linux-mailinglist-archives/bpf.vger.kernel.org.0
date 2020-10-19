Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AC292E90
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 21:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgJSTmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 15:42:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16884 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731090AbgJSTmY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Oct 2020 15:42:24 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JJfxDe032551
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 12:42:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=ys6gWfOq1d44sbwUOmaO+IHnwyjaoWpQqi+nWnx1jgk=;
 b=ccffgv+Fra8XierfZqm+LXF06e+2VUvvinCEMhtKOpugYen86m+kADi3GMtalrroIxHm
 rj5G+gktiKGh5hQ7642sld9e/yohen/FS9NDkoiWrNGrqXGxYxYgiDPCRliJaWHxA5YN
 3iPYGVONgRHnLFYpcFWWqI9FaV3I1vvEfIo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 348gp3xmb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 12:42:24 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 19 Oct 2020 12:42:22 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 3081C2946269; Mon, 19 Oct 2020 12:42:19 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 2/3] bpf: selftest: Ensure the return value of bpf_skc_to helpers must be checked
Date:   Mon, 19 Oct 2020 12:42:19 -0700
Message-ID: <20201019194219.1051314-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201019194206.1050591-1-kafai@fb.com>
References: <20201019194206.1050591-1-kafai@fb.com>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_10:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 suspectscore=13 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=790 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch tests:

int bpf_cls(struct __sk_buff *skb)
{
	/* REG_6: sk
	 * REG_7: tp
	 * REG_8: req_sk
	 */

	sk =3D skb->sk;
	if (!sk)
		return 0;

	tp =3D bpf_skc_to_tcp_sock(sk);
	req_sk =3D bpf_skc_to_tcp_request_sock(sk);
	if (!req_sk)
		return 0;

	/* !tp has not been tested, so verifier should reject. */
	return *(__u8 *)tp;
}

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/verifier/sock.c | 25 +++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/=
selftests/bpf/verifier/sock.c
index b1aac2641498..ce13ece08d51 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -631,3 +631,28 @@
 	.prog_type =3D BPF_PROG_TYPE_SK_REUSEPORT,
 	.result =3D ACCEPT,
 },
+{
+	"mark null check on return value of bpf_skc_to helpers",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk=
)),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_request_sock),
+	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_8, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
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

