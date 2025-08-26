Return-Path: <bpf+bounces-66507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96AB354BC
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 08:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938405E06A8
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84FB2F4A1D;
	Tue, 26 Aug 2025 06:49:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C123224AE6;
	Tue, 26 Aug 2025 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190954; cv=none; b=f1OtQjRZhA72wzDbt92kB9Hck/fiBfmklDnuUJeV6PFAKN8asDIebvVa0gs5gIAQYjqOIrww8sw+eg85t4x7LLtUPYGVfHxCkCd+THkgldE4WbIJQ9OQY14wnGsCq2XntEXsxlS6Y4a64nDDTXLx9IoAjI+ArQVqvSbMZ6NOF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190954; c=relaxed/simple;
	bh=WQiyCPe1c9Dqjla1jCqE9LJ4OEHB8M7ZV66fnfHLw20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaDSpvTIRWOABa+G4KyBfA9MXO/RiUcGHNHG8Sx6yG2cS8oKNS6q0bfBWU5QAkfI/3MHLjrohN6239MLdroVDecL92lltPIjL6OJf0FC6coDUp/hAiV6UfDiE2DQHS8NCPgesJ6JKst1bcS5xCkvQCcwaJIvE7uFfVI6R4ZLbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxLvDjWK1oh0EDAA--.6264S3;
	Tue, 26 Aug 2025 14:49:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxE+TiWK1oOGxpAA--.324S2;
	Tue, 26 Aug 2025 14:49:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: BPF: Optimize sign-extention mov instructions
Date: Tue, 26 Aug 2025 14:49:06 +0800
Message-ID: <20250826064906.10683-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxE+TiWK1oOGxpAA--.324S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWktw4rZw4xJr17Ar17XFc_yoW8Grykpr
	ZrCrnYkrWjq347AF1kJa1UWrsFyFsxGr47XFy2q3y8J39xWryqqr1fKw13tFZ5J39YvFWk
	XFy0kwn0qas8ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU

For 8-bit and 16-bit sign-extention mov instructions, it can use the native
instructions ext.w.b and ext.w.h directly, no need to use the temporary t1
register, just remove the redundant operations.

Here are the test results:

  # modprobe test_bpf test_range=81,84
  # dmesg -t | tail -5
  test_bpf: #81 ALU_MOVSX | BPF_B jited:1 5 PASS
  test_bpf: #82 ALU_MOVSX | BPF_H jited:1 5 PASS
  test_bpf: #83 ALU64_MOVSX | BPF_B jited:1 5 PASS
  test_bpf: #84 ALU64_MOVSX | BPF_H jited:1 5 PASS
  test_bpf: Summary: 4 PASSED, 0 FAILED, [4/4 JIT'ed]

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..7072db18c6cd 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -527,13 +527,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			emit_zext_32(ctx, dst, is32);
 			break;
 		case 8:
-			move_reg(ctx, t1, src);
-			emit_insn(ctx, extwb, dst, t1);
+			emit_insn(ctx, extwb, dst, src);
 			emit_zext_32(ctx, dst, is32);
 			break;
 		case 16:
-			move_reg(ctx, t1, src);
-			emit_insn(ctx, extwh, dst, t1);
+			emit_insn(ctx, extwh, dst, src);
 			emit_zext_32(ctx, dst, is32);
 			break;
 		case 32:
-- 
2.42.0


