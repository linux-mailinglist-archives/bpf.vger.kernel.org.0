Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AECC4448A3
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 19:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhKCSxo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCSxn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 14:53:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA1AC061714;
        Wed,  3 Nov 2021 11:51:06 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y3so8748533ybf.2;
        Wed, 03 Nov 2021 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yw3M8NVGUaiaF6RQboKd6RTjrXvJsqFSMX2x6M9gO7o=;
        b=EGkhfZFZ1h80LT4AZAOyLqRsLxXr90QPNH/ElTNArWXioFgjxzTGBhprpdF+SIbUU8
         xYdFE7ESTvfP2BxXHX1OI4PqxXfPhjGOn/8tG+gPJton1d8a7cVmOOhEnMexhsneg7Sp
         NzUcAhqNgkAH3Ap/cOfxAzWfH0XkImpeUhLCQ8Li8HcCkcH7yuK7yAkOYS1xVvxY1Q6+
         mwFbPpNBvgg6rUl2xx3dOTgF10jAsdx7mbPyQGGLGTKGbv3FHiu9dwkMEc0lxxOSrsDy
         cHqmx8wkMVvf4kFGscb9tPCLLbPspzgPuXLbM+79SFxGi9mj2/qUP5rJL6SzGEsJiLz5
         4I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yw3M8NVGUaiaF6RQboKd6RTjrXvJsqFSMX2x6M9gO7o=;
        b=mrwD9vehSdNUJa1MSTW43AjG3NOnpw8Tx3+cUbywZ6Txd0ihpSCepZv9kMW1NIx/M6
         sVnSkcWYXrUS7UUQvrJHhOn6m+4Nt2tJeRU8ByVQ02xcaLD2Mxa6jy9Tsi47WFOttQFe
         9l5bt8MjGS6yo5CJNtcblpIPHHrpOOE8ilaH+5+UKSTOHjvtSGx0DDrANX9nvFEfF9Ln
         Ir50/7BaPHjyBe96xLl+skbTvOqMuiLe3cbbDqUHjdL/SHu5Szfgm8d5eAQiu6FNSFXa
         EFKPYvdVZj0wgvR5k9mndMxOiZ4XyC/7X51qbvPnY5Bq5iAeQ8eSMdK9UwxkHKGAIhgh
         Hp6w==
X-Gm-Message-State: AOAM532IU87mZClnxB8lJaNj9GVbjpxN9D/+xNiA8Y9BvjmB2rfhA5aX
        KUN1gPRPCC8Isxou7Lh+kDCxQgRbETBMDNPSrqk=
X-Google-Smtp-Source: ABdhPJwo/NTzJ10taWClmCG9M2kZ7TiS5mmNQJuGgFZWgASg4bXE0LZNq40SIPaS0Kx5eIlCnnas3/CRFQFlwpXRyLE=
X-Received: by 2002:a25:d16:: with SMTP id 22mr41679749ybn.51.1635965465937;
 Wed, 03 Nov 2021 11:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
 <CAEf4BzY_OXyWdgJu=0phg0Pyb4PW6QWcKKBHLFOf=FwAmgOjqA@mail.gmail.com>
 <7c6a10fb-b1c5-4f50-8f7c-75c170e24ebb@isovalent.com> <CAEf4BzaGcLTsG-7Wbp+R-Y45ZN29Ch2pUyBdOHvYMoXupUaYWg@mail.gmail.com>
In-Reply-To: <CAEf4BzaGcLTsG-7Wbp+R-Y45ZN29Ch2pUyBdOHvYMoXupUaYWg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Nov 2021 11:50:53 -0700
Message-ID: <CAEf4BzamZ06oN4vezW1_L1Yn2hmA9SHn5Ch+JgjwqRbg08Yegg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] libbpf: deprecate bpf_program__get_prog_info_linear
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
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

On Wed, Nov 3, 2021 at 11:21 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 3, 2021 at 4:26 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >
> > 2021-11-02 16:06 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > On Mon, Nov 1, 2021 at 3:46 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >>
> > >> bpf_program__get_prog_info_linear is a helper which wraps the
> > >> bpf_obj_get_info_by_fd BPF syscall with some niceties that put
> > >> all dynamic-length bpf_prog_info in one buffer contiguous with struct
> > >> bpf_prog_info, and simplify the selection of which dynamic data to grab.
> > >>
> > >> The resultant combined struct, bpf_prog_info_linear, is persisted to
> > >> file by 'perf' to enable later annotation of BPF prog data. libbpf
> > >> includes some vaddr <-> offset conversion helpers for
> > >> struct bpf_prog_info_linear to simplify this.
> > >>
> > >> This functionality is heavily tailored to perf's usecase, so its use as
> > >> a general prog info API should be deemphasized in favor of just calling
> > >> bpf_obj_get_info_by_fd, which can be more easily fit to purpose. Some
> > >> examples from caller migrations in this series:
> > >>
> > >>   * Some callers weren't requesting or using dynamic-sized prog info and
> > >>     are well served by a simple get_info_by_fd call (e.g.
> > >>     dump_prog_id_as_func_ptr in bpftool)
> > >>   * Some callers were requesting all of a specific dynamic info type but
> > >>     only using the first record, so can avoid unnecessary malloc by
> > >>     only requesting 1 (e.g. profile_target_name in bpftool)
> > >>   * bpftool's do_dump saves some malloc/free by growing and reusing its
> > >>     dynamic prog_info buf as it loops over progs to grab info and dump.
> > >>
> > >> Perf does need the full functionality of
> > >> bpf_program__get_prog_info_linear and its accompanying structs +
> > >> helpers, so copy the code to its codebase, migrate all other uses in the
> > >> tree, and deprecate the helper in libbpf.
> > >>
> > >> Since the deprecated symbols continue to be included in perf some
> > >> renaming was necessary in perf's copy, otherwise functionality is
> > >> unchanged.
> > >>
> > >> This work was previously discussed in libbpf's issue tracker [0].
> > >>
> > >> [0]: https://github.com/libbpf/libbpf/issues/313
> > >>
> > >> v2->v3:
> > >>   * Remove v2's patch 1 ("libbpf: Migrate internal use of
> > >>     bpf_program__get_prog_info_linear"), which was applied [Andrii]
> > >>   * Add new patch 1 migrating error checking of libbpf calls to
> > >>     new scheme [Andrii, Quentin]
> > >>   * In patch 2, fix != -1 error check of libbpf call, improper realloc
> > >>     handling, and get rid of confusing macros [Andrii]
> > >>   * In patch 4, deprecate starting from 0.6 instead of 0.7 [Andrii]
> > >
> > > LGTM. Quentin, can you please take a look and ack as well? Thanks!
> >
> > Thanks Andrii for the Cc! I realised yesterday morning that I'd been hit
> > by the unsubscription incident and missed v3 of this set.
>
> Yeah, super unfortunate this unsubscription. Had to go through that as well.
>
> >
> > The changes look good to me, and you can add my tag to the first three
> > patches:
> >
> > Acked-by: Quentin Monnet <quentin@isovalent.com>
>
> Thanks, I will.
>
> >
> > Regarding patch 4, looking at the latest deprecations in libbpf, I would
> > have expected the functions to be deprecated starting in v0.7, and not v0.6?
>
> The reason to do it in upcoming v0.6 is because there are no
> replacement APIs that we are going to wait for. No point in delaying
> the inevitable just for the sake of delaying it.
>
> >
> > Other than that, on patch 2 (apologies for not answering inline), it
> > would feel more natural, in do_dump()'s "for" loop in prog.c, to have
> > the memset() above the call to bpf_obj_get_info_by_fd() (and to skip the
> > zero-initialisation of "info") instead of at the end of the loop, which
> > means a useless memset() just before we exit the loop. But probably not
> > worth a respin just for that.
>
> Yeah, that bothered me a bit as well, but if you are also mentioning
> that I'll just move it up as you suggested, while applying. Thanks.
>

Applied to bpf-next, thanks.

> >
> > Thanks,
> > Quentin
