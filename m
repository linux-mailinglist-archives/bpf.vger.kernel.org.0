Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA46686351
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjBAKFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 05:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjBAKFB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:05:01 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC05EFAC;
        Wed,  1 Feb 2023 02:04:59 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4P6HbB0YsGz9sgS;
        Wed,  1 Feb 2023 11:04:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nhmy8sRbA5dQ; Wed,  1 Feb 2023 11:04:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4P6Hb75NLSz9sgT;
        Wed,  1 Feb 2023 11:04:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FE8F8B779;
        Wed,  1 Feb 2023 11:04:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XX_GferYAqBP; Wed,  1 Feb 2023 11:04:51 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 72DD18B776;
        Wed,  1 Feb 2023 11:04:51 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 311A4kTS3908568
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 11:04:46 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 311A4kNN3908567;
        Wed, 1 Feb 2023 11:04:46 +0100
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
Subject: [PATCH v2 2/9] powerpc/bpf/32: No need to zeroise r4 when not doing tail call
Date:   Wed,  1 Feb 2023 11:04:24 +0100
Message-Id: <9c5440b2b6d90a78600257433ac499b5c5101fbb.1675245773.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
References: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675245868; l=924; s=20211009; h=from:subject:message-id; bh=F4gLR/oDVGhGLrWr7vT88ocK2LRqvsA/yloytjSuBcQ=; b=mqWIs23+ixQrWni55jfuJFKN/A48mwqQ3DQxGUtcbO7HPjq2dY/+laQKhUIjhtzB9AnUpRs007NI ojhPAxYPBBhBk88PcUsZ/3UFTQc4tiIdz53/yIvm5B7mLEoHuSTr
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

r4 is cleared at function entry and used as tail call count.

But when the function does not perform tail call, r4 is
ignored, so no need to clear it.

Replace it by a NOP in that case.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit_comp32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index a379b0ce19ff..4e6caee9c98a 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -114,7 +114,10 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 	int i;
 
 	/* Initialize tail_call_cnt, to be skipped if we do tail calls. */
-	EMIT(PPC_RAW_LI(_R4, 0));
+	if (ctx->seen & SEEN_TAILCALL)
+		EMIT(PPC_RAW_LI(_R4, 0));
+	else
+		EMIT(PPC_RAW_NOP());
 
 #define BPF_TAILCALL_PROLOGUE_SIZE	4
 
-- 
2.39.1

