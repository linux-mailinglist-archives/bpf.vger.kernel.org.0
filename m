Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7389235D697
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 06:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhDMEpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 00:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhDMEpb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 00:45:31 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A5C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:45:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k73so10453018ybf.3
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 21:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l9x1L9G1pk+qZOZWVdo4QFPIcDjIxtbqSR+YanxyMk=;
        b=Y2WUwSVHMZU3NQ45ZC/VgnmmqcG385FomssDDYsZiHOSvK9XBrcyGjgOzN5PLBqsTY
         y/344ndYofDezQFFwzpETQFh3SIGT8FNMYSUhWobb+Kb4KAC5dq0fTeBVBAL2+DtAtm5
         QRnvzLgA1t8T0zZAWyK11b6vsGOaEuZJMhpscMN5oJzJG9Ahn25rwxnARk1DwsmuNAiD
         diDSSe+bbRPVYwyIfOjsT4sb4jQzmWBAsd9k4aKn9PXi/75pbQEFI/U8dyJ0bAbPagrn
         8rg3kyhc33tNR+t0vhK64A1mtmHjfacv5CDUtYgw7J8VUnexQmB9sZZ759mu67ct4QJV
         NyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l9x1L9G1pk+qZOZWVdo4QFPIcDjIxtbqSR+YanxyMk=;
        b=aGPv4j3/AgvcY20x4361Hx55CNhHojkVti8S9Kdqe0arVXMU5eQpM9EsDsWprc5BQh
         yqHR0YKeuyd3NReNytV+hfvenJ83QEguz2rBKBunXPOApOVeIGUbo/TorAUCajnifnZn
         rbKXFkmK2jbBwv9tql/S7cCm7DxNP1zwGFqd/lyXd9hCv2aJJeDnJL65jAfX/jMLbDd+
         5hbrxaiOvv98buxL2kcIxNakAWiuaGLex2rSlqNvBTEOyuc8xW2JMFAVbQlkxntyQ8yv
         xU0OP9+qmn6LyunbpZgQ3fstvjVV/lUTfFkXrFrQv4sGWV4+/iNvfrWjZuzcKeMcjV+m
         29IA==
X-Gm-Message-State: AOAM533viJZbdzgWNIa5hKGAqx8rXhOH3i5CTjPD/l7yz9dPXqgOPdk/
        MpmWH5n2hZjTJk5wkC4aCFDSMySOrD4k1sVcYjQ=
X-Google-Smtp-Source: ABdhPJxA15XjMsDpPXF5AG/iVv4FahT/V1GnClqdYEdVPLblXpau1jaE2I/fOC5xnYhabRCxNVeJntz32l7juTcLBds=
X-Received: by 2002:a25:ab03:: with SMTP id u3mr42621492ybi.347.1618289111573;
 Mon, 12 Apr 2021 21:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <20210412142927.268732-1-yhs@fb.com>
In-Reply-To: <20210412142927.268732-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 21:45:00 -0700
Message-ID: <CAEf4Bzb278syq=fPpN=+StGnaP7FuAwcPGKq6KQq5P5rrC_Lpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: silence clang compilation warnings
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

On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
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

So why not do what the compiler suggests and use `"err %s",
strerror(errno)` instead of silencing useful warning globally?

>   .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK'
>         _CHECK(condition, tag, duration, format)
>                                          ^
>   .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHECK'
>                 fprintf(stdout, ##format);                              \
>                                   ^
> The first warning can be silenced with clang option -Wno-unused-command-line-argument,

this one does seem necessary, otherwise we'll have to adjust per each
.c file the list of libraries needed


> and the second with -Wno-format-security. Further, gcc does not support the option
> -Wno-unused-command-line-argument. Since the warning only happens with clang
> compiler, these two options are enabled only when clang compiler is used and this
> fixed the above warnings.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bbd61cc3889b..ef7078756c8a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -28,6 +28,11 @@ CFLAGS += -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)           \
>           -Dbpf_load_program=bpf_test_load_program
>  LDLIBS += -lcap -lelf -lz -lrt -lpthread
>
> +# Silence some warnings when compiled with clang
> +ifneq ($(LLVM),)
> +CFLAGS += -Wno-unused-command-line-argument -Wno-format-security
> +endif
> +
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
>         test_verifier_log test_dev_cgroup \
> --
> 2.30.2
>
