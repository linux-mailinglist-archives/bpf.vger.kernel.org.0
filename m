Return-Path: <bpf+bounces-18337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94F8190AC
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838D4283415
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184E38FA8;
	Tue, 19 Dec 2023 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XplsuUiO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034F38F87
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so6787a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703013915; x=1703618715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5XHQNu3BkvS320rJdf94Cudz3uzhMbm3BC0Mk11iD8=;
        b=XplsuUiOIg0Se4CqUA3mYNOu3DPTeZ7ayDissN+T0lXnUWedNsrpGIccAKA+L3PhVv
         Ii2OfIrYA5jiIW6bH0+Zj3xPOySd0q7RFgpoV7AsQSeWhGeuE+e2j8KZZhmqv3NObTL6
         C7ukAoCjBsYnl2JqVCi1k69WsQvIQ52qWc7KOun+XlAbR5JVcTPE2aybbvMpV59q5Pxb
         uiQo2mbYfDDII61BzQoAYHFGEtDM3Bk6gZfxk6ae/pAGnZGVRAlTtdh6VAfUIYOdkQx/
         6Xch6sHwk8v3HvTUPVR/P5GlmCqi7D5Wukj3PnXat0vFtPF7thSKTzOczaKYogIOon8J
         yWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013915; x=1703618715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5XHQNu3BkvS320rJdf94Cudz3uzhMbm3BC0Mk11iD8=;
        b=lptLLe/0yMw8LSvLsD1jUGmLqeC8UxiCyKKAShQlhlTfuyd+AQMyEHewyhZBplJ0mr
         muWuPEp+035mKQph0zIoQs5BnOn1jW9P5zRDiiNgg/JJi7j47ThdW5MmALV+EFTfDLAo
         wMGY38dP/E2fq1bIuqrIlWhnic6qXgC6nhWXSKbisyITZwTMT0FYcK/NRY9VdjV0jKZZ
         /XIWL6PQ1Ip6mIgMS8V8TcddX6gLUeJtdPYYQ0Z0VgI50Zks1OJ1AXk8PN8wZOc3j7nV
         KcX57OKI59z/OKejjLhFlVOswcAMvlvY4Gw0tcJlJe8PZxahEPyWYopDwpZUekH+frwY
         w4eg==
X-Gm-Message-State: AOJu0YxBbEmc+P3lg7724JDzsS+NiP5Z8KVNPC/35G1tEqG9BNXsJz7O
	ETHI4Sf3DhWhsWp/CgsLMzgmTtvSjCbNQgKrSg8=
X-Google-Smtp-Source: AGHT+IHLdmn349AODx3MWmuKZpfeLaxrqFhU90DBAqG8TUDC6ie5pqGLSLQ6P+VLdswwoByuZrxtcuStTTT9t6SLx5g=
X-Received: by 2002:a50:ba86:0:b0:552:d75b:c6d9 with SMTP id
 x6-20020a50ba86000000b00552d75bc6d9mr1550156ede.7.1703013915539; Tue, 19 Dec
 2023 11:25:15 -0800 (PST)
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
 <CACT4Y+bb7DuQXQ=-PRO4FteRz_4OLsRw0tXFKqNiOoT6UOFLaA@mail.gmail.com>
In-Reply-To: <CACT4Y+bb7DuQXQ=-PRO4FteRz_4OLsRw0tXFKqNiOoT6UOFLaA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 11:25:03 -0800
Message-ID: <CAEf4BzZ6mUkFgRCaa-KCHH=hRdEDj+A5ZSjewiwVF6c4Jcd54A@mail.gmail.com>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with overwriting
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com, 
	guwen@linux.alibaba.com, alibuda@linux.alibaba.com, hengqi@linux.alibaba.com, 
	Nathan Slingerland <slinger@meta.com>, "rihams@meta.com" <rihams@meta.com>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 12:50=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> On Fri, 15 Dec 2023 at 23:39, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> > > On 2023/12/14 07:35, Andrii Nakryiko wrote:
> > > > On Mon, Dec 11, 2023 at 4:39=E2=80=AFAM Philo Lu <lulie@linux.aliba=
ba.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2023/12/9 06:32, Andrii Nakryiko wrote:
> > > >>> On Thu, Dec 7, 2023 at 6:49=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> > > >>>>
> > > >>>> On 07/12/2023 13:15, Philo Lu wrote:
> > > >>>>> Hi all. I have a question when using perfbuf/ringbuf in bpf. I =
will
> > > >>>>> appreciate it if you give me any advice.
> > > >>>>>
> > > >>>>> Imagine a simple case: the bpf program output a log (some tcp
> > > >>>>> statistics) to user every time a packet is received, and the us=
er
> > > >>>>> actively read the logs if he wants. I do not want to keep a use=
r process
> > > >>>>> alive, waiting for outputs of the buffer. User can read the buf=
fer as
> > > >>>>> need. BTW, the order does not matter.
> > > >>>>>
> > > >>>>> To conclude, I hope the buffer performs like relayfs: (1) no ne=
ed for
> > > >>>>> user process to receive logs, and the user may read at any time=
 (and no
> > > >>>>> wakeup would be better); (2) old data can be overwritten by new=
 ones.
> > > >>>>>
> > > >>>>> Currently, it seems that perfbuf and ringbuf cannot satisfy bot=
h: (i)
> > > >>>>> ringbuf: only satisfies (1). However, if data arrive when the b=
uffer is
> > > >>>>> full, the new data will be lost, until the buffer is consumed. =
(ii)
> > > >>>>> perfbuf: only satisfies (2). But user cannot access the buffer =
after the
> > > >>>>> process who creates it (including perf_event.rb via mmap) exits=
.
> > > >>>>> Specifically, I can use BPF_F_PRESERVE_ELEMS flag to keep the
> > > >>>>> perf_events, but I do not know how to get the buffer again in a=
 new
> > > >>>>> process.
> > > >>>>>
> > > >>>>> In my opinion, this can be solved by either of the following: (=
a) add
> > > >>>>> overwrite support in ringbuf (maybe a new flag for reserve), bu=
t we have
> > > >>>>> to address synchronization between kernel and user, especially =
under
> > > >>>>> variable data size, because when overwriting occurs, kernel has=
 to
> > > >>>>> update the consumer posi too; (b) implement map_fd_sys_lookup_e=
lem for
> > > >>>>> perfbuf to expose fds to user via map_lookup_elem syscall, and =
a
> > > >>>>> mechanism is need to preserve perf_event->rb when process exits
> > > >>>>> (otherwise the buffer will be freed by perf_mmap_close). I am n=
ot sure
> > > >>>>> if they are feasible, and which is better. If not, perhaps we c=
an
> > > >>>>> develop another mechanism to achieve this?
> > > >>>>>
> > > >>>>
> > > >>>> There was an RFC a while back focused on supporting BPF ringbuf
> > > >>>> over-writing [1]; at the time, Andrii noted some potential issue=
s that
> > > >>>> might be exposed by doing multiple ringbuf reserves to overfill =
the
> > > >>>> buffer within the same program.
> > > >>>>
> > > >>>
> > > >>> Correct. I don't think it's possible to correctly and safely supp=
ort
> > > >>> overwriting with BPF ringbuf that has variable-sized elements.
> > > >>>
> > > >>> We'll need to implement MPMC ringbuf (probably with fixed sized
> > > >>> element size) to be able to support this.
> > > >>>
> > > >>
> > > >> Thank you very much!
> > > >>
> > > >> If it is indeed difficult with ringbuf, maybe I can implement a ne=
w type
> > > >> of bpf map based on relay interface [1]? e.g., init relay during m=
ap
> > > >> creating, write into it with bpf helper, and then user can access =
to it
> > > >> in filesystem. I think it will be a simple but useful map for
> > > >> overwritable data transfer.
> > > >
> > > > I don't know much about relay, tbh. Give it a try, I guess.
> > > > Alternatively, we need better and faster implementation of
> > > > BPF_MAP_TYPE_QUEUE, which seems like the data structure that can
> > > > support overwriting and generally be a fixed elementa size
> > > > alternative/complement to BPF ringbuf.
> > > >
> > >
> > > Thank you for your reply. I am afraid BPF_MAP_TYPE_QUEUE cannot get r=
id
> > > of locking overheads with concurrent reading and writing by design, a=
nd
> >
> > I disagree, I think [0] from Dmitry Vyukov is one way to implement
> > lock-free BPF_MAP_TYPE_QUEUE. I don't know how easy it would be to
> > implement overwriting support, but it would be worth considering.
> >
> >   [0] https://www.1024cores.net/home/lock-free-algorithms/queues/bounde=
d-mpmc-queue
>
>
> I am missing some context here. But note that this queue is not
> formally lock-free. While it's usually faster and more scalable than
> mutex-protected queues, stuck readers and writers will eventually
> block each other. Stucking for a short time is not a problem because
> the queue allows parallelism for both readers and writers. But if
> threads get stuck for a long time and the queue wraps around so that
> writers try to write to elements being read/written by slow threads,
> they block. Similarly, readers get blocked by slow writers even if
> there are other fully written elements in the queue already.
> The queue is not serializable either, which may be surprisable in some ca=
ses.

Thanks for additional insights, Dmitry!

In our case producers will be either BPF programs or done by bpf()
syscall in the kernel, so the expectation is that they will be fast
and will be guaranteed to run to completion. (We can decide whether
sleepable/faultable BPF programs should be allowed to work with this
QUEUE or not). For consuming, the main target is probably user-space,
and probably we'd want to be able to do this without a syscall through
mmaping. If the user is slow, on the producer side we can perhaps just
fail to enqueue a new element (not sure how easy it is to tell "slow
consumer" vs "no consumer, we are full"?)

Anyways, I think it's an interesting algorithm, I stumbled upon it a
while ago and was always curious how it would fit BPF use cases :)

>
> Adding overwriting support may be an interesting exercise.
> I guess readers could use some variation of a seqlock to deal with
> elements that are being overwritten.

One way I was thinking would be to remember sequence number before
reading data, read data, and then re-read sequence number. If it
changed, user can discard because data was modified. If not, then we
have a guarantee that data was intact for the entire duration of the
read operation.

> Writers can already skip over other slow writers. Normally this is
> used w/o wrap-around, but I suspect it can just work with wrap-around
> as well (a writer can skip over a writer stuck on the previous lap).
> Since we overwrite elements, the queue provides only a very weak
> notion of FIFO anyway, so skipping over very old writers may be fine.

Exactly, it's not really FIFO (so perhaps literally retrofitting it
into BPF_MAP_TYPE_QUEUE might not be the best idea, maybe it would be
a new map type), so overwriting is like some consumer quickly consumed
(and discarded) an element, and then wrote over it some new
information. That was how my thinking went.

The devil is in details and fitting all this end-to-end into BPF
subsystem, of course.

