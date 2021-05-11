Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8909237A07B
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEKHPU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhEKHPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 03:15:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA40C061574;
        Tue, 11 May 2021 00:14:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q15so10873159pgg.12;
        Tue, 11 May 2021 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCE0VDemWP3Un3BUBubMOTJqKvhb1dlengItxJN9kCg=;
        b=dvWBVFkDpMFMjORmV6mBzC0CLWkszPaXOBWqcbLFzQzTFGR8V382LPXY3RSt47PSwJ
         PriWUdBlYzxBgzlQNm5VRwrDBalYJyi4uPr4uNiM03Hhrk0iVoYWwKNMrXEF3QPf4kZn
         8mYO91HE02cfwkoVfsLEemXRhNo12BIrGCV1CBSxLmQzPP/OPv/cCQbJE999w5QZlFVP
         MgNjN52ICxRoOyOdkf4lNyAbxXiGrRk5UJKx0PXf3/2shlFSiB1fC/qgalaGcR4ze6SW
         drEy294gra5n6N4J3H0s4FAXsbsORpig3yHGOau0FvDpSHnDDbNCwvpGF3DpsAxtIaGv
         +KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCE0VDemWP3Un3BUBubMOTJqKvhb1dlengItxJN9kCg=;
        b=UQMTrBcBvMzJhXbXeJokqGtvicvRdYJZu5pYatms8MUzK1XRkVnYbTGqvbMiTnT4sv
         zRJ4ehqtE+K7TNvVpa9BOWIvFWjYuWj7MNmcdem9nK/vDjP6aXEhbu6rYZPrBAtBa+4y
         YJGUPfpOw1zw5R8EuI8wt27aUrGxc7bYQW0TXVBHI5tjjmPMkIkm5Ry0g85aKaMcnKqS
         YuG1eAbAkoA5BON0JCtXhq2KSnD3J0A+BgN9a2Ymhi0CsIVK0NtVWpKnOlkhW6C3Lppa
         k7018rrU2qKP4Mxrswm0kGBXjcGknvbMXMCggaghqG1d48dlFUDPWa8+0eQOdnGA0vHj
         h5fA==
X-Gm-Message-State: AOAM532qpWn6fL8LdNJvVs1EAvULlUoTiOBNuQeXalE1bMsBbVTBgRol
        AtYgCb1iyag5OvuIyT+D5VMWpu6D5/eVoyM20i8=
X-Google-Smtp-Source: ABdhPJzB5dBcRqYw4ILOKKlWtRmv2VdjzfR/h5MVREf5B3Yicsh7OXee7jd9MFZwwpcPeUm13xty8co8o8PTnZYrbzw=
X-Received: by 2002:a05:6a00:139a:b029:2a1:2e2d:5924 with SMTP id
 t26-20020a056a00139ab02902a12e2d5924mr25069886pfg.15.1620717252935; Tue, 11
 May 2021 00:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620499942.git.yifeifz2@illinois.edu> <53db70ed544928d227df7e3f3a1f8c53e3665c65.1620499942.git.yifeifz2@illinois.edu>
 <20210511020425.54nygajvrpxqnfsh@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210511020425.54nygajvrpxqnfsh@ast-mbp.dhcp.thefacebook.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Tue, 11 May 2021 02:14:01 -0500
Message-ID: <CABqSeAT8iz-VhWjWqABqGbF7ydkoT7LmzJ5Do8K1ANQvQK=FJQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to
 read user memory
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 9:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 10, 2021 at 12:22:47PM -0500, YiFei Zhu wrote:
> >
> > +BPF_CALL_3(bpf_probe_read_user_dumpable, void *, dst, u32, size,
> > +        const void __user *, unsafe_ptr)
> > +{
> > +     int ret = -EPERM;
> > +
> > +     if (get_dumpable(current->mm))
> > +             ret = copy_from_user_nofault(dst, unsafe_ptr, size);
>
> Could you explain a bit more how dumpable flag makes it safe for unpriv?
> The unpriv prog is attached to the children tasks only, right?
> and dumpable gets cleared if euid changes?

This is the "reduction to ptrace". The model here is that the eBPF
seccomp filter is doing the equivalent of ptracing the user process
using the privileges of the task at the time of loading the seccomp
filter.

ptrace access control is governed by ptrace.c:__ptrace_may_access. The
requirements are:
* always allow thread group introspection -- assume false so we are
more restrictive than ptrace.
* tracer has CAP_PTRACE in the target user namespace or tracer
r/fsu/gidid equal target resu/gid -- discuss below
* tracer has CAP_PTRACE in the target user namespace or target is
SUID_DUMP_USER (I realized I should probably change the condition to
== SUID_DUMP_USER).
* passes LSM checks (eg yama ptrace_scope) -- we expose a hook to LSM
but it's more of a "disable all advanced seccomp-eBPF features". How
would a better interface to LSM look like?

The dumpable check handles the "target is SUID_DUMP_USER" condition,
in the circumstance that the loader does not have CAP_PTRACE in its
namespace at the time of load. Why would this imply its CAP_PTRACE
capability in target namespace? This is based on my understanding on
how capabilities and user namespaces interact:
For the sake of simplicity, let's first assume that loader is the same
task as the task that attaches the filter (via prctl or seccomp
syscall).
* Case 1: target and loader are the same user namespace. Trivial case,
the two operations are the same.
* Case 2: target is loader's parent namespace. Can't happen under
assumption. Seccomp affects itself and children only, and it is only
possible to join a descendant user ns.
* Case 3: target is loader's descendant namespace. Loader would have
full CAP_PTRACE on target. We are more restrictive than ptrace.
* Case 4: target and loader are on unrelated namespace branches. Can't
happen under assumption. Same as case 2.

Let's break this assumption and see what happens if the loader and
attacher are in different contexts:
* Case 1: attacher is less capable (as a general term of "what it can
do") than loader then all of the above applies, since the model
concerns and checks the capabilities of the loader.
* Case 2: attacher is more capable than loader. The attacher would
need an fd to the prog to attach it:
  * subcase 1: attacher inherited the fd after an exec and became more
capable. uh... why is it trusting fds from a less capable context?
  * subcase 2: attacher has CAP_SYS_ADMIN and gets the fd via
BPF_PROG_GET_FD_BY_ID. uh... why is it trusting random fds and
attaching it?
  * subcase 3: attacher received the fd via a domain socket from a
process which may be in a different user namespace. On my first
thought, I thought, why is it trusting random fds from a less capable
context? Except I just thought of an adversary could:
    * Clone into new userns,
    * Load filter in child, which has CAP_PTRACE in new userns
    * Send filter to the parent which doesn't have CAP_PTRACE in its userns
    * It's broken :(
We'll think more about this case. One way is to check against init
namespace, which means unpriv container runtimes won't have the
non-dumpable override. Though, it shouldn't be affecting most of the
use cases. Alternatively we can store which userns it was loaded from
and reject attaching from a different userns.

Regarding u/gids, for an attacher to attach a seccomp filter, whether
cBPF or eBPF, if it doesn't have CAP_SYS_ADMIN in its current ns, it
will have to set no_new_privs on itself before it can attach. (Unlike
the previous discussion, this check is done at attach time rather than
load.) With no_new_privs the target's privs is a subset of the
attacher's, so the attacher should have a way to match the target's
resuid, so this condition is not a concern.

YiFei Zhu
