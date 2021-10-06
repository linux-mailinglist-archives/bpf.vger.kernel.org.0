Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C433842442E
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 19:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJFRbO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhJFRbO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 13:31:14 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F87C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 10:29:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id a7so7180327yba.6
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plcFIEUzVYEdGXRNx7nVr4qbRUTzXkNL6VID+QZ+VBY=;
        b=fBvPk5NxSsuCTDCAQyrdTVT+OdJNryiZKfpREZV4ilvskWoxaKXo1xff415IwgOfRl
         BobuUoYCFVVaS0bKGcrZy2eMNZHuuENOHe3D9nQ3DHMwZqFiqGwYy76JBvPP3z1GLayZ
         BMGb3NCJ1UpX4V06A09WKmWttY8HCntrpQUZDR4BmyitirZ/RcVO/sjLouJtIbpMm8a/
         Q35af8EJVRfUbSFY5vlCPA2HF+xVfyZ3fpEYMrR2ClHx9hKMR4Il0alV3ryxQZdwm8hC
         SQE2kSL2r6MiNLJcNQHoPwjAb6ZiHo4p8Djqplr2gjhKTRgJksQx7NiGVgpJwIrGcRSp
         eHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plcFIEUzVYEdGXRNx7nVr4qbRUTzXkNL6VID+QZ+VBY=;
        b=jwsFaugqkC/uP8z9tPEPsYbYav7/Rx9QUJz+xHCVq8wvmkE0J4jg0rfqJ8IeJYZ82H
         YQIrG+8ZWgM2p/XZabT1ve7oKer0PGw+tM/1rZqyPJXhoEoOl7yVo/DjbT35tNefv1gF
         Mo/ScQ0DGzs27s1CaQnTmEmsrRQJ1e4N+0H6lAnSoz9jAP8sUz3/cKFNnkWhiM696TGE
         UgwXqmoGd2B1PHEOCv5rmebeyQuLnJZovhqimwat2Hc8Nln7GeNdjwgMwV+xhoMYh53E
         YuCPOLR3YcYWbpdmXd1Gmils8++WXLJBYZsWxFRpCn64BpyrhKIcTflzVXifrO7Zo7o5
         SprA==
X-Gm-Message-State: AOAM530dneygaxHp34d2ZbYEvOrQofgXgD4D0MUe62mJvILDvJ8TY95P
        Wm3sMjHm60wq4pu8a3Ih0eoerQe4kjUNA4DzKjQ=
X-Google-Smtp-Source: ABdhPJySkIMCKtoLiybMxnj/lesdXLpcfRrEF7R45RO12hAv8bolhGHKAtsPxLNVN0yE+YV8xruAP+RfI6bsVLDxK/A=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr32154893ybc.225.1633541361196;
 Wed, 06 Oct 2021 10:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211004215644.497327-1-grantseltzer@gmail.com> <CAPhsuW6MZ8-iHd95OLjV-xZCiq8m=satUjqHOhcoh1PENcL5=g@mail.gmail.com>
In-Reply-To: <CAPhsuW6MZ8-iHd95OLjV-xZCiq8m=satUjqHOhcoh1PENcL5=g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Oct 2021 10:29:10 -0700
Message-ID: <CAEf4Bzbcdq26BQpTgK=bFRsws9AkmXa6qoB3vE7WegQk+qePwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add API documentation convention guidelines
To:     Song Liu <song@kernel.org>
Cc:     grantseltzer <grantseltzer@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 4, 2021 at 6:00 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Oct 4, 2021 at 4:51 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds a section to the documentation for libbpf
> > naming convention which describes how to document
> > API features in libbpf, specifically the format of
> > which API doc comments need to conform to.
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
>

Applied to bpf-next, thanks. I've fixed the example block comment
indentation (it was off by one space for all but the first line). I
also noticed that vim syntax highlighting were treating '/**' as
something special, so I added escaping: '/\*\*', but it's not easy for
me to serve html from my dev server, so not sure if that renders ok.
At least `make htmldocs` didn't complain.

BTW, as we'll have (hopefully) more contributions to libbpf docs, it
would be nice to integrate `make htmldocs` "check" into
selftests/bpf's Makefile. Can you please see if that's possible?
Ideally we'd only build docs inside Documentation/bpf to speed things
up. Seems like we currently have one error/warning there, so we are in
a pretty good shape already, but playing a proactive defense here
seems like a prudent approach?


> > ---
> >  .../bpf/libbpf/libbpf_naming_convention.rst   | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > index 9c68d5014ff1..5f42f172987a 100644
> > --- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > +++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
> > @@ -150,6 +150,46 @@ mirror of the mainline's version of libbpf for a stand-alone build.
> >  However, all changes to libbpf's code base must be upstreamed through
> >  the mainline kernel tree.
> >
> > +
> > +API documentation convention
> > +============================
> > +
> > +The libbpf API is documented via comments above definitions in
> > +header files. These comments can be rendered by doxygen and sphinx
> > +for well organized html output. This section describes the
> > +convention in which these comments should be formated.
> > +
> > +Here is an example from btf.h:
> > +
> > +.. code-block:: c
> > +
> > +        /**
> > +        * @brief **btf__new()** creates a new instance of a BTF object from the raw
> > +        * bytes of an ELF's BTF section
> > +        * @param data raw bytes
> > +        * @param size number of bytes passed in `data`
> > +        * @return new BTF object instance which has to be eventually freed with
> > +        * **btf__free()**
> > +        *
> > +        * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
> > +        * error code from such a pointer `libbpf_get_error()` should be used. If
> > +        * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
> > +        * returned on error instead. In both cases thread-local `errno` variable is
> > +        * always set to error code as well.
> > +        */
> > +
> > +The comment must start with a block comment of the form '/**'.
> > +
> > +The documentation always starts with a @brief directive. This line is a short
> > +description about this API. It starts with the name of the API, denoted in bold
> > +like so: **api_name**. Please include an open and close parenthesis if this is a
> > +function. Follow with the short description of the API. A longer form description
> > +can be added below the last directive, at the bottom of the comment.
> > +
> > +Parameters are denoted with the @param directive, there should be one for each
> > +parameter. If this is a function with a non-void return, use the @return directive
> > +to document it.
> > +
> >  License
> >  -------------------
> >
> > --
> > 2.31.1
> >
