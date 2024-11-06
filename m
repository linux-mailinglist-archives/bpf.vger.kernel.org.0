Return-Path: <bpf+bounces-44160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D09BF89F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D0CB2219F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D120CCF9;
	Wed,  6 Nov 2024 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVLTGNEW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902D1CF2A5;
	Wed,  6 Nov 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929417; cv=none; b=loQDS7xrODcbNVjdYrDUS3Ap+zdD45Qa4jDkfcliZYsnLiN4vroi4pT4rTWJzdBrRxoJTickg8wrQbh/4KZkXkGtzeSIcM2YrQq3YczmS3pDHZ4QC1qq2UTAHMSr/t2EjXpm1XVC1Am5bYCogFtqwBgTufu+XnuX7qkS/SVE9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929417; c=relaxed/simple;
	bh=FnSf1vUHNNfBpJkPKGERbOMo7osT6qLVpZEECIj3j40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccaGSKxUtTyffKlVeJ6uk6rJ/BM0ccWEsAylRbmJYbAcAkYc30WY03qtY4/n9R9M0c9nbb7hbh7BybHJiulzl9slxN+sc4rdM7GnSCG5Ovl59IiC0K6+fIjDTezOPDIxstq8rUC6AlUCwuN8mUM7zCi4HOA69/OUpX9W0JnSTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVLTGNEW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso273409a12.3;
        Wed, 06 Nov 2024 13:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730929413; x=1731534213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QSnhMxMsw7IM6qwPkS0rhaEH2zXSwmnLjCctjOaBLQ=;
        b=kVLTGNEWX8i5RjWHp/S0//DSuwyWnB89R/tOKtSop2FmS7pqBzUApBWgrFaW2Pmvnw
         4/Cx8xciiXbQi1VSL/iY/PgaHipuwFQn74hNbRjzvSRcDU8fF+1vc1XSJw734Otesngb
         Cx0VGKqhKHMSaG7+IufRspgHDVAmh4cZFM9RLzuGm3shrpI+wrETpGj7ksoGEXyEO2vV
         rN1kaGfP2QrIHr0/54vxnaDzbLjvO/RUBDoX9DmSl0WpYDHVXTKp+aBx7/SBbg9tnnuY
         SwO2dFUYGrC76Xj19fkdDcBWcJ2no84BH5fWNcBgfK1pPR4MJ0Gn7kDqKXRBnpd+UXvN
         +2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929413; x=1731534213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QSnhMxMsw7IM6qwPkS0rhaEH2zXSwmnLjCctjOaBLQ=;
        b=OEsMz+l1S1vcmiMxFK3pNgzT0ABTDo0t1CuxlDPyp5p/VOImCc5wfmqxE68KtO9XyS
         YHAzjxNvnieBxuki4jN33idAcziSYaWXXyRkIOPojhEYQlqQkK9RsZoPYwRKbDFXfFeV
         A4vizxwuMPMM5ESbU+7MmEgWGd2+oEVijQqlRyHy9LJMo+5gf2UFqiE57RxGadAnzW7j
         DYsH2FkrbhjI9Ve8M8qz8yW5tZu08k307/cd7ZG5GWErMdNcNyrX3t4g7p4ZoCMVL7Qc
         AfD9wkOwzhL3CyLISmvKg2Bn84ylzXj6/E5wkmwopcKoF42qGAFYdCwhFIlPo+PLavQW
         ZHMw==
X-Forwarded-Encrypted: i=1; AJvYcCUGLRaf3ZUHNkEt/NjtZE73orp85rq2DH0FbHybD6mIO6wsNKHd3jzXxGtD2ak28ZNKIJYisqPA5YGR1um3@vger.kernel.org, AJvYcCW3tNqBgq+51QkCTycNVmFFBudi/55eg77HJ6VVF9Rd5Xrl/KQRBQO6Fu8pnhrJUhL69IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHyICMTh1VA7hcAvBKbo8MlxzGo5QnZnR0UGxsQ5RSQuynxRv
	vkMo5xtJJiScbPHMg3bu7sOK4Nk3+r/kIKXhuRcVvOk2zU29anax2YTwVf/VE++tzz1QABK29S3
	vv0X1Rr07kfanB2fN7C8uYSGZu0s=
X-Google-Smtp-Source: AGHT+IGYw5aqxzmaviJwDc6Zqp7rpeDToIqnDWYnfkla0rOrgMRU95HQmWa9D5wcv0/r3xJtdk9MhuuLNXj1NVLZwpc=
X-Received: by 2002:a17:90a:4802:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2e8f1073b73mr44891842a91.24.1730929413511; Wed, 06 Nov 2024
 13:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101023832.32404-1-mrpre@163.com> <CAEf4BzbVqcCN1p8ydLN17LygK5R=gBYJV0A-cnycjtsUzrX34g@mail.gmail.com>
 <gbtlzrhme5yrbvlwkswlzz44lims7dymougc7376c5hugosqqh@qqrjg6wtmnan>
In-Reply-To: <gbtlzrhme5yrbvlwkswlzz44lims7dymougc7376c5hugosqqh@qqrjg6wtmnan>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 13:43:21 -0800
Message-ID: <CAEf4BzYgkuC0HCqx1X_-j36pd5XqrMJayOvORe39Ego_Oj8A6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
To: Jiayuan Chen <mrpre@163.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 10:12=E2=80=AFPM Jiayuan Chen <mrpre@163.com> wrote:
>
> On Fri, Nov 01, 2024 at 12:25:51PM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 31, 2024 at 7:40=E2=80=AFPM mrpre <mrpre@163.com> wrote:
> > >
> > > Why we need cpu affinity:
> > > Mainstream data planes, like Nginx and HAProxy, utilize CPU affinity
> > > by binding user processes to specific CPUs. This avoids interference
> > > between processes and prevents impact from other processes.
> > >
> > > Sockmap, as an optimization to accelerate such proxy programs,
> > > currently lacks the ability to specify CPU affinity. The current
> > > implementation of sockmap handling backlog is based on workqueue,
> > > which operates by calling 'schedule_delayed_work()'. It's current
> > > implementation prefers to schedule on the local CPU, i.e., the CPU
> > > that handled the packet under softirq.
> > >
> > > For extremely high traffic with large numbers of packets,
> > > 'sk_psock_backlog' becomes a large loop.
> > >
> > > For multi-threaded programs with only one map, we expect different
> > > sockets to run on different CPUs. It is important to note that this
> > > feature is not a general performance optimization. Instead, it
> > > provides users with the ability to bind to specific CPU, allowing
> > > them to enhance overall operating system utilization based on their
> > > own system environments.
> > >
> > > Implementation:
> > > 1.When updating the sockmap, support passing a CPU parameter and
> > > save it to the psock.
> > > 2.When scheduling psock, determine which CPU to run on using the
> > > psock's CPU information.
> > > 3.For thoes sockmap without CPU affinity, keep original logic by usin=
g
> > > 'schedule_delayed_work()'.
> > >
> > > Performance Testing:
> > > 'client <-> sockmap proxy <-> server'
> > >
> > > Using 'iperf3' tests, with the iperf server bound to CPU5 and the ipe=
rf
> > > client bound to CPU6, performance without using CPU affinity is
> > > around 34 Gbits/s, and CPU usage is concentrated on CPU5 and CPU6.
> > > '''
> > > [  5] local 127.0.0.1 port 57144 connected to 127.0.0.1 port 10000
> > > [ ID] Interval           Transfer     Bitrate
> > > [  5]   0.00-1.00   sec  3.95 GBytes  33.9 Gbits/sec
> > > [  5]   1.00-2.00   sec  3.95 GBytes  34.0 Gbits/sec
> > > ......
> > > '''
> > >
> > > With using CPU affinity, the performnce is close to direct connection
> > > (without any proxy).
> > > '''
> > > [  5] local 127.0.0.1 port 56518 connected to 127.0.0.1 port 10000
> > > [ ID] Interval           Transfer     Bitrate
> > > [  5]   0.00-1.00   sec  7.76 GBytes  66.6 Gbits/sec
> > > [  5]   1.00-2.00   sec  7.76 GBytes  66.7 Gbits/sec
> > > ......
> > > '''
> > >
> > > Signed-off-by: Jiayuan Chen <mrpre@163.com>
> > > ---
> > >  include/linux/bpf.h      |  3 ++-
> > >  include/linux/skmsg.h    |  8 ++++++++
> > >  include/uapi/linux/bpf.h |  4 ++++
> > >  kernel/bpf/syscall.c     | 23 +++++++++++++++++------
> > >  net/core/skmsg.c         | 11 +++++++----
> > >  net/core/sock_map.c      | 12 +++++++-----
> > >  6 files changed, 45 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index c3ba4d475174..a56028c389e7 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -3080,7 +3080,8 @@ int bpf_prog_test_run_syscall(struct bpf_prog *=
prog,
> > >
> > >  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog=
 *prog);
> > >  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_t=
ype ptype);
> > > -int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *v=
alue, u64 flags);
> > > +int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *v=
alue, u64 flags,
> > > +                            s32 target_cpu);
> > >  int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > >                             union bpf_attr __user *uattr);
> > >  int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog=
 *prog);
> > > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > > index d9b03e0746e7..919425a92adf 100644
> > > --- a/include/linux/skmsg.h
> > > +++ b/include/linux/skmsg.h
> > > @@ -117,6 +117,7 @@ struct sk_psock {
> > >         struct delayed_work             work;
> > >         struct sock                     *sk_pair;
> > >         struct rcu_work                 rwork;
> > > +       s32                             target_cpu;
> > >  };
> > >
> > >  int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
> > > @@ -514,6 +515,13 @@ static inline bool sk_psock_strp_enabled(struct =
sk_psock *psock)
> > >         return !!psock->saved_data_ready;
> > >  }
> > >
> > > +static inline int sk_psock_strp_get_cpu(struct sk_psock *psock)
> > > +{
> > > +       if (psock->target_cpu !=3D -1)
> > > +               return psock->target_cpu;
> > > +       return WORK_CPU_UNBOUND;
> > > +}
> > > +
> > >  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
> > >
> > >  #define BPF_F_STRPARSER        (1UL << 1)
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index f28b6527e815..2019a87b5d4a 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1509,6 +1509,10 @@ union bpf_attr {
> > >                         __aligned_u64 next_key;
> > >                 };
> > >                 __u64           flags;
> > > +               union {
> > > +                       /* specify the CPU where the sockmap job run =
on */
> > > +                       __aligned_u64 target_cpu;
> >
> > I have no opinion on the feature itself, I'll leave this to others.
> > But from UAPI perspective:
> >
> > a) why is this a u64 and not, say, int?
> > b) maybe we should just specify this as flags and not have to update
> > all the UAPIs (including libbpf-side)? Just add a new
> > BPF_F_SOCKNMAP_TARGET_CPU flag or something, and specify that highest
> > 32 bits specify the CPU itself?
> >
> > We have similar schema for some other helpers, so not *that* unusual.
> >
> Thank you for your response. I think I should clarify my thoughts:
>
> My idea is to pass a user-space pointer, with the pointer being null
> to indicate that the user has not provided anything.For example, when
> users use the old interface 'bpf_map_update_elem' and pass in u64 of
> 0, it means that the user hasn't specified a CPU. If a u32 or another
> type of value is passed in, when it is 0, it's ambiguous whether this
> indicates target CPU 0 or that the user hasn't provided a value. So
> my design involves passing a user-space pointer.
>
> I also considered using the highest 32 bits of the flag as target_cpu, bu=
t
> this approach still encounters the ambiguity mentioned above. Of course
> for programs using libbpf, I can naturally init all the higher 32 bits
> default to 1 to indicate the user hasn't specified a CPU, but this is
> incompatible with programs not using libbpf. Another approach could be
> that a value of 1 for the higher 32 bits indicates CPU 0, and 2 indicates
> CPU 1..., but this seems odd and would require a helper to assist users
> in passing arguments.

See BPF_F_SOCKMAP_TARGET_CPU flag point in my reply. You need an extra
flag that would specify that those 32 bits are specifying a CPU
number. There is no ambiguity. No flag - no CPU, Flag - CPU (even if
zero).

>
> There is another method, like providing an extra 'attr', to replace the
> passed 'target_cpu', which maintains the general nature of
> 'map_update_elem' interface, like:
> '''
> +struct extra_bpf_attr {
> +    u32 target_cpu;
> +};
> struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>     __u32   map_fd;
>     __aligned_u64 key;
>     union {
>         __aligned_u64 value;
>         __aligned_u64 next_key;
>     };
>     __u64   flags;
>     +struct extra_bpf_attr extra;
> };
>
> static int bpf_map_update_value(struct bpf_map *map, struct file *map_fil=
e,
> -                               void *key, void *value, __u64 flags)
> +                               void *key, void *value, __u64 flags, stru=
ct bpf_attr_extra *extra);
> '''
>
> > > +               };
> > >         };
> > >
> > >         struct { /* struct used by BPF_MAP_*_BATCH commands */
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 8254b2973157..95f719b9c3f3 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -239,10 +239,9 @@ static int bpf_obj_pin_uptrs(struct btf_record *=
rec, void *obj)
> > >  }
> > >
> > >  static int bpf_map_update_value(struct bpf_map *map, struct file *ma=
p_file,
> > > -                               void *key, void *value, __u64 flags)
> > > +                               void *key, void *value, __u64 flags, =
s32 target_cpu)
> >
> > yeah, this is what I'm talking about. Think how ridiculous it is for a
> > generic "BPF map update" operation to accept the "target_cpu"
> > parameter.
> >
> > pw-bot: cr
> >
> > >  {
> > >         int err;
> > > -
> >
> > why? don't break whitespace formatting
> >
> > >         /* Need to create a kthread, thus must support schedule */
> > >         if (bpf_map_is_offloaded(map)) {
> > >                 return bpf_map_offload_update_elem(map, key, value, f=
lags);
> > > @@ -252,7 +251,7 @@ static int bpf_map_update_value(struct bpf_map *m=
ap, struct file *map_file,
> > >                 return map->ops->map_update_elem(map, key, value, fla=
gs);
> > >         } else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH ||
> > >                    map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP) {
> > > -               return sock_map_update_elem_sys(map, key, value, flag=
s);
> > > +               return sock_map_update_elem_sys(map, key, value, flag=
s, target_cpu);
> > >         } else if (IS_FD_PROG_ARRAY(map)) {
> > >                 return bpf_fd_array_map_update_elem(map, map_file, ke=
y, value,
> > >                                                     flags);
> >
> > [...]
>
>

