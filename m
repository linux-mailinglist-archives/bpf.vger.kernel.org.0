Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E19207A73
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405595AbgFXRlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXRlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 13:41:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F5BC061573;
        Wed, 24 Jun 2020 10:41:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so2375789qtg.4;
        Wed, 24 Jun 2020 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziFtSjIhL98D47J75ud+A7uvotLYVp2aO/hT/zUWKj4=;
        b=YChNC0l74e+tZ9czZfB+hsmX3TiN8QgoBPbCOIyueSMoWm+2KnhFgs0uvzcSW7aXn4
         5NpUa+o/i2Y3vW+vjAR/ZokwP3rUF1gGfFbN6rD81XXkfWlgbYQj21ZR+zR/UIUooeqU
         frYMhV0FfDcmrFjX+JKpE3EzThDeWfl2NuPGPUJTtYt+7T4qxBLbXXIVWD4mZ0NL9dbs
         Dkv6GOLjEGEpVoCsm1Mq9XgCUcB40+vRXR9gv4J0I4oZOkuT3hQgZMlj9zVFtHOUjPRc
         QqDk0GgyrAyedONpohXxn9KeV8OFFza93BZlIcxzEQR8yYFOeu/S+zCrRyfAQLtbaL97
         CJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziFtSjIhL98D47J75ud+A7uvotLYVp2aO/hT/zUWKj4=;
        b=mscCv6TE0NPjKT0cnoKWmG9bWsB2YI4U6Xef4N3dwvZm7zptjZ5qmmTl3HnRTH+IAw
         QVa7B2j1+KYS/sKuVfyJhSvFtZB4mN1drkpQ3pu/JAxsAGt0l0T/wxT5nKLEpGXIz4Ib
         Huwrxx+4N69MRH9zrCmsRSdresyl0lRjA3r5i0IZBjkLW4RcxHzaLAm4OgF6KFTKJCJW
         w86tvQv0eUrGhl5czCqsDABhEhSSv/Z2HfcnTzrCFDI35XLQHzU0vRvqV9moZe/QuJiS
         X9IduZ+CdMChaQFzfqpWcHMT8LCuLKZWqTWThJm8pbX1PSEFBhH4gtybqLT/9MmMcnkC
         EIMA==
X-Gm-Message-State: AOAM532P0qWCkHjwd4KwD1TtB1fh0ncbRQmdq21nFtI3oiKk8CLBzw/l
        ApEgdl9FpJoFjN0ciGkDNIdql7DbHFM7+w0FA4Y=
X-Google-Smtp-Source: ABdhPJxumVi0c8Ib5CwkouZQi1sikvMQbf91/lBqnPsL52SsK4sh+CSo8/YiI9Q8I2WeOlUs4p0Ll6WBt0yGBHaVlZU=
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr27703901qtm.171.1593020481300;
 Wed, 24 Jun 2020 10:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
In-Reply-To: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Jun 2020 10:41:10 -0700
Message-ID: <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 24, 2020 at 4:07 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Hi,
>
> If pahole -J is used on an ELF that has BTF info from clang, it
> produces an invalid
> output. This is because pahole rewrites the .BTF section (which
> includes a new string
> table) but it doesn't touch .BTF.ext at all.

Why do you run `pahole -J` on BPF .o file? Clang already generates
.BTF (and .BTF.ext, of course) for you.

pahole -J is supposed to be used for vmlinux, not for clang-compiled
-target BPF object files.

>
> To demonstrate, on a recent check out of bpf-next:
>     $ cp connect4_prog.o connect4_pahole.o
>     $ pahole -J connect4_pahole.o
>     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
>     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> .BTF.ext=btf-ext.bin connect4_prog.o
>     $ sha1sum *.bin
>     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
>     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
>     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
>     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
>
> This problem crops up when compiling old kernels like 4.19 which have
> an extra pahole
> build step with clang-10.

I was under impression that clang generates .BTF and .BTF.ext only for
-target BPF. In this case, kernel is compiled for "real" target arch,
so there shouldn't be .BTF.ext in the first place? If that's not the
case, then I guess it's a bug in Clang.

>
> I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
>
> Best
> Lorenz
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
