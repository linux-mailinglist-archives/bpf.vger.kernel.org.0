Return-Path: <bpf+bounces-45146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7A9D2073
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 07:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE90DB21470
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696914AD1A;
	Tue, 19 Nov 2024 06:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4512CDAE;
	Tue, 19 Nov 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999158; cv=none; b=qwLcpHw7x8nfdY8n95VoBgpiRKVuvYWTV2XsG3IJePDZIC9jv1oR+i2Ov1Z7Z03K0yDS01GNx5kultToMrzcUgbPhncWBPn10tE72MIrr2Bg8JbzcxhJ17b+cVxTrhwAcPrAsYzGJHGH0kBxCFws7WhOX4xLarYM5Xxl/lxU5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999158; c=relaxed/simple;
	bh=X1+zdJ06C6wxtKvSwI4yFWv5SXK3REfFFRtQiBhbY44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWXg61gwnwZNzoXLNgGCagnRPkYaygIjBvloO4xrDFWxYrkkQmQMlRFXepe6NQgup2toSR2q+/Yn/8d8hWKsP6Cr03q/CVv0t6W6Mq20X2m3aj/uKr+HuUuOqrQt3xKKUhwdUvzaNrNZDz+zdkOg+YeMVG/M5JG+aH8By0fte7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxeeCyNTxncTVCAA--.64076S3;
	Tue, 19 Nov 2024 14:52:34 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxtsCwNTxnx_xcAA--.27448S2;
	Tue, 19 Nov 2024 14:52:33 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: BPF: Sign-extend return values
Date: Tue, 19 Nov 2024 14:52:30 +0800
Message-ID: <20241119065230.19157-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxtsCwNTxnx_xcAA--.27448S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4rurW7AF1UJr1fWr17urX_yoW5Xw48pr
	W3Cr98GrWqg34UZ3Wkt3yrWF15KFsxWrWfW3429ryUZ3Z0934xWr1Yg3y5tFZ8u34F9FWI
	vr98C3yY9a1kA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1LvtUUUUU=

(1) Description of Problem:

When testing BPF JIT with the latest compiler toolchains on LoongArch,
there exist some strange failed test cases, dmesg shows something like
this:

  # dmesg -t | grep FAIL | head -1
  ... ret -3 != -3 (0xfffffffd != 0xfffffffd)FAIL ...

(2) Steps to Reproduce:

  # echo 1 > /proc/sys/net/core/bpf_jit_enable
  # modprobe test_bpf

(3) Additional Info:

There are no failed test cases compiled with the lower version of GCC
such as 13.3.0, while the problems only appear with higher version of
GCC such as 14.2.0.

This is because the problems were hidden by the lower version of GCC
due to there are redundant sign extension instructions generated by
compiler, but with optimization of higher version of GCC, the sign
extension instructions have been removed.

(4) Root Cause Analysis:

The LoongArch architecture does not expose sub-registers, and hold all
32-bit values in a sign-extended format. While BPF, on the other hand,
exposes sub-registers, and use zero-extension (similar to arm64/x86).

This has led to some subtle bugs, where a BPF JITted program has not
sign-extended the a0 register (return value in LoongArch land), passed
the return value up the kernel, for example:

  | int from_bpf(void);
  |
  | long foo(void)
  | {
  |    return from_bpf();
  | }

Here, a0 would be 0xffff_ffff, instead of the expected
0xffff_ffff_ffff_ffff.

Internally, the LoongArch JIT uses a5 as a dedicated register for BPF
return values. That is to say, the LoongArch BPF uses a5 for BPF return
values, which are zero-extended, whereas the LoongArch ABI uses a0 which
is sign-extended.

(5) Final Solution:

Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
outside BPF land). Because libbpf currently defines the return value
of an ebpf program as a 32-bit unsigned integer, just use addi.w to
extend bit 31 into bits 63 through 32 of a5 to a0. This is similar
with commit 2f1b0d3d7331 ("riscv, bpf: Sign-extend return values").

Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 7dbefd4ba210..dd350cba1252 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -179,7 +179,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 
 	if (!is_tail_call) {
 		/* Set return value */
-		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
+		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
 		/* Return to the caller */
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, LOONGARCH_GPR_ZERO, 0);
 	} else {
-- 
2.42.0


