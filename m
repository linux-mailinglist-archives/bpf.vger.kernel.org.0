Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A010C2AC365
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgKISME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 13:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgKISME (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 13:12:04 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779A1C0613CF
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 10:12:04 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 2so4999299ybc.12
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 10:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJaU71BmUVQDVbleBx8Lzwyu7uuf5QVUwlWKiLooY8I=;
        b=JnAbwk9/MaPS8SO30mhU6jU+uS+0lVrHeRriuqEKsgFPEpDfQRb7udUUbD1hRJG56/
         I9k+8zFnyLEaEGMvD5zC/pL9u7VaQ/AS9t7Yda2R2xbcvR93HUD3CEgXQbpHw1m68s7U
         MyJ5V7qPYmcVoRSX2dno1+08wuwOjXy/xC1Fc1YW2iCsHCuUfV20ni6qyT1RQ9c3xT1+
         2Q9N+Y5kVYitHLvjLJqUtrRqZUUKMswFajj1R/dO4GAn5wEA2Sf6FhWURnp+dQqGwlZK
         FojkRsmi3eSVEDrBB0IMzP7E4kk33GJV6jHJMIKcZAyDGcnA1UnFbRbEGHEa45/mhfCh
         lOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJaU71BmUVQDVbleBx8Lzwyu7uuf5QVUwlWKiLooY8I=;
        b=RWkaUfTbmhiVMiJENE0L6YMkkEyv3NIcSPi5cyUirFE8w/52hPmzaCGw4TJzJn97Bz
         avgNXMdeGJ0w77u7mtbJjUeAoSqBGqv2CmfmtzddVWUV9VsyU9E+Cu9Ko/Nygce/yxpW
         QQi/utR+GRr19YPezunDLHcGxs2ydMfnMFJAkQWPXJerwzelzDve0oF1IPUETEZuN6wn
         8r9ihn/tJbzgh5kl0TzuKSgJIMAsBOGO77VcgrDvMESHXYvhQGrL+t8SAQcV22bJwSoo
         IBPn8E9CgH23x09eeeW6FHth+XeLgYGYLh/AeFGFIfYJS8DLP9L8Bh4a0KANWDAV1umD
         356A==
X-Gm-Message-State: AOAM532ZXhRICbebtNu8uKPrumToe0vgqJFAHvcC7rDTQ/hGzW7gYmcJ
        JBtJICUurbI3E0ddDYlhj/OEXRIT611svLkLRew=
X-Google-Smtp-Source: ABdhPJyaEjW6bV36+iASx7Fdr0lauqsM1kF6tJC3kh+6pVt1KCW6vFy/956FDZ11WxowcWm5ar/4uagZaJEdyzQ7oFA=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr9373992ybd.27.1604945523763;
 Mon, 09 Nov 2020 10:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Nov 2020 10:11:52 -0800
Message-ID: <CAEf4BzZeymUUNSp-wg1_UVUH_7-N3JaXWT7qArqT612459nLmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tools/bpftool: Fix cross and out-of-tree builds
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> A few fixes for cross and out-of-tree build of bpftool and runqslower.
> These changes allow to build for different target architectures, using
> the same source tree.
>
> I sent [v1] ages ago but haven't found time to resend. No change except
> rebasing on the latest bpf-next/master.
>
> [v1] https://lore.kernel.org/bpf/20200827153629.3820891-1-jean-philippe@linaro.org/
>

While you are looking at bpftool builds... Seems like it regressed
recently and doesn't honor -jX setting. Either way the build is
sequential (and rather slow). Do you mind checking if your changes
could fix the regression (I haven't had a chance to bisect the
offending change causing regression).


> Jean-Philippe Brucker (6):
>   tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
>   tools/bpftool: Force clean of out-of-tree build
>   tools/bpftool: Fix cross-build
>   tools/runqslower: Use Makefile.include
>   tools/runqslower: Enable out-of-tree build
>   tools/runqslower: Build bpftool using HOSTCC
>
>  tools/bpf/bpftool/Makefile        | 38 +++++++++++++----
>  tools/bpf/resolve_btfids/Makefile |  9 ----
>  tools/bpf/runqslower/Makefile     | 68 ++++++++++++++++++-------------
>  tools/build/Makefile              |  4 --
>  tools/objtool/Makefile            |  9 ----
>  tools/perf/Makefile.perf          |  4 --
>  tools/power/acpi/Makefile.config  |  1 -
>  tools/scripts/Makefile.include    | 10 +++++
>  8 files changed, 78 insertions(+), 65 deletions(-)
>
> --
> 2.29.1
>
