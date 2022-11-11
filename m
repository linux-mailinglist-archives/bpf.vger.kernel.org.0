Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBCD626341
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiKKU4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKU4v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 15:56:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0286D55
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:56:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n12so15161209eja.11
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8SAutTO/+s9yFGs8+TOqIT08pR/4HT5KBK7AcqNyV8=;
        b=OQIakW6sZ+jm1lixHWj37xtG7dwPqifkRTjERsnpOjZWEdwK7KIegWSs0qFXSWdCGb
         4CXfl+xA9pRKqAP5NvXhm+ElltaPPy1FSSVoIkoasH+nmnAPrFDo37E5qlVLitpeNjov
         OKmWj3rIex3/tUNX98J/K9B0IygGFoEiQQDnXd9XoP62wBDowyCCL++kUfRfh9E7uRjX
         za1JGg0tO9MKh1Uv8k3qnMaTmB8zOikLLMFhk7xSwSsPmTJRxiAoOXg/1GHpWxwZHAxL
         GuHBis+U84mr92kyJjFHHkJ88HnYFPXGxh8XV/1J+WUZp4hry6fxpC6TltsdRSxufYbR
         PAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8SAutTO/+s9yFGs8+TOqIT08pR/4HT5KBK7AcqNyV8=;
        b=oHLm84nnLqZwnR8K0rqsfdJq9n7TZE9y/7WFUGtCAfptvQQVE/w1bnRKtuSAjxko0Q
         rvHz/hAUGBntf9+4cBDgbejuMaxvUlrrZqgQrvgWQ5qiiqfjuwJOSUtlMAcxRS3LT2kL
         jjQrp05NDiBP0CSylD/FdLdbiGqjx81wvWcVMsZIxXO1Alj360RrYzEKwkjmUWyeRyPs
         x8ZJcspuIS9ThP/9t9cAX1W6WDlh1FcoixRJoWkZA81d+vKoTFoij2Azain8r5xTnce4
         XPc+SoimtZEC8iXDES7W9Vs/faOHdaqo0DkNbv6eIrprgfR9XzKaavlC4tT+DL5F613y
         kgtQ==
X-Gm-Message-State: ANoB5pkrbwodG7S9aey+em7uqpyOJwET8qollWVyUSKdQwi226dn/4OW
        ajNGkDBcwOMj1iVMM5EGT32IYlh6QP261OxO4mU=
X-Google-Smtp-Source: AA0mqf7aHEmuZehAdBdlvQ+yXCQIwFk+k00sGPxl/pDQ9dYNH+NJtr8oSVG4ReoaXn0mkz0hXXj6UOf/Csqyz0Y75ZU=
X-Received: by 2002:a17:906:1b0f:b0:78d:3188:9116 with SMTP id
 o15-20020a1709061b0f00b0078d31889116mr3312060ejg.176.1668200206068; Fri, 11
 Nov 2022 12:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20221111092642.2333724-1-houtao@huaweicloud.com>
 <20221111092642.2333724-3-houtao@huaweicloud.com> <Y26MTygDw2PUQlFz@google.com>
In-Reply-To: <Y26MTygDw2PUQlFz@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 12:56:34 -0800
Message-ID: <CAEf4Bza4yPEW2wOFAFMC8nwEEqVtD-jBD2T52CQ7vJpCUWCvmA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] libbpf: Handle size overflow for ringbuf mmap
To:     sdf@google.com
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 11, 2022 at 9:54 AM <sdf@google.com> wrote:
>
> On 11/11, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
>
> > The maximum size of ringbuf is 2GB on x86-64 host, so 2 * max_entries
> > will overflow u32 when mapping producer page and data pages. Only
> > casting max_entries to size_t is not enough, because for 32-bits
> > application on 64-bits kernel the size of read-only mmap region
> > also could overflow size_t.
>
> > So fixing it by casting the size of read-only mmap region into a __u64
> > and checking whether or not there will be overflow during mmap.
>
> > Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >   tools/lib/bpf/ringbuf.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
>
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index d285171d4b69..c4bdc88af672 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -77,6 +77,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> >       __u32 len = sizeof(info);
> >       struct epoll_event *e;
> >       struct ring *r;
> > +     __u64 ro_size;

I found ro_size quite a confusing name, let's call it mmap_sz?

> >       void *tmp;
> >       int err;
>
> > @@ -129,8 +130,14 @@ int ring_buffer__add(struct ring_buffer *rb, int
> > map_fd,
> >        * data size to allow simple reading of samples that wrap around the
> >        * end of a ring buffer. See kernel implementation for details.
> >        * */
> > -     tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
> > -                MAP_SHARED, map_fd, rb->page_size);
> > +     ro_size = rb->page_size + 2 * (__u64)info.max_entries;
>
> [..]
>
> > +     if (ro_size != (__u64)(size_t)ro_size) {
> > +             pr_warn("ringbuf: ring buffer size (%u) is too big\n",
> > +                     info.max_entries);
> > +             return libbpf_err(-E2BIG);
> > +     }
>
> Why do we need this check at all? IIUC, the problem is that the expression
> "rb->page_size + 2 * info.max_entries" is evaluated as u32 and can
> overflow. So why doing this part only isn't enough?
>
> size_t mmap_size = rb->page_size + 2 * (size_t)info.max_entries;
> mmap(NULL, mmap_size, PROT_READ, MAP_SHARED, map_fd, ...);
>
> sizeof(size_t) should be 8, so no overflow is possible?

not on 32-bit arches, presumably?



>
>
> > +     tmp = mmap(NULL, (size_t)ro_size, PROT_READ, MAP_SHARED, map_fd,
> > +                rb->page_size);

should we split this mmap into two mmaps -- one for producer_pos page,
another for data area. That will presumably allow to mmap ringbuf with
max_entries = 1GB?

> >       if (tmp == MAP_FAILED) {
> >               err = -errno;
> >               ringbuf_unmap_ring(rb, r);
> > --
> > 2.29.2
>
