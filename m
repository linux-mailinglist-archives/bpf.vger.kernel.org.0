Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163A94AE387
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386493AbiBHWW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387253AbiBHWOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:14:17 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BD1C0612B8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:14:16 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s18so826331ioa.12
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LdxQlBQ8/TvLVNrRm8ZrnrXZDWaEwW134kzxx2JltA=;
        b=AHhc9mW0C7kdRN9BuXvhiZ8Y9ZgZWcdp31GpN+Mai+5uvcgeX9fliTP7rNSsg3AKJz
         BdzQCv7PJaIjg9JkKhnNLiYwQw3WpXzlvtaDbByCebMGX+UVPQm/UzlRypvPnY0YJsLz
         CTtPCmCsgsrU5n/eWXxFm7s6mztrSOZgUDVj/41RCLEpjh7AqvsCB7ZMS3/HltAlKf+i
         F23fmn1X3BSTM/PWViicIMQGQwC94q9qinb60h5ztXhzRhZRqo6HxyNrGi579DhtNJ2Y
         u76sYHDhZeKh42U1akabgj0yCvQaJBF4A0wt2z2MEBByx50QB9bpwcnPI9GSYEGk/sS/
         PmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LdxQlBQ8/TvLVNrRm8ZrnrXZDWaEwW134kzxx2JltA=;
        b=D2oD/8C05t41nmrC+J4ABN22UJWFgk4x8tRyF9VXCiCV/ZQnrRwj99S5oypS4KEFCl
         qBSGhM7UQ8gPC/gqqriK863cOM9Cz+MnKiqa/SfLqaoUGKHWp3mUWnu9u4C16CZq6iwB
         1Wd9HnKN4ArEEKdvEfj9iC1OcyanpcAEVGCOdXNHlAn37nauCHGuGrSO0s+ThK/Fjngx
         Dt80G140spXBNeXu24zKkL/Av4PojcGj2bnvpEaBji3e6ptscqalfF3TyUTKMb3dyueS
         FzkdVX1OAYq3va2aIax4FTJA8Zr6R3tgEQlw34zVjVAKG5VNCSEZiQdc50CuStvtJlP/
         EX8w==
X-Gm-Message-State: AOAM531uo2e/BVWq/coK/INaF4WCc7W943rj1dEu8ZZsyUK8sIMobf1r
        qGnR3siVCjOXHjbXEEJAAD1ME5Dm3eMDrGQAQI0=
X-Google-Smtp-Source: ABdhPJycHV0quE5lOaCgu0k2/FXwj2k+V49tRBJHLAzLvgFkXnKaoboR+8rjWZNEJrAt4gVC7Zempr2pVCCa4DJ90Is=
X-Received: by 2002:a02:1181:: with SMTP id 123mr3109351jaf.93.1644358455557;
 Tue, 08 Feb 2022 14:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-11-iii@linux.ibm.com>
In-Reply-To: <20220208051635.2160304-11-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 14:14:04 -0800
Message-ID: <CAEf4BzbWqzWDhvZqT9WqMhwXpnRX7m85XTHQ3zacwmtdhJJDeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/14] libbpf: Move data structure
 manipulation macros to bpf_common_helpers.h
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> These macros are useful for both libbpf and bpf progs, so put them into
> a separate header dedicated to this use case.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/Makefile                 |  2 +-
>  tools/lib/bpf/bpf_common_helpers.h     | 30 ++++++++++++++++++++++++++
>  tools/lib/bpf/bpf_helpers.h            | 15 +------------
>  tools/testing/selftests/bpf/bpf_util.h | 10 +--------
>  4 files changed, 33 insertions(+), 24 deletions(-)
>  create mode 100644 tools/lib/bpf/bpf_common_helpers.h
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index b8b37fe76006..60b06c22e0a1 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -239,7 +239,7 @@ install_lib: all_cmd
>
>  SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h      \
>             bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h         \
> -           skel_internal.h libbpf_version.h
> +           skel_internal.h libbpf_version.h bpf_common_helpers.h

Wait, how did we get from fixing s390x syscall arg fetching to
exposing a new public API header from libbpf?... I feel like I missed
a few revisions and discussion threads.

>  GEN_HDRS := $(BPF_GENERATED)
>
>  INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
> diff --git a/tools/lib/bpf/bpf_common_helpers.h b/tools/lib/bpf/bpf_common_helpers.h
> new file mode 100644
> index 000000000000..79db303b6ae2
> --- /dev/null
> +++ b/tools/lib/bpf/bpf_common_helpers.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +#ifndef __BPF_COMMON_HELPERS__
> +#define __BPF_COMMON_HELPERS__
> +
> +/*
> + * Helper macros that can be used both by libbpf and bpf progs.
> + */
> +
> +#ifndef offsetof
> +#define offsetof(TYPE, MEMBER) ((unsigned long)&((TYPE *)0)->MEMBER)
> +#endif
> +
> +#ifndef sizeof_field
> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> +#endif
> +
> +#ifndef offsetofend
> +#define offsetofend(TYPE, MEMBER) \
> +       (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
> +#endif
> +
> +#ifndef container_of
> +#define container_of(ptr, type, member)                                \
> +       ({                                                      \
> +               void *__mptr = (void *)(ptr);                   \
> +               ((type *)(__mptr - offsetof(type, member)));    \
> +       })
> +#endif
> +
> +#endif
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 44df982d2a5c..1e8b609c1000 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -2,6 +2,7 @@
>  #ifndef __BPF_HELPERS__
>  #define __BPF_HELPERS__
>
> +#include "bpf_common_helpers.h"
>  /*
>   * Note that bpf programs need to include either
>   * vmlinux.h (auto-generated from BTF) or linux/types.h
> @@ -61,20 +62,6 @@
>  #define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
>  #endif
>
> -/*
> - * Helper macros to manipulate data structures
> - */
> -#ifndef offsetof
> -#define offsetof(TYPE, MEMBER) ((unsigned long)&((TYPE *)0)->MEMBER)
> -#endif
> -#ifndef container_of
> -#define container_of(ptr, type, member)                                \
> -       ({                                                      \
> -               void *__mptr = (void *)(ptr);                   \
> -               ((type *)(__mptr - offsetof(type, member)));    \
> -       })
> -#endif
> -
>  /*
>   * Helper macro to throw a compilation error if __bpf_unreachable() gets
>   * built into the resulting code. This works given BPF back end does not
> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
> index a3352a64c067..bc0b741b1eef 100644
> --- a/tools/testing/selftests/bpf/bpf_util.h
> +++ b/tools/testing/selftests/bpf/bpf_util.h
> @@ -6,6 +6,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <bpf/bpf_common_helpers.h>
>  #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
>
>  static inline unsigned int bpf_num_possible_cpus(void)
> @@ -31,13 +32,4 @@ static inline unsigned int bpf_num_possible_cpus(void)
>  # define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  #endif
>
> -#ifndef sizeof_field
> -#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> -#endif
> -
> -#ifndef offsetofend
> -#define offsetofend(TYPE, MEMBER) \
> -       (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
> -#endif
> -
>  #endif /* __BPF_UTIL__ */
> --
> 2.34.1
>
