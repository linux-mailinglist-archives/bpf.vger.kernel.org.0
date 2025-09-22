Return-Path: <bpf+bounces-69174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CDB8F1F2
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87A874E1AFC
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160262EFD9E;
	Mon, 22 Sep 2025 06:23:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1D257827;
	Mon, 22 Sep 2025 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522182; cv=none; b=EHvGQRNSofKtN3UD5lrlNMUdGHhZuF6j0u/eMIZmBVs8/KkMyNp+COfGQVEs+UsMOtx//1tEZLTq86h92Ha30RDJEaXCSNp8glnygwe+BLB8xzSScS2iynexRcb3hWcPgohkZEFsILxNTv1qCKTxZ770G3zQHg9iC7DpndFZppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522182; c=relaxed/simple;
	bh=is8yakVFJ92Y77+pJ24vkJB51vTMkdKk2Ii8jnnEXLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3P76seo33FX+phbXqNgn5UlwFbn/Z2s4srtzCf9XquhGKQLKzU5CA9noqpeu/RvKCJJgH/1qVnAvgiYHipO16F2NutL1N6qhSnRm/mHS8Vqm053Nui8KUf6NMz3+PWQSSnXyYPmGNvK61FO+/l3639EbPK+ztLBpNYZMznl5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 916b7686977c11f0b29709d653e92f7d-20250922
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0dfb604e-c375-4e14-8edb-4e1323093f64,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:0dfb604e-c375-4e14-8edb-4e1323093f64,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:aab4714ecc1f80bb4f209f82ea7ba360,BulkI
	D:250922142250KV4QC9ZA,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|81
	|82|102|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 916b7686977c11f0b29709d653e92f7d-20250922
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1612824356; Mon, 22 Sep 2025 14:22:51 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	duanchenghao@kylinos.cn
Subject: [PATCH v2 1/1] riscv: bpf: Fix uninitialized symbol 'retval_off'
Date: Mon, 22 Sep 2025 14:22:44 +0800
Message-Id: <20250922062244.822937-2-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250922062244.822937-1-duanchenghao@kylinos.cn>
References: <20250922062244.822937-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the __arch_prepare_bpf_trampoline() function, retval_off is only
meaningful when save_ret is true, so the current logic is correct.
However, in the original logic, retval_off is only initialized under
certain conditions; for example, in the fmod_ret logic, the compiler is
not aware that the flags of the fmod_ret program (prog) have set
BPF_TRAMP_F_CALL_ORIG, which results in an uninitialized symbol
compilation warning.

So initialize retval_off unconditionally to fix it.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/riscv/net/bpf_jit_comp64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 9883a55d61b5..8475a8ab5715 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 16;
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
-	if (save_ret) {
+	if (save_ret)
 		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
-		retval_off = stack_size;
-	}
+	retval_off = stack_size;
 
 	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
-- 
2.25.1


