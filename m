Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA832427363
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhJHWHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243549AbhJHWHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4716460F11
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633730724;
        bh=SPdproSvRCmKuty2nPGNuU/rR6ESnf0YCR1g9D5qETQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TURPWDKhbfy+A3YSQ4ro9nF1+s8IYV0panMGbjzze31S+H3Tay6/9UHYv4sPR/ck+
         IXLubbErRfVStXZgTglwssxdobX+lsoBj7QdX1cQIdtxxY9u5hCakiiPvpEUqm7DUZ
         wko5ka5ZvDbutYZKyXpl8vgYnpFHxJQdNlhkLVb9d82JX600/DdJmBDhGZporKuoCA
         ZFJFmCVyfBUYcXn/gSfGO86CyUU+VVLO3swm6HuDjjKe/AWA30048zuncJC1YFwm7V
         la4ebnVyduNXg7V6AhIK3LjGkcHl63KdM9pk/oITpJclQ+50xdiDsola1f7nkoZNay
         c23fT3DxXrwPg==
Received: by mail-lf1-f41.google.com with SMTP id y15so44649338lfk.7
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:05:24 -0700 (PDT)
X-Gm-Message-State: AOAM530fGCXS9r0BY/forW5oNFWgYeuszpmeVaK9lVTd0i6eYpjI5sCk
        +9xPwLG4PXEGsAnAvx3q+f5tAVkLwpr+SfpDyEg=
X-Google-Smtp-Source: ABdhPJx+aqo5NXdSSVkzGbHKekyhgw7i2wcVycMnaa0RRhHxqMoa6zmPbf6p377rHOswR5Sbe2mN50DA/qS2X1lO/FU=
X-Received: by 2002:a05:6512:39c4:: with SMTP id k4mr12511911lfu.14.1633730722319;
 Fri, 08 Oct 2021 15:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-8-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-8-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Oct 2021 15:05:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7tUL3sdh7n3+hYedE2hDtgb9iOKKAxOye+RVm1OSz7LA@mail.gmail.com>
Message-ID: <CAPhsuW7tUL3sdh7n3+hYedE2hDtgb9iOKKAxOye+RVm1OSz7LA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] libbpf: support multiple .rodata.* and
 .data.* BPF maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:05 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Add support for having multiple .rodata and .data data sections ([0]).
> .rodata/.data are supported like the usual, but now also
> .rodata.<whatever> and .data.<whatever> are also supported. Each such
> section will get its own backing BPF_MAP_TYPE_ARRAY, just like
> .rodata and .data.
>
> Multiple .bss maps are not supported, as the whole '.bss' name is
> confusing and might be deprecated soon, as well as user would need to
> specify custom ELF section with SEC() attribute anyway, so might as well
> stick to just .data.* and .rodata.* convention.
>
> User-visible map name for such new maps is going to be just their ELF
> section names. When creating the map in the kernel, libbpf will still
> try to prepend portion of object name. This feature is up for debate and
> I'm open to dropping that for new maps entirely.
>
>   [0] https://github.com/libbpf/libbpf/issues/274
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
