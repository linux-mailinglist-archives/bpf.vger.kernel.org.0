Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEEC297821
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750590AbgJWURW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 16:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750409AbgJWURW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Oct 2020 16:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603484240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SA5JQ46kCigAVjsj+eOrE0/uNXvQiWdJkSJpr5x9y88=;
        b=bBuvtRvO7d2Ha4fB61nQw5p4TTvByPfyhgyHypITfQ/v6E6mCveV2BpHiNDEan22GpVDck
        Fu3ONgt5U4FO4YUc9gFIOWlbgECcAb5BoFbXnlVkvvUur30XenttyyELWMPkYWxVorUOzY
        MbUFcD84Il+e9jNmUO0en8xaP40C90A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-J2SON3V_NxKTzXUvSyofhA-1; Fri, 23 Oct 2020 16:17:16 -0400
X-MC-Unique: J2SON3V_NxKTzXUvSyofhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE9A21842176;
        Fri, 23 Oct 2020 20:17:14 +0000 (UTC)
Received: from krava (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id D64FB5C1CF;
        Fri, 23 Oct 2020 20:17:02 +0000 (UTC)
Date:   Fri, 23 Oct 2020 22:17:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201023201702.GA2495983@krava>
References: <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
 <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava>
 <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava>
 <20201023065832.GA2435078@krava>
 <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 11:22:05AM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 22, 2020 at 11:58 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Oct 23, 2020 at 07:36:57AM +0200, Jiri Olsa wrote:
> > > On Thu, Oct 22, 2020 at 01:00:19PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > >
> > > > > hi,
> > > > > FYI there's still no solution yet, so far the progress is:
> > > > >
> > > > > the proposed workaround was to use the negation -> we don't have
> > > > > DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> > > > > tags have attached code and skip them if they don't have any:
> > > > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
> > > > >
> > > > > the attached patch is doing that, but the resulting BTF is missing
> > > > > several functions due to another bug in dwarf:
> > > > >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> > > >
> > > > It seems fine if there are only few functions (especially if those are
> > > > unlikely to be traced). Do you have an estimate of how many functions
> > > > have this second DWARF bug?
> > >
> > > it wasn't that many, I'll recheck
> >
> > 127 functions missing if the workaround is applied, list attached
> >
> 
> some of those seem pretty useful... I guess the quick workaround in
> pahole would be to just remember function names that were emitted
> already. The problem with that is that we can pick a version without
> parameter names, which is not the end of the world, but certainly
> annoying.

right, we can generate them in bpftrace, but it's a shame


> 
> But otherwise, I don't really have a good feeling what's the perfect
> solution here...

I tried the check of dwarf record against function symbols
with adresses mentioned earlier (attached)

getting more functions of course ;-)

$ bpftool btf dump file ./vmlinux | grep 'FUNC '  | wc -l
46606

compared to 22869 on the same .config with working gcc
and current pahole

and resolve_btfids is happy, because there are no duplications

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index 2a6455be4c52..468781204cd9 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -326,6 +326,18 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
 	return 0;
 }
 
+static bool btfe__generate_func(const struct btf_elf *btfe, const char *name)
+{
+	struct symbol *sym;
+
+	sym = btfe__find_symbol(btfe, name);
+	if (!sym || sym->generated || !sym->addr)
+		return false;
+
+	sym->generated = true;
+	return true;
+}
+
 int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		   bool skip_encoding_vars)
 {
@@ -354,6 +366,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (!skip_encoding_vars && find_all_percpu_vars(btfe))
 			goto out;
 
+		if (btfe__load_symbols(btfe, cu))
+			goto out;
+
 		has_index_type = false;
 		need_index_type = false;
 		array_index_id = 0;
@@ -401,7 +416,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		int btf_fnproto_id, btf_fn_id;
 		const char *name;
 
-		if (fn->declaration || !fn->external)
+		if (!btfe__generate_func(btfe, function__name(fn, cu)))
 			continue;
 
 		btf_fnproto_id = btf_elf__add_func_proto(btfe, cu, &fn->proto, type_id_off);
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
diff --git a/libbtf.c b/libbtf.c
index babf4fe8cd9e..6c4b8a069b85 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -30,6 +30,91 @@
 uint8_t btf_elf__verbose;
 uint8_t btf_elf__force;
 
+static int btfe__insert_symbol(struct btf_elf *btfe, const char *name,
+			     uint64_t addr)
+{
+	struct rb_node **p = &btfe->symbols.rb_node;
+	struct rb_node *parent = NULL;
+	struct symbol *sym;
+	int err;
+
+	while (*p != NULL) {
+		parent = *p;
+		sym = rb_entry(parent, struct symbol, rb_node);
+
+
+		err = strcmp(sym->name, name);
+		if (err < 0)
+			p = &(*p)->rb_left;
+		else if (err > 0)
+			p = &(*p)->rb_right;
+		else
+			return 0;
+	}
+
+	sym = malloc(sizeof(*sym));
+	if (!sym)
+		return -1;
+	sym->name = name;
+	sym->addr = addr;
+	sym->generated = false;
+
+	rb_link_node(&sym->rb_node, parent, p);
+	rb_insert_color(&sym->rb_node, &btfe->symbols);
+	return 0;
+}
+
+struct symbol *btfe__find_symbol(const struct btf_elf *btfe, const char *name)
+{
+	struct symbol *sym;
+	struct rb_node *n;
+	int err;
+
+	n = btfe->symbols.rb_node;
+
+	while (n) {
+		sym = rb_entry(n, struct symbol, rb_node);
+		err = strcmp(sym->name, name);
+		if (err < 0)
+			n = n->rb_left;
+		else if (err > 0)
+			n = n->rb_right;
+		else
+			return sym;
+	}
+
+	return NULL;
+}
+
+int btfe__load_symbols(struct btf_elf *btfe, struct cu *cu)
+{
+	const char *name;
+	GElf_Sym sym;
+	uint32_t id;
+
+	cu__cache_symtab(cu);
+
+	cu__for_each_cached_symtab_entry(cu, id, sym, name) {
+		if (!elf_sym__is_function(&sym))
+			continue;
+		if (btfe__insert_symbol(btfe, name, elf_sym__value(&sym)))
+			return -1;
+	}
+	return 0;
+}
+
+static void btfe__delete_symbols(struct btf_elf *btfe)
+{
+	struct rb_node *n = rb_first(&btfe->symbols);
+	struct symbol *sym;
+
+	while (n) {
+		sym = rb_entry(n, struct symbol, rb_node);
+		n = rb_next(&sym->rb_node);
+		free(sym);
+	}
+}
+
 static int btf_var_secinfo_cmp(const void *a, const void *b)
 {
 	const struct btf_var_secinfo *av = a;
@@ -72,6 +157,7 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 	if (!btfe)
 		return NULL;
 
+	btfe->symbols = RB_ROOT;
 	btfe->in_fd = -1;
 	btfe->filename = strdup(filename);
 	if (btfe->filename == NULL)
@@ -177,6 +263,7 @@ void btf_elf__delete(struct btf_elf *btfe)
 			elf_end(btfe->elf);
 	}
 
+	btfe__delete_symbols(btfe);
 	elf_symtab__delete(btfe->symtab);
 	__gobuffer__delete(&btfe->percpu_secinfo);
 	btf__free(btfe->btf);
diff --git a/libbtf.h b/libbtf.h
index 887b5bc55c8e..f4a58834c390 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -12,6 +12,14 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include "lib/bpf/src/btf.h"
+#include "rbtree.h"
+
+struct symbol {
+	const char	*name;
+	uint64_t	 addr;
+	bool		 generated;
+	struct rb_node	 rb_node;
+};
 
 struct btf_elf {
 	void		  *priv;
@@ -27,6 +35,7 @@ struct btf_elf {
 	uint32_t	  percpu_shndx;
 	uint64_t	  percpu_base_addr;
 	struct btf	  *btf;
+	struct rb_root	  symbols;
 };
 
 extern uint8_t btf_elf__verbose;
@@ -66,4 +75,7 @@ int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
 const char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
 int btf_elf__load(struct btf_elf *btf);
 
+struct symbol *btfe__find_symbol(const struct btf_elf *btfe, const char *name);
+int btfe__load_symbols(struct btf_elf *btfe, struct cu *cu);
+
 #endif /* _LIBBTF_H */

