Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3116B68207E
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjAaARS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAaARR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:17:17 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44610D2
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:17:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id be12so1551585edb.4
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GYYxWGV7Yc0B7iFSHhosrqEoymkL+aRDNJ5d6krQZ+k=;
        b=F4cWv/vC7XEShaZEghkZ3CByio7seIJIhF6Nih5Quw9rRcBNXdDNyINnubuMBIPWL+
         8dYGjROA++U7oxEOeiGb48171SosBs489rwK4fU/XI28S/GA2P0Qq7Ygq5S1A9dWsfLx
         7qht4ZkE0pYoGkFtMk/p/uhMxhdHdu/+gDiLG1ZoM154NociQOBJKajz2fQppmjfWnXH
         dzhv2ks+9nevmMHWsgywSZQJqUcWXEwmnXsjkx58M5aUjoKgRWdy3icHijnpLzfYX+FZ
         p3NCiGoo//gmJ4fTUEepQhOE231VjBF+/nR4Wo9KUI82sMtQQZrwxWm3dkldEyO198m6
         rjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYYxWGV7Yc0B7iFSHhosrqEoymkL+aRDNJ5d6krQZ+k=;
        b=g6IZIURYnC9ccJmmPwGXILPzv5fHXJo0Yageg5ExJ67s24wUSuqe32K0vbWMujtSdJ
         e2lJMx3+gEQcvm+/zL1iyj0NQJD4PcNrbxUWJqxmN2NLe32wft7xFzVur21t7YCuBWy5
         gqhIyjEoSSKTaMUti+0JmnkvR30aK/5qEibX1tvT6gLzIRvncQZoT+vjeAZ3Z/tAasfj
         NsRH5Yub81E/q6LdKC7l2Clyr74HeekLSIDSXoU5/G2gIjT94HFZQMExFl4cD0I1v8dx
         iPOD/ZcYrqTCFR3y+AP95AilXATcg1s7ApZkmsj70alozjh19AfVbHvwxVgNXJE0fvAN
         C02w==
X-Gm-Message-State: AFqh2koopU/8Ruhtua6IYQIXnngKRbgOU8m/DeOXWbFXaEjUvSmttiVE
        rCoGyeS2ekKhyonPV/GV0ZXPtgEBO7LQgE2tinI=
X-Google-Smtp-Source: AMrXdXt01CcOdYYWqW4gCanA70iPKsakLX32s432L+MVyIRH9hfdK8RGlxWawGJRUh1/JkkCVcSaaaizlYPwE258NVE=
X-Received: by 2002:aa7:dbc1:0:b0:49e:1e:14b1 with SMTP id v1-20020aa7dbc1000000b0049e001e14b1mr9269486edt.6.1675124234693;
 Mon, 30 Jan 2023 16:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20230127181457.21389-1-aspsk@isovalent.com>
In-Reply-To: <20230127181457.21389-1-aspsk@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Jan 2023 16:17:02 -0800
Message-ID: <CAEf4BzYcMM4hzvD3TSPnK052W2a0Eu2ygm4BixPmMaZioq9TKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/6] New benchmark for hashmap lookups
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
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

On Fri, Jan 27, 2023 at 10:14 AM Anton Protopopov <aspsk@isovalent.com> wrote:
>
> Add a new benchmark for hashmap lookups and fix several typos. See individual
> commits for descriptions.
>
> One thing to mention here is that in commit 3 I've patched bench so that now
> command line options can be reused by different benchmarks.
>
> The benchmark itself is added in the last commit 6. I am using this benchmark
> to test map lookup productivity when using a different hash function (see
> https://fosdem.org/2023/schedule/event/bpf_hashing/). The results provided by
> the benchmark look reasonable and match the results of my different benchmarks
> (requiring to patch kernel to get actual statistics on map lookups).

Could you share the results with us? Curious which hash functions did
you try and which one are the most promising :)

>
> Anton Protopopov (6):
>   selftest/bpf/benchs: fix a typo in bpf_hashmap_full_update
>   selftest/bpf/benchs: make a function static in bpf_hashmap_full_update
>   selftest/bpf/benchs: enhance argp parsing
>   selftest/bpf/benchs: make quiet option common
>   selftest/bpf/benchs: print less if the quiet option is set
>   selftest/bpf/benchs: Add benchmark for hashmap lookups
>
>  tools/testing/selftests/bpf/Makefile          |   5 +-
>  tools/testing/selftests/bpf/bench.c           | 126 +++++++-
>  tools/testing/selftests/bpf/bench.h           |  24 ++
>  .../bpf/benchs/bench_bloom_filter_map.c       |   6 -
>  .../benchs/bench_bpf_hashmap_full_update.c    |   4 +-
>  .../bpf/benchs/bench_bpf_hashmap_lookup.c     | 277 ++++++++++++++++++
>  .../selftests/bpf/benchs/bench_bpf_loop.c     |   4 -
>  .../bpf/benchs/bench_local_storage.c          |   5 -
>  .../bench_local_storage_rcu_tasks_trace.c     |  20 +-
>  .../selftests/bpf/benchs/bench_ringbufs.c     |   8 -
>  .../selftests/bpf/benchs/bench_strncmp.c      |   4 -
>  .../run_bench_bpf_hashmap_full_update.sh      |   2 +-
>  .../selftests/bpf/progs/bpf_hashmap_lookup.c  |  61 ++++
>  13 files changed, 486 insertions(+), 60 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_hashmap_lookup.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_hashmap_lookup.c
>
> --
> 2.34.1
>
