Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456252999BD
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394546AbgJZWgg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Oct 2020 18:36:36 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:27509 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394542AbgJZWgg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 18:36:36 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-UsC-xTOrPB23zdIPNFE0RA-1; Mon, 26 Oct 2020 18:36:30 -0400
X-MC-Unique: UsC-xTOrPB23zdIPNFE0RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C5A87505D;
        Mon, 26 Oct 2020 22:36:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A068F6EF50;
        Mon, 26 Oct 2020 22:36:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 2/3] btf_encoder: Change functions check due to broken dwarf
Date:   Mon, 26 Oct 2020 23:36:16 +0100
Message-Id: <20201026223617.2868431-3-jolsa@kernel.org>
In-Reply-To: <20201026223617.2868431-1-jolsa@kernel.org>
References: <20201026223617.2868431-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

They might be slightly superfluous together, but it's
better to be ready for another DWARF mishap.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++-
 elf_symtab.h  |   8 ++++
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2dd26c904039..99b9abe36993 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -26,6 +26,62 @@
  */
 #define KSYM_NAME_LEN 128
 
+struct elf_function {
+	const char *name;
+	bool generated;
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
+}
+
+static int config_function(struct btf_elf *btfe, GElf_Sym *sym)
+{
+	if (!elf_sym__is_function(sym))
+		return 0;
+	if (!elf_sym__value(sym))
+		return 0;
+
+	if (functions_cnt == functions_alloc) {
+		functions_alloc += 5000;
+		functions = realloc(functions, functions_alloc * sizeof(*functions));
+		if (!functions)
+			return -1;
+	}
+
+	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
+	functions_cnt++;
+	return 0;
+}
+
+static bool should_generate_func(const struct btf_elf *btfe, const char *name)
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
@@ -207,6 +263,7 @@ int btf_encoder__encode()
 		btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
 
 	err = btf_elf__encode(btfe, 0);
+	delete_functions();
 	btf_elf__delete(btfe);
 	btfe = NULL;
 
@@ -314,11 +371,16 @@ static int config(struct btf_elf *btfe, bool do_percpu_vars)
 
 	/* cache variables' addresses, preparing for searching in symtab. */
 	percpu_var_cnt = 0;
+	/* functions addresses */
+	functions_cnt = 0;
+	functions_alloc = 0;
 
 	/* search within symtab for percpu variables */
 	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
 		if (do_percpu_vars && config_percpu_var(btfe, &sym))
 			return -1;
+		if (config_function(btfe, &sym))
+			return -1;
 	}
 
 	if (do_percpu_vars) {
@@ -329,9 +391,25 @@ static int config(struct btf_elf *btfe, bool do_percpu_vars)
 			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
 	}
 
+	if (functions_cnt)
+		qsort(functions, functions_cnt, sizeof(functions[0]), functions_cmp);
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
@@ -407,7 +485,28 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
 
-		if (fn->declaration || !fn->external)
+		if (!fn->external)
+			continue;
+
+		/*
+		 * We need to generate just single BTF instance for the
+		 * function, while DWARF data contains multiple instances
+		 * of DW_TAG_subprogram tag.
+		 *
+		 * We can no longer rely on DW_AT_declaration tag.
+		 *  (see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060)
+		 *
+		 * We check following conditions in following calls:
+		 *   - argument names are defined
+		 *   - there's symbol and address defined for the function
+		 *   - function is generated only once
+		 *
+		 * They might be slightly superfluous together, but it's
+		 * better to be ready for another DWARF mishap.
+		 */
+		if (!has_arg_names(cu, &fn->proto))
+			continue;
+		if (!should_generate_func(btfe, function__name(fn, cu)))
 			continue;
 
 		btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
@@ -491,6 +590,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 out:
 	if (err) {
+		delete_functions();
 		btf_elf__delete(btfe);
 		btfe = NULL;
 	}
diff --git a/elf_symtab.h b/elf_symtab.h
index 359add69c8ab..094ec4683d01 100644
--- a/elf_symtab.h
+++ b/elf_symtab.h
@@ -63,6 +63,14 @@ static inline uint64_t elf_sym__value(const GElf_Sym *sym)
 	return sym->st_value;
 }
 
+static inline int elf_sym__is_function(const GElf_Sym *sym)
+{
+	return (elf_sym__type(sym) == STT_FUNC ||
+		elf_sym__type(sym) == STT_GNU_IFUNC) &&
+		sym->st_name != 0 &&
+		sym->st_shndx != SHN_UNDEF;
+}
+
 static inline bool elf_sym__is_local_function(const GElf_Sym *sym)
 {
 	return elf_sym__type(sym) == STT_FUNC &&
-- 
2.26.2

