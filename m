Return-Path: <bpf+bounces-42016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227E99E63E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 13:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E611F24DFB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AC1EF0B7;
	Tue, 15 Oct 2024 11:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226101E7658;
	Tue, 15 Oct 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992364; cv=none; b=Yu9MWw5x4ou3xYWELgGvweUfINu0dRgZmoLQwC1ngkpvN0eNOdDdlJMZqTIR+V9mgAGVOHqMeCdJ5SJyyo5S+reXJK/oUimTPRLpDvekET69AuPVn1AU7WQU7WTNdgpKgBXY1KeeHhCip6/XUPYtneFSzA2rpE/CKfa7gZqa/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992364; c=relaxed/simple;
	bh=SbfJr9+jdDKjyBPYTFn1HGRQF9YgV69BHlnKnAozTHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuRLV0KbT90tSAb/s8ZLZODjA10mcNBNYdXTPXmJxyTcYDcLYPXazdatwni0jWx2OXSUkuCX2z82izv8VOn/oZvMWUjNzCMtO7FB8FvTbcviVpgnkiyIp5L2X24cS5XyJ/LheERPAQ86kYE3pEaBADmUxy3c5qgASIHNk62P7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxyrFnVA5n8n8dAA--.42637S3;
	Tue, 15 Oct 2024 19:39:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMCxbcdkVA5n6E0uAA--.9583S5;
	Tue, 15 Oct 2024 19:39:19 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] LoongArch: Enable jump table for objtool
Date: Tue, 15 Oct 2024 19:39:12 +0800
Message-ID: <20241015113915.12623-4-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qciowMCxbcdkVA5n6E0uAA--.9583S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF47uFWrtr1xZw15Kw13Jrc_yoW8uF1kpr
	Z7Zr1kGr4kXF4vqry3J3yFg398AFnrtr4fXF4xWa4rCrWSq3yavw40yrsrGa40k398J3yS
	gFWfGa4ayF4UGwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

For now, it can remove -fno-jump-tables and then enable jump table
for objtool if the compiler has option -mannotate-tablejump.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig  | 8 +++++++-
 arch/loongarch/Makefile | 5 +----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bb35c34f86d2..49ed776cb253 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -150,7 +150,7 @@ config LOONGARCH
 	select HAVE_LIVEPATCH
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB
+	select HAVE_OBJTOOL if TOOLCHAIN_SUPPORTS_OBJTOOL
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -284,6 +284,12 @@ config AS_HAS_LBT_EXTENSION
 config AS_HAS_LVZ_EXTENSION
 	def_bool $(as-instr,hvcl 0)
 
+config CC_HAS_ANNOTATE_TABLEJUMP
+	def_bool $(cc-option,-mannotate-tablejump)
+
+config TOOLCHAIN_SUPPORTS_OBJTOOL
+	def_bool AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && CC_HAS_ANNOTATE_TABLEJUMP
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae3f80622f4c..69a3b4ae6c60 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -99,10 +99,7 @@ KBUILD_AFLAGS			+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno
 KBUILD_CFLAGS			+= $(call cc-option,-mno-relax) $(call cc-option,-Wa$(comma)-mno-relax)
 KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
 KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
-
-ifdef CONFIG_OBJTOOL
-KBUILD_CFLAGS			+= -fno-jump-tables
-endif
+KBUILD_CFLAGS			+= $(call cc-option,-mannotate-tablejump)
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat
 KBUILD_RUSTFLAGS_KERNEL		+= -Zdirect-access-external-data=yes
-- 
2.42.0


