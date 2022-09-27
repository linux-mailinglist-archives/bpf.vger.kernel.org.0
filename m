Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D505ECC7E
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiI0S6o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0S6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:58:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C211DB54C
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RD5oPS015938
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Tw59ClHvl/v9nyocTsrkM162WBmFqvGAp8VweSRoggw=;
 b=WzDiHbGBFer3mI+jp1TDp0Q18HXc+vAwyvXSCW2PX+qGJGXNyUspqe8VuLBtOfAy8wM0
 qBgU533QvpPnbkW0sJgmsH8DAykFb5ndgLL4ikKG591CmTOubS1SsKqYjN93A3OuVdaU
 TRs0XOfC4KWp5YtcKLf9ACNGz1yyDSD92+k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jumv5ew5p-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:58:42 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 11:58:41 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id C16ED10B4B674; Tue, 27 Sep 2022 11:58:34 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v3 1/3] bpf,x64: avoid unnecessary instructions when shift dest is ecx
Date:   Tue, 27 Sep 2022 11:57:59 -0700
Message-ID: <20220927185801.1824838-2-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927185801.1824838-1-jmeng@fb.com>
References: <7437e1cb-325c-fc86-37f6-3422c085007d@iogearbox.net>
 <20220927185801.1824838-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gHMJSBqUpOIXjbHRVcP3btdoEaDKjBaO
X-Proofpoint-ORIG-GUID: gHMJSBqUpOIXjbHRVcP3btdoEaDKjBaO
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

x64 JIT produces redundant instructions when a shift operation's
destination register is BPF_REG_4/ecx and this patch removes them.

Specifically, when dest reg is BPF_REG_4 but the src isn't, we
needn't push and pop ecx around shift only to get it overwritten
by r11 immediately afterwards.

In the rare case when both dest and src registers are BPF_REG_4,
a single shift instruction is sufficient and we don't need the
two MOV instructions around the shift.

To summarize using shift left as an example, without patch:
-------------------------------------------------
            |   dst =3D=3D ecx     |    dst !=3D ecx
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
src =3D=3D ecx  |   mov r11, ecx   |    shl dst, cl
            |   shl r11, ecx   |
            |   mov ecx, r11   |
-------------------------------------------------
src !=3D ecx  |   mov r11, ecx   |    push ecx
            |   push ecx       |    mov ecx, src
            |   mov ecx, src   |    shl dst, cl
            |   shl r11, cl    |    pop ecx
            |   pop ecx        |
            |   mov ecx, r11   |
-------------------------------------------------

With patch:
-------------------------------------------------
            |   dst =3D=3D ecx     |    dst !=3D ecx
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
src =3D=3D ecx  |   shl ecx, cl    |    shl dst, cl
-------------------------------------------------
src !=3D ecx  |   mov r11, ecx   |    push ecx
            |   mov ecx, src   |    mov ecx, src
            |   shl r11, cl    |    shl dst, cl
            |   mov ecx, r11   |    pop ecx
-------------------------------------------------

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 35796db58116..6a5c59f1e6f9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1136,18 +1136,18 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 		case BPF_ALU64 | BPF_RSH | BPF_X:
 		case BPF_ALU64 | BPF_ARSH | BPF_X:
=20
-			/* Check for bad case when dst_reg =3D=3D rcx */
-			if (dst_reg =3D=3D BPF_REG_4) {
-				/* mov r11, dst_reg */
-				EMIT_mov(AUX_REG, dst_reg);
-				dst_reg =3D AUX_REG;
-			}
-
 			if (src_reg !=3D BPF_REG_4) { /* common case */
-				EMIT1(0x51); /* push rcx */
-
-				/* mov rcx, src_reg */
-				EMIT_mov(BPF_REG_4, src_reg);
+				/* Check for bad case when dst_reg =3D=3D rcx */
+				if (dst_reg =3D=3D BPF_REG_4) {
+					/* mov r11, dst_reg */
+					EMIT_mov(AUX_REG, dst_reg);
+					dst_reg =3D AUX_REG;
+				} else {
+					EMIT1(0x51); /* push rcx */
+
+					/* mov rcx, src_reg */
+					EMIT_mov(BPF_REG_4, src_reg);
+				}
 			}
=20
 			/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
@@ -1157,12 +1157,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 			b3 =3D simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(0xD3, add_1reg(b3, dst_reg));
=20
-			if (src_reg !=3D BPF_REG_4)
-				EMIT1(0x59); /* pop rcx */
+			if (src_reg !=3D BPF_REG_4) {
+				if (insn->dst_reg =3D=3D BPF_REG_4)
+					/* mov dst_reg, r11 */
+					EMIT_mov(insn->dst_reg, AUX_REG);
+				else
+					EMIT1(0x59); /* pop rcx */
+			}
=20
-			if (insn->dst_reg =3D=3D BPF_REG_4)
-				/* mov dst_reg, r11 */
-				EMIT_mov(insn->dst_reg, AUX_REG);
 			break;
=20
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
--=20
2.30.2

