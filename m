Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA142128413
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 22:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLTVqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 16:46:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44577 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLTVqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 16:46:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id t3so9440155qtr.11;
        Fri, 20 Dec 2019 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bSdzqSkXy2nXKrE44xrkAYfd8o2O8DSa/j15qpE9Co=;
        b=g4aEh9wmRFPukc8H0VbSMU+nRgFidrf7tvKKSgoJm5bOpDkKDRVqwWYLvwECy9+HtH
         /3sIOIAR+wSs2NC6oFkB7VF0whKSuqwfNO7dr2BssU+TU9XNf8beVns8BDwKOaD5oct1
         ApENd3DW6j3pvabGA6UZ/WPCQ9QqCbXWlk0UPPxjBGmiPnIIeh46B5xsib+P+wSV3CH9
         mllX4zVM9kVuiugvM3AvW6BOf9NhYcNx4Aj4H7Q9LuQCkWYjjIiQj/KkMu4i/L+rCbf7
         9jwgWHbT6dQgG1/9nBJj5rrK7vuSEc7D9/8aXIKmyBnoVMawdsU/57Bv0fsnaIpTtlxp
         u+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bSdzqSkXy2nXKrE44xrkAYfd8o2O8DSa/j15qpE9Co=;
        b=eSdhQAA66h4wnOB3dUbd/IPLaGkocQrzX3vNspnJT2TmPJDjDJ7eMXk2zHG1YPdVn8
         PJgMfvU46Os1NCgmyGWei3JqaTcpXdZoIBtIVAS1jG1AppbleMw8VVc1kF5nIsvZv4Td
         apKtLBb7NYHe5VW9uxLpKe2P+BXAxQn9+iVWZTTf29Zagb/RPhilqdJ8NGuQHk7AYWc5
         RZn9KsrPW0gDbJLMOtWTHJhR+3Uhc3uV+9CFDlWY6hnUop2GUI4+bMZJqCIkldiVtZKY
         AwtwHz5QZ9l5HLnkgxrHo64rDsgp929YFr3+GgiHFZ79vFdhGGA9c7vHFvSHJPjlRoLu
         kQeg==
X-Gm-Message-State: APjAAAVFbab2V9diAqm8jVodpLgkA1E5SrWUuq2CQLYvdHCyNdHUHMm6
        g+dJwiH66cUg7iHWecgf3rK9oVSTtVrfSlqvtjw=
X-Google-Smtp-Source: APXvYqx+GcanRxNPtZNAZZT31/q/tW0ARwXqogjfBfw4b+WYyyK0iZRoAEgyqZDpjjWGd8JLTlmApcGiI0B+95LOloE=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr13543670qtj.117.1576878363657;
 Fri, 20 Dec 2019 13:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20191220032558.3259098-1-namhyung@kernel.org> <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
 <20191220204748.GA9076@kernel.org>
In-Reply-To: <20191220204748.GA9076@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Dec 2019 13:45:52 -0800
Message-ID: <CAEf4BzZW+bDxkdmXBJrrCHqBP5UT1NLJJ7mXLNqc6eypRCib6Q@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 20, 2019 at 12:47 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Dec 20, 2019 at 12:29:36PM -0800, Andrii Nakryiko escreveu:
> > On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > I got the following error when I tried to build perf on a read-only
> > > filesystem with O=dir option.
> > >
> > >   $ cd /some/where/ro/linux/tools/perf
> > >   $ make O=$HOME/build/perf
> > >   ...
> > >     CC       /home/namhyung/build/perf/lib.o
> > >   /bin/sh: bpf_helper_defs.h: Read-only file system
> > >   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
> > >   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
> > >   make[2]: *** Waiting for unfinished jobs....
> > >     LD       /home/namhyung/build/perf/libperf-in.o
> > >     AR       /home/namhyung/build/perf/libperf.a
> > >     PERF_VERSION = 5.4.0
> > >   make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > >   make: *** [Makefile:70: all] Error 2
> > >
> > > It was becaused bpf_helper_defs.h was generated in current directory.
> > > Move it to OUTPUT directory.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> >
> > Overall nothing is obviously broken, except you need to fix up
> > selftests/bpf's Makefile as well.
> >
> > BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.
> >
> > Also subject prefix should look like [PATCH bpf-next] if it's meant to
> > be applied against bpf-next.
>
> Shouldn't this be applied to the current merge window since a behaviour
> that people relied, i.e. using O= to generate the build in a separate
> directory, since its not possible to use the source dir tree as it is
> read-only is now broken, i.e. isn't this a regression?

Sure, it can be applied against bpf as well, but selftests still need
to be fixed first.

>
> - Arnaldo
>
> > >  tools/lib/bpf/Makefile | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> >
> > [...]
>
> --
>
> - Arnaldo
