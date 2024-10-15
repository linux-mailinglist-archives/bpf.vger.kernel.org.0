Return-Path: <bpf+bounces-42018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDDA99E644
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A511E28905E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB31F7069;
	Tue, 15 Oct 2024 11:39:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F071EF0BD;
	Tue, 15 Oct 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992366; cv=none; b=j1ZD+UQtBTyKl82knVeO+NG9aLIsNYPbCIVqM0j7k8dBKiqhqEn1joKgLEc2okBuPj0Zx4Aa4Q7DcTgwU6yER4ZIoZVATgtDKdAB5DI7TJq5d6q9oYaYP+cLijzpj4KuED1pjguUlgIjeFrFpCj6AbYSLXfMJ7a138/euQKZKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992366; c=relaxed/simple;
	bh=ApEpc+gMzlX7HhsNG8gGJN7ES63x/5gdU3xsJJp/lNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6qPTqFR1MUVvjvhwHkuVHpmH0HRljlMuWat1cLdk/XcTky/ZNqPP6I/H8nrlasLoGQvRF6UyZfnXhpnwaZzlp4tNyoAetgTliWFRLOc4oOvK3BdLOd33QUjETf8BueX4k8IxqKSN4DOgknfmlN1+C4st/Bq4yiaAQ1E1BuP4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxkuhoVA5n_H8dAA--.42777S3;
	Tue, 15 Oct 2024 19:39:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMCxbcdkVA5n6E0uAA--.9583S7;
	Tue, 15 Oct 2024 19:39:20 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] LoongArch: Define specified arch_prepare_goto()
Date: Tue, 15 Oct 2024 19:39:14 +0800
Message-ID: <20241015113915.12623-6-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241015113915.12623-1-yangtiezhu@loongson.cn>
References: <20241015113915.12623-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxbcdkVA5n6E0uAA--.9583S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1ftr4xAF43CF4xCF18CrX_yoW8WrW5pF
	9rZ3WkKFZ7Wr4fCrZrta4UWr15Xan3WF47WF1Iqa48AF90q34vyr1kK34DAFyUCan5JrWI
	gF1fWa4YgF4UJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

In order to figure out the address of goto table by interpreting the
LoongArch machine code, define specified arch_prepare_goto() to insert
the relocation information of goto table address, then it can find the
destination address of the table jump instruction.

Suggested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                |  1 +
 arch/loongarch/include/asm/compiler.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/loongarch/include/asm/compiler.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 49ed776cb253..9eed0bde678f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -106,6 +106,7 @@ config LOONGARCH
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
diff --git a/arch/loongarch/include/asm/compiler.h b/arch/loongarch/include/asm/compiler.h
new file mode 100644
index 000000000000..424268a92c40
--- /dev/null
+++ b/arch/loongarch/include/asm/compiler.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_COMPILER_H
+#define _ASM_COMPILER_H
+
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
+#define arch_prepare_goto() \
+	asm volatile(".reloc\t., R_LARCH_NONE, %0" : : "i" (jumptable))
+#endif
+
+#endif /* _ASM_COMPILER_H */
-- 
2.42.0


