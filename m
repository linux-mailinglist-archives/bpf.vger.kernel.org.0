Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071F435E8C4
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDMWIV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhDMWIV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 18:08:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761DC061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:08:00 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y2so17770726ybq.13
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpvpsMiE8x2EQYt0LszCFHNufodZU5Qfra6iRGbLVMs=;
        b=aqKPDPd6FwUEExI+aS6suoJvqHJsS27pk31ymhkwghgNObhj3A2TSY4KL2YdQwfMd+
         E1/hZkQMzIHAiPS4F14/U3RvupfRcSsOyiv0rSpbJuZQjBVLNrgAOIVDH0I3R3vtG5AD
         rkKW7KXTL6gWmXpVVLkQj6rlEnBCS9bnq+0M4kO7S6xX5X3OqolHsHCYi9pDGr1EcizA
         JD7PgTxXv35VMr3VEPoXWx6xp3qy2TZsycOZodFm0VJ4FOlesJEQspMKCmtssar8rIYL
         lYF+BJcVpVVGLxoie6+ADhPFzv+2kLD0Bd6jqEJW3cz54/ki5CwYgGKuIQW3zUgvjtH1
         YQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpvpsMiE8x2EQYt0LszCFHNufodZU5Qfra6iRGbLVMs=;
        b=XgLp11R7Rf0NEd9vM7zunsaZBIFlzjU0c9SCS5kBTDhD4Zx2fDm0L/yDJ+lZhhjPQC
         cykjn+iUKDBH4YCcteUOi7O3wYckrjrh3HjhNtimQTHVSVKRxsw6HdZ4fhfj7n9hMIir
         l+/wJRY3ig3T9AebA/vPy+k1UCrdYfyBBRO/leniR2Fjpg9XnCTMbg90DwdxL3CWrdaX
         cvqprQgbQ0/01YMNrjJd47ixylPaHeDyFNYhDOg8muKj3w0CCoLQ5VmJPQKvYJ5V+qm1
         HzIkaLGCE/Biv9+og7cNb/bK4jwp6mxDtu0z1tUGu1hf+sFyaON4ZHWSYAfs0JlOwtam
         kzeg==
X-Gm-Message-State: AOAM533NINPq4/P090wVPSpKPTxaPubOrHIoZoNrDdb4kbkZNKa82s5/
        xY+W+mFa+GD3wtz94VFLJRF0we5rDerDUHSRA3k=
X-Google-Smtp-Source: ABdhPJy0yAVIZnzWeGgvCaGTC9kmn2CkyEs8p+gJOEVTPDmh4QCd7BolgjOYPZTVehmbE+LjPA/B39nLpoXLRVjAJ28=
X-Received: by 2002:a25:850c:: with SMTP id w12mr4232530ybk.347.1618351680290;
 Tue, 13 Apr 2021 15:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153429.3029377-1-yhs@fb.com>
In-Reply-To: <20210413153429.3029377-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 15:07:49 -0700
Message-ID: <CAEf4BzY2qKks5EV2CYZjSHpv3Z-qakfKAw=dA-Uc7kh88_f0AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: silence clang compilation warnings
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
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
> The first warning can be silenced with clang option -Wno-unused-command-line-argument.
> For the second warning, source codes are modified as suggested by the compiler
> to silence the warning. Since gcc does not support the option
> -Wno-unused-command-line-argument and the warning only happens with clang
> compiler, the option -Wno-unused-command-line-argument is enabled only when
> clang compiler is used.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM, please see the question below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile                         | 5 +++++
>  tools/testing/selftests/bpf/prog_tests/fexit_sleep.c         | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 4 ++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index dcc2dc1f2a86..c45ae13b88a0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -28,6 +28,11 @@ CFLAGS += -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)           \
>           -Dbpf_load_program=bpf_test_load_program
>  LDLIBS += -lcap -lelf -lz -lrt -lpthread
>
> +# Silence some warnings when compiled with clang
> +ifneq ($(LLVM),)

This won't handle the case where someone does `make CC=clang`, right?
Do we care at all?


> +CFLAGS += -Wno-unused-command-line-argument
> +endif
> +

[...]
