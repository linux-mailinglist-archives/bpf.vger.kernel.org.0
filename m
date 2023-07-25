Return-Path: <bpf+bounces-5801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9F760B21
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4361C203AE
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470D8F68;
	Tue, 25 Jul 2023 07:05:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A68F5E
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:05:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41D2E0;
	Tue, 25 Jul 2023 00:05:35 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxIvA9dL9kcZwJAA--.23155S3;
	Tue, 25 Jul 2023 15:05:33 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCM8dL9kxkc6AA--.7400S2;
	Tue, 25 Jul 2023 15:05:32 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
	stable@vger.kernel.org, #@web.codeaurora.org, 6.1@web.codeaurora.org
Subject: [PATCH bpf-next] LoongArch: BPF: Fix check condition to call lu32id in move_imm()
Date: Tue, 25 Jul 2023 15:05:08 +0800
Message-Id: <1690268708-5899-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID:AQAAf8BxHCM8dL9kxkc6AA--.7400S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF15Cr4DKF1xuF47Xw15Jrc_yoW8Gr1xp3
	97urn7JrZrWrnrZ3WDGay3WF47JrZ7Ww40ga1qk34rCFsxWr1DXr1F93yDA3Wkta1YyayS
	qrWqkwnIgFWkAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j3jj
	DUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

As the code comment says, the initial aim is to reduce one instruction
in some corner cases, if bit[51:31] is all 0 or all 1, no need to call
lu32id, that is to say, it should call lu32id only if bit[51:31] is not
all 0 and not all 1. The current code always call lu32id, the result is
right but the logic is unexpected and wrong, fix it.

Cc: stable@vger.kernel.org # 6.1
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Reported-by: Colin King (gmail) <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/bcf97046-e336-712a-ac68-7fd194f2953e@gmail.com/
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index c335dc4..6858633 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -150,7 +150,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, long imm
 			 * no need to call lu32id to do a new filled operation.
 			 */
 			imm_51_31 = (imm >> 31) & 0x1fffff;
-			if (imm_51_31 != 0 || imm_51_31 != 0x1fffff) {
+			if (imm_51_31 != 0 && imm_51_31 != 0x1fffff) {
 				/* lu32id rd, imm_51_32 */
 				imm_51_32 = (imm >> 32) & 0xfffff;
 				emit_insn(ctx, lu32id, rd, imm_51_32);
-- 
2.1.0


