Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62B3228AE
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 11:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBWKN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 05:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhBWKNw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 05:13:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09297C06174A
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 02:13:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m22so10344341lfg.5
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/LuwTXoQO6jvKbzdrCDlo4TVXiV1s6U/zT2nfH4wUo=;
        b=FPv96nKrO3ZcNri+Ayz2U12l2pEPI/lw0/tV7tLSR3XfC/LRI7gNshjvChWIVBHTCe
         BI5/1feI2Ws1J5Dn/U7X5l55dsH0HirpU7aDqLPE5WPdY6KMzyeLjdPTqcyLrgF4FFyS
         VwbhoW4938AyHp0cRXnyeanZcov/zDW+aDsFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/LuwTXoQO6jvKbzdrCDlo4TVXiV1s6U/zT2nfH4wUo=;
        b=hVeoS43Qg6I24qGz726l7qpjsJGtQTX1CS1eWxbjmMFzJmHBImSs7ms23zLg88BETY
         SdpNKzNX0YfsBeHItbaWfLPf0yAlKDGzlYjFqXHzGwfxdZfkTBP9o1MdOnEEF6hBnOKI
         z7MiBfnJetuFoPzPuit3RQguYiI1H9UkfvhmDORBXPyWn34pkdh9n5GgZZy9Uyc4Fmz1
         Vpn4Gxb15C0nkr4IHPYAQTrqyunfoQ+dAe+vc1S7MYFiNEOWtddTxWitpuJgTPtIzzPm
         pSKEEeT4ab6q9PDOSoYtFepn+5C9yORoJqAdhb21Qo+6bDhGp4+MR6z96qGJaucehAFo
         pu7A==
X-Gm-Message-State: AOAM5325ZBr7X9UtB3gU1dCXHaauKpyTlpqpf12NKhndvml5nfSn2F21
        hVHKL6X+aXRXI31FqLNHKMlLWp4YGuUM7KOhNKqgMA==
X-Google-Smtp-Source: ABdhPJwp2c34zaYgmMqQNop0GDw3Dz3h2Gyz1Ym94wDGqDMGBmWfcLJvfeUOyxvf7JEqLJKTDEHFuUKJvUW0XK6MpDc=
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr16966939lfu.325.1614075180451;
 Tue, 23 Feb 2021 02:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20210216105713.45052-1-lmb@cloudflare.com> <CAEf4BzYuvE-RsT5Ee+FstZ=vuy3AMd+1j7DazFSb56+hfPKPig@mail.gmail.com>
In-Reply-To: <CAEf4BzYuvE-RsT5Ee+FstZ=vuy3AMd+1j7DazFSb56+hfPKPig@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 23 Feb 2021 10:12:49 +0000
Message-ID: <CACAyw98gTrzf8+cPnBEC5A3_rg70UUrJxtV9a_w-dMpKn0Wicg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] PROG_TEST_RUN support for sk_lookup programs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Feb 2021 at 07:29, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> Curious, is there any supported architecture where this is not the
> case? I think it's fine to be consistent, tbh, and use int. Worst
> case, in some obscure architecture we'd need to create a copy of an
> array. Doesn't seem like a big deal (and highly unlikely anyways).

Ok, thanks! I'm not super familiar with C platform differences, so I wanted
to be on the safe side. I'll take this up depending on the outcome of the
conversation with Alexey, maybe I don't need to add this after all.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
