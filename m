Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96E568FA0
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGFQu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiGFQu3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 12:50:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FE2A41D
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 09:50:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so28080705eja.8
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaCcNJUc/PsXyUHcRjXip0ZsV/ByK7ustJKLF8+SsWM=;
        b=RwclD5KFXWfbo/tSAqN6oS8Om8060BCLcvrdB4azIOAC1AMbjSwsfdmksIaBLM4aEK
         rT18R3/rTCPvpW1tQhOMkVhb55GXZ268C6TcQkSp3G66wacHJmGZL+9ukiqRaKNC7JUA
         8ktoRxAuQqtANFXq/zeFsCPE1u3EIXHBKnp1ZO1fOdjkKqbcKwBWcETZuC1hVJelIcE4
         qd+l0oNJ5aYqosLKg8bUWwgqtys7boWuxv8baeJG/tZAEtm2nlIjTCQEAx/MqWs0nspv
         klHtrp6YeFdQ+MYVDqHEUkmXLQh6dkMEUSaiIFe4bAN6/0JlxovbE7oCAl17l8uZIpCA
         EDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaCcNJUc/PsXyUHcRjXip0ZsV/ByK7ustJKLF8+SsWM=;
        b=SxGBJyPhxCC3niYCo1KD68WBUiK1aQS3p2ZXLhXzDXxLFGVny1AC1CeU6OX3nk153x
         Kd9uxNkfc9r6PIr+7TcaEqSOiVG/zOjY94EmuO/iaFqO/B3a6WEiH7oGlNP9/Rui+fEY
         T16pKaDl82gT6Ec5aDjrsKh5EtyqAH9RtNgLG5q+kFsjERcvp5UF9zttzWLS3IcjPb3/
         WHHcNVTPLiVRGRM7QTz8hPNLH9rmRn5grg1DZMrat59fRph3Hc7k/FmtODPrSdV/OUzK
         2jJk330v+jR44dlBCuH+3GFnsUdqD4IlkOnzKFZTPFfNJhIrwQYyGmM7Gu0FiP7AuvP+
         zgOQ==
X-Gm-Message-State: AJIora8P59/QI4KJDgV3BKqVaVUWL/tMHRalgJYH8m8R9/AUg+UnRTKd
        aXCQoomolsAnLhMYNmj4+HEMaWgeIUoD8PofEt4VxfP6LBU=
X-Google-Smtp-Source: AGRyM1s56Krm+r4duhrMOBvrAx59qA+Knwvzznejo3C58kFdClv4PX0Lf4SApdHXBd7z5a7pi5acjte69nu9yebdGtA=
X-Received: by 2002:a17:906:8444:b0:72a:7dda:5d71 with SMTP id
 e4-20020a170906844400b0072a7dda5d71mr30262560ejy.94.1657126226615; Wed, 06
 Jul 2022 09:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-3-laoar.shao@gmail.com>
In-Reply-To: <20220706155848.4939-3-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jul 2022 09:50:15 -0700
Message-ID: <CAADnVQLHDATCgQE39nVTy-LE+Mhx-hXbj8phBeyUKFc1f=W-6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Warn on non-preallocated case for
 missed trace types
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
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

On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE and BPF_PROG_TYPE_TRACING are
> trace type as well, which may also cause unexpected memory allocation if
> we set BPF_F_NO_PREALLOC.
> Let's also warn on both of them.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3ec6b05f05..f9c0f4889a3a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12570,6 +12570,8 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
>         case BPF_PROG_TYPE_TRACEPOINT:
>         case BPF_PROG_TYPE_PERF_EVENT:
>         case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +       case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> +       case BPF_PROG_TYPE_TRACING:

BPF_TRACE_ITER should probably be excluded.
