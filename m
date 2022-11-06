Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1426B61E5F2
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 21:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKFUnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 15:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKFUnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 15:43:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C8DEA0
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 12:43:19 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so25455714ejc.4
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 12:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbfTDt9a68Py7+4woMulJtWFyD56s/WjPZxRJAhXhxM=;
        b=QSrKND2Bbk/YK9WIxIRH7scK+eANdu7+kuNw5A5Afnn6hnIXuuVlv9+nnA3YXVnFh4
         0IQK8sqFTuMxNj9E/2+SIgO3ykmpVZq/0LrMGc356GKMo3+s4Wkqd676v6SYrOz9FSHV
         cn7ERWg8rxjfBKm256wytNZ18lApEUPBeWcm1TkxRj8BLMClnZdmMEfXs3Yn/iC3MmSx
         jUN7QYKyxvjmTvhS0Tn4bzRT1d4gvm3BupnBDmClPx/vQsm1vUdMcV/zwLyBdcEjI6my
         ZTEWYpLHyuW3jHxMutJnWIelwi8rYLQ7VH5M2nga6y20Iwe+UXxgM3INtXwjmWKZlok2
         MVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbfTDt9a68Py7+4woMulJtWFyD56s/WjPZxRJAhXhxM=;
        b=nRYJi5wwyFZLOU0pVrzqyFL2bnzVgbwhLOYOD7tGPBe9k4pn4Zx6ShVQN95FiwOtPr
         2gEVNgZIOFSjpG4JHya/txEwOUwzbU4O+Lt+yxnuzKjKreRii1+mu+ROsw+ng+g1b2EE
         tHWS3YkkDDMbzKBR073x2TNm0P2PKW7U1CMHoTuosM1UehxQB0oWbnsEVK8TKrgXXhPd
         g1pEq4ayorHv8A/i0x1vp7nswTUYmIz/V/YXj7/IUrfTrl1U4wRAvq9FW8LWlpwS1K6t
         zayPY+WS0mf7WgzCMTp9vNWXm9xmEXmjh/57ylokTbziWDUs3+ogzg3IUESr3NBcTkDc
         4n8A==
X-Gm-Message-State: ACrzQf1q0W0E0FDKRyn+KQJfFLfQAr29LOzyGQDilpfnmcaVunoRuie5
        i3zC6Xc7+gG9RpgoIKImReaNFruZJHZMLN2WbEU=
X-Google-Smtp-Source: AMsMyM6JO5lT54dY6qewd2khavsOt1O5AJ2VsNk1u7OUIZlezLX+DECti3HbORIVAUbS0cayeKbt0gNRSR4cZCvCFBc=
X-Received: by 2002:a17:906:8a73:b0:7ae:3962:47e7 with SMTP id
 hy19-20020a1709068a7300b007ae396247e7mr12274984ejc.502.1667767397404; Sun, 06
 Nov 2022 12:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20221106202910.4193104-1-eddyz87@gmail.com> <20221106202910.4193104-2-eddyz87@gmail.com>
In-Reply-To: <20221106202910.4193104-2-eddyz87@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 6 Nov 2022 12:43:05 -0800
Message-ID: <CAADnVQJNFqGE+5b9kicHnfxd37bpeCJV1Cz+5rXi-vt8imTMaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: hashmap interface update to long
 -> long
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Sun, Nov 6, 2022 at 12:29 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> An update for libbpf's hashmap interface from void* -> void* to
> long -> long. Removes / simplifies some type casts when hashmap
> keys or values are 32-bit integers.
>
> In libbpf hashmap is more often used with integral keys / values
> rather than with pointer keys / values.
>
> Perf copies hashmap implementation from libbpf and has to be
> updated as well.
>
> Changes to libbpf, selftests/bpf and perf are packed as a single
> commit to avoid compilation issues with any future bisect.
>
> The net number of casts is decreased after this refactoring. Although
> perf mostly uses ptr to ptr maps, thus a lot of casts have to be
> added there:
>
>              Casts    Casts
>              removed  added
> libbpf       ~50      ~20
> libbpf tests ~55      ~0
> perf         ~0       ~33
> perf tests   ~0       ~13
>
> This is a follow up for [1].
>
> [1] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/bpf/bpftool/btf.c                       |  25 ++---
>  tools/bpf/bpftool/common.c                    |  10 +-
>  tools/bpf/bpftool/gen.c                       |  19 ++--
>  tools/bpf/bpftool/link.c                      |   8 +-
>  tools/bpf/bpftool/main.h                      |  14 +--
>  tools/bpf/bpftool/map.c                       |   8 +-
>  tools/bpf/bpftool/pids.c                      |  16 +--
>  tools/bpf/bpftool/prog.c                      |   8 +-
>  tools/lib/bpf/btf.c                           |  41 ++++---
>  tools/lib/bpf/btf_dump.c                      |  16 +--
>  tools/lib/bpf/hashmap.c                       |  16 +--
>  tools/lib/bpf/hashmap.h                       |  34 +++---
>  tools/lib/bpf/libbpf.c                        |  18 ++--
>  tools/lib/bpf/strset.c                        |  18 ++--
>  tools/lib/bpf/usdt.c                          |  31 +++---
>  tools/perf/tests/expr.c                       |  40 +++----
>  tools/perf/tests/pmu-events.c                 |   6 +-
>  tools/perf/util/bpf-loader.c                  |  23 ++--
>  tools/perf/util/expr.c                        |  32 +++---
>  tools/perf/util/hashmap.c                     |  16 +--
>  tools/perf/util/hashmap.h                     |  34 +++---
>  tools/perf/util/metricgroup.c                 |  12 +--
>  tools/perf/util/stat.c                        |   9 +-
>  .../selftests/bpf/prog_tests/hashmap.c        | 102 +++++++++---------
>  .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
>  25 files changed, 257 insertions(+), 305 deletions(-)

Looks like the churn is not worth it.
I'd keep it as-is.
