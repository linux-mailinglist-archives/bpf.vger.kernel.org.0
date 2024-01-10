Return-Path: <bpf+bounces-19313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A680B829392
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 07:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159F11F26D37
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E52BCF4;
	Wed, 10 Jan 2024 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuNYpGFo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD36090;
	Wed, 10 Jan 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67fdfed519dso26864756d6.2;
        Tue, 09 Jan 2024 22:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704866856; x=1705471656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX4ZgGhrFmihBCc9vwu3GrccuPRtsb0D4SK3T+0feJ4=;
        b=OuNYpGFo3lxMVY+70hJn4i9+7mCIslJw/TRpmV5Xdpk/K6SYI00VnKOxCwQ72fEegO
         wkFVn45En0bI7EH4wfuyievvVtC4gbCIK3o3+1p21sf79AhRFdxHd/OKR8TzWe0lArh3
         5FV6PKOavvhPMW9fUWo/fXzveoE1MyjiBRIpUjNgFvv2C9f0qDuIXZH3gwNCkAycMZ1z
         2fbNvP9fRRuh0ql/4wPeCYjcf/m0Geeq60CnsHbs2BGJej336Csu2oMUaLWYdpSNBRa6
         LZCl6jKJe9dgUv7kYUWRUReCd2+FWEPf8u0E3WG6zb2aotcuwMmdh/uk31aGWtM4ydcN
         BsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704866856; x=1705471656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX4ZgGhrFmihBCc9vwu3GrccuPRtsb0D4SK3T+0feJ4=;
        b=JxPkOA01ZsGoQD1jXauCkFrdiMuHqvARDeYCasObmNqOXURgQ5g647oCYaWAaXiw9p
         cDOg5ozWybbHNwgX4styqkQsGWHmsdIlz4iXwztYj4Lr+FMyqRtzGseHlaKAEV5VUaIW
         yHlJWhlHpZRAA96SGcR66Pwe/yTxjt97S78xDCBzcbcmlyC7qrZrb6AefgdZjY2DwPO9
         /RTh6ZuH5bhmlsWzFNAGYS1MQpaDpUTG/zHImbmpLQMwFuMU0pmwPDhroVoPT4XIm4cS
         Q14Bo32Zzy4SJTDTseUjEdZWqxLwgMwsvhYXmuM6IipxfyYH+mbxWVQziacMs0oxu7hV
         xKNg==
X-Gm-Message-State: AOJu0Yybemx1IdWMkSIsJ7Ifexc0hkfaV2HZbQYfJF0ZfIlAOW9WzaxR
	QmQs8zxk5rzlRcgpIKrmxoCOOFI9V0a4itRy1A4=
X-Google-Smtp-Source: AGHT+IHb1XZEP3Dx8xNoa6s5KH+tFvQ9Tdn8bsevvwemtEmBcSDOKtx6V5D6nj9LvCxyaKPkQA5KgsMdPU8hlRt3xaU=
X-Received: by 2002:a05:6214:1d0a:b0:67f:3cc6:4420 with SMTP id
 e10-20020a0562141d0a00b0067f3cc64420mr900691qvd.2.1704866855495; Tue, 09 Jan
 2024 22:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
 <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
 <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com> <CALOAHbA-aW5gHXuf4MZVDXqD89Ri=9Ff7wcnV5wnBe=+pjkLrQ@mail.gmail.com>
In-Reply-To: <CALOAHbA-aW5gHXuf4MZVDXqD89Ri=9Ff7wcnV5wnBe=+pjkLrQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 Jan 2024 14:06:59 +0800
Message-ID: <CALOAHbCqMZE2F9E+KdLtF=hw9_hEkhjAsHaCHaRwKYWU3wyDyA@mail.gmail.com>
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

On Mon, Dec 25, 2023 at 11:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Mon, Dec 25, 2023 at 3:44=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Sat, Dec 23, 2023 at 10:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > On Sat, Dec 23, 2023 at 8:16=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Thu, Dec 14, 2023 at 7:51=E2=80=AFAM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > Background
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > In our containerized environment, we've identified unexpected OOM=
 events
> > > > > where the OOM-killer terminates tasks despite having ample free m=
emory.
> > > > > This anomaly is traced back to tasks within a container using mbi=
nd(2) to
> > > > > bind memory to a specific NUMA node. When the allocated memory on=
 this node
> > > > > is exhausted, the OOM-killer, prioritizing tasks based on oom_sco=
re,
> > > > > indiscriminately kills tasks.
> > > > >
> > > > > The Challenge
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > In a containerized environment, independent memory binding by a u=
ser can
> > > > > lead to unexpected system issues or disrupt tasks being run by ot=
her users
> > > > > on the same server. If a user genuinely requires memory binding, =
we will
> > > > > allocate dedicated servers to them by leveraging kubelet deployme=
nt.
> > > > >
> > > > > Currently, users possess the ability to autonomously bind their m=
emory to
> > > > > specific nodes without explicit agreement or authorization from o=
ur end.
> > > > > It's imperative that we establish a method to prevent this behavi=
or.
> > > > >
> > > > > Proposed Solution
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - Capability
> > > > >   Currently, any task can perform MPOL_BIND without specific capa=
bilities.
> > > > >   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, =
but this
> > > > >   may have unintended consequences. Capabilities, being broad, mi=
ght grant
> > > > >   unnecessary privileges. We should explore alternatives to preve=
nt
> > > > >   unexpected side effects.
> > > > >
> > > > > - LSM
> > > > >   Introduce LSM hooks for syscalls such as mbind(2) and set_mempo=
licy(2)
> > > > >   to disable MPOL_BIND. This approach is more flexibility and all=
ows for
> > > > >   fine-grained control without unintended consequences. A sample =
LSM BPF
> > > > >   program is included, demonstrating practical implementation in =
a
> > > > >   production environment.
> > > > >
> > > > > - seccomp
> > > > >   seccomp is relatively heavyweight, making it less suitable for
> > > > >   enabling in our production environment:
> > > > >   - Both kubelet and containers need adaptation to support it.
> > > > >   - Dynamically altering security policies for individual contain=
ers
> > > > >     without interrupting their operations isn't straightforward.
> > > > >
> > > > > Future Considerations
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > In addition, there's room for enhancement in the OOM-killer for c=
ases
> > > > > involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial t=
o
> > > > > prioritize selecting a victim that has allocated memory on the sa=
me NUMA
> > > > > node. My exploration on the lore led me to a proposal[0] related =
to this
> > > > > matter, although consensus seems elusive at this point. Neverthel=
ess,
> > > > > delving into this specific topic is beyond the scope of the curre=
nt
> > > > > patchset.
> > > > >
> > > > > [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.b=
dlg@bytedance.com/
> > > > >
> > > > > Changes:
> > > > > - v4 -> v5:
> > > > >   - Revise the commit log in patch #5. (KP)
> > > > > - v3 -> v4: https://lwn.net/Articles/954126/
> > > > >   - Drop the changes around security_task_movememory (Serge)
> > > > > - RCC v2 -> v3: https://lwn.net/Articles/953526/
> > > > >   - Add MPOL_F_NUMA_BALANCING man-page (Ying)
> > > > >   - Fix bpf selftests error reported by bot+bpf-ci
> > > > > - RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
> > > > >   - Refine the commit log to avoid misleading
> > > > >   - Use one common lsm hook instead and add comment for it
> > > > >   - Add selinux implementation
> > > > >   - Other improments in mempolicy
> > > > > - RFC v1: https://lwn.net/Articles/951188/
> > > > >
> > > > > Yafang Shao (5):
> > > > >   mm, doc: Add doc for MPOL_F_NUMA_BALANCING
> > > > >   mm: mempolicy: Revise comment regarding mempolicy mode flags
> > > > >   mm, security: Add lsm hook for memory policy adjustment
> > > > >   security: selinux: Implement set_mempolicy hook
> > > > >   selftests/bpf: Add selftests for set_mempolicy with a lsm prog
> > > > >
> > > > >  .../admin-guide/mm/numa_memory_policy.rst          | 27 +++++++
> > > > >  include/linux/lsm_hook_defs.h                      |  3 +
> > > > >  include/linux/security.h                           |  9 +++
> > > > >  include/uapi/linux/mempolicy.h                     |  2 +-
> > > > >  mm/mempolicy.c                                     |  8 +++
> > > > >  security/security.c                                | 13 ++++
> > > > >  security/selinux/hooks.c                           |  8 +++
> > > > >  security/selinux/include/classmap.h                |  2 +-
> > > > >  .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++=
++++++++++++++
> > > > >  .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
> > > > >  10 files changed, 182 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/set_me=
mpolicy.c
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_set_me=
mpolicy.c
> > > >
> > > > In your original patchset there was a lot of good discussion about
> > > > ways to solve, or mitigate, this problem using existing mechanisms;
> > > > while you disputed many (all?) of those suggestions, I felt that th=
ey
> > > > still had merit over your objections.
> > >
> > > JFYI. The initial patchset presents three suggestions:
> > > - Disabling CONFIG_NUMA, proposed by Michal:
> > >   By default, tasks on a server allocate memory from their local
> > > memory node initially. Disabling CONFIG_NUMA could potentially lead t=
o
> > > a performance hit.
> > >
> > > - Adjusting NUMA workload configuration, also from Michal:
> > >   This adjustment has been successfully implemented on some dedicated
> > > clusters, as mentioned in the commit log. However, applying this
> > > change universally across a large fleet of servers might result in
> > > significant wastage of physical memory.
> > >
> > > - Implementing seccomp, suggested by Ondrej and Casey:
> > >   As indicated in the commit log, altering the security policy
> > > dynamically without interrupting a running container isn't
> > > straightforward. Implementing seccomp requires the introduction of an
> > > eBPF-based seccomp, which constitutes a substantial change.
> > >   [ The seccomp maintainer has been added to this mail thread for
> > > further discussion. ]
> >
> > The seccomp filter runs cBFF (classic BPF) and not eBPF; there are a
> > number of sandboxing tools designed to make this easier to use,
> > including systemd, and if you need to augment your existing
> > application there are libraries available to make this easier.
>
> Let's delve into how cBPF-based seccomp operates with runc [0] - our
> application:
>
> 1. Create a seccomp filter in /path/to/seccomp/profile.json.
> 2. Initiate a container with this filter rule using
>     docker run --rm \
>              -it \
>              --security-opt seccomp=3D/path/to/seccomp/profile.json \
>              hello-world
>
> However, modifying or removing the seccomp filter mandates stopping
> the running container and repeating the aforementioned steps. This
> interruption isn't desirable for us.
>
> The inability to dynamically alter the seccomp filter with cBPF arises
> from the kernel lacking a method to unload the seccomp once attached
> to a task. In other words, cBPF-based seccomp cannot dynamically
> attach and detach from tasks. Please correct me if my understanding is
> incorrect.
>
> [0]. https://docs.docker.com/engine/security/seccomp/

Paul,

Do you have any additional comments or further suggestions?

--=20
Regards
Yafang

