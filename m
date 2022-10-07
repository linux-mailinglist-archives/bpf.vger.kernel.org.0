Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56C5F7EA8
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJGUY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 16:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJGUYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 16:24:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74927A287D
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 13:24:21 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297I56fF032285
        for <bpf@vger.kernel.org>; Fri, 7 Oct 2022 13:24:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xyYeBsb1mgZYiH1Znz6FMpvA1Muiz25CbdezPjIOZEI=;
 b=W0O9+EHHeHLep/t4ftyM85yGTMZsyQdVEqVAipJEv5FS1JR2WFhy6d2B5cpEDAA0/Ehv
 lkbwqKzVCzYmep0SINbXpYaPZc4MjmV4e2YTpbMJ77hfZyko4dVjDjdnP/uKmsNXE0z9
 MmjxRIBFpu9dPCO/t7Hr2nf26dpVbCfZajM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k1tp758s7-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Oct 2022 13:24:20 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 13:24:19 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 843631142F722; Fri,  7 Oct 2022 13:24:13 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <kpsingh@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <andrii@kernel.org>, <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v5 2/3] bpf,x64: use shrx/sarx/shlx when available
Date:   Fri, 7 Oct 2022 13:23:48 -0700
Message-ID: <20221007202348.1118830-3-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CACYkzJ7gz8Y0JXgfs2vKG5nF98iS+UdqpM9Vk0OOnSfYvMdK4g@mail.gmail.com>
References: <CACYkzJ7gz8Y0JXgfs2vKG5nF98iS+UdqpM9Vk0OOnSfYvMdK4g@mail.gmail.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CLr22iRPZDxY036RSErl-V62LS5uToch
X-Proofpoint-ORIG-GUID: CLr22iRPZDxY036RSErl-V62LS5uToch
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BMI2 provides 3 shift instructions (shrx, sarx and shlx) that use VEX
encoding but target general purpose registers [1]. They allow the shift
count in any general purpose register and have the same performance as
non BMI2 shift instructions [2].

Instead of shr/sar/shl that implicitly use %cl (lowest 8 bit of %rcx),
emit their more flexible alternatives provided in BMI2 when advantageous;
keep using the non BMI2 instructions when shift count is already in
BPF_REG_4/%rcx as non BMI2 instructions are shorter.

To summarize, when BMI2 is available:
-------------------------------------------------
            |   arbitrary dst
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
src =3D=3D ecx  |   shl dst, cl
-------------------------------------------------
src !=3D ecx  |   shlx dst, dst, src
-------------------------------------------------

And no additional register shuffling is needed.

A concrete example between non BMI2 and BMI2 codegen.  To shift %rsi by
%rdi:

Without BMI2:

 ef3:   push   %rcx
        51
 ef4:   mov    %rdi,%rcx
        48 89 f9
 ef7:   shl    %cl,%rsi
        48 d3 e6
 efa:   pop    %rcx
        59

With BMI2:

 f0b:   shlx   %rdi,%rsi,%rsi
        c4 e2 c1 f7 f6

[1] https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
[2] https://www.agner.org/optimize/instruction_tables.pdf

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d926ca637d8d..d7dd8e0db8da 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -891,6 +891,65 @@ static void emit_nops(u8 **pprog, int len)
 	*pprog =3D prog;
 }
=20
+/* emit the 3-byte VEX prefix
+ *
+ * r: same as rex.r, extra bit for ModRM reg field
+ * x: same as rex.x, extra bit for SIB index field
+ * b: same as rex.b, extra bit for ModRM r/m, or SIB base
+ * m: opcode map select, encoding escape bytes e.g. 0x0f38
+ * w: same as rex.w (32 bit or 64 bit) or opcode specific
+ * src_reg2: additional source reg (encoded as BPF reg)
+ * l: vector length (128 bit or 256 bit) or reserved
+ * pp: opcode prefix (none, 0x66, 0xf2 or 0xf3)
+ */
+static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
+		      bool w, u8 src_reg2, bool l, u8 pp)
+{
+	u8 *prog =3D *pprog;
+	const u8 b0 =3D 0xc4; /* first byte of 3-byte VEX prefix */
+	u8 b1, b2;
+	u8 vvvv =3D reg2hex[src_reg2];
+
+	/* reg2hex gives only the lower 3 bit of vvvv */
+	if (is_ereg(src_reg2))
+		vvvv |=3D 1 << 3;
+
+	/*
+	 * 2nd byte of 3-byte VEX prefix
+	 * ~ means bit inverted encoding
+	 *
+	 *    7                           0
+	 *  +---+---+---+---+---+---+---+---+
+	 *  |~R |~X |~B |         m         |
+	 *  +---+---+---+---+---+---+---+---+
+	 */
+	b1 =3D (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);
+	/*
+	 * 3rd byte of 3-byte VEX prefix
+	 *
+	 *    7                           0
+	 *  +---+---+---+---+---+---+---+---+
+	 *  | W |     ~vvvv     | L |   pp  |
+	 *  +---+---+---+---+---+---+---+---+
+	 */
+	b2 =3D (w << 7) | ((~vvvv & 0xf) << 3) | (l << 2) | (pp & 3);
+
+	EMIT3(b0, b1, b2);
+	*pprog =3D prog;
+}
+
+/* emit BMI2 shift instruction */
+static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8=
 op)
+{
+	u8 *prog =3D *pprog;
+	bool r =3D is_ereg(dst_reg);
+	u8 m =3D 2; /* escape code 0f38 */
+
+	emit_3vex(&prog, r, false, r, m, is64, src_reg, false, op);
+	EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
+	*pprog =3D prog;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw=
_image,
@@ -1137,6 +1196,28 @@ static int do_jit(struct bpf_prog *bpf_prog, int *ad=
drs, u8 *image, u8 *rw_image
 		case BPF_ALU64 | BPF_LSH | BPF_X:
 		case BPF_ALU64 | BPF_RSH | BPF_X:
 		case BPF_ALU64 | BPF_ARSH | BPF_X:
+			/* BMI2 shifts aren't better when shift count is already in rcx */
+			if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg !=3D BPF_REG_4) {
+				/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
+				bool w =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
+				u8 op;
+
+				switch (BPF_OP(insn->code)) {
+				case BPF_LSH:
+					op =3D 1; /* prefix 0x66 */
+					break;
+				case BPF_RSH:
+					op =3D 3; /* prefix 0xf2 */
+					break;
+				case BPF_ARSH:
+					op =3D 2; /* prefix 0xf3 */
+					break;
+				}
+
+				emit_shiftx(&prog, dst_reg, src_reg, w, op);
+
+				break;
+			}
=20
 			if (src_reg !=3D BPF_REG_4) { /* common case */
 				/* Check for bad case when dst_reg =3D=3D rcx */
--=20
2.30.2

