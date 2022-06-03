Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA48153D32D
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiFCV0V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiFCV0U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:26:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF11B30F50
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:26:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a23so9712163ljd.9
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jr1dNT+e892BexleCrQnUaUaEYmN3eEmRxKcNbA2Q9k=;
        b=GSe8ogsEfXQ44Ue2sMb4i06jinv48mJSzU7LBa9MWuYzuR1Q3LcfsgX4Fz1w5yUR5J
         fdSHntRCQFQdKgPkL9nnjSXxN1mrbKXe/Bc4oCQ9dHbzRrWIu7U5c6RBKDqzr+NCh0Fx
         qVDjlC6QEPviGVn9GtsUAIdGFxclehiU8I07EBHlY0AVNMk5GW3zQmiJ2CN1Zx7bIQ84
         6376geOrWIuObSqLKBMz0EtqG/xFLX/RtQ9M7bdV4HJUur7hMt+W1Iu/Yx6r5PHhOFrh
         r2pVkivrI1tf03lxz0nfVOKByvW4/JK5PfuyiBzc2AB+EQ0AdGKOO3Ag0aa9ncp/Bo4v
         xMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jr1dNT+e892BexleCrQnUaUaEYmN3eEmRxKcNbA2Q9k=;
        b=BmurT3U2VaOLwd+ANlwkIQB0ScDT2V9sLmqYJLLUuH6km9//fz+5kXqfRAjDRU4lWQ
         P1JiccdYE6ovPrP9efROYSzgf3j3oQ1u+mCoCPXF6wmtwv7GIcdPvdXABDpMU6DBOZ0S
         KJR8TYcz7CEN2Djg6FNSymeIt4zmTRTyLyTYm1bRCthaFsvPwZvwvHEV2sVs1N8RV6kL
         g/v8yQKE0SJ4S2GMaGY0QSgq3nLX5HDuclZ0ZK1lUVzyCuvt+L0q6NaEEzWt9SnhjhzE
         FphR/kNP31NGe13Q5BmKFdnEttIcdooAyBIde3HH33IFEEg1OymW6lf4o7LfynqmyKlE
         Z6xA==
X-Gm-Message-State: AOAM5338++XtMtMtuis6pcwCnt8XAIypu4uejXDZ4gZzeBCF1VxAh9c2
        Ix0kTbPU83OZ0DdFhtKyvw11SPl45PFZHQ99IaHsidrp
X-Google-Smtp-Source: ABdhPJzu4QgmzRiL9AFk8OVII3OLBdylLJAoF+UXmwMUQZPitlMMnBKFmCgxQUJdRLaB6frFLV4Zb/B3z6JT1iS875Y=
X-Received: by 2002:a2e:87c8:0:b0:255:6d59:ebce with SMTP id
 v8-20020a2e87c8000000b002556d59ebcemr7656929ljj.455.1654291578289; Fri, 03
 Jun 2022 14:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220530202711.2594486-1-davemarchevsky@fb.com> <20220530202711.2594486-2-davemarchevsky@fb.com>
In-Reply-To: <20220530202711.2594486-2-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 14:26:06 -0700
Message-ID: <CAEf4BzZZCQsctEEwv=YnUYdcaGevA9sNHs63EeqH+WBzoFXTCA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: refactor bench reporting functions
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, May 30, 2022 at 1:27 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> The report_progress and report_final functions in bench.c do similar
> calculation of mean and stddev, but each of these rewrites the entire
> calculation. Add helpers which calculate mean and stddev for simple
> fields of struct bench_res, or in the case of total_ops, sum of two
> fields, and move all extant calculations of mean and stddev to use
> the helpers.
>
> Also add some macros for unit conversion constants to improve
> readability.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/testing/selftests/bpf/bench.c | 156 +++++++++++++++++-----------
>  1 file changed, 95 insertions(+), 61 deletions(-)
>

please drop this patch, it doesn't look like an improvement

> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 32399554f89b..0383bcd0e009 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -28,6 +28,62 @@ static int libbpf_print_fn(enum libbpf_print_level level,
>         return vfprintf(stderr, format, args);
>  }
>

[...]
