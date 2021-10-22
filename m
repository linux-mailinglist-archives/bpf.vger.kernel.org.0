Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B367C4380B9
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 01:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhJVXm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 19:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJVXmY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 19:42:24 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B3C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 16:40:06 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l201so10362668ybl.9
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioiQdv2d9YcnzAxy5W3iTM9ddA3jiAp6jAJXvGbAt6w=;
        b=jx1IRyIuucjHNTzaGWhf6ArI7mg+Hiiq3j1LGPvZHkZWHuJRQICY19Uz1w6JpKI30q
         jYJbei2C9hUh9pyc52w66L2MaoHyeTzdzmX+zZdBK/cFiBii2hBXvPxLeOo0vWOoivo3
         bA6WLGOchwst+rGeyXwwarUosdRYaoLFSQy2e9fs/5oMZBWzovrDJXPZGYIVHjVXhxAE
         O93Cs5cm+tJKRspXFhmMggksBX2vmpasa4TOcP47rRVvouMVj6k7J26JbmKdtHS8EvZ9
         IzZ+CzcV/lL0/jCnuwpaBldkIzDwujf0DOsz3yqfB25XqNrXr4b2Hc89B73hAiwp2DhT
         5PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioiQdv2d9YcnzAxy5W3iTM9ddA3jiAp6jAJXvGbAt6w=;
        b=JfS69on91TqFvc1jf+9dF9syXr/lxuxjBcDd/X2wwhRQ9zRLFxO6TL6S3fIcHbII0Y
         bBlI/avM2OhVUYMrsLCsxaACNtOn8yAwUV9BOoxfO/a1xq0wIOxnjWMvojmJiu8HJzUy
         mtYjNUXlhiQcB9S4lfsfCwg4RhKmxh+fKNYDYPJSR3PNUu8ed6d7Ohl/KZhzBU+HSHn4
         Kz1DJb8JaTmo0anT5CvTtzXw/xCczH0MLmW1tvq9hfDaqUjCSW3DfqqklxEFawxN1XDa
         UvF4KP1CQ7PBcwmIUftp9U4M/ALRI8N3kmGjM752xeSqUibuW6Ifdp7vPlcQw1Z4tkkq
         mRSw==
X-Gm-Message-State: AOAM5308emEMb5zCukmVtseT1VOtSyfnt9FYQBUvezRCq9i1pAhCX7uC
        wyalNkyk8MbuRzfjiNCigV5Y175BV+to/YCKPm/VnOtn3Vo=
X-Google-Smtp-Source: ABdhPJwEHUHqRmcv5CbGcPeDf19umnHW7lSrfh7E4HTFqUVWNKoHbvm6LzdFe38ocow0BCXkhr/X+HqLwwYgWFMwKp8=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr2759022ybj.433.1634946005254;
 Fri, 22 Oct 2021 16:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211022130623.1548429-1-hengqi.chen@gmail.com>
In-Reply-To: <20211022130623.1548429-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Oct 2021 16:39:54 -0700
Message-ID: <CAEf4BzYmp_yfExLYO0r6XRuEBC+C=V_Dmhb0t5gcPVF-uXCmOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5 v2] libbpf: Add btf__type_cnt() and
 btf__raw_data() APIs
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 6:06 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add btf__type_cnt() and btf__raw_data() APIs and deprecate
> btf__get_nr_type() and btf__get_raw_data() since the old APIs
> don't follow libbpf naming convention. Also update tools/selftests
> to use these new APIs. This is part of effort towards libbpf v1.0
>
> v1->v2:
>  - Update commit message, deprecate the old APIs in libbpf v0.7 (Andrii)
>  - Separate changes in tools/ to individual patches (Andrii)
>

Applied to bpf-next, thanks.

> Hengqi Chen (5):
>   libbpf: Add btf__type_cnt() and btf__raw_data() APIs
>   perf bpf: Switch to new btf__raw_data API
>   tools/resolve_btfids: Switch to new btf__type_cnt API
>   bpftool: Switch to new btf__type_cnt API
>   selftests/bpf: Switch to new btf__type_cnt/btf__raw_data APIs
>
>  tools/bpf/bpftool/btf.c                       | 12 +++----
>  tools/bpf/bpftool/gen.c                       |  4 +--
>  tools/bpf/resolve_btfids/main.c               |  4 +--
>  tools/lib/bpf/btf.c                           | 36 +++++++++++--------
>  tools/lib/bpf/btf.h                           |  4 +++
>  tools/lib/bpf/btf_dump.c                      |  8 ++---
>  tools/lib/bpf/libbpf.c                        | 36 +++++++++----------
>  tools/lib/bpf/libbpf.map                      |  2 ++
>  tools/lib/bpf/linker.c                        | 28 +++++++--------
>  tools/perf/util/bpf-event.c                   |  2 +-
>  tools/testing/selftests/bpf/btf_helpers.c     |  4 +--
>  tools/testing/selftests/bpf/prog_tests/btf.c  | 10 +++---
>  .../selftests/bpf/prog_tests/btf_dump.c       |  8 ++---
>  .../selftests/bpf/prog_tests/btf_endian.c     | 12 +++----
>  .../selftests/bpf/prog_tests/btf_split.c      |  2 +-
>  .../selftests/bpf/prog_tests/core_autosize.c  |  2 +-
>  .../selftests/bpf/prog_tests/core_reloc.c     |  2 +-
>  .../selftests/bpf/prog_tests/resolve_btfids.c |  4 +--
>  18 files changed, 97 insertions(+), 83 deletions(-)
>
> --
> 2.30.2
