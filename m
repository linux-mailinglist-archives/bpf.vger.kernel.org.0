Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625D4BAC1F
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343736AbiBQVzk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 16:55:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiBQVzk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 16:55:40 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C21680A4;
        Thu, 17 Feb 2022 13:55:25 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id q8so5411092iod.2;
        Thu, 17 Feb 2022 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzGHEeXu8qLa160V5UZX2UopdW7xy02LCvRanuKe4aA=;
        b=Su1vjtXg2FKoyFSL416m7D0PGEXJQemZAFUvAm2KSIh4CjFOEYsdtdDYLVrwqNf+FO
         mMdkBAvlPio3IM7jN86ukcAQCfxgv/nrG5MQDO8qU7jbj5wAqD+VgTTPKU2hXZ2oMizz
         8sMzM8GRQMHNlvClufoIyp7IcbIYowFFVxWNTbUEAvsPO0WU8zAfrecnL7wNIjA3qTBo
         rrMn/PWeUpeifbP9PKToLXnPqqXy1goqx7jYY2fvlSE5Dwuz8s4tsiqF2M3mQxCOTD3u
         lwAk3t8zB2aJqAqQVlKHnlYIb/a7+eA0jCh7kQ0Dzec6uGs/pwarPTx1UJcBKO2JraVw
         0lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzGHEeXu8qLa160V5UZX2UopdW7xy02LCvRanuKe4aA=;
        b=31oySHvg9PztjCe8f9/4MZedCv6J96WAKalhJ29NujW2dwLEfhHsFRJWlsBrQuI7gk
         mWVR1goD01FnQF1VnD+bMUz2WaDp3Fjt0gADmHQWlNmE1O9a/aKthAbk/1XUGOyagwZ8
         IJPTwaPPLgsVAQhw6rcSWEqKJEWU8DFMm6EujVbrC+3oWgutZEi6msupYik+/P+z+E9g
         hXY996dVwAbZxwlqqADppntf3KSsSNVlyU5hHdR3he13IaUYdNf5jsI5ROGi9SKo2DHZ
         jjUMoIiK7CtLD5kFagLkJtntnQMkOapTXyrepSKv4a5EW+SB/5dXsFYBER8B/aqO/zMl
         5fBw==
X-Gm-Message-State: AOAM532IaPfRPhMdMz3fzXRZnd/VcrkwcvU5zeWcBZL9x+c74IzfxuIf
        cw2ShEr+85iqNGVEZp0CId5C3CnvFdyuGvbAKpU=
X-Google-Smtp-Source: ABdhPJw7wiutofbKqAgsHlE9hG5ZQ/cLRNXVIQDjG9ngh81dBu0Y1TaMM4hTVZ9x4c/KCdVDdLYplTTogMOwSV1SfVA=
X-Received: by 2002:a05:6638:2656:b0:30d:23ec:fcbf with SMTP id
 n22-20020a056638265600b0030d23ecfcbfmr3439041jat.103.1645134924694; Thu, 17
 Feb 2022 13:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20220217131916.50615-1-jolsa@kernel.org>
In-Reply-To: <20220217131916.50615-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:13 -0800
Message-ID: <CAEf4BzY+_3vjtN3dJjU4deVR131=Dz-9adYQ+mntVqgAOfh4RA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] perf/bpf: Replace deprecated code
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

On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> the original patchset [1] removed the whole perf functionality
> with the hope nobody's using that. But it turned out there's
> actually bpf script using prologue functionality, so there
> might be users of this.
>
> This patchset gets rid of and adds workaround (and keeps the
> current functionality) for following deprecated libbpf
> functions/struct:
>
>   bpf_program__set_priv
>   bpf_program__priv
>   bpf_map__set_priv
>   bpf_map__priv
>   bpf_program__set_prep
>   bpf_program__nth_fd
>   struct bpf_prog_prep_result
>
> Basically it implements workarounds suggested by Andrii in [2].
>
> I tested with script from examples/bpf that are working for me:
>
>   examples/bpf/hello.c
>   examples/bpf/5sec.c
>
> The rest seem to fail for various reasons even without this
> change..  they seem unmaintained for some time now, but I might
> have wrong setup.
>
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/depre
>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#t
> [2] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#md3ccab9fe70a4583e94603b1a562e369bd67b17d
> ---
> Jiri Olsa (3):
>       perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
>       perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
>       perf tools: Rework prologue generation code
>

It's great that you are deprecating these, thanks a lot for that! I
suggest to also doing libbpf_set_strict_mode(LIBBPF_STRICT_ALL) to
check that libbpf 1.0 won't break anything. For example, you'll need
to use a custom SEC() handler to handle those quirky sections that
perf allows. This patch set has landed in bpf-next, so you should be
good to go.


>  tools/perf/util/bpf-loader.c | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 230 insertions(+), 37 deletions(-)
