Return-Path: <bpf+bounces-18656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F06181DDCF
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 04:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507522819CF
	for <lists+bpf@lfdr.de>; Mon, 25 Dec 2023 03:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4DA4C;
	Mon, 25 Dec 2023 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnkuOBkl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613634A17;
	Mon, 25 Dec 2023 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f85d29d14so27793096d6.1;
        Sun, 24 Dec 2023 19:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703473976; x=1704078776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stc1KaRMKqDMQyE8dlkS4piT7lRpW1LtMhsAboA4VmI=;
        b=PnkuOBkl8ql2qpvv0BCn/JuYIyYuwSTm7A0dY+eM/asGtgrkuE/iJQYvIYBWgLFkST
         NE9KIBBs+P2Lhtpp86IuUvLekmFSBbRbz/9YOJEdyJdx/TbXBDCucGAdUVD1eWu0kdNN
         uyPxU8xGn4zFpEU2XVPwPV6zWJzYUGf8O4C4lzAcVOY6PGXfoOOJ4TcQFjHXzQo1TtxG
         AfCLxtdNWV5IvqVWsvcraxf8jtwdcTpn/xkNhZwLBxXIpRm1dx6j2Rw+RCKLt4Gy3yiX
         mVxDIvKRR3+bnL+Fh7IFZ6PnhAWTdJ+zSl7n6fxFky4LxCpFnUBp7tmKv+8AN08TiiWf
         6zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703473976; x=1704078776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stc1KaRMKqDMQyE8dlkS4piT7lRpW1LtMhsAboA4VmI=;
        b=Fe7W2Y8xQc1K1DYV0dGvg1b4HPR9YQTU7JIP9WT4yFDpXf6TBSdWxwYVoo9WXZM4Td
         eB2ZrYhMyyndUQVoCQRqKZ2HOV86tPkuMNWzhtAAN16Q4mRv6MAYq3z+q+fdepMcg/Y+
         DD4YiFds7xLLv5QfWDPvk+0uT4nLQDrU74vAYkGYjhFGiH/qe4JJhJB/OCg+6AcJ4xtR
         Vq2yjxZlwgxabFm2yXglALJCBApvHYLw/Rcy3na/+ft/QaiiR/WyM2dNssn1lK8w5CsE
         xRbFqsO4XfRZguSL593AHwxF5P6/4yNR93pW4N6wlev0wE+/+t9gqKPdMNOW/Mcq1RmD
         WVnw==
X-Gm-Message-State: AOJu0Yy4F/9nxaMVs3QkPp86jPRDWzaF0juOhOmA2w3Dis986o1sS73x
	9pxfWDyB3iYwrPThGX1AhKw0Z/IOu0R8tgx6bBc=
X-Google-Smtp-Source: AGHT+IH0MaXg/bxmj+IKekD2gC/g6X7v02PuvSaBpohWy8f6AdLoMmwb9hBQJLS6ZVnYEpAnNiREy667re5oC73QVBQ=
X-Received: by 2002:a05:6214:140c:b0:67f:ae1d:9187 with SMTP id
 pr12-20020a056214140c00b0067fae1d9187mr3853691qvb.69.1703473976160; Sun, 24
 Dec 2023 19:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
 <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com> <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 25 Dec 2023 11:12:19 +0800
Message-ID: <CALOAHbA-aW5gHXuf4MZVDXqD89Ri=9Ff7wcnV5wnBe=+pjkLrQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, "luto@amacapital.net" <luto@amacapital.net>, wad@chromium.org, 
	akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 3:44=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sat, Dec 23, 2023 at 10:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > On Sat, Dec 23, 2023 at 8:16=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Dec 14, 2023 at 7:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > Background
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > In our containerized environment, we've identified unexpected OOM e=
vents
> > > > where the OOM-killer terminates tasks despite having ample free mem=
ory.
> > > > This anomaly is traced back to tasks within a container using mbind=
(2) to
> > > > bind memory to a specific NUMA node. When the allocated memory on t=
his node
> > > > is exhausted, the OOM-killer, prioritizing tasks based on oom_score=
,
> > > > indiscriminately kills tasks.
> > > >
> > > > The Challenge
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > In a containerized environment, independent memory binding by a use=
r can
> > > > lead to unexpected system issues or disrupt tasks being run by othe=
r users
> > > > on the same server. If a user genuinely requires memory binding, we=
 will
> > > > allocate dedicated servers to them by leveraging kubelet deployment=
.
> > > >
> > > > Currently, users possess the ability to autonomously bind their mem=
ory to
> > > > specific nodes without explicit agreement or authorization from our=
 end.
> > > > It's imperative that we establish a method to prevent this behavior=
.
> > > >
> > > > Proposed Solution
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - Capability
> > > >   Currently, any task can perform MPOL_BIND without specific capabi=
lities.
> > > >   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, bu=
t this
> > > >   may have unintended consequences. Capabilities, being broad, migh=
t grant
> > > >   unnecessary privileges. We should explore alternatives to prevent
> > > >   unexpected side effects.
> > > >
> > > > - LSM
> > > >   Introduce LSM hooks for syscalls such as mbind(2) and set_mempoli=
cy(2)
> > > >   to disable MPOL_BIND. This approach is more flexibility and allow=
s for
> > > >   fine-grained control without unintended consequences. A sample LS=
M BPF
> > > >   program is included, demonstrating practical implementation in a
> > > >   production environment.
> > > >
> > > > - seccomp
> > > >   seccomp is relatively heavyweight, making it less suitable for
> > > >   enabling in our production environment:
> > > >   - Both kubelet and containers need adaptation to support it.
> > > >   - Dynamically altering security policies for individual container=
s
> > > >     without interrupting their operations isn't straightforward.
> > > >
> > > > Future Considerations
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > In addition, there's room for enhancement in the OOM-killer for cas=
es
> > > > involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
> > > > prioritize selecting a victim that has allocated memory on the same=
 NUMA
> > > > node. My exploration on the lore led me to a proposal[0] related to=
 this
> > > > matter, although consensus seems elusive at this point. Nevertheles=
s,
> > > > delving into this specific topic is beyond the scope of the current
> > > > patchset.
> > > >
> > > > [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdl=
g@bytedance.com/
> > > >
> > > > Changes:
> > > > - v4 -> v5:
> > > >   - Revise the commit log in patch #5. (KP)
> > > > - v3 -> v4: https://lwn.net/Articles/954126/
> > > >   - Drop the changes around security_task_movememory (Serge)
> > > > - RCC v2 -> v3: https://lwn.net/Articles/953526/
> > > >   - Add MPOL_F_NUMA_BALANCING man-page (Ying)
> > > >   - Fix bpf selftests error reported by bot+bpf-ci
> > > > - RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
> > > >   - Refine the commit log to avoid misleading
> > > >   - Use one common lsm hook instead and add comment for it
> > > >   - Add selinux implementation
> > > >   - Other improments in mempolicy
> > > > - RFC v1: https://lwn.net/Articles/951188/
> > > >
> > > > Yafang Shao (5):
> > > >   mm, doc: Add doc for MPOL_F_NUMA_BALANCING
> > > >   mm: mempolicy: Revise comment regarding mempolicy mode flags
> > > >   mm, security: Add lsm hook for memory policy adjustment
> > > >   security: selinux: Implement set_mempolicy hook
> > > >   selftests/bpf: Add selftests for set_mempolicy with a lsm prog
> > > >
> > > >  .../admin-guide/mm/numa_memory_policy.rst          | 27 +++++++
> > > >  include/linux/lsm_hook_defs.h                      |  3 +
> > > >  include/linux/security.h                           |  9 +++
> > > >  include/uapi/linux/mempolicy.h                     |  2 +-
> > > >  mm/mempolicy.c                                     |  8 +++
> > > >  security/security.c                                | 13 ++++
> > > >  security/selinux/hooks.c                           |  8 +++
> > > >  security/selinux/include/classmap.h                |  2 +-
> > > >  .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++++=
++++++++++++
> > > >  .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
> > > >  10 files changed, 182 insertions(+), 2 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/set_memp=
olicy.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_set_memp=
olicy.c
> > >
> > > In your original patchset there was a lot of good discussion about
> > > ways to solve, or mitigate, this problem using existing mechanisms;
> > > while you disputed many (all?) of those suggestions, I felt that they
> > > still had merit over your objections.
> >
> > JFYI. The initial patchset presents three suggestions:
> > - Disabling CONFIG_NUMA, proposed by Michal:
> >   By default, tasks on a server allocate memory from their local
> > memory node initially. Disabling CONFIG_NUMA could potentially lead to
> > a performance hit.
> >
> > - Adjusting NUMA workload configuration, also from Michal:
> >   This adjustment has been successfully implemented on some dedicated
> > clusters, as mentioned in the commit log. However, applying this
> > change universally across a large fleet of servers might result in
> > significant wastage of physical memory.
> >
> > - Implementing seccomp, suggested by Ondrej and Casey:
> >   As indicated in the commit log, altering the security policy
> > dynamically without interrupting a running container isn't
> > straightforward. Implementing seccomp requires the introduction of an
> > eBPF-based seccomp, which constitutes a substantial change.
> >   [ The seccomp maintainer has been added to this mail thread for
> > further discussion. ]
>
> The seccomp filter runs cBFF (classic BPF) and not eBPF; there are a
> number of sandboxing tools designed to make this easier to use,
> including systemd, and if you need to augment your existing
> application there are libraries available to make this easier.

Let's delve into how cBPF-based seccomp operates with runc [0] - our
application:

1. Create a seccomp filter in /path/to/seccomp/profile.json.
2. Initiate a container with this filter rule using
    docker run --rm \
             -it \
             --security-opt seccomp=3D/path/to/seccomp/profile.json \
             hello-world

However, modifying or removing the seccomp filter mandates stopping
the running container and repeating the aforementioned steps. This
interruption isn't desirable for us.

The inability to dynamically alter the seccomp filter with cBPF arises
from the kernel lacking a method to unload the seccomp once attached
to a task. In other words, cBPF-based seccomp cannot dynamically
attach and detach from tasks. Please correct me if my understanding is
incorrect.

[0]. https://docs.docker.com/engine/security/seccomp/

>
> > > I also don't believe the
> > > SELinux implementation of the set_mempolicy hook fits with the
> > > existing SELinux philosophy of access control via type enforcement;
> > > outside of some checks on executable memory and low memory ranges,
> > > SELinux doesn't currently enforce policy on memory ranges like this,
> > > SELinux focuses more on tasks being able to access data/resources on
> > > the system.
> > >
> > > My current opinion is that you should pursue some of the mitigations
> > > that have already been mentioned, including seccomp and/or a better
> > > NUMA workload configuration.  I would also encourage you to pursue th=
e
> > > OOM improvement you briefly described.  All of those seem like better
> > > options than this new LSM/SELinux hook.
> >
> > Using the OOM solution should not be our primary approach. Whenever
> > possible, we should prioritize alternative solutions to prevent
> > encountering the OOM situation.
>
> It's a good thing that there exist other options.

Absolutely, let's explore alternative options beforehand.

--=20
Regards
Yafang

