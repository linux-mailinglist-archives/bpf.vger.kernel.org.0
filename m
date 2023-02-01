Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECED686359
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBAKFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 05:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBAKFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:05:32 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A416186D;
        Wed,  1 Feb 2023 02:05:18 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4P6HbM1plhz9sgV;
        Wed,  1 Feb 2023 11:05:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S_-gyKi_iQBk; Wed,  1 Feb 2023 11:05:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4P6HbJ61V7z9sgb;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B41198B787;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RXOSX6CA2QxX; Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4432E8B77D;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 311A4rLh3908598
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 11:04:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 311A4r243908597;
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
Subject: [PATCH v2 9/9] powerpc/bpf/32: perform three operands ALU operations
Date:   Wed,  1 Feb 2023 11:04:31 +0100
Message-Id: <b6719beaf01f9dcbcdbb787ef67c4a2f8e3a4cb6.1675245773.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
References: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675245869; l=2064; s=20211009; h=from:subject:message-id; bh=4k+9p9BOgr5AsQmTaugfewxV5KK1NxF/SGog2G5s/xY=; b=/RfY7znmvGZdByYmvM8hJYJtEV0uJWaxtyyI1ViNdALkZ7DpkxBbL0pZn96UtYJerNX6d1CZZfZ2 loxq/B/kBk/traYsL6xqhf0sLRwVY/lqgq64rIMEpxQp0xL2/rmH
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When an ALU instruction is preceded by a MOV instruction
that just moves a source register into the destination register of
the ALU, replace that MOV+ALU instructions by an ALU operation
taking the source of the MOV as second source instead of using its
destination.

Before the change, code could look like the following, with
superfluous separate register move (mr) instructions.

  70:	7f c6 f3 78 	mr      r6,r30
  74:	7f a5 eb 78 	mr      r5,r29
  78:	30 c6 ff f4 	addic   r6,r6,-12
  7c:	7c a5 01 d4 	addme   r5,r5

With this commit, addition instructions take r30 and r29 directly.

  70:	30 de ff f4 	addic   r6,r30,-12
  74:	7c bd 01 d4 	addme   r5,r29

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit_comp32.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 5d36ff7a0a8b..7f91ea064c08 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -290,6 +290,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 
 	for (i = 0; i < flen; i++) {
 		u32 code = insn[i].code;
+		u32 prevcode = i ? insn[i - 1].code : 0;
 		u32 dst_reg = bpf_to_ppc(insn[i].dst_reg);
 		u32 dst_reg_h = dst_reg - 1;
 		u32 src_reg = bpf_to_ppc(insn[i].src_reg);
@@ -308,6 +309,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		u32 tmp_idx;
 		int j;
 
+		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
+		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
+		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
+		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1) {
+			src2_reg = bpf_to_ppc(insn[i - 1].src_reg);
+			src2_reg_h = src2_reg - 1;
+			ctx->idx = addrs[i - 1] / 4;
+		}
+
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
 		 * the start of the body code.
-- 
2.39.1

