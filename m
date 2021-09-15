Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5543340BD79
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 03:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhIOCAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 22:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhIOCAe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 22:00:34 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A08C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 18:59:16 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k10so1227086vsp.12
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BprZnpSeHeFo0+SJVzrq5fQiBrWljkOqlIt1I1jZYM=;
        b=n2Hk2W9jjG4BqP18PFQCvyuMx4lxbxRugoO45g4D8gfgy8P05Q/qXAM96kmLwcu6Re
         HPKuabnAMHfNmopw92nYNV+82+KaGc4LyTBHt4FDDAF4qoU6yoWR49ti3AWDaT6iYf8n
         YHty6e8vrd1mY23RuW1LW0g90Ec7xSUT8UunQ096QdHChsRqO7N0eK481S8rFqg3Hvog
         1O5d5JtoxNfgk6cLcT27E/WfVGQMalT1WRSRKT3MFdZY1JXIy4RnJOc19Chlfjc6YA9t
         6eQJ+i7eqhttW7lDreB9NZLb5r0dJUBESSkX067AraQdEWL1LtOm4V9bCqSSdvpFuDQc
         Ix9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BprZnpSeHeFo0+SJVzrq5fQiBrWljkOqlIt1I1jZYM=;
        b=ooqi1879LmF0dV77e51fm/ZwYRFETIOPeTyM0YXWyqKKhGllGjq5X40JdxiWIfdB6B
         NLUNb3J0V5x12/862S4wGt2Q0NJdj7+WqUsc+zMmlMqc2FAPQqm6iD9QS+AWjcTircDM
         y0Ydnxzi1pZUmiXHm2sCV61ABLXXmmkY5413V9epeQCKst4GeEVJyvutKJ7DpJ1uXC9x
         tSK5JGxp5N+QJMjRL8KyVOeWe6f4Z0w9NYSH94smNMC6FKlqbTJKuyPvfa6xCC73GJAc
         oEAFnoqW95m2QT7irrm4zcfcfoOXVuuDirIybtoFQt8IeeWGFfKgUna+mmykUM6vxIdl
         w0nQ==
X-Gm-Message-State: AOAM530aMPwC3FKziF5wFUx10b33J6U3XPbjrH/GP8+lL59sq3s9VfqT
        6dXcsxz/MYOo66DJtVam/6Ftn8VpnJh488vyZaw=
X-Google-Smtp-Source: ABdhPJwGZGZC7SiX21iFDIzhlYmJ0s7nyvopfGpO6Dnfe2tRTglu+z1zd6WWFkZJ4QuMZB2h8MgyunC/FZeww3EEfoU=
X-Received: by 2002:a05:6102:2256:: with SMTP id e22mr1714320vsb.47.1631671155738;
 Tue, 14 Sep 2021 18:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210909204312.197814-1-grantseltzer@gmail.com>
 <CAEf4BzZQi9QTRaZgvn7ip=DcoCL2qgeQBAjOTptnZ+3_kOPxHg@mail.gmail.com>
 <CAO658oVTaLstBBm3th8kUwOH8D=0mAGo6A-B87yChBrhzD1ehw@mail.gmail.com> <CAEf4BzZnAQvTBvLi9z_fWZbsPoZEM=OEz3gTV3369RwW2cXx=A@mail.gmail.com>
In-Reply-To: <CAEf4BzZnAQvTBvLi9z_fWZbsPoZEM=OEz3gTV3369RwW2cXx=A@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 14 Sep 2021 21:59:04 -0400
Message-ID: <CAO658oWssvXuuxpc6Q1651v1ZDPvRzJssdb6LqEdzx8R4YPdVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add sphinx code documentation comments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 7:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 14, 2021 at 12:52 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 11:46 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Sep 9, 2021 at 1:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
> > > >
> > > > From: Grant Seltzer <grantseltzer@gmail.com>
> > > >
> > > > This adds comments above five functions in btf.h which document
> > > > their uses. These comments are of a format that doxygen and sphinx
> > > > can pick up and render. These are rendered by libbpf.readthedocs.org
> > > >
> > > > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/btf.h | 36 ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 36 insertions(+)
> > > >
> > >
> > > It's nice that you provided a test instance of readthedocs.io site, it
> > > made it much easier to look at how all this is rendered. Thanks!
> > >
> > > I'm no technical writer, but left some thoughts below. It would be
> > > great to get more help documenting all the APIs and important libbpf
> > > objects from people that are good at succinctly explaining concepts.
> >
> > For sure! Once we have these doc comments we can point to them as
> > examples. I'm going to write a blog post and advertise to people to
> > see how they can contribute.
> >
> > > This is a great start!
> > >
> > > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > > index 4a711f990904..f928e57c238c 100644
> > > > --- a/tools/lib/bpf/btf.h
> > > > +++ b/tools/lib/bpf/btf.h
> > > > @@ -30,11 +30,47 @@ enum btf_endianness {
> > > >         BTF_BIG_ENDIAN = 1,
> > > >  };
> > > >
> > > > +/**
> > > > + * @brief **btf__free** frees all data of the BTF representation
> > >
> > > I'd like to propose that we add () for all functions, I've been
> > > roughly following this convention throughout commit messages and
> > > comments in the code, I think it's makes it a bit clearer that we are
> > > talking about functions
> > >
> > > > + * @param btf
> > >
> > > seems like the format is "<arg_name> <description of the argument>" so
> > > in this case it should be something like
> > >
> > > @param btf BTF object to free
> > >
> > > > + * @return void
> > >
> > > do we need @return if the function is returning void? What if we just
> > > omit @return for such cases?
> > >
> > > > + */
> > > >  LIBBPF_API void btf__free(struct btf *btf);
> > > >
> > > > +/**
> > > > + * @brief **btf__new** creates a representation of a BTF section
> > > > + * (struct btf) from the raw bytes of that section
> > >
> > > is there some way to cross reference to other types/functions? E.g.,
> > > how do we make `struct btf` a link to its description?
> >
> > Yes we can cross reference against other members that are in the
> > generated documentation (my v2 patch will have this), but not ones
> > that aren't present. `struct btf` is not because it's in btf.c and not
>
> I see. If it's impossible to jump to forward reference declaration,
> that's fine, I suppose. We don't have to get this perfect from the
> first try.

There must be a way to do this, I will continue to experiment/research.

>
> > btf.h. It's a little messy to have documentation from both as it leads
> > to some generation of non-API functions and duplication. One way of
> > getting around that mess is to explicitly name
> > functions/variables/defines/types that we want to have in
> > documentation but that's not automatically maintained.
> >
> > For this example, is there a reason that `struct btf` is defined in
>
> yes, struct btf internals (actual fields and their layout) is internal
> libbpf implementation detail and not part of its API. So public
> headers only define forward references. If possible, it's good to add
> brief comments to such forward references (similarly we have
> bpf_program, bpf_map, bpf_object, btf_dump, etc), specifying what is
> their purpose. But if not, we can have a separate page going over main
> "objects" that libbpf API defines (bpf_object, bpf_map, bpf_program,
> bpf_link, btf, btf_ext, btf_dump, probably some more I'm forgetting).
> All those have hidden internals, but they are themselves very visible
> in the API.
>
> > btf.c and not btf.h? Would it be possible to have all struct
> > definitions in header files?
> >
> > >
> > > > + * @param data raw bytes
> > > > + * @param size length of raw bytes
> > > > + * @return struct btf*
> > >
> > >
> > > @return new instance of BTF object which has to be eventually freed
> > > with **btf__free()**?
> > >
> > > > + */
> > > >  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> > > > +
> > > > +/**
> > > > + * @brief **btf__new_split** creates a representation of a BTF section
> > >
> > > "representation of a BTF section" seems a bit mouthful. And it's not a
> > > representation, it's a BTF object that allows to perform a lot of
> > > stuff with BTF type information. So maybe let's describe it as
> > >
> > > **btf__new_split()** create a new instance of BTF object from provided
> > > raw data bytes. It takes another BTF instance, **base_btf**, which
> > > serves as a base BTF, which is extended by types in a newly created
> > > BTF instance.
> > >
> > > > + * (struct btf) from a combination of raw bytes and a btf struct
> > > > + * where the btf struct provides a basic set of types and strings,
> > > > + * while the raw data adds its own new types and strings
> > > > + * @param data raw bytes
> > > > + * @param size length of raw bytes
> > > > + * @param base_btf the base btf representation
> > >
> > > same here, "representation" sounds kind of weird and wrong here
> > >
> > > > + * @return struct btf*
> > > > + */
> > > >  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> > > > +
> > > > +/**
> > > > + * @brief **btf__new_empty** creates an unpopulated representation of
> > > > + * a BTF section
> > > > + * @return struct btf*
> > > > + */
> > > >  LIBBPF_API struct btf *btf__new_empty(void);
> > > > +
> > > > +/**
> > > > + * @brief **btf__new_empty_split** creates an unpopulated
> > > > + * representation of a BTF section except with a base BTF
> > > > + * ontop of which split BTF should be based
> > >
> > > typo: on top
> > >
> > > > + * @return struct btf*q
> > > > + */
> > > >  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
> > > >
> > > >  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> > > > --
> > > > 2.31.1
> > > >
