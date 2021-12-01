Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC79846590F
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 23:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbhLAWZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 17:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLAWZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 17:25:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0BC061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 14:21:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so108122065edd.0
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCQwNQM8rrMxQXyeEOO7UYUuoyOy+1BPKKIhY77bUI4=;
        b=tTXbinmHWSW2VS+rox0MD8Wc3V9t0cuzdeAarAAPw5rstqXwa3guk+3UR7TFB87JtY
         RN0O8mhoqKv6j7KdpWz3QtRe5Doj8bqAvQtZQZspMwDr1mW6ExSYu4XYVjSInBQJYOWN
         bHZcah89iTK/bdR27y3K+S3Y5bY9Usri3b7hEo8PxV+RPBvHOLz2wutrUtkXFXmN4bQo
         qhWhPjI6ddylFoAvtBix6w1RBiHO9RYaNniMOdttNhpKG2vEa9iCCoulNaJekEGRaRIt
         fjXEtkOYj1kgGI7WyDb70WJTIrf1XBt2qYCg5v9V3ovNlJTO5R0S07e3rFR01xYq6ECj
         HvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCQwNQM8rrMxQXyeEOO7UYUuoyOy+1BPKKIhY77bUI4=;
        b=l3j7FSkcOh50KQgf6UU16F/4LhqLMCx/jNbQX0SiD+LfR9kfKdO42F1iM0N4V92oXY
         q70dIypnjA8rKqrfC/N4Clz3ljpqCIAzFFgYzNabtLe+3LNw563HA5CcLnVuanJma9Kh
         GaNia7Pn0Knw97MuQEMuMleFti74HQuyZI6x9Rkvr0TpTJue7L86E4W1Aq9J+KC/TIfQ
         sYF2Q3rzrHzxtEvvbHlir3TWlbVSS2rRkXrpXzBRGU+mb21cmo3hcHVNcB7Glx4L8WMt
         Y0yWZM5WMGk4ZbrqtNy+8hZ2IPF5s3AnH6rfliWop8cPdn0+XK5l+lcBdGSU/NdaezLd
         q08A==
X-Gm-Message-State: AOAM533uhbYcbgtAWdkSUoRCxGaRXC7sPHWi8UWLEicGRgHQaiioH5c8
        4sUD6nbNI2uA6Tr9eyVMtDbSX3j0ANLaH85DdKuECw==
X-Google-Smtp-Source: ABdhPJyB8ojsnOPGHyycLQhzYxe0jWJawgVgb98cMd/1djPtNiI8MbFN/5kw5ex6GMNTAEcoFzR1XGaVS8MHouf9irY=
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr12366783edl.336.1638397313813;
 Wed, 01 Dec 2021 14:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com> <20211130012948.380602-9-haoluo@google.com>
 <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 1 Dec 2021 14:21:41 -0800
Message-ID: <CA+khW7ggwH-kwZYk48xnb1akYcTjK5itWu1eLCjmpb36=NLBbA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args
 that are pointers to rdonly mem.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 12:34 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 05:29:47PM -0800, Hao Luo wrote:
> >
> > +
> >  struct bpf_reg_types {
> >       const enum bpf_reg_type types[10];
> >       u32 *btf_id;
> > +
> > +     /* Certain types require customized type matching function. */
> > +     bool (*type_match_fn)(enum bpf_arg_type arg_type,
> > +                           enum bpf_reg_type type,
> > +                           enum bpf_reg_type expected);
> >  };
> >
> >  static const struct bpf_reg_types map_key_value_types = {
> > @@ -5013,6 +5019,19 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
> >  };
> >  #endif
> >
> > +static bool mem_type_match(enum bpf_arg_type arg_type,
> > +                        enum bpf_reg_type type, enum bpf_reg_type expected)
> > +{
> > +     /* If arg_type is tagged with MEM_RDONLY, type is compatible with both
> > +      * RDONLY and RDWR mem, fold the MEM_RDONLY flag in 'type' before
> > +      * comparison.
> > +      */
> > +     if ((arg_type & MEM_RDONLY) != 0)
> > +             type &= ~MEM_RDONLY;
> > +
> > +     return type == expected;
> > +}
> > +
> >  static const struct bpf_reg_types mem_types = {
> >       .types = {
> >               PTR_TO_STACK,
> > @@ -5022,8 +5041,8 @@ static const struct bpf_reg_types mem_types = {
> >               PTR_TO_MAP_VALUE,
> >               PTR_TO_MEM,
> >               PTR_TO_BUF,
> > -             PTR_TO_BUF | MEM_RDONLY,
> >       },
> > +     .type_match_fn = mem_type_match,
>
> why add a callback for this logic?
> Isn't it a universal rule for MEM_RDONLY?

Ah, good point, I didn't realize that. Maybe, not only MEM_RDONLY, but
all flags can be checked in the same way? Like the following

 static const struct bpf_reg_types int_ptr_types = {
@@ -5097,6 +5116,13 @@ static int check_reg_type(struct
bpf_verifier_env *env, u32 regno,
                if (expected == NOT_INIT)
                        break;

+               flag = bpf_type_flag(arg_type);

-               if (type == expected)
+               if ((type & ~flag) == expected)
                        goto found;
        }
