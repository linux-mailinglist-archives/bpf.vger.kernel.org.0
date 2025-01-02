Return-Path: <bpf+bounces-47808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F8A001AE
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087653A42A2
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05981C3C05;
	Thu,  2 Jan 2025 23:25:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61C1C2335;
	Thu,  2 Jan 2025 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860334; cv=none; b=mvkimj42Vx/b2WaqVxwm5FFF1kyq4qUD6JGZ5GYdoMtygDbOvHqI1c1S67V1gQflpjHOd5xgNldmVl2B7oNbAhiFVFSmYYVh5HzHetD6y68Z5d4tuwjBDJ7fviCBnRQ80iLr/3GoI9dzAzKsPRnzWJciJCZS2ioElEpp2BdCTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860334; c=relaxed/simple;
	bh=BDb0Sreoy9rBRdj+OjLgmVqqmdKxyy8n159KbqO39WA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FWJIR2GN+lM21QcvEGMYAZ+EMTXIxnbN69/jqKs0zD7rsajrOvd188pqusK2rAI04W44ohWeYoAd/3+wjLrYXrwZ2gq9lFf7y4WY+BZZuCPgzix82hlzRNYYA5rHZHIQXygVD1NyiK4Y9GB6ZAlsUd1QmYdIY49D4L75TmkYeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E7EC4CEE3;
	Thu,  2 Jan 2025 23:25:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTUaZ-00000005YyL-1Mxe;
	Thu, 02 Jan 2025 18:26:51 -0500
Message-ID: <20250102232651.173687711@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 18:26:24 -0500
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
Subject: [PATCH v2 15/16] scripts/sorttable: Zero out weak functions in mcount_loc table
References: <20250102232609.529842248@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In preparation for removing weak functions from available_filter_functions,
have the sorttable.c code that sorts the mcount regions during the build
modified to take a "nm -S vmlinux" as input, sort it, and any function
listed in the mcount_loc section that is not within a boundary of the
function list given by nm is considered a weak function and is zeroed out.
This will move them all to the beginning of the mcount_loc section. This
will allow for the ftrace code to be able to skip them in one go.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 129 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 3 deletions(-)

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
index c26e71e6ec6b..1a2b420a4929 100644
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
@@ -463,6 +555,22 @@ static void *sort_mcount_loc(void *arg)
 					+ shdr_offset(emloc->init_data_sec);
 	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
+	void *end_loc = start_loc + count;
+
+	/* zero out any locations not found by function list */
+	if (function_list_size) {
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
 
 	qsort(start_loc, count/long_size, long_size, compare_extable);
 	return NULL;
@@ -502,6 +610,8 @@ static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
 		return;
 	}
 }
+#else /* MCOUNT_SORT_ENABLED */
+static inline int parse_symbols(const char *fname) { return 0; }
 #endif
 
 static int do_sort(Elf_Ehdr *ehdr,
@@ -930,14 +1040,29 @@ int main(int argc, char *argv[])
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



