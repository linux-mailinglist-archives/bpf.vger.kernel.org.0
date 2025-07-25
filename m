Return-Path: <bpf+bounces-64319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7ADB1153A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 02:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79234AA550A
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190C684D08;
	Fri, 25 Jul 2025 00:28:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6ED3C2F
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403335; cv=none; b=VQyJGBXw0IBC53VjgeoNl5/rUAL4FK33SPSG4NdGEmyn73QVbUGpHQZtfwXpjsKWkMRCE4sD7t/tS9jxKxcCECr7h8x/1NFfxKB9piZ/K8x5gLx0Kt3O01YLddMvGxJkTne2J+MOBnkf/oSJ54gM2OnqZmxPJtxAgHh64KQKDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403335; c=relaxed/simple;
	bh=S6zAbtSWIGr9zU+AHkVWnIE7F3XIu8Qc2NSEkRu725M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+wD3mC308/bU7LiVrEOloK1kwp2AbOdAFBG4u8gdFproiLIUW3ZDba7An4wO0idRNhpZo9rc4DwNY5qWMfJPoophiLSaeSOFhgYO6+F/b17VuST20XIRI4NcFN1Mxs7+LLwpJge3pI/Ge24j0VoJUKNJhydZGFBpSOHh8LnCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 529b592468ee11f0b29709d653e92f7d-20250725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3dc2f97d-3fad-40cd-8ebb-07de2e1d7d74,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:3dc2f97d-3fad-40cd-8ebb-07de2e1d7d74,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:88fb729e7995959cc518f2921cdfdd46,BulkI
	D:250725082847EM2E1WUI,BulkQuantity:0,Recheck:0,SF:10|24|44|66|78|81|82|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 529b592468ee11f0b29709d653e92f7d-20250725
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 479033193; Fri, 25 Jul 2025 08:28:44 +0800
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
Subject: [PATCH v3 1/2] LoongArch: BPF: Fix jump offset calculation in tailcall
Date: Fri, 25 Jul 2025 08:28:34 +0800
Message-Id: <20250725002835.64211-2-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250725002835.64211-1-jianghaoran@kylinos.cn>
References: <20250725002835.64211-1-jianghaoran@kylinos.cn>
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
which is wrong. The final generated assembly as follow.

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

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 95d5920f6073..5da41ccc6698 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -225,9 +225,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 	return true;
 }
 
-/* initialized on the first pass of build_body() */
-static int out_offset = -1;
-static int emit_bpf_tail_call(struct jit_ctx *ctx)
+static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off;
 	u8 tcc = tail_call_reg(ctx);
@@ -237,9 +235,10 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	u8 t2 = LOONGARCH_GPR_T2;
 	u8 t3 = LOONGARCH_GPR_T3;
 	const int idx0 = ctx->idx;
+	int tc_ninsn = 0;
 
 #define cur_offset (ctx->idx - idx0)
-#define jmp_offset (out_offset - (cur_offset))
+#define jmp_offset (tc_ninsn - (cur_offset))
 
 	/*
 	 * a0: &ctx
@@ -249,6 +248,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if (index >= array->map.max_entries)
 	 *	 goto out;
 	 */
+	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] :
+		ctx->offset[0];
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */
@@ -280,15 +281,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
@@ -933,7 +925,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
 		mark_tail_call(ctx);
-		if (emit_bpf_tail_call(ctx) < 0)
+		if (emit_bpf_tail_call(ctx, i) < 0)
 			return -EINVAL;
 		break;
 
@@ -1367,7 +1359,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (tmp_blinded)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ? tmp : orig_prog);
 
-	out_offset = -1;
 
 	return prog;
 
-- 
2.43.0


