Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FC027654D
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 02:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgIXAmF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 20:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgIXAmF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 20:42:05 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8DC0613D2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 17:42:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so1660696edk.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALS2hDm4ftsEUNq9TXFt06kpNHf/ZcV3y5aWx3s1Do8=;
        b=i+nBcw6Qc5YdCSP79kchMxNZ9vscFmuRHIjL+4oM9aaVNrPeQ2J1fRTklh0kqsjyI1
         N8NLB4IWr+D48TgWyYvZVuR18wkLSPfX8ovenzBJ4SrpdBaZGCKeG/X9PqlHe/AREy+G
         qo3TDDWtf6fkUtjt6XhYF7btCK2MTxIo9/4DEX+39YzOETzUS7wn6qaEXW02Fy7Nv7Sy
         iAhA3DJm5GB6uJspOdBYPqpCrSqmLiQJtt9QHxklrgcQ+yeDdyLYxkIwNF+ZXqK0GpPm
         VMI2uHMtk9t1HcUse8hr8ZqCv8PfIWNolN5O2CBcz/jLPmHK2IpxgDyi/+YWAMhYYGp8
         Br8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALS2hDm4ftsEUNq9TXFt06kpNHf/ZcV3y5aWx3s1Do8=;
        b=JXdvXU7inIY7D0Q4HNLOSMBkBK1ADTRjcFE9njr3LA4CyMxoXNKH5lRdbFoV8FQF5M
         o9DivhIuy7grv9dlDYdt744uV8dJ23fZ49c3+UDy0L4LXrrhW12xWGGYbaI0Gs+22V8O
         2pA49xFqQIe2H9ok4JN/lO3MId9Ev44OdWIyiYpnWYzY4ygfvn8BI3dybbZj326igEjY
         K6iVloj9fJpqk73RQ33eC5UUNPoy34PZK4oYYuGNnJ4+Ett53MgucO5VwUBivxmiaG3X
         mX0r6Qqyge+XjmNZ/9nhxW2Cx9UTBSHXeF/SRiwuS4CObkf6maBbYQFrtzNiuwv/7dvs
         7omw==
X-Gm-Message-State: AOAM532Wm4seegCdHewl+4HHpONCN0UGOWvhWfizVj6AmrXDwM5/QTZI
        1iV3vIuC7XAp7Eld67amvbJDYGVHVliXvrNyrXwLxg==
X-Google-Smtp-Source: ABdhPJyJ+2+MBiUxJyKzlnkil/1tpGNHZFlDrmkJ5755EYgjTjHJLwH+rSfDuJCXfwgvffq+bBDZCtFfWoiMAlyJwQo=
X-Received: by 2002:a50:e807:: with SMTP id e7mr2071571edn.84.1600908123101;
 Wed, 23 Sep 2020 17:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org> <20200923232923.3142503-2-keescook@chromium.org>
In-Reply-To: <20200923232923.3142503-2-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 02:41:36 +0200
Message-ID: <CAG48ez17XK2Co+1LbUWTc4x_W7nza=TObNh2Kpz6P+ba3OKPsw@mail.gmail.com>
Subject: Re: [PATCH 1/6] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> For systems that provide multiple syscall maps based on audit
> architectures (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via
> CONFIG_COMPAT) or via syscall masks (e.g. x86_x32), allow a fast way
> to pin the process to a specific syscall table, instead of needing
> to generate all filters with an architecture check as the first filter
> action.
>
> This creates the internal representation that seccomp itself can use
> (which is separate from the filters, which need to stay runtime
> agnostic). Additionally paves the way for constant-action bitmaps.

I don't really see the point in providing this UAPI - the syscall
number checking will probably have much more performance cost than the
architecture number check, and it's not like this lets us avoid the
check, we're just moving it over into C code.

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/seccomp.h                       |  9 +++
>  include/uapi/linux/seccomp.h                  |  1 +
>  kernel/seccomp.c                              | 79 ++++++++++++++++++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 33 ++++++++
>  4 files changed, 120 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 02aef2844c38..0be20bc81ea9 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -20,12 +20,18 @@
>  #include <linux/atomic.h>
>  #include <asm/seccomp.h>
>
> +#define SECCOMP_ARCH_IS_NATIVE         1
> +#define SECCOMP_ARCH_IS_COMPAT         2

FYI, mips has three different possible "arch" values (per kernel build
config; the __AUDIT_ARCH_LE flag can also be set, but that's fixed
based on the config):

 - AUDIT_ARCH_MIPS
 - AUDIT_ARCH_MIPS | __AUDIT_ARCH_64BIT
 - AUDIT_ARCH_MIPS | __AUDIT_ARCH_64BIT | __AUDIT_ARCH_CONVENTION_MIPS64_N32

But I guess we can deal with that once someone wants to actually add
support for this on mips.

> +#define SECCOMP_ARCH_IS_MULTIPLEX      3

Why should X32 be handled specially? If the seccomp filter allows
specific syscalls (as it should), we don't have to care about X32.
Only in weird cases where the seccomp filter wants to deny specific
syscalls (a horrible idea), X32 is a concern, and in such cases, the
userspace code can generate a single conditional jump to deal with it.

And when seccomp is used properly to allow specific syscalls, the
kernel will just waste time uselessly checking this X32 stuff.

[...]
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
[...]
> +static long seccomp_pin_architecture(void)
> +{
> +#ifdef SECCOMP_ARCH
> +       struct task_struct *task = current;
> +
> +       u8 arch = seccomp_get_arch(syscall_get_arch(task),
> +                                  syscall_get_nr(task, task_pt_regs(task)));
> +
> +       /* How did you even get here? */

Via a racing TSYNC, that's how.

> +       if (task->seccomp.arch && task->seccomp.arch != arch)
> +               return -EBUSY;
> +
> +       task->seccomp.arch = arch;
> +#endif
> +       return 0;
> +}

Why does this return 0 if SECCOMP_ARCH is not defined? That suggests
to userspace that we have successfully pinned the ABI, even though
we're actually unable to do so.
