Return-Path: <bpf+bounces-47903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81570A01A84
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E8A1885311
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF731D618A;
	Sun,  5 Jan 2025 16:22:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C31D54C0;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094143; cv=none; b=I7Sh9bD0JN17Yk8L0JIufbSnwiWJlqaTk5bGgJmq97hp03f5tH+ll0S0xTo/MUPz38sVKk/BANcxTVuLqG7R1oPdHzrup8NhfkswoTwSC3fiZq2SapRUDJqNGoLc7z30+LJItLfHuryngbLawJ43slJEthk4PNXTSL4T63Y14U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094143; c=relaxed/simple;
	bh=4XDYGnaJqZyZf9GsCD6m7euu79M2meSX1buewOLfQ90=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hJk3hrx+txexwEpsCG4SeEjx0QLvsSTgE5rsbwnxp/yU3ayYmX1R4JzR1J6P3OKvuJaJb7JbRw1DvnUsLXlwVAqLHTPZNT7KYC/mCESiZfKVyzwoiqxeSjaDhgkRBYT4nrnkVmSqgZnTOU+ZAp039qgxOxAiM8KLINCjlBfebIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC43FC4CED0;
	Sun,  5 Jan 2025 16:22:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPm-00000008Exb-48zt;
	Sun, 05 Jan 2025 11:23:46 -0500
Message-ID: <20250105162346.817157047@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:25 -0500
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
Subject: [PATCH 14/14] scripts/sorttable: Get start/stop_mcount_loc from ELF file directly
References: <20250105162211.971039541@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The get_mcount_loc() does a cheesy trick to find the start_mcount_loc and
stop_mcount_loc values. That trick is:

 file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");

and

 file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");

Those values are stored in the Elf symbol table. Use that to capture those
values. Using the symbol table is more efficient and more robust. The
above could fail if another variable had "start_mcount" or "stop_mcount"
as part of its name.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 95 +++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 50 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index b9d9eb6f01f1..cd3b2145a827 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -469,42 +469,41 @@ static void *sort_mcount_loc(void *arg)
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
+			if (++found == 2)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "__stop_mcount_loc")) {
+			emloc->stop_mcount_loc = sym_value(sym);
+			if (++found == 2)
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
 #endif
+
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
 		   table_sort_t custom_sort)
@@ -535,8 +534,6 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
 	struct elf_mcount_loc mstruct = {0};
-	uint64_t _start_mcount_loc = 0;
-	uint64_t _stop_mcount_loc = 0;
 #endif
 #ifdef UNWINDER_ORC_ENABLED
 	unsigned int orc_ip_size = 0;
@@ -574,13 +571,8 @@ static int do_sort(Elf_Ehdr *ehdr,
 
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
 
 #ifdef UNWINDER_ORC_ENABLED
@@ -624,23 +616,6 @@ static int do_sort(Elf_Ehdr *ehdr,
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
@@ -660,6 +635,26 @@ static int do_sort(Elf_Ehdr *ehdr,
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
-- 
2.45.2



