Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD61637FC39
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEMRRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 13:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhEMRRQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 13:17:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 029DC61444
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620926167;
        bh=Ry2wjIVSYj1t6KKG93LfA7nqkdFhgjKLx802ZbZeA0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mEkE7LLBXRwRAGqz9BaFjjMCPBb9Eq4M/yjSpJDZJX30xdkOJKuw4d7dcrfA40tmh
         Wpt0YLo+ULypdIyBtvkKq3gSNhR7zjv3/1qlImNgpQs3geDVtNAqfye/vAaqhEHa76
         UO6Q8bfZaZin+mfljCfQwBiQ2Tk/NahMUgS+2a0XV9jEh9+tusx6TAxnNY3nb/mIhx
         z8sAbcgyCwUaly5pYkX7CXvi7LaTz+s82Dg17iaTdj09kVBsI22ydnVEZa9HIANf8c
         QInpIhNp2cj8MJZXhFQJW8kunB4hRDgggudLvfFGMZyv45tywHvDz8zd16IXfoflFG
         lQIhE3ZS/90mQ==
Received: by mail-ed1-f48.google.com with SMTP id i13so1867165edb.9
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 10:16:06 -0700 (PDT)
X-Gm-Message-State: AOAM531vvKU6c+vDKI9ViaDviq0DCtkJNtwH0LNLVdHEBxt0d6GHSfeF
        iyq+++RedulA3yna/GOTprkOcXixTJusZjv1MGWvcw==
X-Google-Smtp-Source: ABdhPJzXLGCnTkj2E/00lNqydWmiYxjCYe6O+PIcMnjIWu8EnTQzfh9BwwyDPhJVG7WJp8KKqPul2wugt7zsXVQjzI4=
X-Received: by 2002:a05:6402:cac:: with SMTP id cn12mr53201537edb.238.1620926165459;
 Thu, 13 May 2021 10:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABqSeAR9rgARxYGYUVZQgZ0a-wqZxy-qeoVpu495XHxpj0Ku=A@mail.gmail.com>
 <B541CF0E-3410-4CA3-93E4-670052C5FC11@amacapital.net> <CABqSeAT1OeiW69RipcY6U4drPtJ+GaygZqXfd8aL8uX4d4Wp=A@mail.gmail.com>
In-Reply-To: <CABqSeAT1OeiW69RipcY6U4drPtJ+GaygZqXfd8aL8uX4d4Wp=A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 13 May 2021 10:15:54 -0700
X-Gmail-Original-Message-ID: <CALCETrWfV0C8c9erk-imRrndsY8dEffT=W4mJZnoKYP8-Dxojg@mail.gmail.com>
Message-ID: <CALCETrWfV0C8c9erk-imRrndsY8dEffT=W4mJZnoKYP8-Dxojg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 10/12] seccomp-ebpf: Add ability to
 read user memory
To:     YiFei Zhu <zhuyifei1999@gmail.com>
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

On Thu, May 13, 2021 at 10:13 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> On Thu, May 13, 2021 at 9:53 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > > On May 12, 2021, at 10:26 PM, YiFei Zhu <zhuyifei1999@gmail.com> wrot=
e:
> > >
> > > =EF=BB=BFOn Wed, May 12, 2021 at 5:36 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > >> Typically the verifier does all the checks at load time to avoid
> > >> run-time overhead during program execution. Then at attach time we
> > >> check that attach parameters provided at load time match exactly
> > >> to those at attach time. ifindex, attach_btf_id, etc fall into this =
category.
> > >> Doing something similar it should be possible to avoid
> > >> doing get_dumpable() at run-time.
> > >
> > > Do you mean to move the check of dumpable to load time instead of
> > > runtime? I do not think that makes sense. A process may arbitrarily
> > > set its dumpable attribute during execution via prctl. A process coul=
d
> > > do set itself to non-dumpable, before interacting with sensitive
> > > information that would better not be possible to be dumped (eg.
> > > ssh-agent does this [1]). Therefore, being dumpable at one point in
> > > time does not indicate anything about whether it stays dumpable at a
> > > later point in time. Besides, seccomp filters are inherited across
> > > clone and exec, attaching to many tasks with no option to detach. Wha=
t
> > > should the load-time check of task dump-ability be against? The
> > > current task may only be the tip of an iceburg.
> > >
> > > [1] https://github.com/openssh/openssh-portable/blob/2dc328023f60212c=
d29504fc05d849133ae47355/ssh-agent.c#L1398
> > >
> > >
> >
> > First things first: why are you checking dumpable at all?  Once you fig=
ure out why and whether it=E2=80=99s needed, you may learn something about =
what task to check.
> >
> > I don=E2=80=99t think checking dumpable makes any sense.
>
> ptrace. We don't want to extend one's ability to read another
> process's memory if they could not read it via ptrace
> (process_vm_readv or ptrace(PTRACE_PEEK{TEXT,DATA})). The constraints
> for ptrace to access a target's memory I've written down earlier [1],
> but tl;dr: to be at least as restrictive as ptrace, a tracer without
> CAP_PTRACE cannot trace a non-dumpable process. What's the target
> process (i.e. the process whose memory is being read) in the context
> of a seccomp filter? The current task. Does that answer your
> questions?
>
> [1] https://lore.kernel.org/bpf/CABqSeAT8iz-VhWjWqABqGbF7ydkoT7LmzJ5Do8K1=
ANQvQK=3DFJQ@mail.gmail.com/

The whole seccomp model is based on the assumption that the filter
installer completely controls the filtered task.  Reading memory is
not qualitatively different.

To be clear, this is not to be interpreted as an ack to allowing
seccomp to read process memory.  I'm saying that, if seccomp gains the
ability to read process memory, I don't think a dumpable or ptrace
check is needed.
