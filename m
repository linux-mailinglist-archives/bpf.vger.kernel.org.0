Return-Path: <bpf+bounces-47789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D826A0011B
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0DA7A1DA5
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C61BBBC5;
	Thu,  2 Jan 2025 22:13:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DC1B6CE9;
	Thu,  2 Jan 2025 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855997; cv=none; b=byw0dHOXt+2ubmSX0Rsrj0Z0DAQNmSYlGk+1I9d/Wv8KwsimvuBTmnQurVJc73eLvg2CxB9WSqhcPfPLnbxGqL1vA57e6LgqCPtv6is3QZKF2TQhqgnlmO0v8Ai80vlvnnNp7iGQ0JjeZIjKkpXQJS3MtFic/Aa7bPc5ybwaPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855997; c=relaxed/simple;
	bh=rITP3EEkpgAn7tqmxq8YJZ2VuQbmsK+iT2/qX5Oy/KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyPc4LvAgeCOXKVcJrKmxyank1wvN66+yXWu6kopaE8Qm/UwlbPXdPdcXX9GffP4oRtniBesXaW318qWAEXXnrZN/hENRQLDKvNhbgLcKmjEImBF1nYQmMOwkJ8qcqca2ayL4slarlI+h0Dpl2S2lG1jaoO8aPZTNmwcpuUf/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB85BC4CED0;
	Thu,  2 Jan 2025 22:13:14 +0000 (UTC)
Date: Thu, 2 Jan 2025 17:14:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250102171431.319ef74b@gandalf.local.home>
In-Reply-To: <20250102164454.2ffa33b1@gandalf.local.home>
References: <20250102185845.928488650@goodmis.org>
	<CAHk-=wjg4ckXG6tQHFAU_mL5vEFedwjGe=uahb31Oju50bYbNA@mail.gmail.com>
	<20250102164454.2ffa33b1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 16:44:54 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I guess the next thing I could do is to create a "skip" variable that can
> be modified, and we can skip X entries in the start_mcount_loc. As the
> start_mcount_loc and stop_mcount_loc (which determines the size of the
> table) cannot be modified in an architecture independent way.

This is on top of the last patch, but I'll likely restructure it and remove
the kaslr_offset() part totally. I'd still break it up into two patches.
One to remove the reading of the System.map, and then the other to add the
skip variable.

This version, I add a "ftrace_mcount_skip" that is default to zero, but the
sorttable.c code will update it to skip over the functions that it zeroed
out.

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5963ae76b31a..3193148102e0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7077,20 +7077,6 @@ static int ftrace_process_locs(struct module *mod,
 			continue;
 		}
 
-		/*
-		 * At build time, a check is made against: nm -S vmlinux
-		 * to make sure all functions are found within the
-		 * size range of symbols listed by nm. If not, it's likely
-		 * a weak function that was overridden. We do not want those.
-		 * The script will zero them out, but kaslr will still
-		 * update them. If the address is the same as the kaslr_offset()
-		 * then skip the record.
-		 */
-		if (addr == kaslr_offset()) {
-			skipped++;
-			continue;
-		}
-
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
@@ -7761,10 +7747,13 @@ int __init __weak ftrace_dyn_arch_init(void)
 	return 0;
 }
 
+int ftrace_mcount_skip __initdata;
+
 void __init ftrace_init(void)
 {
 	extern unsigned long __start_mcount_loc[];
 	extern unsigned long __stop_mcount_loc[];
+	unsigned long *start_addr = __start_mcount_loc;
 	unsigned long count, flags;
 	int ret;
 
@@ -7775,6 +7764,14 @@ void __init ftrace_init(void)
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
@@ -7783,9 +7780,7 @@ void __init ftrace_init(void)
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
index d1d52bd12adb..506172898fd8 100644
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
@@ -554,12 +555,19 @@ static void *sort_mcount_loc(void *arg)
 	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
 					+ shdr_offset(emloc->init_data_sec);
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	uint32_t *skip_addr = NULL;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
+	void *end_loc = start_loc + count;
+
+	if (emloc->ftrace_skip_sym) {
+		offset = sym_value(emloc->ftrace_skip_sym) -
+			shdr_addr(emloc->init_data_sec) +
+			shdr_offset(emloc->init_data_sec);
+		skip_addr = (void *)emloc->ehdr + offset;
+	}
 
 	/* zero out any locations not found by function list */
 	if (function_list_size) {
-		void *end_loc = start_loc + count;
-
 		for (void *ptr = start_loc; ptr < end_loc; ptr += long_size) {
 			uint64_t key;
 
@@ -574,44 +582,65 @@ static void *sort_mcount_loc(void *arg)
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
 
 /* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
+static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
+			   const char *strtab)
 {
-	FILE *file_start, *file_stop;
-	char start_buff[20];
-	char stop_buff[20];
-	int len = 0;
+	Elf_Sym *sym, *end_sym;
+	int symentsize = shdr_entsize(symtab_sec);
+	int found = 0;
+
+	sym = (void *)emloc->ehdr + shdr_offset(symtab_sec);
+	end_sym = (void *)sym + shdr_size(symtab_sec);
+
+	while (sym < end_sym) {
+		if (!strcmp(strtab + sym_name(sym), "__start_mcount_loc")) {
+			emloc->start_mcount_loc = sym_value(sym);
+			if (++found == 3)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "__stop_mcount_loc")) {
+			emloc->stop_mcount_loc = sym_value(sym);
+			if (++found == 3)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "ftrace_mcount_skip")) {
+			emloc->ftrace_skip_sym = sym;
+			if (++found == 3)
+				break;
+		}
+		sym = (void *)sym + symentsize;
+	}
 
-	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
-	if (!file_start) {
+	if (!emloc->start_mcount_loc) {
 		fprintf(stderr, "get start_mcount_loc error!");
 		return;
 	}
 
-	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
-	if (!file_stop) {
+	if (!emloc->stop_mcount_loc) {
 		fprintf(stderr, "get stop_mcount_loc error!");
-		pclose(file_start);
 		return;
 	}
-
-	while (fgets(start_buff, sizeof(start_buff), file_start) != NULL) {
-		len = strlen(start_buff);
-		start_buff[len - 1] = '\0';
-	}
-	*_start = strtoul(start_buff, NULL, 16);
-
-	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
-		len = strlen(stop_buff);
-		stop_buff[len - 1] = '\0';
-	}
-	*_stop = strtoul(stop_buff, NULL, 16);
-
-	pclose(file_start);
-	pclose(file_stop);
 }
 #else /* MCOUNT_SORT_ENABLED */
 static inline int parse_symbols(const char *fname) { return 0; }
@@ -647,8 +676,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
 	struct elf_mcount_loc mstruct = {0};
-	uint64_t _start_mcount_loc = 0;
-	uint64_t _stop_mcount_loc = 0;
 #endif
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
@@ -686,15 +713,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 
 #ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
-		if (!strcmp(secstrings + idx, ".init.data")) {
-			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
-			mstruct.ehdr = ehdr;
+		if (!strcmp(secstrings + idx, ".init.data"))
 			mstruct.init_data_sec = shdr;
-			mstruct.start_mcount_loc = _start_mcount_loc;
-			mstruct.stop_mcount_loc = _stop_mcount_loc;
-		}
 #endif
-
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 		/* locate the ORC unwind tables */
 		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
@@ -736,23 +757,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 		goto out;
 	}
 #endif
-
-#ifdef MCOUNT_SORT_ENABLED
-	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
-		fprintf(stderr,
-			"incomplete mcount's sort in file: %s\n",
-			fname);
-		goto out;
-	}
-
-	/* create thread to sort mcount_loc concurrently */
-	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
-		fprintf(stderr,
-			"pthread_create mcount_sort_thread failed '%s': %s\n",
-			strerror(errno), fname);
-		goto out;
-	}
-#endif
 	if (!extab_sec) {
 		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
 		goto out;
@@ -772,6 +776,26 @@ static int do_sort(Elf_Ehdr *ehdr,
 	strtab = (const char *)ehdr + shdr_offset(strtab_sec);
 	symtab = (const Elf_Sym *)((const char *)ehdr + shdr_offset(symtab_sec));
 
+#ifdef MCOUNT_SORT_ENABLED
+	mstruct.ehdr = ehdr;
+	get_mcount_loc(&mstruct, symtab_sec, strtab);
+
+	if (!mstruct.init_data_sec || !mstruct.start_mcount_loc || !mstruct.stop_mcount_loc) {
+		fprintf(stderr,
+			"incomplete mcount's sort in file: %s\n",
+			fname);
+		goto out;
+	}
+
+	/* create thread to sort mcount_loc concurrently */
+	if (pthread_create(&mcount_sort_thread, NULL, &sort_mcount_loc, &mstruct)) {
+		fprintf(stderr,
+			"pthread_create mcount_sort_thread failed '%s': %s\n",
+			strerror(errno), fname);
+		goto out;
+	}
+#endif
+
 	if (custom_sort) {
 		custom_sort(extab_image, shdr_size(extab_sec));
 	} else {

