Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650A83595E9
	for <lists+bpf@lfdr.de>; Fri,  9 Apr 2021 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhDIG5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Apr 2021 02:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhDIG5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Apr 2021 02:57:15 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63AC061760
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 23:57:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z1so5475559ybf.6
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGv43HujHORPXafgF3HjGnmkibOU4EwnSNneKiYSJuE=;
        b=rJ65Cene78hUG8XI+3Uw57B+ckDKd6ATlsG88dvTjs18jg5pFffEhwiHpnPZjGyZ9r
         glXROSQPjJ0pNRFY+nAxS0WWkub81GeQSJcsRZFqjFw/ThEFDr3wXo60itCsLGp24Wia
         e70oXQKV5AR+3pVU/o2UW0dNP9BIz0Pwr5PZhDmQXtMgYijflVqqm/1UOaFP6cMXoFV9
         yi7A4ra+3sNYRWwQXEtAuv7FPJpWDSFuh6UrkUUpy3Hm/dqEn3XfpbZ5nW9G3lzdzNVU
         /9YBiTWCQS2macYtzNB2oYRFIIJyo+D3HyoLgJ2UqU9iR2Ix0atc7lBVWe/O1bj7Jvpa
         vZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGv43HujHORPXafgF3HjGnmkibOU4EwnSNneKiYSJuE=;
        b=Xz8bTWTvcik92yctXf8a6CrcYx0S0MUHuHwQXzRDI4Xs8S5YyrKbKSyPtKcx1vahKJ
         3TAGuKqDRgNouyOLHk0IcotHtTdskMHWGFbW/FtwexG1E1m/u8wYadAU9YYvNbPXjvKh
         KlhxjlEqZMGwG8g4Oa8Jid9LkYP22nIXErTsjK3m2ZgOzVe+z1cUwSEynYuquxeTdGA+
         IY8UVGd7eB58PuPVCUX8j38YMVkGi3ZEUvzZ6D62/b6SXWzidAudI2Q3sE46DCVmHhvF
         3Ugx3OGVbuQhR9Szo86w66lHRM/CrkdT1pg4dJMyotpL5lCYVvlH9GtP4qPXw7VZyIX/
         VlGg==
X-Gm-Message-State: AOAM532daG3Zlg8B3vta7ZkuavTII2t1Q76io52DaS12r/DQRESJuQwr
        LxQRJMr8Nnd1RsujZgWK1JZIERKelX/wmmlias5q5GN8
X-Google-Smtp-Source: ABdhPJykGf9Lg73jcU0kIJXCFXTxLRsch80q4ocTwPnAxrPubJzHX16dgV9wuXPcPbsuPl4HfZ0WUldXozL2xqRMOXg=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr17341601ybi.347.1617951421605;
 Thu, 08 Apr 2021 23:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com> <20210408061310.95877-9-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-9-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Apr 2021 23:56:43 -0700
Message-ID: <CAEf4BzatS8w0V7HKbFtb6==pQGVNMqEm_X0YhU0Fm8gbsJDE2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: ringbuf_multi: test bpf_map__set_inner_map_fd
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 11:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Test map__set_inner_map_fd() interaction with map-in-map
> initialization. Use hashmap of maps just to make it different to
> existing array of maps.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  .../testing/selftests/bpf/prog_tests/ringbuf_multi.c  | 11 +++++++++++
>  .../testing/selftests/bpf/progs/test_ringbuf_multi.c  | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> index 159de99621c7..0e79a7d28361 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
> @@ -44,6 +44,7 @@ void test_ringbuf_multi(void)
>         struct ring_buffer *ringbuf = NULL;
>         int err;
>         int page_size = getpagesize();
> +       int proto_fd;
>
>         skel = test_ringbuf_multi__open();
>         if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
> @@ -61,10 +62,20 @@ void test_ringbuf_multi(void)
>         if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
>                 goto cleanup;
>
> +       proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
> +       if (CHECK(proto_fd == -1, "bpf_create_map", "bpf_create_map failed\n"))
> +               goto cleanup;
> +
> +       err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
> +       if (CHECK(err != 0, "bpf_map__set_inner_map_fd", "bpf_map__set_inner_map_fd failed\n"))
> +               goto cleanup;
> +
>         err = test_ringbuf_multi__load(skel);
>         if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
>                 goto cleanup;
>
> +       close(proto_fd);
> +

This will leak FD if any of two previous CHECK()s fail. Fixed it up
while applying.

>         /* only trigger BPF program for current process */
>         skel->bss->pid = getpid();
>
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> index 055c10b2ff80..197b86546dca 100644
> --- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
> @@ -30,6 +30,17 @@ struct {
>         },
>  };
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __array(values, struct ringbuf_map);
> +} ringbuf_hash SEC(".maps") = {
> +       .values = {
> +               [0] = &ringbuf1,
> +       },
> +};
> +
>  /* inputs */
>  int pid = 0;
>  int target_ring = 0;
> --
> 2.31.1
>
