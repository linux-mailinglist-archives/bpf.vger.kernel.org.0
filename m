Return-Path: <bpf+bounces-47768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5EB9FFF1D
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337101634AF
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7BE1BD9DE;
	Thu,  2 Jan 2025 18:59:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8511BD004;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844389; cv=none; b=IkXV5oZoClxPjhyJw81X5T83nNksgjvfNt02wrecRM5u3S7XdSPjEh9WcWYgQMf/QN0Q1KcF4KlvjdlcsIxM8yCMouc2M0N+5RfgH8rl2QdqRfeNVZYiv6gmieLzvXM+rj3wnEBUXzX/dKQEydDe2dvp9ItCM5AUkCc+UGoQUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844389; c=relaxed/simple;
	bh=tHEC0ICC/LaWxIAamB8V1GABfzWWMx6h1s7uZ/8Hi3A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=glFRNv36DckDwCvV+dyclUIQNpQbqo3ImaWJDPmRf0i76xOi1KfwlLxFYAaosmB78KnIJMb92VCuLi786eRAVkCiRchVQ+Vg2oNxXFIEqFgqYSPz7ptzJe07yEujG4y178BMqyToRmHrK/ck1eNuVkOu0fYwJ9EAllS/Z38MUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE3C4CEE7;
	Thu,  2 Jan 2025 18:59:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRN-00000005Mpq-2j1t;
	Thu, 02 Jan 2025 14:01:05 -0500
Message-ID: <20250102190105.506164167@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:59 -0500
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
Subject: [PATCH 14/14] scripts/sorttable: ftrace: Do not add weak functions to
 available_filter_functions
References: <20250102185845.928488650@goodmis.org>
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

On boot up, when the ftrace table is created from the mcount_loc section,
it will skip any address that matches kaslr_offset(). This stops the weak
functions from ever being added to the ftrace table and also keeps from
needing place holders in available_filter_functions.

Before:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 556

After:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 0

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c   |  14 +++++
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 131 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..5963ae76b31a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7077,6 +7077,20 @@ static int ftrace_process_locs(struct module *mod,
 			continue;
 		}
 
+		/*
+		 * At build time, a check is made against: nm -S vmlinux
+		 * to make sure all functions are found within the
+		 * size range of symbols listed by nm. If not, it's likely
+		 * a weak function that was overridden. We do not want those.
+		 * The script will zero them out, but kaslr will still
+		 * update them. If the address is the same as the kaslr_offset()
+		 * then skip the record.
+		 */
+		if (addr == kaslr_offset()) {
+			skipped++;
+			continue;
+		}
+
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
 			/* We should have allocated enough */
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d853ddb3b28c..976808c46665 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -177,12 +177,14 @@ mksysmap()
 
 sorttable()
 {
-	${objtree}/scripts/sorttable ${1}
+	${NM} -S ${1} > .tmp_vmlinux.nm-sort
+	${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}
 }
 
 cleanup()
 {
 	rm -f .btf.*
+	rm -f .tmp_vmlinux.nm-sort
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.map
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index da9e1a82e886..d1d52bd12adb 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -446,6 +446,98 @@ static void *sort_orctable(void *arg)
 #endif
 
 #ifdef MCOUNT_SORT_ENABLED
+struct func_info {
+	uint64_t	addr;
+	uint64_t	size;
+};
+
+/* List of functions created by: nm -S vmlinux */
+static struct func_info *function_list;
+static int function_list_size;
+
+/* Allocate functions in 1k blocks */
+#define FUNC_BLK_SIZE	1024
+#define FUNC_BLK_MASK	(FUNC_BLK_SIZE - 1)
+
+static int add_field(uint64_t addr, uint64_t size)
+{
+	struct func_info *fi;
+	int fsize = function_list_size;
+
+	if (!(fsize & FUNC_BLK_MASK)) {
+		fsize += FUNC_BLK_SIZE;
+		fi = realloc(function_list, fsize * sizeof(struct func_info));
+		if (!fi)
+			return -1;
+		function_list = fi;
+	}
+	fi = &function_list[function_list_size++];
+	fi->addr = addr;
+	fi->size = size;
+	return 0;
+}
+
+/* Only return match if the address lies inside the function size */
+static int cmp_func_addr(const void *K, const void *A)
+{
+	uint64_t key = *(const uint64_t *)K;
+	const struct func_info *a = A;
+
+	if (key < a->addr)
+		return -1;
+	return key >= a->addr + a->size;
+}
+
+/* Find the function in function list that is bounded by the function size */
+static int find_func(uint64_t key)
+{
+	return bsearch(&key, function_list, function_list_size,
+		       sizeof(struct func_info), cmp_func_addr) != NULL;
+}
+
+static int cmp_funcs(const void *A, const void *B)
+{
+	const struct func_info *a = A;
+	const struct func_info *b = B;
+
+	if (a->addr < b->addr)
+		return -1;
+	return a->addr > b->addr;
+}
+
+static int parse_symbols(const char *fname)
+{
+	FILE *fp;
+	char addr_str[20]; /* Only need 17, but round up to next int size */
+	char size_str[20];
+	char type;
+
+	fp = fopen(fname, "r");
+	if (!fp) {
+		perror(fname);
+		return -1;
+	}
+
+	while (fscanf(fp, "%16s %16s %c %*s\n", addr_str, size_str, &type) == 3) {
+		uint64_t addr;
+		uint64_t size;
+
+		/* Only care about functions */
+		if (type != 't' && type != 'T')
+			continue;
+
+		addr = strtoull(addr_str, NULL, 16);
+		size = strtoull(size_str, NULL, 16);
+		if (add_field(addr, size) < 0)
+			return -1;
+	}
+	fclose(fp);
+
+	qsort(function_list, function_list_size, sizeof(struct func_info), cmp_funcs);
+
+	return 0;
+}
+
 static pthread_t mcount_sort_thread;
 
 struct elf_mcount_loc {
@@ -464,6 +556,23 @@ static void *sort_mcount_loc(void *arg)
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 
+	/* zero out any locations not found by function list */
+	if (function_list_size) {
+		void *end_loc = start_loc + count;
+
+		for (void *ptr = start_loc; ptr < end_loc; ptr += long_size) {
+			uint64_t key;
+
+			key = long_size == 4 ? r((uint32_t *)ptr) : r8((uint64_t *)ptr);
+			if (!find_func(key)) {
+				if (long_size == 4)
+					*(uint32_t *)ptr = 0;
+				else
+					*(uint64_t *)ptr = 0;
+			}
+		}
+	}
+
 	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
 }
@@ -504,7 +613,10 @@ static void get_mcount_loc(uint64_t *_start, uint64_t *_stop)
 	pclose(file_start);
 	pclose(file_stop);
 }
+#else /* MCOUNT_SORT_ENABLED */
+static inline int parse_symbols(const char *fname) { return 0; }
 #endif
+
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
 		   table_sort_t custom_sort)
@@ -936,14 +1048,29 @@ int main(int argc, char *argv[])
 	int i, n_error = 0;  /* gcc-4.3.0 false positive complaint */
 	size_t size = 0;
 	void *addr = NULL;
+	int c;
+
+	while ((c = getopt(argc, argv, "s:")) >= 0) {
+		switch (c) {
+		case 's':
+			if (parse_symbols(optarg) < 0) {
+				fprintf(stderr, "Could not parse %s\n", optarg);
+				return -1;
+			}
+			break;
+		default:
+			fprintf(stderr, "usage: sorttable [-s nm-file] vmlinux...\n");
+			return 0;
+		}
+	}
 
-	if (argc < 2) {
+	if ((argc - optind) < 1) {
 		fprintf(stderr, "usage: sorttable vmlinux...\n");
 		return 0;
 	}
 
 	/* Process each file in turn, allowing deep failure. */
-	for (i = 1; i < argc; i++) {
+	for (i = optind; i < argc; i++) {
 		addr = mmap_file(argv[i], &size);
 		if (!addr) {
 			++n_error;
-- 
2.45.2



