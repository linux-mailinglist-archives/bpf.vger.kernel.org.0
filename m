Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8D2DD127
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLQMPB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 17 Dec 2020 07:15:01 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39774 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQMPA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 07:15:00 -0500
Received: by mail-ot1-f44.google.com with SMTP id d8so27023166otq.6;
        Thu, 17 Dec 2020 04:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+ZQ9Hep/ihbUcAAKgQBrtb6DKWZjd1MMpk6GQGQBFo=;
        b=TwUE/sAaDxSik4eC4+AwHfhs259wcfDFaqZ9iAEraBl2QkccsjfTrFTz3utu1eAtxe
         Z0QtTCQVWqfSQV4KSrzJPi3sYXIZQ9iOrgZKZ+4n3He0ShWxke3P6LN05fBagccHvcBQ
         r2OUQ1tdC6f7OivbGm+kTXTRufY4ouXz4j/wneC71NeHmY2l4RXdmwhBLZjDHYSyYSIJ
         KcssnimozOGMCMvU7FRpDf4gYdPodv3BTeIBgKghLNwiDoYMCBCOnsYrG1JwmlqtcgVa
         YAk3Kar9SihjT7kmv3ntqhFSkAFfWk7FHKnANOJksbpUek993z5QavpMwDRPwQRTZOGc
         u+HQ==
X-Gm-Message-State: AOAM532KaE/4c9ToIExUavd/+ExtHVxSGbk8aB2uXujvKXjrpdm1hZBy
        sBBSuvmzsVjHsIp7TS5jL27+xagesoMkuAJFzJzSSEJ3c/A=
X-Google-Smtp-Source: ABdhPJz59bsLl40yU/AMrbYd1pTjEH6DKHmAPNcgiQuY6xiSJuPFg3psehvXyIwiQfTmcEKRkCfg14X04prnuLoQcg4=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr29145891otc.145.1608207259025;
 Thu, 17 Dec 2020 04:14:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <4706b0ff81f28b498c9012fd3517fe88319e7c42.1602431034.git.yifeifz2@illinois.edu>
In-Reply-To: <4706b0ff81f28b498c9012fd3517fe88319e7c42.1602431034.git.yifeifz2@illinois.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Dec 2020 13:14:07 +0100
Message-ID: <CAMuHMdVU1BhmwMiHKDYmnyRHtQfeMtwtwkFLQwinfBPto-rtOQ@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yifei,

On Sun, Oct 11, 2020 at 8:08 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> Currently the kernel does not provide an infrastructure to translate
> architecture numbers to a human-readable name. Translating syscall
> numbers to syscall names is possible through FTRACE_SYSCALL
> infrastructure but it does not provide support for compat syscalls.
>
> This will create a file for each PID as /proc/pid/seccomp_cache.
> The file will be empty when no seccomp filters are loaded, or be
> in the format of:
> <arch name> <decimal syscall number> <ALLOW | FILTER>
> where ALLOW means the cache is guaranteed to allow the syscall,
> and filter means the cache will pass the syscall to the BPF filter.
>
> For the docker default profile on x86_64 it looks like:
> x86_64 0 ALLOW
> x86_64 1 ALLOW
> x86_64 2 ALLOW
> x86_64 3 ALLOW
> [...]
> x86_64 132 ALLOW
> x86_64 133 ALLOW
> x86_64 134 FILTER
> x86_64 135 FILTER
> x86_64 136 FILTER
> x86_64 137 ALLOW
> x86_64 138 ALLOW
> x86_64 139 FILTER
> x86_64 140 ALLOW
> x86_64 141 ALLOW
> [...]
>
> This file is guarded by CONFIG_SECCOMP_CACHE_DEBUG with a default
> of N because I think certain users of seccomp might not want the
> application to know which syscalls are definitely usable. For
> the same reason, it is also guarded by CAP_SYS_ADMIN.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

> @@ -2311,3 +2314,59 @@ static int __init seccomp_sysctl_init(void)
>  device_initcall(seccomp_sysctl_init)
>
>  #endif /* CONFIG_SYSCTL */
> +
> +#ifdef CONFIG_SECCOMP_CACHE_DEBUG
> +/* Currently CONFIG_SECCOMP_CACHE_DEBUG implies SECCOMP_ARCH_NATIVE */

Should there be a dependency on SECCOMP_ARCH_NATIVE?
Should all architectures that implement seccomp have this?

E.g. mips does select HAVE_ARCH_SECCOMP_FILTER, but doesn't
have SECCOMP_ARCH_NATIVE?

(noticed with preliminary out-of-tree seccomp implementation for m68k,
 which doesn't have SECCOMP_ARCH_NATIVE

> +static void proc_pid_seccomp_cache_arch(struct seq_file *m, const char *name,
> +                                       const void *bitmap, size_t bitmap_size)
> +{
> +       int nr;
> +
> +       for (nr = 0; nr < bitmap_size; nr++) {
> +               bool cached = test_bit(nr, bitmap);
> +               char *status = cached ? "ALLOW" : "FILTER";
> +
> +               seq_printf(m, "%s %d %s\n", name, nr, status);
> +       }
> +}
> +
> +int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
> +                          struct pid *pid, struct task_struct *task)
> +{
> +       struct seccomp_filter *f;
> +       unsigned long flags;
> +
> +       /*
> +        * We don't want some sandboxed process to know what their seccomp
> +        * filters consist of.
> +        */
> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> +               return -EACCES;
> +
> +       if (!lock_task_sighand(task, &flags))
> +               return -ESRCH;
> +
> +       f = READ_ONCE(task->seccomp.filter);
> +       if (!f) {
> +               unlock_task_sighand(task, &flags);
> +               return 0;
> +       }
> +
> +       /* prevent filter from being freed while we are printing it */
> +       __get_seccomp_filter(f);
> +       unlock_task_sighand(task, &flags);
> +
> +       proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_NATIVE_NAME,
> +                                   f->cache.allow_native,

error: ‘struct action_cache’ has no member named ‘allow_native’

struct action_cache is empty if SECCOMP_ARCH_NATIVE is not
defined (so there are checks for it).

> +                                   SECCOMP_ARCH_NATIVE_NR);
> +
> +#ifdef SECCOMP_ARCH_COMPAT
> +       proc_pid_seccomp_cache_arch(m, SECCOMP_ARCH_COMPAT_NAME,
> +                                   f->cache.allow_compat,
> +                                   SECCOMP_ARCH_COMPAT_NR);
> +#endif /* SECCOMP_ARCH_COMPAT */
> +
> +       __put_seccomp_filter(f);
> +       return 0;
> +}
> +#endif /* CONFIG_SECCOMP_CACHE_DEBUG */
> --
> 2.28.0
>


-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
