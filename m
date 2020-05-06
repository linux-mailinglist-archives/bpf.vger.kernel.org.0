Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6425D1C64D0
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 02:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgEFADp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbgEFADe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 20:03:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E478C0610D5
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 17:03:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so10831pjw.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tu4wfIJHIQQHHdr2oULlj2uQlQex1349SVlpEUwQDaA=;
        b=YYYhuVfwies2v08OAprLyffNxDwOzCKJiip46cwKDTes0snI5kI1fVXAt1v/DbyQbq
         qqyIuITgLNQFp7znZJSNTLBz31BDZ2NDzwY487Q4RBlX5Avypqf06V/om1/Cwl6WM9/f
         RqZY+PdRhztp2kb1+kPiL5NQXx0HtDwlCc7LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tu4wfIJHIQQHHdr2oULlj2uQlQex1349SVlpEUwQDaA=;
        b=LTPckm6Imxme1sR2UmHBfvVITNT+jziAeqOaIwGnFP6MlbSn1HKygbSDPP4+d3uJfz
         //bsTDFHia3hsfiVYP7EoPXKCJw34zgEaPk3gvGw5Org9g6tMHban/6muh4ZWlzF7N1/
         wEwRR6g5MOLfk72jYkm/bI1psG9ee6kvKN73u4e42UCVv5w8PFxgJPmCFqPpgWzoX8sl
         mXCEr4R0YFCSNgagN5lXU4J7lz3xAKBmAtuHKri6YrGhqggh7MODq4e0YjBQ5LJ2+E3o
         Hwx8R8FbkVsIDqCmoVl/PrX6ohZxDawb+bxqvuKm+EXBdgw4PDf3s+88DQIjEr6TTq6h
         ltgg==
X-Gm-Message-State: AGi0PuZYKbPkYkZOr9VDXREh5zyNoDcBZAoJFLg2ydoJlxmrxvaiUuRD
        wrBm/yQghE7LgCTQFzKNKi5DMf+c3i0V+g==
X-Google-Smtp-Source: APiQypIwBdTOVciQ6JxnzjjE9tj9R8b2rWOeA29u6dvkgY6D7Tjhk6Ie+E/Rg01PCw6tols8N/uxIA==
X-Received: by 2002:a17:902:b711:: with SMTP id d17mr5341360pls.333.1588723412695;
        Tue, 05 May 2020 17:03:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id u3sm133912pfn.217.2020.05.05.17.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:03:32 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] bpf, riscv: Optimize FROM_LE using verifier_zext on RV64
Date:   Tue,  5 May 2020 17:03:18 -0700
Message-Id: <20200506000320.28965-3-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506000320.28965-1-luke.r.nels@gmail.com>
References: <20200506000320.28965-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds two optimizations for BPF_ALU BPF_END BPF_FROM_LE in
the RV64 BPF JIT.

First, it enables the verifier zero-extension optimization to avoid zero
extension when imm == 32. Second, it avoids generating code for imm ==
64, since it is equivalent to a no-op.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e2636902a74e..c3ce9a911b66 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -542,13 +542,21 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	/* dst = BSWAP##imm(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
-	{
-		int shift = 64 - imm;
-
-		emit(rv_slli(rd, rd, shift), ctx);
-		emit(rv_srli(rd, rd, shift), ctx);
+		switch (imm) {
+		case 16:
+			emit(rv_slli(rd, rd, 48), ctx);
+			emit(rv_srli(rd, rd, 48), ctx);
+			break;
+		case 32:
+			if (!aux->verifier_zext)
+				emit_zext_32(rd, ctx);
+			break;
+		case 64:
+			/* Do nothing */
+			break;
+		}
 		break;
-	}
+
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
 		emit(rv_addi(RV_REG_T2, RV_REG_ZERO, 0), ctx);
 
-- 
2.17.1

