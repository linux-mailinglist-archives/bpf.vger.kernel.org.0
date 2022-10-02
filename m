Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EA5F2156
	for <lists+bpf@lfdr.de>; Sun,  2 Oct 2022 07:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJBFMB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 01:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJBFMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 01:12:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFBD5072C
        for <bpf@vger.kernel.org>; Sat,  1 Oct 2022 22:11:58 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2922UMmn010951
        for <bpf@vger.kernel.org>; Sat, 1 Oct 2022 22:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=blWgJUKo2fEjrg8otb1YMeoqVIacBbtSVSu/vrW5KRY=;
 b=VL8UJ207lbQVjsKMxI69ei39riuuf/CB3tQBVj2KCK147GGgdcFUixDwQltD2xMXhHAf
 lyvLVhOHaIEXTyThB5S70mwscS+nkD5tia6f2uoBbcrFjzvuRlHWFqry7jOV25Y8HuDT
 sXsXaVP2CNGcGglGc/IMa71QFjxpkPHmo+0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxk8qudvm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Oct 2022 22:11:57 -0700
Received: from twshared15978.04.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 1 Oct 2022 22:11:56 -0700
Received: by devbig150.prn5.facebook.com (Postfix, from userid 187975)
        id 6740410F44C84; Sat,  1 Oct 2022 22:11:51 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next v4 1/3] bpf,x64: avoid unnecessary instructions when shift dest is ecx
Date:   Sat, 1 Oct 2022 22:11:41 -0700
Message-ID: <20221002051143.831029-2-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221002051143.831029-1-jmeng@fb.com>
References: <20220927185801.1824838-1-jmeng@fb.com>
 <20221002051143.831029-1-jmeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: C2XZXrfTFuuV6VaKKHm0_6KqAIAlpq7q
X-Proofpoint-ORIG-GUID: C2XZXrfTFuuV6VaKKHm0_6KqAIAlpq7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_15,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/net/bpf_jit_comp.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5b6230779cf3..d9ba997c5891 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1136,16 +1136,15 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
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
+				/* Check for bad case when dst_reg =3D=3D rcx */
+				if (dst_reg =3D=3D BPF_REG_4) {
+					/* mov r11, dst_reg */
+					EMIT_mov(AUX_REG, dst_reg);
+					dst_reg =3D AUX_REG;
+				} else {
+					EMIT1(0x51); /* push rcx */
+				}
 				/* mov rcx, src_reg */
 				EMIT_mov(BPF_REG_4, src_reg);
 			}
@@ -1157,12 +1156,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
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

