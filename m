Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460CC35B34E
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhDKLNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKLNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 07:13:09 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD88C061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 04:12:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d12so6333879iod.12
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=N+N9Dws5It87kxQhfLpflORE8jB+LBoK7x++8LjMrsw=;
        b=PG7DKdkU5m6ereLhCwyJufFk0Bz0wNBnK41zhJe/k30YUtp2FZIkgEnGL2aH+smm0H
         AJ5vvWULTZkHbCGPywNmNwS/oJyUOUGI/islI+p8G2KaTAnLRY/3UHpOgea2jbqqpgmu
         K/vFPCYdcyzqaUsisa1E/L7ltV+KnBX4zQoQdDzXFkYMbp77lpeY9+m/I9oJKqCzu1/i
         XHxTeLr7BTzIDihf/B6+2PqIZPFCEmsJ7U0eeh9W7MZIieGYB4pLOezD6kSG+irfuadH
         pKOtWNEgRHnBCcYxxmFPnHUVoU7rmTy2/GzYKmctUI5N6rEehhEEkPCm6XF92wcWnxLU
         7Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=N+N9Dws5It87kxQhfLpflORE8jB+LBoK7x++8LjMrsw=;
        b=dRsQyMxxISjcxv8LGDJBbLP1hxFxypPnE2NmkoVfibgEEkVt3eRe4dDlTFondVFgAE
         35szWSBQ+ZqODSYZ52FHn8H8PVqVcRkSoACo9B26pMSb5bKbwq9SUGcMTAcQiZZQ6+4H
         Ac2esC2boZ54YErT5067RrnQ3l9Z6aSlbbNb3TCelBcXVzwDi5009lgEJVmGw/KKaurw
         ST9PpFsjbZkoTNVHqMaT6ZaWBRKbb8uH9rbgRxZ7k38KrKs4Ph14BQ87XSGx0WczVhU7
         OwNLRfqSdSWv5I0EhUkJXJGu4C/Sfyf9C9CEelKMdIo7JORXpjZdvKEKbhW0TYT7jlqb
         iemg==
X-Gm-Message-State: AOAM531dgyIOQyeTJpCNIiLV5ZKB3C1hdgOoC7Eb3gc4aVbKR98eF38f
        iNHjaTM2fEJXzRmN/hjS8Pv21KQ+G62j3gc38hw=
X-Google-Smtp-Source: ABdhPJwc7etrpCLRfWVYrC7sg4kpQGzy67PDrEXnjemzX/EudyCIUgdHHhpWXyujq4Qgwct7nRaK+Anar8nJEhjWjCk=
X-Received: by 2002:a6b:8bd3:: with SMTP id n202mr4963819iod.57.1618139572881;
 Sun, 11 Apr 2021 04:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164946.770575-1-yhs@fb.com>
In-Reply-To: <20210410164946.770575-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 13:12:16 +0200
Message-ID: <CA+icZUXZY+dhv+JHnpiz+tkN4T9f2XCd02Btp9QGRfnT2n6qBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: silence clang compilation warnings
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>
> With clang compiler:
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> Some linker flags are not used/effective for some binaries and
> we have warnings like:
>   warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]
>
> We also have warnings like:
>   .../selftests/bpf/prog_tests/ns_current_pid_tgid.c:74:57: note: treat the string as an argument to avoid this
>         if (CHECK(waitpid(cpid, &wstatus, 0) == -1, "waitpid", strerror(errno)))
>                                                                ^
>                                                                "%s",
>   .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK'
>         _CHECK(condition, tag, duration, format)
>                                          ^
>   .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHECK'
>                 fprintf(stdout, ##format);                              \
>                                   ^
> Let us add proper compilation flags to silence the above two kinds of warnings.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bbd61cc3889b..a9c0a64a4c49 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -24,6 +24,8 @@ SAN_CFLAGS    ?=
>  CFLAGS += -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)             \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)                      \
> +         -Wno-unused-command-line-argument                             \
> +         -Wno-format-security                                          \

Are both compliler flags available for GCC (I simply don't know or
have checked)?

- Sedat -

>           -Dbpf_prog_load=bpf_prog_test_load                            \
>           -Dbpf_load_program=bpf_test_load_program
>  LDLIBS += -lcap -lelf -lz -lrt -lpthread
> --
> 2.30.2
>
