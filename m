Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D9444839
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKCSYN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 14:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhKCSYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 14:24:12 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE0C061714;
        Wed,  3 Nov 2021 11:21:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v64so8509602ybi.5;
        Wed, 03 Nov 2021 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/Y36oQavEUk/CbSUE4JbA9Hrj/lEJMM0pfmJWWGrTM=;
        b=cjJvonAMq6S5Fm6eXejLFz0NLccrMj4ycbJ9mVLV7hqChyl7sx/fpZdcLamS/Erqix
         DS9pwbZwoC2zldCibLTDntF3xS4wSFUUdAbS12EjvXOBt23dSpf60xXyTTO5SVSHF5P9
         iZN0JmNOh4Pg5g8BbJjMa1wpaaTjms77RwMEiJwkRGeRi52xH+FFpwzzc+nIlMpmJ5Y+
         VcHZXuGQmiF/bMSspjeqTZbBO0VnJMKuvZvEmL/NgRAoj85Rlq6SMlOMIf0G85X1dDvh
         JyHUPuod61UD/3ul0kVShmE2ku8cPzYkA0VNb4m6kpf9U2238NImnXhM9qq7DyoDChZ9
         B6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/Y36oQavEUk/CbSUE4JbA9Hrj/lEJMM0pfmJWWGrTM=;
        b=4L5l/dyKuxIBhZNAxeubRBvawYRwAJ1c/UT+G5pDyK5bYkrRYps+OaIfd9AxNhVxkv
         wsQ83s2sGeB1GJOTXVuXsByjDiwBxnZA6xRaB9k8VFQ6+2LTI7EvMhHw26940xElkxPh
         JEE/l3NvnWg6Qh01h+9TJlwmzrN/xuBULnetYx0QTtPD3Ameb3DMbbC8aBsXrkL1jD2y
         /PHd3tI2fp9KkrWMbxGVBu8ZCOv7eOYnxGGfiWZp+tXSkxgMVVIycJOsu0/+xKYOgNVF
         yH7j2HlEMbwXa7QR3PBH94qhR2bZOywrLxw+RPkaR0fGuu9EvF4TnRyRHSajJXHcBrq4
         QZ+w==
X-Gm-Message-State: AOAM531ngrT1eCzgnXHBQmwLbvwkJ4b+OkKYjCx497gSl/sAWIie0wSc
        ppqOezNhiWgq/JVBHzLNaQ880MDpZtwO5ROPFcg=
X-Google-Smtp-Source: ABdhPJyKY84MoemKz2Umdb4LiuzuPIrMMGhKY9VSXDlPsLmNLrHr9IqmH0xGvjNDKacU4WEe34pi7QWS6M+q7cHSNZY=
X-Received: by 2002:a25:d16:: with SMTP id 22mr41493565ybn.51.1635963694372;
 Wed, 03 Nov 2021 11:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
 <CAEf4BzY_OXyWdgJu=0phg0Pyb4PW6QWcKKBHLFOf=FwAmgOjqA@mail.gmail.com> <7c6a10fb-b1c5-4f50-8f7c-75c170e24ebb@isovalent.com>
In-Reply-To: <7c6a10fb-b1c5-4f50-8f7c-75c170e24ebb@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Nov 2021 11:21:23 -0700
Message-ID: <CAEf4BzaGcLTsG-7Wbp+R-Y45ZN29Ch2pUyBdOHvYMoXupUaYWg@mail.gmail.com>
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

On Wed, Nov 3, 2021 at 4:26 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> 2021-11-02 16:06 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > On Mon, Nov 1, 2021 at 3:46 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >>
> >> bpf_program__get_prog_info_linear is a helper which wraps the
> >> bpf_obj_get_info_by_fd BPF syscall with some niceties that put
> >> all dynamic-length bpf_prog_info in one buffer contiguous with struct
> >> bpf_prog_info, and simplify the selection of which dynamic data to grab.
> >>
> >> The resultant combined struct, bpf_prog_info_linear, is persisted to
> >> file by 'perf' to enable later annotation of BPF prog data. libbpf
> >> includes some vaddr <-> offset conversion helpers for
> >> struct bpf_prog_info_linear to simplify this.
> >>
> >> This functionality is heavily tailored to perf's usecase, so its use as
> >> a general prog info API should be deemphasized in favor of just calling
> >> bpf_obj_get_info_by_fd, which can be more easily fit to purpose. Some
> >> examples from caller migrations in this series:
> >>
> >>   * Some callers weren't requesting or using dynamic-sized prog info and
> >>     are well served by a simple get_info_by_fd call (e.g.
> >>     dump_prog_id_as_func_ptr in bpftool)
> >>   * Some callers were requesting all of a specific dynamic info type but
> >>     only using the first record, so can avoid unnecessary malloc by
> >>     only requesting 1 (e.g. profile_target_name in bpftool)
> >>   * bpftool's do_dump saves some malloc/free by growing and reusing its
> >>     dynamic prog_info buf as it loops over progs to grab info and dump.
> >>
> >> Perf does need the full functionality of
> >> bpf_program__get_prog_info_linear and its accompanying structs +
> >> helpers, so copy the code to its codebase, migrate all other uses in the
> >> tree, and deprecate the helper in libbpf.
> >>
> >> Since the deprecated symbols continue to be included in perf some
> >> renaming was necessary in perf's copy, otherwise functionality is
> >> unchanged.
> >>
> >> This work was previously discussed in libbpf's issue tracker [0].
> >>
> >> [0]: https://github.com/libbpf/libbpf/issues/313
> >>
> >> v2->v3:
> >>   * Remove v2's patch 1 ("libbpf: Migrate internal use of
> >>     bpf_program__get_prog_info_linear"), which was applied [Andrii]
> >>   * Add new patch 1 migrating error checking of libbpf calls to
> >>     new scheme [Andrii, Quentin]
> >>   * In patch 2, fix != -1 error check of libbpf call, improper realloc
> >>     handling, and get rid of confusing macros [Andrii]
> >>   * In patch 4, deprecate starting from 0.6 instead of 0.7 [Andrii]
> >
> > LGTM. Quentin, can you please take a look and ack as well? Thanks!
>
> Thanks Andrii for the Cc! I realised yesterday morning that I'd been hit
> by the unsubscription incident and missed v3 of this set.

Yeah, super unfortunate this unsubscription. Had to go through that as well.

>
> The changes look good to me, and you can add my tag to the first three
> patches:
>
> Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks, I will.

>
> Regarding patch 4, looking at the latest deprecations in libbpf, I would
> have expected the functions to be deprecated starting in v0.7, and not v0.6?

The reason to do it in upcoming v0.6 is because there are no
replacement APIs that we are going to wait for. No point in delaying
the inevitable just for the sake of delaying it.

>
> Other than that, on patch 2 (apologies for not answering inline), it
> would feel more natural, in do_dump()'s "for" loop in prog.c, to have
> the memset() above the call to bpf_obj_get_info_by_fd() (and to skip the
> zero-initialisation of "info") instead of at the end of the loop, which
> means a useless memset() just before we exit the loop. But probably not
> worth a respin just for that.

Yeah, that bothered me a bit as well, but if you are also mentioning
that I'll just move it up as you suggested, while applying. Thanks.

>
> Thanks,
> Quentin
