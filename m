Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03992276508
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 02:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIXAZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 20:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgIXAZb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 20:25:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59790C0613D2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 17:25:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so2020938ejb.8
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 17:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z36kKBCsQHaNPCeH2E/H9tB3p5RdrZUDg9hhwZ3Nxx4=;
        b=cbX2fdSuIUKZiYq81JUboXArhe0hzzMQKHDvzeE7J6nPvEp8uAfCWtiVvkPW+XoRqf
         SNmPSYUj8Mpf3ntteDZJ0BanpOlimPgmPK5k08S1L+NTDs61EtOmrdTemzlWhloBfw6h
         hKLpi61bNpByUX8xegnen+FIfES+zFOI5Jgc8ssG7qTKjF/Wpu+CsolNmc1A1GzdxMsW
         NkjdaMnu37uiBq+cQSIdZi0TXBDDkqRhIpx11URvPwfi8G5hVCXLICWEaTH5P15N5kMO
         CFX1LqExw0W6wTTa9LYSuBv3hcYXouQwkUxbrf+gi3nYE4HwGGLnZmq/5/jBYASMI8q5
         9ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z36kKBCsQHaNPCeH2E/H9tB3p5RdrZUDg9hhwZ3Nxx4=;
        b=eFBuIecMuezg6JWjwserOzw1BgPtFYLIk7pRLZcZk1YwqmT62GzlmQvwZCg+RiXTdq
         VDhzz/whok4QuU9p4pntN1A4W9KBSQHR3/SJhOrQODHRDQpyqkrj9m28Ar1KQCWJVkpt
         zhiFsw/SnXx3JY5OQIyR/ERKWm+EiH4BRmJCdNijwniDmqsP5m3VW6iGQmpkR7MsQNAs
         S0DmDyGKoLX0VJfNA1eS9XndS+IHwQqPUuoQ9Y2R6Yio+V8p2yx03kAxqdiUwsrUvRaF
         Sj62r3syP+5aonbgQgiksY//Zgk5xJ8zEb+QAP69t4I+dZ+ahl5r716w1FBQZrbg09b6
         +9SQ==
X-Gm-Message-State: AOAM533ztO8gXRfPxJgq65POQ8JlJcyP5n1KDbnQ2V7Z4sl0gGNWFaxc
        SPz9jH4+zAbglK52YACejQpF0FO3YM/jthUl3AkKDQ==
X-Google-Smtp-Source: ABdhPJx4IA2iHrYE9+q5i2RC4hqX4ARo0Up8yxJYRnnkUT5XwQl8IaZ/DeyUn7wb1rDN5L75+fZh2NkwrKTz3Yzkc0Q=
X-Received: by 2002:a17:906:1f94:: with SMTP id t20mr2089748ejr.493.1600907129579;
 Wed, 23 Sep 2020 17:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org> <20200923232923.3142503-4-keescook@chromium.org>
In-Reply-To: <20200923232923.3142503-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Sep 2020 02:25:03 +0200
Message-ID: <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
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
> One of the most common pain points with seccomp filters has been dealing
> with the overhead of processing the filters, especially for "always allow"
> or "always reject" cases.

The "always reject" cases don't need to be fast, in particular not the
kill_thread/kill_process ones. Nobody's going to have "process kills
itself by executing a forbidden syscall" on a critical hot codepath.

> While BPF is extremely fast[1], it will always
> have overhead associated with it. Additionally, due to seccomp's design,
> filters are layered, which means processing time goes up as the number
> of filters attached goes up.
[...]
> In order to build this mapping at filter attach time, each filter is
> executed for every syscall (under each possible architecture), and
> checked for any accesses of struct seccomp_data that are not the "arch"
> nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
> there is a constant mapping for that syscall, and bitmaps can be updated
> accordingly. If any accesses happen outside of those struct members,
> seccomp must not bypass filter execution for that syscall, since program
> state will be used to determine filter action result. (This logic comes
> in the next patch.)
>
> [1] https://lore.kernel.org/bpf/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com/
> [2] https://lore.kernel.org/bpf/20200601101137.GA121847@gardel-login/
> [3] https://lore.kernel.org/bpf/717a06e7f35740ccb4c70470ec70fb2f@huawei.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/seccomp.h |  18 ++++
>  kernel/seccomp.c        | 207 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 221 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 0be20bc81ea9..96df2f899e3d 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -25,6 +25,17 @@
>  #define SECCOMP_ARCH_IS_MULTIPLEX      3
>  #define SECCOMP_ARCH_IS_UNKNOWN                0xff
>
> +/* When no bits are set for a syscall, filters are run. */
> +struct seccomp_bitmaps {
> +#ifdef SECCOMP_ARCH
> +       /* "allow" are initialized to set and only ever get cleared. */
> +       DECLARE_BITMAP(allow, NR_syscalls);

This bitmap makes sense.

The "NR_syscalls" part assumes that the compat syscall tables will not
be bigger than the native syscall table, right? I guess that's usually
mostly true nowadays, thanks to the syscall table unification...
(might be worth a comment though)

> +       /* These are initialized to clear and only ever get set. */
> +       DECLARE_BITMAP(kill_thread, NR_syscalls);
> +       DECLARE_BITMAP(kill_process, NR_syscalls);

I don't think these bitmaps make sense, this is not part of any fastpath.

(However, a "which syscalls have a fixed result" bitmap might make
sense if we want to export the list of permitted syscalls as a text
file in procfs, as I mentioned over at
<https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/>.)

> +#endif
> +};
> +
>  struct seccomp_filter;
>  /**
>   * struct seccomp - the state of a seccomp'ed process
> @@ -45,6 +56,13 @@ struct seccomp {
>  #endif
>         atomic_t filter_count;
>         struct seccomp_filter *filter;
> +       struct seccomp_bitmaps native;
> +#ifdef CONFIG_COMPAT
> +       struct seccomp_bitmaps compat;
> +#endif
> +#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
> +       struct seccomp_bitmaps multiplex;
> +#endif

Why do we have one bitmap per thread (in struct seccomp) instead of
putting the bitmap for a given filter and all its ancestors into the
seccomp_filter?

>  };
>
>  #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 0a3ff8eb8aea..111a238bc532 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -318,7 +318,7 @@ static inline u8 seccomp_get_arch(u32 syscall_arch, u32 syscall_nr)
>
>  #ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
>         if (syscall_arch == SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH) {
> -               seccomp_arch |= (sd->nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
> +               seccomp_arch |= (syscall_nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
>                                 SECCOMP_MULTIPLEXED_SYSCALL_TABLE_SHIFT;

This belongs over into patch 1.

>         }
>  #endif
> @@ -559,6 +559,21 @@ static inline void seccomp_sync_threads(unsigned long flags)
>                 atomic_set(&thread->seccomp.filter_count,
>                            atomic_read(&thread->seccomp.filter_count));
>
> +               /* Copy syscall filter bitmaps. */
> +               memcpy(&thread->seccomp.native,
> +                      &caller->seccomp.native,
> +                      sizeof(caller->seccomp.native));
> +#ifdef CONFIG_COMPAT
> +               memcpy(&thread->seccomp.compat,
> +                      &caller->seccomp.compat,
> +                      sizeof(caller->seccomp.compat));
> +#endif
> +#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
> +               memcpy(&thread->seccomp.multiplex,
> +                      &caller->seccomp.multiplex,
> +                      sizeof(caller->seccomp.multiplex));
> +#endif

This part wouldn't be necessary if the bitmasks were part of the
seccomp_filter...

>                 /*
>                  * Don't let an unprivileged task work around
>                  * the no_new_privs restriction by creating
> @@ -661,6 +676,114 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>         return filter;
>  }
>
> +static inline bool sd_touched(pte_t *ptep)
> +{
> +       return !!pte_young(*(READ_ONCE(ptep)));
> +}

I think this is left over from the previous version and should've been removed?

[...]
> +/*
> + * Walk everyone syscall combination for this arch/mask combo and update

nit: "Walk every possible", or something like that

> + * the bitmaps with any results.
> + */
> +static void seccomp_update_bitmap(struct seccomp_filter *filter,
> +                                 void *pagepair, u32 arch, u32 mask,
> +                                 struct seccomp_bitmaps *bitmaps)
[...]
> @@ -970,6 +1097,65 @@ static int seccomp_do_user_notification(int this_syscall,
>         return -1;
>  }
>
> +#ifdef SECCOMP_ARCH
> +static inline bool __bypass_filter(struct seccomp_bitmaps *bitmaps,
> +                                  u32 nr, u32 *filter_ret)
> +{
> +       if (nr < NR_syscalls) {
> +               if (test_bit(nr, bitmaps->allow)) {
> +                       *filter_ret = SECCOMP_RET_ALLOW;
> +                       return true;
> +               }
> +               if (test_bit(nr, bitmaps->kill_process)) {
> +                       *filter_ret = SECCOMP_RET_KILL_PROCESS;
> +                       return true;
> +               }
> +               if (test_bit(nr, bitmaps->kill_thread)) {
> +                       *filter_ret = SECCOMP_RET_KILL_THREAD;
> +                       return true;
> +               }

The checks against ->kill_process and ->kill_thread won't make
anything faster, but since they will run in the fastpath, they'll
probably actually contribute to making things *slower*.

> +       }
> +       return false;
> +}
> +
> +static inline u32 check_syscall(const struct seccomp_data *sd,
> +                               struct seccomp_filter **match)
> +{
> +       u32 filter_ret = SECCOMP_RET_KILL_PROCESS;
> +       u8 arch = seccomp_get_arch(sd->arch, sd->nr);
> +
> +       switch (arch) {
> +       case SECCOMP_ARCH_IS_NATIVE:
> +               if (__bypass_filter(&current->seccomp.native, sd->nr, &filter_ret))
> +                       return filter_ret;
> +               break;
> +#ifdef CONFIG_COMPAT
> +       case SECCOMP_ARCH_IS_COMPAT:
> +               if (__bypass_filter(&current->seccomp.compat, sd->nr, &filter_ret))
> +                       return filter_ret;
> +               break;
> +#endif
> +#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
> +       case SECCOMP_ARCH_IS_MULTIPLEX:
> +               if (__bypass_filter(&current->seccomp.multiplex, sd->nr, &filter_ret))
> +                       return filter_ret;
> +               break;
> +#endif
> +       default:
> +               WARN_ON_ONCE(1);
> +               return filter_ret;
> +       };
> +
> +       return seccomp_run_filters(sd, match);
> +}

You could write this in a less repetitive way, and especially if we
get rid of the kill_* masks, also more compact:

static inline u32 check_syscall(const struct seccomp_data *sd,
        struct seccomp_filter **match)
{
  struct seccomp_bitmaps *bitmaps;
  u32 filter_ret;

  switch (arch) {
  case SECCOMP_ARCH_IS_NATIVE:
    bitmaps = &current->seccomp.native;
    break;
#ifdef CONFIG_COMPAT
  case SECCOMP_ARCH_IS_COMPAT:
    bitmaps = &current->seccomp.compat;
    break;
#endif
#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
  case SECCOMP_ARCH_IS_MULTIPLEX:
    bitmaps = &current->seccomp.multiplex;
    break;
#endif
  default:
    WARN_ON_ONCE(1);
    return SECCOMP_RET_KILL_PROCESS;
  }

  if ((unsigned)sd->nr < __NR_syscalls && test_bit(sd->nr, bitmaps->allow))
    return SECCOMP_RET_ALLOW;

  return seccomp_run_filters(sd, match);
}

[...]
> @@ -1625,12 +1812,24 @@ static long seccomp_set_mode_filter(unsigned int flags,
>             mutex_lock_killable(&current->signal->cred_guard_mutex))
>                 goto out_put_fd;
>
> +       /*
> +        * This memory will be needed for bitmap testing, but we'll
> +        * be holding a spinlock at that point. Do the allocation
> +        * (and free) outside of the lock.
> +        *
> +        * Alternative: we could do the bitmap update before attach
> +        * to avoid spending too much time under lock.
> +        */
> +       pagepair = vzalloc(PAGE_SIZE * 2);
> +       if (!pagepair)
> +               goto out_put_fd;
> +
[...]
> -       ret = seccomp_attach_filter(flags, prepared);
> +       ret = seccomp_attach_filter(flags, prepared, pagepair);

You probably intended to rip this stuff back out? AFAIU the vzalloc()
stuff is a remnant from the old version that relied on MMU trickery.
