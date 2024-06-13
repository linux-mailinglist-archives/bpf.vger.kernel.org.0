Return-Path: <bpf+bounces-32080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC6A9073CC
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF3A1F21F46
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA27144D12;
	Thu, 13 Jun 2024 13:36:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE5143C5F;
	Thu, 13 Jun 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285805; cv=none; b=LFg19xWbXQBGLjngUmjk6sJMr++whhDOnqjjooPR0t9FosgOGLkiW9GA0KKxw/eMnkvCW2122Uw7+xI9aiVkATdfzZKVABFyQrZBARJ8hQ1uNS/E8yuSTh2HckFRnDIv8CBMvwpzPurpMUH6j+mS8XSujMX9yBiCL/kdmrcSjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285805; c=relaxed/simple;
	bh=L3kKolLqYCdCsguERH50zIApmY/jXnpJBn/Cw8AtSBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbirFXteDmHz7qFj1gpijxFlNHjPwuRPkQIjnFxVhiyFs1xu/2A9qB1CAcqd0idGO8WD9U8qV/aWt1nhE+sRwtOUvv6++Qvcm+k2KQ4l67DHfXA8ZQ61hC5TVwxaMPY/ftxrzaJthuFyCSHV49qHAJaLL4Y3/kbU60zDjL3E+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W0Ncx4JDtzwTlf;
	Thu, 13 Jun 2024 21:32:33 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id E049B140154;
	Thu, 13 Jun 2024 21:36:40 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 21:36:40 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen.n.rao@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <mcgrof@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<masahiroy@kernel.org>, <nathan@kernel.org>, <nicolas@fjasle.eu>,
	<kees@kernel.org>, <james.clark@arm.com>, <kent.overstreet@linux.dev>,
	<yhs@fb.com>, <jpoimboe@kernel.org>, <peterz@infradead.org>
CC: <zhengyejian1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-modules@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH 3/6] module: kallsyms: Determine exact function size
Date: Thu, 13 Jun 2024 21:37:08 +0800
Message-ID: <20240613133711.2867745-4-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613133711.2867745-1-zhengyejian1@huawei.com>
References: <20240613133711.2867745-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)

When a weak type function is overridden, its symbol will be removed
from the symbol table, but its code will not been removed. It will
cause find_kallsyms_symbol() to compute a larger function size than
it actually is, just because symbol of its following weak function is
removed.

To fix this issue, check that an given address is within the size of
the function found.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 include/linux/module.h   |  7 +++++++
 kernel/module/kallsyms.c | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ffa1c603163c..13518f464d3f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -597,6 +597,13 @@ static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
 }
 #endif
 
+#ifndef HAVE_ARCH_KALLSYMS_SYMBOL_TYPE
+static inline unsigned int kallsyms_symbol_type(const Elf_Sym *sym)
+{
+	return ELF_ST_TYPE(sym->st_info);
+}
+#endif
+
 /* FIXME: It'd be nice to isolate modules during init, too, so they
    aren't used before they (may) fail.  But presently too much code
    (IDE & SCSI) require entry into the module during init.*/
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 62fb57bb9f16..092ae6f43dad 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -262,6 +262,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	unsigned long nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
 	struct module_memory *mod_mem;
+	const Elf_Sym *sym;
 
 	/* At worse, next value is at end of module */
 	if (within_module_init(addr, mod))
@@ -278,9 +279,10 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	 * starts real symbols at 1).
 	 */
 	for (i = 1; i < kallsyms->num_symtab; i++) {
-		const Elf_Sym *sym = &kallsyms->symtab[i];
-		unsigned long thisval = kallsyms_symbol_value(sym);
+		unsigned long thisval;
 
+		sym = &kallsyms->symtab[i];
+		thisval = kallsyms_symbol_value(sym);
 		if (sym->st_shndx == SHN_UNDEF)
 			continue;
 
@@ -292,6 +294,13 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
+		if (kallsyms_symbol_type(sym) == STT_FUNC &&
+		    addr >= thisval && addr < thisval + sym->st_size) {
+			best = i;
+			bestval = thisval;
+			nextval = thisval + sym->st_size;
+			goto find;
+		}
 		if (thisval <= addr && thisval > bestval) {
 			best = i;
 			bestval = thisval;
@@ -303,6 +312,12 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	if (!best)
 		return NULL;
 
+	sym = &kallsyms->symtab[best];
+	if (kallsyms_symbol_type(sym) == STT_FUNC && sym->st_size &&
+	    addr >= kallsyms_symbol_value(sym) + sym->st_size)
+		return NULL;
+
+find:
 	if (size)
 		*size = nextval - bestval;
 	if (offset)
-- 
2.25.1


