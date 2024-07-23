Return-Path: <bpf+bounces-35368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DB9399BF
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA9B1C21A71
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BFF14A4DD;
	Tue, 23 Jul 2024 06:32:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114913CF85;
	Tue, 23 Jul 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716329; cv=none; b=h6ZykdvqCMvEcC+dukyeRpFBql0IdFzCsD7mfrJGIbI4x9V5i42cdUh992LKjRTDNJJdbbBRfyoTMtBfRqF7pk4KQG5KNnu43i2RZxRCljHeRo8V+v+d1eTUWSCBKFFD6t0GZkN9cnpfRW203QDb38/VrS2FX/Bt8ettg4nDSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716329; c=relaxed/simple;
	bh=LLO1F1XA2C13CWuFfwDqmzGNIc8dg7seX4y/8W9IzB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQI5WAfMwBY0xuxF4gUij2lI/67+FR33skMT05wIAPWt6F65iJeRDzp7M7sNafOGd+KXFbJdtyLN6A3tIP1fZyoAQo/ZhWktfcmzH481c3I1YffFNHb9keK5ZiWF01U50KhqUWKqanJqRLlc8O4NsP2R0AIswQFiuTDb2x6AxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WSnP00S3Xz4f3lVL;
	Tue, 23 Jul 2024 14:31:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8D8FB1A0572;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP2 (Coremail) with SMTP id Syh0CgA34wpOTp9mjImuAw--.48686S4;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: masahiroy@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mcgrof@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	james.clark@arm.com,
	jpoimboe@kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2 2/5] module: kallsyms: Determine exact function size
Date: Tue, 23 Jul 2024 14:32:55 +0800
Message-Id: <20240723063258.2240610-3-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA34wpOTp9mjImuAw--.48686S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47Wry3tF4UAr4xKw47twb_yoW5Ary5pF
	45Ar4rGF48Xr47uFWxAay09ry5Gr1kur4UKasxK34fZFnIqFy093Z7t3y5C3s8Zr48GF18
	JrnagFWakF4UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRC2NtUUUUU
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

When a weak type function is overridden, its symbol will be removed
from the symbol table, but its code will not been removed. It will
cause find_kallsyms_symbol() to compute a larger function size than
it actually is, just because symbol of its following weak function is
removed.

To fix this issue, check that given address is within the size of
the function found.

Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 include/linux/module.h   |  7 +++++++
 kernel/module/kallsyms.c | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 4213d8993cd8..0299d79433ae 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -599,6 +599,13 @@ static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
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
index bf65e0c3c86f..cce4f81b9933 100644
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
+			goto found;
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
+found:
 	if (size)
 		*size = nextval - bestval;
 	if (offset)
-- 
2.25.1


