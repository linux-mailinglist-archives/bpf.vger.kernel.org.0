Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17042AA058
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 23:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgKFWZh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 17:25:37 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:47107 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbgKFWZh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 17:25:37 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-tKEp-EO3NLi12jizeLG6pg-1; Fri, 06 Nov 2020 17:25:30 -0500
X-MC-Unique: tKEp-EO3NLi12jizeLG6pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FB10186DD21;
        Fri,  6 Nov 2020 22:25:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E01327512A;
        Fri,  6 Nov 2020 22:25:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 3/3] btf_encoder: Change functions check due to broken dwarf
Date:   Fri,  6 Nov 2020 23:25:12 +0100
Message-Id: <20201106222512.52454-4-jolsa@kernel.org>
In-Reply-To: <20201106222512.52454-1-jolsa@kernel.org>
References: <20201106222512.52454-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We need to generate just single BTF instance for the
function, while DWARF data contains multiple instances
of DW_TAG_subprogram tag.

Unfortunately we can no longer rely on DW_AT_declaration
tag (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)

Instead we apply following checks:
  - argument names are defined for the function
  - there's symbol and address defined for the function
  - function is generated only once

Also because we want to follow kernel's ftrace traceable
functions, this patchset is adding extra check that the
function is one of the ftrace's functions.

All ftrace functions addresses are stored in vmlinux
binary within symbols:
  __start_mcount_loc
  __stop_mcount_loc

During object preparation code we read those addresses,
sort them and use them as filter for all detected dwarf
functions.

We also filter out functions within .init section, ftrace
is doing that in runtime. At the same time we keep functions
from .init.bpf.preserve_type, because they are needed in BTF.

I can still see several differences to ftrace functions in
/sys/kernel/debug/tracing/available_filter_functions file:

  - available_filter_functions includes modules
  - available_filter_functions includes functions like:
      __acpi_match_device.part.0.constprop.0
      acpi_ns_check_sorted_list.constprop.0
      acpi_os_unmap_generic_address.part.0
      acpiphp_check_bridge.part.0

    which are not part of dwarf data
  - BTF includes multiple functions like:
      __clk_register_clkdev
      clk_register_clkdev

    which share same code so they appear just as single function
    in available_filter_functions, but dwarf keeps track of both
    of them

  - BTF includes iterator functions, which do not make it to
    available_filter_functions

With this change I'm getting 38384 BTF functions, which
when added above functions to consideration gives same
amount of functions in available_filter_functions.

The patch still keeps the original function filter condition
(that uses current fn->declaration check) in case the object
does not contain *_mcount_loc symbol -> object is not vmlinux.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 267 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1866bb16a8ba..9b93e9963727 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -26,6 +26,179 @@
  */
 #define KSYM_NAME_LEN 128
 
+struct funcs_layout {
+	unsigned long mcount_start;
+	unsigned long mcount_stop;
+	unsigned long init_begin;
+	unsigned long init_end;
+	unsigned long init_bpf_begin;
+	unsigned long init_bpf_end;
+	unsigned long mcount_sec_idx;
+};
+
+struct elf_function {
+	const char	*name;
+	unsigned long	 addr;
+	bool		 generated;
+};
+
+static struct elf_function *functions;
+static int functions_alloc;
+static int functions_cnt;
+
+static int functions_cmp(const void *_a, const void *_b)
+{
+	const struct elf_function *a = _a;
+	const struct elf_function *b = _b;
+
+	return strcmp(a->name, b->name);
+}
+
+static void delete_functions(void)
+{
+	free(functions);
+	functions_alloc = functions_cnt = 0;
+	functions = NULL;
+}
+
+#ifndef max
+#define max(x, y) ((x) < (y) ? (y) : (x))
+#endif
+
+static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
+{
+	struct elf_function *new;
+
+	if (elf_sym__type(sym) != STT_FUNC)
+		return 0;
+	if (!elf_sym__value(sym))
+		return 0;
+
+	if (functions_cnt == functions_alloc) {
+		functions_alloc = max(1000, functions_alloc * 3 / 2);
+		new = realloc(functions, functions_alloc * sizeof(*functions));
+		if (!new) {
+			/*
+			 * The cleanup - delete_functions is called
+			 * in cu__encode_btf error path.
+			 */
+			return -1;
+		}
+		functions = new;
+	}
+
+	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
+	functions[functions_cnt].addr = elf_sym__value(sym);
+	functions[functions_cnt].generated = false;
+	functions_cnt++;
+	return 0;
+}
+
+static int addrs_cmp(const void *_a, const void *_b)
+{
+	const unsigned long *a = _a;
+	const unsigned long *b = _b;
+
+	if (*a == *b)
+		return 0;
+	return *a < *b ? -1 : 1;
+}
+
+static bool is_init(struct funcs_layout *fl, unsigned long addr)
+{
+	return addr >= fl->init_begin && addr < fl->init_end;
+}
+
+static bool is_bpf_init(struct funcs_layout *fl, unsigned long addr)
+{
+	return addr >= fl->init_bpf_begin && addr < fl->init_bpf_end;
+}
+
+static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
+{
+	unsigned long *addrs, count, offset, i;
+	int functions_valid = 0;
+	Elf_Data *data;
+	GElf_Shdr shdr;
+	Elf_Scn *sec;
+
+	/*
+	 * Find mcount addressed marked by __start_mcount_loc
+	 * and __stop_mcount_loc symbols and load them into
+	 * sorted array.
+	 */
+	sec = elf_getscn(btfe->elf, fl->mcount_sec_idx);
+	if (!sec || !gelf_getshdr(sec, &shdr)) {
+		fprintf(stderr, "Failed to get section(%lu) header.\n",
+			fl->mcount_sec_idx);
+		return -1;
+	}
+
+	offset = fl->mcount_start - shdr.sh_addr;
+	count  = (fl->mcount_stop - fl->mcount_start) / 8;
+
+	data = elf_getdata(sec, 0);
+	if (!data) {
+		fprintf(stderr, "Failed to get section(%lu) data.\n",
+			fl->mcount_sec_idx);
+		return -1;
+	}
+
+	addrs = malloc(count * sizeof(addrs[0]));
+	if (!addrs) {
+		fprintf(stderr, "Failed to allocate memory for ftrace addresses.\n");
+		return -1;
+	}
+
+	memcpy(addrs, data->d_buf + offset, count * sizeof(addrs[0]));
+	qsort(addrs, count, sizeof(addrs[0]), addrs_cmp);
+
+	/*
+	 * Let's got through all collected functions and filter
+	 * out those that are not in ftrace and init code.
+	 */
+	for (i = 0; i < functions_cnt; i++) {
+		struct elf_function *func = &functions[i];
+
+		/*
+		 * Do not enable .init section functions,
+		 * but keep .init.bpf.preserve_type functions.
+		 */
+		if (is_init(fl, func->addr) && !is_bpf_init(fl, func->addr))
+			continue;
+
+		/* Make sure function is within ftrace addresses. */
+		if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
+			/*
+			 * We iterate over sorted array, so we can easily skip
+			 * not valid item and move following valid field into
+			 * its place, and still keep the 'new' array sorted.
+			 */
+			if (i != functions_valid)
+				functions[functions_valid] = functions[i];
+			functions_valid++;
+		}
+	}
+
+	functions_cnt = functions_valid;
+	free(addrs);
+	return 0;
+}
+
+static bool should_generate_function(const struct btf_elf *btfe, const char *name)
+{
+	struct elf_function *p;
+	struct elf_function key = { .name = name };
+
+	p = bsearch(&key, functions, functions_cnt,
+		    sizeof(functions[0]), functions_cmp);
+	if (!p || p->generated)
+		return false;
+
+	p->generated = true;
+	return true;
+}
+
 static bool btf_name_char_ok(char c, bool first)
 {
 	if (c == '_' || c == '.')
@@ -207,6 +380,7 @@ int btf_encoder__encode()
 		btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
 
 	err = btf_elf__encode(btfe, 0);
+	delete_functions();
 	btf_elf__delete(btfe);
 	btfe = NULL;
 
@@ -308,8 +482,45 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
 	return 0;
 }
 
+static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl)
+{
+	if (!fl->mcount_start &&
+	    !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
+		fl->mcount_start = sym->st_value;
+		fl->mcount_sec_idx = sym->st_shndx;
+	}
+
+	if (!fl->mcount_stop &&
+	    !strcmp("__stop_mcount_loc", elf_sym__name(sym, btfe->symtab)))
+		fl->mcount_stop = sym->st_value;
+
+	if (!fl->init_begin &&
+	    !strcmp("__init_begin", elf_sym__name(sym, btfe->symtab)))
+		fl->init_begin = sym->st_value;
+
+	if (!fl->init_end &&
+	    !strcmp("__init_end", elf_sym__name(sym, btfe->symtab)))
+		fl->init_end = sym->st_value;
+
+	if (!fl->init_bpf_begin &&
+	    !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
+		fl->init_bpf_begin = sym->st_value;
+
+	if (!fl->init_bpf_end &&
+	    !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
+		fl->init_bpf_end = sym->st_value;
+}
+
+static int has_all_symbols(struct funcs_layout *fl)
+{
+	return fl->mcount_start && fl->mcount_stop &&
+	       fl->init_begin && fl->init_end &&
+	       fl->init_bpf_begin && fl->init_bpf_end;
+}
+
 static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 {
+	struct funcs_layout fl = { };
 	uint32_t core_id;
 	GElf_Sym sym;
 
@@ -320,6 +531,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
 		if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
 			return -1;
+		if (collect_function(btfe, &sym))
+			return -1;
+		collect_symbol(&sym, &fl);
 	}
 
 	if (collect_percpu_vars) {
@@ -329,9 +543,37 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 		if (btf_elf__verbose)
 			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
+
+	if (functions_cnt && has_all_symbols(&fl)) {
+		qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
+		if (filter_functions(btfe, &fl)) {
+			fprintf(stderr, "Failed to filter dwarf functions\n");
+			return -1;
+		}
+		if (btf_elf__verbose)
+			printf("Found %d functions!\n", functions_cnt);
+	} else {
+		if (btf_elf__verbose)
+			printf("vmlinux not detected, falling back to dwarf data\n");
+		delete_functions();
+	}
+
 	return 0;
 }
 
+static bool has_arg_names(struct cu *cu, struct ftype *ftype)
+{
+	struct parameter *param;
+	const char *name;
+
+	ftype__for_each_parameter(ftype, param) {
+		name = dwarves__active_loader->strings__ptr(cu, param->name);
+		if (name == NULL)
+			return false;
+	}
+	return true;
+}
+
 int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		   bool skip_encoding_vars)
 {
@@ -357,7 +599,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!btfe)
 			return -1;
 
-		if (collect_symbols(btfe, !skip_encoding_vars))
+		err = collect_symbols(btfe, !skip_encoding_vars);
+		if (err)
 			goto out;
 
 		has_index_type = false;
@@ -407,8 +650,28 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
 
-		if (fn->declaration || !fn->external)
-			continue;
+		/*
+		 * The functions_cnt != 0 means we parsed all necessary
+		 * kernel symbols and we are using ftrace location filter
+		 * for functions. If it's not available keep the current
+		 * dwarf declaration check.
+		 */
+		if (functions_cnt) {
+			/*
+			 * We check following conditions:
+			 *   - argument names are defined
+			 *   - there's symbol and address defined for the function
+			 *   - function address belongs to ftrace locations
+			 *   - function is generated only once
+			 */
+			if (!has_arg_names(cu, &fn->proto))
+				continue;
+			if (!should_generate_function(btfe, function__name(fn, cu)))
+				continue;
+		} else {
+			if (fn->declaration || !fn->external)
+				continue;
+		}
 
 		btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
 		name = dwarves__active_loader->strings__ptr(cu, fn->name);
@@ -492,6 +755,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 out:
 	if (err) {
+		delete_functions();
 		btf_elf__delete(btfe);
 		btfe = NULL;
 	}
-- 
2.26.2

