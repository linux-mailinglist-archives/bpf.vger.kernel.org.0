Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4749C383
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiAZGN2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 01:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiAZGN2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 01:13:28 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9770BC06161C;
        Tue, 25 Jan 2022 22:13:27 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i14so18756453ila.11;
        Tue, 25 Jan 2022 22:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSYmlZQa0IaWT/qL+jT1l6pxc0f984J7li9TgluA20o=;
        b=DcyDzDt3CRxHhBEU5u//5poH2cpJtT6SF4Jo08K8+An7daQafsdXFN/6mWB0YBRTsA
         XFBmh6yPgttBsU8yaOGYHpnrydPFpxW4TDAn7cAydeRij09cBZA7w/OL7AkpfPQefjKw
         VJYI6jaY8xiRaU5hOR6/JcymcHuJtXWgBjibDZudOtVWX1f1pjtuwEnmHa/PSGhvzaFX
         Y+IHG05pdf2WA4LJuoPscJMVixqIB9dZbuoRbdQs0cHpf2fAYc4P8H/bP1oi3EaqZLwZ
         b/UBNjoQE5fnnLL/v3t+umG1CZf9ekBL9vu0nbpMLqrqVqzE0qiaFeoapeItyD8nq/yR
         0vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSYmlZQa0IaWT/qL+jT1l6pxc0f984J7li9TgluA20o=;
        b=q78Qlc5mwc3bGvuRUjFz8Wlz9owjhSjoX+RgD9sHU7lnIXYOJ655WkDiQ6XZMOUF55
         LXcI8XQgK4qVzTJUHhDKy398da0RxErVjgxGXsj0S/W3KxAKu0xEZ9BZI6xeksLc76hX
         1PsZU7FhJWU/REiCEnpLD74KI0RIwv87Jq2V0Xose11wa1E32q6njx8YKaEKK67owhs+
         qcYhbupx/Tel1WRUg4Z0u+1p1ZUGigYwi5w94ekg3axswVyROjqpQX5y4suVJivE7G61
         w7vnlr9DFSq0c+haX1qpqGh9LLYbGrb8CPko4Vh4NJtT+tmCY16oODoZMif2qATEaO1y
         MiFQ==
X-Gm-Message-State: AOAM531J4Pd71SSvw9uM0lpgmySyShIRd03vbfEIb9eK+DWfmICJAMLL
        oLNvzdgk1N6ChHRh22Nf9aw9XLemZkq4F9HgUBA=
X-Google-Smtp-Source: ABdhPJyqtDX4KyOT5+g3DIRBgl27MBpzyDUDNdtz7Sfz9hPZsityiQQ9yD5y8nU0fibdtBgLMoF/DYoJJi99MXoVCek=
X-Received: by 2002:a05:6e02:1c01:: with SMTP id l1mr14102334ilh.239.1643177607010;
 Tue, 25 Jan 2022 22:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20220126040509.1862767-1-kuifeng@fb.com> <20220126040509.1862767-3-kuifeng@fb.com>
In-Reply-To: <20220126040509.1862767-3-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Jan 2022 22:13:14 -0800
Message-ID: <CAEf4BzbRHe+KiqcP0zsq64LMCWxOJGJBrEWHrV-gccMeQ6g7dA@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 2/4] dwarf_loader: Prepare and pass per-thread
 data to worker threads.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 8:07 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add interfaces to allow users of dwarf_loader to prepare and pass
> per-thread data to steal-functions running on worker threads.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  dwarf_loader.c | 58 +++++++++++++++++++++++++++++++++++++++-----------
>  dwarves.h      |  4 ++++
>  2 files changed, 49 insertions(+), 13 deletions(-)
>

[...]

>  static int dwarf_cus__threaded_process_cus(struct dwarf_cus *dcus)
>  {
>         pthread_t threads[dcus->conf->nr_jobs];
> +       struct dwarf_thread dthr[dcus->conf->nr_jobs];
> +       void *thread_data[dcus->conf->nr_jobs];
> +       int res;
>         int i;
>
> +       if (dcus->conf->threads_prepare) {
> +               res = dcus->conf->threads_prepare(dcus->conf, dcus->conf->nr_jobs, thread_data);
> +               if (res != 0)
> +                       return res;
> +       } else
> +               memset(thread_data, 0, sizeof(void *) * dcus->conf->nr_jobs);

at least in kernel code style, if one branch of if/else has {}, the
other has to have {} as well, even if it's a single-line statement

> +
>         for (i = 0; i < dcus->conf->nr_jobs; ++i) {
> -               dcus->error = pthread_create(&threads[i], NULL, dwarf_cus__process_cu_thread, dcus);
> +               dthr[i].dcus = dcus;
> +               dthr[i].data = thread_data[i];
> +
> +               dcus->error = pthread_create(&threads[i], NULL,
> +                                            dwarf_cus__process_cu_thread,
> +                                            &dthr[i]);
>                 if (dcus->error)
>                         goto out_join;
>         }

[...]
