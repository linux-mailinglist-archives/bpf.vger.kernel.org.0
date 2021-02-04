Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F430EB7D
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 05:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhBDEOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 23:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBDEOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 23:14:18 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F249C0613D6;
        Wed,  3 Feb 2021 20:13:38 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x21so1803215iog.10;
        Wed, 03 Feb 2021 20:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdcB32twqsu89EL3UdkOt2BlFJjgIF2KmPNLuytB5fY=;
        b=Xqm8gUE5ZNYmuabgd7vz7yifp5ynuWxN3P9EbtuKBfzdRf2DmFLsULl7JrZ5Qa09QO
         ALbptbNa3pdrsylj00y0h7lbRoXHF4J210fBMA8Y9xmk1Y1dOcETVSSzKlxdgFzgNMnc
         S9HBwTPVF0AA02AiAwY5Rn0Am4u/mGi8X8G2jJOka775A49uB1VwdF3f6UkYTZ685GsK
         F06q2qyPhYPJ5j5QF9LNV20VOX/5qu8Gc/J/s63iGKfvDvAlgWs2Ru1GFLT8mAYut8Az
         8jN4yx6FLnGsgFzN6N7pnlx2Bw42GSOg7UiZ1k/FOj5+nnmBusHBRcR3OkT6f3w76t3Y
         2/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdcB32twqsu89EL3UdkOt2BlFJjgIF2KmPNLuytB5fY=;
        b=IusKgnsXZ1n/Cj1NAefcA9PevaUIX++xvlLYfEsi+kldYAIWk65Lcn6EUBNAN1pTtx
         fXAmz/YYFlF8oPlp/pcWWOgztl90UwoOQL8YIFxuMSxZxkAmdxwBDZ+V2ZwlceM8doxM
         sThhzJib4laBt+vOC8k6R/+Z0WkI8eoSx32LS+B4ad9TfvJBsNBV5CGLLah6SM4Zroie
         PyOi3XpDYPPbA5c7JeEqh8NahE6Lb/lcLlta8UogMaJiEJwjoZuaoTKExiG/b3PMDnaB
         8xRTDW/E9qggaszKhpahkAJMbJuMPrNazPE8fFzmspVNPMn8V4l1TRjH9BBqFoOZUM48
         /q+g==
X-Gm-Message-State: AOAM530br1cUQtstbhi76zseVxtIJPDYtXGgAC42KMx81ovJuv83pr4x
        q4yJY236I2/ulTz4yizDHsFEkf4trOinTRIQVm8r7IDWSms=
X-Google-Smtp-Source: ABdhPJxmi13O6Z6gQu9j4iY3LtNElB9YtHYyJngYTuNzEPHo5XIU5DN5XigqE6AosiNca2R6mCkhMkYSlUo/l1kla+c=
X-Received: by 2002:a05:6638:138e:: with SMTP id w14mr6083265jad.98.1612412017750;
 Wed, 03 Feb 2021 20:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210201172530.1141087-3-gprocida@google.com>
In-Reply-To: <20210201172530.1141087-3-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 20:13:26 -0800
Message-ID: <CAEf4BzY_xk2H1Eh9h_WiXbqP3O-afiZnmpWf=MtCrqdJeNW+ag@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 2/4] btf_encoder: Manually lay out updated ELF sections
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 1, 2021 at 9:26 AM Giuliano Procida <gprocida@google.com> wrote:
>
> pahole -J needs to do the following to an ELF file:
>
> * add or update the ".BTF" section
> * maybe update the section name string table
> * update the Section Header Table (SHT)
>
> libelf either takes full control of layout or requires the user to
> specify offset, size and alignment of all new and updated sections and
> headers.
>
> To avoid libelf moving program segments in particular, we position the

It's not clear to me what's wrong with libelf handling all the layout.
Even if libelf will move program segments around, what's the harm?
Does it break anything if we just let libelf do this?

> ".BTF" and section name string table (typically named ".shstrtab")
> sections after all others. The SHT always lives at the end of the file.
>
> Note that the last section in an ELF file is normally the section name
> string table and any ".BTF" section will normally be second last.
> However, if these sections appear earlier, then we'll waste some space
> in the ELF file when we rewrite them.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
>

[...]
