Return-Path: <bpf+bounces-18051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402F8153D6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216C41C23250
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F0199C2;
	Fri, 15 Dec 2023 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlq0OBaz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9018ED8
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55193d5e8cdso1390761a12.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 14:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702679961; x=1703284761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJIRgALtyoWUfCUQBDX8zPjiI5uj832KhlzRV2lZRCU=;
        b=hlq0OBazraZ5bkoRRQiHDjkf+ktAALJTxidWARchG43eKUajghghqUzVhDiXjMhSv9
         lNrvR0isQRK5tK9l6xxYiVh5Bw3O/GfPzxY6IeVrDVyVQC+aqWB+DvkvzjcH8Yag5F04
         XLK1nz+rQ2KHx8ARku24rZ0lfng5pr9N3iderACHE8v8mSAYptX+pzVM55c1l0z3RntZ
         wJhfHPOAhtCmizijUHfUDptx7cLnEbNbULArwfy7i026dcxv41HBQl2zT2CgFlTgaSAS
         +j5IaCJncZoXuYJTL3rrxHa5Z1L4OB+SxyIrdN6I5MnaQSSUPTj1rQ2k2ThVlnnjGqTY
         xHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702679961; x=1703284761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJIRgALtyoWUfCUQBDX8zPjiI5uj832KhlzRV2lZRCU=;
        b=GhlxhimRmH0DzSN66dXwIKK1N0BsAJ2qw/1X1iPFdQYSRkhaYNURTwfJ9F4s8IYI5L
         ooqFcZED73VYw7vbbmz2ygVNC5D6Mc3pRuPBfzk0r8E8Fj1OP8yt0Skmz+Ea7iQqE5q7
         MSLA5YFZGaA9fR9+RFHatMGyohknwpxHtvWH5hIrZYx8rAtEr5Qs9Q1kDZDmWjHY2UpR
         UyAayqwjQ6HsIKakEpktBvnMDO7QkfibXKk0+CMbz+rZupawW9v3Xbjo/vt7+6B4jTHI
         lY10Ikb0mxjA3iMZMfo/0WMiHQ4YxVYIjT3IllfNqPCpSYkzFVi0loMYhHVpGu3Bj0km
         o3/g==
X-Gm-Message-State: AOJu0YyWXBP2nMHaNbansp3FkKkFqj9Q/6Stm9j1Iav/Hp27LeS32QdP
	VgEkpcHxyvfcas6/KEypwvZcRJ6pr/ECH/gS9Zs=
X-Google-Smtp-Source: AGHT+IFnZimnLbXJ7dxgZwGvnDABkvNMO3CgmjlzFAw1Q+VIpIi/ex606lfLbJhC0ISalu7u4wnuTry1QpVOo3Mqp8w=
X-Received: by 2002:a50:d5d6:0:b0:551:cff9:dae3 with SMTP id
 g22-20020a50d5d6000000b00551cff9dae3mr3452202edj.72.1702679960605; Fri, 15
 Dec 2023 14:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com> <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com> <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
 <23bcab0e-bec1-4edd-b45a-0142ebcda41a@linux.alibaba.com>
In-Reply-To: <23bcab0e-bec1-4edd-b45a-0142ebcda41a@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Dec 2023 14:39:07 -0800
Message-ID: <CAEf4BzYBqwDQ8LeyrQSOh+G8eofy1mN=j=DVrj5DkYovFW64Jw@mail.gmail.com>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with overwriting
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, song@kernel.org, andrii@kernel.org, ast@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, xuanzhuo@linux.alibaba.com, 
	dust.li@linux.alibaba.com, guwen@linux.alibaba.com, alibuda@linux.alibaba.com, 
	hengqi@linux.alibaba.com, Nathan Slingerland <slinger@meta.com>, 
	"rihams@meta.com" <rihams@meta.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 2:10=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
>
>
> On 2023/12/14 07:35, Andrii Nakryiko wrote:
> > On Mon, Dec 11, 2023 at 4:39=E2=80=AFAM Philo Lu <lulie@linux.alibaba.c=
om> wrote:
> >>
> >>
> >>
> >> On 2023/12/9 06:32, Andrii Nakryiko wrote:
> >>> On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>>>
> >>>> On 07/12/2023 13:15, Philo Lu wrote:
> >>>>> Hi all. I have a question when using perfbuf/ringbuf in bpf. I will
> >>>>> appreciate it if you give me any advice.
> >>>>>
> >>>>> Imagine a simple case: the bpf program output a log (some tcp
> >>>>> statistics) to user every time a packet is received, and the user
> >>>>> actively read the logs if he wants. I do not want to keep a user pr=
ocess
> >>>>> alive, waiting for outputs of the buffer. User can read the buffer =
as
> >>>>> need. BTW, the order does not matter.
> >>>>>
> >>>>> To conclude, I hope the buffer performs like relayfs: (1) no need f=
or
> >>>>> user process to receive logs, and the user may read at any time (an=
d no
> >>>>> wakeup would be better); (2) old data can be overwritten by new one=
s.
> >>>>>
> >>>>> Currently, it seems that perfbuf and ringbuf cannot satisfy both: (=
i)
> >>>>> ringbuf: only satisfies (1). However, if data arrive when the buffe=
r is
> >>>>> full, the new data will be lost, until the buffer is consumed. (ii)
> >>>>> perfbuf: only satisfies (2). But user cannot access the buffer afte=
r the
> >>>>> process who creates it (including perf_event.rb via mmap) exits.
> >>>>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> >>>>> perf_events, but I do not know how to get the buffer again in a new
> >>>>> process.
> >>>>>
> >>>>> In my opinion, this can be solved by either of the following: (a) a=
dd
> >>>>> overwrite support in ringbuf (maybe a new flag for reserve), but we=
 have
> >>>>> to address synchronization between kernel and user, especially unde=
r
> >>>>> variable data size, because when overwriting occurs, kernel has to
> >>>>> update the consumer posi too; (b) implement map_fd_sys_lookup_elem =
for
> >>>>> perfbuf to expose fds to user via map_lookup_elem syscall, and a
> >>>>> mechanism is need to preserve perf_event->rb when process exits
> >>>>> (otherwise the buffer will be freed by perf_mmap_close). I am not s=
ure
> >>>>> if they are feasible, and which is better. If not, perhaps we can
> >>>>> develop another mechanism to achieve this?
> >>>>>
> >>>>
> >>>> There was an RFC a while back focused on supporting BPF ringbuf
> >>>> over-writing [1]; at the time, Andrii noted some potential issues th=
at
> >>>> might be exposed by doing multiple ringbuf reserves to overfill the
> >>>> buffer within the same program.
> >>>>
> >>>
> >>> Correct. I don't think it's possible to correctly and safely support
> >>> overwriting with BPF ringbuf that has variable-sized elements.
> >>>
> >>> We'll need to implement MPMC ringbuf (probably with fixed sized
> >>> element size) to be able to support this.
> >>>
> >>
> >> Thank you very much!
> >>
> >> If it is indeed difficult with ringbuf, maybe I can implement a new ty=
pe
> >> of bpf map based on relay interface [1]? e.g., init relay during map
> >> creating, write into it with bpf helper, and then user can access to i=
t
> >> in filesystem. I think it will be a simple but useful map for
> >> overwritable data transfer.
> >
> > I don't know much about relay, tbh. Give it a try, I guess.
> > Alternatively, we need better and faster implementation of
> > BPF_MAP_TYPE_QUEUE, which seems like the data structure that can
> > support overwriting and generally be a fixed elementa size
> > alternative/complement to BPF ringbuf.
> >
>
> Thank you for your reply. I am afraid BPF_MAP_TYPE_QUEUE cannot get rid
> of locking overheads with concurrent reading and writing by design, and

I disagree, I think [0] from Dmitry Vyukov is one way to implement
lock-free BPF_MAP_TYPE_QUEUE. I don't know how easy it would be to
implement overwriting support, but it would be worth considering.

  [0] https://www.1024cores.net/home/lock-free-algorithms/queues/bounded-mp=
mc-queue



> a lockless buffer like relay fits better to our case. So I will try it :)
>
> >>
> >> [1]
> >> https://github.com/torvalds/linux/blob/master/Documentation/filesystem=
s/relay.rst
> >>
> >>>> Alan
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/lkml/20220906195656.33021-2-flaniel@linux.mi=
crosoft.com/

