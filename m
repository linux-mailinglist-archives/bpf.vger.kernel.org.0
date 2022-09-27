Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF36E5ECC7F
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiI0S6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0S6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:58:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532731DB548
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:44 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RD5oPW015938
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=g0GyE0YNtLCaf+o/OcF75OlaLwk3uYstodM8y0DIv5A=;
 b=ICZhdGQ3x7igV9qoNTN7bVP25tQN/I5SNudrChjznzYCRMwytIk8+M+qR4ACeqsG88a4
 IE7oeKGXjdmLXdjWrpgVyM873Q2QC1s7CL68xrbWdR5gzn9pTXEwwTvmn9Z+WXlPl5b2
 HYjIj3LMOPEOcLXm3XLwmzFH4uf2kDH+ShQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jumv5ew5p-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:44 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 11:58:42 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id D0A1D10B4B676; Tue, 27 Sep 2022 11:58:34 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v3 2/3] bpf,x64: use shrx/sarx/shlx when available
Date:   Tue, 27 Sep 2022 11:58:00 -0700
Message-ID: <20220927185801.1824838-3-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927185801.1824838-1-jmeng@fb.com>
References: <7437e1cb-325c-fc86-37f6-3422c085007d@iogearbox.net>
 <20220927185801.1824838-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NKbsq47OCTQuknaES8VbE2hRVUMCF8ng
X-Proofpoint-ORIG-GUID: NKbsq47OCTQuknaES8VbE2hRVUMCF8ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
alternatives provided in BMI2 when advantageous; keep using the non BMI2
instructions when shift count is already in BPF_REG_4/rcx as non BMI2
instructions are shorter.

To summarize, when BMI2 is available:
-------------------------------------------------
            |   arbitrary dst
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
src =3D=3D ecx  |   shl dst, cl
-------------------------------------------------
src !=3D ecx  |   shlx dst, dst, src
-------------------------------------------------

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

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a5c59f1e6f9..f91eac901c32 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -889,6 +889,48 @@ static void emit_nops(u8 **pprog, int len)
 	*pprog =3D prog;
 }
=20
+/* emit the 3-byte VEX prefix */
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
+/* emit BMI2 shift instruction */
+static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, =
u8 op)
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
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
@@ -1135,6 +1177,28 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
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

