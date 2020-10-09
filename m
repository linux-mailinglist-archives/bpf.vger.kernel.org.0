Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E654F289B29
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 23:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbgJIVp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389116AbgJIVp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 17:45:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42577C0613D5
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 14:45:28 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lw21so15197299ejb.6
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3QASBM0PyBqWV4qYi2/juWl30Ro5T5ehsILkUh0Mms=;
        b=VeVHFmlydw44XMQ0jlUmjz9257sBoMcSb5kNBMm+/I8yNF1mq+Isl0FguqOpyiZKE/
         Y+aPx4AUvkVLLePrLlaTWIQ31nAAC9X4APGGLo3mVwcz+Vy9L7qQXJU9USVA/1alpFOc
         igtne+lu0FvEXxR4DTncx4DdoY4ADZqHTALlTUsbGyugfoOvGSc2sMtuIop4N0/FZhQQ
         esRZ6kzNRqnZ5zg27AN3U6lj8G19zmAlHXNVazZJ+AbThUZjti1lfTGrMftco6w+V00D
         yQ7y3Ce6BYhi1fynlsr0e4dzvttbb8ZD+yXjcskUQwKBwsX8dRJR8UY+UiO3wVY/Xywj
         xSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3QASBM0PyBqWV4qYi2/juWl30Ro5T5ehsILkUh0Mms=;
        b=tkr+oKcx07LEY0ZXYP+huoppwJrWWQAcoMQDXDVqPRF6A4roVYN2cGuv7nHDS7xyWT
         HvNFCo0L9/kvhhzOhIvcQH0iE/RHhbcUCjw4akv/ip94Wi9rRwCxwY7/bGO8yb6h1mDS
         JBIb/98AGAqGSi4+7i5yq3ieHGZRxleVZR6GSPhcgvBbbydyH0Uz1klaLbaCU2QJqhlQ
         fyPBkxIhhC6dOO4NF03TZNrFFVgLflpj9NzP75t+yptotCkFssTMZQz4GDEZQ2blA0Lp
         Yjmu9Ln31dQBXXG80mnN+x/szp4SAgQ9DMPUfHNIA5lylnKE4ec1ug8PsOzgCCUc4Tb+
         MsXA==
X-Gm-Message-State: AOAM532utI52FaA9In7uj+YM71FeBBEPr8FYXG0eULJue9dmU14gvewS
        NiAUmRlGfZ12FeLbFUDr8BOzvc8vPoJT70M1xRGBvw==
X-Google-Smtp-Source: ABdhPJztbhpbmafO850DZApEDfDuxUWnWBQzmSIKVH0rtmX0BAQpAcxDEIMOsnGY2/dfOkAseQk1kA6/YYaTTgip9Yc=
X-Received: by 2002:a17:906:394:: with SMTP id b20mr15967989eja.513.1602279926518;
 Fri, 09 Oct 2020 14:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
In-Reply-To: <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 9 Oct 2020 23:45:00 +0200
Message-ID: <CAG48ez1zQkoFMpFaxnL-xmzdkJZ+KN-CcEnyvB6ZpPCfwb4=bg@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
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

On Fri, Oct 9, 2020 at 7:15 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
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
[...]
> diff --git a/arch/Kconfig b/arch/Kconfig
[...]
> +config SECCOMP_CACHE_DEBUG
> +       bool "Show seccomp filter cache status in /proc/pid/seccomp_cache"
> +       depends on SECCOMP
> +       depends on SECCOMP_FILTER
> +       depends on PROC_FS
> +       help
> +         This is enables /proc/pid/seccomp_cache interface to monitor

nit: s/This is enables/This enables the/

> +         seccomp cache data. The file format is subject to change. Reading
> +         the file requires CAP_SYS_ADMIN.
> +
> +         This option is for debugging only. Enabling present the risk that

nit: *presents

> +         an adversary may be able to infer the seccomp filter logic.

[...]
> +int proc_pid_seccomp_cache(struct seq_file *m, struct pid_namespace *ns,
> +                          struct pid *pid, struct task_struct *task)
> +{
> +       struct seccomp_filter *f;
> +       unsigned long flags;
> +
> +       /*
> +        * We don't want some sandboxed process know what their seccomp

s/know/to know/

> +        * filters consist of.
> +        */
> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> +               return -EACCES;
> +
> +       if (!lock_task_sighand(task, &flags))
> +               return 0;

maybe return -ESRCH here so that userspace can distinguish between an
exiting process and a process with no filters?

> +       f = READ_ONCE(task->seccomp.filter);
> +       if (!f) {
> +               unlock_task_sighand(task, &flags);
> +               return 0;
> +       }
[...]
