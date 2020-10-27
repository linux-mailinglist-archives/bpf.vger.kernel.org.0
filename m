Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2329A8B8
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 11:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896052AbgJ0Jwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 05:52:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44673 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409641AbgJ0Jwv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 05:52:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id k27so652954oij.11;
        Tue, 27 Oct 2020 02:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4k15uLlQPDyibib9c7Zvh6tW8H4LI+JfDQ0J2WXNZIA=;
        b=BBMZlwMKMJkpNdRA8EKcd0GPztw/WrRCoPddZTk8RlrfDyCOTE9vN3eahJ53uIvydJ
         isBdqKSVeEDUZLuTMeD7AxxjWtUHlufyZhzSZ8QBC7TrplYpO2xkZvrVyeSx+7CXJ0dF
         aF0V/jxAr/jiRc+3oifutExZM8FfZQ+6wWVznTAeyM57M8Ic8a6N3Pgb4BQQWy8Hw+l2
         Z2LQXE/6LXJaEDdAR+P/Gdmn10Iv88yOu6pa7kUkdl2ftzJJG86So85lmZ5mR715TTew
         vjn0bfz1cTLTBYlFwDOoKzyyCgfTemb2U4m79bB3flh5INW24/sTUUgJEZwj5GkpRwn1
         macw==
X-Gm-Message-State: AOAM530hG5i6VoZeYl9BsJx5N3SfXn+2R+96A2EHFIy/WBXEv5eqHHKu
        zbd0VXjGdiTCQmnTOCi3EPpu0omvD7Nc8H23oRwKui47u8y4cg==
X-Google-Smtp-Source: ABdhPJy1dLvdgv16AoCtLqymByBSY+KWH3iutF2PlZlpY9aTJDLry4PFiC4VtXAbn52n7pE6xNSdtr52Vl0GaJY40Gk=
X-Received: by 2002:aca:f40c:: with SMTP id s12mr785596oih.153.1603792370966;
 Tue, 27 Oct 2020 02:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
In-Reply-To: <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 10:52:39 +0100
Message-ID: <CAMuHMdXTLKr6pvoE+JAdn_P5kVxL6gx8PJ8mqfXcS+SF+pRbkQ@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 1/6] seccomp: Move config option SECCOMP to arch/Kconfig
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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

Hi Yifei,

On Thu, Sep 24, 2020 at 2:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> In order to make adding configurable features into seccomp
> easier, it's better to have the options at one single location,
> considering easpecially that the bulk of seccomp code is
> arch-independent. An quick look also show that many SECCOMP
> descriptions are outdated; they talk about /proc rather than
> prctl.
>
> As a result of moving the config option and keeping it default
> on, architectures arm, arm64, csky, riscv, sh, and xtensa
> did not have SECCOMP on by default prior to this and SECCOMP will
> be default in this change.
>
> Architectures microblaze, mips, powerpc, s390, sh, and sparc
> have an outdated depend on PROC_FS and this dependency is removed
> in this change.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

Thanks for your patch. which is now commit 282a181b1a0d66de ("seccomp:
Move config option SECCOMP to arch/Kconfig") in v5.10-rc1.

> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -458,6 +462,23 @@ config HAVE_ARCH_SECCOMP_FILTER
>             results in the system call being skipped immediately.
>           - seccomp syscall wired up
>
> +config SECCOMP
> +       def_bool y
> +       depends on HAVE_ARCH_SECCOMP
> +       prompt "Enable seccomp to safely compute untrusted bytecode"
> +       help
> +         This kernel feature is useful for number crunching applications
> +         that may need to compute untrusted bytecode during their
> +         execution. By using pipes or other transports made available to
> +         the process as file descriptors supporting the read/write
> +         syscalls, it's possible to isolate those applications in
> +         their own address space using seccomp. Once seccomp is
> +         enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
> +         and the task is only allowed to execute a few safe syscalls
> +         defined by each seccomp mode.
> +
> +         If unsure, say Y. Only embedded should say N here.
> +

Please tell me why SECCOMP is special, and deserves to default to be
enabled.  Is it really that critical, given only 13.5 (half of sparc
;-) out of 24
architectures implement support for it?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
