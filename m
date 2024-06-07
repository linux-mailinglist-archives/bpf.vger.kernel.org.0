Return-Path: <bpf+bounces-31580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977849002A6
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 13:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13EA1C23323
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30818FDD9;
	Fri,  7 Jun 2024 11:51:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD9187358;
	Fri,  7 Jun 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761112; cv=none; b=IdeNJRy0j/5CHfZ26hspvUT3OOiV6HNX23AoG48PW7R98hAdzf0TFd6Cr7TYjgqC59zwOCIr+E/moliGExDXa3vF/oU//wCt4u+C/jEqV7KI0YTnI/PZYDu9ToKW9fDGTmxGEwC0C1YH5p85XFsBTVzhOrD4Zj3MHKy+kRfLdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761112; c=relaxed/simple;
	bh=GnXWztmBlVx1nxLihLb597i2xbfK7pMcpc9w3/QoxVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hiwb6okXt+OqtqTuWc7lnIdxB/NAAmD6e9TQ6EZYmuvqgFrFM1vIorXYwT0u1nOD9iJdWpBcIlkWKMpWDonV9A3aBHEyIIW3gJHuwHc06xo6yPJROMCKMYwsKgu/z9WqpdlujZr8Wqt1WY30wHGLRE679Vxx8JwWURQm2Q4rHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwfZp5jCFzsTYC;
	Fri,  7 Jun 2024 19:47:46 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C8B3418007E;
	Fri,  7 Jun 2024 19:51:45 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 19:51:45 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <rostedt@goodmis.org>, <mcgrof@kernel.org>, <mhiramat@kernel.org>,
	<mark.rutland@arm.com>, <mathieu.desnoyers@efficios.com>,
	<jpoimboe@kernel.org>, <peterz@infradead.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak functions
Date: Fri, 7 Jun 2024 19:52:11 +0800
Message-ID: <20240607115211.734845-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)

ftrace_location() was changed to not only return the __fentry__ location
when called for the __fentry__ location, but also when called for the
sym+0 location after commit aebfd12521d9 ("x86/ibt,ftrace: Search for
__fentry__ location"). That is, if sym+0 location is not __fentry__,
ftrace_location() would find one over the entire size of the sym.

However, there is case that more than one __fentry__ exist in the sym
range (described below) and ftrace_location() would find wrong __fentry__
location by binary searching, which would cause its users like livepatch/
kprobe/bpf to not work properly on this sym!

The case is that, based on current compiler behavior, suppose:
 - function A is followed by weak function B1 in same binary file;
 - weak function B1 is overridden by function B2;
Then in the final binary file:
 - symbol B1 will be removed from symbol table while its instructions are
   not removed;
 - __fentry__ of B1 will be still in __mcount_loc table;
 - function size of A is computed by substracting the symbol address of
   A from its next symbol address (see kallsyms_lookup_size_offset()),
   but because symbol info of B1 is removed, the next symbol of A is
   originally the next symbol of B1. See following example, function
   sizeof A will be (symbol_address_C - symbol_address_A):

     symbol_address_A
     symbol_address_B1 (Not in symbol table)
     symbol_address_C

The weak function issue has been discovered in commit b39181f7c690
("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
but it didn't resolve the issue in ftrace_location().

There may be following resolutions:

1. Shrink the search range when __fentry__ is not a sym+0 location,
   for example use the macro FTRACE_MCOUNT_MAX_OFFSET. This need every
   arch to define its own FTRACE_MCOUNT_MAX_OFFSET:

   ftrace_location() {
     ...
     if (!offset)
       loc = ftrace_location_range(ip, ip + FTRACE_MCOUNT_MAX_OFFSET + 1);
     ...
  }

2. Define arch-specific arch_ftrace_location() based on its own
   different cases of __fentry__ position, for example:

   ftrace_location() {
     ...
     if (!offset)
       loc = arch_ftrace_location(ip);
     ...
  }

3. Skip __fentry__ of non-override weak function in ftrace_process_locs()
   then all records in ftrace_pages are valid. The reason why this scheme
   may work is that both __mcount_loc and symbol table are sorted and it
   can be assumed that one function has only one __fentry__ location. Then
   commit b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
   adding weak function") can be reverted (not do in this patch). However,
   looking up size and offset of every record in __mount_loc table will
   slow down system boot and module load.

Solution 1 and 2 need every arch to handle the complex fentry location
case, I use solution 3 as RFC.

Fixes: aebfd12521d9 ("x86/ibt,ftrace: Search for __fentry__ location")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 include/linux/module.h   |  8 ++++++++
 kernel/module/kallsyms.c | 23 +++++++++++++++++------
 kernel/trace/ftrace.c    | 20 +++++++++++++-------
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ffa1c603163c..3d5a2165160d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -954,6 +954,9 @@ unsigned long module_kallsyms_lookup_name(const char *name);
 
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
 
+int find_kallsyms_symbol(struct module *mod, unsigned long addr,
+			 unsigned long *size, unsigned long *offset);
+
 #else	/* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 static inline int module_kallsyms_on_each_symbol(const char *modname,
@@ -997,6 +1000,11 @@ static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
 	return 0;
 }
 
+static inline int find_kallsyms_symbol(struct module *mod, unsigned long addr,
+				       unsigned long *size, unsigned long *offset)
+{
+	return 0;
+}
 #endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 62fb57bb9f16..d70fb4ead794 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -253,10 +253,10 @@ static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned
  * Given a module and address, find the corresponding symbol and return its name
  * while providing its size and offset if needed.
  */
-static const char *find_kallsyms_symbol(struct module *mod,
-					unsigned long addr,
-					unsigned long *size,
-					unsigned long *offset)
+static const char *__find_kallsyms_symbol(struct module *mod,
+					  unsigned long addr,
+					  unsigned long *size,
+					  unsigned long *offset)
 {
 	unsigned int i, best = 0;
 	unsigned long nextval, bestval;
@@ -311,6 +311,17 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	return kallsyms_symbol_name(kallsyms, best);
 }
 
+int find_kallsyms_symbol(struct module *mod, unsigned long addr,
+			 unsigned long *size, unsigned long *offset)
+{
+	const char *ret;
+
+	preempt_disable();
+	ret = __find_kallsyms_symbol(mod, addr, size, offset);
+	preempt_enable();
+	return !!ret;
+}
+
 void * __weak dereference_module_function_descriptor(struct module *mod,
 						     void *ptr)
 {
@@ -344,7 +355,7 @@ const char *module_address_lookup(unsigned long addr,
 #endif
 		}
 
-		ret = find_kallsyms_symbol(mod, addr, size, offset);
+		ret = __find_kallsyms_symbol(mod, addr, size, offset);
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
@@ -367,7 +378,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 		if (within_module(addr, mod)) {
 			const char *sym;
 
-			sym = find_kallsyms_symbol(mod, addr, NULL, NULL);
+			sym = __find_kallsyms_symbol(mod, addr, NULL, NULL);
 			if (!sym)
 				goto out;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65208d3b5ed9..3c56be753ae8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6488,6 +6488,7 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long addr;
 	unsigned long flags = 0; /* Shut up gcc */
 	int ret = -ENOMEM;
+	unsigned long last_func = 0;
 
 	count = end - start;
 
@@ -6538,6 +6539,8 @@ static int ftrace_process_locs(struct module *mod,
 	pg = start_pg;
 	while (p < end) {
 		unsigned long end_offset;
+		unsigned long cur_func, off;
+
 		addr = ftrace_call_adjust(*p++);
 		/*
 		 * Some architecture linkers will pad between
@@ -6549,6 +6552,16 @@ static int ftrace_process_locs(struct module *mod,
 			skipped++;
 			continue;
 		}
+		if (mod)
+			WARN_ON_ONCE(!find_kallsyms_symbol(mod, addr, NULL, &off));
+		else
+			WARN_ON_ONCE(!kallsyms_lookup_size_offset(addr, NULL, &off));
+		cur_func = addr - off;
+		if (cur_func == last_func) {
+			skipped++;
+			continue;
+		}
+		last_func = cur_func;
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -6860,13 +6873,6 @@ void ftrace_module_enable(struct module *mod)
 		if (!within_module(rec->ip, mod))
 			break;
 
-		/* Weak functions should still be ignored */
-		if (!test_for_valid_rec(rec)) {
-			/* Clear all other flags. Should not be enabled anyway */
-			rec->flags = FTRACE_FL_DISABLED;
-			continue;
-		}
-
 		cnt = 0;
 
 		/*
-- 
2.25.1


