Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF652C8DF
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 02:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiESAri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 20:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiESAre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 20:47:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100C3DA48
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 17:47:32 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y12so4229813ior.7
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 17:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdzaQMo/P7r3fTqx0SZZ4rKlgzZsO8MePR+BIgxErdw=;
        b=MZow+tUjJFvi95rosYZ2Ns/bACU8x2DTCVSEkCby1/KkxM4PnG3cob5xwApdUBiUtg
         9cVBiTdW2XaK1y8zaaQgtUpGVLMqLurekYLGFx8oFgbns10dbhhi2Qb0IhBNX66nRAxO
         a4dq7Tj0ZicBIq23tYICHF2LUt311A0kP3u9yGtN5Q4TcXgAzn7YKrG5TuYLm9xoQo47
         JWsnfY/RntFjMJX9uqySkOdCC2TZnZz8alR/3uFtMIK8I+VUexHuNhhFASIMZUO/+Er5
         FQCKbCiiD9dEhvDw2aPB67jolu0KZJM3D5Sy+f5EgqKYshvNcZ+m1gfZAibUr8MnLNsA
         qNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdzaQMo/P7r3fTqx0SZZ4rKlgzZsO8MePR+BIgxErdw=;
        b=r1RFPM3xL17S019rE4x9UZ38vqcEbvPPFlhClm+7+AH9joc0GlHEIdt9UXMyfC1pAY
         9m3c1/N2ZwlS+reh5WLjBzgNAGFFA7YKrHcWZi+Qdi90FHeQn83OwyQDdeNpbMJLVbhn
         b9yVmlUZ+vOhZs3c//BMEwsuzuzGY03PiMYRgn8ZyhtCzGJ9HW3snWKgbK7zcFzcVd46
         I7Baor3Q6HBCl6mDxsp4XIiMgvJh22YtYZRPzUL8q2NRHp3uR6UfkIoMF5AnwV1ysFzm
         38GGn7fBUgNWvg0/5x6UFzKc2OIDxOedDsSjZVyo3CsFzwqy1TBKCpa19np1rYbuE1Hr
         4ITQ==
X-Gm-Message-State: AOAM530IdTuCLPcntyyx8UjgQMhr4pDhVGu7Dijh7mJmZ6TIvB8fd6lO
        Q6nyI7g4M8FlDMZu9f7ZI/3cpxFS4ySTEPRbOus=
X-Google-Smtp-Source: ABdhPJyRR7VCfglCZb6cPKAM8JC/Q3N5WENQubGWzVHll1Q2xjm5O/bcFWJTKGqIIpYKVbb3Wb/W5dd45nn7gwrbVfo=
X-Received: by 2002:a05:6602:248f:b0:65a:fb17:7a6b with SMTP id
 g15-20020a056602248f00b0065afb177a6bmr1119888ioe.79.1652921251468; Wed, 18
 May 2022 17:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com> <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1652788780-25520-3-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 18 May 2022 17:47:20 -0700
Message-ID: <CAEf4BzakF1CLMPhiXZj6D9YW0EExUeg9VJS4gbhfizbbU2fWGQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add tests verifying
 unprivileged bpf disabled behaviour
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kees Cook <keescook@chromium.org>, bpf <bpf@vger.kernel.org>
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

On Tue, May 17, 2022 at 5:00 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> tests load/attach bpf prog with maps, perfbuf and ringbuf, pinning
> them.  Then effective caps are dropped and we verify we can
>
> - pick up the pin
> - create ringbuf/perfbuf
> - get ringbuf/perfbuf events, carry out map update, lookup and delete
> - create a link
>
> Negative testing also ensures
>
> - BPF prog load fails
> - BPF map create fails
> - get fd by id fails
> - get next id fails
> - query fails
> - BTF load fails
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../bpf/prog_tests/unpriv_bpf_disabled.c      | 308 ++++++++++++++++++
>  .../bpf/progs/test_unpriv_bpf_disabled.c      |  83 +++++
>  2 files changed, 391 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_unpriv_bpf_disabled.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> new file mode 100644
> index 000000000000..7c58c4f7ecc7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022, Oracle and/or its affiliates. */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +#include "test_unpriv_bpf_disabled.skel.h"
> +
> +#include "cap_helpers.h"
> +
> +#define ADMIN_CAPS (1ULL << CAP_SYS_ADMIN |    \
> +                   1ULL << CAP_NET_ADMIN |     \
> +                   1ULL << CAP_PERFMON |       \
> +                   1ULL << CAP_BPF)
> +
> +#define PINPATH                "/sys/fs/bpf/unpriv_bpf_disabled_"
> +
> +struct test_unpriv_bpf_disabled *skel;
> +__u32 prog_id;
> +int prog_fd;
> +int perf_fd;
> +char *map_paths[7] =   { PINPATH "array",
> +                         PINPATH "percpu_array",
> +                         PINPATH "hash",
> +                         PINPATH "percpu_hash",
> +                         PINPATH "perfbuf",
> +                         PINPATH "ringbuf",
> +                         PINPATH "prog_array" };
> +int map_fds[7];

just very briefly skimming, all these variables should be static

but at least for skel why not passing it as input argument to
respective subtest functions?

> +
> +static __u32 got_perfbuf_val;
> +static __u32 got_ringbuf_val;
> +

[...]
