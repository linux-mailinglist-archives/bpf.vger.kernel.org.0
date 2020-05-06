Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09461C64D1
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 02:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgEFADp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgEFADe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 20:03:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0970C03C1A6
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 17:03:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so1539311plp.9
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 17:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lz68WQXWqBJ9Ra70jP1k6TPdklvjro5he/Cgs5XKfJQ=;
        b=I6cMHC4+vQAr4egLJrgK3OkC44xCth/N7aOfzAvQ88GNlC28skwjZIiOcQKwNKba/m
         FVZ8YHUtKiebf9iWuSRXzYTau4g4wEt2ut7eFApIaIPTmqwz9OgkAAmccDhLYdh7GSgL
         udtSxu3Cbv9CJiLBN6cTo0VwR1ottraN5dnR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lz68WQXWqBJ9Ra70jP1k6TPdklvjro5he/Cgs5XKfJQ=;
        b=t9hToMxkCo3bndmqqQ7WhIDIQ/rjr3+ea0i0ByTTjxc1p+NMW5pRxY0hXulS4kRfR+
         mQEIC2N2hI6c17AEjeZwp1PefHUD2PZOWpkLv//pQPAkuFyw+A96OoyQ8phvaraqW+YE
         XiHH+kyzD3Jv4/h65rQgwhppjKurGJCrjWHaSEL63lT2p6MYJWCFpP/SA/2BNplOduuU
         VBresx9DBU/Rc/CWku8di0T/vVzo7jgNK9TqpaZOi1jotzX1yS6VQoxvSKQ/OjgeAtEa
         4Wspk1QVeUiDSnBmdmtmKcbjBKGgHVbz2FEV695/Jhs7GxnoZuQZMxZsf08OdJkGxKax
         N9aA==
X-Gm-Message-State: AGi0PuZaEuV3GAuDVvyH0SSkehUDO1ROkLTCV17HalFNEe3A+XW/Il4c
        umotpfh121dpWGdazyilMnHLCzRqBypJ0Q==
X-Google-Smtp-Source: APiQypLac7W0AQ0zsoyEUeh+HLIH71Pw99XQTxx+zpjnRrIO/fJRi7MugYIYZ/bW+GZIBXfAD086Qw==
X-Received: by 2002:a17:902:854c:: with SMTP id d12mr3949168plo.131.1588723413811;
        Tue, 05 May 2020 17:03:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id u3sm133912pfn.217.2020.05.05.17.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:03:33 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf, riscv: Optimize BPF_JMP BPF_K when imm == 0 on RV64
Date:   Tue,  5 May 2020 17:03:19 -0700
Message-Id: <20200506000320.28965-4-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506000320.28965-1-luke.r.nels@gmail.com>
References: <20200506000320.28965-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds an optimization to BPF_JMP (32- and 64-bit) BPF_K for
when the BPF immediate is zero.

When the immediate is zero, the code can directly use the RISC-V zero
register instead of loading a zero immediate to a temporary register
first.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c3ce9a911b66..b07cef952019 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -796,7 +796,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_JMP32 | BPF_JSET | BPF_K:
 		rvoff = rv_offset(i, off, ctx);
 		s = ctx->ninsns;
-		emit_imm(RV_REG_T1, imm, ctx);
+		if (imm) {
+			emit_imm(RV_REG_T1, imm, ctx);
+			rs = RV_REG_T1;
+		} else {
+			/* If imm is 0, simply use zero register. */
+			rs = RV_REG_ZERO;
+		}
 		if (!is64) {
 			if (is_signed_bpf_cond(BPF_OP(code)))
 				emit_sext_32_rd(&rd, ctx);
@@ -811,11 +817,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		if (BPF_OP(code) == BPF_JSET) {
 			/* Adjust for and */
 			rvoff -= 4;
-			emit(rv_and(RV_REG_T1, rd, RV_REG_T1), ctx);
-			emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff,
-				    ctx);
+			emit(rv_and(rs, rd, rs), ctx);
+			emit_branch(BPF_JNE, rs, RV_REG_ZERO, rvoff, ctx);
 		} else {
-			emit_branch(BPF_OP(code), rd, RV_REG_T1, rvoff, ctx);
+			emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
 		}
 		break;
 
-- 
2.17.1

