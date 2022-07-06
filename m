Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343CE567D9D
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 07:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiGFFIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 01:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGFFIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 01:08:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C713F6E;
        Tue,  5 Jul 2022 22:08:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d2so25106896ejy.1;
        Tue, 05 Jul 2022 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqW8ITr6pkHCWZBrT39EMsBIfhdgMVbMM4TjNULI/38=;
        b=YsAx5ivwuNl9tLSOYa7dEkxgApDxvzAPmFmc58v+1biY3BiOwjQBT3Czux7A02seZB
         ZvHwwLyVBJ8/44c+cGpsFt2SjJZ/tPqA3lHoByEU/Lne4SS9UfebmIthgZMu3D+hNhpG
         ydOwNUwPS1kX9bReAxKxtfDbjLAazrRZp6QJfdhC+YlA9XeCOMTuwDvGYXXKFd3JHEHM
         rlM4HUi1g1qfRB3E4H5ppWuhzR7zOX4BFh2KZwGJ/ZS20vcAmn2kglgbdb/FrySgFMme
         0QOfZ1zRQx4r1xdRlwkT1OQvpeFGz5CVK5+TZ1Q6m2l86UI2/HGmBnXWrhbUxOtigsrv
         /GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqW8ITr6pkHCWZBrT39EMsBIfhdgMVbMM4TjNULI/38=;
        b=p18/kAjBOxL3+T5D10aC7TaL6hhfEE68iCXBYbprOgMAxgTi1g6GgxYMbeFbj/8kv2
         FC/tibwb5S2ooJhgeuO3v0wcP7RXVD6NPFEvRWMlA6J0nlO5nZ9WGGOuo2LtHuZgp+qP
         OlFSxSrsuH4ZnXa++Zya67TR6AsoKzFtdlhkSFussRcDA1jG2C0BjGGyrywUA6doee/l
         ljNREmG0yNHuhuc0DVqSLhjifEruIY7EhKAkcHxe0IzAwd2B58JwdEo0Ejye3RjCzrxo
         /TgYYil88TP3YB985gxEMlVuLzv0oc0D+yU5LY/tOrg4p7JhecTgohXMbh4F5yuvMSEy
         3rYw==
X-Gm-Message-State: AJIora+iblham9uN7u8CI7+DYNG05/f8OezOjE3UfwBLVAxsoYGFfC8D
        mXH5AxSrqnWrno1N5Y7XR1wULIg9VFGDvdgGolg=
X-Google-Smtp-Source: AGRyM1tHiuUQIegmkhcnzw4aOn0s2ariq+tC53xxAs49MBY6ZpAMRVUYnbv3Gn+5IHRHiXq1jEOx4FGry9WJYCFZ3sI=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr20770588ejc.545.1657084107247; Tue, 05
 Jul 2022 22:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220704152721.352046-1-jolsa@kernel.org>
In-Reply-To: <20220704152721.352046-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 22:08:16 -0700
Message-ID: <CAEf4Bzb+dK9kBsYZ_j=st9LMgFid6GzivQnbNOJ+nyg7zbD8UQ@mail.gmail.com>
Subject: Re: [PATCHv2] perf tools: Convert legacy map definition to BTF-defined
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Jul 4, 2022 at 8:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
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

LGTM. Thanks for taking care of this!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/perf/tests/bpf-script-example.c | 35 ++++++++++++++++++---------
>  tools/perf/util/llvm-utils.c          |  2 +-
>  2 files changed, 24 insertions(+), 13 deletions(-)
>

[...]
