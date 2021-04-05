Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFC354809
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhDEVIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbhDEVIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 17:08:47 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3937C061756
        for <bpf@vger.kernel.org>; Mon,  5 Apr 2021 14:08:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i144so13858804ybg.1
        for <bpf@vger.kernel.org>; Mon, 05 Apr 2021 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMpDwESeUQdbZqdF8LrlBxY9ISVZoLG+ZWuL3Olt6fc=;
        b=XM9uK+Y9fdgGReuq5MOnZxI9zz6eTe1tKjLirnVTuVlF6rk4cptsvytN4zWYs+zU1+
         c4ipgM4BAEoLsC+tTFJA33F51Gjq8JdG4kfA/Oo7KWCyjJPmpV1UTQkmQTf+ajgTwk8a
         hp7F2mQSQISUnV80NcJbVDMWJfNIj3tE+w2GF5lEawKQTCJ70UB74OeY8j/KlGO9xTGS
         UZQJydDmLk1mL04HrJ35StqVa0RA45cEGjrVLXsq5Q6bypPn1A4/jzJuQDiAyQbgKeRj
         SVEGSW3uXBwkyDSDotrKneqzp1wikshE+cEAA7lXTz0TpyXPhh1sAsy05H44eWsQLATy
         59Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMpDwESeUQdbZqdF8LrlBxY9ISVZoLG+ZWuL3Olt6fc=;
        b=sdgtroQY4Z1tkSac9/sfj4ZKAwlnCXsqgAhOHJOV8aI+dMEQckC7d6ZrNYbm4SrkC8
         NmcPDlSzMMSF2wvuikKRfEyL67tf79++iN31J/wsmbYmk7vMJ8A9tkfYNfYSaAE5cLV/
         MPTRxVTkyZ5gbqERAqFDeyKGtpbq7dHPS3mbEX0IrgHMdxvp4qf2rn3ktCJDQ4XM7YqP
         IiJQGeq7/ZYAGX/0e0AtpNbHjP6qN5sNj3B82DMafC+0MBHU3p/eHMkRdnMXT09E5Rzt
         UHvHvjUjWa206ShV0rM7SnGl7VOUaHpz3uulwMtZ9BiPc3BRcjwKVDpjsRmhpTfkjUtN
         LF8Q==
X-Gm-Message-State: AOAM530G+xbI519vAiY4EFJLGz7RMN3AVBO8/bDo90puz5s1dLzEcKXf
        WGVXetdIZjjMBmlkdD6NVXQDyZE3P55UuJRDww0=
X-Google-Smtp-Source: ABdhPJy+Cwnxx2C+03yWtZ6twBGAihCKm3Cvi3hNCniUumTjsLA3D8I5tBXPclMXB81dumsCN7hY3Py/I8fVdahH5EE=
X-Received: by 2002:a25:9942:: with SMTP id n2mr38470911ybo.230.1617656920191;
 Mon, 05 Apr 2021 14:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <YGHOxEIA/k5vG/s5@gmail.com> <ce69af50-3667-c52d-1f1a-b924bbe0fc58@fb.com>
In-Reply-To: <ce69af50-3667-c52d-1f1a-b924bbe0fc58@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 5 Apr 2021 14:08:29 -0700
Message-ID: <CAEf4BzYeLLQAQKNPorzi4pdMq7DxbDXZVPZ11p+-T8+RTV9myA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next] bpf: add lookup_and_delete_elem support to hashtab
To:     Yonghong Song <yhs@fb.com>
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        bpf <bpf@vger.kernel.org>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 4, 2021 at 9:47 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/29/21 5:57 AM, Denis Salopek wrote:
> > Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> > hashtab maps, in addition to stacks and queues.
> > Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
> > the BPF_F_LOCK flag.
> > Create a new hashtab bpf_map_ops function that does lookup and deletion
> > of the element under the same bucket lock and add the created map_ops to
> > bpf.h.
> > Add the appropriate test cases to 'maps' and 'lru_map' selftests
> > accompanied with new test_progs.
> >
> > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> > ---
> > v2: Add functionality for LRU/per-CPU, add test_progs tests.
> > v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> > flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> > v4: Fix the return value for unsupported map types.
> > ---
> >   include/linux/bpf.h                           |   2 +
> >   kernel/bpf/hashtab.c                          |  97 ++++++
> >   kernel/bpf/syscall.c                          |  27 +-
> >   tools/lib/bpf/bpf.c                           |  13 +
> >   tools/lib/bpf/bpf.h                           |   2 +
> >   tools/lib/bpf/libbpf.map                      |   1 +
> >   .../bpf/prog_tests/lookup_and_delete.c        | 279 ++++++++++++++++++
> >   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
> >   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
> >   tools/testing/selftests/bpf/test_maps.c       |  19 +-
> >   10 files changed, 469 insertions(+), 5 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
>

[...]

> > +int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
> > +{
> > +     union bpf_attr attr;
> > +
> > +     memset(&attr, 0, sizeof(attr));
> > +     attr.map_fd = fd;
> > +     attr.key = ptr_to_u64(key);
> > +     attr.value = ptr_to_u64(value);
> > +     attr.flags = flags;
> > +
> > +     return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
> > +}
>
> This looks okay to me. It mimics bpf_map_lookup_elem_flags().
> Andrii, could you take a look as well?

I think it's fine. Given bpf_map_lookup_elem_flags() didn't get
extended for so long means the API is pretty stable and is unlikely to
require the entire OPTS framework.

>
> > +
> >   int bpf_map_delete_elem(int fd, const void *key)
> >   {
> >       union bpf_attr attr;

[...]
