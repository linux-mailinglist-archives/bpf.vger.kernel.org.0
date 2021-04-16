Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850D936299E
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 22:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbhDPUsG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 16:48:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11798 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236061AbhDPUsG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 16:48:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GKgBJp028656
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 13:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=oQJudfdYmJl/qmUuBWVFvw7t4nvyIPTwZCvCwu9x8p0=;
 b=GOtfaMFe0ACmeiRcdzXLG6OuCyN0YEU9vOiZpBeVBZJD3ZkF6u1lx4zs8FrFekra69pk
 XqEmVVCZkAtLfEeuFew/jDLq38mBJumdK1UPL8suQl+CuzdSkupk0uosRhlGMSrInXIZ
 WTxjCkdy9n9xelAzubsd1uDLBfTAJlKNjPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5j2jv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 13:47:40 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 13:47:39 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id A915FA90283; Fri, 16 Apr 2021 13:47:31 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v2 2/3] bpf/selftests: add bpf_get_task_stack retval bounds verifier test
Date:   Fri, 16 Apr 2021 13:47:03 -0700
Message-ID: <20210416204704.2816874-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416204704.2816874-1-davemarchevsky@fb.com>
References: <20210416204704.2816874-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bPm4a3ZK4FpJslBn7Ky-kcKnAz2R2h1m
X-Proofpoint-ORIG-GUID: bPm4a3ZK4FpJslBn7Ky-kcKnAz2R2h1m
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a bpf_iter test which feeds bpf_get_task_stack's return value into
seq_write after confirming it's positive. No attempt to bound the value
from above is made.

Load will fail if verifier does not refine retval range based on
buf sz input to bpf_get_task_stack.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/verifier/bpf_get_stack.c    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools=
/testing/selftests/bpf/verifier/bpf_get_stack.c
index 69b048cf46d9..3e024c891178 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
@@ -42,3 +42,46 @@
 	.result =3D ACCEPT,
 	.prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
 },
+{
+	"bpf_get_task_stack return R0 range is refined",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_6, 0), // ctx->meta->seq
+	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1, 8), // ctx->task
+	BPF_LD_MAP_FD(BPF_REG_1, 0), // fixup_map_array_48b
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0), // keep buf for seq_write
+	BPF_MOV64_IMM(BPF_REG_3, 48),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	BPF_EMIT_CALL(BPF_FUNC_get_task_stack),
+	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_EMIT_CALL(BPF_FUNC_seq_write),
+
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.prog_type =3D BPF_PROG_TYPE_TRACING,
+	.expected_attach_type =3D BPF_TRACE_ITER,
+	.kfunc =3D "task",
+	.runs =3D -1, // Don't run, just load
+	.fixup_map_array_48b =3D { 3 },
+},
--=20
2.30.2

