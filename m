Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12FB427364
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhJHWJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhJHWJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:09:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2125261040
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 22:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633730862;
        bh=0k4lWlAuAn27QjjPHjk5ZD9JnED0kody/SFlSHRq13I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cI58irP+AyjzBiPrfZ7J/JN9YlTQ7zCeUHv5pj/GhP9kmSH0qU67dOvhIFgzQqmyh
         OY0CEoBoQQfuMyGvd4j5A/7VoGUWx/aJvnDKp0XQTtPIjBE2Dc8DQOve76xunaYsFq
         CRgvLmNSEzw0lfOOn2fhGUSPYpFGhLfNBnUw2jbbJ7l0cwEHmMlV1/XLIvGcmeJfmM
         /POhcsqPSsLXHW90zEGT/dRUNjQJsMYHUszlzx7S6DW7QVhdUiAJ/rMB1fCHTyvhkm
         8/QYpyBESCXErKHDDAj8bHBoctadtgeoSDR7L0eX8jEQCoauh7SINs3ZxXKPjJiJ63
         ZdQeGcMYT5TIw==
Received: by mail-lf1-f42.google.com with SMTP id z11so36124308lfj.4
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:07:42 -0700 (PDT)
X-Gm-Message-State: AOAM532i/8vth5QtW0VY4SV4/ojF16qka5eNIRzxeTXozQzgodN0Ip1k
        gl2ELnQgOp7XpQrcs6Oh15xK9vr7d2g1ki0F2x4=
X-Google-Smtp-Source: ABdhPJxSIpoSs94G423hnxtKcsmAFlGY9Tu0ABn/eajT23OoC5ABtvIH65k+1R7XUfJv7nxSoNu9SQwhz6CFXQ5632E=
X-Received: by 2002:ac2:5182:: with SMTP id u2mr12437787lfi.676.1633730860291;
 Fri, 08 Oct 2021 15:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-9-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-9-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Oct 2021 15:07:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5uc8M5JRMbq9uYsDwNJtLoTyQ7n5NvMixG94pFVOtHsg@mail.gmail.com>
Message-ID: <CAPhsuW5uc8M5JRMbq9uYsDwNJtLoTyQ7n5NvMixG94pFVOtHsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: demonstrate use of custom
 .rodata/.data sections
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:04 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Enhance existing selftests to demonstrate the use of custom
> .data/.rodata sections.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
