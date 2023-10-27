Return-Path: <bpf+bounces-13442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC87D9F9F
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7F91C2113C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7C3C071;
	Fri, 27 Oct 2023 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D73C067
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:16:45 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D02D9
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:44 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39RE53bs003192
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u089achyn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:16:42 -0700
Received: from twshared9518.03.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:16:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2B7D33A796695; Fri, 27 Oct 2023 11:14:20 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v5 bpf-next 13/23] bpf: move is_branch_taken() down
Date: Fri, 27 Oct 2023 11:13:36 -0700
Message-ID: <20231027181346.4019398-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181346.4019398-1-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: d0Wz0Nb4YUGZ1qdZFg1Q8y2Z3F0lDOZ5
X-Proofpoint-ORIG-GUID: d0Wz0Nb4YUGZ1qdZFg1Q8y2Z3F0lDOZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02

Move is_branch_taken() slightly down. In subsequent patched we'll need
both flip_opcode() and is_pkt_ptr_branch_taken() for is_branch_taken(),
but instead of sprinkling forward declarations around, it makes more
sense to move is_branch_taken() lower below is_pkt_ptr_branch_taken(),
and also keep it closer to very tightly related reg_set_min_max(), as
they are two critical parts of the same SCALAR range tracking logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 84 +++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd328c579f10..25b5234ebda3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14339,48 +14339,6 @@ static int is_branch64_taken(struct bpf_reg_stat=
e *reg1, struct bpf_reg_state *r
 	return -1;
 }
=20
-/* compute branch direction of the expression "if (<reg1> opcode <reg2>)=
 goto target;"
- * and return:
- *  1 - branch will be taken and "goto target" will be executed
- *  0 - branch will not be taken and fall-through to next insn
- * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register value
- *      range [0,10]
- */
-static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
-			   u8 opcode, bool is_jmp32)
-{
-	struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2-=
>var_off;
-	u64 val;
-
-	if (!tnum_is_const(reg2_tnum))
-		return -1;
-	val =3D reg2_tnum.value;
-
-	if (__is_pointer_value(false, reg1)) {
-		if (!reg_not_null(reg1))
-			return -1;
-
-		/* If pointer is valid tests against zero will fail so we can
-		 * use this to direct branch taken.
-		 */
-		if (val !=3D 0)
-			return -1;
-
-		switch (opcode) {
-		case BPF_JEQ:
-			return 0;
-		case BPF_JNE:
-			return 1;
-		default:
-			return -1;
-		}
-	}
-
-	if (is_jmp32)
-		return is_branch32_taken(reg1, reg2, opcode);
-	return is_branch64_taken(reg1, reg2, opcode);
-}
-
 static int flip_opcode(u32 opcode)
 {
 	/* How can we transform "a <op> b" into "b <op> a"? */
@@ -14442,6 +14400,48 @@ static int is_pkt_ptr_branch_taken(struct bpf_re=
g_state *dst_reg,
 	return -1;
 }
=20
+/* compute branch direction of the expression "if (<reg1> opcode <reg2>)=
 goto target;"
+ * and return:
+ *  1 - branch will be taken and "goto target" will be executed
+ *  0 - branch will not be taken and fall-through to next insn
+ * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register value
+ *      range [0,10]
+ */
+static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
+			   u8 opcode, bool is_jmp32)
+{
+	struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2-=
>var_off;
+	u64 val;
+
+	if (!tnum_is_const(reg2_tnum))
+		return -1;
+	val =3D reg2_tnum.value;
+
+	if (__is_pointer_value(false, reg1)) {
+		if (!reg_not_null(reg1))
+			return -1;
+
+		/* If pointer is valid tests against zero will fail so we can
+		 * use this to direct branch taken.
+		 */
+		if (val !=3D 0)
+			return -1;
+
+		switch (opcode) {
+		case BPF_JEQ:
+			return 0;
+		case BPF_JNE:
+			return 1;
+		default:
+			return -1;
+		}
+	}
+
+	if (is_jmp32)
+		return is_branch32_taken(reg1, reg2, opcode);
+	return is_branch64_taken(reg1, reg2, opcode);
+}
+
 /* Adjusts the register min/max values in the case that the dst_reg is t=
he
  * variable register that we are working on, and src_reg is a constant o=
r we're
  * simply doing a BPF_K check.
--=20
2.34.1


