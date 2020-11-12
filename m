Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2552B0817
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgKLPFW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 Nov 2020 10:05:22 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:28332 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbgKLPFV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 10:05:21 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-FjoNWsRvNSW_QmNotb_lTg-1; Thu, 12 Nov 2020 10:05:17 -0500
X-MC-Unique: FjoNWsRvNSW_QmNotb_lTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A6310866AD;
        Thu, 12 Nov 2020 15:05:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D4D60C0F;
        Thu, 12 Nov 2020 15:05:13 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC/PATCH 3/3] btf_encoder: Func generation fix
Date:   Thu, 12 Nov 2020 16:05:06 +0100
Message-Id: <20201112150506.705430-4-jolsa@kernel.org>
In-Reply-To: <20201112150506.705430-1-jolsa@kernel.org>
References: <20201112150506.705430-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recent btf encoder's changes brakes BTF data for some gcc versions.

The problem is that some functions can appear in dwarf data in some
instances without arguments, while they are defined with some.

Current code will record 'no arguments' for such functions and they
disregard the rest of the DWARF data claiming otherwise.

This patch changes the BTF function generation, so that in the main
cu__encode_btf processing we do not generate any BTF function code,
but only collect functions 'to generate' and update their arguments.

When we process the whole data, we go through the functions and
generate its BTD data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 110 +++++++++++++++++++++++++++++++++-----------------
 pahole.c      |   2 +-
 2 files changed, 73 insertions(+), 39 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index efc4f48dbc5a..46cb7e6f5abe 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -35,7 +35,10 @@ struct funcs_layout {
 struct elf_function {
 	const char	*name;
 	unsigned long	 addr;
-	bool		 generated;
+	struct cu	*cu;
+	struct function *fn;
+	int		 args_cnt;
+	uint32_t	 type_id_off;
 };
 
 static struct elf_function *functions;
@@ -64,6 +67,7 @@ static void delete_functions(void)
 static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 {
 	struct elf_function *new;
+	char *name;
 
 	if (elf_sym__type(sym) != STT_FUNC)
 		return 0;
@@ -83,9 +87,20 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
 		functions = new;
 	}
 
-	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
+	/*
+	 * At the time we process functions,
+	 * elf object might be already released.
+	 */
+	name = strdup(elf_sym__name(sym, btfe->symtab));
+	if (!name)
+		return -1;
+
+	functions[functions_cnt].name = name;
 	functions[functions_cnt].addr = elf_sym__value(sym);
-	functions[functions_cnt].generated = false;
+	functions[functions_cnt].fn = NULL;
+	functions[functions_cnt].cu = NULL;
+	functions[functions_cnt].args_cnt = 0;
+	functions[functions_cnt].type_id_off = 0;
 	functions_cnt++;
 	return 0;
 }
@@ -164,20 +179,6 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 	return 0;
 }
 
-static bool should_generate_function(const struct btf_elf *btfe, const char *name)
-{
-	struct elf_function *p;
-	struct elf_function key = { .name = name };
-
-	p = bsearch(&key, functions, functions_cnt,
-		    sizeof(functions[0]), functions_cmp);
-	if (!p || p->generated)
-		return false;
-
-	p->generated = true;
-	return true;
-}
-
 static bool btf_name_char_ok(char c, bool first)
 {
 	if (c == '_' || c == '.')
@@ -368,6 +369,21 @@ static int generate_func(struct btf_elf *btfe, struct cu *cu,
 	return err;
 }
 
+static int process_functions(struct btf_elf *btfe)
+{
+	unsigned long i;
+
+	for (i = 0; i < functions_cnt; i++) {
+		struct elf_function *func = &functions[i];
+
+		if (!func->fn)
+			continue;
+		if (generate_func(btfe, func->cu, func->fn, func->type_id_off))
+			return -1;
+	}
+	return 0;
+}
+
 int btf_encoder__encode()
 {
 	int err;
@@ -375,7 +391,9 @@ int btf_encoder__encode()
 	if (gobuffer__size(&btfe->percpu_secinfo) != 0)
 		btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
 
-	err = btf_elf__encode(btfe, 0);
+	err = process_functions(btfe);
+	if (!err)
+		err = btf_elf__encode(btfe, 0);
 	delete_functions();
 	btf_elf__delete(btfe);
 	btfe = NULL;
@@ -539,15 +557,17 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
 	return 0;
 }
 
-static bool has_arg_names(struct cu *cu, struct ftype *ftype)
+static bool has_arg_names(struct cu *cu, struct ftype *ftype, int *args_cnt)
 {
 	struct parameter *param;
 	const char *name;
 
+	*args_cnt = 0;
 	ftype__for_each_parameter(ftype, param) {
 		name = dwarves__active_loader->strings__ptr(cu, param->name);
 		if (name == NULL)
 			return false;
+		++*args_cnt;
 	}
 	return true;
 }
@@ -624,32 +644,46 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		has_index_type = true;
 	}
 
-	cu__for_each_function(cu, core_id, fn) {
-		/*
-		 * The functions_cnt != 0 means we parsed all necessary
-		 * kernel symbols and we are using ftrace location filter
-		 * for functions. If it's not available keep the current
-		 * dwarf declaration check.
-		 */
-		if (functions_cnt) {
+	/*
+	 * The functions_cnt != 0 means we parsed all necessary
+	 * kernel symbols and we are using ftrace location filter
+	 * for functions. If it's not available keep the current
+	 * dwarf declaration check.
+	 */
+	if (functions_cnt) {
+		cu__for_each_function(cu, core_id, fn) {
+			struct elf_function *p;
+			struct elf_function key = { .name = function__name(fn, cu) };
+			int args_cnt = 0;
+
 			/*
-			 * We check following conditions:
-			 *   - argument names are defined
-			 *   - there's symbol and address defined for the function
-			 *   - function address belongs to ftrace locations
-			 *   - function is generated only once
+			 * Collect functions that match ftrace filter
+			 * and pick the one with proper argument names.
+			 * The BTF generation happens at the end in
+			 * btf_encoder__encode function.
 			 */
-			if (!has_arg_names(cu, &fn->proto))
+			p = bsearch(&key, functions, functions_cnt,
+				    sizeof(functions[0]), functions_cmp);
+			if (!p)
 				continue;
-			if (!should_generate_function(btfe, function__name(fn, cu)))
+
+			if (!has_arg_names(cu, &fn->proto, &args_cnt))
 				continue;
-		} else {
+
+			if (!p->fn || args_cnt > p->args_cnt) {
+				p->fn = fn;
+				p->cu = cu;
+				p->args_cnt = args_cnt;
+				p->type_id_off = type_id_off;
+			}
+		}
+	} else {
+		cu__for_each_function(cu, core_id, fn) {
 			if (fn->declaration || !fn->external)
 				continue;
+			if (generate_func(btfe, cu, fn, type_id_off))
+				goto out;
 		}
-
-		if (generate_func(btfe, cu, fn, type_id_off))
-			goto out;
 	}
 
 	if (skip_encoding_vars)
diff --git a/pahole.c b/pahole.c
index fca27148e0bb..d6165d4164dd 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2392,7 +2392,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
-		return LSK__DELETE;
+		return LSK__KEEPIT;
 	}
 
 	if (ctf_encode) {
-- 
2.26.2

