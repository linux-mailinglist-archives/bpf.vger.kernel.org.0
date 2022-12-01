Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1063EAA1
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 08:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiLAH5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 02:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLAH5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 02:57:09 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A151316;
        Wed, 30 Nov 2022 23:57:08 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4NN7hG0wSwz9sXw;
        Thu,  1 Dec 2022 08:57:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZHx9Acv37piw; Thu,  1 Dec 2022 08:57:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4NN7hD3gmRz9sZt;
        Thu,  1 Dec 2022 08:57:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6603B8B786;
        Thu,  1 Dec 2022 08:57:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uqtkp7rnjH06; Thu,  1 Dec 2022 08:57:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D734D8B788;
        Thu,  1 Dec 2022 08:56:59 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2B17uvPo130832
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 08:56:57 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2B17uvE7130831;
        Thu, 1 Dec 2022 08:56:57 +0100
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
Subject: [PATCH v1 07/10] powerpc/bpf: Only pad length-variable code at initial pass
Date:   Thu,  1 Dec 2022 08:56:32 +0100
Message-Id: <ee5253722c2a1e26b8bec3691166d7081538c7cb.1669881248.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
References: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669881391; l=3050; s=20211009; h=from:subject:message-id; bh=nL5CqXWPiz/BUngCysQIWSZa7hNQZeFj8xwmb11p9kA=; b=RnNHGX2YEBBid1pt9gpxSmgra+AVaIn4fG1kA2C89gHzjdE/DzWTQW+BefFonH49GkyGXE1f26Xo 7vNq9xWLD5Dfh2nBL4rDcXOWOJTvaNHIUAOY+GPWE7ITgEQZ0142
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that two real additional passes are performed in case of extra pass
requested by BPF core, padding is not needed anymore except during
initial pass done before memory allocation to count maximum possible
program size.

So, only do the padding when 'image' is NULL.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit_comp32.c |  8 +++-----
 arch/powerpc/net/bpf_jit_comp64.c | 12 +++++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7c129fe810f5..6c45d953d4e8 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -206,9 +206,6 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
 
 	if (image && rel < 0x2000000 && rel >= -0x2000000) {
 		PPC_BL(func);
-		EMIT(PPC_RAW_NOP());
-		EMIT(PPC_RAW_NOP());
-		EMIT(PPC_RAW_NOP());
 	} else {
 		/* Load function address into r0 */
 		EMIT(PPC_RAW_LIS(_R0, IMM_H(func)));
@@ -973,8 +970,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			PPC_LI32(dst_reg_h, (u32)insn[i + 1].imm);
 			PPC_LI32(dst_reg, (u32)insn[i].imm);
 			/* padding to allow full 4 instructions for later patching */
-			for (j = ctx->idx - tmp_idx; j < 4; j++)
-				EMIT(PPC_RAW_NOP());
+			if (!image)
+				for (j = ctx->idx - tmp_idx; j < 4; j++)
+					EMIT(PPC_RAW_NOP());
 			/* Adjust for two bpf instructions */
 			addrs[++i] = ctx->idx * 4;
 			break;
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 29ee306d6302..1c2931b4bc15 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -240,13 +240,14 @@ int bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func
 	 * load the callee's address, but this may optimize the number of
 	 * instructions required based on the nature of the address.
 	 *
-	 * Since we don't want the number of instructions emitted to change,
+	 * Since we don't want the number of instructions emitted to increase,
 	 * we pad the optimized PPC_LI64() call with NOPs to guarantee that
 	 * we always have a five-instruction sequence, which is the maximum
 	 * that PPC_LI64() can emit.
 	 */
-	for (i = ctx->idx - ctx_idx; i < 5; i++)
-		EMIT(PPC_RAW_NOP());
+	if (!image)
+		for (i = ctx->idx - ctx_idx; i < 5; i++)
+			EMIT(PPC_RAW_NOP());
 
 	EMIT(PPC_RAW_MTCTR(_R12));
 	EMIT(PPC_RAW_BCTRL());
@@ -938,8 +939,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			tmp_idx = ctx->idx;
 			PPC_LI64(dst_reg, imm64);
 			/* padding to allow full 5 instructions for later patching */
-			for (j = ctx->idx - tmp_idx; j < 5; j++)
-				EMIT(PPC_RAW_NOP());
+			if (!image)
+				for (j = ctx->idx - tmp_idx; j < 5; j++)
+					EMIT(PPC_RAW_NOP());
 			/* Adjust for two bpf instructions */
 			addrs[++i] = ctx->idx * 4;
 			break;
-- 
2.38.1

