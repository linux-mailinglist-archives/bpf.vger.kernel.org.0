Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991B825BA28
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 07:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgICFfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 01:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgICFfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 01:35:52 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B447DC061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 22:35:52 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c17so1349167ybe.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E08Zk/9+6JHtl6QsUWwsuFdFIW7JNxG1i4fFwPEn8qs=;
        b=DqBdbynu3FFOlxCn+HfxFdkzg7BDZe3EMRXQzQxiafIYKRF58fdPSkAxQ3ag5dH7IY
         DRHeEKDdN4yq0A8wnwEK+VCgD/3p9AX2pPiOTMTTgTYM1eUBRhUEbJTeJ+8mo80Rd5x2
         SN3OKa3Iv2/6qIvxT040KXFI5qFDc2KbT20wXhMuVkTkvT1L/6qY0mIvvs0ddHtszI5b
         FnmYuqlmrrivtl9WLxdXqsdZJiwRJNdUqPUxz2uvI2B+RZM/Oc56dZ4rOaQ5pDWUS/5b
         JRazvuVFskeE5rVL9idhsPClmDIrFTh+9S65droUySaRlEwFvg6wr0uBN0kJSg2+nW3Q
         ub7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E08Zk/9+6JHtl6QsUWwsuFdFIW7JNxG1i4fFwPEn8qs=;
        b=QrRogq3oyLBu8lHTdR82LVfr12ma0plVeN5u2GBNUv6z/4UYXhbgZQPnFIsuR4cuew
         nv9+qjMRKI5B1BON0lmWKmKx+vueZZU40Axj7RmR0gDuDU9qq1xheyUO3lMtWlImfnli
         NuapKjNfDr68QHWXEez0gC+VXRiwr0WOKRWKJWTBRMhMkaNZDp6o66ehmw7A+2t2/FHM
         smMYDQqJfsd6OFX6elB+Ns53ILpE09KG1W076jivTjKlJzfzp1n1vfP9rwiVamKPZ6bJ
         OQgfMAYbzqDVooDcXTDfnrH/DrW/PpqNtiXn3xuNdDkVAwr8N0A53fLNsjTw2EnaENa9
         Hv4w==
X-Gm-Message-State: AOAM533xZmGgHdAHzQV6+dQlfPbXcFklejsxhb4bYUZHIHWRRaInkFyt
        5go7DfjLYfOCXcWmBbtwv1xSd9ucglmz3UIG1rY=
X-Google-Smtp-Source: ABdhPJwvKBWr3d0bi9Kl2raVB5nUIO/iu/FZ5h6GXv/gZ8ltClrhFWvYbH5NAAQuqiAlJF+hH5eE2EIQaDtf6ZluxhY=
X-Received: by 2002:a25:ae43:: with SMTP id g3mr403246ybe.459.1599111351980;
 Wed, 02 Sep 2020 22:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200901103210.54607-1-lmb@cloudflare.com> <20200901103210.54607-5-lmb@cloudflare.com>
In-Reply-To: <20200901103210.54607-5-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Sep 2020 22:35:41 -0700
Message-ID: <CAEf4BzY5QwUdYzXvptKrY=iVjRZqZeHfRzjUm8DAR3YsUe4ZqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: Test copying a sockmap
 via bpf_iter
To:     Lorenz Bauer <lmb@cloudflare.com>
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

On Tue, Sep 1, 2020 at 3:33 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Add a test that exercises a basic sockmap / sockhash copy using bpf_iter.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

just a bunch of nits, as I was passing by :-P

>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 88 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_iter.h  |  9 ++
>  .../selftests/bpf/progs/bpf_iter_sockmap.c    | 58 ++++++++++++
>  .../selftests/bpf/progs/bpf_iter_sockmap.h    |  3 +
>  4 files changed, 158 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 9569bbac7f6e..f5b7b27f096f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -6,6 +6,9 @@
>  #include "test_skmsg_load_helpers.skel.h"
>  #include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
> +#include "bpf_iter_sockmap.skel.h"
> +
> +#include "progs/bpf_iter_sockmap.h"
>
>  #define TCP_REPAIR             19      /* TCP sock is under repair right now */
>
> @@ -196,6 +199,87 @@ static void test_sockmap_invalid_update(void)
>                 test_sockmap_invalid_update__destroy(skel);
>  }
>
> +static void test_sockmap_copy(enum bpf_map_type map_type)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +       int err, len, src_fd, iter_fd, duration;
> +       union bpf_iter_link_info linfo = {0};

nit: misleading initialization, `= {}` is the same but doesn't imply
that you can fill union/struct with non-zeroes like this

> +       __s64 sock_fd[SOCKMAP_MAX_ENTRIES];
> +       __u32 i, num_sockets, max_elems;
> +       struct bpf_iter_sockmap *skel;
> +       struct bpf_map *src, *dst;
> +       struct bpf_link *link;
> +       char buf[64];
> +

[...]

> +SEC("iter/sockmap")
> +int copy_sockmap(struct bpf_iter__sockmap *ctx)
> +{
> +       struct bpf_sock *sk = ctx->sk;
> +       __u32 tmp, *key = ctx->key;
> +       int ret;
> +
> +       if (key == (void *)0)

nit: seems like a verbose way to just write `if (!key)`?

> +               return 0;
> +
> +       elems++;
> +
> +       /* We need a temporary buffer on the stack, since the verifier doesn't
> +        * let us use the pointer from the context as an argument to the helper.
> +        */
> +       tmp = *key;
> +       bpf_printk("key: %u\n", tmp);

is this intentional or a debugging leftover?

> +
> +       if (sk != (void *)0)
> +               return bpf_map_update_elem(&dst, &tmp, sk, 0) != 0;
> +
> +       ret = bpf_map_delete_elem(&dst, &tmp);
> +       return ret && ret != -ENOENT;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> new file mode 100644
> index 000000000000..f98ad727ac06
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define SOCKMAP_MAX_ENTRIES (64)
> --
> 2.25.1
>
