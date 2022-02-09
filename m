Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323974AE8F1
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiBIFNk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:13:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355660AbiBIEkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 23:40:36 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA459C061577
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 20:40:34 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m185so1690403iof.10
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 20:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyfZruhyLanmHReDvvMLF6Bn0nm+y9EGbqOI6igTgC0=;
        b=BaGoRFunpCQTt+UR5cz2IolxLaEuqlbcpWmJYjhodMlIwtKyTyBI5QQwfctfvTmIOP
         a2BARmy0hBRijtwa0CAtXj2Puo3yJbzMZgm4OcKfgrcQPAOvDBjknUnvMa6ygl1vYkPv
         sVzk7vYS24hNYXFDxsOTkzitxZ8Gj64OQZfDfJvfQ7CMEQ7o6aMT3nZ04gmkmyis9uNj
         lcexJGXVoyeeOnN0DSIC/TP2i9neCfdHZohKcIZEGFjsVRIL5cc+Yy4pc0Qels+Vdmtx
         t6DMN7IX4qTA8WbQJhH8cCSODlzbTuuy85tuEn8EzMx2amtiECgGQyHDDrEmNxHqV19F
         g5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyfZruhyLanmHReDvvMLF6Bn0nm+y9EGbqOI6igTgC0=;
        b=GAeC+GzWpGY3gGLItz+/v+jYXaUuDu1ro2w0oGandIip8EdSgXqTrziOaqmxJUSIsD
         hOs392sppG/O3I8sCaNKA+2EKXryvCcUmERnBXSag+G3BhH+LlFE2TMfSYrD71iz2x67
         pBoLrwCGIlE6LO/wKs9UKCescgeyOYr8qO/KBJm1Jw9j44tJLFbJhSpzGMRkn901jX+W
         FvqeE3USLe7+YLolJcMpNm63v/dy5uPPlZYz2+iQMSVt1Y6DBwzCYGm4jp+t8WzisKUD
         dq0TRMWFlWt+Je1qcwG5JdtI4mxHsBNizkGP2z0XZXuWgo1kl/bJ3GUyYj8wYs4veItP
         D7KA==
X-Gm-Message-State: AOAM531w2FJH9MiyOCP34kv+t0dnVpR5qeaLXbdsO1qIRIqdpMoukN+E
        tvaHbujOw2YRokZvBdelXYu1BXaGSPRgTwdh+iU=
X-Google-Smtp-Source: ABdhPJw1HC6aspd3+3OkMC62y/YA52MEQUSnNKpQrIlLzQAtzsN2COfZWg/H//DwbbfrmqXzui1Ebstu9GHYDZSkCpE=
X-Received: by 2002:a05:6638:2606:: with SMTP id m6mr144408jat.93.1644381634123;
 Tue, 08 Feb 2022 20:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com> <20220208191306.6136-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20220208191306.6136-5-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 20:40:23 -0800
Message-ID: <CAEf4BzbZK_DG46Tf06UmcqT5rFtGg2Wwe7HB57vLOy_RdmRtJQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Update iterators.lskel.h.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 11:13 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Light skeleton and skel_internal.h have changed.
> Update iterators.lskel.h.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  .../bpf/preload/iterators/iterators.lskel.h   | 28 +++++++------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
> index d90562d672d2..3e45237f59f4 100644
> --- a/kernel/bpf/preload/iterators/iterators.lskel.h
> +++ b/kernel/bpf/preload/iterators/iterators.lskel.h
> @@ -3,8 +3,6 @@
>  #ifndef __ITERATORS_BPF_SKEL_H__
>  #define __ITERATORS_BPF_SKEL_H__
>
> -#include <stdlib.h>
> -#include <bpf/bpf.h>
>  #include <bpf/skel_internal.h>
>
>  struct iterators_bpf {
> @@ -70,31 +68,25 @@ iterators_bpf__destroy(struct iterators_bpf *skel)
>         iterators_bpf__detach(skel);
>         skel_closenz(skel->progs.dump_bpf_map.prog_fd);
>         skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
> -       munmap(skel->rodata, 4096);
> +       skel_free_map_data(skel->rodata, skel->maps.rodata.initial_value, 4096);
>         skel_closenz(skel->maps.rodata.map_fd);
> -       free(skel);
> +       skel_free(skel);
>  }
>  static inline struct iterators_bpf *
>  iterators_bpf__open(void)
>  {
>         struct iterators_bpf *skel;
>
> -       skel = calloc(sizeof(*skel), 1);
> +       skel = skel_alloc(sizeof(*skel));
>         if (!skel)
>                 goto cleanup;
>         skel->ctx.sz = (void *)&skel->links - (void *)skel;
> -       skel->rodata =
> -               mmap(NULL, 4096, PROT_READ | PROT_WRITE,
> -                    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> -       if (skel->rodata == (void *) -1)
> -               goto cleanup;

previously if mmap() failed you'd go to cleanup, but now skel->rodata
will remain NULL. Are you concerned about this?


> -       memcpy(skel->rodata, (void *)"\
> +       skel->rodata = skel_prep_map_data((void *)"\
>  \x20\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\
>  \x20\x20\x20\x6d\x61\x78\x5f\x65\x6e\x74\x72\x69\x65\x73\x0a\0\x25\x34\x75\x20\
>  \x25\x2d\x31\x36\x73\x25\x36\x64\x0a\0\x20\x20\x69\x64\x20\x6e\x61\x6d\x65\x20\
>  \x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x20\x61\x74\x74\x61\x63\x68\x65\
> -\x64\x0a\0\x25\x34\x75\x20\x25\x2d\x31\x36\x73\x20\x25\x73\x20\x25\x73\x0a\0", 98);
> -       skel->maps.rodata.initial_value = (__u64)(long)skel->rodata;
> +\x64\x0a\0\x25\x34\x75\x20\x25\x2d\x31\x36\x73\x20\x25\x73\x20\x25\x73\x0a\0", 4096, 98);
>         return skel;
>  cleanup:
>         iterators_bpf__destroy(skel);
> @@ -343,11 +335,11 @@ iterators_bpf__load(struct iterators_bpf *skel)
>  \0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x30\x0e\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\
>  \xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd4\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\
>  \x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0e\0\0\x63\x01\0\0\0\
> -\0\0\0\x61\x60\x20\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
> +\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
>  \x5c\x0e\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\
>  \0\x50\x0e\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\
>  \xc5\x07\xc3\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\
> -\0\x79\x63\x18\0\0\0\0\0\x15\x03\x04\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
> +\0\x79\x63\x20\0\0\0\0\0\x15\x03\x04\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\
>  \x0e\0\0\xb7\x02\0\0\x62\0\0\0\x85\0\0\0\x94\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\
>  \0\0\0\0\x61\x20\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x08\x0f\0\0\x63\x01\0\
>  \0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0f\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
> @@ -401,12 +393,12 @@ iterators_bpf__load(struct iterators_bpf *skel)
>  \x28\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x2c\0\0\0\0\0\x18\x61\0\0\0\0\0\
>  \0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\xb7\0\0\0\0\0\0\0\
>  \x95\0\0\0\0\0\0\0";
> +       skel->maps.rodata.initial_value = skel_prep_init_value((void **)&skel->rodata, 4096, 98);
>         err = bpf_load_and_run(&opts);
>         if (err < 0)
>                 return err;
> -       skel->rodata =
> -               mmap(skel->rodata, 4096, PROT_READ, MAP_SHARED | MAP_FIXED,
> -                       skel->maps.rodata.map_fd, 0);
> +       skel->rodata = skel_finalize_map_data(&skel->maps.rodata.initial_value,
> +                       4096, PROT_READ, skel->maps.rodata.map_fd);

here seems like both before and now, on error, nothing happens. For
kernel mode it matches skeleton behavior (rodata will be NULL), but
for user-space code you'll have (void *)-1, which is probably not
great.

>         return 0;
>  }


>
> --
> 2.30.2
>
