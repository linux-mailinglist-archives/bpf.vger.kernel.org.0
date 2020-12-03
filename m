Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D231B2CE048
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgLCVDb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgLCVDb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 16:03:31 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152DC061A4F;
        Thu,  3 Dec 2020 13:02:44 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id k65so3344136ybk.5;
        Thu, 03 Dec 2020 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D96ntruvKNHwhJI4N9JZfzOeYobqLQ+gufOr4VkC1bk=;
        b=NCpz16V4A8mC4sxO+He2ZjqFqMJwgbrNEba7nwUjJarpcGXTuxgGds3FHa19cKYz8l
         Z3KiO9kQRWoZO+wvT3w2txPm1P1P01jIhtcFdphQ5QV5WLwDr0SRYrFdPz5VMBvojRT9
         xUtmg7UXISeP+wC7FeuRUAA6JoOtzw5kRmMsZVqwxa4PXCGAKQW0kCelfW4pZDfYb2qz
         jo9abkq3ESsni4Q/2CgTZ7tk5TiJ/EUa7XjW+tvEX/uSgXKQODMqLcyotAEJAIDxKlqM
         e/mvRGXpRXfFGTp7I1PlKrPvXM3uiMnPnXx75AhwX+kaihn0f95cM/9dmjdxkXJzE89b
         EPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D96ntruvKNHwhJI4N9JZfzOeYobqLQ+gufOr4VkC1bk=;
        b=OjWDCuhpu8M1fpKM8M/VUZPBAROQowxXzPH2IWX2ZHpd+wxtgU1EmLCrTjOKRz32Yc
         xP2yo35J87P+Ke6AzT7Zi6JcNP07eMN2brRAA7xKRxhJ+6KTGNCmyHgTw6/zgfv+VEV4
         iP7BdX4cn1piAVqbZ8/NVWgvfHvM9GmJzzP8jJB3JN5/vZjIL/TMx6B6bVCF8gYLjrak
         +6memyEPqvug0asKIkIr6UT77h8HC0RAyP62Q+h9ahLBa9ElI6xCOi/3EKkb7uCW9HFf
         A6yAQzdGHqesgJetve2sNRd5Q36y0j3m+tRYMItiiOnaxA8ibS101BziWPCPJAw36RxY
         iTpw==
X-Gm-Message-State: AOAM532feGcB8tP9eibPv18EVkzpexmdcAoi3McV/RAyFD2HPc2ekumx
        3r9Y4lHxGpDRoeiTWKCv6IUOvYXLW73d4adPTzU=
X-Google-Smtp-Source: ABdhPJxsPvxzAvsTaC+SuNOn/oifB3Nfv491GjWULpmf+sLM5DBK9SyDzSUZgogACqoyPgkGkqnIP1aIq/chrwKZFtg=
X-Received: by 2002:a25:2845:: with SMTP id o66mr1540517ybo.260.1607029364337;
 Thu, 03 Dec 2020 13:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com> <20201203160245.1014867-12-jackmanb@google.com>
In-Reply-To: <20201203160245.1014867-12-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 13:02:33 -0800
Message-ID: <CAEf4BzbN==quHrXgGswSVKwK_9mqKMmzw=2y21uc-Sfz1_VGuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/14] tools build: Implement feature check
 for BPF atomics in Clang
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 8:08 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> Change-Id: Ia15bb76f7152fff2974e38242d7430ce2987a71e
>

See recent discussion on KP's patch set. There needs to be a commit
message, even if it's just a copy/paste of subject line. But see also
my other reply, I'm not sure it's worth it to do it this way for
selftests.

> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: "Frank Ch. Eigler" <fche@redhat.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Hebb <tommyhebb@gmail.com>
> Change-Id: Ie2c3832eaf050d627764071d1927c7546e7c4b4b
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/build/feature/Makefile                 | 4 ++++
>  tools/build/feature/test-clang-bpf-atomics.c | 9 +++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 tools/build/feature/test-clang-bpf-atomics.c
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index cdde783f3018..81370d7fa193 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -70,6 +70,7 @@ FILES=                                          \
>           test-libaio.bin                       \
>           test-libzstd.bin                      \
>           test-clang-bpf-co-re.bin              \
> +         test-clang-bpf-atomics.bin            \
>           test-file-handle.bin                  \
>           test-libpfm4.bin
>
> @@ -331,6 +332,9 @@ $(OUTPUT)test-clang-bpf-co-re.bin:
>         $(CLANG) -S -g -target bpf -o - $(patsubst %.bin,%.c,$(@F)) |   \
>                 grep BTF_KIND_VAR
>
> +$(OUTPUT)test-clang-bpf-atomics.bin:
> +       $(CLANG) -S -g -target bpf -mcpu=v3 -Werror=implicit-function-declaration -o - $(patsubst %.bin,%.c,$(@F)) 2>&1
> +
>  $(OUTPUT)test-file-handle.bin:
>         $(BUILD)
>
> diff --git a/tools/build/feature/test-clang-bpf-atomics.c b/tools/build/feature/test-clang-bpf-atomics.c
> new file mode 100644
> index 000000000000..8b5fcdd4ba6f
> --- /dev/null
> +++ b/tools/build/feature/test-clang-bpf-atomics.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020 Google
> +
> +int x = 0;
> +
> +int foo(void)
> +{
> +       return __sync_val_compare_and_swap(&x, 1, 2);
> +}
> --
> 2.29.2.454.gaff20da3a2-goog
>
