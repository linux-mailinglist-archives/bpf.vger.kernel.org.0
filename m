Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6649C98E
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 13:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiAZMXo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 07:23:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30307 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiAZMXo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 07:23:44 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JkNCc39MGzbkFg;
        Wed, 26 Jan 2022 20:22:52 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 20:23:42 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <houtao1@huawei.com>
Subject: [PATCH bpf-next v2 2/2] bpf, arm64: calculate offset as byte-offset for bpf line info
Date:   Tue, 25 Jan 2022 18:57:07 +0800
Message-ID: <20220125105707.292449-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125105707.292449-1-houtao1@huawei.com>
References: <20220125105707.292449-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is calculated
in instruction granularity instead of bytes granularity, but bpf
line info requires byte offset, so fixing it by calculating offset
as byte-offset.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 6a83f3070985..7b94e0c5e134 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -152,10 +152,12 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 	bpf_insn++;
 	/*
 	 * Whereas arm64 branch instructions encode the offset
-	 * from the branch itself, so we must subtract 1 from the
+	 * from the branch itself, so we must subtract 4 from the
 	 * instruction offset.
 	 */
-	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
+	return (ctx->offset[bpf_insn + off] -
+		(ctx->offset[bpf_insn] - AARCH64_INSN_SIZE)) /
+		AARCH64_INSN_SIZE;
 }
 
 static void jit_fill_hole(void *area, unsigned int size)
@@ -946,13 +948,14 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 		const struct bpf_insn *insn = &prog->insnsi[i];
 		int ret;
 
+		/* BPF line info needs byte-offset instead of insn-offset */
 		if (ctx->image == NULL)
-			ctx->offset[i] = ctx->idx;
+			ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
 		ret = build_insn(insn, ctx, extra_pass);
 		if (ret > 0) {
 			i++;
 			if (ctx->image == NULL)
-				ctx->offset[i] = ctx->idx;
+				ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
 			continue;
 		}
 		if (ret)
@@ -964,7 +967,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 	 * instruction (end of program)
 	 */
 	if (ctx->image == NULL)
-		ctx->offset[i] = ctx->idx;
+		ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
 
 	return 0;
 }
-- 
2.27.0

