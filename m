Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DEC63EAB1
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 08:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiLAH65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 02:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLAH6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 02:58:15 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290ADBE2F;
        Wed, 30 Nov 2022 23:57:40 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4NN7hM5MFCz9sZb;
        Thu,  1 Dec 2022 08:57:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fi5NXFaCiC1k; Thu,  1 Dec 2022 08:57:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4NN7hD4Pqzz9sZm;
        Thu,  1 Dec 2022 08:57:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82C578B781;
        Thu,  1 Dec 2022 08:57:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7OCGxiDEj4Hh; Thu,  1 Dec 2022 08:57:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBCE08B783;
        Thu,  1 Dec 2022 08:56:59 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2B17uvHa130872
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 08:56:57 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2B17uvZZ130871;
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
Subject: [PATCH v1 10/10] powerpc/bpf/32: perform three operands ALU operations
Date:   Thu,  1 Dec 2022 08:56:35 +0100
Message-Id: <f3a39308117cddfb98103ccde9acf772e9f2ed36.1669881248.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
References: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669881391; l=2064; s=20211009; h=from:subject:message-id; bh=x9e4wsb7bwKsXC6S+KcXmVuzQBBX7AhIURwS3dX/rR4=; b=XsN+vrNJB5stqWsxL7BjReZg+9Ci3BiT40M67fhpNUf77tkXWOUxpOfPm8CKFXMi9eyiYb3IVTok HDoMyJP3CSO/U9BCU4ujNUEnj3SkVPGu4o3qJAHEzf2u9z5CzwmD
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
index c45db3d280b2..4b8d3634dc04 100644
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
2.38.1

