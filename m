Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43E4F0D32
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357563AbiDDATx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 20:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347200AbiDDATx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 20:19:53 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32735AB8
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 17:17:57 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r11so5785221ila.1
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 17:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUsEXYrrl2LaEcRfw2qkU+XltYNiTQsT5u14BCswPxM=;
        b=NR0p0vyE4ADKwpvZFbrE0ke1nH6GxXdGQrp7ETwZnv+yCMckcO8cngKg+tyWWyY5I/
         00r/6YlrXcomkEcZmuHG4BO4HgMnxU5Ly6QizjG++V8awMZxL1c1VJ2rJypIj/ztmKOi
         jIEsHs1v53F/nIK/d4JVPJECfTwWuU4GSRsVCLYD240HQX4JWUxTbVM661V0evbBdeip
         eUhBgIDJ1mAfkSZqa0RdG9Zo3uiky6/2kpNN3nCKzcWAfCVfzJ2I+RVu8/Xs7VeojN13
         C4VnGAb9zN/YotXTvjQok7K9h9apCXfPRbHhT1xGgxuy7wgmTXnqBCFsYCg4xrgvp7fJ
         T8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUsEXYrrl2LaEcRfw2qkU+XltYNiTQsT5u14BCswPxM=;
        b=sfabfXylD8V4U93qjd7i271K1oPka2kyO1664pjDpqjVi5JJwDJLuW19iWCrnVxQ7A
         Aq7cSTWTLyNdfuUTTaJIXwetGUugCj/4UMtijuUbCiHYewPV4shnKFQBMbUAuWFzrt1Z
         Av4bXT/9z7WGB76ELmXbsxWp+Uh9bFWHpngfQ07x4OCi2nHQ831zeeCcFuCXSFx5wLH5
         pLHGb1HB+owmMcvBrIkLKFxdSqDDps/JbHpWQxHjN1xboJzXmsKOhYVe4YMne1bs+23i
         C2v7T7vNOB8qyqFFBiykr9S3fqv2leZC6Thryu95jSIYdZkkcvMCCV1ScSmzF5j1DE9Z
         BsNg==
X-Gm-Message-State: AOAM533U9cLFwLWYlHRct80ERKionbVCIQUVDXJK6+CIeojKWOGB7E1X
        6jyTHUmgvL6E/zpLjeHY+Psdva5DwW2AkLX7yo+CG6f6
X-Google-Smtp-Source: ABdhPJyt54XcAG1BpuDr7xb9D/TC9x7Fn0g39I80hVxKnbQMZgPL/lsxAotWzMuuFygeZTO3pM26ebcUENukGtxcoS8=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr4239429ilb.305.1649031476990; Sun, 03
 Apr 2022 17:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220403160718.13730-1-9erthalion6@gmail.com>
In-Reply-To: <20220403160718.13730-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Apr 2022 17:17:46 -0700
Message-ID: <CAEf4BzZ7=AfL5fAU8aYT20RWY9tG5qU+Fgv-JC0GTLpGOGgAEg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Priorities for bpf progs attached to the
 same tracepoint
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>
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

On Sun, Apr 3, 2022 at 9:08 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> With growing number of various products and tools using BPF it could
> easily happen that multiple BPF programs from different processes will
> be attached to the same tracepoint. It seems that in such case there is
> no way to specify a custom order in which those programs may want to be
> executed -- it will depend on the order in which they were attached.
>
> Consider an example when the BPF program A is attached to tracepoint T,
> the BFP program B needs to be attached to the T as well and start
> before/end after the A (e.g. to monitor the whole process of A +
> tracepoint in some way).  If the program A could not be changed and is
> attached before B, the order specified above will not be possible.
>
> One way to address this in a limited, but less invasive way is to
> utilize link options structure to pass the desired priority to
> perf_event_set_bpf_prog, and add new bpf_prog into the bpf_prog_array
> based on its value. This will allow to specify the priority value via
> bpf_tracepoint_opts when attaching a new prog.
>
> Does this make sense? There maybe a better way to achieve this, I would
> be glad to hear any feedback on it.

Not really. What's the real use case where you need to define relative
order of BPF programs on the same kprobe or tracepoint. Each of them
is supposed to be independent of each other and not depend on any
order of their execution. Further, given such tracing programs are
read-only relative to the kernel (they can't change kernel behavior),
the order is supposed to be irrelevant.

>
> Dmitrii Dolgov (2):
>   bpf: tracing: Introduce prio field for bpf_prog
>   libbpf: Allow setting bpf_prog priority
>
>  drivers/media/rc/bpf-lirc.c    |  4 ++--
>  include/linux/bpf.h            |  3 ++-
>  include/linux/trace_events.h   |  7 ++++---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/core.c              | 19 +++++++++++++++++--
>  kernel/bpf/syscall.c           |  3 ++-
>  kernel/events/core.c           |  8 ++++----
>  kernel/trace/bpf_trace.c       |  8 +++++---
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/bpf.c            |  1 +
>  tools/lib/bpf/bpf.h            |  1 +
>  tools/lib/bpf/libbpf.c         |  4 +++-
>  tools/lib/bpf/libbpf.h         |  6 ++++--
>  13 files changed, 47 insertions(+), 19 deletions(-)
>
> --
> 2.32.0
>
