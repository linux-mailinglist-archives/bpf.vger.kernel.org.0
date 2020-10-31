Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFB2A1B0D
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 23:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJaWbr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 31 Oct 2020 18:31:47 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:30542 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgJaWbq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 31 Oct 2020 18:31:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-1haZIE5wPSmyLyCvS_t6Lg-1; Sat, 31 Oct 2020 18:31:42 -0400
X-MC-Unique: 1haZIE5wPSmyLyCvS_t6Lg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DA4B1084D62;
        Sat, 31 Oct 2020 22:31:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D137C6F142;
        Sat, 31 Oct 2020 22:31:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCH 1/2] btf_encoder: Move find_all_percpu_vars in generic collect_symbols
Date:   Sat, 31 Oct 2020 23:31:30 +0100
Message-Id: <20201031223131.3398153-2-jolsa@kernel.org>
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

Moving find_all_percpu_vars under generic collect_symbols
function that walks over symbols and calls collect_percpu_var.

We will add another collect function that needs to go through
all the symbols, so it's better we go through them just once.

There's no functional change intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 124 +++++++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 57 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4c92908beab2..1866bb16a8ba 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -250,75 +250,85 @@ static bool percpu_var_exists(uint64_t addr, uint32_t *sz, const char **name)
 	return true;
 }
 
-static int find_all_percpu_vars(struct btf_elf *btfe)
+static int collect_percpu_var(struct btf_elf *btfe, GElf_Sym *sym)
 {
-	uint32_t core_id;
-	GElf_Sym sym;
+	const char *sym_name;
+	uint64_t addr;
+	uint32_t size;
 
-	/* cache variables' addresses, preparing for searching in symtab. */
-	percpu_var_cnt = 0;
+	/* compare a symbol's shndx to determine if it's a percpu variable */
+	if (elf_sym__section(sym) != btfe->percpu_shndx)
+		return 0;
+	if (elf_sym__type(sym) != STT_OBJECT)
+		return 0;
 
-	/* search within symtab for percpu variables */
-	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
-		const char *sym_name;
-		uint64_t addr;
-		uint32_t size;
+	addr = elf_sym__value(sym);
+	/*
+	 * Store only those symbols that have allocated space in the percpu section.
+	 * This excludes the following three types of symbols:
+	 *
+	 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
+	 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
+	 *  3. __exitcall(fn), functions which are labeled as exit calls.
+	 *
+	 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
+	 * also not included, which currently includes:
+	 *
+	 *  1. fixed_percpu_data
+	 */
+	if (!addr)
+		return 0;
 
-		/* compare a symbol's shndx to determine if it's a percpu variable */
-		if (elf_sym__section(&sym) != btfe->percpu_shndx)
-			continue;
-		if (elf_sym__type(&sym) != STT_OBJECT)
-			continue;
+	size = elf_sym__size(sym);
+	if (!size)
+		return 0; /* ignore zero-sized symbols */
 
-		addr = elf_sym__value(&sym);
-		/*
-		 * Store only those symbols that have allocated space in the percpu section.
-		 * This excludes the following three types of symbols:
-		 *
-		 *  1. __ADDRESSABLE(sym), which are forcely emitted as symbols.
-		 *  2. __UNIQUE_ID(prefix), which are introduced to generate unique ids.
-		 *  3. __exitcall(fn), functions which are labeled as exit calls.
-		 *
-		 * In addition, the variables defined using DEFINE_PERCPU_FIRST are
-		 * also not included, which currently includes:
-		 *
-		 *  1. fixed_percpu_data
-		 */
-		if (!addr)
-			continue;
+	sym_name = elf_sym__name(sym, btfe->symtab);
+	if (!btf_name_valid(sym_name)) {
+		dump_invalid_symbol("Found symbol of invalid name when encoding btf",
+				    sym_name, btf_elf__verbose, btf_elf__force);
+		if (btf_elf__force)
+			return 0;
+		return -1;
+	}
 
-		size = elf_sym__size(&sym);
-		if (!size)
-			continue; /* ignore zero-sized symbols */
+	if (btf_elf__verbose)
+		printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
 
-		sym_name = elf_sym__name(&sym, btfe->symtab);
-		if (!btf_name_valid(sym_name)) {
-			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
-					    sym_name, btf_elf__verbose, btf_elf__force);
-			if (btf_elf__force)
-				continue;
-			return -1;
-		}
+	if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
+		fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
+			MAX_PERCPU_VAR_CNT);
+		return -1;
+	}
+	percpu_vars[percpu_var_cnt].addr = addr;
+	percpu_vars[percpu_var_cnt].sz = size;
+	percpu_vars[percpu_var_cnt].name = sym_name;
+	percpu_var_cnt++;
 
-		if (btf_elf__verbose)
-			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
+	return 0;
+}
+
+static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
+{
+	uint32_t core_id;
+	GElf_Sym sym;
 
-		if (percpu_var_cnt == MAX_PERCPU_VAR_CNT) {
-			fprintf(stderr, "Reached the limit of per-CPU variables: %d\n",
-				MAX_PERCPU_VAR_CNT);
+	/* cache variables' addresses, preparing for searching in symtab. */
+	percpu_var_cnt = 0;
+
+	/* search within symtab for percpu variables */
+	elf_symtab__for_each_symbol(btfe->symtab, core_id, sym) {
+		if (collect_percpu_vars && collect_percpu_var(btfe, &sym))
 			return -1;
-		}
-		percpu_vars[percpu_var_cnt].addr = addr;
-		percpu_vars[percpu_var_cnt].sz = size;
-		percpu_vars[percpu_var_cnt].name = sym_name;
-		percpu_var_cnt++;
 	}
 
-	if (percpu_var_cnt)
-		qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
+	if (collect_percpu_vars) {
+		if (percpu_var_cnt)
+			qsort(percpu_vars, percpu_var_cnt, sizeof(percpu_vars[0]), percpu_var_cmp);
 
-	if (btf_elf__verbose)
-		printf("Found %d per-CPU variables!\n", percpu_var_cnt);
+		if (btf_elf__verbose)
+			printf("Found %d per-CPU variables!\n", percpu_var_cnt);
+	}
 	return 0;
 }
 
@@ -347,7 +357,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!btfe)
 			return -1;
 
-		if (!skip_encoding_vars && find_all_percpu_vars(btfe))
+		if (collect_symbols(btfe, !skip_encoding_vars))
 			goto out;
 
 		has_index_type = false;
-- 
2.26.2

