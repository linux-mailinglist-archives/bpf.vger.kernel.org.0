Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8522A2AF9CC
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 21:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKKUbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 15:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgKKUbn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 11 Nov 2020 15:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605126701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/mP/kzazXOYIkQkYS4Rs3SAoyNpLxhpsQryByaBPgI=;
        b=Qh9vLmba74EGXVMc2uOnH534iEI4fn9lFJyUJa5lT0RUJKzKlKY8Il2Vjd1zOnlWKO9oBp
        i5ANpvvVHpuklnh6/re9fXitnMP7r7LMUdwgrzLiNr3/NsAS9xlQpuWT5FGuBCtMohb/YU
        8zRJytHvg1xSiifD2SARpPWH9tsbAKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-BnxWEKYnNxC2_TGfQWzcJg-1; Wed, 11 Nov 2020 15:31:38 -0500
X-MC-Unique: BnxWEKYnNxC2_TGfQWzcJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DA226414C;
        Wed, 11 Nov 2020 20:31:36 +0000 (UTC)
Received: from krava (unknown [10.40.194.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 246876EF7F;
        Wed, 11 Nov 2020 20:31:30 +0000 (UTC)
Date:   Wed, 11 Nov 2020 21:31:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 3/3] btf_encoder: Change functions check due to broken
 dwarf
Message-ID: <20201111203130.GC619201@krava>
References: <20201106222512.52454-1-jolsa@kernel.org>
 <20201106222512.52454-4-jolsa@kernel.org>
 <CAEf4BzZqFos1N-cnyAc6nL-=fHFJYn1tf9vNUewfsmSUyK4rQQ@mail.gmail.com>
 <20201111201929.GB619201@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111201929.GB619201@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 09:19:29PM +0100, Jiri Olsa wrote:
> On Wed, Nov 11, 2020 at 11:59:20AM -0800, Andrii Nakryiko wrote:
> 
> SNIP
> 
> > > +       if (!fl->init_bpf_begin &&
> > > +           !strcmp("__init_bpf_preserve_type_begin", elf_sym__name(sym, btfe->symtab)))
> > > +               fl->init_bpf_begin = sym->st_value;
> > > +
> > > +       if (!fl->init_bpf_end &&
> > > +           !strcmp("__init_bpf_preserve_type_end", elf_sym__name(sym, btfe->symtab)))
> > > +               fl->init_bpf_end = sym->st_value;
> > > +}
> > > +
> > > +static int has_all_symbols(struct funcs_layout *fl)
> > > +{
> > > +       return fl->mcount_start && fl->mcount_stop &&
> > > +              fl->init_begin && fl->init_end &&
> > > +              fl->init_bpf_begin && fl->init_bpf_end;
> > 
> > See below for what seems to be the root cause for the immediate problem.
> > 
> > But me, Alexei and Daniel had a discussion offline, and we concluded
> > that this special bpf_preserve_init section is probably not the right
> > approach overall. We should roll back the bpf patch and instead adjust
> > pahole's approach. I think we should just drop the __init check and
> > include all the __init functions into BTF. There could be cases where
> > we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> > security cases), so having BTFs for those FUNCs are necessary as well.
> > Ftrace currently disallows that, but it's only because no user-space
> > application has a way to attach probes early enough. This might change
> > in the future, so there is no need to invent special mechanisms now
> > for bpf_iter function preservation. Let's just include all __init
> > functions in BTF. Can you please do that change and check how much
> > more functions we get in BTF? Thanks!
> 
> sure, not problem to keep all init functions, will give you the count

with pahole change below (on top of current master) and kernel
without the special init section, I'm getting over ~2000 functions
more on my .config:

  $ bpftool btf dump file ./vmlinux | grep 'FUNC ' | wc -l
  41505
  $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep 'FUNC ' | wc -l
  39256

jirka


---
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
diff --git a/lib/bpf b/lib/bpf
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f
+Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f-dirty

