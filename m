Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB940B85F
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 21:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhINTxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhINTxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 15:53:38 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD68C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 12:52:20 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id c33so133356uae.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB0E7AHyr+CRMt/SqpjRdSp9UL+UD55eZuTyY9l3b0w=;
        b=UybhZ6uKXCZJbyXROd2fqG/29rO1S3He3A2reyEQlRVZFLaqGuigOborN/1V4cWl99
         KUN+SxXLSWPNKqEorstvGWk7Mi6Mi8ki8wE+kdi76vSMoZLi5jbFRsKTxzWCTy/vtDfn
         K3UoB4uRAuPohFG1ks51sv0t7Y6Z+1ZjFiuUXPav5dZnP07neI0ka65tP+jp2V3c6k+x
         X5FU1FLPPamaEznZz4jDv8kXu4EAVwZteVMVYZCfSoPGcCZkiVRC9cAfj0QgCvn2JaXh
         /8iHH0ZjaF+IvuR58u8F6wc3lDH8GlorVxmY17AuSQ+5gHMPU7Cy5sMjdtKPwgGfK0dM
         fXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB0E7AHyr+CRMt/SqpjRdSp9UL+UD55eZuTyY9l3b0w=;
        b=KXxjtN/E7tNxEhlbZIF4f6HNU8Me/5LULhQ92P4ONN5dtvXRonE7TxRE6XUaBLQBN7
         6RsLry59tuIqu7VpxUgR9p94hXhYmRYgbdC0PwEHljBUrQnVv7kDaRMebN3834UoTqsL
         VIieMf8zz6dUxsVC4vfyXFGsoj9Q2tTioayf3beOvm1NLWSPiqWqTJQYZ8001qqRqLQt
         sIpRBRzsp+7rg1YVUGesKn3nZ05i7qhGpnOIN5d1T0COyaRNAUO/lh+xfnpKfnOEaNKf
         uhPz+zf9UDRDMf1Z01nKlkb6pBdwITvEohcY8P6G2HbXByZIs+i/ZjStFtBgkisw2VMi
         aCqg==
X-Gm-Message-State: AOAM5313ucBh1yZ2rifp9gms68CG6se23Kny/+COUWvnvI1OSeSZ1s8j
        l3DbKOHpA8hxqYjQeoAlvUfbKuR6Hu6bwLfhKvA=
X-Google-Smtp-Source: ABdhPJxemEjpUZDbNoXuGCUFS7NgjovESpzeFmlqrqUT46BGkiYCrUH9WxsNVDDG9AcKzKs1+3WFvGJRKKb68XAUqr0=
X-Received: by 2002:ab0:28d2:: with SMTP id g18mr6334339uaq.40.1631649139039;
 Tue, 14 Sep 2021 12:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210909204312.197814-1-grantseltzer@gmail.com> <CAEf4BzZQi9QTRaZgvn7ip=DcoCL2qgeQBAjOTptnZ+3_kOPxHg@mail.gmail.com>
In-Reply-To: <CAEf4BzZQi9QTRaZgvn7ip=DcoCL2qgeQBAjOTptnZ+3_kOPxHg@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 14 Sep 2021 15:52:07 -0400
Message-ID: <CAO658oVTaLstBBm3th8kUwOH8D=0mAGo6A-B87yChBrhzD1ehw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add sphinx code documentation comments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 11:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 9, 2021 at 1:43 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds comments above five functions in btf.h which document
> > their uses. These comments are of a format that doxygen and sphinx
> > can pick up and render. These are rendered by libbpf.readthedocs.org
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > ---
> >  tools/lib/bpf/btf.h | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
>
> It's nice that you provided a test instance of readthedocs.io site, it
> made it much easier to look at how all this is rendered. Thanks!
>
> I'm no technical writer, but left some thoughts below. It would be
> great to get more help documenting all the APIs and important libbpf
> objects from people that are good at succinctly explaining concepts.

For sure! Once we have these doc comments we can point to them as
examples. I'm going to write a blog post and advertise to people to
see how they can contribute.

> This is a great start!
>
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 4a711f990904..f928e57c238c 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -30,11 +30,47 @@ enum btf_endianness {
> >         BTF_BIG_ENDIAN = 1,
> >  };
> >
> > +/**
> > + * @brief **btf__free** frees all data of the BTF representation
>
> I'd like to propose that we add () for all functions, I've been
> roughly following this convention throughout commit messages and
> comments in the code, I think it's makes it a bit clearer that we are
> talking about functions
>
> > + * @param btf
>
> seems like the format is "<arg_name> <description of the argument>" so
> in this case it should be something like
>
> @param btf BTF object to free
>
> > + * @return void
>
> do we need @return if the function is returning void? What if we just
> omit @return for such cases?
>
> > + */
> >  LIBBPF_API void btf__free(struct btf *btf);
> >
> > +/**
> > + * @brief **btf__new** creates a representation of a BTF section
> > + * (struct btf) from the raw bytes of that section
>
> is there some way to cross reference to other types/functions? E.g.,
> how do we make `struct btf` a link to its description?

Yes we can cross reference against other members that are in the
generated documentation (my v2 patch will have this), but not ones
that aren't present. `struct btf` is not because it's in btf.c and not
btf.h. It's a little messy to have documentation from both as it leads
to some generation of non-API functions and duplication. One way of
getting around that mess is to explicitly name
functions/variables/defines/types that we want to have in
documentation but that's not automatically maintained.

For this example, is there a reason that `struct btf` is defined in
btf.c and not btf.h? Would it be possible to have all struct
definitions in header files?

>
> > + * @param data raw bytes
> > + * @param size length of raw bytes
> > + * @return struct btf*
>
>
> @return new instance of BTF object which has to be eventually freed
> with **btf__free()**?
>
> > + */
> >  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> > +
> > +/**
> > + * @brief **btf__new_split** creates a representation of a BTF section
>
> "representation of a BTF section" seems a bit mouthful. And it's not a
> representation, it's a BTF object that allows to perform a lot of
> stuff with BTF type information. So maybe let's describe it as
>
> **btf__new_split()** create a new instance of BTF object from provided
> raw data bytes. It takes another BTF instance, **base_btf**, which
> serves as a base BTF, which is extended by types in a newly created
> BTF instance.
>
> > + * (struct btf) from a combination of raw bytes and a btf struct
> > + * where the btf struct provides a basic set of types and strings,
> > + * while the raw data adds its own new types and strings
> > + * @param data raw bytes
> > + * @param size length of raw bytes
> > + * @param base_btf the base btf representation
>
> same here, "representation" sounds kind of weird and wrong here
>
> > + * @return struct btf*
> > + */
> >  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> > +
> > +/**
> > + * @brief **btf__new_empty** creates an unpopulated representation of
> > + * a BTF section
> > + * @return struct btf*
> > + */
> >  LIBBPF_API struct btf *btf__new_empty(void);
> > +
> > +/**
> > + * @brief **btf__new_empty_split** creates an unpopulated
> > + * representation of a BTF section except with a base BTF
> > + * ontop of which split BTF should be based
>
> typo: on top
>
> > + * @return struct btf*q
> > + */
> >  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
> >
> >  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> > --
> > 2.31.1
> >
