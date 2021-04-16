Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C073617E1
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 04:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhDPC4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 22:56:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234751AbhDPC4j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 22:56:39 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13G2sYEw003211
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FYNKgPimmFS1pbbBqLTWaGPfZxCwTAYOXdTMDN1ZnM0=;
 b=pewl1548yOGvOzB7duYqA0+lXVWWwwqaDF7GPEbAtjQmmqWWebKVc3HXzmclKtfqRYca
 BhRKHyi59jVMOx5TBj7kZpwXxAv2MoALD2/lu/JMdJn6KCdvABqJpkQnU1w1Zzw0h9VP
 NXKZIGX47nqMfZIrEH6TSLHRvpUOVJbH1U8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37wvgkbjxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:14 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 19:56:13 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 1C860A2A6A9; Thu, 15 Apr 2021 19:56:11 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/3] bpf/selftests: add bpf_get_task_stack retval bounds verifier test
Date:   Thu, 15 Apr 2021 19:55:36 -0700
Message-ID: <20210416025537.2352753-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416025537.2352753-1-davemarchevsky@fb.com>
References: <20210416025537.2352753-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f5Q6YXEgHjNtjxHCdHBksjxrFS4smR8F
X-Proofpoint-GUID: f5Q6YXEgHjNtjxHCdHBksjxrFS4smR8F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160023
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
---
 .../selftests/bpf/verifier/bpf_get_stack.c    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools=
/testing/selftests/bpf/verifier/bpf_get_stack.c
index 69b048cf46d9..0e8299c043d4 100644
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

