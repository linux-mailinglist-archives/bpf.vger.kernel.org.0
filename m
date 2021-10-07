Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F16742605D
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 01:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhJGX3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhJGX3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 19:29:42 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B4FC061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 16:27:48 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id w13so8641422vsa.2
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuOtizwYQxOKZTfi1ywm619X8BsaenAkt1hjnUDDRRg=;
        b=aAyfiQzTFTtrjPJa0y653ijRiWgc6ChxXbl6a8AEMtkK6EVoGFw9aGM4/nVCLs2Q6I
         xPe1niPNN4Md0sbyM1rtvKhpyQ6pDLTEZh1AWQi2GL5TzwZBvO7okZTDSrCWbpVdsFG3
         UaS6FEvbhWKvGDqV6JiJVrdFr0OA4GKpo58zGMwklN217WH4q0RfEVJxoeeYv/QRR78t
         zomEL6QAfA7TOKgi8YI/32WGjPy7ikKCoYL4aMaF8vyTxreNOQPOitQyX9+K3DMtjgpm
         FJdKUs+U7xB8SLS6Ods4edyuk+nb7OECrqmyQSVQwBx78ViNuHYM3vz3AslzVJ8MKJVA
         l8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuOtizwYQxOKZTfi1ywm619X8BsaenAkt1hjnUDDRRg=;
        b=bqtYsVXhXePreLHJvqoS2oyVkg4vsVHY4Tb4m2btnrFFPpfAUMHOtDByGb7dFr87nS
         3N4hLXX2+BC0d4aiIbIC7FRpp7M2u3yU1y4LzWfXgp0gNzJzeJdO5Z1cEbb28cFWCLl9
         OI2CX5iLTdjXemBOuzF2fmhHW5pJtT4IO459Wv9YbiBOpb3/kyEJbagZ05uTFiLuuYEU
         Rqi8j02B89+d/6JE4QW38hJ/DFAesrgEJWj+9+yrJedMnIZGk3GtkSY83gwkmTZcLriF
         9LFqHY5SUjVx/C04vaiTEY/US2dfhrRtgkTNZ+4ppJ4kfnHdPaWi3aTJZvvSVHJmurKo
         F0Uw==
X-Gm-Message-State: AOAM530RwkAORCORQAma6smC9TEHxUaI3lHnitB7rvbQTWxvhC+TOHR2
        toArczLt7/+IOGbA8+OrTQtkQIH+Aj7Dj2PkoRSjGeswYL8=
X-Google-Smtp-Source: ABdhPJxXWR7j5vUlY2hHmTv61qJxIGWkTLuKjTbP/WKUAsKANHyC9zWCmEObGnjgB1hAG2CiXDhCG45sa5vC84OCu9g=
X-Received: by 2002:a05:6102:1147:: with SMTP id j7mr7556746vsg.45.1633649267196;
 Thu, 07 Oct 2021 16:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211004215644.497327-1-grantseltzer@gmail.com>
 <CAPhsuW6MZ8-iHd95OLjV-xZCiq8m=satUjqHOhcoh1PENcL5=g@mail.gmail.com> <CAEf4Bzbcdq26BQpTgK=bFRsws9AkmXa6qoB3vE7WegQk+qePwA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbcdq26BQpTgK=bFRsws9AkmXa6qoB3vE7WegQk+qePwA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Thu, 7 Oct 2021 19:27:36 -0400
Message-ID: <CAO658oUfpQC4-wxu=-gwt7eJvGaruYB5MrsqwQKJHwgXe5SUBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add API documentation convention guidelines
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 1:29 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 4, 2021 at 6:00 PM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Oct 4, 2021 at 4:51 PM grantseltzer <grantseltzer@gmail.com> wrote:
> > >
> > > From: Grant Seltzer <grantseltzer@gmail.com>
> > >
> > > This adds a section to the documentation for libbpf
> > > naming convention which describes how to document
> > > API features in libbpf, specifically the format of
> > > which API doc comments need to conform to.
> > >
> > > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
>
> Applied to bpf-next, thanks. I've fixed the example block comment
> indentation (it was off by one space for all but the first line). I
> also noticed that vim syntax highlighting were treating '/**' as
> something special, so I added escaping: '/\*\*', but it's not easy for
> me to serve html from my dev server, so not sure if that renders ok.
> At least `make htmldocs` didn't complain.
>
> BTW, as we'll have (hopefully) more contributions to libbpf docs, it
> would be nice to integrate `make htmldocs` "check" into
> selftests/bpf's Makefile. Can you please see if that's possible?
> Ideally we'd only build docs inside Documentation/bpf to speed things
> up. Seems like we currently have one error/warning there, so we are in
> a pretty good shape already, but playing a proactive defense here
> seems like a prudent approach?

That's a good idea, I will work on this.

>
>
> > > ---
> > >  .../bpf/libbpf/libbpf_naming_convention.rst   | 40 +++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > > index 9c68d5014ff1..5f42f172987a 100644
> > > --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > > +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > > @@ -150,6 +150,46 @@ mirror of the mainline's version of libbpf for a stand-alone build.
> > >  However, all changes to libbpf's code base must be upstreamed through
> > >  the mainline kernel tree.
> > >
> > > +
> > > +API documentation convention
> > > +============================
> > > +
> > > +The libbpf API is documented via comments above definitions in
> > > +header files. These comments can be rendered by doxygen and sphinx
> > > +for well organized html output. This section describes the
> > > +convention in which these comments should be formated.
> > > +
> > > +Here is an example from btf.h:
> > > +
> > > +.. code-block:: c
> > > +
> > > +        /**
> > > +        * @brief **btf__new()** creates a new instance of a BTF object from the raw
> > > +        * bytes of an ELF's BTF section
> > > +        * @param data raw bytes
> > > +        * @param size number of bytes passed in `data`
> > > +        * @return new BTF object instance which has to be eventually freed with
> > > +        * **btf__free()**
> > > +        *
> > > +        * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
> > > +        * error code from such a pointer `libbpf_get_error()` should be used. If
> > > +        * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
> > > +        * returned on error instead. In both cases thread-local `errno` variable is
> > > +        * always set to error code as well.
> > > +        */
> > > +
> > > +The comment must start with a block comment of the form '/**'.
> > > +
> > > +The documentation always starts with a @brief directive. This line is a short
> > > +description about this API. It starts with the name of the API, denoted in bold
> > > +like so: **api_name**. Please include an open and close parenthesis if this is a
> > > +function. Follow with the short description of the API. A longer form description
> > > +can be added below the last directive, at the bottom of the comment.
> > > +
> > > +Parameters are denoted with the @param directive, there should be one for each
> > > +parameter. If this is a function with a non-void return, use the @return directive
> > > +to document it.
> > > +
> > >  License
> > >  -------------------
> > >
> > > --
> > > 2.31.1
> > >
