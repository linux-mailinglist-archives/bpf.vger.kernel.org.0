Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648344C8088
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 02:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiCABur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 20:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiCABuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 20:50:46 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052519C0F;
        Mon, 28 Feb 2022 17:50:06 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h16so16866344iol.11;
        Mon, 28 Feb 2022 17:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4k4h4W32vCuhVOfXYYjtUEmCRraNFfrLiqh99nzYlg=;
        b=Ww6CrvkdCe1kExj6qFfy5yN3tZzwpshF+sOVGqd5kLr6MmHzPAySDXEZVigUWoQr2W
         8RJmx6rtsgWv4R2w9ELD6dr5Fcp7Bjh9IbWUvX5D4lv8czk//oy9G1jNMyWB8eAGtHWi
         BvaNYtQOkvKcd5vYX5Fkf+w23VUezDm1PysbmeBweSKGMT5vTgmmcTkEIecxTYiw45JF
         S0TEf8fup2sMT6I0MjgCJkrwkFWw3itviLWw333fIED2D5gmaPFzJ9Qy1yA8ppu/Y/14
         Iyocq3dGn7i/zOpfJHoQotiIIyqD6mdTW3zkGiEb/i29gWtnGTfze1D0Tl2Q6/zc0D3v
         JWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4k4h4W32vCuhVOfXYYjtUEmCRraNFfrLiqh99nzYlg=;
        b=Ji820dblqGsboTfuB5uuAuUHvdxj/2r8+KHE7KGRfxCXEZZU/R3Kbb84aZhK29/y/M
         09dxiLUgjNtiVi6/C15YEJWOjJJEjJ7shUkLI+VFc5B5JyRjAZd+aow3ZLQiFEyWc0m9
         FCI4qV6y3Ut/CNwFJ+zryt0w3RQIDL2VV6F3nW5FAvdiGuYpUyP21RLHKyGevNx6cFLG
         ACd7l0dX1mfHImv4NKgjIstlXFzXvSvg7zDLvLpM5rQaan0HpPUSi6w4UvCGjljYeYkw
         NxRHcpw7IkN+8N9/Q1XmLAl3mb4KKMIqBV+xlNqYIZ61prfLDPJYqe+cvh6ef+f910Wj
         FXZw==
X-Gm-Message-State: AOAM531j+GGHaHcE+4h9D1XL1IReWGKkOsl2JDSJNVpCNetdCdus1y3d
        tbC3RinW/OJfKYem8B8drOUUOGmtOAp2ER9O0QxfeERFXVoldA==
X-Google-Smtp-Source: ABdhPJxhchNLllKl2ENlaQzYuRzg7UBU6bBEGnXAV5zUD1eqT1EY+Izp2kQxuI/52xByjPpoP+nNth+WfqpLr3ibaL0=
X-Received: by 2002:a02:a08c:0:b0:314:ede5:1461 with SMTP id
 g12-20020a02a08c000000b00314ede51461mr20195817jah.103.1646099406395; Mon, 28
 Feb 2022 17:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20220224155238.714682-1-jolsa@kernel.org>
In-Reply-To: <20220224155238.714682-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Feb 2022 17:49:55 -0800
Message-ID: <CAEf4BzYZ5adRWP7AtnwDEa51UArjgWvBCF0d+tvoVgv+QSv2cA@mail.gmail.com>
Subject: Re: [PATCHv3 0/2] perf/bpf: Replace deprecated code
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

On Thu, Feb 24, 2022 at 7:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> the original patchset [1] removed the whole perf functionality
> with the hope nobody's using that. But it turned out there's
> actually bpf script using prologue functionality, so there
> might be users of this.
>
> v3 changes:
>   - sending priv related changes, because they can be already
>     merged, the rest will need more discussion and work
>
>   - this version gets rid of and adds workaround (and keeps the
>     current functionality) for following deprecated libbpf functions:
>
>       bpf_program__set_priv
>       bpf_program__priv
>       bpf_map__set_priv
>       bpf_map__priv
>
>     Basically it implements workarounds suggested by Andrii in [2].
>

LGTM, for the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   bpf/depre
>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#t
> [2] https://lore.kernel.org/linux-perf-users/YgoPxhE3OEEmZqla@krava/T/#md3ccab9fe70a4583e94603b1a562e369bd67b17d
> ---
> Jiri Olsa (2):
>       perf tools: Remove bpf_program__set_priv/bpf_program__priv usage
>       perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
>
>  tools/perf/util/bpf-loader.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 141 insertions(+), 23 deletions(-)
