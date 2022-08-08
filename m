Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5491B58C23F
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 05:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiHHD6n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Aug 2022 23:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiHHD6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 23:58:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA7610FC9;
        Sun,  7 Aug 2022 20:58:40 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M1Mmd5CM1zjX6Y;
        Mon,  8 Aug 2022 11:55:29 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 8 Aug
 2022 11:58:38 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf] bpf, arm64: Fix bpf trampoline instruction endianness
Date:   Mon, 8 Aug 2022 00:07:35 -0400
Message-ID: <20220808040735.1232002-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sparse tool complains as follows:

arch/arm64/net/bpf_jit_comp.c:1684:16:
	warning: incorrect type in assignment (different base types)
arch/arm64/net/bpf_jit_comp.c:1684:16:
	expected unsigned int [usertype] *branch
arch/arm64/net/bpf_jit_comp.c:1684:16:
	got restricted __le32 [usertype] *
arch/arm64/net/bpf_jit_comp.c:1700:52:
	error: subtraction of different types can't work (different base
	types)
arch/arm64/net/bpf_jit_comp.c:1734:29:
	warning: incorrect type in assignment (different base types)
arch/arm64/net/bpf_jit_comp.c:1734:29:
	expected unsigned int [usertype] *
arch/arm64/net/bpf_jit_comp.c:1734:29:
	got restricted __le32 [usertype] *
arch/arm64/net/bpf_jit_comp.c:1918:52:
	error: subtraction of different types can't work (different base
	types)

This is because the variable branch in function invoke_bpf_prog and the
variable branches in function prepare_trampoline are defined as type
u32 *, which conflicts with ctx->image's type __le32 *, so sparse complains
when assignment or arithmetic operation are performed on these two
variables and ctx->image.

Since arm64 instructions are always little-endian, change the type of
these two variables to __le32 * and call cpu_to_le32 to convert
instruction to little-endian before writing it to memory.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7ca8779ae34f..29dc55da2476 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1643,7 +1643,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 			    int args_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
-	u32 *branch;
+	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
 	struct bpf_prog *p = l->link.prog;
@@ -1698,7 +1698,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 
 	if (ctx->image) {
 		int offset = &ctx->image[ctx->idx] - branch;
-		*branch = A64_CBZ(1, A64_R(0), offset);
+		*branch = cpu_to_le32(A64_CBZ(1, A64_R(0), offset));
 	}
 
 	/* arg1: prog */
@@ -1713,7 +1713,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 
 static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 			       int args_off, int retval_off, int run_ctx_off,
-			       u32 **branches)
+			       __le32 **branches)
 {
 	int i;
 
@@ -1784,7 +1784,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	bool save_ret;
-	u32 **branches = NULL;
+	__le32 **branches = NULL;
 
 	/* trampoline stack layout:
 	 *                  [ parent ip         ]
@@ -1892,7 +1892,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 
 	if (fmod_ret->nr_links) {
-		branches = kcalloc(fmod_ret->nr_links, sizeof(u32 *),
+		branches = kcalloc(fmod_ret->nr_links, sizeof(__le32 *),
 				   GFP_KERNEL);
 		if (!branches)
 			return -ENOMEM;
@@ -1916,7 +1916,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
 	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
 		int offset = &ctx->image[ctx->idx] - branches[i];
-		*branches[i] = A64_CBNZ(1, A64_R(10), offset);
+		*branches[i] = cpu_to_le32(A64_CBNZ(1, A64_R(10), offset));
 	}
 
 	for (i = 0; i < fexit->nr_links; i++)
-- 
2.30.2

