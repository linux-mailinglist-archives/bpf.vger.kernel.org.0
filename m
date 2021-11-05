Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF6446ADB
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhKEWXj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 18:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhKEWXj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 18:23:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36987C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 15:20:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id o12so26331200ybk.1
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQ5d5oMVppWeyv7bjRETMA2692X8XqEdhel7qHjvJH0=;
        b=WyMa7GW2KHF+O2jfsiXOKBRYVx3wyccBG3KImM5dvLupXoRwUgwSHLwa/5ATe7HpZ5
         2X+TUOj/0FIT+DV1NJuGw+xVWm1qfznAQ7FHe5yLlsOB1auZFDOpn4y4CVqTe5n5l+31
         odEQMO+OJq3+t5jXnrvS+p9BrsLcNcbV27MI2JfIDGS+eMsQxHweIyYJ01+NxzrgDmwi
         upF3PmWb6S2kHrBy6qZlyGf+DbxTAGU4FmbKkTA3FQ0FD0cmH97mrUSFgT+JWowbkVi5
         TCHTcWseTz7KIqcOiNZA+fiuii/rGjEWsoNkyF/s0mga1ku+v3TvMZyTMBTOWjZQLxZu
         B2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQ5d5oMVppWeyv7bjRETMA2692X8XqEdhel7qHjvJH0=;
        b=a0J7maleFEPt7YhKsLQcY4pt+Sncd21IXkov1W+m5Kjmy8C6vN8gU5a8YJCVIiTPb9
         VIkXkHgx8WickG6O/ZS7gw8jZQRYDKDWy3SvJzuXSrxJRjbRQnG5y3/8qWSCmFPYyR1b
         oVOKOoTTHckRQOGwHkpxKoX7Y7dhw4njr13eGbvyc6eQF9A52GhMR7it8C+3RM9WRnQk
         67Yspe1KIq1nxG/fXs9FPezvNDXq1gTefcc13ImaLG+SCQ1LW5e8xAtzcTiwnsv+AtQI
         8ltHxYEATIg60tfFCP4/xR4ieovpbA9w3+TJVh2hQ2c9Kzd3AOuQP7Chvxs6rMMlStk5
         e1dQ==
X-Gm-Message-State: AOAM5315XOHIvlpBJpOHXkmBXfBkOZAZH/Eh9klwSjFTyDez3GCcppVg
        xTuvaE1Bl7rHfjaXJINFaZTCDYUPoHy8cekXEbuGGuDP
X-Google-Smtp-Source: ABdhPJxAetvBOI7o2tF84RKherYVqZK3K3pUhIEPKpCWLtpKsAxsOE5FGfZh1ydqyspzrY3oED+8Ukbj6EFaAfoRpog=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr67593521ybj.504.1636150858417;
 Fri, 05 Nov 2021 15:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211105191055.3324874-1-andrii@kernel.org> <20211105204051.v7wzca6fryb774m4@apollo.localdomain>
 <CAEf4Bzb83Nz3iRa1t8+EknuowkkbYwf+zjwRj_SJSvh0ewfa+g@mail.gmail.com> <20211105220410.j2eur76wvzjd3fab@apollo.localdomain>
In-Reply-To: <20211105220410.j2eur76wvzjd3fab@apollo.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 5 Nov 2021 15:20:47 -0700
Message-ID: <CAEf4BzZncpbHtSp47jv4cE0CYZ+3tFBNqrj+HoXFcx_5EjSNbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration in gen_loader.c
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 3:04 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Sat, Nov 06, 2021 at 03:19:38AM IST, Andrii Nakryiko wrote:
> > On Fri, Nov 5, 2021 at 1:40 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > On Sat, Nov 06, 2021 at 12:40:55AM IST, Andrii Nakryiko wrote:
> > > > Fix the `int i` declaration inside the for statement. This is non-C89
> > > > compliant. See [0] for user report breaking BCC build.
> > > >
> > > >   [0] https://github.com/libbpf/libbpf/issues/403
> > > >
> > > > Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > Thanks for the fix, and sorry about that.
> > >
> > > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > >
> >
> > No worries, we just need to figure out which compiler flags we need to
> > catch this. I'm surprised BCC build caught this and neither libbpf's
> > Makefile nor selftest did. Selftests are definitely too permissive
> > w.r.t. stuff like this.
> >
> > If you could take a look and see what we'll need to lock it down a
> > bit, that would be great. I've also requested help from the original
> > reporter of this issue (see issue on Github).
> >
>
> I think you want -std=gnu89 (i.e. C89 with GNU extensions). I get the same error
> as the reporter when building with that.

Oh, I think I tried -std=c89 and it didn't compile due to use of those
extensions. Didn't realize gnu89 exists. Do you mind adding it to
bpftool, libbpf, and selftests Makefiles and sending a patch?

>
> >
> > > > [...]
> > >
> > > --
> > > Kartikeya
>
> --
> Kartikeya
