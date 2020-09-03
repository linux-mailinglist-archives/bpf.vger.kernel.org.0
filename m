Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978B225BD74
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgICIjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICIjA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 04:39:00 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED5DC061244
        for <bpf@vger.kernel.org>; Thu,  3 Sep 2020 01:39:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 37so1983898oto.4
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUp1WtXGmzLaZpKCmv67YOpSDqjPZnie8XQTKx942qU=;
        b=WkhQYCEjq1T033ONFUsv8w2UZgdCv+LnTVRHdk0UsjmVrFKvsui4hs/8t4qvjQSZsN
         gx2zvn26/o4/WWelgBIvIm12ojeQ887kuUPlI8PDF76OBuPRj3kpBB58i7gUOIV94bcm
         d4nLDJ2DiJeg91KJZYF94qlCKaWfG2R0YTgNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUp1WtXGmzLaZpKCmv67YOpSDqjPZnie8XQTKx942qU=;
        b=ujNjg3kufG8jkhp2Sw3jdDvWzQyLHj6ro1+kit8ioyigDBwfL///7nk+ldKgWjQvKL
         UWllKORRyhIJmL2khlZl0I9BWam6J/WARApGWL+/ToEVA40L5nOeul7SjKoSpeEHA71Q
         Dm2GWz1av39lKxJHc/5DX7znYBK6Oa2luO+ysDXpSJkucwmQeZYtQcxSw1/fRx6jsBlJ
         dhha9C3U7XZ8aFMQmzITQ4I0w7rBz/1wwjkwDLFpmKi6dC9tmjMCMVPFC1zkl3Pze8T0
         jjm/KZY4P+/eFkRMzzAgjknhyAVKhXPNJZJCWckKlw4KUJoxNScIvqGOTSu8kc7jCvZT
         LZfw==
X-Gm-Message-State: AOAM532jAo1ccUHdyLEHhsAVDZoY7sNjxDDjhIVVx0OF08SCFXVEyHvV
        I5puRf5HTJfIxRx7eQ62y8V/MDwOB7CQ34RX2JtFVA==
X-Google-Smtp-Source: ABdhPJw/i/FHbTaEK+I4btb88nSPJQYuKubYTuf32kSdiv0oRkH+nO2n9ONTc/7nxTsJq4io4uGdk/+V14daiXx+T+Y=
X-Received: by 2002:a9d:7e93:: with SMTP id m19mr789109otp.132.1599122339188;
 Thu, 03 Sep 2020 01:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200901103210.54607-1-lmb@cloudflare.com> <20200901103210.54607-5-lmb@cloudflare.com>
 <CAEf4BzY5QwUdYzXvptKrY=iVjRZqZeHfRzjUm8DAR3YsUe4ZqQ@mail.gmail.com>
In-Reply-To: <CAEf4BzY5QwUdYzXvptKrY=iVjRZqZeHfRzjUm8DAR3YsUe4ZqQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 3 Sep 2020 09:38:48 +0100
Message-ID: <CACAyw9--VjiCtp7HPEUHEJ0SHStUEZxqsqvFYVci=1Tsiersng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: Test copying a sockmap
 via bpf_iter
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 3 Sep 2020 at 06:35, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 1, 2020 at 3:33 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Add a test that exercises a basic sockmap / sockhash copy using bpf_iter.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
>
> just a bunch of nits, as I was passing by :-P

Appreciated, as always :)

>
> >  .../selftests/bpf/prog_tests/sockmap_basic.c  | 88 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 ++
> >  .../selftests/bpf/progs/bpf_iter_sockmap.c    | 58 ++++++++++++
> >  .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
> >  4 files changed, 158 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > index 9569bbac7f6e..f5b7b27f096f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > @@ -6,6 +6,9 @@
> >  #include "test_skmsg_load_helpers.skel.h"
> >  #include "test_sockmap_update.skel.h"
> >  #include "test_sockmap_invalid_update.skel.h"
> > +#include "bpf_iter_sockmap.skel.h"
> > +
> > +#include "progs/bpf_iter_sockmap.h"
> >
> >  #define TCP_REPAIR             19      /* TCP sock is under repair right now */
> >
> > @@ -196,6 +199,87 @@ static void test_sockmap_invalid_update(void)
> >                 test_sockmap_invalid_update__destroy(skel);
> >  }
> >
> > +static void test_sockmap_copy(enum bpf_map_type map_type)
> > +{
> > +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > +       int err, len, src_fd, iter_fd, duration;
> > +       union bpf_iter_link_info linfo = {0};
>
> nit: misleading initialization, `= {}` is the same but doesn't imply
> that you can fill union/struct with non-zeroes like this

Ack.
>
> > +       __s64 sock_fd[SOCKMAP_MAX_ENTRIES];
> > +       __u32 i, num_sockets, max_elems;
> > +       struct bpf_iter_sockmap *skel;
> > +       struct bpf_map *src, *dst;
> > +       struct bpf_link *link;
> > +       char buf[64];
> > +
>
> [...]
>
> > +SEC("iter/sockmap")
> > +int copy_sockmap(struct bpf_iter__sockmap *ctx)
> > +{
> > +       struct bpf_sock *sk = ctx->sk;
> > +       __u32 tmp, *key = ctx->key;
> > +       int ret;
> > +
> > +       if (key == (void *)0)
>
> nit: seems like a verbose way to just write `if (!key)`?

Yeah, this is copypasta from the other iterator test. I'll change this.

>
> > +               return 0;
> > +
> > +       elems++;
> > +
> > +       /* We need a temporary buffer on the stack, since the verifier doesn't
> > +        * let us use the pointer from the context as an argument to the helper.
> > +        */
> > +       tmp = *key;
> > +       bpf_printk("key: %u\n", tmp);
>
> is this intentional or a debugging leftover?

Oops!

>
> > +
> > +       if (sk != (void *)0)
> > +               return bpf_map_update_elem(&dst, &tmp, sk, 0) != 0;
> > +
> > +       ret = bpf_map_delete_elem(&dst, &tmp);
> > +       return ret && ret != -ENOENT;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> > new file mode 100644
> > index 000000000000..f98ad727ac06
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> > @@ -0,0 +1,3 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define SOCKMAP_MAX_ENTRIES (64)
> > --
> > 2.25.1
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
