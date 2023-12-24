Return-Path: <bpf+bounces-18655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C7B81DC2C
	for <lists+bpf@lfdr.de>; Sun, 24 Dec 2023 20:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15659281D11
	for <lists+bpf@lfdr.de>; Sun, 24 Dec 2023 19:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F92DDA8;
	Sun, 24 Dec 2023 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WdpqF/FF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29389D52C
	for <bpf@vger.kernel.org>; Sun, 24 Dec 2023 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb89215406so1896442b6e.1
        for <bpf@vger.kernel.org>; Sun, 24 Dec 2023 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703447097; x=1704051897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boZ0uwY/zF6oiDhDnHlBkkvbQGja5+tZWoWqWwoQ9bk=;
        b=WdpqF/FFE+eiL9ECBGtIw9C+F1KiPfWam6qQYVUQOl84lzYOQNS39kNml5eRNHTXtK
         Pctu9NiMbbWBH2C6jzX5OHkMbQY3fsmGijhfqyNrSm3JSHBuqZHi1J3NQTG6+8R0zQTg
         ptsFeIj9dh9oCX+YvbEx7jdYlTpLq6eHdpLAZRFKf3RZOasRFpjWx7YNcxge5BCrGDMR
         iMXnXwX3rERxG2xpPHuKX+lBZQPVKUra5CMSlIlwA1xf9f2LrAH1/6dlIkcd32PgySd7
         J+eqPxkInZAYM6lY6MmGJhs6igPvn2RFjCBcEmw/mKjTjFR9QgiAbCtRwDmot13SyVAS
         gVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703447097; x=1704051897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boZ0uwY/zF6oiDhDnHlBkkvbQGja5+tZWoWqWwoQ9bk=;
        b=PNQsQ2EGJ6qHm5NhZG8ewdeZ0B9hA+J21W/G4VpeR2YocPE1W0BvA9VIWAOyumaU8k
         4CmU5mpRuRoNqq2t9DuI+NZhZGVGzp2O9CPKiAECLB7P5JI5Mh7l9jd2dBObm5PCW6bs
         yVXqxFbeFMIdwRpd69PRKOg5GBXm4dwbCzYHN70DBCx8aXCPd5Qd20qhG6sLvmPUN044
         aq7Fh8oq8l1nkewWFf4YOrjvbgOMxBp2F/Dn3Efv7ZSdbImvKgGGyfEa2WQxjCcZwoMb
         +yyUGrrVwM8eNbgsoNYpt7tJrsvLsvPakMGqco5YGakMLlOiz5E+A5pf7GigWV8wnwbI
         dEXA==
X-Gm-Message-State: AOJu0YzkRIsq2aKahbuoEzdfeCIDhZnL50/GE8F+ATHkVud7WKZ5gVKB
	YAL6MXj4P+nj+3gA/byMZdwNHQTc1r/MQyYa7hBNxgTn7aqG
X-Google-Smtp-Source: AGHT+IGETYfxawX0HFXMVp+6t2ErU493rO1FtJFm80zYN2C9Rdc/T7NbMEoVOIgu/80q/4IgixKMSLJqZ1pExaurGLI=
X-Received: by 2002:a05:6808:13d0:b0:3b8:b063:9b66 with SMTP id
 d16-20020a05680813d000b003b8b0639b66mr6047506oiw.88.1703447097154; Sun, 24
 Dec 2023 11:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
 <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
In-Reply-To: <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 24 Dec 2023 14:44:46 -0500
Message-ID: <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, "luto@amacapital.net" <luto@amacapital.net>, wad@chromium.org, 
	akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 10:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> On Sat, Dec 23, 2023 at 8:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Dec 14, 2023 at 7:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > Background
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In our containerized environment, we've identified unexpected OOM eve=
nts
> > > where the OOM-killer terminates tasks despite having ample free memor=
y.
> > > This anomaly is traced back to tasks within a container using mbind(2=
) to
> > > bind memory to a specific NUMA node. When the allocated memory on thi=
s node
> > > is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > > indiscriminately kills tasks.
> > >
> > > The Challenge
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In a containerized environment, independent memory binding by a user =
can
> > > lead to unexpected system issues or disrupt tasks being run by other =
users
> > > on the same server. If a user genuinely requires memory binding, we w=
ill
> > > allocate dedicated servers to them by leveraging kubelet deployment.
> > >
> > > Currently, users possess the ability to autonomously bind their memor=
y to
> > > specific nodes without explicit agreement or authorization from our e=
nd.
> > > It's imperative that we establish a method to prevent this behavior.
> > >
> > > Proposed Solution
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > - Capability
> > >   Currently, any task can perform MPOL_BIND without specific capabili=
ties.
> > >   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but =
this
> > >   may have unintended consequences. Capabilities, being broad, might =
grant
> > >   unnecessary privileges. We should explore alternatives to prevent
> > >   unexpected side effects.
> > >
> > > - LSM
> > >   Introduce LSM hooks for syscalls such as mbind(2) and set_mempolicy=
(2)
> > >   to disable MPOL_BIND. This approach is more flexibility and allows =
for
> > >   fine-grained control without unintended consequences. A sample LSM =
BPF
> > >   program is included, demonstrating practical implementation in a
> > >   production environment.
> > >
> > > - seccomp
> > >   seccomp is relatively heavyweight, making it less suitable for
> > >   enabling in our production environment:
> > >   - Both kubelet and containers need adaptation to support it.
> > >   - Dynamically altering security policies for individual containers
> > >     without interrupting their operations isn't straightforward.
> > >
> > > Future Considerations
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > In addition, there's room for enhancement in the OOM-killer for cases
> > > involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
> > > prioritize selecting a victim that has allocated memory on the same N=
UMA
> > > node. My exploration on the lore led me to a proposal[0] related to t=
his
> > > matter, although consensus seems elusive at this point. Nevertheless,
> > > delving into this specific topic is beyond the scope of the current
> > > patchset.
> > >
> > > [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@=
bytedance.com/
> > >
> > > Changes:
> > > - v4 -> v5:
> > >   - Revise the commit log in patch #5. (KP)
> > > - v3 -> v4: https://lwn.net/Articles/954126/
> > >   - Drop the changes around security_task_movememory (Serge)
> > > - RCC v2 -> v3: https://lwn.net/Articles/953526/
> > >   - Add MPOL_F_NUMA_BALANCING man-page (Ying)
> > >   - Fix bpf selftests error reported by bot+bpf-ci
> > > - RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
> > >   - Refine the commit log to avoid misleading
> > >   - Use one common lsm hook instead and add comment for it
> > >   - Add selinux implementation
> > >   - Other improments in mempolicy
> > > - RFC v1: https://lwn.net/Articles/951188/
> > >
> > > Yafang Shao (5):
> > >   mm, doc: Add doc for MPOL_F_NUMA_BALANCING
> > >   mm: mempolicy: Revise comment regarding mempolicy mode flags
> > >   mm, security: Add lsm hook for memory policy adjustment
> > >   security: selinux: Implement set_mempolicy hook
> > >   selftests/bpf: Add selftests for set_mempolicy with a lsm prog
> > >
> > >  .../admin-guide/mm/numa_memory_policy.rst          | 27 +++++++
> > >  include/linux/lsm_hook_defs.h                      |  3 +
> > >  include/linux/security.h                           |  9 +++
> > >  include/uapi/linux/mempolicy.h                     |  2 +-
> > >  mm/mempolicy.c                                     |  8 +++
> > >  security/security.c                                | 13 ++++
> > >  security/selinux/hooks.c                           |  8 +++
> > >  security/selinux/include/classmap.h                |  2 +-
> > >  .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++++++=
++++++++++
> > >  .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
> > >  10 files changed, 182 insertions(+), 2 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempol=
icy.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempol=
icy.c
> >
> > In your original patchset there was a lot of good discussion about
> > ways to solve, or mitigate, this problem using existing mechanisms;
> > while you disputed many (all?) of those suggestions, I felt that they
> > still had merit over your objections.
>
> JFYI. The initial patchset presents three suggestions:
> - Disabling CONFIG_NUMA, proposed by Michal:
>   By default, tasks on a server allocate memory from their local
> memory node initially. Disabling CONFIG_NUMA could potentially lead to
> a performance hit.
>
> - Adjusting NUMA workload configuration, also from Michal:
>   This adjustment has been successfully implemented on some dedicated
> clusters, as mentioned in the commit log. However, applying this
> change universally across a large fleet of servers might result in
> significant wastage of physical memory.
>
> - Implementing seccomp, suggested by Ondrej and Casey:
>   As indicated in the commit log, altering the security policy
> dynamically without interrupting a running container isn't
> straightforward. Implementing seccomp requires the introduction of an
> eBPF-based seccomp, which constitutes a substantial change.
>   [ The seccomp maintainer has been added to this mail thread for
> further discussion. ]

The seccomp filter runs cBFF (classic BPF) and not eBPF; there are a
number of sandboxing tools designed to make this easier to use,
including systemd, and if you need to augment your existing
application there are libraries available to make this easier.

> > I also don't believe the
> > SELinux implementation of the set_mempolicy hook fits with the
> > existing SELinux philosophy of access control via type enforcement;
> > outside of some checks on executable memory and low memory ranges,
> > SELinux doesn't currently enforce policy on memory ranges like this,
> > SELinux focuses more on tasks being able to access data/resources on
> > the system.
> >
> > My current opinion is that you should pursue some of the mitigations
> > that have already been mentioned, including seccomp and/or a better
> > NUMA workload configuration.  I would also encourage you to pursue the
> > OOM improvement you briefly described.  All of those seem like better
> > options than this new LSM/SELinux hook.
>
> Using the OOM solution should not be our primary approach. Whenever
> possible, we should prioritize alternative solutions to prevent
> encountering the OOM situation.

It's a good thing that there exist other options.

--=20
paul-moore.com

