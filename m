Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A710644DBE0
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKKS7F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhKKS7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:59:05 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10894C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:56:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id d10so17509610ybe.3
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErqFIvW9PcJ5s8cA1ZIVAY0RDKThUMnFOK+iEmSPbh4=;
        b=Xd0egUr7E/PzNa780TPM3kxVchsjAdN8b3Ay9jZkK04YUmITa7325mz8+Id3sKBG2a
         58tWINwE/cPlTMbeWI9zc0NT9t6i9Geuj2TDi0JJMgDwv0Uz44EjVb56XJhm3K3BFYkI
         9WJTvHlEtqcsy8WSB49hvE3y/lVg2h7tCE+dweSc8kXfPRn3zQurnSyTqq9gyBQTS4+0
         qbiCZuNfCjGLg3Kf3UZBDnzv5InPzFiGwDEofxw2avEw2ybAJ3QSx+9TS6+Fpn5ORqJJ
         3QHrK34U926luMcI9RG61l7Z+54QqJ+qXh0KEO3VqN63dK6siU3AsgHT3eR422xuARdD
         6EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErqFIvW9PcJ5s8cA1ZIVAY0RDKThUMnFOK+iEmSPbh4=;
        b=SwuNM1soxN+gAlMHbwsSl9Kz54D1R+SSMlh1RKTumLcdDqqca12QVSy8qY2FuD/cxM
         TYB6NHoTuEJt2aTQD92mYJZOqwq4z4zAChI8UZC+FVkv/PUEDkVJbofM+uy4vp3LJtrL
         T1iXydnvKGNOh4hohzHTSe14C/lJWWyx0v//WcgB8cuzX1BoVWNSi3f3jkqxFR/n/rF0
         opwgoYQAq22U+P3EvZR+SvnsmzIX174CjjxA3kXwTjKFRv1bi21+wH3x512SolzcZ0l7
         DGlrBBeeBJKNLosRHWXlvZieM+DXg9qVYH3tL7+6Zbg08Ln+4monCfA0yJkGEENskY99
         8hHA==
X-Gm-Message-State: AOAM532fr4IFWBzqs0heFlMM2+UVL/5O7XvcopD4V2NPwO3/xd72TvBO
        nJ7ju12KGrgUCIqZ8D0BCzRp755qWsLQLXKncYLdSeJgZSg=
X-Google-Smtp-Source: ABdhPJybmdNjMXS+efTkteweULDexoE6+KNS34TEWdPgTEtoOtOgNqe0VI1++UgESOaWKFuyxkebcYCIoCNgys4x+3Y=
X-Received: by 2002:a25:d16:: with SMTP id 22mr10167689ybn.51.1636656973313;
 Thu, 11 Nov 2021 10:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052028.372604-1-yhs@fb.com>
In-Reply-To: <20211110052028.372604-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:56:02 -0800
Message-ID: <CAEf4BzYV-u+ceGMfRkfX7vgB7F4NY6jBt0ToqNRipgwp8g1BVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] selftests/bpf: Clarify llvm dependency
 with btf_tag selftest
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> btf_tag selftest needs certain llvm versions (>= llvm14).
> Make it clear in the selftests README.rst file.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/README.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

[...]
