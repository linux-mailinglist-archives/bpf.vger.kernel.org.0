Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADE1296594
	for <lists+bpf@lfdr.de>; Thu, 22 Oct 2020 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370509AbgJVUAj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Oct 2020 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370508AbgJVUAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Oct 2020 16:00:32 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86450C0613CF
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 13:00:31 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a4so2636422ybq.13
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyRHvtPr+7K5VoBbYjXWzRrrVP3TBUuAFsfeJuBXWi0=;
        b=SAWjiEIaYGZSdzWuYviZUVkukbtcJgErhsawN3Ox98dX6GWbZDD88J8Gj0OGTZwkpg
         mXRkxTkIyBWZvxfJPe3fRfMmUgJ69RYbHOlYO7pWCjZQj/dviXrwr+Aaa0fMQPnxqDAS
         PBp/2jdRRKs39w3CE/VKbjUZGSBqlwL+HfNlKbtwkS/gDUj8B4OpzCBQT4R/yIV5Myk7
         HlUuumuqTAeiFyBdpXPsOjfEUfTUoJ9zhSnz+alaDMC7jb0tBSEit0gyUT9v2Tf/kqpe
         WRR8UqoeKazmU7pMrqPMNZUygPMc90UiL6FJd7AEPG0mbXrO8l/peTdJ7sGJkj6gnzmP
         F1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyRHvtPr+7K5VoBbYjXWzRrrVP3TBUuAFsfeJuBXWi0=;
        b=tEaJ/qAKiruQpGx06IC/DTJth1DHjysH3fMHXqGtsQc6VoYxLvt3ANqvCByhbavlAN
         fZe3uSFAnyu986aK4DED4C1/+Iajc9qGmrtj+NN/k08ikZe5ElVBHAPINN15HG6FoSW0
         W1h6t87MIIY8wI9p73VKw/9QRc1as1wCd2bVybzimwzoxBleFJ5Pne0DGZf+LxJZf7dw
         ksVl2I7OeL0FGM1cvIe8cLFL5Yv+mtUdyIOR7Z5bLHY2Ac/RIYrAbUgXWP3ffBwAtNTV
         +k1aKGpOpN9s2XxJods702X/MN3uxeRzD95LJEcG+o+qGjZWcZo44g3ei+O4jUrlxdkt
         N54g==
X-Gm-Message-State: AOAM531uP5yT0hzal+7X+wV1iSMic1pRhWdvREIegOyaAU4XRkjQXlLE
        e2KNe6EfKCuSkoytv+r1bZFmPwCMD51KzeNsLQ8=
X-Google-Smtp-Source: ABdhPJwB+Ou1M4sEu4H5nJ0Zxo+VZhRSGhhjoc/jkiYXce6wBbk0UtOGragVaWFkz9ORVyHaig9dnclpV3sXI8lStkU=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr5979002ybl.347.1603396830144;
 Thu, 22 Oct 2020 13:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
 <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava> <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava> <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava> <20201016213835.GJ1461394@krava> <20201021194209.GB2276476@krava>
In-Reply-To: <20201021194209.GB2276476@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Oct 2020 13:00:19 -0700
Message-ID: <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 21, 2020 at 12:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 16, 2020 at 11:38:37PM +0200, Jiri Olsa wrote:
> > On Wed, Sep 16, 2020 at 11:06:27AM +0200, Jiri Olsa wrote:
> > > On Tue, Sep 15, 2020 at 02:17:46PM +0200, Jiri Olsa wrote:
> > >
> > > SNIP
> > >
> > > >    <2><140d7aa>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > > >       <140d7ab>   DW_AT_type        : <0x140cfb6>
> > > >    <2><140d7af>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > > >       <140d7b0>   DW_AT_type        : <0x1406176>
> > > >    <2><140d7b4>: Abbrev Number: 3 (DW_TAG_formal_parameter)
> > > >       <140d7b5>   DW_AT_type        : <0x14060c9>
> > > >    <2><140d7b9>: Abbrev Number: 0
> > > >
> > > > the latter is just declaration.. but it's missing the
> > > >     <365d69d>   DW_AT_declaration : 1
> > > >
> > > > so it goes through pahole's function processing:
> > > >
> > > >   cu__encode_btf:
> > > >   ...
> > > >         cu__for_each_function(cu, core_id, fn) {
> > > >                 int btf_fnproto_id, btf_fn_id;
> > > >
> > > >                 if (fn->declaration || !fn->external)
> > > >                         continue;
> > > >   ...
> > > >
> > > >
> > > > CC-ing Frank.. any idea why is the DW_AT_declaration : 1 missing?
> > >
> > > looks like gcc issue:
> > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
> > >
> > > let's see ;-)
> >
> > so this gcc bug did not disappear and the fix might be delayed,
> > as I was told it's real complex and difficult to fix
> >
> > and it's no longer just rawhide issue, because I just started to
> > see it in Fedora 32 after updating to gcc (GCC) 10.2.1 20201005
> > (Red Hat 10.2.1-5)
> >
> > I'm checking on pahole's workaround, but so far I can't see dwarf
> > based solution for that.. any thoughts/ideas? ;-)
>
> hi,
> FYI there's still no solution yet, so far the progress is:
>
> the proposed workaround was to use the negation -> we don't have
> DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> tags have attached code and skip them if they don't have any:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
>
> the attached patch is doing that, but the resulting BTF is missing
> several functions due to another bug in dwarf:
>   https://bugzilla.redhat.com/show_bug.cgi?id=1890107

It seems fine if there are only few functions (especially if those are
unlikely to be traced). Do you have an estimate of how many functions
have this second DWARF bug?

>
>
> the only other workaround I can think of is to check each DW_TAG_subprogram
> tag name with vmlinux symbol to ensure it's actually present,
> I'll check on it, because as Mark suggested it might be good
> for future not to completely rely on dwarf being correct, even
> if that gcc bug gets eventually fixed

This might be a good thing to do anyways. Currently BTF contains only
global functions, but a lot of static functions that didn't end up
inlined are available for attachment, but because BTF info is not
there, we can't use fentry/fexit on them. Checking against ELF symbols
would match kallsyms, right? So we would be able to drop fn->external
requirement and have all the attachable functions available.

Have you tried this? I'm curious how good the data is and how much
bigger BTF size is with all the functions included?

>
> jirka
>
>
> ---
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e90150784282..51a370d580b7 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -302,8 +302,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>
>         cu__for_each_function(cu, core_id, fn) {
>                 int btf_fnproto_id, btf_fn_id;
> +               bool has_pc = !!function__addr(fn) || fn->ranges;
>
> -               if (fn->declaration || !fn->external)
> +               if (!has_pc || !fn->external)
>                         continue;
>
>                 btf_fnproto_id = btf_elf__add_func_proto(btfe, &fn->proto, type_id_off);
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index d3586aa5b0dd..4763b9118475 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -953,6 +953,7 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu)
>                 func->declaration     = dwarf_hasattr(die, DW_AT_declaration);
>                 func->external        = dwarf_hasattr(die, DW_AT_external);
>                 func->abstract_origin = dwarf_hasattr(die, DW_AT_abstract_origin);
> +               func->ranges          = dwarf_hasattr(die, DW_AT_ranges);
>                 dwarf_tag__set_spec(func->proto.tag.priv,
>                                     attr_type(die, DW_AT_specification));
>                 func->accessibility   = attr_numeric(die, DW_AT_accessibility);
> @@ -2023,8 +2024,10 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
>                         dtype = dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
>                         if (dtype == NULL)
>                                 dtype = dwarf_cu__find_tag_by_ref(cu->priv, &specification);
> -                       if (dtype != NULL)
> +                       if (dtype != NULL) {
>                                 fn->name = tag__function(dtype->tag)->name;
> +                               fn->external = tag__function(dtype->tag)->external;
> +                       }
>                         else {
>                                 fprintf(stderr,
>                                         "%s: couldn't find name for "
> diff --git a/dwarves.h b/dwarves.h
> index 7c4254eded1f..3204f69abfe5 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -813,6 +813,7 @@ struct function {
>         uint8_t          virtuality:2; /* DW_VIRTUALITY_{none,virtual,pure_virtual} */
>         uint8_t          declaration:1;
>         uint8_t          btf:1;
> +       uint8_t          ranges:1;
>         int32_t          vtable_entry;
>         struct list_head vtable_node;
>         /* fields used by tools */
>
