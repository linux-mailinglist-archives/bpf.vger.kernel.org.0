Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A401556060F
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiF2Qnf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiF2Qnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 12:43:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559120F65
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 09:43:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k129so8317812wme.0
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyNdAiqX42nvqZ9JWQ/ZZaNT635XeywxS5XfMuA1CNA=;
        b=opEEI8h3+r0PCqDkmte4H0kX0dHSW0KHKiFIN9QkbQDYyw9MZk+K4YkwZZpBiNBh5o
         PHZ00wpnpy09QVuA596YHI1IXuFiGKStIGwr355sBtLqirvwyu+X+pzoba8Hvl4CeSRA
         951rV2x5tz49mFgmEZagaOIQnxeC4i8gdj/ncHjPxVj5ni2WdWP19l3dcdTgAVeh9NPn
         KWshRxNd3Tv9VpnUv4FcBVmyHC4rXb/yTMURlMZNdKCCiE7mkMm1GktD2EkgvU4BLw7M
         M1SCUkOyRIzFw7gmJnN5el0E6eFz9I1sVr3cLEt/TDOEOnh6RFLIhD9R3JEx/fNOqD++
         0Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyNdAiqX42nvqZ9JWQ/ZZaNT635XeywxS5XfMuA1CNA=;
        b=kD9hdLk9n+7trS8aB/Xn1xn80vutGFGt9mIEfVCV4s0XwcAfi+GVkgImHwYPEVs3tj
         Yad0IFNy6T38O/PPRW0tcKjoLz1NLaThS+Npt5DohRlrcbwRl50sBVTkAeXesdaPua8d
         G3NE0NaiFxiIJx00Ji4MpkLLctLtdxETctdZr0e3tcQjFbWB+hJUULmoe0bg563LvuZ3
         zd/pxl+thi9C7sUDtP16Arhf+yUyrN5nhA4hsh2Zgpb6o0f6KqDB2Zp6TeXgz+/js41Z
         VMPTDsii33+pfOFrwdhTGCeQTZdfVtcomhv8PEm1ZY22LOftn+rta2De6z423EcWJhhS
         muww==
X-Gm-Message-State: AJIora8YuU3ha6lQg7yfUdLgX9JamHnHbbk8KRPnX1Nr9WS8QNZQ8lpl
        a92SEasVqnPUWeO/P+UwQ/59P+8sVPyg1I7stNmD2bCqWRa/gg==
X-Google-Smtp-Source: AGRyM1tzVMu+TvVRluK/L7Osh8Zh1JGst4FUzpq7H+X2NAYP7sSYq8BO0Hw75njUXs/skzfjKMMdQXFX07FY1+vv1dA=
X-Received: by 2002:a05:600c:4e4c:b0:3a0:53a2:48b5 with SMTP id
 e12-20020a05600c4e4c00b003a053a248b5mr4628041wmq.174.1656521010316; Wed, 29
 Jun 2022 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220629112717.125927-1-jolsa@kernel.org>
In-Reply-To: <20220629112717.125927-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 09:43:17 -0700
Message-ID: <CAP-5=fWm5uZYrxakCZuJtWgVFChNje2SpPgDXD+Xs=XnmB2dzA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Convert legacy map definition to BTF-defined
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 4:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The libbpf is switching off support for legacy map definitions [1],
> which will break the perf llvm tests.
>
> Moving the base source map definition to BTF-defined, so we need
> to use -g compile option for to add debug/BTF info.
>
> [1] https://lore.kernel.org/bpf/20220627211527.2245459-1-andrii@kernel.org/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/bpf-script-example.c | 15 +++++++++------
>  tools/perf/util/llvm-utils.c          |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
> index ab4b98b3165d..065a4ac5d8e5 100644
> --- a/tools/perf/tests/bpf-script-example.c
> +++ b/tools/perf/tests/bpf-script-example.c
> @@ -24,13 +24,16 @@ struct bpf_map_def {
>         unsigned int max_entries;
>  };
>
> +#define __uint(name, val) int (*name)[val]
> +#define __type(name, val) typeof(val) *name

This is probably worth a comment, reading it hurts :-) I expect that
libbpf provides a definition that the rest of the world uses.

Fwiw, the pre bpf counters BPF in perf needs a good overhaul. Arnaldo
mentioned switching perf trace's BPF to use BPF skeletons in another
post. The tests we have on event filters are flaky. One fewer bpf.h in
the world seems like a service to humanity (I'm looking at you
tools/perf/include/bpf/bpf.h).

Thanks,
Ian

> +
>  #define SEC(NAME) __attribute__((section(NAME), used))
> -struct bpf_map_def SEC("maps") flip_table = {
> -       .type = BPF_MAP_TYPE_ARRAY,
> -       .key_size = sizeof(int),
> -       .value_size = sizeof(int),
> -       .max_entries = 1,
> -};
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, int);
> +} flip_table SEC(".maps");
>
>  SEC("func=do_epoll_wait")
>  int bpf_func__SyS_epoll_pwait(void *ctx)
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 96c8ef60f4f8..2dc797007419 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -25,7 +25,7 @@
>                 "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
>                 "-Wno-unused-value -Wno-pointer-sign "          \
>                 "-working-directory $WORKING_DIR "              \
> -               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> +               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
>
>  struct llvm_param llvm_param = {
>         .clang_path = "clang",
> --
> 2.35.3
>
