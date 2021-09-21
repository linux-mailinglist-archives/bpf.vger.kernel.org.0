Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66838412A44
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhIUBdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 21:33:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4484 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhIUBdH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 21:33:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwMcT028630
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=G6JlfMaj3ieCK0PRofb89XlBrM0Xdtah7XuApqlYmoY=;
 b=IxuFkfWbY7G9Yl+N/9fCvl4c35dwbfpVc/9GfnSjR4HYQ0nv+TBDGFjWYIhl01J4NgLQ
 zJXSdbIo2BDBoA0mDqX6rqD1cWpmu/x8rSN8WDQRU+4Inx69IyuodYOYC8zrj6uj+42v
 hOi6SA0a7CPZy/OuHD+lFkUvQqcCgK3b5bA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6kt66b1v-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:38 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 18:31:36 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id AA2332940D2A; Mon, 20 Sep 2021 18:31:29 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 4/4] bpf: selftest: Add verifier tests for <8-byte scalar spill and refill
Date:   Mon, 20 Sep 2021 18:31:29 -0700
Message-ID: <20210921013129.1037825-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921013102.1035356-1-kafai@fb.com>
References: <20210921013102.1035356-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: wQrEUaKF0LAbxpJmfQbLpUXnS4uEnMvo
X-Proofpoint-GUID: wQrEUaKF0LAbxpJmfQbLpUXnS4uEnMvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_11,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a few verifier tests for <8-byte spill and refill.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/verifier/spill_fill.c       | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/te=
sting/selftests/bpf/verifier/spill_fill.c
index 0b943897aaf6..c9991c3f3bd2 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -104,3 +104,164 @@
 	.result =3D ACCEPT,
 	.retval =3D POINTER_VALUE,
 },
+{
+	"Spill and refill a u32 const scalar.  Offset to skb->data",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 =3D 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 =3D *(u32 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 =3D r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3Dinv20 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=3Dpkt,off=3D20 R2=3Dpkt R3=3Dpkt_end R4=3Dinv20 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 =3D *(u32 *)r2 R0=3Dpkt,off=3D20,r=3D20 R2=3Dpkt,r=3D20 R3=3Dpkt_=
end R4=3Dinv20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const, refill from another half of the uninit u32 from the=
 stack",
+	.insns =3D {
+	/* r4 =3D 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 =3D *(u32 *)(r10 -4) fp-8=3D????rrrr*/
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D REJECT,
+	.errstr =3D "invalid read from stack off -4+0 size 4",
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const scalar.  Refill as u16.  Offset to skb->data",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 =3D 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 =3D *(u16 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 =3D r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3Dinv,umax=3D65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=3Dpkt,umax=3D65535 R2=3Dpkt R3=3Dpkt_end R4=3Dinv,um=
ax=3D65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 =3D *(u32 *)r2 R0=3Dpkt,umax=3D65535 R2=3Dpkt R3=3Dpkt_end R4=3Di=
nv20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D REJECT,
+	.errstr =3D "invalid access to packet",
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->da=
ta",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 =3D 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 =3D *(u16 *)(r10 -6) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -6),
+	/* r0 =3D r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3Dinv,umax=3D65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=3Dpkt,umax=3D65535 R2=3Dpkt R3=3Dpkt_end R4=3Dinv,um=
ax=3D65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 =3D *(u32 *)r2 R0=3Dpkt,umax=3D65535 R2=3Dpkt R3=3Dpkt_end R4=3Di=
nv20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D REJECT,
+	.errstr =3D "invalid access to packet",
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill and refill a u32 const scalar at non 8byte aligned stack addr.  =
Offset to skb->data",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 =3D 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* *(u32 *)(r10 -4) =3D r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
+	/* r4 =3D *(u32 *)(r10 -4),  */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
+	/* r0 =3D r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 +=3D r4 R0=3Dpkt R2=3Dpkt R3=3Dpkt_end R4=3Dinv,umax=3DU32_MAX */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=3Dpkt,umax=3DU32_MAX R2=3Dpkt R3=3Dpkt_end R4=3Dinv =
*/
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 =3D *(u32 *)r2 R0=3Dpkt,umax=3DU32_MAX R2=3Dpkt R3=3Dpkt_end R4=3D=
inv */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D REJECT,
+	.errstr =3D "invalid access to packet",
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill and refill a umax=3D40 bounded scalar.  Offset to skb->data",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1,
+		    offsetof(struct __sk_buff, tstamp)),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_4, 40, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* *(u32 *)(r10 -8) =3D r4 R4=3Dinv,umax=3D40 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 =3D (*u32 *)(r10 - 8) */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
+	/* r2 +=3D r4 R2=3Dpkt R4=3Dinv,umax=3D40 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_4),
+	/* r0 =3D r2 R2=3Dpkt,umax=3D40 R4=3Dinv,umax=3D40 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r2 +=3D 20 R0=3Dpkt,umax=3D40 R2=3Dpkt,umax=3D40 */
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 20),
+	/* if (r2 > r3) R0=3Dpkt,umax=3D40 R2=3Dpkt,off=3D20,umax=3D40 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 1),
+	/* r0 =3D *(u32 *)r0 R0=3Dpkt,r=3D20,umax=3D40 R2=3Dpkt,off=3D20,r=3D20=
,umax=3D40 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+},
--=20
2.30.2

