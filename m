Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E17296967
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 07:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370827AbgJWFhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 01:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S370820AbgJWFhG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Oct 2020 01:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603431424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWBykkt7mvfQvNaQqiJjdTW8rBvyNw0+OJsykVGYI6o=;
        b=BV2l6ItpdmWSkkr0pDBWSNXgavsUR69krapX4ZfzPtm0tw6Xus8mazY7BGCHZkyIpG7Hcz
        ifE4atfpP88pMaarU/GZFSZp0cZBmcr8Ks8+T9Ytd0r99Rvp3OHlywStY7gwPkJAl6xIFA
        OoiydiwAkb4H2NI12jRJqu6RT27FlIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-aVBmoo7AP32Y9pqEjJs8Ww-1; Fri, 23 Oct 2020 01:36:58 -0400
X-MC-Unique: aVBmoo7AP32Y9pqEjJs8Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 239FF835B8C;
        Fri, 23 Oct 2020 05:36:57 +0000 (UTC)
Received: from krava (unknown [10.40.192.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1A9305B4AC;
        Fri, 23 Oct 2020 05:36:51 +0000 (UTC)
Date:   Fri, 23 Oct 2020 07:36:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201023053651.GE2332608@krava>
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava>
 <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
 <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava>
 <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 22, 2020 at 01:00:19PM -0700, Andrii Nakryiko wrote:

SNIP

> >
> > hi,
> > FYI there's still no solution yet, so far the progress is:
> >
> > the proposed workaround was to use the negation -> we don't have
> > DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> > tags have attached code and skip them if they don't have any:
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
> >
> > the attached patch is doing that, but the resulting BTF is missing
> > several functions due to another bug in dwarf:
> >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> 
> It seems fine if there are only few functions (especially if those are
> unlikely to be traced). Do you have an estimate of how many functions
> have this second DWARF bug?

it wasn't that many, I'll recheck

> 
> >
> >
> > the only other workaround I can think of is to check each DW_TAG_subprogram
> > tag name with vmlinux symbol to ensure it's actually present,
> > I'll check on it, because as Mark suggested it might be good
> > for future not to completely rely on dwarf being correct, even
> > if that gcc bug gets eventually fixed
> 
> This might be a good thing to do anyways. Currently BTF contains only
> global functions, but a lot of static functions that didn't end up
> inlined are available for attachment, but because BTF info is not
> there, we can't use fentry/fexit on them. Checking against ELF symbols
> would match kallsyms, right? So we would be able to drop fn->external
> requirement and have all the attachable functions available.

right, both static and global

> 
> Have you tried this? I'm curious how good the data is and how much
> bigger BTF size is with all the functions included?

I did not realize that with droping fn->external this would bring
static functions as well, now I want to try ;-)

jirka

> 
> >
> > jirka
> >
> >
> > ---
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index e90150784282..51a370d580b7 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -302,8 +302,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >
> >         cu__for_each_function(cu, core_id, fn) {
> >                 int btf_fnproto_id, btf_fn_id;
> > +               bool has_pc = !!function__addr(fn) || fn->ranges;
> >
> > -               if (fn->declaration || !fn->external)
> > +               if (!has_pc || !fn->external)
> >                         continue;
> >
> >                 btf_fnproto_id = btf_elf__add_func_proto(btfe, &fn->proto, type_id_off);
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index d3586aa5b0dd..4763b9118475 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -953,6 +953,7 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu)
> >                 func->declaration     = dwarf_hasattr(die, DW_AT_declaration);
> >                 func->external        = dwarf_hasattr(die, DW_AT_external);
> >                 func->abstract_origin = dwarf_hasattr(die, DW_AT_abstract_origin);
> > +               func->ranges          = dwarf_hasattr(die, DW_AT_ranges);
> >                 dwarf_tag__set_spec(func->proto.tag.priv,
> >                                     attr_type(die, DW_AT_specification));
> >                 func->accessibility   = attr_numeric(die, DW_AT_accessibility);
> > @@ -2023,8 +2024,10 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
> >                         dtype = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
> >                         if (dtype == NULL)
> >                                 dtype = dwarf_cu__find_tag_by_ref(cu->priv, &specification);
> > -                       if (dtype != NULL)
> > +                       if (dtype != NULL) {
> >                                 fn->name = tag__function(dtype->tag)->name;
> > +                               fn->external = tag__function(dtype->tag)->external;
> > +                       }
> >                         else {
> >                                 fprintf(stderr,
> >                                         "%s: couldn't find name for "
> > diff --git a/dwarves.h b/dwarves.h
> > index 7c4254eded1f..3204f69abfe5 100644
> > --- a/dwarves.h
> > +++ b/dwarves.h
> > @@ -813,6 +813,7 @@ struct function {
> >         uint8_t          virtuality:2; /* DW_VIRTUALITY_{none,virtual,pure_virtual} */
> >         uint8_t          declaration:1;
> >         uint8_t          btf:1;
> > +       uint8_t          ranges:1;
> >         int32_t          vtable_entry;
> >         struct list_head vtable_node;
> >         /* fields used by tools */
> >
> 

