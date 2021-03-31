Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2F3506DA
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhCaSxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhCaSwh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 14:52:37 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B3C061574
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 11:52:36 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id q127-20020a4a33850000b02901b646aa81b1so4860257ooq.8
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwG58KDcIJ/PJto0GhxZletjW0RV/aaeU84SYkm4RXo=;
        b=OJ84ddmToAeFrPd3yMqPuL6eV4VFZ7UyMV6LciMsiy0l22h3QxevBtJ1xP9USMn8zo
         X5+URl9Qe2WVEJfOnvTGSk286sDr91+3j1pgHF3ZWiDXXmJ7DOSv/8iOs9KSbfwr52E6
         vussqui7q3odSqIr0AfouZxr6zdWObLE6xj3OONtELw6RyIsxIdhsUWsev6K4inGMECX
         6Lv1Fb/YCrcvnC8MpP49q3h+ydc3nJevR8lpQjD1TO28kQzKgfIDjRO6byQqTnM0k5JT
         pBhPoxxdliL18r9cIn58IGdBwV20ShfpNuQhgmrl4C7Qohk+eCgM2oyUjb/qUhPZ1azt
         acPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwG58KDcIJ/PJto0GhxZletjW0RV/aaeU84SYkm4RXo=;
        b=XwghEIttY7opagNhLSasvHhylGfS2Bevk8F2migMwu/O0cx1k/a5tPlv74B1k3ihLm
         hGW1EadpM9YKO+jLS13OFFpcq604n1kZo5rxccuBFbrLWJ6x4n1bI/oIZRDSioMSxCQI
         HDcrYvp9WB+8EbZ4ybi3T5b+49C3dbLendX8eBMJsmBG7UPrn775K93Q/MGFAqIfS8pB
         wRwb+NHD6v7V6PjVYg/gNcAiRGhWbv/6w2E2cSQ9OzjwXzuTQkHPdGrBHOx5d+NQaxj2
         AAHH1ZcZ+ewfSySwhNLI0PNDMdoc7n0E1Hrr96OrAC2OkAGYRaIQKk16hDQyovb/0vQT
         gVxA==
X-Gm-Message-State: AOAM5339F0pSlcvYG/6wWnD0LFzbqozCO7YuLK8nm/ud1qhl1F7a0DLI
        Us1+ympXOnidujS50nkFAvcJ6vGLt0UZlPjQJt454aDe
X-Google-Smtp-Source: ABdhPJxiXv7cEV8K88j6EiMqMFQvTDCsMJvhtZhIJSniCqkwKIrIhz95HjaZIm4U6y16FXYbz8qeXR1lkwBPOZ+MxhE=
X-Received: by 2002:a25:37c1:: with SMTP id e184mr6412574yba.260.1617216743035;
 Wed, 31 Mar 2021 11:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com> <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-8-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 31 Mar 2021 11:52:07 -0700
Message-ID: <CAEf4BzaeB_M-95U4cOUccM00XitBaMPnpS7Wik4T9SLSfdixyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: ringbuf_multi: use runtime
 page size
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 9:45 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Set bpf table sizes dynamically according to the runtime page size
> value.
>
> Do not switch to ASSERT macros, keep CHECK, for consistency with the
> rest of the test. Can be a separate cleanup patch.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  .../selftests/bpf/prog_tests/ringbuf_multi.c  | 23 ++++++++++++++++---
>  .../selftests/bpf/progs/test_ringbuf_multi.c  |  1 -
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> index d37161e59bb2..159de99621c7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> @@ -41,13 +41,30 @@ static int process_sample(void *ctx, void *data, size_t len)
>  void test_ringbuf_multi(void)
>  {
>         struct test_ringbuf_multi *skel;
> -       struct ring_buffer *ringbuf;
> +       struct ring_buffer *ringbuf = NULL;
>         int err;
> +       int page_size = getpagesize();
>
> -       skel = test_ringbuf_multi__open_and_load();
> -       if (CHECK(!skel, "skel_open_load", "skeleton open&load failed\n"))
> +       skel = test_ringbuf_multi__open();
> +       if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
>                 return;
>
> +       err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
> +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> +               goto cleanup;
> +
> +       err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
> +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> +               goto cleanup;
> +
> +       err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
> +       if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
> +               goto cleanup;
> +
> +       err = test_ringbuf_multi__load(skel);
> +       if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
> +               goto cleanup;
> +

To test bpf_map__set_inner_map_fd() interaction with map-in-map
initialization, can you extend the test to have another map-in-map
(could be HASHMAP, just for fun), which is initialized with either
ringbuf1 or ringbuf2, but then from user-space use a different way to
override inner map definition:

int proto_fd = bpf_create_map(... RINGBUF of page_size ...);
bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
close(proto_fd);

/* perform load, it should succeed */

Important is to use a different map-in-map from ringbuf_arr, so that
load fails, unless set_inner_map_fd() properly updates internals of a
map.

>         /* only trigger BPF program for current process */
>         skel->bss->pid = getpid();
>
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> index edf3b6953533..055c10b2ff80 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> @@ -15,7 +15,6 @@ struct sample {
>
>  struct ringbuf_map {
>         __uint(type, BPF_MAP_TYPE_RINGBUF);
> -       __uint(max_entries, 1 << 12);
>  } ringbuf1 SEC(".maps"),
>    ringbuf2 SEC(".maps");
>
> --
> 2.31.1
>
