Return-Path: <bpf+bounces-30576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFB8CEDC7
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 05:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F981F2197E
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 03:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28762F2F;
	Sat, 25 May 2024 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="owQSQSqF"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0C138E
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716609398; cv=none; b=mYFPxWTg879c6FME9D7n7aHQ3WSO+ajN+UmVcmh8y2xuPKgvOHmBYv+PGpFVfISmg4Y8pek8wn4lCm8XKv4IR+B6Sqtjsl5S8sc2DiH8NWewiWgpr+SviYxgtPqfHirElceVVutQ/Hhi5rdkHgmHMxjEJB5rMiXOo0gWQlsxWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716609398; c=relaxed/simple;
	bh=VTq+Xedy9UIJWuKp7p2kMUev4eiuFF7NTxn6pDn5J5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQXS1OfVHu3rznjYFGHpwkeqMA93zT3sAHdeoTa30s8cqU+kYBdxtcwAjoHiARYL2RQf5uZhZ8ZKWna3WGIX011xNvD2qR6CguQ2DVV8VaDcMrj5uAkdmJgvsQkiYoZfpHZ/m65yXnWpRqf7PmGw1etbq8UfI0sApz0UKILy4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=owQSQSqF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1716609391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ESjsEOrjOSUIfpoJSGAmqJmoqMNxjpwHbfQn63f4et0=;
	b=owQSQSqFjjRZyiqkZ1lWmrHkb+jDpAVPpTMBtoA0eogMnMYaTrerBBvWNg9E5wlJ7U038L
	TKTUXEyk0C7Xltx6Ohr0kRPxexeYtxSgp4uy4A2ZrLoD2rsVolmmhHBWXCmbwoJmsYWNkB
	v++GPO6jxBRhG5io7GQ12w1tAUVkWkb2BEJQFhz/eVwBNkxVuvWjCBod4/JZ8FOhxI/Oin
	bCDrcEdyopMhHrTnSPN5Wd/ElyKqmFkAEKzuqzT+d6wA6PfLpcTM/TEt2etaW3vFEQS3vN
	s/RppA0LsAxAZ+3rVvnLqdfv9lgvxBFKeh1EvAWo+Az16ZSygoSme2WD8A1Omg==
X-Envelope-To: list+bpf@vahedi.org
X-Envelope-To: shahab@synopsys.com
X-Envelope-To: vgupta@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: linux-snps-arc@lists.infradead.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shahab Vahedi <list+bpf@vahedi.org>
To: bpf@vger.kernel.org
Cc: Shahab Vahedi <list+bpf@vahedi.org>,
	Shahab Vahedi <shahab@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH bpf-next] ARC, bpf: Fix issues reported by the static analyzers
Date: Sat, 25 May 2024 05:56:28 +0200
Message-Id: <20240525035628.1026-1-list+bpf@vahedi.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Shahab Vahedi <shahab@synopsys.com>

Also updated couple of comments along the way.

One of the issues reported was indeed a bug in the code:

  memset(ctx, 0, sizeof(ctx))      // original line
  memset(ctx, 0, sizeof(*ctx))     // fixed line

That was a nice catch.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405222314.UG5F2NHn-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202405232036.Xqoc3b0J-lkp@intel.com/
Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
---
 arch/arc/net/bpf_jit.h       |  2 +-
 arch/arc/net/bpf_jit_arcv2.c | 10 ++++++----
 arch/arc/net/bpf_jit_core.c  | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arc/net/bpf_jit.h b/arch/arc/net/bpf_jit.h
index 34dfcac531d5..d688bb422fd5 100644
--- a/arch/arc/net/bpf_jit.h
+++ b/arch/arc/net/bpf_jit.h
@@ -39,7 +39,7 @@
 
 /************** Functions that the back-end must provide **************/
 /* Extension for 32-bit operations. */
-inline u8 zext(u8 *buf, u8 rd);
+u8 zext(u8 *buf, u8 rd);
 /***** Moves *****/
 u8 mov_r32(u8 *buf, u8 rd, u8 rs, u8 sign_ext);
 u8 mov_r32_i32(u8 *buf, u8 reg, s32 imm);
diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
index 31bfb6e9ce00..4458e409ca0a 100644
--- a/arch/arc/net/bpf_jit_arcv2.c
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -62,7 +62,7 @@ enum {
  *   If/when we decide to add ARCv2 instructions that do use register pairs,
  *   the mapping, hopefully, doesn't need to be revisited.
  */
-const u8 bpf2arc[][2] = {
+static const u8 bpf2arc[][2] = {
 	/* Return value from in-kernel function, and exit value from eBPF */
 	[BPF_REG_0] = {ARC_R_8, ARC_R_9},
 	/* Arguments from eBPF program to in-kernel function */
@@ -1302,7 +1302,7 @@ static u8 arc_b(u8 *buf, s32 offset)
 
 /************* Packers (Deal with BPF_REGs) **************/
 
-inline u8 zext(u8 *buf, u8 rd)
+u8 zext(u8 *buf, u8 rd)
 {
 	if (rd != BPF_REG_FP)
 		return arc_movi_r(buf, REG_HI(rd), 0);
@@ -2235,6 +2235,7 @@ u8 gen_swap(u8 *buf, u8 rd, u8 size, u8 endian, bool force, bool do_zext)
 			break;
 		default:
 			/* The caller must have handled this. */
+			break;
 		}
 	} else {
 		/*
@@ -2253,6 +2254,7 @@ u8 gen_swap(u8 *buf, u8 rd, u8 size, u8 endian, bool force, bool do_zext)
 			break;
 		default:
 			/* The caller must have handled this. */
+			break;
 		}
 	}
 
@@ -2517,7 +2519,7 @@ u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size)
 #define JCC64_NR_OF_JMPS 3	/* Number of jumps in jcc64 template. */
 #define JCC64_INSNS_TO_END 3	/* Number of insn. inclusive the 2nd jmp to end. */
 #define JCC64_SKIP_JMP 1	/* Index of the "skip" jump to "end". */
-const struct {
+static const struct {
 	/*
 	 * "jit_off" is common between all "jmp[]" and is coupled with
 	 * "cond" of each "jmp[]" instance. e.g.:
@@ -2883,7 +2885,7 @@ u8 gen_jmp_64(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
  * The "ARC_CC_SET" becomes "CC_unequal" because of the "tst"
  * instruction that precedes the conditional branch.
  */
-const u8 arcv2_32_jmps[ARC_CC_LAST] = {
+static const u8 arcv2_32_jmps[ARC_CC_LAST] = {
 	[ARC_CC_UGT] = CC_great_u,
 	[ARC_CC_UGE] = CC_great_eq_u,
 	[ARC_CC_ULT] = CC_less_u,
diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 6f6b4ffccf2c..e3628922c24a 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -159,7 +159,7 @@ static void jit_dump(const struct jit_context *ctx)
 /* Initialise the context so there's no garbage. */
 static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
 {
-	memset(ctx, 0, sizeof(ctx));
+	memset(ctx, 0, sizeof(*ctx));
 
 	ctx->orig_prog = prog;
 
@@ -167,7 +167,7 @@ static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
 	ctx->prog = bpf_jit_blind_constants(prog);
 	if (IS_ERR(ctx->prog))
 		return PTR_ERR(ctx->prog);
-	ctx->blinded = (ctx->prog == ctx->orig_prog ? false : true);
+	ctx->blinded = (ctx->prog != ctx->orig_prog);
 
 	/* If the verifier doesn't zero-extend, then we have to do it. */
 	ctx->do_zext = !ctx->prog->aux->verifier_zext;
@@ -1182,12 +1182,12 @@ static int jit_prepare(struct jit_context *ctx)
 }
 
 /*
- * All the "handle_*()" functions have been called before by the
- * "jit_prepare()". If there was an error, we would know by now.
- * Therefore, no extra error checking at this point, other than
- * a sanity check at the end that expects the calculated length
- * (jit.len) to be equal to the length of generated instructions
- * (jit.index).
+ * jit_compile() is the real compilation phase. jit_prepare() is
+ * invoked before jit_compile() as a dry-run to make sure everything
+ * will go OK and allocate the necessary memory.
+ *
+ * In the end, jit_compile() checks if it has produced the same number
+ * of instructions as jit_prepare() would.
  */
 static int jit_compile(struct jit_context *ctx)
 {
@@ -1407,9 +1407,9 @@ static struct bpf_prog *do_extra_pass(struct bpf_prog *prog)
 
 /*
  * This function may be invoked twice for the same stream of BPF
- * instructions. The "extra pass" happens, when there are "call"s
- * involved that their addresses are not known during the first
- * invocation.
+ * instructions. The "extra pass" happens, when there are
+ * (re)locations involved that their addresses are not known
+ * during the first run.
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
-- 
2.39.4


