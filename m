Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9DE2A1B0E
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 23:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgJaWbv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 31 Oct 2020 18:31:51 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:37964 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgJaWbv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 31 Oct 2020 18:31:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-KZ_-yXp9NV2fi2_pL48x6A-1; Sat, 31 Oct 2020 18:31:45 -0400
X-MC-Unique: KZ_-yXp9NV2fi2_pL48x6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B97C879515;
        Sat, 31 Oct 2020 22:31:43 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 698395B4D2;
        Sat, 31 Oct 2020 22:31:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 2/2] btf_encoder: Change functions check due to broken dwarf
Date:   Sat, 31 Oct 2020 23:31:31 +0100
Message-Id: <20201031223131.3398153-3-jolsa@kernel.org>
In-Reply-To: <20201031223131.3398153-1-jolsa@kernel.org>
References: <20201031223131.3398153-1-jolsa@kernel.org>
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
is doing that in runtime.

I can still see several differences to ftrace functions in
/sys/kernel/debug/tracing/available_filter_functions file:

  - available_filter_functions includes modules (7086 functions)
  - available_filter_functions includes functions like:
      __acpi_match_device.part.0.constprop.0
      acpi_ns_check_sorted_list.constprop.0
      acpi_os_unmap_generic_address.part.0
      acpiphp_check_bridge.part.0

    which are not part of dwarf data (1164 functions)
  - BTF includes multiple functions like:
      __clk_register_clkdev
      clk_register_clkdev

    which share same code so they appear just as single function
    in available_filter_functions, but dwarf keeps track of both
    of them (16 functions)

With this change I'm getting 38334 BTF functions, which
when added above functions to consideration gives same
amount of functions in available_filter_functions.

The patch still keeps the original function filter condition
(that uses current fn->declaration check) in case the object
does not contain *_mcount_loc symbol -> object is not vmlinux.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1866bb16a8ba..0a378aa92142 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -26,6 +26,151 @@
  */
 #define KSYM_NAME_LEN 128
 
+struct mcount_symbols {
+	unsigned long start;
+	unsigned long stop;
+	unsigned long init_begin;
+	unsigned long init_end;
+	unsigned long start_section;
+};
+
+struct elf_function {
+	const char	*name;
+	unsigned long	 addr;
+	bool		 generated;
+	bool		 valid;
+};
+
+static struct elf_function *functions;
+static int functions_alloc;
+static int functions_cnt;
+static int functions_valid;
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
+	functions_alloc = functions_cnt = functions_valid = 0;
+}
+
+#ifndef max
+# define max(x, y) ((x) < (y) ? (y) : (x))
+#endif
+
+static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
+{
+	if (elf_sym__type(sym) != STT_FUNC)
+		return 0;
+	if (!elf_sym__value(sym))
+		return 0;
+
+	if (functions_cnt == functions_alloc) {
+		functions_alloc = max(1000, functions_alloc * 3 / 2);
+		functions = realloc(functions, functions_alloc * sizeof(*functions));
+		if (!functions)
+			return -1;
+	}
+
+	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
+	functions[functions_cnt].addr = elf_sym__value(sym);
+	functions[functions_cnt].generated = false;
+	functions[functions_cnt].valid = false;
+	functions_cnt++;
+	return 0;
+}
+
+static int addrs_cmp(const void *_a, const void *_b)
+{
+	const unsigned long *a = _a;
+	const unsigned long *b = _b;
+
+	return *a - *b;
+}
+
+static int filter_functions(struct btf_elf *btfe, struct mcount_symbols *ms)
+{
+	bool init_filter = ms->init_begin && ms->init_end;
+	unsigned long *addrs, count, offset, i;
+	Elf_Data *data;
+	GElf_Shdr shdr;
+	Elf_Scn *sec;
+
+	/*
+	 * Find mcount addressed marked by __start_mcount_loc
+	 * and __stop_mcount_loc symbols and load them into
+	 * sorted array.
+	 */
+	sec = elf_getscn(btfe->elf, ms->start_section);
+	if (!sec || !gelf_getshdr(sec, &shdr)) {
+		fprintf(stderr, "Failed to get section(%lu) header.\n",
+			ms->start_section);
+		return -1;
+	}
+
+	offset = ms->start - shdr.sh_addr;
+	count  = (ms->stop - ms->start) / 8;
+
+	data = elf_getdata(sec, 0);
+	if (!data) {
+		fprintf(stderr, "Failed to section(%lu) data.\n",
+			ms->start_section);
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
+		/* Do not enable .init section functions. */
+		if (init_filter &&
+		    func->addr >= ms->init_begin &&
+		    func->addr <  ms->init_end)
+			continue;
+
+		/* Make sure function is within mcount addresses. */
+		if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
+			functions_valid++;
+			func->valid = true;
+		}
+	}
+
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
+	if (!p || !p->valid || p->generated)
+		return false;
+
+	p->generated = true;
+	return true;
+}
+
 static bool btf_name_char_ok(char c, bool first)
 {
 	if (c == '_' || c == '.')
@@ -207,6 +352,7 @@ int btf_encoder__encode()
 		btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
 
 	err = btf_elf__encode(btfe, 0);
+	delete_functions();
 	btf_elf__delete(btfe);
 	btfe = NULL;
 
@@ -308,8 +454,27 @@ static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
 	return 0;
 }
 
+#define SET_SYMBOL(__sym, __var)						\
+	if (!ms->__var && !strcmp(__sym, elf_sym__name(sym, btfe->symtab)))	\
+		ms->__var = sym->st_value;					\
+
+static void collect_mcount_symbol(GElf_Sym *sym, struct mcount_symbols *ms)
+{
+	if (!ms->start &&
+	    !strcmp("__start_mcount_loc", elf_sym__name(sym, btfe->symtab))) {
+		ms->start = sym->st_value;
+		ms->start_section = sym->st_shndx;
+	}
+	SET_SYMBOL("__stop_mcount_loc", stop)
+	SET_SYMBOL("__init_begin", init_begin)
+	SET_SYMBOL("__init_end", init_end)
+}
+
+#undef SET_SYMBOL
+
 static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 {
+	struct mcount_symbols ms = { };
 	uint32_t core_id;
 	GElf_Sym sym;
 
@@ -320,6 +485,9 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
 		if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
 			return -1;
+		if (collect_function(btfe, &sym))
+			return -1;
+		collect_mcount_symbol(&sym, &ms);
 	}
 
 	if (collect_percpu_vars) {
@@ -329,9 +497,34 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 		if (btf_elf__verbose)
 			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
+
+	if (functions_cnt) {
+		qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
+		if (ms.start && ms.stop &&
+		    filter_functions(btfe, &ms)) {
+			fprintf(stderr, "Failed to filter dwarf functions\n");
+			return -1;
+		}
+		if (btf_elf__verbose)
+			printf("Found %d functions!\n", functions_valid);
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
@@ -407,8 +600,32 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
 
-		if (fn->declaration || !fn->external)
-			continue;
+		/*
+		 * The functions_valid != 0 means we parsed all necessary
+		 * kernel symbols and we are using mcount location filter
+		 * for functions. If it's not available keep the current
+		 * dwarf declaration check.
+		 */
+		if (functions_valid) {
+			/*
+			 * We need to generate just single BTF instance for the
+			 * function, while DWARF data contains multiple instances
+			 * of DW_TAG_subprogram tag.
+			 *
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
@@ -492,6 +709,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 out:
 	if (err) {
+		delete_functions();
 		btf_elf__delete(btfe);
 		btfe = NULL;
 	}
-- 
2.26.2

