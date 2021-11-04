Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52592445916
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhKDR7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDR7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 13:59:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F5C061714;
        Thu,  4 Nov 2021 10:56:39 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y3so16424893ybf.2;
        Thu, 04 Nov 2021 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPStDFw2+0Lg1MlhJeEQxDNPEkzqlTJMn986ZZm8lCI=;
        b=R1JRU1dkj1w1IkWHjbEg9yW6MSnPMZbaCvsFkQDqHVKxvueaG2XyfoMU5DcuqsXpeC
         HOKAvCBqZvSaLMr9SlfoAOQFUIG4ayd2Lw6xeYrsSugSQjV6mHvbFUrx6cJCeAqTln86
         MREFbbBslBCSNwBTPOnzWMru5sI/d5TDHhSdcSc6w/ZdaQkbkmWj6HK0jh0/fZ8A+J4H
         FIOPeuQMtjlRvT6s2xac0DQzeTJ8lUq0DGJuUfdscWDb62un0+P7g/AA+x5FsDT70BAW
         8Fvy1NdmlIaAZx9MYiiFenQqvPvl5L7gzksNjlX+Vmj/bc/ehc9fMswQLVzaq8JKDV0s
         DHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPStDFw2+0Lg1MlhJeEQxDNPEkzqlTJMn986ZZm8lCI=;
        b=S0Vmn476Yny+5oQkxQ3zMk/wdPupe9KKGpsjx7bP8ZE2XosoE1uBecffLMGfuxCwxY
         WbV1Vm6Lo57irT7oZzgkhzJ16pRqsWmh8Brce2WO8p+j73NSTJLijDsrsOl9p3VIg94r
         S3HxlEtQ+Ennr2cE8vgZieC6KvDCbeFNSyzcfx/PzUMhnWwNkvico1vWZlJexFbwSaWb
         fNbMlwReqhGUWt+w1zHej7/WiLMQBGnpMBaaZVyMvlrE+qqPtAwY9e0BK/YULhueVttP
         DjFliQ5g+hFlfe4gwJvyxMGtPMU6fsbwrpX6JWGPE+KfhitcHNgTE/R8mLF+jbfyuxUJ
         kZEQ==
X-Gm-Message-State: AOAM531b8rY7HAw/SxBFBzLHP5Mt7KUVICuAZ7i7rvUEcJK20m5h9n29
        pXc08qKtWvEBfzMVafDgUzw201crCPnmn4NwU9Q=
X-Google-Smtp-Source: ABdhPJyoUTC6m0SVMW0LmcU8OPfPkyCsQ/bryAweQHZwjiqWdl052MN6XoC0o9UFkY6soBsuhHTaziQ2blBSHf7Fs38=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr55747145ybf.114.1636048597996;
 Thu, 04 Nov 2021 10:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <YYQadWbtdZ9Ff9N4@kernel.org> <YYQdKijyt20cBQik@kernel.org>
In-Reply-To: <YYQdKijyt20cBQik@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 Nov 2021 10:56:26 -0700
Message-ID: <CAEf4BzYtq5Fru0_=Stih+Tjya3i29xG+RSF=4oOT7GbUwVRQaQ@mail.gmail.com>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge with upstream
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 4, 2021 at 10:49 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Nov 04, 2021 at 02:37:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> >
> > Hi Song,
> >
> >       I just did a merge with upstream and I'm getting this:
> >
> >   LINK    /tmp/build/perf/plugins/plugin_scsi.so
> >   INSTALL trace_plugins
>
> To clarify, the command line to build perf that results in this problem
> is:
>
>   make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin

Oh, I dropped CORESIGN and left BUILD_BPF_SKEL=1 and yeah, I see the
build failure. I do think now that it's related to the recent Makefile
revamp effort. Quentin, PTAL.

On the side note, why BUILD_BPF_SKEL=1 is not a default, we might have
caught this sooner. Is there any reason not to flip the default?

>
> > Auto-detecting system features:
> > ...                        libbfd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                        libcap: [ on  ]
> > ...               clang-bpf-co-re: [ on  ]
> >
> >

[...]
