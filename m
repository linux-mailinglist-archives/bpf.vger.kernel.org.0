Return-Path: <bpf+bounces-62642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2710AFC3D8
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6B7A359C
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540AB29824E;
	Tue,  8 Jul 2025 07:19:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83362236FF
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959149; cv=none; b=PWma8vCblyO2w1jqwJH+R9vw2KcoWKu2/zMgIepMHtsGkOKyXmmwBGBotnn9eKDMXHcPwYReQgyPUr0HLN6TMIYdTtF5P6l8zQ3U3eZHRIvJUQuPX3BlJCF5HuO3KPom2EY3ISIKrbV8PTTNh5wR3+b0wmKLJDbl4R7b9EAXNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959149; c=relaxed/simple;
	bh=1fogLxGnYTWy1MX44JdrHuDQqNNPGSk0SdHEiSS8m0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWHdxOa022N8O+Xh23X2y7dq5enaU6kvAPdhb7jkq+O8vAvWNABAgaIqb/Pl96kS13KIAA2uCKkx/37muk9tTyqOA9GXYVy5Jkay8XD81EKqMOpmTk/Q3hR5YyqhFNx67SOpbGZ0PXkU+9lTfnyZMsPFtYO7hn9p/nHWm8DdxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d11fd4585bcb11f0b29709d653e92f7d-20250708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:904e6c6a-4b4b-471e-95f8-453c448955c5,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:904e6c6a-4b4b-471e-95f8-453c448955c5,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f4701ff831626eedbab9373fb1fa2546,BulkI
	D:2507081519023TLD5WU0,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d11fd4585bcb11f0b29709d653e92f7d-20250708
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 183489347; Tue, 08 Jul 2025 15:18:59 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Subject: [PATCH v2 1/2] LoongArch: BPF: Optimize the calculation method of jmp_offset in the emit_bpf_tail_call function
Date: Tue,  8 Jul 2025 15:18:39 +0800
Message-Id: <20250708071840.556686-2-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250708071840.556686-1-jianghaoran@kylinos.cn>
References: <20250708071840.556686-1-jianghaoran@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra pass of bpf_int_jit_compile() skips JIT context initialization
which essentially skips offset calculation leaving out_offset = -1,
the jmp_offset in emit_bpf_tail_call is calculated
by #define jmp_offset (out_offset - (cur_offset)) is a negative number,
which does not meet expectations.The final generated assembly as follow.

54:	bgeu        	$a2, $t1, -8	    # 0x0000004c
58:	addi.d      	$a6, $s5, -1
5c:	bltz        	$a6, -16	    # 0x0000004c
60:	alsl.d      	$t2, $a2, $a1, 0x3
64:	ld.d        	$t2, $t2, 264
68:	beq         	$t2, $zero, -28	    # 0x0000004c

Before apply this patch, the follow test case will reveal soft lock issues.

cd tools/testing/selftests/bpf/
./test_progs --allow=tailcalls/tailcall_bpf2bpf_1

dmesg:
watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_progs:25056]

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fa1500d4aa3e..5061bfc978f2 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -208,9 +208,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 	return true;
 }
 
-/* initialized on the first pass of build_body() */
-static int out_offset = -1;
-static int emit_bpf_tail_call(struct jit_ctx *ctx)
+static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off;
 	u8 tcc = tail_call_reg(ctx);
@@ -220,9 +218,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	u8 t2 = LOONGARCH_GPR_T2;
 	u8 t3 = LOONGARCH_GPR_T3;
 	const int idx0 = ctx->idx;
+	int tc_ninsn = 0;
 
 #define cur_offset (ctx->idx - idx0)
-#define jmp_offset (out_offset - (cur_offset))
+#define jmp_offset (tc_ninsn - (cur_offset))
 
 	/*
 	 * a0: &ctx
@@ -232,6 +231,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if (index >= array->map.max_entries)
 	 *	 goto out;
 	 */
+	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] :
+		ctx->offset[0];
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */
@@ -263,15 +264,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit_insn(ctx, ldd, t3, t2, off);
 	__build_epilogue(ctx, true);
 
-	/* out: */
-	if (out_offset == -1)
-		out_offset = cur_offset;
-	if (cur_offset != out_offset) {
-		pr_err_once("tail_call out_offset = %d, expected %d!\n",
-			    cur_offset, out_offset);
-		return -1;
-	}
-
 	return 0;
 
 toofar:
@@ -916,7 +908,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
 		mark_tail_call(ctx);
-		if (emit_bpf_tail_call(ctx) < 0)
+		if (emit_bpf_tail_call(ctx, i) < 0)
 			return -EINVAL;
 		break;
 
@@ -1342,7 +1334,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (tmp_blinded)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ? tmp : orig_prog);
 
-	out_offset = -1;
 
 	return prog;
 
-- 
2.43.0


