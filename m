Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95B62E54F
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiKQTc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 14:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKQTcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 14:32:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E66D4B5;
        Thu, 17 Nov 2022 11:32:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so4022645edc.12;
        Thu, 17 Nov 2022 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7voftGmuSESeHnH51mRqWR1O01T37W44y2d/FtLakEE=;
        b=b+N35A5icMOEgiLaxidcQES6/n5R/EJmuHxCQ6bVKOu39evBSXdqvPpbBYo+MtS5sC
         sAzdVaiI5PvtVKQy7G5wIprymOlOH3d/DVXPQnhEl2PCInDSD6oDfhaSvhqTbaatsWbi
         7ZS1JQKu0JuV8+CS8bMvQYJwYreuT+2Q7D6hP78fRklGdFE5KUv7s3xZCwWqnrY5tXxT
         BmyJyEWH1gcL2FKvTZx1RTe6wveuWYy4MF5TN/pP2WYZ2jodEIT9hNWhLeYCFRTVYrmv
         CrH50D31d5Ip0gqR93IKW4z88HoXQiPpK9tJXIVmwUyalqJjQOd6n8W5evo5cFLgEdum
         r3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7voftGmuSESeHnH51mRqWR1O01T37W44y2d/FtLakEE=;
        b=fDKow4ObJc1rui8JqcfRAcqm8e72OvnrWjMSqlAVmqiiz/HlM1cS4m4B4pZkbfCaQn
         4RTRrrelEENd3zy2U8AhqnKYNlVshedDt0iIbU73HVp7ablqhBAyTYr4tX5wxxvuqiab
         aY8iAr9kWxsxWxjuPZuzvIxoDajclEaiY+SoTeSiWY7AcfOTV2W/aVKmgtLwa+F3PImK
         qe4zYouWSM1cZJzIOSqL3LBNzwg9aKrR0r4rAYhgQbFDME2VCemixT5j36TvyTnvQNi1
         3zrZLldhCcwDlsAQCxhiK82qHYPq4EXEDRt4LCWmgx2HFZN8u2hxX/leXhXsEvkWeI8n
         6DbQ==
X-Gm-Message-State: ANoB5pnE9hxiDlGLFuMFVVSH5BonKI/5M4Y3w2yIoiRLUxNJq9fTkSKn
        grgjRDX16R1myURlvYVg4oEgJDDQc98eTPLQ8iw=
X-Google-Smtp-Source: AA0mqf4gsyUuCmbIF6+d7uuy3cDx5R66+FuWiJiyuTvngw2hYYEMShpCy3Z/k5CgOcHsnIgIe75v6Av9UeplmJgxlTE=
X-Received: by 2002:aa7:d3c9:0:b0:459:aa70:d4b6 with SMTP id
 o9-20020aa7d3c9000000b00459aa70d4b6mr3485789edr.224.1668713542600; Thu, 17
 Nov 2022 11:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20221117004356.279422-1-irogers@google.com> <Y3ZV0FDW70ADoIYE@kernel.org>
In-Reply-To: <Y3ZV0FDW70ADoIYE@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Nov 2022 11:32:10 -0800
Message-ID: <CAEf4BzbZ2-KiM=S6k11+39Y7vQMOmj7YvAd2w59BOXtCacjtFg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Build output clean up
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Thu, Nov 17, 2022 at 7:40 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 16, 2022 at 04:43:50PM -0800, Ian Rogers escreveu:
> > Reduce build spam from commands not prefixed with @. Make
> > install_headers targets distinguishable by adding in the library name
> > so:
> > INSTALL headers
> > becomes:
> > INSTALL libapi_headers
> >
> > Ian Rogers (6):
> >   tools lib api: clean up install_headers
> >   tools lib bpf: Avoid install_headers make warning
> >   tools lib symbol: clean up build output
> >   tools lib perf: Make install_headers clearer
> >   tools lib subcmd: Make install_headers clearer
> >   tools lib traceevent: Make install_headers clearer
>
> Andrii, are you ok with that? Can I carry this on my next (perf/core)
> branch?

yep, lgtm. Please take it through your tree, in-kernel Makefile is not
even synced into Github, so there is no downsides in terms of libbpf
sync.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Testing it now.
>
> - Arnaldo
>
> >  tools/lib/api/Makefile        | 4 ++--
> >  tools/lib/bpf/Makefile        | 1 +
> >  tools/lib/perf/Makefile       | 2 +-
> >  tools/lib/subcmd/Makefile     | 2 +-
> >  tools/lib/symbol/Makefile     | 4 ++--
> >  tools/lib/traceevent/Makefile | 4 ++--
> >  6 files changed, 9 insertions(+), 8 deletions(-)
> >
> > --
> > 2.38.1.431.g37b22c650d-goog
>
> --
>
> - Arnaldo
