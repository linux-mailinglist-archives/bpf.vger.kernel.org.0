Return-Path: <bpf+bounces-32084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF889073DC
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD80E1C227B5
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F5145B1B;
	Thu, 13 Jun 2024 13:36:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88E143C7A;
	Thu, 13 Jun 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285806; cv=none; b=trYgkzWmGgwajMrvkdMjSX33nAUOUaMoSwP/BVCbyOK2nA5TIdSOu7is0W5Kyp0ZgXfoRfmyZN8ltVlzBsLcmPcopWebh7ZXIsBIbU6CHQlodz8vk3dqVFiM3uW7rCYJPw15T5My+TssOxedjWrtJeUty0XEi09Rn8/YXdrTtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285806; c=relaxed/simple;
	bh=CrPKC982qjIse3Ck6Gjvw9p9oWmd+fMASANGmez5t04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuZ5AuPPJXuWkCnduG5WrUWHeOi3bE+Z92rSEZ2Nm/TtkBrbfDENr+JFLLwrG+9tarZzf5+wPinNpKLcf70JbMMY3uPExSmM/bXKtFz96hSNNRlNpxDrTF3Ir9496gFgaydMEmMNTCom8Quch+a7/YUyD2Zr+JrXUlUdRBLRehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W0Ncy3KstzwTml;
	Thu, 13 Jun 2024 21:32:34 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id BFC44140154;
	Thu, 13 Jun 2024 21:36:41 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 21:36:41 +0800
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
Subject: [PATCH 6/6] ftrace: Revert the FTRACE_MCOUNT_MAX_OFFSET workaround
Date: Thu, 13 Jun 2024 21:37:11 +0800
Message-ID: <20240613133711.2867745-7-zhengyejian1@huawei.com>
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

After patch titled "ftrace: Skip invalid __fentry__ in
ftrace_process_locs()", __fentry__ locations in overridden weak function
have been checked and skipped, then all records in ftrace_pages are
valid, the FTRACE_MCOUNT_MAX_OFFSET workaround can be reverted, include:
 1. commit b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
    adding weak function")
 2. commit 7af82ff90a2b ("powerpc/ftrace: Ignore weak functions")
 3. commit f6834c8c59a8 ("powerpc/ftrace: Fix dropping weak symbols with
    older toolchains")

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 arch/powerpc/include/asm/ftrace.h |   7 --
 arch/x86/include/asm/ftrace.h     |   7 --
 kernel/trace/ftrace.c             | 141 +-----------------------------
 3 files changed, 2 insertions(+), 153 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 107fc5a48456..d6ed058c8041 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -10,13 +10,6 @@
 
 #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
-/* Ignore unused weak functions which will have larger offsets */
-#if defined(CONFIG_MPROFILE_KERNEL) || defined(CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY)
-#define FTRACE_MCOUNT_MAX_OFFSET	16
-#elif defined(CONFIG_PPC32)
-#define FTRACE_MCOUNT_MAX_OFFSET	8
-#endif
-
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
 
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..7a147c9da08d 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -9,13 +9,6 @@
 # define MCOUNT_ADDR		((unsigned long)(__fentry__))
 #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
 
-/* Ignore unused weak functions which will have non zero offsets */
-#ifdef CONFIG_HAVE_FENTRY
-# include <asm/ibt.h>
-/* Add offset for endbr64 if IBT enabled */
-# define FTRACE_MCOUNT_MAX_OFFSET	ENDBR_INSN_SIZE
-#endif
-
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c46c35ac9b42..1d60dc9a850b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -49,8 +49,6 @@
 #define FTRACE_NOCLEAR_FLAGS	(FTRACE_FL_DISABLED | FTRACE_FL_TOUCHED | \
 				 FTRACE_FL_MODIFIED)
 
-#define FTRACE_INVALID_FUNCTION		"__ftrace_invalid_address__"
-
 #define FTRACE_WARN_ON(cond)			\
 	({					\
 		int ___r = cond;		\
@@ -3709,105 +3707,6 @@ static void add_trampoline_func(struct seq_file *m, struct ftrace_ops *ops,
 		seq_printf(m, " ->%pS", ptr);
 }
 
-#ifdef FTRACE_MCOUNT_MAX_OFFSET
-/*
- * Weak functions can still have an mcount/fentry that is saved in
- * the __mcount_loc section. These can be detected by having a
- * symbol offset of greater than FTRACE_MCOUNT_MAX_OFFSET, as the
- * symbol found by kallsyms is not the function that the mcount/fentry
- * is part of. The offset is much greater in these cases.
- *
- * Test the record to make sure that the ip points to a valid kallsyms
- * and if not, mark it disabled.
- */
-static int test_for_valid_rec(struct dyn_ftrace *rec)
-{
-	char str[KSYM_SYMBOL_LEN];
-	unsigned long offset;
-	const char *ret;
-
-	ret = kallsyms_lookup(rec->ip, NULL, &offset, NULL, str);
-
-	/* Weak functions can cause invalid addresses */
-	if (!ret || offset > FTRACE_MCOUNT_MAX_OFFSET) {
-		rec->flags |= FTRACE_FL_DISABLED;
-		return 0;
-	}
-	return 1;
-}
-
-static struct workqueue_struct *ftrace_check_wq __initdata;
-static struct work_struct ftrace_check_work __initdata;
-
-/*
- * Scan all the mcount/fentry entries to make sure they are valid.
- */
-static __init void ftrace_check_work_func(struct work_struct *work)
-{
-	struct ftrace_page *pg;
-	struct dyn_ftrace *rec;
-
-	mutex_lock(&ftrace_lock);
-	do_for_each_ftrace_rec(pg, rec) {
-		test_for_valid_rec(rec);
-	} while_for_each_ftrace_rec();
-	mutex_unlock(&ftrace_lock);
-}
-
-static int __init ftrace_check_for_weak_functions(void)
-{
-	INIT_WORK(&ftrace_check_work, ftrace_check_work_func);
-
-	ftrace_check_wq = alloc_workqueue("ftrace_check_wq", WQ_UNBOUND, 0);
-
-	queue_work(ftrace_check_wq, &ftrace_check_work);
-	return 0;
-}
-
-static int __init ftrace_check_sync(void)
-{
-	/* Make sure the ftrace_check updates are finished */
-	if (ftrace_check_wq)
-		destroy_workqueue(ftrace_check_wq);
-	return 0;
-}
-
-late_initcall_sync(ftrace_check_sync);
-subsys_initcall(ftrace_check_for_weak_functions);
-
-static int print_rec(struct seq_file *m, unsigned long ip)
-{
-	unsigned long offset;
-	char str[KSYM_SYMBOL_LEN];
-	char *modname;
-	const char *ret;
-
-	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);
-	/* Weak functions can cause invalid addresses */
-	if (!ret || offset > FTRACE_MCOUNT_MAX_OFFSET) {
-		snprintf(str, KSYM_SYMBOL_LEN, "%s_%ld",
-			 FTRACE_INVALID_FUNCTION, offset);
-		ret = NULL;
-	}
-
-	seq_puts(m, str);
-	if (modname)
-		seq_printf(m, " [%s]", modname);
-	return ret == NULL ? -1 : 0;
-}
-#else
-static inline int test_for_valid_rec(struct dyn_ftrace *rec)
-{
-	return 1;
-}
-
-static inline int print_rec(struct seq_file *m, unsigned long ip)
-{
-	seq_printf(m, "%ps", (void *)ip);
-	return 0;
-}
-#endif
-
 static int t_show(struct seq_file *m, void *v)
 {
 	struct ftrace_iterator *iter = m->private;
@@ -3835,13 +3734,7 @@ static int t_show(struct seq_file *m, void *v)
 	if (iter->flags & FTRACE_ITER_ADDRS)
 		seq_printf(m, "%lx ", rec->ip);
 
-	if (print_rec(m, rec->ip)) {
-		/* This should only happen when a rec is disabled */
-		WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
-		seq_putc(m, '\n');
-		return 0;
-	}
-
+	seq_printf(m, "%ps", (void *)rec->ip);
 	if (iter->flags & (FTRACE_ITER_ENABLED | FTRACE_ITER_TOUCHED)) {
 		struct ftrace_ops *ops;
 
@@ -4221,24 +4114,6 @@ add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
 	return 0;
 }
 
-#ifdef FTRACE_MCOUNT_MAX_OFFSET
-static int lookup_ip(unsigned long ip, char **modname, char *str)
-{
-	unsigned long offset;
-
-	kallsyms_lookup(ip, NULL, &offset, modname, str);
-	if (offset > FTRACE_MCOUNT_MAX_OFFSET)
-		return -1;
-	return 0;
-}
-#else
-static int lookup_ip(unsigned long ip, char **modname, char *str)
-{
-	kallsyms_lookup(ip, NULL, NULL, modname, str);
-	return 0;
-}
-#endif
-
 static int
 ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 		struct ftrace_glob *mod_g, int exclude_mod)
@@ -4246,12 +4121,7 @@ ftrace_match_record(struct dyn_ftrace *rec, struct ftrace_glob *func_g,
 	char str[KSYM_SYMBOL_LEN];
 	char *modname;
 
-	if (lookup_ip(rec->ip, &modname, str)) {
-		/* This should only happen when a rec is disabled */
-		WARN_ON_ONCE(system_state == SYSTEM_RUNNING &&
-			     !(rec->flags & FTRACE_FL_DISABLED));
-		return 0;
-	}
+	kallsyms_lookup(rec->ip, NULL, NULL, &modname, str);
 
 	if (mod_g) {
 		int mod_matches = (modname) ? ftrace_match(modname, mod_g) : 0;
@@ -6887,13 +6757,6 @@ void ftrace_module_enable(struct module *mod)
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


