Return-Path: <bpf+bounces-18088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E4815874
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0291C24B2C
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555901400F;
	Sat, 16 Dec 2023 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVanJUzL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39371B649
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso6629a12.0
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702716619; x=1703321419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjpNsyY+/dKvE19F78O5BhZxciIlDogxltpO7mUYXXY=;
        b=kVanJUzLjh81S8wo9+s15XdcxFrSIEA1ytS7ljWUuQaoNWRgGDiEW1wqCGolY9ezOd
         Wc0gJm1NhDCHYkvtLTfHZ0CfXllF2TMjt/nAEy37cDOMMgJawqoE1QnsDxrbi7xGKMyk
         nqT8mjULJ3sIxWd3/7oFu4jNKWVwCzmyffiSiQiwnngCVXRJrugkITeudXmp/Q44SKai
         Dpmh3K1EF9ff9FIRoRf8RmcpQXXDIt/KYecg5l3F5em4x3ZrDNmM6WU4XQa1gUtV8+Md
         l5f2jPq2mM3Wl2mfipv1XYRDUzZga1lMJkMagdMICB3EE9j8E2BEVdhYRTf02IdcG8Vp
         CQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702716619; x=1703321419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjpNsyY+/dKvE19F78O5BhZxciIlDogxltpO7mUYXXY=;
        b=Dad7/z8eXnxtWkshM7WWF7aHDAlSPReY1+gAt7Fj0dev6xL9iJkmZQzF8jg59usWS7
         fWpWIE9PBh8o1haJvcai2RhT816caB3lsWEw8QXfv60KfYp8+ZJ65mMvZR/774hHfbQL
         xJyU5YoBgRWB9wPh8zVQ3SMUBrj4AKhH2YGt3StOoLwI2X+u92xVED2NiZxML1tTTqRl
         +Z4ZosEC4wZ36yHXIafkRdmInVVY9g4IIKyyC3V5thDujC4tHRuzLCPuR0N5669GP39w
         RVihT1U//s2A6ws0H5HwKAHArAN9GkNGxdPjb9buLxqvRzqt8yEqON4AyuapdPZtIj4r
         2gNw==
X-Gm-Message-State: AOJu0YwCjDBEpvQqejUDALlT3QarzV1FbAjGp5jvwCZT52mBjsE9//iR
	L5WQTagUjn+kqhGxkL0APOOtWLXC4gNQciXJwcSjobT95JwZ
X-Google-Smtp-Source: AGHT+IGAImrxobxctMCu02dOUFBlS4+j0vXCsD4tJTFdYBL5SQyCDCCMcwaQJpm4+jjoldK1A6mDbalGhIGqtwFcP1I=
X-Received: by 2002:a50:8d15:0:b0:54b:321:ef1a with SMTP id
 s21-20020a508d15000000b0054b0321ef1amr93929eds.6.1702716619123; Sat, 16 Dec
 2023 00:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com> <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com> <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
 <23bcab0e-bec1-4edd-b45a-0142ebcda41a@linux.alibaba.com> <CAEf4BzYBqwDQ8LeyrQSOh+G8eofy1mN=j=DVrj5DkYovFW64Jw@mail.gmail.com>
In-Reply-To: <CAEf4BzYBqwDQ8LeyrQSOh+G8eofy1mN=j=DVrj5DkYovFW64Jw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 16 Dec 2023 09:50:06 +0100
Message-ID: <CACT4Y+bb7DuQXQ=-PRO4FteRz_4OLsRw0tXFKqNiOoT6UOFLaA@mail.gmail.com>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with overwriting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, 
	guwen@linux.alibaba.com, alibuda@linux.alibaba.com, hengqi@linux.alibaba.com, 
	Nathan Slingerland <slinger@meta.com>, "rihams@meta.com" <rihams@meta.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 at 23:39, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
> > On 2023/12/14 07:35, Andrii Nakryiko wrote:
> > > On Mon, Dec 11, 2023 at 4:39=E2=80=AFAM Philo Lu <lulie@linux.alibaba=
.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2023/12/9 06:32, Andrii Nakryiko wrote:
> > >>> On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> > >>>>
> > >>>> On 07/12/2023 13:15, Philo Lu wrote:
> > >>>>> Hi all. I have a question when using perfbuf/ringbuf in bpf. I wi=
ll
> > >>>>> appreciate it if you give me any advice.
> > >>>>>
> > >>>>> Imagine a simple case: the bpf program output a log (some tcp
> > >>>>> statistics) to user every time a packet is received, and the user
> > >>>>> actively read the logs if he wants. I do not want to keep a user =
process
> > >>>>> alive, waiting for outputs of the buffer. User can read the buffe=
r as
> > >>>>> need. BTW, the order does not matter.
> > >>>>>
> > >>>>> To conclude, I hope the buffer performs like relayfs: (1) no need=
 for
> > >>>>> user process to receive logs, and the user may read at any time (=
and no
> > >>>>> wakeup would be better); (2) old data can be overwritten by new o=
nes.
> > >>>>>
> > >>>>> Currently, it seems that perfbuf and ringbuf cannot satisfy both:=
 (i)
> > >>>>> ringbuf: only satisfies (1). However, if data arrive when the buf=
fer is
> > >>>>> full, the new data will be lost, until the buffer is consumed. (i=
i)
> > >>>>> perfbuf: only satisfies (2). But user cannot access the buffer af=
ter the
> > >>>>> process who creates it (including perf_event.rb via mmap) exits.
> > >>>>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> > >>>>> perf_events, but I do not know how to get the buffer again in a n=
ew
> > >>>>> process.
> > >>>>>
> > >>>>> In my opinion, this can be solved by either of the following: (a)=
 add
> > >>>>> overwrite support in ringbuf (maybe a new flag for reserve), but =
we have
> > >>>>> to address synchronization between kernel and user, especially un=
der
> > >>>>> variable data size, because when overwriting occurs, kernel has t=
o
> > >>>>> update the consumer posi too; (b) implement map_fd_sys_lookup_ele=
m for
> > >>>>> perfbuf to expose fds to user via map_lookup_elem syscall, and a
> > >>>>> mechanism is need to preserve perf_event->rb when process exits
> > >>>>> (otherwise the buffer will be freed by perf_mmap_close). I am not=
 sure
> > >>>>> if they are feasible, and which is better. If not, perhaps we can
> > >>>>> develop another mechanism to achieve this?
> > >>>>>
> > >>>>
> > >>>> There was an RFC a while back focused on supporting BPF ringbuf
> > >>>> over-writing [1]; at the time, Andrii noted some potential issues =
that
> > >>>> might be exposed by doing multiple ringbuf reserves to overfill th=
e
> > >>>> buffer within the same program.
> > >>>>
> > >>>
> > >>> Correct. I don't think it's possible to correctly and safely suppor=
t
> > >>> overwriting with BPF ringbuf that has variable-sized elements.
> > >>>
> > >>> We'll need to implement MPMC ringbuf (probably with fixed sized
> > >>> element size) to be able to support this.
> > >>>
> > >>
> > >> Thank you very much!
> > >>
> > >> If it is indeed difficult with ringbuf, maybe I can implement a new =
type
> > >> of bpf map based on relay interface [1]? e.g., init relay during map
> > >> creating, write into it with bpf helper, and then user can access to=
 it
> > >> in filesystem. I think it will be a simple but useful map for
> > >> overwritable data transfer.
> > >
> > > I don't know much about relay, tbh. Give it a try, I guess.
> > > Alternatively, we need better and faster implementation of
> > > BPF_MAP_TYPE_QUEUE, which seems like the data structure that can
> > > support overwriting and generally be a fixed elementa size
> > > alternative/complement to BPF ringbuf.
> > >
> >
> > Thank you for your reply. I am afraid BPF_MAP_TYPE_QUEUE cannot get rid
> > of locking overheads with concurrent reading and writing by design, and
>
> I disagree, I think [0] from Dmitry Vyukov is one way to implement
> lock-free BPF_MAP_TYPE_QUEUE. I don't know how easy it would be to
> implement overwriting support, but it would be worth considering.
>
>   [0] https://www.1024cores.net/home/lock-free-algorithms/queues/bounded-=
mpmc-queue


I am missing some context here. But note that this queue is not
formally lock-free. While it's usually faster and more scalable than
mutex-protected queues, stuck readers and writers will eventually
block each other. Stucking for a short time is not a problem because
the queue allows parallelism for both readers and writers. But if
threads get stuck for a long time and the queue wraps around so that
writers try to write to elements being read/written by slow threads,
they block. Similarly, readers get blocked by slow writers even if
there are other fully written elements in the queue already.
The queue is not serializable either, which may be surprisable in some case=
s.

Adding overwriting support may be an interesting exercise.
I guess readers could use some variation of a seqlock to deal with
elements that are being overwritten.
Writers can already skip over other slow writers. Normally this is
used w/o wrap-around, but I suspect it can just work with wrap-around
as well (a writer can skip over a writer stuck on the previous lap).
Since we overwrite elements, the queue provides only a very weak
notion of FIFO anyway, so skipping over very old writers may be fine.

