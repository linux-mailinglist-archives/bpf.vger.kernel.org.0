Return-Path: <bpf+bounces-47769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F79FFF1E
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FFA3A3B29
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB21BD9E3;
	Thu,  2 Jan 2025 18:59:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F11BD000;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844389; cv=none; b=VQi4VGttMYDbgyoIDMYWL6cFCjsGOdEt85RFOG3KdzggWlqiVhX9PMl6RXtAuAzDUW+HDri6/X1QbA6LoXWh28Ka5yNacM1z0ON438IH157vypsC8gW+1rB3BPQzDq4mjyUFTPWpKKHqQqorQnuiVThdpigSOn/QDMlQpixca6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844389; c=relaxed/simple;
	bh=Z1ifu5d2WFSuCvXmWv8QD9Mr0b9/K+neWrODXtL1TJ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AvdlyrY8pk5RvfALCnKYLH2gV2aqeLLPbqFOyoNHDbCC9i7OmJrl/dujQf8HQGg4UreK+OGBQSLWZJt0HBCX6Q4o1lyIL0NoI8nQYdmQI0JeMQaLGt/63i1ObekzFeq5mK2Y1eD1ZuWvIGPATmVLAAai3+hisJfs/cx3qU+GRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1EEC4CED6;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRN-00000005MpK-225b;
	Thu, 02 Jan 2025 14:01:05 -0500
Message-ID: <20250102190105.337110490@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:58 -0500
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
Subject: [PATCH 13/14] scripts/sorttable: Move code from sorttable.h into sorttable.c
References: <20250102185845.928488650@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of having the main code live in a header file and included twice
with MACROs that define the Elf structures for 64 bit or 32 bit, move the
code in the C file now that the Elf structures are defined in a union that
has both. All accesses to the Elf structure fields are done through helper
function pointers. If the file being parsed if for a 64 bit architecture,
all the helper functions point to the 64 bit versions to retrieve the Elf
fields. The same is true if the architecture is 32 bit, where the function
pointers will point to the 32 bit helper functions.

Note, when the value of a field can be either 32 bit or 64 bit, a 64 bit
is always returned, as it works for the 32 bit code as well.

This makes the code easier to read and maintain, and it now all exists in
sorttable.c and sorttable.h may be removed.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 470 ++++++++++++++++++++++++++++++++++++++++--
 scripts/sorttable.h | 482 --------------------------------------------
 2 files changed, 457 insertions(+), 495 deletions(-)
 delete mode 100644 scripts/sorttable.h

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 20615de18276..da9e1a82e886 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -327,10 +327,420 @@ static inline void *get_index(void *start, int entsize, int index)
 	return start + (entsize * index);
 }
 
-/* 32 bit and 64 bit are very similar */
-#include "sorttable.h"
-#define SORTTABLE_64
-#include "sorttable.h"
+
+static int (*compare_extable)(const void *a, const void *b);
+static uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
+static uint16_t (*ehdr_shstrndx)(Elf_Ehdr *ehdr);
+static uint16_t (*ehdr_shentsize)(Elf_Ehdr *ehdr);
+static uint16_t (*ehdr_shnum)(Elf_Ehdr *ehdr);
+static uint64_t (*shdr_addr)(Elf_Shdr *shdr);
+static uint64_t (*shdr_offset)(Elf_Shdr *shdr);
+static uint64_t (*shdr_size)(Elf_Shdr *shdr);
+static uint64_t (*shdr_entsize)(Elf_Shdr *shdr);
+static uint32_t (*shdr_link)(Elf_Shdr *shdr);
+static uint32_t (*shdr_name)(Elf_Shdr *shdr);
+static uint32_t (*shdr_type)(Elf_Shdr *shdr);
+static uint8_t (*sym_type)(Elf_Sym *sym);
+static uint32_t (*sym_name)(Elf_Sym *sym);
+static uint64_t (*sym_value)(Elf_Sym *sym);
+static uint16_t (*sym_shndx)(Elf_Sym *sym);
+
+static int extable_ent_size;
+static int long_size;
+
+
+#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
+/* ORC unwinder only support X86_64 */
+#include <asm/orc_types.h>
+
+#define ERRSTR_MAXSZ	256
+
+static char g_err[ERRSTR_MAXSZ];
+static int *g_orc_ip_table;
+static struct orc_entry *g_orc_table;
+
+static pthread_t orc_sort_thread;
+
+static inline unsigned long orc_ip(const int *ip)
+{
+	return (unsigned long)ip + *ip;
+}
+
+static int orc_sort_cmp(const void *_a, const void *_b)
+{
+	struct orc_entry *orc_a;
+	const int *a = g_orc_ip_table + *(int *)_a;
+	const int *b = g_orc_ip_table + *(int *)_b;
+	unsigned long a_val = orc_ip(a);
+	unsigned long b_val = orc_ip(b);
+
+	if (a_val > b_val)
+		return 1;
+	if (a_val < b_val)
+		return -1;
+
+	/*
+	 * The "weak" section terminator entries need to always be on the left
+	 * to ensure the lookup code skips them in favor of real entries.
+	 * These terminator entries exist to handle any gaps created by
+	 * whitelisted .o files which didn't get objtool generation.
+	 */
+	orc_a = g_orc_table + (a - g_orc_ip_table);
+	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
+}
+
+static void *sort_orctable(void *arg)
+{
+	int i;
+	int *idxs = NULL;
+	int *tmp_orc_ip_table = NULL;
+	struct orc_entry *tmp_orc_table = NULL;
+	unsigned int *orc_ip_size = (unsigned int *)arg;
+	unsigned int num_entries = *orc_ip_size / sizeof(int);
+	unsigned int orc_size = num_entries * sizeof(struct orc_entry);
+
+	idxs = (int *)malloc(*orc_ip_size);
+	if (!idxs) {
+		snprintf(g_err, ERRSTR_MAXSZ, "malloc idxs: %s",
+			 strerror(errno));
+		pthread_exit(g_err);
+	}
+
+	tmp_orc_ip_table = (int *)malloc(*orc_ip_size);
+	if (!tmp_orc_ip_table) {
+		snprintf(g_err, ERRSTR_MAXSZ, "malloc tmp_orc_ip_table: %s",
+			 strerror(errno));
+		pthread_exit(g_err);
+	}
+
+	tmp_orc_table = (struct orc_entry *)malloc(orc_size);
+	if (!tmp_orc_table) {
+		snprintf(g_err, ERRSTR_MAXSZ, "malloc tmp_orc_table: %s",
+			 strerror(errno));
+		pthread_exit(g_err);
+	}
+
+	/* initialize indices array, convert ip_table to absolute address */
+	for (i = 0; i < num_entries; i++) {
+		idxs[i] = i;
+		tmp_orc_ip_table[i] = g_orc_ip_table[i] + i * sizeof(int);
+	}
+	memcpy(tmp_orc_table, g_orc_table, orc_size);
+
+	qsort(idxs, num_entries, sizeof(int), orc_sort_cmp);
+
+	for (i = 0; i < num_entries; i++) {
+		if (idxs[i] == i)
+			continue;
+
+		/* convert back to relative address */
+		g_orc_ip_table[i] = tmp_orc_ip_table[idxs[i]] - i * sizeof(int);
+		g_orc_table[i] = tmp_orc_table[idxs[i]];
+	}
+
+	free(idxs);
+	free(tmp_orc_ip_table);
+	free(tmp_orc_table);
+	pthread_exit(NULL);
+}
+#endif
+
+#ifdef MCOUNT_SORT_ENABLED
+static pthread_t mcount_sort_thread;
+
+struct elf_mcount_loc {
+	Elf_Ehdr *ehdr;
+	Elf_Shdr *init_data_sec;
+	uint64_t start_mcount_loc;
+	uint64_t stop_mcount_loc;
+};
+
+/* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
+static void *sort_mcount_loc(void *arg)
+{
+	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
+	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
+					+ shdr_offset(emloc->init_data_sec);
+	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	unsigned char *start_loc = (void *)emloc->ehdr + offset;
+
+	qsort(start_loc, count/long_size, long_size, compare_extable);
+	return NULL;
+}
+
+/* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
+static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
+{
+	FILE *file_start, *file_stop;
+	char start_buff[20];
+	char stop_buff[20];
+	int len = 0;
+
+	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
+	if (!file_start) {
+		fprintf(stderr, "get start_mcount_loc error!");
+		return;
+	}
+
+	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
+	if (!file_stop) {
+		fprintf(stderr, "get stop_mcount_loc error!");
+		pclose(file_start);
+		return;
+	}
+
+	while (fgets(start_buff, sizeof(start_buff), file_start) != NULL) {
+		len = strlen(start_buff);
+		start_buff[len - 1] = '\0';
+	}
+	*_start = strtoul(start_buff, NULL, 16);
+
+	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
+		len = strlen(stop_buff);
+		stop_buff[len - 1] = '\0';
+	}
+	*_stop = strtoul(stop_buff, NULL, 16);
+
+	pclose(file_start);
+	pclose(file_stop);
+}
+#endif
+static int do_sort(Elf_Ehdr *ehdr,
+		   char const *const fname,
+		   table_sort_t custom_sort)
+{
+	int rc = -1;
+	Elf_Shdr *shdr_start;
+	Elf_Shdr *strtab_sec = NULL;
+	Elf_Shdr *symtab_sec = NULL;
+	Elf_Shdr *extab_sec = NULL;
+	Elf_Shdr *string_sec;
+	Elf_Sym *sym;
+	const Elf_Sym *symtab;
+	Elf32_Word *symtab_shndx = NULL;
+	Elf_Sym *sort_needed_sym = NULL;
+	Elf_Shdr *sort_needed_sec;
+	uint32_t *sort_needed_loc;
+	void *sym_start;
+	void *sym_end;
+	const char *secstrings;
+	const char *strtab;
+	char *extab_image;
+	int sort_need_index;
+	int symentsize;
+	int shentsize;
+	int idx;
+	int i;
+	unsigned int shnum;
+	unsigned int shstrndx;
+#ifdef MCOUNT_SORT_ENABLED
+	struct elf_mcount_loc mstruct = {0};
+	uint64_t _start_mcount_loc = 0;
+	uint64_t _stop_mcount_loc = 0;
+#endif
+#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
+	unsigned int orc_ip_size = 0;
+	unsigned int orc_size = 0;
+	unsigned int orc_num_entries = 0;
+#endif
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	shstrndx = ehdr_shstrndx(ehdr);
+	if (shstrndx == SHN_XINDEX)
+		shstrndx = shdr_link(shdr_start);
+	string_sec = get_index(shdr_start, shentsize, shstrndx);
+	secstrings = (const char *)ehdr + shdr_offset(string_sec);
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	for (i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+
+		idx = shdr_name(shdr);
+		if (!strcmp(secstrings + idx, "__ex_table"))
+			extab_sec = shdr;
+		if (!strcmp(secstrings + idx, ".symtab"))
+			symtab_sec = shdr;
+		if (!strcmp(secstrings + idx, ".strtab"))
+			strtab_sec = shdr;
+
+		if (shdr_type(shdr) == SHT_SYMTAB_SHNDX)
+			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
+						      shdr_offset(shdr));
+
+#ifdef MCOUNT_SORT_ENABLED
+		/* locate the .init.data section in vmlinux */
+		if (!strcmp(secstrings + idx, ".init.data")) {
+			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
+			mstruct.ehdr = ehdr;
+			mstruct.init_data_sec = shdr;
+			mstruct.start_mcount_loc = _start_mcount_loc;
+			mstruct.stop_mcount_loc = _stop_mcount_loc;
+		}
+#endif
+
+#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
+		/* locate the ORC unwind tables */
+		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
+			orc_ip_size = shdr_size(shdr);
+			g_orc_ip_table = (int *)((void *)ehdr +
+						   shdr_offset(shdr));
+		}
+		if (!strcmp(secstrings + idx, ".orc_unwind")) {
+			orc_size = shdr_size(shdr);
+			g_orc_table = (struct orc_entry *)((void *)ehdr +
+							     shdr_offset(shdr));
+		}
+#endif
+	} /* for loop */
+
+#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
+	if (!g_orc_ip_table || !g_orc_table) {
+		fprintf(stderr,
+			"incomplete ORC unwind tables in file: %s\n", fname);
+		goto out;
+	}
+
+	orc_num_entries = orc_ip_size / sizeof(int);
+	if (orc_ip_size % sizeof(int) != 0 ||
+	    orc_size % sizeof(struct orc_entry) != 0 ||
+	    orc_num_entries != orc_size / sizeof(struct orc_entry)) {
+		fprintf(stderr,
+			"inconsistent ORC unwind table entries in file: %s\n",
+			fname);
+		goto out;
+	}
+
+	/* create thread to sort ORC unwind tables concurrently */
+	if (pthread_create(&orc_sort_thread, NULL,
+			   sort_orctable, &orc_ip_size)) {
+		fprintf(stderr,
+			"pthread_create orc_sort_thread failed '%s': %s\n",
+			strerror(errno), fname);
+		goto out;
+	}
+#endif
+
+#ifdef MCOUNT_SORT_ENABLED
+	if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
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
+	if (!extab_sec) {
+		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
+		goto out;
+	}
+
+	if (!symtab_sec) {
+		fprintf(stderr,	"no .symtab in file: %s\n", fname);
+		goto out;
+	}
+
+	if (!strtab_sec) {
+		fprintf(stderr,	"no .strtab in file: %s\n", fname);
+		goto out;
+	}
+
+	extab_image = (void *)ehdr + shdr_offset(extab_sec);
+	strtab = (const char *)ehdr + shdr_offset(strtab_sec);
+	symtab = (const Elf_Sym *)((const char *)ehdr + shdr_offset(symtab_sec));
+
+	if (custom_sort) {
+		custom_sort(extab_image, shdr_size(extab_sec));
+	} else {
+		int num_entries = shdr_size(extab_sec) / extable_ent_size;
+		qsort(extab_image, num_entries,
+		      extable_ent_size, compare_extable);
+	}
+
+	/* find the flag main_extable_sort_needed */
+	sym_start = (void *)ehdr + shdr_offset(symtab_sec);
+	sym_end = sym_start + shdr_size(symtab_sec);
+	symentsize = shdr_entsize(symtab_sec);
+
+	for (sym = sym_start; (void *)sym + symentsize < sym_end;
+	     sym = (void *)sym + symentsize) {
+		if (sym_type(sym) != STT_OBJECT)
+			continue;
+		if (!strcmp(strtab + sym_name(sym),
+			    "main_extable_sort_needed")) {
+			sort_needed_sym = sym;
+			break;
+		}
+	}
+
+	if (!sort_needed_sym) {
+		fprintf(stderr,
+			"no main_extable_sort_needed symbol in file: %s\n",
+			fname);
+		goto out;
+	}
+
+	sort_need_index = get_secindex(sym_shndx(sym),
+				       ((void *)sort_needed_sym - (void *)symtab) / symentsize,
+				       symtab_shndx);
+	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
+	sort_needed_loc = (void *)ehdr +
+		shdr_offset(sort_needed_sec) +
+		sym_value(sort_needed_sym) - shdr_addr(sort_needed_sec);
+
+	/* extable has been sorted, clear the flag */
+	w(0, sort_needed_loc);
+	rc = 0;
+
+out:
+#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
+	if (orc_sort_thread) {
+		void *retval = NULL;
+		/* wait for ORC tables sort done */
+		rc = pthread_join(orc_sort_thread, &retval);
+		if (rc) {
+			fprintf(stderr,
+				"pthread_join failed '%s': %s\n",
+				strerror(errno), fname);
+		} else if (retval) {
+			rc = -1;
+			fprintf(stderr,
+				"failed to sort ORC tables '%s': %s\n",
+				(char *)retval, fname);
+		}
+	}
+#endif
+
+#ifdef MCOUNT_SORT_ENABLED
+	if (mcount_sort_thread) {
+		void *retval = NULL;
+		/* wait for mcount sort done */
+		rc = pthread_join(mcount_sort_thread, &retval);
+		if (rc) {
+			fprintf(stderr,
+				"pthread_join failed '%s': %s\n",
+				strerror(errno), fname);
+		} else if (retval) {
+			rc = -1;
+			fprintf(stderr,
+				"failed to sort mcount '%s': %s\n",
+				(char *)retval, fname);
+		}
+	}
+#endif
+	return rc;
+}
 
 static int compare_relative_table(const void *a, const void *b)
 {
@@ -399,7 +809,6 @@ static void sort_relative_table_with_data(char *extab_image, int image_size)
 
 static int do_file(char const *const fname, void *addr)
 {
-	int rc = -1;
 	Elf_Ehdr *ehdr = addr;
 	table_sort_t custom_sort = NULL;
 
@@ -462,29 +871,64 @@ static int do_file(char const *const fname, void *addr)
 		    r2(&ehdr->e32.e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC/ET_DYN file: %s\n", fname);
-			break;
+			return -1;
 		}
-		rc = do_sort_32(ehdr, fname, custom_sort);
+
+		compare_extable		= compare_extable_32;
+		ehdr_shoff		= ehdr32_shoff;
+		ehdr_shentsize		= ehdr32_shentsize;
+		ehdr_shstrndx		= ehdr32_shstrndx;
+		ehdr_shnum		= ehdr32_shnum;
+		shdr_addr		= shdr32_addr;
+		shdr_offset		= shdr32_offset;
+		shdr_link		= shdr32_link;
+		shdr_size		= shdr32_size;
+		shdr_name		= shdr32_name;
+		shdr_type		= shdr32_type;
+		shdr_entsize		= shdr32_entsize;
+		sym_type		= sym32_type;
+		sym_name		= sym32_name;
+		sym_value		= sym32_value;
+		sym_shndx		= sym32_shndx;
+		long_size		= 4;
+		extable_ent_size	= 8;
 		break;
 	case ELFCLASS64:
-		{
 		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
 		    r2(&ehdr->e64.e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC/ET_DYN file: %s\n",
 				fname);
-			break;
-		}
-		rc = do_sort_64(ehdr, fname, custom_sort);
+			return -1;
 		}
+
+		compare_extable		= compare_extable_64;
+		ehdr_shoff		= ehdr64_shoff;
+		ehdr_shentsize		= ehdr64_shentsize;
+		ehdr_shstrndx		= ehdr64_shstrndx;
+		ehdr_shnum		= ehdr64_shnum;
+		shdr_addr		= shdr64_addr;
+		shdr_offset		= shdr64_offset;
+		shdr_link		= shdr64_link;
+		shdr_size		= shdr64_size;
+		shdr_name		= shdr64_name;
+		shdr_type		= shdr64_type;
+		shdr_entsize		= shdr64_entsize;
+		sym_type		= sym64_type;
+		sym_name		= sym64_name;
+		sym_value		= sym64_value;
+		sym_shndx		= sym64_shndx;
+		long_size		= 8;
+		extable_ent_size	= 16;
+
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
 			ehdr->e32.e_ident[EI_CLASS], fname);
-		break;
+		return -1;
 	}
 
-	return rc;
+	return do_sort(ehdr, fname, custom_sort);
 }
 
 int main(int argc, char *argv[])
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
deleted file mode 100644
index b9c0716ee72c..000000000000
--- a/scripts/sorttable.h
+++ /dev/null
@@ -1,482 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * sorttable.h
- *
- * Added ORC unwind tables sort support and other updates:
- * Copyright (C) 1999-2019 Alibaba Group Holding Limited. by:
- * Shile Zhang <shile.zhang@linux.alibaba.com>
- *
- * Copyright 2011 - 2012 Cavium, Inc.
- *
- * Some of code was taken out of arch/x86/kernel/unwind_orc.c, written by:
- * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
- *
- * Some of this code was taken out of recordmcount.h written by:
- *
- * Copyright 2009 John F. Reiser <jreiser@BitWagon.com>. All rights reserved.
- * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
- */
-
-#undef extable_ent_size
-#undef compare_extable
-#undef get_mcount_loc
-#undef sort_mcount_loc
-#undef elf_mcount_loc
-#undef do_sort
-#undef ehdr_shoff
-#undef ehdr_shentsize
-#undef ehdr_shstrndx
-#undef ehdr_shnum
-#undef shdr_addr
-#undef shdr_offset
-#undef shdr_link
-#undef shdr_size
-#undef shdr_name
-#undef shdr_type
-#undef shdr_entsize
-#undef sym_type
-#undef sym_name
-#undef sym_value
-#undef sym_shndx
-#undef long_size
-
-#ifdef SORTTABLE_64
-# define extable_ent_size	16
-# define compare_extable	compare_extable_64
-# define get_mcount_loc		get_mcount_loc_64
-# define sort_mcount_loc	sort_mcount_loc_64
-# define elf_mcount_loc		elf_mcount_loc_64
-# define do_sort		do_sort_64
-# define ehdr_shoff		ehdr64_shoff
-# define ehdr_shentsize		ehdr64_shentsize
-# define ehdr_shstrndx		ehdr64_shstrndx
-# define ehdr_shnum		ehdr64_shnum
-# define shdr_addr		shdr64_addr
-# define shdr_offset		shdr64_offset
-# define shdr_link		shdr64_link
-# define shdr_size		shdr64_size
-# define shdr_name		shdr64_name
-# define shdr_type		shdr64_type
-# define shdr_entsize		shdr64_entsize
-# define sym_type		sym64_type
-# define sym_name		sym64_name
-# define sym_value		sym64_value
-# define sym_shndx		sym64_shndx
-# define long_size		8
-#else
-# define extable_ent_size	8
-# define compare_extable	compare_extable_32
-# define get_mcount_loc		get_mcount_loc_32
-# define sort_mcount_loc	sort_mcount_loc_32
-# define elf_mcount_loc		elf_mcount_loc_32
-# define do_sort		do_sort_32
-# define ehdr_shoff		ehdr32_shoff
-# define ehdr_shentsize		ehdr32_shentsize
-# define ehdr_shstrndx		ehdr32_shstrndx
-# define ehdr_shnum		ehdr32_shnum
-# define shdr_addr		shdr32_addr
-# define shdr_offset		shdr32_offset
-# define shdr_link		shdr32_link
-# define shdr_size		shdr32_size
-# define shdr_name		shdr32_name
-# define shdr_type		shdr32_type
-# define shdr_entsize		shdr32_entsize
-# define sym_type		sym32_type
-# define sym_name		sym32_name
-# define sym_value		sym32_value
-# define sym_shndx		sym32_shndx
-# define long_size		4
-#endif
-
-#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-/* ORC unwinder only support X86_64 */
-#include <asm/orc_types.h>
-
-#define ERRSTR_MAXSZ	256
-
-char g_err[ERRSTR_MAXSZ];
-int *g_orc_ip_table;
-struct orc_entry *g_orc_table;
-
-pthread_t orc_sort_thread;
-
-static inline unsigned long orc_ip(const int *ip)
-{
-	return (unsigned long)ip + *ip;
-}
-
-static int orc_sort_cmp(const void *_a, const void *_b)
-{
-	struct orc_entry *orc_a;
-	const int *a = g_orc_ip_table + *(int *)_a;
-	const int *b = g_orc_ip_table + *(int *)_b;
-	unsigned long a_val = orc_ip(a);
-	unsigned long b_val = orc_ip(b);
-
-	if (a_val > b_val)
-		return 1;
-	if (a_val < b_val)
-		return -1;
-
-	/*
-	 * The "weak" section terminator entries need to always be on the left
-	 * to ensure the lookup code skips them in favor of real entries.
-	 * These terminator entries exist to handle any gaps created by
-	 * whitelisted .o files which didn't get objtool generation.
-	 */
-	orc_a = g_orc_table + (a - g_orc_ip_table);
-	return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;
-}
-
-static void *sort_orctable(void *arg)
-{
-	int i;
-	int *idxs = NULL;
-	int *tmp_orc_ip_table = NULL;
-	struct orc_entry *tmp_orc_table = NULL;
-	unsigned int *orc_ip_size = (unsigned int *)arg;
-	unsigned int num_entries = *orc_ip_size / sizeof(int);
-	unsigned int orc_size = num_entries * sizeof(struct orc_entry);
-
-	idxs = (int *)malloc(*orc_ip_size);
-	if (!idxs) {
-		snprintf(g_err, ERRSTR_MAXSZ, "malloc idxs: %s",
-			 strerror(errno));
-		pthread_exit(g_err);
-	}
-
-	tmp_orc_ip_table = (int *)malloc(*orc_ip_size);
-	if (!tmp_orc_ip_table) {
-		snprintf(g_err, ERRSTR_MAXSZ, "malloc tmp_orc_ip_table: %s",
-			 strerror(errno));
-		pthread_exit(g_err);
-	}
-
-	tmp_orc_table = (struct orc_entry *)malloc(orc_size);
-	if (!tmp_orc_table) {
-		snprintf(g_err, ERRSTR_MAXSZ, "malloc tmp_orc_table: %s",
-			 strerror(errno));
-		pthread_exit(g_err);
-	}
-
-	/* initialize indices array, convert ip_table to absolute address */
-	for (i = 0; i < num_entries; i++) {
-		idxs[i] = i;
-		tmp_orc_ip_table[i] = g_orc_ip_table[i] + i * sizeof(int);
-	}
-	memcpy(tmp_orc_table, g_orc_table, orc_size);
-
-	qsort(idxs, num_entries, sizeof(int), orc_sort_cmp);
-
-	for (i = 0; i < num_entries; i++) {
-		if (idxs[i] == i)
-			continue;
-
-		/* convert back to relative address */
-		g_orc_ip_table[i] = tmp_orc_ip_table[idxs[i]] - i * sizeof(int);
-		g_orc_table[i] = tmp_orc_table[idxs[i]];
-	}
-
-	free(idxs);
-	free(tmp_orc_ip_table);
-	free(tmp_orc_table);
-	pthread_exit(NULL);
-}
-#endif
-
-#ifdef MCOUNT_SORT_ENABLED
-pthread_t mcount_sort_thread;
-
-struct elf_mcount_loc {
-	Elf_Ehdr *ehdr;
-	Elf_Shdr *init_data_sec;
-	uint64_t start_mcount_loc;
-	uint64_t stop_mcount_loc;
-};
-
-/* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
-static void *sort_mcount_loc(void *arg)
-{
-	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
-					+ shdr_offset(emloc->init_data_sec);
-	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
-	unsigned char *start_loc = (void *)emloc->ehdr + offset;
-
-	qsort(start_loc, count/long_size, long_size, compare_extable);
-	return NULL;
-}
-
-/* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
-{
-	FILE *file_start, *file_stop;
-	char start_buff[20];
-	char stop_buff[20];
-	int len = 0;
-
-	file_start = popen(" grep start_mcount System.map | awk '{print $1}' ", "r");
-	if (!file_start) {
-		fprintf(stderr, "get start_mcount_loc error!");
-		return;
-	}
-
-	file_stop = popen(" grep stop_mcount System.map | awk '{print $1}' ", "r");
-	if (!file_stop) {
-		fprintf(stderr, "get stop_mcount_loc error!");
-		pclose(file_start);
-		return;
-	}
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
-}
-#endif
-static int do_sort(Elf_Ehdr *ehdr,
-		   char const *const fname,
-		   table_sort_t custom_sort)
-{
-	int rc = -1;
-	Elf_Shdr *shdr_start;
-	Elf_Shdr *strtab_sec = NULL;
-	Elf_Shdr *symtab_sec = NULL;
-	Elf_Shdr *extab_sec = NULL;
-	Elf_Shdr *string_sec;
-	Elf_Sym *sym;
-	const Elf_Sym *symtab;
-	Elf32_Word *symtab_shndx = NULL;
-	Elf_Sym *sort_needed_sym = NULL;
-	Elf_Shdr *sort_needed_sec;
-	uint32_t *sort_needed_loc;
-	void *sym_start;
-	void *sym_end;
-	const char *secstrings;
-	const char *strtab;
-	char *extab_image;
-	int sort_need_index;
-	int symentsize;
-	int shentsize;
-	int idx;
-	int i;
-	unsigned int shnum;
-	unsigned int shstrndx;
-#ifdef MCOUNT_SORT_ENABLED
-	struct elf_mcount_loc mstruct = {0};
-	uint64_t _start_mcount_loc = 0;
-	uint64_t _stop_mcount_loc = 0;
-#endif
-#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-	unsigned int orc_ip_size = 0;
-	unsigned int orc_size = 0;
-	unsigned int orc_num_entries = 0;
-#endif
-
-	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
-	shentsize = ehdr_shentsize(ehdr);
-
-	shstrndx = ehdr_shstrndx(ehdr);
-	if (shstrndx == SHN_XINDEX)
-		shstrndx = shdr_link(shdr_start);
-	string_sec = get_index(shdr_start, shentsize, shstrndx);
-	secstrings = (const char *)ehdr + shdr_offset(string_sec);
-
-	shnum = ehdr_shnum(ehdr);
-	if (shnum == SHN_UNDEF)
-		shnum = shdr_size(shdr_start);
-
-	for (i = 0; i < shnum; i++) {
-		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
-
-		idx = shdr_name(shdr);
-		if (!strcmp(secstrings + idx, "__ex_table"))
-			extab_sec = shdr;
-		if (!strcmp(secstrings + idx, ".symtab"))
-			symtab_sec = shdr;
-		if (!strcmp(secstrings + idx, ".strtab"))
-			strtab_sec = shdr;
-
-		if (shdr_type(shdr) == SHT_SYMTAB_SHNDX)
-			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
-						      shdr_offset(shdr));
-
-#ifdef MCOUNT_SORT_ENABLED
-		/* locate the .init.data section in vmlinux */
-		if (!strcmp(secstrings + idx, ".init.data")) {
-			get_mcount_loc(&_start_mcount_loc, &_stop_mcount_loc);
-			mstruct.ehdr = ehdr;
-			mstruct.init_data_sec = shdr;
-			mstruct.start_mcount_loc = _start_mcount_loc;
-			mstruct.stop_mcount_loc = _stop_mcount_loc;
-		}
-#endif
-
-#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-		/* locate the ORC unwind tables */
-		if (!strcmp(secstrings + idx, ".orc_unwind_ip")) {
-			orc_ip_size = shdr_size(shdr);
-			g_orc_ip_table = (int *)((void *)ehdr +
-						   shdr_offset(shdr));
-		}
-		if (!strcmp(secstrings + idx, ".orc_unwind")) {
-			orc_size = shdr_size(shdr);
-			g_orc_table = (struct orc_entry *)((void *)ehdr +
-							     shdr_offset(shdr));
-		}
-#endif
-	} /* for loop */
-
-#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-	if (!g_orc_ip_table || !g_orc_table) {
-		fprintf(stderr,
-			"incomplete ORC unwind tables in file: %s\n", fname);
-		goto out;
-	}
-
-	orc_num_entries = orc_ip_size / sizeof(int);
-	if (orc_ip_size % sizeof(int) != 0 ||
-	    orc_size % sizeof(struct orc_entry) != 0 ||
-	    orc_num_entries != orc_size / sizeof(struct orc_entry)) {
-		fprintf(stderr,
-			"inconsistent ORC unwind table entries in file: %s\n",
-			fname);
-		goto out;
-	}
-
-	/* create thread to sort ORC unwind tables concurrently */
-	if (pthread_create(&orc_sort_thread, NULL,
-			   sort_orctable, &orc_ip_size)) {
-		fprintf(stderr,
-			"pthread_create orc_sort_thread failed '%s': %s\n",
-			strerror(errno), fname);
-		goto out;
-	}
-#endif
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
-	if (!extab_sec) {
-		fprintf(stderr,	"no __ex_table in file: %s\n", fname);
-		goto out;
-	}
-
-	if (!symtab_sec) {
-		fprintf(stderr,	"no .symtab in file: %s\n", fname);
-		goto out;
-	}
-
-	if (!strtab_sec) {
-		fprintf(stderr,	"no .strtab in file: %s\n", fname);
-		goto out;
-	}
-
-	extab_image = (void *)ehdr + shdr_offset(extab_sec);
-	strtab = (const char *)ehdr + shdr_offset(strtab_sec);
-	symtab = (const Elf_Sym *)((const char *)ehdr + shdr_offset(symtab_sec));
-
-	if (custom_sort) {
-		custom_sort(extab_image, shdr_size(extab_sec));
-	} else {
-		int num_entries = shdr_size(extab_sec) / extable_ent_size;
-		qsort(extab_image, num_entries,
-		      extable_ent_size, compare_extable);
-	}
-
-	/* find the flag main_extable_sort_needed */
-	sym_start = (void *)ehdr + shdr_offset(symtab_sec);
-	sym_end = sym_start + shdr_size(symtab_sec);
-	symentsize = shdr_entsize(symtab_sec);
-
-	for (sym = sym_start; (void *)sym + symentsize < sym_end;
-	     sym = (void *)sym + symentsize) {
-		if (sym_type(sym) != STT_OBJECT)
-			continue;
-		if (!strcmp(strtab + sym_name(sym),
-			    "main_extable_sort_needed")) {
-			sort_needed_sym = sym;
-			break;
-		}
-	}
-
-	if (!sort_needed_sym) {
-		fprintf(stderr,
-			"no main_extable_sort_needed symbol in file: %s\n",
-			fname);
-		goto out;
-	}
-
-	sort_need_index = get_secindex(sym_shndx(sym),
-				       ((void *)sort_needed_sym - (void *)symtab) / symentsize,
-				       symtab_shndx);
-	sort_needed_sec = get_index(shdr_start, shentsize, sort_need_index);
-	sort_needed_loc = (void *)ehdr +
-		shdr_offset(sort_needed_sec) +
-		sym_value(sort_needed_sym) - shdr_addr(sort_needed_sec);
-
-	/* extable has been sorted, clear the flag */
-	w(0, sort_needed_loc);
-	rc = 0;
-
-out:
-#if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
-	if (orc_sort_thread) {
-		void *retval = NULL;
-		/* wait for ORC tables sort done */
-		rc = pthread_join(orc_sort_thread, &retval);
-		if (rc) {
-			fprintf(stderr,
-				"pthread_join failed '%s': %s\n",
-				strerror(errno), fname);
-		} else if (retval) {
-			rc = -1;
-			fprintf(stderr,
-				"failed to sort ORC tables '%s': %s\n",
-				(char *)retval, fname);
-		}
-	}
-#endif
-
-#ifdef MCOUNT_SORT_ENABLED
-	if (mcount_sort_thread) {
-		void *retval = NULL;
-		/* wait for mcount sort done */
-		rc = pthread_join(mcount_sort_thread, &retval);
-		if (rc) {
-			fprintf(stderr,
-				"pthread_join failed '%s': %s\n",
-				strerror(errno), fname);
-		} else if (retval) {
-			rc = -1;
-			fprintf(stderr,
-				"failed to sort mcount '%s': %s\n",
-				(char *)retval, fname);
-		}
-	}
-#endif
-	return rc;
-}
-- 
2.45.2



