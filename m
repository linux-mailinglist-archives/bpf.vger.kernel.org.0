Return-Path: <bpf+bounces-47809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD49A001B1
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2514D1639F0
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3E1C463F;
	Thu,  2 Jan 2025 23:25:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E71C3C10;
	Thu,  2 Jan 2025 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860334; cv=none; b=bqXuyIxFq5Eritcpw33Kd+jIJsCJt6WorQYvyjAaBFDaVj33FZZtdPF9yzJSDL89fehE3A3O6T7hf+sLKTL2SbXQrmG1goUW64ktlWsbTl4IiVecDxS4NQ2z2d68Q1rVv3JIG3R2Ra9wpJlPRaJ7N5AUxwj2V0u5j3+SK0X0uvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860334; c=relaxed/simple;
	bh=uLAkQ1iCsJrNH+pf6IhLKO9FnRJigtIjVOdVkksLxas=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ovgux5+JTuelkbiWHwpLoHknCiux4WkEOUHzJD7RJrGHfh+EUaqppnMqArPGCR6e/TrBWhOV4Ha9MKm0C7lrmy/GPMARVulkrqGCOxHxvgKiN9fypAwp+XxS6FvkyxKH8wp29F+83zDyXieJ/EVAhL0AkmP3YrlBs76aGB0hxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DBAC4CED0;
	Thu,  2 Jan 2025 23:25:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTUaZ-00000005Yyp-25r6;
	Thu, 02 Jan 2025 18:26:51 -0500
Message-ID: <20250102232651.347490863@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 18:26:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 16/16] scripts/sorttable: ftrace: Do not add weak functions to
 available_filter_functions
References: <20250102232609.529842248@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a function is annotated as "weak" and is overridden, the code is not
removed. If it is traced, the fentry/mcount location in the weak function
will be referenced by the "__mcount_loc" section. This will then be added
to the available_filter_functions list. Since only the address of the
functions are listed, to find the name to show, a search of kallsyms is
used.

Since kallsyms will return the function by simply finding the function
that the address is after but before the next function, an address of a
weak function will show up as the function before it. This is because
kallsyms does not save names of weak functions. This has caused issues in
the past, as now the traced weak function will be listed in
available_filter_functions with the name of the function before it.

At best, this will cause the previous function's name to be listed twice.
At worse, if the previous function was marked notrace, it will now show up
as a function that can be traced. Note that it only shows up that it can
be traced but will not be if enabled, which causes confusion.

 https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/

The commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
adding weak function") was a workaround to this by checking the function
address before printing its name. If the address was too far from the
function given by the name then instead of printing the name it would
print: __ftrace_invalid_address___<invalid-offset>

The real issue is that these invalid addresses are listed in the ftrace
table look up which available_filter_functions is derived from. A place
holder must be listed in that file because set_ftrace_filter may take a
series of indexes into that file instead of names to be able to do O(1)
lookups to enable filtering (many tools use this method).

Even if kallsyms saved the size of the function, it does not remove the
need of having these place holders. The real solution is to not add a weak
function into the ftrace table in the first place.

To solve this, the sorttable.c code that sorts the mcount regions during
the build is modified to take a "nm -S vmlinux" input, sort it, and any
function listed in the mcount_loc section that is not within a boundary of
the function list given by nm is considered a weak function and is zeroed
out. Note, this does not mean they will remain zero when booting as KASLR
will still shift those addresses.

A new initdata variable is added: ftrace_mcount_skip
The sorttable will update that to the number of functions at the start of
the mcount_loc section that should be skipped. As it zeros out the weak
functions before sorting, they end up all at the start of the section.
This variable states how many of them to skip over.

On boot up, when the ftrace table is created from the mcount_loc section,
it will start at the start_mcount_loc + ftrace_mcount_skip. This stops the
weak functions from ever being added to the ftrace table and also keeps
from needing place holders in available_filter_functions.

Before:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 556

After:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 0

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 16 +++++++++++++---
 scripts/sorttable.c   | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..1b8cb4ebd285 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7747,10 +7747,14 @@ int __init __weak ftrace_dyn_arch_init(void)
 	return 0;
 }
 
+/* This is set in scripts/sorttable.c */
+int ftrace_mcount_skip __initdata;
+
 void __init ftrace_init(void)
 {
 	extern unsigned long __start_mcount_loc[];
 	extern unsigned long __stop_mcount_loc[];
+	unsigned long *start_addr = __start_mcount_loc;
 	unsigned long count, flags;
 	int ret;
 
@@ -7761,6 +7765,14 @@ void __init ftrace_init(void)
 		goto failed;
 
 	count = __stop_mcount_loc - __start_mcount_loc;
+
+	/*
+	 * scripts/sorttable.c will set ftrace_mcount_skip to state
+	 * how many functions to skip in the __mcount_loc section.
+	 * These would have been weak functions.
+	 */
+	count -= ftrace_mcount_skip;
+	start_addr += ftrace_mcount_skip;
 	if (!count) {
 		pr_info("ftrace: No functions to be traced?\n");
 		goto failed;
@@ -7769,9 +7781,7 @@ void __init ftrace_init(void)
 	pr_info("ftrace: allocating %ld entries in %ld pages\n",
 		count, DIV_ROUND_UP(count, ENTRIES_PER_PAGE));
 
-	ret = ftrace_process_locs(NULL,
-				  __start_mcount_loc,
-				  __stop_mcount_loc);
+	ret = ftrace_process_locs(NULL, start_addr, __stop_mcount_loc);
 	if (ret) {
 		pr_warn("ftrace: failed to allocate entries for functions\n");
 		goto failed;
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 1a2b420a4929..506172898fd8 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -543,6 +543,7 @@ static pthread_t mcount_sort_thread;
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *init_data_sec;
+	Elf_Sym *ftrace_skip_sym;
 	uint64_t start_mcount_loc;
 	uint64_t stop_mcount_loc;
 };
@@ -554,9 +555,17 @@ static void *sort_mcount_loc(void *arg)
 	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
 					+ shdr_offset(emloc->init_data_sec);
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	uint32_t *skip_addr = NULL;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 	void *end_loc = start_loc + count;
 
+	if (emloc->ftrace_skip_sym) {
+		offset = sym_value(emloc->ftrace_skip_sym) -
+			shdr_addr(emloc->init_data_sec) +
+			shdr_offset(emloc->init_data_sec);
+		skip_addr = (void *)emloc->ehdr + offset;
+	}
+
 	/* zero out any locations not found by function list */
 	if (function_list_size) {
 		for (void *ptr = start_loc; ptr < end_loc; ptr += long_size) {
@@ -573,6 +582,25 @@ static void *sort_mcount_loc(void *arg)
 	}
 
 	qsort(start_loc, count/long_size, long_size, compare_extable);
+
+	/* Now set how many functions need to be skipped */
+	for (void *ptr = start_loc; skip_addr && ptr < end_loc; ptr += long_size) {
+		uint64_t val;
+
+		if (long_size == 4)
+			val = *(uint32_t *)ptr;
+		else
+			val = *(uint64_t *)ptr;
+		if (val) {
+			uint32_t skip;
+
+			/* Update the ftrace_mcount_skip to skip these functions */
+			val = ptr - (void *)start_loc;
+			skip = val / long_size;
+			w(r(&skip), skip_addr);
+			break;
+		}
+	}
 	return NULL;
 }
 
@@ -590,11 +618,15 @@ static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
 	while (sym < end_sym) {
 		if (!strcmp(strtab + sym_name(sym), "__start_mcount_loc")) {
 			emloc->start_mcount_loc = sym_value(sym);
-			if (++found == 2)
+			if (++found == 3)
 				break;
 		} else if (!strcmp(strtab + sym_name(sym), "__stop_mcount_loc")) {
 			emloc->stop_mcount_loc = sym_value(sym);
-			if (++found == 2)
+			if (++found == 3)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "ftrace_mcount_skip")) {
+			emloc->ftrace_skip_sym = sym;
+			if (++found == 3)
 				break;
 		}
 		sym = (void *)sym + symentsize;
-- 
2.45.2



