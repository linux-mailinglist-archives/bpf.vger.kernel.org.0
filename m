Return-Path: <bpf+bounces-76417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9ADCB36F1
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB44530321D9
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8FE2D47E0;
	Wed, 10 Dec 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dmHNSOAS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60292C029D
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383123; cv=none; b=rqC/dM95Jv5KFDE9Efj3/yZHRKqq4INJrwzbALQU6IUAB73FVNw62EZ0/D1L5EOMuiIGIC6DJN7CknPcA1GwLxPe82yEgCITD4OY+4gSdFw/OD0rd3Jy/npCxXvTidpm+YFFyx1Bh6ls3gIHVKC0LQA+UPPtW2E+FhZJgSEPvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383123; c=relaxed/simple;
	bh=DTgOyI7sg8tx64osbWQ+fHOWLPcBoi27wtW73f4Fd2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8GJKCuKi7N6vUMSBuyVy5/hHfaSrtqVFhoTvmdhBDHFdM1s3+dLSUu/M+JEjKATF/SjxR2l9Ko8KYXYjkvIEAz5CmrtnoM9NfNRdG7lEMW/JGK/p9C7gim8e2RIUGTUUsvYRISGaVQgLoRcl2VlN9Mui2QUj/ucL2CNLJKFnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dmHNSOAS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b997ae045b7so469742a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765383119; x=1765987919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1rZLrbee4PtvRuG6okTKd88QcH0uiVNojdlds4NpK4=;
        b=dmHNSOASzukZ8pQ3kmt8D/wCIz5z3Xj5TDTYBa6iFLDTqG/jfnhFodk+kKK3OUoqc1
         gctYoo9D1lRsDs3wdK614iu8M6znqeAra7xkeqzDP0wSnUF3C0OAFz+RrebFUUsBhTRZ
         MU15HVMjmXXVwdL+dG8ceqsQ19H4gnXrfNx6u6lOtIIstp8L+vyZcLM67cO0vmT9wAhD
         lotXz19AHg5UN4c8UTl9kNqbROLebS3qAg6GH8axtuz41MjxKfWfRDfmwnGTuPn/rWnz
         cWxLBhUoUKZS8fEI4ZHYVoUzQZ4sfvnJN/K+rv9SOc2VgoAdkM+N4P+O4iaLBvq5WmIX
         vr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383119; x=1765987919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1rZLrbee4PtvRuG6okTKd88QcH0uiVNojdlds4NpK4=;
        b=k1ncJAyNdJWN4OFoCWe5em4VSp9fJx3ec6FJWEdYBW+dteOqMjz8JX/7WRapIdjR7M
         S6bfLvOv2Y7khlnTdVbYZ45x9fHBHScaHEVgIx6zufTszDrUt6qmV5TdV1dVba/9A/eO
         h63qpL2ezQleO8WWRjNFM2uw+My/WXkG1UwPcEavgC2FW2LWqxtk0Zw2YIAzErj5AWNM
         sxInfvB0Mqs+nz07jx73lIxju4VpdjKiX3jQqcObwUMIl9ikZgvv8yKD4hW42IPOz4Yc
         hILzShba+Py9+GQSYjiGZKkqzx8UHPs3VcNEbAm84TzQyTayydI0B4UxqLBxXh39hXuK
         l3hA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZMWBr8cy636gxWi601o2KiHLPG9sVG3eVG/hiy666XeC7OEwfPZRXZTEv1cpLKp7agk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuWF0LdYEHrIq4YScUp2PL3d/Kd11klFJR+2PB9VcSkTgQo1c
	OwUb1uVgA+ogplvavXkVQkLXczXjA39JW6+Mi7BivvHSLs35QaYBCp2RRCVjjV2uYlWIbfCobrF
	1dldBnkHUfVWJXVBSrQVed1LaxjbQyDfErQQNLRDkZQ==
X-Gm-Gg: AY/fxX4iVnSCSVtNgSgf/peFJq/PzeCGsfSykrKCVDcVvZlg7GIL1NiTpuCt+z+yGYW
	kgt4rQ1n14fWfC8GL68W7oJUZVx5WaGHUMYUCccxZ6YeT1IAOKxE/dtwaclvgTyCj/OsN6Ac4PZ
	u+O8JlL/eLWc96SW50rZ1sUo9oh77z+coJsF6pc1lQCkDB2IEcw4lN9kuYcu2b5RtwuJU6yhGBl
	C7g9LTfYLhlnzZiEvqO5WswzKNC6Oljrp5koKBBVvGf5nF09D1qH2Rjzrn+fAwvkUcpPU2m
X-Google-Smtp-Source: AGHT+IGKxYxFmhHMtm+wBFXt2ll1q27RjOYld/jjIcVyxoiCnmJ1kPO1gaVbLFEIbYTLLkk/DztxEfB9zCVskuKFEC4=
X-Received: by 2002:a05:7300:d209:b0:2ab:ca55:b76a with SMTP id
 5a478bee46e88-2ac05577c3emr914389eec.5.1765383118343; Wed, 10 Dec 2025
 08:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104162123.1086035-1-ming.lei@redhat.com> <20251104162123.1086035-4-ming.lei@redhat.com>
 <94f94f0e-7086-4f44-a658-9cb3b5496faf@samba.org> <aRW6LfJi63X7wbPm@fedora>
 <05a37623-c78c-4a86-a9f3-c78ce133fa66@samba.org> <aRabTk29_v6p92mY@fedora>
 <CADUfDZqpTSihuYnTqUbtctrX4OGT7Szr-_wWb4xLgg11RcwYkA@mail.gmail.com> <aTeStJ9_Tu0i5_wH@fedora>
In-Reply-To: <aTeStJ9_Tu0i5_wH@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 10 Dec 2025 08:11:46 -0800
X-Gm-Features: AQt7F2qawBEULt0VkGwLybDGkUm3A0y654dc70GPJ4Zwx0jMXbQ9a687ef3VI8E
Message-ID: <CADUfDZr=1XnrFCv9gRa4=Y9JMgOvMKROfgCf=e652QZvxv3hag@mail.gmail.com>
Subject: Re: [PATCH 3/5] io_uring: bpf: extend io_uring with bpf struct_ops
To: Ming Lei <ming.lei@redhat.com>
Cc: Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 7:08=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Dec 08, 2025 at 02:45:35PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Nov 13, 2025 at 7:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Nov 13, 2025 at 12:19:33PM +0100, Stefan Metzmacher wrote:
> > > > Am 13.11.25 um 11:59 schrieb Ming Lei:
> > > > > On Thu, Nov 13, 2025 at 11:32:56AM +0100, Stefan Metzmacher wrote=
:
> > > > > > Hi Ming,
> > > > > >
> > > > > > > io_uring can be extended with bpf struct_ops in the following=
 ways:
> > > > > > >
> > > > > > > 1) add new io_uring operation from application
> > > > > > > - one typical use case is for operating device zero-copy buff=
er, which
> > > > > > > belongs to kernel, and not visible or too expensive to export=
 to
> > > > > > > userspace, such as supporting copy data from this buffer to u=
serspace,
> > > > > > > decompressing data to zero-copy buffer in Android case[1][2],=
 or
> > > > > > > checksum/decrypting.
> > > > > > >
> > > > > > > [1] https://lpc.events/event/18/contributions/1710/attachment=
s/1440/3070/LPC2024_ublk_zero_copy.pdf
> > > > > > >
> > > > > > > 2) extend 64 byte SQE, since bpf map can be used to store IO =
data
> > > > > > >      conveniently
> > > > > > >
> > > > > > > 3) communicate in IO chain, since bpf map can be shared among=
 IOs,
> > > > > > > when one bpf IO is completed, data can be written to IO chain=
 wide
> > > > > > > bpf map, then the following bpf IO can retrieve the data from=
 this bpf
> > > > > > > map, this way is more flexible than io_uring built-in buffer
> > > > > > >
> > > > > > > 4) pretty handy to inject error for test purpose
> > > > > > >
> > > > > > > bpf struct_ops is one very handy way to attach bpf prog with =
kernel, and
> > > > > > > this patch simply wires existed io_uring operation callbacks =
with added
> > > > > > > uring bpf struct_ops, so application can define its own uring=
 bpf
> > > > > > > operations.
> > > > > >
> > > > > > This sounds useful to me.
> > > > > >
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > ---
> > > > > > >    include/uapi/linux/io_uring.h |   9 ++
> > > > > > >    io_uring/bpf.c                | 271 ++++++++++++++++++++++=
+++++++++++-
> > > > > > >    io_uring/io_uring.c           |   1 +
> > > > > > >    io_uring/io_uring.h           |   3 +-
> > > > > > >    io_uring/uring_bpf.h          |  30 ++++
> > > > > > >    5 files changed, 311 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/lin=
ux/io_uring.h
> > > > > > > index b8c49813b4e5..94d2050131ac 100644
> > > > > > > --- a/include/uapi/linux/io_uring.h
> > > > > > > +++ b/include/uapi/linux/io_uring.h
> > > > > > > @@ -74,6 +74,7 @@ struct io_uring_sqe {
> > > > > > >                 __u32           install_fd_flags;
> > > > > > >                 __u32           nop_flags;
> > > > > > >                 __u32           pipe_flags;
> > > > > > > +               __u32           bpf_op_flags;
> > > > > > >         };
> > > > > > >         __u64   user_data;      /* data to be passed back at =
completion time */
> > > > > > >         /* pack this to avoid bogus arm OABI complaints */
> > > > > > > @@ -427,6 +428,13 @@ enum io_uring_op {
> > > > > > >    #define IORING_RECVSEND_BUNDLE               (1U << 4)
> > > > > > >    #define IORING_SEND_VECTORIZED               (1U << 5)
> > > > > > > +/*
> > > > > > > + * sqe->bpf_op_flags           top 8bits is for storing bpf =
op
> > > > > > > + *                             The other 24bits are used for=
 bpf prog
> > > > > > > + */
> > > > > > > +#define IORING_BPF_OP_BITS     (8)
> > > > > > > +#define IORING_BPF_OP_SHIFT    (24)
> > > > > > > +
> > > > > > >    /*
> > > > > > >     * cqe.res for IORING_CQE_F_NOTIF if
> > > > > > >     * IORING_SEND_ZC_REPORT_USAGE was requested
> > > > > > > @@ -631,6 +639,7 @@ struct io_uring_params {
> > > > > > >    #define IORING_FEAT_MIN_TIMEOUT              (1U << 15)
> > > > > > >    #define IORING_FEAT_RW_ATTR          (1U << 16)
> > > > > > >    #define IORING_FEAT_NO_IOWAIT                (1U << 17)
> > > > > > > +#define IORING_FEAT_BPF                        (1U << 18)
> > > > > > >    /*
> > > > > > >     * io_uring_register(2) opcodes and arguments
> > > > > > > diff --git a/io_uring/bpf.c b/io_uring/bpf.c
> > > > > > > index bb1e37d1e804..8227be6d5a10 100644
> > > > > > > --- a/io_uring/bpf.c
> > > > > > > +++ b/io_uring/bpf.c
> > > > > > > @@ -4,28 +4,95 @@
> > > > > > >    #include <linux/kernel.h>
> > > > > > >    #include <linux/errno.h>
> > > > > > >    #include <uapi/linux/io_uring.h>
> > > > > > > +#include <linux/init.h>
> > > > > > > +#include <linux/types.h>
> > > > > > > +#include <linux/bpf_verifier.h>
> > > > > > > +#include <linux/bpf.h>
> > > > > > > +#include <linux/btf.h>
> > > > > > > +#include <linux/btf_ids.h>
> > > > > > > +#include <linux/filter.h>
> > > > > > >    #include "io_uring.h"
> > > > > > >    #include "uring_bpf.h"
> > > > > > > +#define MAX_BPF_OPS_COUNT      (1 << IORING_BPF_OP_BITS)
> > > > > > > +
> > > > > > >    static DEFINE_MUTEX(uring_bpf_ctx_lock);
> > > > > > >    static LIST_HEAD(uring_bpf_ctx_list);
> > > > > > > +DEFINE_STATIC_SRCU(uring_bpf_srcu);
> > > > > > > +static struct uring_bpf_ops bpf_ops[MAX_BPF_OPS_COUNT];
> > > > > >
> > > > > > This indicates to me that the whole system with all application=
s in all namespaces
> > > > > > need to coordinate in order to use these 256 ops?
> > > > >
> > > > > So far there is only 62 in-tree io_uring operation defined, I fee=
l 256
> > > > > should be enough.
> > > > >
> > > > > > I think in order to have something useful, this should be per
> > > > > > struct io_ring_ctx and each application should be able to load
> > > > > > its own bpf programs.
> > > > >
> > > > > per-ctx requirement looks reasonable, and it shouldn't be hard to
> > > > > support.
> > > > >
> > > > > >
> > > > > > Something that uses bpf_prog_get_type() based on a bpf_fd
> > > > > > like SIOCKCMATTACH in net/kcm/kcmsock.c.
> > > > >
> > > > > I considered per-ctx prog before, one drawback is the prog can't =
be shared
> > > > > among io_ring_ctx, which could waste memory. In my ublk case, the=
re can be
> > > > > lots of devices sharing same bpf prog.
> > > >
> > > > Can't the ublk instances coordinate and use the same bpf_fd?
> > > > new instances could request it via a unix socket and SCM_RIGHTS
> > > > from a long running loading process. On the other hand do they
> > > > really want to share?
> > >
> > > struct_ops is typically registered once, used everywhere, such as
> > > sched_ext and socket example.
> > >
> > > This patch follows this usage, so every io_uring application can acce=
ss it like the
> > > in-kernel operations.
> > >
> > > I can understand the requirement for per-io-ring-ctx struct_ops, whic=
h
> > > won't cause conflict among different applications.
> > >
> > > For example, ublk/raid5, there are 100 such devices, each device is c=
reated in dedicated
> > > process and uses its own io-uring, so 100 same struct_ops prog are re=
gistered in memory.
> > > Given struct_ops prog is registered as per-io-ring-ctx, it may not be=
 shared by `bpf_fd`, IMO.
> >
> > I agree with Stefan that a global IORING_OP_BPF op to BPF program
> > mapping will be difficult to coordinate between processes. For
> > example, consider two different ublk server programs that each want to
> > use a different BPF program. Ideally, each should be an independent
> > program and not need to know the op ids used by the other.
>
> Each processes can query free slots by checking `bpftool struc_ops`.

This seems like a time-of-check-to-time-of-use race condition, no? I
worry that a malicious process could exploit this by intentionally
trying to register IORING_OP_BPF programs concurrently with another
process checking for free slots and registering its own programs. If
the malicious process is able to register its program in the free slot
before the other process, it could trick the other process into
executing a malicious IORING_OP_BPF program instead of the intended
one, no?

>
> > On the other hand, a multithreaded process may have multiple
> > io_ring_ctxs and want to use the same IORING_OP_BPF ops with all of
> > them. So a process-level mapping seems to make the most sense. And
> > that's exactly the mapping level that we would get from using the BPF
> > program file descriptor to specify the IORING_OP_BPF op. Additionally,
> > as Stefan points out, the IORING_OP_BPF program could be shared with
> > another process by sending the file descriptor using SCM_RIGHTS. And
>
> io_uring FD doesn't support SCM_RIGHTS.

I (and I assume Stefan) were referring to the BPF program file
descriptor, not the io_uring one.

>
> If one privileged process sends bpf prog FD via SCM_RIGHTS, that means
> this privileged process may be allowed to register any IORING_OP_BPF prog=
ram,
> sounds like `CONFIG_BPF_UNPRIV_DEFAULT_OFF =3D=3D n`. Probably it is fine
> if we just expose 'struct uring_bpf_data' and not expose `struct io_kiocb=
`
> to bpf prog.
>
> Another ways is to register global struct_ops prog in the following way:
>
> - the 1st 256 progs are stored in plain array, which can be for really
>   global/generic progs
>
> - the others(256 ~ 65535) progs are stored in xarray, processes can looku=
p
>   free slots and use them in dynamic allocation way.

Why do you feel a separate xarray for IORING_OP_BPF programs is
needed? It seems to me like a process's file descriptor table already
serves this purpose well.

>
> I'd suggest to start with global register, which is easy to use, and exte=
nd
> to per-uring-ctx struct_ops in future.

But as soon as global IORING_OP_BPF program opcodes are supported,
they become a part of the UAPI. That will make it difficult to remove
them in the future. So I would prefer to pin down this core aspect of
the UAPI when this feature is merged initially.

Thanks,
Caleb

