Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9F2B3134
	for <lists+bpf@lfdr.de>; Sat, 14 Nov 2020 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKNWjG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 14 Nov 2020 17:39:06 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:60005 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgKNWjG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Nov 2020 17:39:06 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-wDa5WIIGPpSWXgb2TRZe7A-1; Sat, 14 Nov 2020 17:39:01 -0500
X-MC-Unique: wDa5WIIGPpSWXgb2TRZe7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4BB61074649;
        Sat, 14 Nov 2020 22:38:59 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24A726EF56;
        Sat, 14 Nov 2020 22:38:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 1/2] btf_encoder: Generate also .init functions
Date:   Sat, 14 Nov 2020 23:38:52 +0100
Message-Id: <20201114223853.1010900-2-jolsa@kernel.org>
In-Reply-To: <20201114223853.1010900-1-jolsa@kernel.org>
References: <20201114223853.1010900-1-jolsa@kernel.org>
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

Currently we skip functions under .init* sections, Removing the .init*
section check, BTF now contains also functions from .init* sections.

Andrii's explanation from email:

> ...                  I think we should just drop the __init check and
> include all the __init functions into BTF. There could be cases where
> we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> security cases), so having BTFs for those FUNCs are necessary as well.
> Ftrace currently disallows that, but it's only because no user-space
> application has a way to attach probes early enough. This might change
> in the future, so there is no need to invent special mechanisms now
> for bpf_iter function preservation. Let's just include all __init
> functions in BTF.

It's over ~2000 functions on my .config:

   $ bpftool btf dump file ./vmlinux | grep 'FUNC ' | wc -l
   41505
   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep 'FUNC ' | wc -l
   39256

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 btf_encoder.c | 43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9b93e9963727..d531651b1e9e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -29,10 +29,6 @@
 struct funcs_layout {
 	unsigned long mcount_start;
 	unsigned long mcount_stop;
-	unsigned long init_begin;
-	unsigned long init_end;
-	unsigned long init_bpf_begin;
-	unsigned long init_bpf_end;
 	unsigned long mcount_sec_idx;
 };
 
@@ -104,16 +100,6 @@ static int addrs_cmp(const void *_a, const void *_b)
 	return *a < *b ? -1 : 1;
 }
 
-static bool is_init(struct funcs_layout *fl, unsigned long addr)
-{
-	return addr >= fl->init_begin && addr < fl->init_end;
-}
-
-static bool is_bpf_init(struct funcs_layout *fl, unsigned long addr)
-{
-	return addr >= fl->init_bpf_begin && addr < fl->init_bpf_end;
-}
-
 static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 {
 	unsigned long *addrs, count, offset, i;
@@ -155,18 +141,11 @@ static int filter_functions(struct btf_elf *btfe, struct funcs_layout *fl)
 
 	/*
 	 * Let's got through all collected functions and filter
-	 * out those that are not in ftrace and init code.
+	 * out those that are not in ftrace.
 	 */
 	for (i = 0; i < functions_cnt; i++) {
 		struct elf_function *func = &functions[i];
 
-		/*
-		 * Do not enable .init section functions,
-		 * but keep .init.bpf.preserve_type functions.
-		 */
-		if (is_init(fl, func->addr) && !is_bpf_init(fl, func->addr))
-			continue;
-
 		/* Make sure function is within ftrace addresses. */
 		if (bsearch(&func->addr, addrs, count, sizeof(addrs[0]), addrs_cmp)) {
 			/*
@@ -493,29 +472,11 @@ static void collect_symbol(GElf_Sym *sym, struct funcs_layout *fl)
 	if (!fl->mcount_stop &&
 	    !strcmp("__stop_mcount_loc", elf_sym__name(sym, btfe->symtab)))
 		fl->mcount_stop = sym->st_value;
-
-	if (!fl->init_begin &&
-	    !strcmp("__init_begin", elf_sym__name(sym, btfe->symtab)))
-		fl->init_begin = sym->st_value;
-
-	if (!fl->init_end &&
-	    !strcmp("__init_end", elf_sym__name(sym, btfe->symtab)))
-		fl->init_end = sym->st_value;
-
-	if (!fl->init_bpf_begin &&
-	    !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
-		fl->init_bpf_begin = sym->st_value;
-
-	if (!fl->init_bpf_end &&
-	    !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
-		fl->init_bpf_end = sym->st_value;
 }
 
 static int has_all_symbols(struct funcs_layout *fl)
 {
-	return fl->mcount_start && fl->mcount_stop &&
-	       fl->init_begin && fl->init_end &&
-	       fl->init_bpf_begin && fl->init_bpf_end;
+	return fl->mcount_start && fl->mcount_stop;
 }
 
 static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
-- 
2.26.2

