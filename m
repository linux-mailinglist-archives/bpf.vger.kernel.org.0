Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4629E0F1
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 02:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgJ2Bna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 21:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgJ2Bn1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 21:43:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238E5C0613D2
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 18:43:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d24so1318524ljg.10
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geZ/oO3CDuXNyCg7XC5g4ztQiJhRJ6O3ZCqLsRDfncw=;
        b=sLyaw6q6IpMdxy0i+OrwQjeQfMFuDOZH3wZnxjQU/9rDKBm6tuuxuSZwVs5vSb5WCr
         dhr5wJNw0eYDPLOVlnAfChnG0rwQ3X3IxyOhhms90HJjdyXu5TJC0nW/joAq2f2CND/0
         CfiNH8M48AdnqYWCsLEkk41NY0rIcwZgm0kQcdKN0ApOcudxbm6lIQIC9aN3G5/6sTDd
         E0nFCedw0IDNiUhrY+kLYDTgjCvAEsr7GQTQqiccy0MVtif7ayBSqtuFcqw/pBfWXhhK
         7t/SE3CAxJQ50Fz1/BKEQTbMkwVW/T9PhUh0MdDok3/8p8gBv5Oh9gBVe4i4ApP4av2Y
         EmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geZ/oO3CDuXNyCg7XC5g4ztQiJhRJ6O3ZCqLsRDfncw=;
        b=kS82Ba592YL8KvDFqa3ZDmXvtHoyJT2GYZ6XJ1cPC/TciWABH546NuBgv2GVX7nbhU
         H6Q/sLN1UYpkFLsTCu2xtuOSaMuOvYr3xk2vbdyVgOmQNIahq2R65tj7VIuY4Ag/hlSp
         9tDlV4t3Up1kpxyys0PZmyU3OcatxgyQm5L0QyB5itEIP2eHq6GuM3bDLURhUgKokuAk
         yXwJCCvZ2Q7exBBFLj0MZ22Dc08luEhoSNuVgN5Szg11se0+IgXaIqqFS1cGMv7NmIgp
         9UQH5paX/gT3/IUDYijI2c88qNlZ4XGoTFqJOODahKP6GuTj97vlJ8LJP+moQpifIzX+
         rWEA==
X-Gm-Message-State: AOAM531SjPV+bp4mbi4u1Px0mHPeJ1soml4oaaIOXM4bCLPelTlrxyR0
        CPUkQnfWX+/9g8bL73pDod0j078FnAf5V63zOYQ3aQ==
X-Google-Smtp-Source: ABdhPJz6TDKuIczDEuNWhwAZLwIsi7p/r5pwANkEoLv02bXcTUl1ox9pp4nTanH9lSHFwu+RpElyT1qPIgjQUosCQDo=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr744683ljo.74.1603935804881;
 Wed, 28 Oct 2020 18:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
In-Reply-To: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:42:58 +0100
Message-ID: <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 10:55 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>        static bool
>        getTargetPathname(struct seccomp_notif *req, int notifyFd,
>                          char *path, size_t len)
>        {
>            char procMemPath[PATH_MAX];
>
>            snprintf(procMemPath, sizeof(procMemPath), "/proc/%d/mem", req->pid);
>
>            int procMemFd = open(procMemPath, O_RDONLY);
>            if (procMemFd == -1)
>                errExit("\tS: open");
>
>            /* Check that the process whose info we are accessing is still alive.
>               If the SECCOMP_IOCTL_NOTIF_ID_VALID operation (performed
>               in checkNotificationIdIsValid()) succeeds, we know that the
>               /proc/PID/mem file descriptor that we opened corresponds to the
>               process for which we received a notification. If that process
>               subsequently terminates, then read() on that file descriptor
>               will return 0 (EOF). */
>
>            checkNotificationIdIsValid(notifyFd, req->id);
>
>            /* Read bytes at the location containing the pathname argument
>               (i.e., the first argument) of the mkdir(2) call */
>
>            ssize_t nread = pread(procMemFd, path, len, req->data.args[0]);
>            if (nread == -1)
>                errExit("pread");

As discussed at
<https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
we need to re-check checkNotificationIdIsValid() after reading remote
memory but before using the read value in any way. Otherwise, the
syscall could in the meantime get interrupted by a signal handler, the
signal handler could return, and then the function that performed the
syscall could free() allocations or return (thereby freeing buffers on
the stack).

In essence, this pread() is (unavoidably) a potential use-after-free
read; and to make that not have any security impact, we need to check
whether UAF read occurred before using the read value. This should
probably be called out elsewhere in the manpage, too...

Now, of course, **reading** is the easy case. The difficult case is if
we have to **write** to the remote process... because then we can't
play games like that. If we write data to a freed pointer, we're
screwed, that's it. (And for somewhat unrelated bonus fun, consider
that /proc/$pid/mem is originally intended for process debugging,
including installing breakpoints, and will therefore happily write
over "readonly" private mappings, such as typical mappings of
executable code.)

So, uuuuh... I guess if anyone wants to actually write memory back to
the target process, we'd better come up with some dedicated API for
that, using an ioctl on the seccomp fd that magically freezes the
target process inside the syscall while writing to its memory, or
something like that? And until then, the manpage should have a big fat
warning that writing to the target's memory is simply not possible
(safely).

>            if (nread == 0) {
>                fprintf(stderr, "\tS: pread() of /proc/PID/mem "
>                        "returned 0 (EOF)\n");
>                exit(EXIT_FAILURE);
>            }
