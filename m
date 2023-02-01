Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C1686356
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjBAKFW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 05:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBAKFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:05:16 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EFB4ED3E;
        Wed,  1 Feb 2023 02:05:10 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4P6HbL3zJBz9sgT;
        Wed,  1 Feb 2023 11:05:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ymu4Rqpu4aE7; Wed,  1 Feb 2023 11:05:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4P6HbJ5qQwz9sgZ;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AEFC48B780;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id r2HI3m-KKwj8; Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CB708B779;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 311A4rEY3908590
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 11:04:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 311A4r8M3908589;
        Wed, 1 Feb 2023 11:04:53 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 7/9] powerpc/bpf/32: Optimise some particular const operations
Date:   Wed,  1 Feb 2023 11:04:29 +0100
Message-Id: <e53b1f4a4150ec6cabcaeeef82bf9c361b5f9204.1675245773.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
References: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675245869; l=2234; s=20211009; h=from:subject:message-id; bh=YuBuk5uYdIx8LS0pf+MZXrVabv5ZialJJlRVFsoUpKc=; b=InZ/fuKy6WGVKX4fIP7Hm+vvItF2pw3VX9KTu5c6lOZbqt/MYUus8v02ivsQcbHWzLNnXNOvvEtk ddHpZo2LC0VEJRPJjJJaZR08rMJpGjM4QXrTWCAY2jQY1oP26Crd
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify multiplications and divisions with constants when the
constant is 1 or -1.

When the constant is a power of 2, replace them by bit shits.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit_comp32.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index c3bc20b91cdc..b1d6ed4d8270 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -391,7 +391,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
 			break;
 		case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
-			if (imm >= -32768 && imm < 32768) {
+			if (imm == 1)
+				break;
+			if (imm == -1) {
+				EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
+			} else if (is_power_of_2((u32)imm)) {
+				EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, ilog2(imm)));
+			} else if (imm >= -32768 && imm < 32768) {
 				EMIT(PPC_RAW_MULI(dst_reg, dst_reg, imm));
 			} else {
 				PPC_LI32(_R0, imm);
@@ -411,6 +417,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
 				break;
 			}
+			if (imm > 0 && is_power_of_2(imm)) {
+				imm = ilog2(imm);
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg_h, imm, 0, 31 - imm));
+				EMIT(PPC_RAW_RLWIMI(dst_reg_h, dst_reg, imm, 32 - imm, 31));
+				EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
+				break;
+			}
 			bpf_set_seen_register(ctx, tmp_reg);
 			PPC_LI32(tmp_reg, imm);
 			EMIT(PPC_RAW_MULW(dst_reg_h, dst_reg_h, tmp_reg));
@@ -438,8 +451,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (imm == 1)
 				break;
 
-			PPC_LI32(_R0, imm);
-			EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, _R0));
+			if (is_power_of_2((u32)imm)) {
+				EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, ilog2(imm)));
+			} else {
+				PPC_LI32(_R0, imm);
+				EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, _R0));
+			}
 			break;
 		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
 			if (!imm)
-- 
2.39.1

