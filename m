Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A255EA56
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiF1QyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiF1Qwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:52:51 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB1B94;
        Tue, 28 Jun 2022 09:51:31 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id s124so18064548oia.0;
        Tue, 28 Jun 2022 09:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIImyclzEie6daS3MJ59Y7qzWwGyVcdl7WmTJMYAfBM=;
        b=hx5wBBQdWlzXhLE5vvIfhrfWHa4n3G0I3Ira/SYyfBPJ+TIINyQHgGYRfftkZrxOjr
         1MPsew884z8izxh4Kwo3yUtDrKfv+BLDrSoJuzvyE4GM8qYdW4rLxMGLsKA13wJBIGhi
         /WmzZOxosFUDmRsMiSosMhQq/kAreWqQqLaKDzSvL+GK8HYg+MeaLfNty/wGhNZK2vzh
         g835RSJGvfxM3n0XwF5uesun7P8OGQtDwoN5c7U+Hh2ASAO/IVgprV/UGsozcXHwW2fZ
         Vj+WWuzBtpsdz4xTMRvJmgPb5GgyMn0LxM6/v6/3Rn2+jWU7yyeyO0jd7guHo73JqZtz
         3+oQ==
X-Gm-Message-State: AJIora+GLAv6S2Ld9at5KeQvYz+NFLYyUqg5jiGwEzoFXpIoDWUOXCxO
        Fg2KUrP54St1x7kZ79GHNUM52+SCgvcIxN+T1tc=
X-Google-Smtp-Source: AGRyM1sOtsVwdJ9t72bf0ILlSISY03R56hUBLB6mIgS4vFfDEJFKDdMGcdmSxd6tYCt4BfSguYwmaKOLEn/UNsm8c18=
X-Received: by 2002:a05:6808:1385:b0:32f:729e:4869 with SMTP id
 c5-20020a056808138500b0032f729e4869mr366556oiw.5.1656435090599; Tue, 28 Jun
 2022 09:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220624231313.367909-1-namhyung@kernel.org> <YrsS4HxNBUk5wtcU@kernel.org>
In-Reply-To: <YrsS4HxNBUk5wtcU@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Jun 2022 09:51:19 -0700
Message-ID: <CAM9d7cgWLPADU66L_5vfoA3NgofTcjCbOgp7DWxA6LyqekV=mQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/6] perf tools: A couple of fixes for perf record
 --off-cpu (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        bpf <bpf@vger.kernel.org>, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 28, 2022 at 7:40 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 24, 2022 at 04:13:07PM -0700, Namhyung Kim escreveu:
> > Hello,
> >
> > The first patch fixes a build error on old kernels which has
> > task_struct->state field that is renamed to __state.  Actually I made
> > a mistake when I wrote the code and assumed new kernel version.
> >
> > The second patch is to prevent invalid sample synthesize by
> > disallowing unsupported sample types.
>
> So I'll pick the first two for perf/urgent and then when that is merged
> into perf/core pick the rest, ok?

Sounds good!

Thanks,
Namhyung
