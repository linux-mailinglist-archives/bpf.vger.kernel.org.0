Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67B05F1456
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiI3VFk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiI3VFh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:05:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD758C5BF1
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:05:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m3so7487140eda.12
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PvD4YTW+az9n8W8tbsufSHwtrPlRsiEZmfDbtv2ugw=;
        b=LHuaLD79xbhvmTqmCXAtaeN9qSgTVl1/NutvX1OHpbqwquz6btcq70ghX9O5s1LkD3
         tpCKLvDVEii8wpuVlye8XaLJaYsv6VeRPaCv36KNhtXmSta7ckHDDh+jVDTFVKp+c0R/
         QqKR1Z1jcriMM/nEZYxIrMRly+ZeohjwbuXbImUMoUiD8XjOvF/hzqgPxZqzMETQ/U4h
         sUR4qmUVgKnynZ1wMT9Oxw2bPyLGuvmS89/zqU/jpzxFzdNc2aq9yWzTfhStaobXPgzv
         FolupEHFn/QuGFzka3Ys93DE6y8GqGMvOO6tmpKm1iiPNFBPsdO3FLbYJ1FEbOPx1T5v
         5RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PvD4YTW+az9n8W8tbsufSHwtrPlRsiEZmfDbtv2ugw=;
        b=7PHNHTDjG0ajZJ81pHomtcB6HXAAnb4a2z+XZkvKnXFOEYzR3DyQH9Ikiabx4wLfiQ
         bh0gvkj4esPoWgivwEpKAqXCJEUmRxKWYJOOvKBE+fFsLzwzrldZsK9PfvY5ly7mtRqn
         IL06vDfMNtec5nF2RPxm/npEZDWo+NKbxdEzUQ7SnRCvDld9HiKuWnA/AHSlYDUbdMdY
         HDloeZtt70xjC3vtPX44kvWy8VomqulJm9mYjfrDk6DkQTkZYbiuSYRPRsf+lJGdS5rE
         YG1aEM94PY1B+fNeZOIwDS8lERsOLRD9C1cspekSFmk/LmWLIO8MkdJJ81QyURF3c+J9
         texw==
X-Gm-Message-State: ACrzQf2G9NlSWNx1l/7QOfO9J8OGlh9aO2iwqnddGhF9NvP9FeReFFCz
        qvfC5VUX4S4JUEYb3GNf7z07mwx7gZ/n50N8FHcHC5J4
X-Google-Smtp-Source: AMsMyM5djuW3n6yHsFlInZg6bwZMKkSoNEZGf12tZd9DtAODLH3CFqSJPNQcA4Pmy+nbYXyD29SWh88WED780aznyNc=
X-Received: by 2002:a50:d79a:0:b0:457:d209:c09c with SMTP id
 w26-20020a50d79a000000b00457d209c09cmr9486275edi.14.1664571929779; Fri, 30
 Sep 2022 14:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220927182345.149171-1-pnaduthota@google.com> <20220927182345.149171-3-pnaduthota@google.com>
In-Reply-To: <20220927182345.149171-3-pnaduthota@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 14:05:17 -0700
Message-ID: <CAEf4BzYLr-HJvjgjJgLHoka2FCPJ=UAhTY-TumM8V4YpjOaX=A@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] Add selftests for devmap pinning
To:     Pramukh Naduthota <pnaduthota@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org
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

On Tue, Sep 27, 2022 at 11:24 AM Pramukh Naduthota
<pnaduthota@google.com> wrote:
>
> Add a test for devmap pinning.
>
> Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
> ---
>  .../testing/selftests/bpf/prog_tests/devmap.c | 21 +++++++++++++++++++
>  .../selftests/bpf/progs/test_pinned_devmap.c  | 17 +++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devmap.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/devmap.c b/tools/testing/selftests/bpf/prog_tests/devmap.c
> new file mode 100644
> index 000000000000..735333d3ac07
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/devmap.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2022 Google

nit: use /* */ for copyright line

> +#include "testing_helpers.h"
> +#include "test_progs.h"
> +#include "test_pinned_devmap.skel.h"
> +#include "test_pinned_devmap_rdonly_prog.skel.h"
> +
> +void test_devmap_pinning(void)

static

> +{
> +       struct test_pinned_devmap *ptr;
> +
> +       ASSERT_OK_PTR(ptr = test_pinned_devmap__open_and_load(), "first load");

nit: don't be too clever inside ASSERT_OK_PTR(), do assignment outside
and then check ptr

> +       test_pinned_devmap__destroy(ptr);
> +       ASSERT_OK_PTR(test_pinned_devmap__open_and_load(), "re-load");
> +}
> +
> +void test_devmap(void)
> +{
> +       if (test__start_subtest("pinned_devmap"))
> +               test_devmap_pinning();

if it's just one subtest then there isn't much point in making it a subtest


> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_pinned_devmap.c b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
> new file mode 100644
> index 000000000000..63879de18ad3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Google */
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <linux/types.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
> +       __uint(max_entries, 32);
> +       __type(key, int);
> +       __type(value, int);
> +       __uint(pinning, LIBBPF_PIN_BY_NAME);
> +} dev_map SEC(".maps");

please use a bit more specific name to minimize potential interference
with other parallel tests

> +
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.30.2
>
