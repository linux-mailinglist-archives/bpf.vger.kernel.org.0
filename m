Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00629530B
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 21:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409783AbgJUTmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 15:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409780AbgJUTmY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Oct 2020 15:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603309342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0r1v8YB9Y3iFX3c5j5e7h/i0CkLp+FLKjoO4uasyscI=;
        b=F6kvF1xUc0NyRsPLBahQc44dQbtadBwCOIY1rBAn7D/WSe98OQ7gsV3r3D4UpKx5ReH49b
        /ipb2F8lqFQi43oioud9KcUP+S1tuVNuE8XZXOCoqRtyU0OfZYbzEt+NhD8e2QFGcjwBZE
        5H+4rQVdBFjI9N16pdXVSZrg1gR+JbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-1-23iZuqOGOKa7RhPJ1giA-1; Wed, 21 Oct 2020 15:42:16 -0400
X-MC-Unique: 1-23iZuqOGOKa7RhPJ1giA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2864804033;
        Wed, 21 Oct 2020 19:42:15 +0000 (UTC)
Received: from krava (unknown [10.40.194.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id BAFCB5B4A9;
        Wed, 21 Oct 2020 19:42:10 +0000 (UTC)
Date:   Wed, 21 Oct 2020 21:42:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201021194209.GB2276476@krava>
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava>
 <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
 <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016213835.GJ1461394@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 16, 2020 at 11:38:37PM +0200, Jiri Olsa wrote:
> On Wed, Sep 16, 2020 at 11:06:27AM +0200, Jiri Olsa wrote:
> > On Tue, Sep 15, 2020 at 02:17:46PM +0200, Jiri Olsa wrote:
> > 
> > SNIP
> > 
> > > 	 <2><140d7aa>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > > 	    <140d7ab>   DW_AT_type        : <0x140cfb6>
> > > 	 <2><140d7af>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > > 	    <140d7b0>   DW_AT_type        : <0x1406176>
> > > 	 <2><140d7b4>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > > 	    <140d7b5>   DW_AT_type        : <0x14060c9>
> > > 	 <2><140d7b9>: Abbrev Number: 0
> > > 
> > > the latter is just declaration.. but it's missing the
> > >     <365d69d>   DW_AT_declaration : 1
> > > 
> > > so it goes through pahole's function processing:
> > > 
> > > 	cu__encode_btf:
> > > 	...
> > >         cu__for_each_function(cu, core_id, fn) {
> > >                 int btf_fnproto_id, btf_fn_id;
> > > 
> > >                 if (fn->declaration || !fn->external)
> > >                         continue;
> > > 	...
> > > 
> > > 
> > > CC-ing Frank.. any idea why is the DW_AT_declaration : 1 missing?
> > 
> > looks like gcc issue:
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> > 
> > let's see ;-)
> 
> so this gcc bug did not disappear and the fix might be delayed,
> as I was told it's real complex and difficult to fix
> 
> and it's no longer just rawhide issue, because I just started to
> see it in Fedora 32 after updating to gcc (GCC) 10.2.1 20201005
> (Red Hat 10.2.1-5)
> 
> I'm checking on pahole's workaround, but so far I can't see dwarf
> based solution for that.. any thoughts/ideas? ;-)

hi,
FYI there's still no solution yet, so far the progress is:

the proposed workaround was to use the negation -> we don't have
DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
tags have attached code and skip them if they don't have any:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10

the attached patch is doing that, but the resulting BTF is missing
several functions due to another bug in dwarf:
  https://bugzilla.redhat.com/show_bug.cgi?id=1890107


the only other workaround I can think of is to check each DW_TAG_subprogram
tag name with vmlinux symbol to ensure it's actually present,
I'll check on it, because as Mark suggested it might be good
for future not to completely rely on dwarf being correct, even
if that gcc bug gets eventually fixed

jirka


---
diff --git a/btf_encoder.c b/btf_encoder.c
index e90150784282..51a370d580b7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -302,8 +302,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 	cu__for_each_function(cu, core_id, fn) {
 		int btf_fnproto_id, btf_fn_id;
+		bool has_pc = !!function__addr(fn) || fn->ranges;
 
-		if (fn->declaration || !fn->external)
+		if (!has_pc || !fn->external)
 			continue;
 
 		btf_fnproto_id = btf_elf__add_func_proto(btfe, &fn->proto, type_id_off);
diff --git a/dwarf_loader.c b/dwarf_loader.c
index d3586aa5b0dd..4763b9118475 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -953,6 +953,7 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu)
 		func->declaration     = dwarf_hasattr(die, DW_AT_declaration);
 		func->external	      = dwarf_hasattr(die, DW_AT_external);
 		func->abstract_origin = dwarf_hasattr(die, DW_AT_abstract_origin);
+		func->ranges          = dwarf_hasattr(die, DW_AT_ranges);
 		dwarf_tag__set_spec(func->proto.tag.priv,
 				    attr_type(die, DW_AT_specification));
 		func->accessibility   = attr_numeric(die, DW_AT_accessibility);
@@ -2023,8 +2024,10 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 			dtype = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
 			if (dtype == NULL)
 				dtype = dwarf_cu__find_tag_by_ref(cu->priv, &specification);
-			if (dtype != NULL)
+			if (dtype != NULL) {
 				fn->name = tag__function(dtype->tag)->name;
+				fn->external = tag__function(dtype->tag)->external;
+			}
 			else {
 				fprintf(stderr,
 					"%s: couldn't find name for "
diff --git a/dwarves.h b/dwarves.h
index 7c4254eded1f..3204f69abfe5 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -813,6 +813,7 @@ struct function {
 	uint8_t		 virtuality:2; /* DW_VIRTUALITY_{none,virtual,pure_virtual} */
 	uint8_t		 declaration:1;
 	uint8_t		 btf:1;
+	uint8_t		 ranges:1;
 	int32_t		 vtable_entry;
 	struct list_head vtable_node;
 	/* fields used by tools */

