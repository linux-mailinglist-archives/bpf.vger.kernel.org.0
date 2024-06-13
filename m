Return-Path: <bpf+bounces-32082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FB9073D3
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650B62833C5
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453514533E;
	Thu, 13 Jun 2024 13:36:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF16143C75;
	Thu, 13 Jun 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285805; cv=none; b=AB+U0FrklNLPy+1d398t7FtdanDiZJV+WrwEh8i8Sup8864U6gTHV2NlZ3lrSMu9TFY0aiNkELFF0njXjAys9MnNpeiaD0MQ4N3H1Mo7ZvifJFWrqXcDlkM9zLn0Y54mnkg1EpoD0nMM09tN69skxkevGYUBxc5QIyonE2sh7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285805; c=relaxed/simple;
	bh=x+CIEYIYHsbtftJJ7Jf0T9GbH9mpamwznfchkhYrlaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUxgF/cEo9PL63u1bkwhH81VCJX45A6LUVRS5Ok71nFQ8RgsMLhl+h5AcnlwHlHYX16gdqB3jd83wQC3jbeYWYLINl3/u+kSK13MgrbTvaiU2TpZOHynO8plVd44Cob9P6Vkb3I7T66qvd9xVa7IfjIpygUCG7JmrSLlT7KkrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W0Ncx6TbFzwTm3;
	Thu, 13 Jun 2024 21:32:33 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 35049180069;
	Thu, 13 Jun 2024 21:36:41 +0800 (CST)
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
Subject: [PATCH 4/6] ftrace: Skip invalid __fentry__ in ftrace_process_locs()
Date: Thu, 13 Jun 2024 21:37:09 +0800
Message-ID: <20240613133711.2867745-5-zhengyejian1@huawei.com>
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

To solve the issue, with Peter's suggestions, in previous patches, all
holes in the text have been found and filled with specail symbols, also
the same case with module weak function has been handled. Then check and
skip __fentry__ that locate in the holes.

Also in this patch, introduce following helper functions:
 1. kallsyms_is_hole_symbol() is used to check if a function name is
    of a hole symbol;
 2. module_kallsyms_find_symbol() is used to check if a __fentry__
    locate in a valid function of the given module. It is needed because
    other symbol lookup functions like module_address_lookup() will find
    module of the passed address, but as ftrace_process_locs() is called,
    the module has not been fully loaded, so those lookup functions can
    not work.

Fixes: aebfd12521d9 ("x86/ibt,ftrace: Search for __fentry__ location")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 include/linux/kallsyms.h | 13 +++++++++++++
 include/linux/module.h   |  7 +++++++
 kernel/module/kallsyms.c | 23 +++++++++++++++++------
 kernel/trace/ftrace.c    | 15 ++++++++++++++-
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index c3f075e8f60c..0bf0d595f244 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -88,6 +88,14 @@ const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *offset,
 			    char **modname, char *namebuf);
 
+/*
+ * Check if the name is of a hole symbol
+ */
+static inline int kallsyms_is_hole_symbol(const char *name)
+{
+	return !strcmp(name, "__hole_symbol_XXXXX");
+}
+
 /* Look up a kernel symbol and return it in a text buffer. */
 extern int sprint_symbol(char *buffer, unsigned long address);
 extern int sprint_symbol_build_id(char *buffer, unsigned long address);
@@ -119,6 +127,11 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
+static inline int kallsyms_is_hole_symbol(const char *name)
+{
+	return 0;
+}
+
 static inline int sprint_symbol(char *buffer, unsigned long addr)
 {
 	*buffer = '\0';
diff --git a/include/linux/module.h b/include/linux/module.h
index 13518f464d3f..a3fd077ef2a8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -960,6 +960,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 unsigned long module_kallsyms_lookup_name(const char *name);
 
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
+int module_kallsyms_find_symbol(struct module *mod, unsigned long addr,
+				unsigned long *size, unsigned long *offset);
 
 #else	/* CONFIG_MODULES && CONFIG_KALLSYMS */
 
@@ -1004,6 +1006,11 @@ static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
 	return 0;
 }
 
+static inline int module_kallsyms_find_symbol(struct module *mod, unsigned long addr,
+					      unsigned long *size, unsigned long *offset)
+{
+	return 0;
+}
 #endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 092ae6f43dad..e9c439d81708 100644
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
@@ -326,6 +326,17 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	return kallsyms_symbol_name(kallsyms, best);
 }
 
+int module_kallsyms_find_symbol(struct module *mod, unsigned long addr,
+				unsigned long *size, unsigned long *offset)
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
@@ -359,7 +370,7 @@ const char *module_address_lookup(unsigned long addr,
 #endif
 		}
 
-		ret = find_kallsyms_symbol(mod, addr, size, offset);
+		ret = __find_kallsyms_symbol(mod, addr, size, offset);
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
@@ -382,7 +393,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 		if (within_module(addr, mod)) {
 			const char *sym;
 
-			sym = find_kallsyms_symbol(mod, addr, NULL, NULL);
+			sym = __find_kallsyms_symbol(mod, addr, NULL, NULL);
 			if (!sym)
 				goto out;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 65208d3b5ed9..0e8628e4d296 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6474,6 +6474,19 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+static int is_invalid_rec(struct module *mod, unsigned long addr)
+{
+	char str[KSYM_SYMBOL_LEN];
+
+	if (mod)
+		return !module_kallsyms_find_symbol(mod, addr, NULL, NULL);
+
+	if (!kallsyms_lookup(addr, NULL, NULL, NULL, str))
+		return 1;
+	/* record locates in hole is invalid */
+	return kallsyms_is_hole_symbol(str);
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6545,7 +6558,7 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr) {
+		if (!addr || is_invalid_rec(mod, addr)) {
 			skipped++;
 			continue;
 		}
-- 
2.25.1


