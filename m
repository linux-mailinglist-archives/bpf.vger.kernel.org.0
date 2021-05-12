Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8E37EF4F
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbhELXE2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbhELWhn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 18:37:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964EC061574;
        Wed, 12 May 2021 15:36:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s22so19394022pgk.6;
        Wed, 12 May 2021 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UpOa8pkygvDZn9c2EJx70PAoimLaTtpvm7rk2w5GoD4=;
        b=eutzv0rcHtCnXg1NZhEg9S189Mh870FS7MNV1qLkcjd0drZJszKPVhqSZgjPJQCSeO
         SBWtCKfeDJWyoGOPj6g1vBhEK7JEeh6GDXIV6X9sl0FqVEWKP6y3P+SFuAZWadb3yjY2
         FWVLOKe/K7/MG+n7vIwJ9Zn3mAzLK7TeKf/GLBgW0wDW4ZJ89QFOu+xlW+4kjrR+lvBk
         kH3gRwBgW4LHrpOoh1ptud55dnlw1eX0IXLNg1KJy+OSXq6Ap4S1TsEOxIUgRSNIBtdv
         RQqmYNa/InvSHlWnDalv+qcvjbRqsuYmOnSDkWA6JZTZPoQjuhawYg2wu95gHAD1YoGL
         CbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpOa8pkygvDZn9c2EJx70PAoimLaTtpvm7rk2w5GoD4=;
        b=aQqG5nzTKa2vt1yNeJa1w4W/BrzT3egBmegL6PZqPBTD2LHztbawgDniUNM+bFF+BS
         Yj4rtg2gm03pwUeCoBTOFkL+eQBAP5zHSfYss3kly4TqLb2g6KpraoeH6PPKsM5gjs7u
         /bzPPQ4T4/JWHhcr1KX+5VXFgsPCx1MOAF+tyJfpEH7yR6Y/B9uD1qlr3huP4VJoDpw4
         UWhIRK3+RzOIjxxQ+McZWOFvCFQtBlKCKQy4zjrq0hyvxLLoInuOarrB2jxl3fABBFOf
         g252FfTHWVcu0+eMRTR/dOeXo27Se8Y+3FJ0U4dLhbmK5U+mLaruHEg9dEa35T8lvByM
         dtQw==
X-Gm-Message-State: AOAM533USVI1AjW29cjo1r+atJoPey5X1BqWsiIWCS8hq/BcX3D4Fn/l
        vSBoOjsNXoMnkJ349r4T+HU=
X-Google-Smtp-Source: ABdhPJwIyt8i8wW63NMx7LcyYVRE3NHcDBhFs/C3LW2ZqpDS6QmKPQ9SBaxs7TzGpicpjPxPjMzZqA==
X-Received: by 2002:a17:90b:3689:: with SMTP id mj9mr42022937pjb.154.1620858992570;
        Wed, 12 May 2021 15:36:32 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:c6f4])
        by smtp.gmail.com with ESMTPSA id v11sm676077pfm.143.2021.05.12.15.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:36:31 -0700 (PDT)
Date:   Wed, 12 May 2021 15:36:26 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
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
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to
 read user memory
Message-ID: <20210512223626.olex7ewf6xd6m2c4@ast-mbp.dhcp.thefacebook.com>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <53db70ed544928d227df7e3f3a1f8c53e3665c65.1620499942.git.yifeifz2@illinois.edu>
 <20210511020425.54nygajvrpxqnfsh@ast-mbp.dhcp.thefacebook.com>
 <CABqSeAT8iz-VhWjWqABqGbF7ydkoT7LmzJ5Do8K1ANQvQK=FJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeAT8iz-VhWjWqABqGbF7ydkoT7LmzJ5Do8K1ANQvQK=FJQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 02:14:01AM -0500, YiFei Zhu wrote:
> On Mon, May 10, 2021 at 9:04 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 10, 2021 at 12:22:47PM -0500, YiFei Zhu wrote:
> > >
> > > +BPF_CALL_3(bpf_probe_read_user_dumpable, void *, dst, u32, size,
> > > +        const void __user *, unsafe_ptr)
> > > +{
> > > +     int ret = -EPERM;
> > > +
> > > +     if (get_dumpable(current->mm))
> > > +             ret = copy_from_user_nofault(dst, unsafe_ptr, size);
> >
> > Could you explain a bit more how dumpable flag makes it safe for unpriv?
> > The unpriv prog is attached to the children tasks only, right?
> > and dumpable gets cleared if euid changes?
> 
> This is the "reduction to ptrace". The model here is that the eBPF
> seccomp filter is doing the equivalent of ptracing the user process
> using the privileges of the task at the time of loading the seccomp
> filter.
> 
> ptrace access control is governed by ptrace.c:__ptrace_may_access. The
> requirements are:
> * always allow thread group introspection -- assume false so we are
> more restrictive than ptrace.
> * tracer has CAP_PTRACE in the target user namespace or tracer
> r/fsu/gidid equal target resu/gid -- discuss below
> * tracer has CAP_PTRACE in the target user namespace or target is
> SUID_DUMP_USER (I realized I should probably change the condition to
> == SUID_DUMP_USER).
> * passes LSM checks (eg yama ptrace_scope) -- we expose a hook to LSM
> but it's more of a "disable all advanced seccomp-eBPF features". How
> would a better interface to LSM look like?
> 
> The dumpable check handles the "target is SUID_DUMP_USER" condition,
> in the circumstance that the loader does not have CAP_PTRACE in its
> namespace at the time of load. Why would this imply its CAP_PTRACE
> capability in target namespace? This is based on my understanding on
> how capabilities and user namespaces interact:
> For the sake of simplicity, let's first assume that loader is the same
> task as the task that attaches the filter (via prctl or seccomp
> syscall).
> * Case 1: target and loader are the same user namespace. Trivial case,
> the two operations are the same.
> * Case 2: target is loader's parent namespace. Can't happen under
> assumption. Seccomp affects itself and children only, and it is only
> possible to join a descendant user ns.
> * Case 3: target is loader's descendant namespace. Loader would have
> full CAP_PTRACE on target. We are more restrictive than ptrace.
> * Case 4: target and loader are on unrelated namespace branches. Can't
> happen under assumption. Same as case 2.
> 
> Let's break this assumption and see what happens if the loader and
> attacher are in different contexts:
> * Case 1: attacher is less capable (as a general term of "what it can
> do") than loader then all of the above applies, since the model
> concerns and checks the capabilities of the loader.
> * Case 2: attacher is more capable than loader. The attacher would
> need an fd to the prog to attach it:
>   * subcase 1: attacher inherited the fd after an exec and became more
> capable. uh... why is it trusting fds from a less capable context?
>   * subcase 2: attacher has CAP_SYS_ADMIN and gets the fd via
> BPF_PROG_GET_FD_BY_ID. uh... why is it trusting random fds and
> attaching it?
>   * subcase 3: attacher received the fd via a domain socket from a
> process which may be in a different user namespace. On my first
> thought, I thought, why is it trusting random fds from a less capable
> context? Except I just thought of an adversary could:
>     * Clone into new userns,
>     * Load filter in child, which has CAP_PTRACE in new userns
>     * Send filter to the parent which doesn't have CAP_PTRACE in its userns
>     * It's broken :(
> We'll think more about this case. One way is to check against init
> namespace, which means unpriv container runtimes won't have the
> non-dumpable override. Though, it shouldn't be affecting most of the
> use cases. Alternatively we can store which userns it was loaded from
> and reject attaching from a different userns.

Typically the verifier does all the checks at load time to avoid
run-time overhead during program execution. Then at attach time we
check that attach parameters provided at load time match exactly
to those at attach time. ifindex, attach_btf_id, etc fall into this category.
Doing something similar it should be possible to avoid
doing get_dumpable() at run-time.
