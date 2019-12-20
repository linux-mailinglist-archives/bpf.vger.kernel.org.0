Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC92128343
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLTU3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 15:29:48 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40488 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfLTU3s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 15:29:48 -0500
Received: by mail-qv1-f67.google.com with SMTP id dp13so4118814qvb.7;
        Fri, 20 Dec 2019 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALZvCGRBc2l/q2Q2l/6VTahATMuAjJCgu9dbrx9svio=;
        b=hlzU591vBI0dQ5OldfwXjC4lkf6yQYUI+OpfOSPwBwodSgsqJVidpsnzPfgxiqkl0n
         zF/bDm3YWERMac79EU9o0yhIzqstQyyNp2z+5cH91T8PgTZV4VBr3Q+AQTdS55e6xNKK
         FcCOLMo26IG6GRrzS/XjF/6Sg6Eksxg4rdNrn15DjjWJqscybnLR75zNoMonNOnW1QAm
         ziqlRVsGc0CGnKKI4SRWg0NXU8xR6qhkkreE0tTskS25gNGCbHGnOXNZUoDj6E98ldED
         5ytXg+a2qbzrCa9lbm97QnfJ26+9NO5OqD4Z6LL0LwZM/tnqre3+eFHRU27TjvIkZ803
         8Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALZvCGRBc2l/q2Q2l/6VTahATMuAjJCgu9dbrx9svio=;
        b=GhgQ/PkEewMCN8RG0l+IhxRcDsl/fULE/ZF71y2BDi44uHcQP+Y1riTm0tbEjq8M3S
         tiyhKJDIL4m2If6qnb+2JAnMAc6WGtqGHCHSRGPnkXEPM4eI8AMNkz/Kjd3YbVXS+Tet
         zeaOAylPBzz0JoZ56bBBmEDrvu0nu5tDAdMfryicLO/4UJmU1WPsYivwuf4v8YqRVJYd
         BN//Tt3gHbCgi8j7xLrfDmMkwNEhp8k4UOwdQExZeO3iAN1zCDu6q9/sG55GZm5v1FbV
         z3B4P6mUkdVTlQEUgp2VEPiJDG0/B6eTP8xY1mOXYfN1AbCb4bc5g9KkIGauX7r/jxlb
         Wihg==
X-Gm-Message-State: APjAAAW7zBm3mRSzwgXeuX4Kpt8aWZJGL+80MOJ4wfeiQeY/g+5tU98t
        37qSHRcfnW13b48n8yFemVGngN3f8+u8Ceo+EbY=
X-Google-Smtp-Source: APXvYqzcDx1ey7RKkeMNmZlsAxZUVSqhfumTrgWMVBmpAQ5jorT6X6cDKHw60AKGF1oTKMU7YO4SYnnKu1ZhWxlS70E=
X-Received: by 2002:a0c:990d:: with SMTP id h13mr13853458qvd.247.1576873787480;
 Fri, 20 Dec 2019 12:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20191220032558.3259098-1-namhyung@kernel.org>
In-Reply-To: <20191220032558.3259098-1-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Dec 2019 12:29:36 -0800
Message-ID: <CAEf4BzaZBSRK2M4LD-c12_2-QLa8+jpPs1E4nA9BNeUDskOMBQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Fix build on read-only filesystems
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 19, 2019 at 7:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I got the following error when I tried to build perf on a read-only
> filesystem with O=dir option.
>
>   $ cd /some/where/ro/linux/tools/perf
>   $ make O=$HOME/build/perf
>   ...
>     CC       /home/namhyung/build/perf/lib.o
>   /bin/sh: bpf_helper_defs.h: Read-only file system
>   make[3]: *** [Makefile:184: bpf_helper_defs.h] Error 1
>   make[2]: *** [Makefile.perf:778: /home/namhyung/build/perf/libbpf.a] Error 2
>   make[2]: *** Waiting for unfinished jobs....
>     LD       /home/namhyung/build/perf/libperf-in.o
>     AR       /home/namhyung/build/perf/libperf.a
>     PERF_VERSION = 5.4.0
>   make[1]: *** [Makefile.perf:225: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>
> It was becaused bpf_helper_defs.h was generated in current directory.
> Move it to OUTPUT directory.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

Overall nothing is obviously broken, except you need to fix up
selftests/bpf's Makefile as well.

BTW, this patch doesn't apply cleanly to latest bpf-next, so please rebase.

Also subject prefix should look like [PATCH bpf-next] if it's meant to
be applied against bpf-next.

>  tools/lib/bpf/Makefile | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>

[...]
