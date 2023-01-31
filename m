Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F356682065
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 01:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAaAKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 19:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjAaAKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 19:10:18 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB51A947
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:10:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v13so12777962eda.11
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 16:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKikHE9MdFqkhSV5xXdoug4AUCUYnV2PUvk4OlPxBNk=;
        b=d0XLMATuggJJvEjVBLJNBcdw263eIr5ObxqiyQhKTcU3BpuOnTiXFRgSOmrVBIaJvN
         nx62Zvrmz5T660JN6vAlew8PQAAMjxn7y8x53dOGpnRlzvfqGUUpnFuPHP6RmNU2Ir6R
         gdACDp7yaxQysK6+hKVO/vbQ5dzA10zpmyNarnSvgEE1tH+9hS554x8q/TvfiuCuhJd4
         DT+lQSTCKt2RcjPfjjljFGEeAevm2GioT1wQx+KJYRMinMVpT+IrFRFpNjM1i2DLqI9V
         saWUHWbbHqGqGzRURmvb06wOZM9k/ym3T5UPaih9N104IoiBp9BZsm4MWWWUmDu65Qql
         r4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKikHE9MdFqkhSV5xXdoug4AUCUYnV2PUvk4OlPxBNk=;
        b=ajorvOvNrqR9ptXIag5fXR6xi1diclwlhE1hCgqGlxo49RgGMLSLV6Or5ZsfGEDH1W
         o+EZlNShVFXnRkWTHqbqKlMbluAlclbmWFWbJNBkubcy4lOr7gqFp6J3SuzrijCtsgiv
         P30KOvjOh6r5ShDbS9vGmfbf+p0LOJUPsBMqLaNZDVHKotjzNQ99Vak/mr4nsBhVz4ZX
         RaWMjPJmDnVk1dEkwD+6aM8yS00jKWSHN57feEwbVbhnTQFgYFbPXmNht5ZrrN0+lI5s
         oW75FlME8JjyzNMkA4CethyX5G7nY6fAqy7ZG5NADqpGE+/GNih3hjUBHvgFNDMyFJUg
         yceA==
X-Gm-Message-State: AO0yUKWkBXUpm9oXcLtr1x9lpa3yQEsntq4DVP/qvrHdcVdn277dPnZG
        EtlHEWWyVSzW8dD5VTvFu07oQ+jC//R8DMdyApiPIVEA
X-Google-Smtp-Source: AK7set9ma4pt/9PXJSm2dtV6XHbtm6G4C6P7/Ki7p8fjw70m5WXJAu7XjKL7N86VBwaF7LZPUjW1jxeJQk7GhXXeJt8=
X-Received: by 2002:a05:6402:510d:b0:4a0:cfed:1a47 with SMTP id
 m13-20020a056402510d00b004a0cfed1a47mr5665853edd.18.1675123815439; Mon, 30
 Jan 2023 16:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20230127181457.21389-1-aspsk@isovalent.com> <20230127181457.21389-5-aspsk@isovalent.com>
In-Reply-To: <20230127181457.21389-5-aspsk@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Jan 2023 16:10:03 -0800
Message-ID: <CAEf4BzYDnGo+5gZKZc-gYTk0ES+s3hOSv7SKCZ9dV-oSnP6wXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] selftest/bpf/benchs: make quiet option common
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
> The "local-storage-tasks-trace" benchmark has a `--quiet` option. Move it to
> the list of common options, so that the main code and other benchmarks can use
> (now global) env.quiet as well.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/testing/selftests/bpf/bench.c               | 15 +++++++++++++++
>  tools/testing/selftests/bpf/bench.h               |  1 +
>  .../benchs/bench_local_storage_rcu_tasks_trace.c  | 14 +-------------
>  3 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index ba93f1b268e1..42bf41a9385e 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -16,6 +16,7 @@ struct env env = {
>         .warmup_sec = 1,
>         .duration_sec = 5,
>         .affinity = false,
> +       .quiet = false,
>         .consumer_cnt = 1,
>         .producer_cnt = 1,
>  };
> @@ -257,6 +258,7 @@ static const struct argp_option opts[] = {
>         { "consumers", 'c', "NUM", 0, "Number of consumer threads"},
>         { "verbose", 'v', NULL, 0, "Verbose debug output"},
>         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
> +       { "quiet", 'q', "{0,1}", OPTION_ARG_OPTIONAL, "If true, be quiet"},

given the default is not quiet, why add 0 or 1? -q for quiet, no "-q"
for not quiet? Keeping it simple?

>         { "prod-affinity", ARG_PROD_AFFINITY_SET, "CPUSET", 0,
>           "Set of CPUs for producer threads; implies --affinity"},
>         { "cons-affinity", ARG_CONS_AFFINITY_SET, "CPUSET", 0,

[...]
