Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69895BF36A
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 04:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUCWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIUCWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 22:22:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F7149B79
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 19:21:59 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KL3DoF014451
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 19:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=e49NcZpgCFpb0dqDSixxDl7cRq97Y2YV7rCYjKMHYJc=;
 b=S5PGS8BK7zrKHRnF2Zjo/hoGD7aCJWyQBySmWW6TSL0KSvdUN0EA4+dlywkrusfAu/GU
 C2VYVHyd2yhMak09yIFM+v8XQ46QpisAkzGkB9VeagfxV3u9f65Dcwg1OVjNkp1itTyU
 no7ZTvqDslNTCnF6j7KFGCgI2kXQRgTDVg0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpyt7t6cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 19:21:58 -0700
Received: from twshared22593.02.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 19:21:57 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id D4DDD10577438; Tue, 20 Sep 2022 19:21:53 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next] bpf,x64: use shrx/sarx/shlx when available
Date:   Tue, 20 Sep 2022 19:21:43 -0700
Message-ID: <20220921022143.1405126-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6nNw3DtIs7FBo-0DgAH2hqrC1uEj3pQU
X-Proofpoint-GUID: 6nNw3DtIs7FBo-0DgAH2hqrC1uEj3pQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_12,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
alternatives provided in BMI2

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c                | 53 ++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/jit.c |  7 +--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ae89f4143eb4..81a3b34327ae 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -889,6 +889,35 @@ static void emit_nops(u8 **pprog, int len)
 	*pprog =3D prog;
 }
=20
+static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
+		      bool w, u8 src_reg2, bool l, u8 p)
+{
+	u8 *prog =3D *pprog;
+	u8 b0 =3D 0xc4, b1, b2;
+	u8 src2 =3D reg2hex[src_reg2];
+
+	if (is_ereg(src_reg2))
+		src2 |=3D 1 << 3;
+
+	/*
+	 *    7                           0
+	 *  +---+---+---+---+---+---+---+---+
+	 *  |~R |~X |~B |         m         |
+	 *  +---+---+---+---+---+---+---+---+
+	 */
+	b1 =3D (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);
+	/*
+	 *    7                           0
+	 *  +---+---+---+---+---+---+---+---+
+	 *  | W |     ~vvvv     | L |   pp  |
+	 *  +---+---+---+---+---+---+---+---+
+	 */
+	b2 =3D (w << 7) | ((~src2 & 0xf) << 3) | (l << 2) | (p & 3);
+
+	EMIT3(b0, b1, b2);
+	*pprog =3D prog;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
@@ -1135,7 +1164,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		case BPF_ALU64 | BPF_LSH | BPF_X:
 		case BPF_ALU64 | BPF_RSH | BPF_X:
 		case BPF_ALU64 | BPF_ARSH | BPF_X:
+			if (boot_cpu_has(X86_FEATURE_BMI2)) {
+				/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
+				bool r =3D is_ereg(dst_reg);
+				u8 m =3D 2; /* escape code 0f38 */
+				bool w =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
+				u8 p;
+
+				switch (BPF_OP(insn->code)) {
+				case BPF_LSH:
+					p =3D 1; /* prefix 0x66 */
+					break;
+				case BPF_RSH:
+					p =3D 3; /* prefix 0xf2 */
+					break;
+				case BPF_ARSH:
+					p =3D 2; /* prefix 0xf3 */
+					break;
+				}
+
+				emit_3vex(&prog, r, false, r, m,
+					  w, src_reg, false, p);
+				EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
=20
+				break;
+			}
 			/* Check for bad case when dst_reg =3D=3D rcx */
 			if (dst_reg =3D=3D BPF_REG_4) {
 				/* mov r11, dst_reg */
diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index 79021c30e51e..3323b93f0972 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -4,15 +4,16 @@
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_MOV64_IMM(BPF_REG_1, 0xff),
 	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 1),
-	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 1),
+	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
 	BPF_EXIT_INSN(),
-	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 1),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_0),
 	BPF_ALU32_IMM(BPF_RSH, BPF_REG_1, 1),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0xff, 1),
 	BPF_EXIT_INSN(),
 	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 1),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x7f, 1),
+	BPF_ALU32_REG(BPF_ARSH, BPF_REG_1, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3f, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
--=20
2.30.2

