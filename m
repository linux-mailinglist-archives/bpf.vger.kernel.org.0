Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7038F37FC2B
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhEMROM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhEMROL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 13:14:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E26C061574;
        Thu, 13 May 2021 10:13:00 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l19so815638plk.11;
        Thu, 13 May 2021 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zrMfwFzDodhHwykTLD1Kq9ONATU2N5C73AJT1XjPvZA=;
        b=l6FD1RQ6xxKveg6UUyO2wxrYw52YI5kT4mdjir0NlJc6rJU7OuUyUK8HNEoD1+M2Ki
         sD1w2nkC9b4PB922KUmVXDWMBzFAzzesvBbZU50Feo644wrDAQJkyHPYEDuZovwCj3QY
         V2/ffS+jjzoZUfBmj/u06vhVxhy5Inp4UyQXbmafMTzHJR59ayQw8Sqk2lDkjmzltK7l
         xRlv/JrmHed8Cy/p5UyHQMwDdmX+bDEXRTdXz7OUhOGxGwaNXky+qQbQHtEz+1HIp7VE
         IyQv9qZRZVIgl6Heh70GO+r03kTCqAUFPLugJH2bpukHmE2gG2SNkkYRBuK3Z/bmbJx+
         JwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zrMfwFzDodhHwykTLD1Kq9ONATU2N5C73AJT1XjPvZA=;
        b=J84cm8q9I6kbU1LTZMGxoebICA5zBNvTVatKbNcQd9jzQDDA0JmMSg5GCx+7VVEz2C
         zXZ3jOjZ+Pc0aSUjZRbz3Eg2ZQMMJTvR8D8lbVxFlTtjbcdQAyZ2uJwQ58WtRPJk1ZE6
         V0Zbqc0k301Gh7gZ71+FBZV9AMwmVoSHjzdNAW5DsQFVAgOcVpi6Xr7sQ6MFbqMyIKXb
         rvhVtZDam9iVf5kwWAR8mGaiuCvXwMFWHw8zHLF+vivoUsu9tyyz7HaUW7RYi8T7Ng1k
         UClVlXuj5aWnJwrWLR1qqNbrIVk5TeorO+7jNGo/ga2rgK6jpiSHDG8vh1A+NQRYdT0P
         nTBQ==
X-Gm-Message-State: AOAM530qvpczqRm34vmm2Jf8B2T9Pbl6eT87aaRKiPBJ8Q1aIg69z+o1
        YV19gITC4uL3FcRXXj8lBi1YyH4KRgxeptNcSGM=
X-Google-Smtp-Source: ABdhPJyt6icEb19FHIyWgBfJo/GScqbX27AWZXJeoucbJApQUi9/ZSvw8D1WlSTRl33U7rU93hkqQoz5O3MY7tAJY4U=
X-Received: by 2002:a17:902:b485:b029:ee:d5c0:841c with SMTP id
 y5-20020a170902b485b02900eed5c0841cmr40423107plr.57.1620925979839; Thu, 13
 May 2021 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABqSeAR9rgARxYGYUVZQgZ0a-wqZxy-qeoVpu495XHxpj0Ku=A@mail.gmail.com>
 <B541CF0E-3410-4CA3-93E4-670052C5FC11@amacapital.net>
In-Reply-To: <B541CF0E-3410-4CA3-93E4-670052C5FC11@amacapital.net>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 13 May 2021 12:12:48 -0500
Message-ID: <CABqSeAT1OeiW69RipcY6U4drPtJ+GaygZqXfd8aL8uX4d4Wp=A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to
 read user memory
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        containers@lists.linux.dev, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 13, 2021 at 9:53 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
> > On May 12, 2021, at 10:26 PM, YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >
> > =EF=BB=BFOn Wed, May 12, 2021 at 5:36 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> Typically the verifier does all the checks at load time to avoid
> >> run-time overhead during program execution. Then at attach time we
> >> check that attach parameters provided at load time match exactly
> >> to those at attach time. ifindex, attach_btf_id, etc fall into this ca=
tegory.
> >> Doing something similar it should be possible to avoid
> >> doing get_dumpable() at run-time.
> >
> > Do you mean to move the check of dumpable to load time instead of
> > runtime? I do not think that makes sense. A process may arbitrarily
> > set its dumpable attribute during execution via prctl. A process could
> > do set itself to non-dumpable, before interacting with sensitive
> > information that would better not be possible to be dumped (eg.
> > ssh-agent does this [1]). Therefore, being dumpable at one point in
> > time does not indicate anything about whether it stays dumpable at a
> > later point in time. Besides, seccomp filters are inherited across
> > clone and exec, attaching to many tasks with no option to detach. What
> > should the load-time check of task dump-ability be against? The
> > current task may only be the tip of an iceburg.
> >
> > [1] https://github.com/openssh/openssh-portable/blob/2dc328023f60212cd2=
9504fc05d849133ae47355/ssh-agent.c#L1398
> >
> >
>
> First things first: why are you checking dumpable at all?  Once you figur=
e out why and whether it=E2=80=99s needed, you may learn something about wh=
at task to check.
>
> I don=E2=80=99t think checking dumpable makes any sense.

ptrace. We don't want to extend one's ability to read another
process's memory if they could not read it via ptrace
(process_vm_readv or ptrace(PTRACE_PEEK{TEXT,DATA})). The constraints
for ptrace to access a target's memory I've written down earlier [1],
but tl;dr: to be at least as restrictive as ptrace, a tracer without
CAP_PTRACE cannot trace a non-dumpable process. What's the target
process (i.e. the process whose memory is being read) in the context
of a seccomp filter? The current task. Does that answer your
questions?

[1] https://lore.kernel.org/bpf/CABqSeAT8iz-VhWjWqABqGbF7ydkoT7LmzJ5Do8K1AN=
QvQK=3DFJQ@mail.gmail.com/

YiFei Zhu
