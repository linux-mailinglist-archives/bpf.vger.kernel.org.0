Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40224512235
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiD0TOp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiD0TOK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 15:14:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3651E8F1A3
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 12:04:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t4so583134ilo.12
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 12:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IEiyj6iYS64RcqScEGEmFRIBA6kU45FZwvezAc1nDI=;
        b=EpEyQZjYA37TOudM035S9jYRjQRGdi9jmQ2sLFO7W0TbYcpfajMlFocsm/MKoYhxsh
         XwfHxx2+0kdWFAlo+ZVftTAbpXkbS0ts2oRWguJVfWLNvhwa+ZJuMMNxIzEwri+i1HLZ
         uqUuKUhknzIQ8xJ+uCQJx1bqTgJNr3QcCWmPvDRMVBIBJLn7sKDrmtZ3rBVjBvyh25P1
         sF/TzhZ1eAiTbx1V2zf1UjYkGptuaaUmrZsdtPUSGJofsfWUzE0ORXytHc+pgnCQ2bHt
         aSsARrc8q03VGq/yj0m3qjW8A+l7jDpKok0TmeKx+S49hSzcwq5N3syPl3f8cDEoBT5x
         +IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IEiyj6iYS64RcqScEGEmFRIBA6kU45FZwvezAc1nDI=;
        b=1pV6qDpC6uPXpGoRdg+dJISBklqE2ih8AMvyGbBfLq9i09kGVk1EfhSxGkWkHEPG8q
         VDYV4KcROSy9/27WvHPCBe7a+vRqpn2X1+TkOFsFu2n4jtSiY7nTtixSyOTL2kodVGNu
         Jv79N1YgbwLd/KNWXoY8uLAkXqWp6P9dDRoqWutJrFyeqloVsI/HamN5K7VjtB2uPGpo
         FmHCJcI4X3K2TlITD0+PdTMO4wjaPXplkV9bZl1v0tj0CT1M8IoHxD2lCC+tS2OENl1R
         zv1sGkT+0/jFvAjxnR/8WmasUTlvKRaJj3RTFAsa+cHJFY6VDneGGuVWwjVf2TixQVja
         vRKA==
X-Gm-Message-State: AOAM531m5e0cTj77CR9wNZNGIQg3sC5o41Bz703Js7KbCRnkYfzVzNkJ
        YsiuQmLV96bC9z7lF0AAq+EW4PoRsK3sL++Xh25a46nu
X-Google-Smtp-Source: ABdhPJzbxMhiGPgDrz71b7j5nd6DTiBwynNlJG8BVb3njfaQh7uefOC94+krW2wqRAxx/O2tIwPs4VA5H8NVVKhooEc=
X-Received: by 2002:a92:cd8d:0:b0:2cd:81ce:79bd with SMTP id
 r13-20020a92cd8d000000b002cd81ce79bdmr8474845ilb.252.1651086292643; Wed, 27
 Apr 2022 12:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220422182254.13693-1-9erthalion6@gmail.com>
In-Reply-To: <20220422182254.13693-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Apr 2022 12:04:41 -0700
Message-ID: <CAEf4Bza4-50p8-TsjsvjnVzEYYHZMBk_yq5Kb2AvJ3gnBp4Xeg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/2] bpf: bpf link iterator
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
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

On Fri, Apr 22, 2022 at 11:23 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Bpf links seem to be one of the important structures for which no
> iterator is provided. Such iterator could be useful in those cases when
> generic 'task/file' is not suitable or better performance is needed.
>

Overall looks good, I'll defer to Yonghong to validate kernel-side
iterator logic. Yonghong, can you please take a look? Thanks!

> The implementation is mostly copied from prog iterator, and I would like
> to get any high-level feedback about what needs to be different or have
> to be taken into account. As a side note, I would also appreciate if
> someone could point me out to some guide about writing selftests for bpf
> subsystem -- for some unclear reason I couldn't compile the test from
> this changeset, and was testing it only manually with a custom test
> program.
>

What was the error? Generally, you need very recent Clang (probably
built from sources), latest pahole built from sources, and you should
compile kernel before building selftests/bpf.


> Dmitrii Dolgov (2):
>   bpf: Add bpf_link iterator
>   selftests/bpf: Add bpf_link test
>
>  include/linux/bpf.h                           |   1 +
>  kernel/bpf/Makefile                           |   2 +-
>  kernel/bpf/link_iter.c                        | 107 ++++++++++++++++++
>  kernel/bpf/syscall.c                          |  19 ++++
>  .../selftests/bpf/prog_tests/bpf_iter.c       |  15 +++
>  .../selftests/bpf/progs/bpf_iter_bpf_link.c   |  18 +++
>  6 files changed, 161 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/link_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c
>
> --
> 2.32.0
>
