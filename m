Return-Path: <bpf+bounces-40285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E5498556B
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8D7282A95
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9C15A842;
	Wed, 25 Sep 2024 08:26:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAC7E574;
	Wed, 25 Sep 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252779; cv=none; b=k7y+8ZiVPKF+WZiH1lJ6BbFZYiEyNfQQWtOMbA23EZrzPqq8v6kf5w1L1BifMU3voZ4cCOYXVjseeFcqq9BPeh/OQejAx19/LKPAYsRhrwzMtmXfAzBdkOgvwBhicHkfi3jppsyyUU9/tGhqJGT1uDBApF1FAGBiYUoECqIWQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252779; c=relaxed/simple;
	bh=ZGixcCrfPDSlQq13Vc/iK8J9fZ1D9NrD1Mjn8nVlCz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GwSjrPX9wBkJdSWQF4hgV2/1rSRKocKCDknOKsw37lbEq9DmKpfHWV4Et3odtvaNdFyKO+BNbmMW15GtpRlydzICS4lS7D4Nc2ptHGe6oqDoFPf+OxJ96y7281M6HXJiP16D3h7Z7cOsLaNbI/HL++yWwTx4898hcnikW+CFIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn; spf=pass smtp.mailfrom=ict.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ict.ac.cn
Received: from localhost.localdomain (unknown [58.206.203.187])
	by APP-03 (Coremail) with SMTP id rQCowABnPBEgyfNmA+_lAA--.9685S2;
	Wed, 25 Sep 2024 16:26:09 +0800 (CST)
From: zyf <zhouyangfan20s@ict.ac.cn>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	zyf <zhouyangfan20s@ict.ac.cn>
Subject: [PATCH] BPF : arch/x86/net/bpf_jit_comp.c : fix wrong condition code in jit compiler
Date: Wed, 25 Sep 2024 16:23:32 +0800
Message-Id: <20240925082332.2849923-1-zhouyangfan20s@ict.ac.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnPBEgyfNmA+_lAA--.9685S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw13KrykGw48Cry8KrWfKrg_yoW3Xrg_A3
	W3Za1xXw1F9Fy5ZFn5ZF45JrsxCr4ruF43uFnYqrWYkas8XF45ZFyvyF1UKw17XFW5KrZ5
	u393tw13JwsxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: 52kr35xdqjwtjqsq2qxlfwhtffof0/

change 'case BPF_ALU64 | BPF_END | BPF_FROM_LE' to 'case BPF_ALU64 | BPF_END | BPF_FROM_BE'

Signed-off-by: zyf <zhouyangfan20s@ict.ac.cn>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..7f954d76b3a6 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1786,7 +1786,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			break;
 
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
-		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
+		case BPF_ALU64 | BPF_END | BPF_FROM_BE:
 			switch (imm32) {
 			case 16:
 				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
-- 
2.39.2


