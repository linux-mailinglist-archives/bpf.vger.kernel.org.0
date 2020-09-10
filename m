Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02023264F2A
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIJTh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgIJThK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 15:37:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB3C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 12:37:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so9718209lja.7
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYa5AkZCKgVgGmik9LCtFlAazM9j9LEX0mOdOur+J84=;
        b=o5OY11EUrHR52fcKMwkFgyfE45fFMjG3nHnlGILMg1L3eB+N9Fp62N/1p/4Ykspauj
         YlrSt1qiCjDOaHWNDLACiM5G1FyrM/hyUtMnwNHjWmLHYBTYx23Z/TxrHY/ChuEHIXKO
         TiZagAsXKoi5IFVQgpX3kINm9xqbD5HWC7cx2VK4SXfgo/j67VBcfgcm2xqyL+nj6HFQ
         Lg/hAvJRaUfg9p1N9f3na7E8zcICAFEe8NDa/xbxxBjONdojCT7B9wJ2EMSAkbVavUAS
         n1/OL2zRkFtwZ+3oljIcw06TLAJN4kj5Xfr3TgdLoFHZ3UL3jI/o1h/mHi7cUy+TG3Q/
         1Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYa5AkZCKgVgGmik9LCtFlAazM9j9LEX0mOdOur+J84=;
        b=kqB9+dI3GPCzs1lIIbz72ao3XSb3hT3Wq4VzbK0KEDjd+7+0ouw/iLCz9vLMqeMQ+j
         dtm/93KU3NAwy9lag6d9m/1zQw4gtoDRMLpJbDQ9Qn/ct5Pkpm9CCMDPzR6iNTWScGnc
         BGkOSxQBOyNOoJT5xtn0GhPdzg2bkMLeCT0Al22gC5hiwToyUHsGLhMUy7wqp1zW6eTT
         Yuai1BiRuU/UeOYsAuXTFIgtUwAqqeo7L7p4dA8iyvmJgOm8CFDsBupLi/L0xE0kqiP5
         ZflZYnSkPv6G21Eiaus/arhMtbUJ8SPM0p1/zFvR4Ta10ySBu4BLQtSPuPX2PqFZhsJO
         cPJA==
X-Gm-Message-State: AOAM532hKHngYH+tP6OehtiH7pEAQ6GiRTYopqioFPcJO6sweiFb5oj/
        mSDMKziolUzUG2M4t3QIO3QXVdqgUoy0+3HuHgw=
X-Google-Smtp-Source: ABdhPJxB/ZnNCsvG6fgtHx7gqX1HAH3CEHzgR6Uk2o06hOxhRzH35ZKydiGDnh1Xt/NWXqmPuarj9yG/YSNuvsmvhus=
X-Received: by 2002:a2e:808f:: with SMTP id i15mr4954183ljg.51.1599766627629;
 Thu, 10 Sep 2020 12:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200909162712.221874-1-lmb@cloudflare.com> <20200909162712.221874-4-lmb@cloudflare.com>
 <45e403c2-223d-3f29-e6ec-7ad71f5893d8@fb.com>
In-Reply-To: <45e403c2-223d-3f29-e6ec-7ad71f5893d8@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 12:36:56 -0700
Message-ID: <CAADnVQL-9bUT3n+11N1FdE2A=HO7dHnLje7EaUpNrUgKRAcNuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests: bpf: Test iterating a sockmap
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 11:11 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/9/20 9:27 AM, Lorenz Bauer wrote:
> > Add a test that exercises a basic sockmap / sockhash iteration. For
> > now we simply count the number of elements seen. Once sockmap update
> > from iterators works we can extend this to perform a full copy.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >   .../selftests/bpf/prog_tests/sockmap_basic.c  | 89 +++++++++++++++++++
> >   tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 ++
> >   .../selftests/bpf/progs/bpf_iter_sockmap.c    | 43 +++++++++
> >   .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
> >   4 files changed, 144 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > index 0b79d78b98db..3215f4d22720 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > @@ -6,6 +6,9 @@
> >   #include "test_skmsg_load_helpers.skel.h"
> >   #include "test_sockmap_update.skel.h"
> >   #include "test_sockmap_invalid_update.skel.h"
> > +#include "bpf_iter_sockmap.skel.h"
> > +
> > +#include "progs/bpf_iter_sockmap.h"
> >
> >   #define TCP_REPAIR          19      /* TCP sock is under repair right now */
> >
> > @@ -171,6 +174,88 @@ static void test_sockmap_invalid_update(void)
> >               test_sockmap_invalid_update__destroy(skel);
> >   }
> >
> > +static void test_sockmap_iter(enum bpf_map_type map_type)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > +     int err, len, src_fd, iter_fd, duration;
> > +     union bpf_iter_link_info linfo = {0};
> > +     __s64 sock_fd[SOCKMAP_MAX_ENTRIES];
> > +     __u32 i, num_sockets, max_elems;
> > +     struct bpf_iter_sockmap *skel;
> > +     struct bpf_link *link;
> > +     struct bpf_map *src;
> > +     char buf[64];
> > +
> > +     skel = bpf_iter_sockmap__open_and_load();
> > +     if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
> > +             return;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(sock_fd); i++)
> > +             sock_fd[i] = -1;
> > +
> > +     /* Make sure we have at least one "empty" entry to test iteration of
> > +      * an empty slot.
> > +      */
> > +     num_sockets = ARRAY_SIZE(sock_fd) - 1;
> > +
> > +     if (map_type == BPF_MAP_TYPE_SOCKMAP) {
> > +             src = skel->maps.sockmap;
> > +             max_elems = bpf_map__max_entries(src);
> > +     } else {
> > +             src = skel->maps.sockhash;
> > +             max_elems = num_sockets;
> > +     }
>
> I know you include the shared header progs/bpf_iter_sockmap.h to
> supply SOCKMAP_MAX_ENTRIES in order to define sock_fd array.
>
> I think it is easier to understand if just using bpf_map__max_entries()
> for both sockmap and sockhash to get max_elems and do dynamic allocation
> for sock_fd. WDYT?

imo makes sense as a follow up.

I fixed up "duration = 0" in this test because of build warnings
and pushed the whole set.
Thanks
