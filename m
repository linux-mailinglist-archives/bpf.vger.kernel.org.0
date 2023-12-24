Return-Path: <bpf+bounces-18654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E181D7C2
	for <lists+bpf@lfdr.de>; Sun, 24 Dec 2023 04:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176611C20FCF
	for <lists+bpf@lfdr.de>; Sun, 24 Dec 2023 03:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BA0A4C;
	Sun, 24 Dec 2023 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSHXTxoI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9BA3F;
	Sun, 24 Dec 2023 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f5c0be04cso23641706d6.0;
        Sat, 23 Dec 2023 19:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703388958; x=1703993758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weKsVsKNrCvV2kyNt0ry5Nk/tWdJ9JAICoIq7OSzhcA=;
        b=HSHXTxoIWPN08wnEn+3G+4WY4xSg35UvZbYIAlKwvcb/qdLAkbcMzVRpAzwcvhqum7
         itpZDUi+xzSZ/LaafLTZkHDCTduv2EFpRZJXw5wLAvCzYVYmtE0Cm1T1J81djznmd4TN
         XFES1yACDODyJHTmZL4NonCro1PAmAygsijs+ykbWQwNr4/eEBlgPQTjp56geKrQmV83
         m3BYE66xPqRO45SL45dMDy67RRZS4zqkmOjPV47GUERDFDcRK7esG56LppUuXGgUd/mK
         pH++QWeKdLOAaBAnKNkjuvi1KQeIvonLDO4/XGTO2zbjyjOHBik0I9aMlXMKHW7O22tz
         96tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703388958; x=1703993758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weKsVsKNrCvV2kyNt0ry5Nk/tWdJ9JAICoIq7OSzhcA=;
        b=q7caFr8vblpaIInuv0JIP3UQGjlxPPaq99aewu7/A90aS/zg+L85w232INNF8BjSKl
         QqEg/BFDO+iZYI+R3eQ4MqlSwJhhXKvnWS9OwRANgYuH8FzhP+8/2gH0+SPZYY1qbefc
         Sbut6/q7CrFFhK0K+IkTVe2f30d5+bDemwzLXbyXdt8/fIhcZiAm+iwui8U86Yy84s2L
         CTtdpCn/LVXua5G2FrEPNNpdegGeal+QvnjxpEbV/9fB+vvAMhnoKdQPPggzOj0GNF9z
         eKxjVwDTePqfAzXkYtU2QVKuFuQsHNwXY0XmBEcdDhY68Tiejg+hyS8iGpb8WnH+NNtE
         4UgA==
X-Gm-Message-State: AOJu0YyLoXRmVZsdSjjd9WnoEYkIa6NNqVegwnOphXmJ1mv3qBvJPcoW
	k5y5x9ZMaMCcLQ1j5jeW8018Vp1863tx5PMOWSw=
X-Google-Smtp-Source: AGHT+IFZJd1vRU2AgHQ9AyCbdlMfveFkrY+CjEU2/eHQHycCO+OrEnUMLwumOveI81fMFduNFPiYWNaOGga9ayqBS+E=
X-Received: by 2002:a05:6214:d8a:b0:67f:27b6:9bae with SMTP id
 e10-20020a0562140d8a00b0067f27b69baemr5362555qve.85.1703388958113; Sat, 23
 Dec 2023 19:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
In-Reply-To: <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 24 Dec 2023 11:35:21 +0800
Message-ID: <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>, 
	"luto@amacapital.net" <luto@amacapital.net>, wad@chromium.org
Cc: akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 8:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Dec 14, 2023 at 7:51=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In our containerized environment, we've identified unexpected OOM event=
s
> > where the OOM-killer terminates tasks despite having ample free memory.
> > This anomaly is traced back to tasks within a container using mbind(2) =
to
> > bind memory to a specific NUMA node. When the allocated memory on this =
node
> > is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > indiscriminately kills tasks.
> >
> > The Challenge
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In a containerized environment, independent memory binding by a user ca=
n
> > lead to unexpected system issues or disrupt tasks being run by other us=
ers
> > on the same server. If a user genuinely requires memory binding, we wil=
l
> > allocate dedicated servers to them by leveraging kubelet deployment.
> >
> > Currently, users possess the ability to autonomously bind their memory =
to
> > specific nodes without explicit agreement or authorization from our end=
.
> > It's imperative that we establish a method to prevent this behavior.
> >
> > Proposed Solution
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > - Capability
> >   Currently, any task can perform MPOL_BIND without specific capabiliti=
es.
> >   Enforcing CAP_SYS_RESOURCE or CAP_SYS_NICE could be an option, but th=
is
> >   may have unintended consequences. Capabilities, being broad, might gr=
ant
> >   unnecessary privileges. We should explore alternatives to prevent
> >   unexpected side effects.
> >
> > - LSM
> >   Introduce LSM hooks for syscalls such as mbind(2) and set_mempolicy(2=
)
> >   to disable MPOL_BIND. This approach is more flexibility and allows fo=
r
> >   fine-grained control without unintended consequences. A sample LSM BP=
F
> >   program is included, demonstrating practical implementation in a
> >   production environment.
> >
> > - seccomp
> >   seccomp is relatively heavyweight, making it less suitable for
> >   enabling in our production environment:
> >   - Both kubelet and containers need adaptation to support it.
> >   - Dynamically altering security policies for individual containers
> >     without interrupting their operations isn't straightforward.
> >
> > Future Considerations
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In addition, there's room for enhancement in the OOM-killer for cases
> > involving CONSTRAINT_MEMORY_POLICY. It would be more beneficial to
> > prioritize selecting a victim that has allocated memory on the same NUM=
A
> > node. My exploration on the lore led me to a proposal[0] related to thi=
s
> > matter, although consensus seems elusive at this point. Nevertheless,
> > delving into this specific topic is beyond the scope of the current
> > patchset.
> >
> > [0]. https://lore.kernel.org/lkml/20220512044634.63586-1-ligang.bdlg@by=
tedance.com/
> >
> > Changes:
> > - v4 -> v5:
> >   - Revise the commit log in patch #5. (KP)
> > - v3 -> v4: https://lwn.net/Articles/954126/
> >   - Drop the changes around security_task_movememory (Serge)
> > - RCC v2 -> v3: https://lwn.net/Articles/953526/
> >   - Add MPOL_F_NUMA_BALANCING man-page (Ying)
> >   - Fix bpf selftests error reported by bot+bpf-ci
> > - RFC v1 -> RFC v2: https://lwn.net/Articles/952339/
> >   - Refine the commit log to avoid misleading
> >   - Use one common lsm hook instead and add comment for it
> >   - Add selinux implementation
> >   - Other improments in mempolicy
> > - RFC v1: https://lwn.net/Articles/951188/
> >
> > Yafang Shao (5):
> >   mm, doc: Add doc for MPOL_F_NUMA_BALANCING
> >   mm: mempolicy: Revise comment regarding mempolicy mode flags
> >   mm, security: Add lsm hook for memory policy adjustment
> >   security: selinux: Implement set_mempolicy hook
> >   selftests/bpf: Add selftests for set_mempolicy with a lsm prog
> >
> >  .../admin-guide/mm/numa_memory_policy.rst          | 27 +++++++
> >  include/linux/lsm_hook_defs.h                      |  3 +
> >  include/linux/security.h                           |  9 +++
> >  include/uapi/linux/mempolicy.h                     |  2 +-
> >  mm/mempolicy.c                                     |  8 +++
> >  security/security.c                                | 13 ++++
> >  security/selinux/hooks.c                           |  8 +++
> >  security/selinux/include/classmap.h                |  2 +-
> >  .../selftests/bpf/prog_tests/set_mempolicy.c       | 84 ++++++++++++++=
++++++++
> >  .../selftests/bpf/progs/test_set_mempolicy.c       | 28 ++++++++
> >  10 files changed, 182 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/set_mempolic=
y.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_set_mempolic=
y.c
>
> In your original patchset there was a lot of good discussion about
> ways to solve, or mitigate, this problem using existing mechanisms;
> while you disputed many (all?) of those suggestions, I felt that they
> still had merit over your objections.

JFYI. The initial patchset presents three suggestions:
- Disabling CONFIG_NUMA, proposed by Michal:
  By default, tasks on a server allocate memory from their local
memory node initially. Disabling CONFIG_NUMA could potentially lead to
a performance hit.

- Adjusting NUMA workload configuration, also from Michal:
  This adjustment has been successfully implemented on some dedicated
clusters, as mentioned in the commit log. However, applying this
change universally across a large fleet of servers might result in
significant wastage of physical memory.

- Implementing seccomp, suggested by Ondrej and Casey:
  As indicated in the commit log, altering the security policy
dynamically without interrupting a running container isn't
straightforward. Implementing seccomp requires the introduction of an
eBPF-based seccomp, which constitutes a substantial change.
  [ The seccomp maintainer has been added to this mail thread for
further discussion. ]


> I also don't believe the
> SELinux implementation of the set_mempolicy hook fits with the
> existing SELinux philosophy of access control via type enforcement;
> outside of some checks on executable memory and low memory ranges,
> SELinux doesn't currently enforce policy on memory ranges like this,
> SELinux focuses more on tasks being able to access data/resources on
> the system.
>
> My current opinion is that you should pursue some of the mitigations
> that have already been mentioned, including seccomp and/or a better
> NUMA workload configuration.  I would also encourage you to pursue the
> OOM improvement you briefly described.  All of those seem like better
> options than this new LSM/SELinux hook.

Using the OOM solution should not be our primary approach. Whenever
possible, we should prioritize alternative solutions to prevent
encountering the OOM situation.

--=20
Regards
Yafang

