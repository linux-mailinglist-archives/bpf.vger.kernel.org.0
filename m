Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A82FDA5F
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 21:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbhATUGT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 15:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbhATT6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jan 2021 14:58:18 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE2C061757;
        Wed, 20 Jan 2021 11:57:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y19so49305183iov.2;
        Wed, 20 Jan 2021 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFAzucvwTgKhltZQcovBVjnsARW7ZpX0kzW41n4VbCA=;
        b=LLLxc5ua6JWaH0ovVLfPkZT5o4iQ+TYpBigrCwUQGCwHbVpCEBbQ4OaHwMjsE4fJlx
         APHpFT1R8s4BbSRyGNnziHhXW7ZoBslo3mFokxG5zpaxInDmGTJR8rJYg8enzASu9Pv1
         uSMPt7K8wc53s1bROHiOz/01NrdXGu6/QNqsxDiPBFtUzJZ7ZZLQmTQzShna4ZL2UESY
         vLSJyUzWh4efUmmwfvt3PMTctTiGRwvdQ0BMFaPVKzYXSKlSXgnhv1fNG9LEXx3uZUTS
         nnCfV36BsTSJsshKbA1CiHN0twFRT91JjmmbeGszC99A3dsrAiV8RRniXCEhFHmHbu7q
         Oy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFAzucvwTgKhltZQcovBVjnsARW7ZpX0kzW41n4VbCA=;
        b=UmEiEs2TTIp2JH8AzaT7y8xqOD0Ds2FmxaM5ubDMXrLCcRFcuYuWzdfidcDELKxDOn
         CpLhrY46Y0mNThGd7lh6/rzsdbq4KTOWTYL2TiMlRR35fElDmnlROk+AA8/1UEBTGrS7
         ofngUcWioTzBVB+g4Y6KtF1+iRU1MIB6aDj8m8MHfKBuJCH6EhQCTeS1HKVzKC1Z+bDy
         jaSxnUcWM/HNKXzw5b2xrwDGpnzx/k+F7el6AtFEvP70fqv4UvrT3p/QUWo2GaTr8LwL
         BpW0EjZLP0kKNiuI8XouzMT4+4sSgt3rDiUmhy+2bRhvz+/KLMLeXIaGiOT2K5E1Tkk9
         xL1w==
X-Gm-Message-State: AOAM5317H3XGGcMPpjPQ4KzZTgPhaoLewie9sFmjabLbOuungQSAIuxV
        hYpFzJFABOUgZVIz7kPsPDPc2NSgc6jtSQaV2yI=
X-Google-Smtp-Source: ABdhPJzkrs5gKJjCgGvS4n4G9ht49JRTpAbNNmjyY5M7srxT8Kg/bD5ZxXNomZJvU4LKP2s2zOsVsiIjg8TZcdcN4FU=
X-Received: by 2002:a92:cd8c:: with SMTP id r12mr9091476ilb.221.1611172657270;
 Wed, 20 Jan 2021 11:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20210120133946.2107897-1-jackmanb@google.com> <20210120133946.2107897-3-jackmanb@google.com>
In-Reply-To: <20210120133946.2107897-3-jackmanb@google.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 20 Jan 2021 20:57:28 +0100
Message-ID: <CAKXUXMxw4JP4q-iGTMsnS2j4KYfU7WDRTLbAdWu4DrvCa=R+NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] docs: bpf: Clarify -mcpu=v3 requirement
 for atomic ops
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 20, 2021 at 2:39 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> Alexei pointed out [1] that this wording is pretty confusing. Here's
> an attempt to be more explicit and clear.
>
> [1] https://lore.kernel.org/bpf/CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com/T/#m07264fc18fdc43af02fc1320968afefcc73d96f4
>

It is common practice to use "Link: URL" to refer to other mail
threads; and to use the "permalink":

https://lore.kernel.org/bpf/CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com/

which is a bit shorter than the link you provided.

If you follow that convention with "Link: URL", checkpatch.pl will not
complain about this long line :)


Lukas

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/networking/filter.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> index 4c2bb4c6364d..b3f457802836 100644
> --- a/Documentation/networking/filter.rst
> +++ b/Documentation/networking/filter.rst
> @@ -1081,9 +1081,10 @@ before is loaded back to ``R0``.
>
>  Note that 1 and 2 byte atomic operations are not supported.
>
> -Except ``BPF_ADD`` *without* ``BPF_FETCH`` (for legacy reasons), all 4 byte
> -atomic operations require alu32 mode. Clang enables this mode by default in
> -architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
> +Clang can generate atomic instructions by default when ``-mcpu=v3`` is
> +enabled. If a lower version for ``-mcpu`` is set, the only atomic instruction
> +Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to enable
> +the atomics features, while keeping a lower ``-mcpu`` version, you can use
>  ``-Xclang -target-feature -Xclang +alu32``.
>
>  You may encounter ``BPF_XADD`` - this is a legacy name for ``BPF_ATOMIC``,
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
