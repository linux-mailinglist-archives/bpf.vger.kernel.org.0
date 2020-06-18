Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C501FFEDF
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFRXqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 19:46:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgFRXqd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 19:46:33 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05INkXs9005219
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:46:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eVCfGBwz39LU/svwoTLby1J/LxKGSWubshX1i2Mel64=;
 b=qSoTJvljoXOj4t4CUWASlBQfySu7A8gDtX6An32lBuNSVG6ej44w1V6QIpwpQGG4RfN4
 B+uYPKh7anBSRNxjcLVpFkW4WIuiF6lXuG2rqsw7q6TO0TV1o3eVtS5S3zQSUxCevJ+E
 kiMnDGYM6sVYT/JX3jtWVikrdrS29vJ8Vag= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65df5jh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:46:33 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 16:46:32 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id BACE83704D98; Thu, 18 Jun 2020 16:46:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] bpf: avoid verifier failure for 32bit pointer arithmetic
Date:   Thu, 18 Jun 2020 16:46:31 -0700
Message-ID: <20200618234631.3321118-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200618234631.3321026-1-yhs@fb.com>
References: <20200618234631.3321026-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=849
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=13 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When do experiments with llvm (disabling instcombine and
simplifyCFG), I hit the following error with test_seg6_loop.o.

  ; R1=3Dpkt(id=3D0,off=3D0,r=3D48,imm=3D0), R7=3Dpkt(id=3D0,off=3D40,r=3D=
48,imm=3D0)
  w2 =3D w7
  ; R2_w=3Dinv(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xffffffff)=
)
  w2 -=3D w1
  R2 32-bit pointer arithmetic prohibited

The corresponding source code is:
  uint32_t srh_off
  // srh and skb->data are all packet pointers
  srh_off =3D (char *)srh - (char *)(long)skb->data;

The verifier does not support 32-bit pointer/scalar arithmetic.

Without my llvm change, the code looks like

  ; R3=3Dpkt(id=3D0,off=3D40,r=3D48,imm=3D0), R8=3Dpkt(id=3D0,off=3D0,r=3D=
48,imm=3D0)
  w3 -=3D w8
  ; R3_w=3Dinv(id=3D0)

This is explicitly allowed in verifier if both registers are
pointers and the opcode is BPF_SUB.

To fix this problem, I changed the verifier to allow
32-bit pointer/scaler BPF_SUB operations.

At the source level, the issue could be workarounded with
inline asm or changing "uint32_t srh_off" to "uint64_t srh_off".
But I feel that verifier change might be the right thing to do.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22d90d47befa..bbf6d655d6ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5052,6 +5052,11 @@ static int adjust_ptr_min_max_vals(struct bpf_veri=
fier_env *env,
=20
 	if (BPF_CLASS(insn->code) !=3D BPF_ALU64) {
 		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
+		if (opcode =3D=3D BPF_SUB && env->allow_ptr_leaks) {
+			__mark_reg_unknown(env, dst_reg);
+			return 0;
+		}
+
 		verbose(env,
 			"R%d 32-bit pointer arithmetic prohibited\n",
 			dst);
--=20
2.24.1

