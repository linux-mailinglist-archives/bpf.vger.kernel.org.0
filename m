Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F271443955
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKBXJk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhKBXJk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 19:09:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF98C061714;
        Tue,  2 Nov 2021 16:07:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id o12so2067001ybk.1;
        Tue, 02 Nov 2021 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IzC/fM7D/0ocsFVOes4HmzPOfilROSHzYlPgHvWpoo=;
        b=E5unkfS0BlsVA9kmyguZAGH+vnNPvUtiIr3upp3Uh6v/X7DR14OK8AaR9a5tnaRw0c
         OtLu8z5A4uu5tO09glV9wio4iCRIOrV3KxRpkw2hL6KTrvXXf+jtZAi+xG7TXk8SPFq1
         ZAMv2pDUwNe78DkA9rpcqZHYdpyuX7jQ24gU8QAlkYkmq6ZsGn8c0DLtE4P5WUUVgZRl
         s2c4VC8r+tJCRPh6PUH6CWJnfKb2wZkMn3jC8ocw2Z6r2i5QhelrLD65ble9Kc6F3R21
         CHljEP00NJnH/WYoZqxMKE6Y7ypU/5vAYhtGjwlr5zm4jTTntl0J9oUMhH/2v5RXSbjb
         elng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IzC/fM7D/0ocsFVOes4HmzPOfilROSHzYlPgHvWpoo=;
        b=FW90jRj01URA60T9X8ySiiNoz2u6XxzQuD40kZAYKefw6hf2/SiPWLXB4txqWvjD0A
         WJU3ItIaXgagbk2D34nqOS7YJzEZQkm2C/UsI6rpDt6TKsqiBWepNEpAW3XDpIlD8Y+j
         6tTiH38CfTKMw8sOaS78Ha1nx+qFAupV54ApgxMjS8GWJLgWp/hefzsR3ggtf5OpYeWG
         1UnVl9VISXcPHbzI6Fg55BIsb5SUkChFnKXDr4dbJFXcdBGSgpy3RH03YYDXtHPTRxdS
         1YieSKPdfJLPaxf/ymKjcTYQRrLtZKi+evevFj5wFqFwjNyzHroVz+455BOJccFjE5Qm
         I13g==
X-Gm-Message-State: AOAM5325792bGjrU0LMJuH5D/1cXDhNbB3mKhRCZ2Rk51yB+24ZH4865
        0S2YMNq3YRw3pdreWNjoVLDpLNrVJLIrIjRhOo0=
X-Google-Smtp-Source: ABdhPJznotNbgoKCR+VKFqCmVIHUXTZJIyj+zW6gCM34TMptCQKXj+k5l3NQ11ZTuIL4mILuteXiG0yhvHTtXDgkMNA=
X-Received: by 2002:a25:d187:: with SMTP id i129mr31712440ybg.2.1635894423954;
 Tue, 02 Nov 2021 16:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
In-Reply-To: <20211101224357.2651181-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Nov 2021 16:06:52 -0700
Message-ID: <CAEf4BzY_OXyWdgJu=0phg0Pyb4PW6QWcKKBHLFOf=FwAmgOjqA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] libbpf: deprecate bpf_program__get_prog_info_linear
To:     Dave Marchevsky <davemarchevsky@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 1, 2021 at 3:46 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> bpf_program__get_prog_info_linear is a helper which wraps the
> bpf_obj_get_info_by_fd BPF syscall with some niceties that put
> all dynamic-length bpf_prog_info in one buffer contiguous with struct
> bpf_prog_info, and simplify the selection of which dynamic data to grab.
>
> The resultant combined struct, bpf_prog_info_linear, is persisted to
> file by 'perf' to enable later annotation of BPF prog data. libbpf
> includes some vaddr <-> offset conversion helpers for
> struct bpf_prog_info_linear to simplify this.
>
> This functionality is heavily tailored to perf's usecase, so its use as
> a general prog info API should be deemphasized in favor of just calling
> bpf_obj_get_info_by_fd, which can be more easily fit to purpose. Some
> examples from caller migrations in this series:
>
>   * Some callers weren't requesting or using dynamic-sized prog info and
>     are well served by a simple get_info_by_fd call (e.g.
>     dump_prog_id_as_func_ptr in bpftool)
>   * Some callers were requesting all of a specific dynamic info type but
>     only using the first record, so can avoid unnecessary malloc by
>     only requesting 1 (e.g. profile_target_name in bpftool)
>   * bpftool's do_dump saves some malloc/free by growing and reusing its
>     dynamic prog_info buf as it loops over progs to grab info and dump.
>
> Perf does need the full functionality of
> bpf_program__get_prog_info_linear and its accompanying structs +
> helpers, so copy the code to its codebase, migrate all other uses in the
> tree, and deprecate the helper in libbpf.
>
> Since the deprecated symbols continue to be included in perf some
> renaming was necessary in perf's copy, otherwise functionality is
> unchanged.
>
> This work was previously discussed in libbpf's issue tracker [0].
>
> [0]: https://github.com/libbpf/libbpf/issues/313
>
> v2->v3:
>   * Remove v2's patch 1 ("libbpf: Migrate internal use of
>     bpf_program__get_prog_info_linear"), which was applied [Andrii]
>   * Add new patch 1 migrating error checking of libbpf calls to
>     new scheme [Andrii, Quentin]
>   * In patch 2, fix != -1 error check of libbpf call, improper realloc
>     handling, and get rid of confusing macros [Andrii]
>   * In patch 4, deprecate starting from 0.6 instead of 0.7 [Andrii]

LGTM. Quentin, can you please take a look and ack as well? Thanks!

>
> v1->v2: fix bpftool do_dump changes to clear bpf_prog_info after use and
> correctly pass realloc'd ptr back (patch 2)
>
> Dave Marchevsky (4):
>   bpftool: Migrate -1 err checks of libbpf fn calls
>   bpftool: use bpf_obj_get_info_by_fd directly
>   perf: pull in bpf_program__get_prog_info_linear
>   libbpf: deprecate bpf_program__get_prog_info_linear
>
>  tools/bpf/bpftool/btf_dumper.c                |  42 +--
>  tools/bpf/bpftool/prog.c                      | 158 ++++++++---
>  tools/bpf/bpftool/struct_ops.c                |   2 +-
>  tools/lib/bpf/libbpf.h                        |   3 +
>  .../Documentation/perf.data-file-format.txt   |   2 +-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/annotate.c                    |   3 +-
>  tools/perf/util/bpf-event.c                   |  41 ++-
>  tools/perf/util/bpf-event.h                   |   2 +-
>  tools/perf/util/bpf-utils.c                   | 261 ++++++++++++++++++
>  tools/perf/util/bpf-utils.h                   |  76 +++++
>  tools/perf/util/bpf_counter.c                 |   6 +-
>  tools/perf/util/dso.c                         |   1 +
>  tools/perf/util/env.c                         |   1 +
>  tools/perf/util/header.c                      |  13 +-
>  15 files changed, 527 insertions(+), 85 deletions(-)
>  create mode 100644 tools/perf/util/bpf-utils.c
>  create mode 100644 tools/perf/util/bpf-utils.h
>
> --
> 2.30.2
>
