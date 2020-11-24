Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B982C2CA9
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 17:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390324AbgKXQTg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 24 Nov 2020 11:19:36 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:56655 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390323AbgKXQTg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 11:19:36 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-VTPRAZ1sMRWcKpHXxpXljQ-1; Tue, 24 Nov 2020 11:19:29 -0500
X-MC-Unique: VTPRAZ1sMRWcKpHXxpXljQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAAB7107B45A;
        Tue, 24 Nov 2020 16:19:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 798DF1346D;
        Tue, 24 Nov 2020 16:19:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 2/2] btf_encoder: Detect kernel module ftrace addresses
Date:   Tue, 24 Nov 2020 17:19:19 +0100
Message-Id: <20201124161919.2152187-3-jolsa@kernel.org>
In-Reply-To: <20201124161919.2152187-1-jolsa@kernel.org>
References: <20201124161919.2152187-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support to detect kernel module dtrace addresses and use
it as filter for functions.

For kernel modules the ftrace addresses are stored in __mcount_loc
section. Adding the code that detects this section and reads
its data into array, which is then processed as filter by
current code.

There's one tricky point with kernel modules wrt Elf object,
which we get from dwfl_module_getelf function. This function
performs all possible relocations, including __mcount_loc
section.

So addrs array contains relocated values, which we need take
into account when we compare them to functions values which
are relative to their sections.

With this change for example for xfs.ko module in my kernel
config I'm getting slightly bigger number of functions:

  before: 2429, after: 2615

Because of the malfunction DWARF's declaration tag, the
'before' functions contain also functions that are not
part of the module. The 'after' functions contain only
functions that are traceable and part of xfs.ko.

Despite filtering out some declarations, this change
also adds static functions, hence the total number
of functions is bigger.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++--
 dutil.c       | 16 ++++++++++
 dutil.h       |  2 ++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 467c4657b2c0..e6114c10ad01 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -36,6 +36,7 @@ struct funcs_layout {
 struct elf_function {
 	const char	*name;
 	unsigned long	 addr;
+	unsigned long	 sh_addr;
 	bool		 generated;
 };
 
@@ -65,11 +66,11 @@ static void delete_functions(void)
 static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 {
 	struct elf_function *new;
+	static GElf_Shdr sh;
+	static int last_idx;
 
 	if (elf_sym__type(sym) != STT_FUNC)
 		return 0;
-	if (!elf_sym__value(sym))
-		return 0;
 
 	if (functions_cnt == functions_alloc) {
 		functions_alloc = max(1000, functions_alloc * 3 / 2);
@@ -84,8 +85,17 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 		functions = new;
 	}
 
+	if (elf_sym__section(sym) != last_idx) {
+		int idx = elf_sym__section(sym);
+
+		if (!elf_section_by_idx(btfe->elf, &sh, idx))
+			return 0;
+		last_idx = idx;
+	}
+
 	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
 	functions[functions_cnt].addr = elf_sym__value(sym);
+	functions[functions_cnt].sh_addr = sh.sh_addr;
 	functions[functions_cnt].generated = false;
 	functions_cnt++;
 	return 0;
@@ -146,10 +156,60 @@ static int get_vmlinux_addrs(struct btf_elf *btfe, struct funcs_layout *fl,
 	return 0;
 }
 
+static int
+get_kmod_addrs(struct btf_elf *btfe, unsigned long **paddrs, unsigned long *pcount)
+{
+	unsigned long *addrs, count;
+	GElf_Shdr shdr_mcount;
+	Elf_Data *data;
+	Elf_Scn *sec;
+
+	/* get __mcount_loc */
+	sec = elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr_mcount,
+				  "__mcount_loc", NULL);
+	if (!sec) {
+		if (btf_elf__verbose) {
+			printf("%s: '%s' doesn't have __mcount_loc section\n", __func__,
+			       btfe->filename);
+		}
+		return 0;
+	}
+
+	data = elf_getdata(sec, NULL);
+	if (!data) {
+		fprintf(stderr, "Failed to data for __mcount_loc section.\n");
+		return -1;
+	}
+
+	addrs = malloc(data->d_size);
+	if (!addrs) {
+		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
+		return -1;
+	}
+
+	count = data->d_size / sizeof(unsigned long);
+	memcpy(addrs, data->d_buf, data->d_size);
+
+	/*
+	 * We get Elf object from dwfl_module_getelf function,
+	 * which performs all possible relocations, including
+	 * __mcount_loc section.
+	 *
+	 * So addrs array now contains relocated values, which
+	 * we need take into account when we compare them to
+	 * functions values, see comment in setup_functions
+	 * function.
+	 */
+	*paddrs = addrs;
+	*pcount = count;
+	return 0;
+}
+
 static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 {
 	unsigned long *addrs = NULL, count, i;
 	int functions_valid = 0;
+	bool kmod = false;
 
 	/*
 	 * Check if we are processing vmlinux image and
@@ -158,6 +218,16 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 	if (get_vmlinux_addrs(btfe, fl, &addrs, &count))
 		return -1;
 
+	/*
+	 * Check if we are processing kernel module and
+	 * get mcount data if it's detected.
+	 */
+	if (!addrs) {
+		if (get_kmod_addrs(btfe, &addrs, &count))
+			return -1;
+		kmod = true;
+	}
+
 	if (!addrs) {
 		if (btf_elf__verbose)
 			printf("ftrace symbols not detected, falling back to DWARF data\n");
@@ -174,9 +244,18 @@ static int setup_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 	 */
 	for (i = 0; i < functions_cnt; i++) {
 		struct elf_function *func = &functions[i];
+		/*
+		 * For vmlinux image both addrs[x] and functions[x]::addr
+		 * values are final address and are comparable.
+		 *
+		 * For kernel module addrs[x] is final address, but
+		 * functions[x]::addr is relative address within section
+		 * and needs to be relocated by adding sh_addr.
+		 */
+		unsigned long addr = kmod ? func->addr + func->sh_addr : func->addr;
 
 		/* Make sure function is within ftrace addresses. */
-		if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
+		if (bsearch(&addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
 			/*
 			 * We iterate over sorted array, so we can easily skip
 			 * not valid item and move following valid field into
diff --git a/dutil.c b/dutil.c
index f7b853f0660d..5ebbd2f9c84c 100644
--- a/dutil.c
+++ b/dutil.c
@@ -196,6 +196,22 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	return sec;
 }
 
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx)
+{
+	Elf_Scn *sec = NULL;
+	size_t cnt = 1;
+
+	while ((sec = elf_nextscn(elf, sec)) != NULL) {
+		if (cnt == idx) {
+			gelf_getshdr(sec, shp);
+			return sec;
+		}
+		++cnt;
+	}
+
+	return NULL;
+}
+
 char *strlwr(char *s)
 {
 	int len = strlen(s), i;
diff --git a/dutil.h b/dutil.h
index 676770d5d5c9..0838dff2d679 100644
--- a/dutil.h
+++ b/dutil.h
@@ -324,6 +324,8 @@ void *zalloc(const size_t size);
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *index);
 
+Elf_Scn *elf_section_by_idx(Elf *elf, GElf_Shdr *shp, int idx);
+
 #ifndef SHT_GNU_ATTRIBUTES
 /* Just a way to check if we're using an old elfutils version */
 static inline int elf_getshdrstrndx(Elf *elf, size_t *dst)
-- 
2.26.2

