Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79C14ACE17
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 02:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiBHBr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 20:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiBHBZx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 20:25:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351FC06109E
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 17:25:50 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jt4xp24h2zdZTS;
        Tue,  8 Feb 2022 09:22:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 09:25:46 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <houtao1@huawei.com>
Subject: [PATCH bpf-next v3 2/2] bpf, arm64: calculate offset as byte-offset for bpf line info
Date:   Tue, 8 Feb 2022 09:25:39 +0800
Message-ID: <20220208012539.491753-3-houtao1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220208012539.491753-1-houtao1@huawei.com>
References: <20220208012539.491753-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is calculated
in instruction granularity instead of bytes granularity, but bpf
line info requires byte offset, so fixing it by calculating ctx->offset
as byte-offset. bpf2a64_offset() needs to return relative instruction
offset by using ctx->offfset, so update it accordingly.

Fixes: 37ab566c178d ("bpf: arm64: Enable arm64 jit to provide bpf_line_info")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 68b35c83e637..aed07cba78ec 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -164,9 +164,14 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 	/*
 	 * Whereas arm64 branch instructions encode the offset
 	 * from the branch itself, so we must subtract 1 from the
-	 * instruction offset.
+	 * instruction offset. The unit of ctx->offset is byte, so
+	 * subtract AARCH64_INSN_SIZE from it. bpf2a64_offset()
+	 * returns instruction offset, so divide by AARCH64_INSN_SIZE
+	 * at the end.
 	 */
-	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
+	return (ctx->offset[bpf_insn + off] -
+		(ctx->offset[bpf_insn] - AARCH64_INSN_SIZE)) /
+		AARCH64_INSN_SIZE;
 }
 
 static void jit_fill_hole(void *area, unsigned int size)
@@ -1087,13 +1092,14 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
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
@@ -1105,7 +1111,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
 	 * instruction (end of program)
 	 */
 	if (ctx->image == NULL)
-		ctx->offset[i] = ctx->idx;
+		ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
 
 	return 0;
 }
-- 
2.27.0

