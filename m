Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5DB817A
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2019 21:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392353AbfISThe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Sep 2019 15:37:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41814 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392355AbfISThe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Sep 2019 15:37:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id w17so3740173oiw.8
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2019 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2WRb88oKnAQnCwV6qMbloqtA0/uxdTgIFA2BEXO/b8=;
        b=hlvcYUkMXTARwnNUtE0WGKuXfVgTodWHpwcYZicRoUCIi9QbGC5JsDfNQZ4gvxKcT/
         CGMmJ6sx12a5ZJdq6bpPkSeLUvQ5RYPJGTiZZMQadiVCSiq1lLaVHuIFsoUHdZuz7sll
         GDK07RqGbBI4Oj2H8jdnBH0c6GKOidGwjGt8/hc/PzKDJlV/zVJjuMMhJj2JjcwnW3Rn
         ldHRCEeGGDEWC4UQ2GMhsRqeKfrr8NJ2UvMgLHgdsal96mj6SBRbMkddm0uNgBRRHK1u
         IzUHE+TPYIhZ/uoD2KuZunl/JpnYSqdNfk1nluCur7PMbYfqcepX6lENPIuRO8g1y2+5
         UWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2WRb88oKnAQnCwV6qMbloqtA0/uxdTgIFA2BEXO/b8=;
        b=pgzaQCYPbram0trC9f8aocPvN1XFrzQ5jLCGYr71cpCjVyp0CoW3kPorW3pjU5R/I2
         ebkb5oK5nfTx0p16/SOeHp+srt1l5/3T3OEd8zpKAJz9i2sbsrg1sD6sKC9Ksxl7SKh2
         NghnrxDDEPauI2VtZWivOqpSSfNVe2lz0EXqn6U3udLbjk6ZDUM/4Kq9H4rhW8RtEQji
         F7ogQ3uZ/oVCnkq5TNrTsUzD7l8UMYZdRN6fVf4Om1+lYhf1/KRnaiu5LDSbLQi3Kc0F
         cvu9ziFrba7gzDWW+g0EPtpqU79jGWt/W07Cj7zqVsQ8L7m+Qu1dkUTilHjNmXuE0qYq
         drMA==
X-Gm-Message-State: APjAAAVl1zcWFYdphY1L9HpBhZMIcDoFfQaVAwBzap12TbvC2xOCDpPC
        XUJf+1qaqz/d+HtDg7FzeAAVHrZxkzWDOoM/mz01Cw==
X-Google-Smtp-Source: APXvYqwjrdh9lXpuBqRhfnH/q8f/TDJskWYrW/HZD6RipzJl9Yt1bLU+UMWBsAqC15hCJfUrBoHFXCqKGsDQYbE0U5E=
X-Received: by 2002:aca:ed52:: with SMTP id l79mr3551222oih.47.1568921853200;
 Thu, 19 Sep 2019 12:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190919095903.19370-1-christian.brauner@ubuntu.com> <20190919095903.19370-2-christian.brauner@ubuntu.com>
In-Reply-To: <20190919095903.19370-2-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 19 Sep 2019 21:37:06 +0200
Message-ID: <CAG48ez1QkJAMgTpqv4EqbDmYPPpxuB8cR=XhUAr1fHZOBY_DHg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] seccomp: add SECCOMP_USER_NOTIF_FLAG_CONTINUE
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, yhs@fb.com,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Tyler Hicks <tyhicks@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 19, 2019 at 11:59 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> This allows the seccomp notifier to continue a syscall.
[...]
> Recently we landed seccomp support for SECCOMP_RET_USER_NOTIF (cf. [4])
> which enables a process (watchee) to retrieve an fd for its seccomp
> filter. This fd can then be handed to another (usually more privileged)
> process (watcher). The watcher will then be able to receive seccomp
> messages about the syscalls having been performed by the watchee.
[...]
> This can be solved by
> telling seccomp to resume the syscall.
[...]
> @@ -780,8 +783,14 @@ static void seccomp_do_user_notification(int this_syscall,
>                 list_del(&n.list);
>  out:
>         mutex_unlock(&match->notify_lock);
> +
> +       /* Userspace requests to continue the syscall. */
> +       if (flags & SECCOMP_USER_NOTIF_FLAG_CONTINUE)
> +               return 0;
> +
>         syscall_set_return_value(current, task_pt_regs(current),
>                                  err, ret);
> +       return -1;
>  }

Seccomp currently expects the various seccomp return values to be
fully ordered based on how much action the kernel should take against
the requested syscall. Currently, the range of return values is
basically divided into three regions: "block syscall in some way"
(from SECCOMP_RET_KILL_PROCESS to SECCOMP_RET_USER_NOTIF), "let ptrace
decide" (SECCOMP_RET_TRACE) and "allow" (SECCOMP_RET_LOG and
SECCOMP_RET_ALLOW). If SECCOMP_RET_USER_NOTIF becomes able to allow
syscalls, it will be able to override a negative decision from
SECCOMP_RET_TRACE.

In practice, that's probably not a big deal, since I'm not aware of
anyone actually using SECCOMP_RET_TRACE for security purposes, and on
top of that, you'd have to allow ioctl(..., SECCOMP_IOCTL_NOTIF_SEND,
...) and seccomp() with SECCOMP_FILTER_FLAG_NEW_LISTENER in your
seccomp policy for this to work.

More interestingly, what about the case where two
SECCOMP_RET_USER_NOTIF filters are installed? The most recently
installed filter takes precedence if the return values's action parts
are the same (and this is also documented in the manpage); so if a
container engine installs a filter that always intercepts sys_foobar()
(and never uses SECCOMP_USER_NOTIF_FLAG_CONTINUE), and then something
inside the container also installs a filter that always intercepts
sys_foobar() (and always uses SECCOMP_USER_NOTIF_FLAG_CONTINUE), the
container engine's filter will become ineffective.

With my tendency to overcomplicate things, I'm thinking that maybe it
might be a good idea to:
 - collect a list of all filters that returned SECCOMP_RET_USER_NOTIF,
as well as the highest-precedence return value that was less strict
than SECCOMP_RET_USER_NOTIF
 - sequentially send notifications to all of the
SECCOMP_RET_USER_NOTIF filters until one doesn't return
SECCOMP_USER_NOTIF_FLAG_CONTINUE
 - if all returned SECCOMP_USER_NOTIF_FLAG_CONTINUE, go with the
highest-precedence return value that was less strict than
SECCOMP_RET_USER_NOTIF, or allow if no such return value was
encountered

But perhaps, for now, it would also be enough to just expand the big
fat warning note and tell people that if they allow the use of
SECCOMP_IOCTL_NOTIF_SEND and SECCOMP_FILTER_FLAG_NEW_LISTENER in their
filter, SECCOMP_RET_USER_NOTIF is bypassable. And if someone actually
has a usecase where SECCOMP_RET_USER_NOTIF should be secure and nested
SECCOMP_RET_USER_NOTIF support is needed, that more complicated logic
could be added later?
