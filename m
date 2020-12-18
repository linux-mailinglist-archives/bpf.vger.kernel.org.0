Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67B2DE2DA
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 13:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgLRMgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 07:36:15 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39399 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLRMgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 07:36:14 -0500
Received: by mail-ot1-f47.google.com with SMTP id d8so1741468otq.6;
        Fri, 18 Dec 2020 04:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DkNUPLV4pty/yUPNr3zH12sGf0mqEAZH7OQh5zf4K8=;
        b=Cbe+ZMZ7Hv+3wvSxKwbxHFHTesx6iENh9ELFCCka4qaJcI9pdnGy3EVVUH9z8Vy0A6
         ddD7tO4nd0Y82lp/7iIsvsmfdssW5nV20uAi451qsU8dYKqNGBKFLXIsOQjGsy+CEmVe
         qN9HeFOmF68Xdos0ZwrGEN3ZLCmBbudznEp3p695TUGXa3Hm3iVsRgNW0hxHbXpsXk1m
         G8imU/OD9pAMTU8bI7jUwaybX4HyhjyIWnCvR9pVUGalHCJoy9A3IZdaLfTSyjhnRGwa
         7iD9Z2rlPqOladaw0amBhuItZbeKxz/IgN8X9Cz4zEEIeERosFbeA0LmXvYo0Lzrws63
         lJgw==
X-Gm-Message-State: AOAM5308e1iUxAwzs92iJK7WPGM7vCF59dbeTw4qlz+0thm3mL3h9nck
        N2foC/Y1Ox9UwYozPfP/FNU7U1HFHLZpDBBGEKiiu/jD
X-Google-Smtp-Source: ABdhPJxfxl8yKvwDyX+PZdHV9q/oXdW8TwcExmFO7cyFXUgs7tlC+yddRm9fZPOke+BiKpjClwWCzDNXD7sWbAFO+/Y=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr2604996otc.145.1608294933980;
 Fri, 18 Dec 2020 04:35:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <4706b0ff81f28b498c9012fd3517fe88319e7c42.1602431034.git.yifeifz2@illinois.edu>
 <CAMuHMdVU1BhmwMiHKDYmnyRHtQfeMtwtwkFLQwinfBPto-rtOQ@mail.gmail.com> <CABqSeARw2tcxEPiU4peuURZybVsFo5K+OkAK0ojADUEENMoKuA@mail.gmail.com>
In-Reply-To: <CABqSeARw2tcxEPiU4peuURZybVsFo5K+OkAK0ojADUEENMoKuA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Dec 2020 13:35:21 +0100
Message-ID: <CAMuHMdVYLZ3t6yieKVG7fbn1+YMQN26jZnxQ1Jo38LiSm_Eh5A@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi YiFei,

On Thu, Dec 17, 2020 at 7:34 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> On Thu, Dec 17, 2020 at 6:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Should there be a dependency on SECCOMP_ARCH_NATIVE?
> > Should all architectures that implement seccomp have this?
> >
> > E.g. mips does select HAVE_ARCH_SECCOMP_FILTER, but doesn't
> > have SECCOMP_ARCH_NATIVE?
> >
> > (noticed with preliminary out-of-tree seccomp implementation for m68k,
> >  which doesn't have SECCOMP_ARCH_NATIVE
>
> You are correct. This specific patch in this series was not applied,
> and this was addressed in a follow up patch series [1]. MIPS does not
> define SECCOMP_ARCH_NATIVE because the bitmap expects syscall numbers
> to start from 0, whereas MIPS does not (defines
> CONFIG_HAVE_SPARSE_SYSCALL_NR). The follow up patch makes it so that
> any arch with HAVE_SPARSE_SYSCALL_NR (currently just MIPS) cannot have
> CONFIG_SECCOMP_CACHE_DEBUG on, by the depend on clause.
>
> I see that you are doing an out of tree seccomp implementation for
> m68k. Assuming unchanged arch/xtensa/include/asm/syscall.h, something
> like this to arch/m68k/include/asm/seccomp.h should make it work:
>
> #define SECCOMP_ARCH_NATIVE        AUDIT_ARCH_M68K
> #define SECCOMP_ARCH_NATIVE_NR        NR_syscalls
> #define SECCOMP_ARCH_NATIVE_NAME    "m68k"
>
> If the file does not exist already, arch/xtensa/include/asm/seccomp.h
> is a good example of how the file should look like, and remember to
> remove `generic-y += seccomp.h` from arch/m68k/include/asm/Kbuild.
>
> [1] https://lore.kernel.org/lkml/cover.1605101222.git.yifeifz2@illinois.edu/T/

Thank you for your extensive explanation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
