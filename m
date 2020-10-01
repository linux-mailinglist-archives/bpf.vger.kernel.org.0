Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD806280384
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 18:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbgJAQF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732242AbgJAQF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 12:05:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33596C0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 09:05:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so7956866ejb.3
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMB73dDKkouoCGF4bPiVkzHfDrWjLelK7eqM7hnqOfQ=;
        b=v0zUtKZZ9u7C+SlsQ2sjJJXn5TQDdDxiCusGcV7Bneg7l6BBK2FRvU6tKaf6cwbkZr
         Bxr4HqFic8ETbL+6s6FkrDBJ6RrJRdxI5e6jH9HqzuAdekZiVBeBfcE+BsIOQYPibWjH
         5wDBH5QUEc3dmwkTqAvAlue2C4c55WjFjAt60tuobqpclbLDVXzW3t/vv/ks3GMmLmS3
         6Ce5Q9qnrrxYVWmqMxqGZedF4dz75mbs5iMjV4WMHNXLA/xqRf88EKEmLm0XEz+E9Fl7
         PyFGoySwCEvboCSlpTknQ/0twIK7Hhr3NtN64G/bzOO0hO0Q5LjfZQ38IYFXieNRFg9b
         ZFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMB73dDKkouoCGF4bPiVkzHfDrWjLelK7eqM7hnqOfQ=;
        b=D3r+P7vTdsehRotEPxqVP6/DLGISkVYRCuIitz6sujUwNYqmBscZLwHiT4TAtJ9qPe
         y/cdSPfKoIyLD1kcNskxEuXy9RIg87l8/ikwInbvlbOhkO8DIJv8fzq4wXKEEodBUAsT
         RRBekah/uJzKUjSoJ+Uy92RzESAcy73G/cvNgzITnI4oF0NYE84g0qZBpxYyLcehYAJV
         oieNF3SOz5iuks0lZKNGWQGyLPCluexIsR0MpVeiDASVyGaChHGRUJbXapBNb2FiajiJ
         Wqw+ki0Seu1tVwUDEEjRLa/RyzBzTR1+5uxoFa8YKNO/NvAhaKiRqU34ZHO8QeN9uE4e
         wItQ==
X-Gm-Message-State: AOAM531a1Wex8JqRervz4jX7Vqe9NcE9x6HvmAAvR32iHMemGGEiO9OH
        s1zic0QYB4U03Q4YexJNynTC1M8ZQ4qsvcayux998w==
X-Google-Smtp-Source: ABdhPJxKtttAvVo28q3xfu3pZ2Zdcn3tId/kcpgfnRwxqrJNDHKqiBhxtoN0zCN6pGxjHl75UiIS9gSFsZdo/e98VLw=
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr4247020eja.233.1601568326659;
 Thu, 01 Oct 2020 09:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0whaSTobwnoJHW+Eyqg5a8H4JCO-KHrgsuNiEg0qbD3w@mail.gmail.com> <CABqSeATEMTB_hRt9D9teW6GcDvz4VLfMQyvX=nvgR4Uu4+AgoA@mail.gmail.com>
In-Reply-To: <CABqSeATEMTB_hRt9D9teW6GcDvz4VLfMQyvX=nvgR4Uu4+AgoA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 18:05:00 +0200
Message-ID: <CAG48ez3nqG_O3OYLLffVOcFf+ONgFwU9mc+HZ1GixBPbHZLyvw@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
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

On Thu, Oct 1, 2020 at 2:06 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> On Wed, Sep 30, 2020 at 5:01 PM Jann Horn <jannh@google.com> wrote:
> > Hmm, this won't work, because the task could be exiting, and seccomp
> > filters are detached in release_task() (using
> > seccomp_filter_release()). And at the moment, seccomp_filter_release()
> > just locklessly NULLs out the tsk->seccomp.filter pointer and drops
> > the reference.
> >
> > The locking here is kind of gross, but basically I think you can
> > change this code to use lock_task_sighand() / unlock_task_sighand()
> > (see the other examples in fs/proc/base.c), and bail out if
> > lock_task_sighand() returns NULL. And in seccomp_filter_release(), add
> > something like this:
> >
> > /* We are effectively holding the siglock by not having any sighand. */
> > WARN_ON(tsk->sighand != NULL);
>
> Ah thanks. I was thinking about how tasks exit and get freed and that
> sort of stuff, and how this would race against them. The last time I
> worked with procfs there was some magic going on that I could not
> figure out, so I was thinking if some magic will stop the task_struct
> from being released, considering it's an argument here.
>
> I just looked at release_task and related functions; looks like it
> will, at the end, decrease the reference count of the task_struct.
> Does procfs increase the refcount while calling the procfs functions?
> Hence, in procfs functions one can rely on the task_struct still being
> a task_struct, but any direct effects of release_task may happen while
> the procfs functions are running?

Yeah.

The ONE() entry you're adding to tgid_base_stuff is used to help
instantiate a "struct inode" when someone looks up the path
"/proc/$tgid/seccomp_cache"; then when that path is opened, a "struct
file" is created that holds a reference to the inode; and while that
file exists, your proc_pid_seccomp_cache() can be invoked.

proc_pid_seccomp_cache() is invoked from proc_single_show()
("PROC_I(inode)->op.proc_show" is proc_pid_seccomp_cache), and
proc_single_show() obtains a temporary reference to the task_struct
using get_pid_task() on a "struct pid" and drops that reference
afterwards with put_task_struct(). The "struct pid" is obtained from
the "struct proc_inode", which is essentially a subclass of "struct
inode". The "struct pid" is kept refererenced until the inode goes
away, via proc_pid_evict_inode(), called by proc_evict_inode().

By looking at put_task_struct() and its callees, you can figure out
which parts of the "struct task" are kept alive by the reference to
it.

By the way, maybe it'd make sense to add this to tid_base_stuff as
well? That should just be one extra line of code. Seccomp filters are
technically per-thread, so it would make sense to have them visible in
the per-thread subdirectories /proc/$pid/task/$tid/.
