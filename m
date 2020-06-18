Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480C11FFEE0
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 01:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFRXqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 19:46:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbgFRXqg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 19:46:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05INhewi005000
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SMhyFLdD4X1h7RYfqJWuVJB9LC3jiUtXAga6EpQL8vI=;
 b=eJ9aXhgql4IPbSxS1+TzqIt5bQXyKY4OmzjyORsJhUoMbe7e4t3k490HgG/HtxNR2vVt
 SljwLQSfihFxC+m6aoGizjPm6y0DI9ixKu6oGwF91txkATcK0okUKn/BSuvj0Dk5LNqb
 MBT011CEGBC3pHygq0T2JYZoUH67bzBWfI8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31q644y0ca-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 16:46:35 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 16:46:34 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 1FD873704C19; Thu, 18 Jun 2020 16:46:32 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] tools/bpf: add verifier tests for 32bit pointer/scalar arithmetic
Date:   Thu, 18 Jun 2020 16:46:32 -0700
Message-ID: <20200618234632.3321367-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200618234631.3321026-1-yhs@fb.com>
References: <20200618234631.3321026-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_21:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 cotscore=-2147483648 suspectscore=13 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=641 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180182
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added two test_verifier subtests for 32bit pointer/scalar arithmetic
with BPF_SUB operator. They are passing verifier now.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/verifier/value_ptr_arith.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/too=
ls/testing/selftests/bpf/verifier/value_ptr_arith.c
index 97ee658e1242..ed4e76b24649 100644
--- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
@@ -836,3 +836,41 @@
 	.errstr =3D "R0 invalid mem access 'inv'",
 	.errstr_unpriv =3D "R0 pointer -=3D pointer prohibited",
 },
+{
+	"32bit pkt_ptr -=3D scalar",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 40),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
+	BPF_ALU32_REG(BPF_MOV, BPF_REG_4, BPF_REG_7),
+	BPF_ALU32_REG(BPF_SUB, BPF_REG_6, BPF_REG_4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+	.result =3D ACCEPT,
+	.flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
+{
+	"32bit scalar -=3D pkt_ptr",
+	.insns =3D {
+	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 40),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
+	BPF_ALU32_REG(BPF_MOV, BPF_REG_4, BPF_REG_6),
+	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_7),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+	.result =3D ACCEPT,
+	.flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
+},
--=20
2.24.1

