Return-Path: <bpf+bounces-75620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02BC8C6F4
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 01:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1983B51CD
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A4223710;
	Thu, 27 Nov 2025 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="WCDHH79u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5941E9B0B
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204027; cv=none; b=EKXaFijTT/gHKNToXzBWrcmCBHq54UFC2VbEwT66ERAUWtffclwA+TIW0Uod554XES8HtUWAN2ylPVPDZfBZbPwrSRUAYh3/4xWcMnKjUfmZqSIOTZTYxkRfC+548GFxDq6HFlG+5ZesfCHUV/4RpGpgho03lJpZH1CLCYpajFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204027; c=relaxed/simple;
	bh=0bVuq3V7XJzDyRApg9JRSdfX/218CmJh+l2f4CAy6So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFwik+Y/s2exYuV0TPTCVNTmqoF71EAKRpiulI+eEEQfCW7e5EtKlj+Pp7PnsqHS945jSIw6k6VXfJdK7WzoVDwnn2JF0hjNXWctXRuedmXCVO2zBhS/TM06WZnQ/wNBLAuKcraDKA5CNbfL/PCQ7YUEHzlwhp/R3o+0UA3ujHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=WCDHH79u; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so237024a91.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 16:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1764204022; x=1764808822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXdpxRmEPHEN5z+LzpGVR59roRbw6+cEm2/8oVDVB1s=;
        b=WCDHH79u0bi/Lt/fB7QWHeO8JUVXBIco6Olc2F9x9Lo8cOpFjmx5g45wPhhYjEuvdw
         Vyra8eiAtsUmHFLkt2EjaWF4VvjRvBfnFxiBYbgSCu+ksmYCUOq01tWLCUwIF3n/gi+e
         UFWMTylaAJk/ILzvbekJgGNMesG0NW/du58kAWmJp0y05rVfXmW+0YqrpxQS9Tj7/lrj
         XuQhlZTq/j2AIOchBoE7vF0iUgctgLzezfXCA8ycB/VNZ6TesKnm2zJW8GQeg9kw7B6t
         a/w1GzKarSlYJRhfSju6asLvABMhYYq4sAsqOsHM0iifLbKjumPnccskdJAF3NUbf4V2
         Grtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764204022; x=1764808822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SXdpxRmEPHEN5z+LzpGVR59roRbw6+cEm2/8oVDVB1s=;
        b=uF5bjUzCy7q2o8RZWCEzQ3Y9qsAsE99OfmKb/e8cHGhA5cX28LJDZl8ItYdgUlei6n
         zipyEVD4bfGAd+9htGJqIasFXgvJqvAsEhHvi4hei8l8ELoz6zJC3oVCtNWofSeRjVHV
         wMZmndavqZFILg/wuoA5CjLpnXWXQEir/df820FzPDCz6ewhExrecFHyQO2xI80txpRE
         ///ZJfpRgPrK00GjRYBqHcbHEj49U27cg5vN5zUV8oSBXkVlxhb0Wlfrf9Lmtc/9h/Tb
         mjVvhnUC1Dhi7/ul50nqIbLnCNVg5NHZn87++tFcVX+v8HHIKVZrjGDQdd8xEE87d04l
         8u2w==
X-Forwarded-Encrypted: i=1; AJvYcCV+CIjBXmbzsDUK2lgUA8FuXPOX9eyeBJa63beAvI8PyDHpH2UXjHw9F6ltO7HmiHZCO20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJsrG8r8LbZuiz3WA1xFrYYhUwd7samS7tR85+BpPzrpAFlSc
	i7WgnMn+yl8NQdKgV00LqKOKIWwdtVIfMnWFTHXhqeNVttNV4emdXXDpDus1sgjjD2nDJcao4RM
	SI3b45mbH2g5575KrtaQsgAphNqMfbHLhjQOLoi8rDw==
X-Gm-Gg: ASbGncuAwlyzdpuW7HeJrbIXU0bMNuLUOefk8cqsSzRKcra8JE5aAztmKlM+19MKktO
	xIxc2rbzSHfxm0s4Afimc8hM3eEvO3ZqzFw/p8XWQRZUVV9xs+qo0oMBtnzna3RtOJHgzC7v2zu
	7w21Q83XOem2tJMQHJTP9ITOq8qhJeySBX4dnN1LEVRnkpS3McpuY+DonGbzcGn9ESWygTULibW
	8Vb1HjyBN74jE+HlRa3eADOOCWDyg4BiZ/Lfx9VknoWNQFvyouOCGguVtUfw5vxzlTjusvp
X-Google-Smtp-Source: AGHT+IHdFJOgBuvMVpvAstJIOluup31S11jh2iE+g+vdm9gI4TbYbvOOSF1eQeylxk4mKp1l/FPmE2HQVLJUwgFvG3k=
X-Received: by 2002:a17:90b:1f82:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-3475ed51781mr8334242a91.20.1764204021563; Wed, 26 Nov 2025
 16:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
 <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
 <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com>
 <CAADnVQ+DycJQ7eW_FDE59Qc1SzJseYy2f8yniqh0C354ruLdCw@mail.gmail.com>
 <CAH6OuBRtCyRhvn4E3yQSqpynoqRiB+sYbiZP1ATqXE4LQDTQmA@mail.gmail.com>
 <CAP01T776rsC_aNF4AijRGDqZRfmeKDbSfFmGYPTYh+zaOuwrWw@mail.gmail.com>
 <CAH6OuBQ3UY7AHHp1ZMacMO6zq4YFsi=ycqE_FPSZGBm0FRnuVg@mail.gmail.com>
 <CAADnVQ+F8v3f+aOJG6AsV9EO+Mp=-uY4OzigNR6jh=SoT+KTFA@mail.gmail.com> <CAP01T77z4h2QhQxgDxLPxzGZVase3xPSqSHq0v_3VWK5sjvqqw@mail.gmail.com>
In-Reply-To: <CAP01T77z4h2QhQxgDxLPxzGZVase3xPSqSHq0v_3VWK5sjvqqw@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Thu, 27 Nov 2025 01:40:10 +0100
X-Gm-Features: AWmQ_bkR6-O5G13hptvXofdWatf01RraJ2oZXT4fU2QX9tsem98pCR1IrE0LwR8
Message-ID: <CAH6OuBQXcKsVDnFAY_8sKF6snsMurV_KkmmyeKb0dxFOjhfF=w@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:41=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 24 Nov 2025 at 19:45, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 20, 2025 at 1:46=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > <ritesh@superluminal.eu> wrote:
> > >
> > > On Mon, Nov 17, 2025 at 4:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Sun, 16 Nov 2025 at 15:11, Ritesh Oedayrajsingh Varma
> > > > <ritesh@superluminal.eu> wrote:
> > > > >
> > > > > On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Va=
rma
> > > > > > <ritesh@superluminal.eu> wrote:
> > > > > > >
> > > > > > > Hi Alexei,
> > > > > > >
> > > > > > > Thanks for the info! I wasn't aware of that fix, but I just c=
hecked,
> > > > > > > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x8=
6_64.
> > > > > > >
> > > > > > > I just installed the kernel sources locally to make sure, and=
 the code
> > > > > > > for rqspinlock matches that of the commit you linked (i.e. th=
e
> > > > > > > is_nmi() check added in the commit is there). The code for th=
e related
> > > > > > > commit  164c246 ("rqspinlock: Protect waiters in queue from s=
talls")
> > > > > > > is also present. You can verify this yourself on Fedora's 6.1=
7.1 git
> > > > > > > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel=
-6.17.1-1/kernel/bpf/rqspinlock.c#L474
> > > > > > >
> > > > > > > So it's good to know issues have already been fixed in this a=
rea since
> > > > > > > the original commit, but it looks like there's still somethin=
g lurking
> > > > > > > here. To clarify, I'm not exactly sure which of the various t=
imeout
> > > > > > > cases in raw_res_spin_lock_irqsave() this recursive lock situ=
ation is
> > > > > > > hitting.
> > > > > >
> > > > > > Ohh. Interesting. It's a new issue then. We thought that
> > > > > > that commit fixed it for good.
> > > > > > How quickly does your reproducer hit it ?
> > > > >
> > > > > It reproduces ~instantly on the machines I've tested on, which is=
 a
> > > > > bit surprising given the inherently racy nature of this issue.
> > > > >
> > > > > I've reproduced this on 4 core / 8 threads and 16 core / 32 threa=
ds
> > > > > machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The user=
 who
> > > > > first reported the issue was also on a 16 core / 32 thread machin=
e
> > > > > (kernel 6.17.4-200.fc42.x86_64).
> > > > >
> > > > > I'll be out of town for a few days from tomorrow, but I'll try to=
 put
> > > > > together a more complete repro before then if possible. I can als=
o
> > > > > provide more diagnostic information if needed.
> > > >
> > > > I think I see the problem, but don't have a good solution except
> > > > reverting to a trylock with 0 timeout until we have something bette=
r.
> > > > Any other value will likely lead to freezes that are as long as the=
 timeout.
> > > > I can trigger it with the stress test we have in the tree when we
> > > > repeatedly spam the CPU with NMIs.
> > > >
> > > > I don't think the problem is when you have reentrancy on the same C=
PU,
> > > > but when you
> > > > have a situation as follows:
> > > >
> > > > CPU 0
> > > > NMI : tail waiter
> > > > Task: random unrelated thing
> > > >
> > > > CPU 1-2
> > > > <other waiters in the middle>
> > > >
> > > > CPU 3
> > > > NMI: head waiter
> > > > Task: Owner
> > > >
> > > > There is no AA deadlock in CPU 0, so we keep spinning.
> > > > If the NMI keeps spamming and delaying the owner from making progre=
ss
> > > > (on multiple CPUs), it is possible to timeout the NMI CPU.
> > > > It feels a bit extreme to be able to cause delays up to 250 ms such
> > > > that we timeout.
> > > >
> > > > I will look at this in closer detail in a couple of days when I hav=
e more time.
> > > >
> > >
> > > Thanks for the update (and sorry for the late response -- I was out o=
f town).
> > >
> > > Great to hear you were able to repro, though I wonder if it's exactly
> > > the same issue we're hitting. In our case, we were able to "fix" this
> > > issue on our side purely by preventing reentrancy via the sampling NM=
I
> > > using a per-CPU map to flag whether that CPU is already executing
> > > another eBPF program. Something like this, expanding on my repro from
> > > before:
> > >
> > > struct {
> > >     __uint(type, BPF_MAP_TYPE_RINGBUF);
> > >     __uint(max_entries, 512 * 1024 * 1024);
> > > } ringBuffer SEC(".maps");
> > >
> > > struct {
> > >     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > >     __uint(max_entries, 1);
> > >     __type(key, u32);
> > >     __type(value, bool);
> > > } sRecursionFlag SEC(".maps");
> > >
> > > SEC("tp_btf/sched_switch")
> > > int cswitch(struct bpf_raw_tracepoint_args* inContext)
> > > {
> > >     u32 zero =3D 0;
> > >     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag,=
 &zero);
> > >     if (*isAlreadyInHandler)
> > >         return 0;
> > >
> > >     *isAlreadyInHandler =3D true;
> > >
> > >     struct CSwitchEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> > > sizeof(struct CSwitchEvent), 0);
> > >     if (event =3D=3D NULL)
> > >     {
> > >         *isAlreadyInHandler =3D false;
> > >         return 1;
> > >     }
> > >
> > >     bpf_ringbuf_submit(event, 0);
> > >
> > >     *isAlreadyInHandler =3D false;
> > >     return 0;
> > > }
> > >
> > > SEC("perf_event")
> > > int sample(struct bpf_perf_event_data* inContext)
> > > {
> > >     u32 zero =3D 0;
> > >     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag,=
 &zero);
> > >     if (*isAlreadyInHandler)
> > >         return 0;
> > >
> > >     *isAlreadyInHandler =3D true;
> > >
> > >     struct SampleEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> > > sizeof(struct SampleEvent), 0);
> > >     if (event =3D=3D NULL)
> > >     {
> > >         *isAlreadyInHandler =3D false;
> > >         return 1;
> > >     }
> > >
> > >     bpf_ringbuf_submit(event, 0);
> > >
> > >     *isAlreadyInHandler =3D false;
> > >     return 0;
> > > }
> > >
> > > (note the addition of the sRecursionFlag per-CPU map and the
> > > reentrancy checks in both programs)
> > >
> > > If the issue really isn't same-CPU reentrancy as you mention, then I
> > > don't understand why this workaround would "fix" the issue; due to th=
e
> > > usage of the per-CPU map, this can *only* prevent reentrancy on the
> > > same CPU.
>
> I think it can mitigate the case I described, because you now have one
> waiter per CPU at most and no reentrancy, with no one impeding the
> owner's progress.
>
> > >
> > > You are right though that in this case, you would expect it to hit th=
e
> > > AA deadlock detection case when it goes into the timeout loop, which =
I
> > > can't explain why it isn't hitting that either.
> > >
> > > If it's helpful, I can put some time into putting together a more
> > > self-contained repro now that I'm back. Let me know if you think that
> > > would be of use.
> >
> > I suspect I see the race.
> > We do:
> > static __always_inline int res_spin_lock(rqspinlock_t *lock)
> > {
> >         int val =3D 0;
> >
> >         if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
> > _Q_LOCKED_VAL))) {
> >                 grab_held_lock_entry(lock);
> >
> > and if NMI happens before grab_held_lock_entry() then AA detector
> > won't see it and it will timeout while waiting for a pending bit.
> >
> > Kumar,
> > how does it sound?
>
> Ritesh, I just sent a fix for the above, more details are in the commit l=
og.
>
> https://lore.kernel.org/bpf/20251125203253.3287019-1-memxor@gmail.com
>
> This is one of the two cases I think are behind the cause of the freeze y=
ou saw.
> Could you give it a spin with your reproducer? It will give us more signa=
l.
> Either way I think this was a real problem so it's worth closing the gap =
anyway.

Thanks for the patch! I've spent the day setting up a kernel build and
testing various scenarios. I'm not sure whether it's best to reply
here or on the patch, let me know if we should move the discussion
there.

I've built two repro executables based on the reproducers I shared
before. They both only reserve & commit to a ringbuf within a
cswitch/sampling handler, but one doesn't protect against same-CPU
recursive locking, and one does. I've then tested these reproducers in
various scenarios. For all tests, other than watching for system
freezes, I've also logged dmesg output to spot NMI handler warnings. I
rebooted the machine between each test/executable to ensure each test
was run against a clean state.

In all scenarios, the version *with* the recursion guard neither
freezes the system, nor results in any NMI handler warnings in dmesg
output, so I won't focus on that. The interesting results are about
the version *without* the recursion guard (i.e. the original
reproducer).

1) The first scenario is against baseline Fedora 6.17.9 built from
source to verify the issue still occurs (my PC had upgraded the kernel
from the 6.17.1 it was on before). The symptoms are the exact same as
previously reported: without the recursion guard, the system
temporarily freezes. dmesg has output like:

[  +0.014286] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.723 msecs
[  +0.232451] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 250.424 msecs
[  +0.000006] perf: interrupt took too long (1956558 > 60421),
lowering kernel.perf_event_max_sample_rate to 1000
[  +0.000001] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 250.424 msecs
[ +10.199727] perf: interrupt took too long (3735113 > 3657913),
lowering kernel.perf_event_max_sample_rate to 1000
[  +0.250938] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 250.936 msecs
[  +0.000003] hrtimer: interrupt took 501441082 ns

2) Next up I tested the patch Kumar sent [1], which fixes the AA
deadlock detection race. The good news is that this indeed fixes the
freeze in the sense that the system doesn't *visibly* freeze anymore.
Looking at dmesg, however, there are still NMI handler warnings (see
below). Of note is that the the 250ms case isn't hit anymore, but
there are still significant outliers. My suspicion is that some of
these are still system freezes, but that they're not noticeable
anymore because they're too short to see by eye (but still an eternity
in CPU time of course...)

[  +0.000002] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.584 msecs
[  +0.014555] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.701 msecs
[  +0.004845] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 26.229 msecs
[  -0.000001] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 15.120 msecs
[  +0.000000] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 24.805 msecs
[  +0.000000] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 6.855 msecs

3) I then tested the suggestion from Alexei [2] to use a 1msec timeout
for the in_nmi() path of resilient_queued_spin_lock_slowpath() to see
if this would improve the NMI timeouts further. And it does (see below
again). The NMI handler spikes are now much less severe; the outliers
are gone and everything is between 1-2ms.

[  +0.002396] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.580 msecs
[  +0.001680] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.580 msecs
[  +0.000077] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.630 msecs
[  +0.006197] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.756 msecs
[  +0.000311] hrtimer: interrupt took 4883753 ns
[  +5.693066] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.973 msecs
[  +0.246851] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.974 msecs
[  +0.163526] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.981 msecs
[  +0.235492] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.996 msecs
[  +0.816012] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 2.003 msecs
[  +0.004036] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 2.019 msecs

4) This result made me curious whether these timings were the result
of the now-1ms-minimum timeout, or whether something else is going on.
I added support for a 0 timeout to check_timeout() and updated the
in_nmi() path to use a 0 timeout like so:

       if (unlikely(idx >=3D _Q_MAX_NODES || in_nmi())) {
               lockevent_inc(lock_no_node);
-               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+               RES_RESET_TIMEOUT(ts, in_nmi() ? 0 : RES_DEF_TIMEOUT);

This made no difference. The NMI handler warnings still show up, in
the same ballpark as the previous test:

[Nov26 23:17] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.520 msecs
[  +0.050890] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.578 msecs
[  +0.032047] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.580 msecs
[  +0.110371] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.583 msecs
[  +0.005776] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.583 msecs
[  +0.010408] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.610 msecs
[  +0.084021] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.789 msecs
[  +0.088464] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.967 msecs
[  +0.011376] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.968 msecs
[  +0.057254] INFO: NMI handler (perf_event_nmi_handler) took too long
to run: 1.973 msecs

5) This made me think it must be one of the other timeout paths that's
still being hit here. So I also added the same 0 timeout for the
_Q_LOCKED_MASK (i.e. the PENDING case):

       if (val & _Q_LOCKED_MASK) {
-               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+               RES_RESET_TIMEOUT(ts, in_nmi() ? 0 : RES_DEF_TIMEOUT);

And with this change, the NMI handler warnings are all gone. There is
another timeout (timeout * 2, actually) path when the locker is at the
head of the waitqueue, but I haven't modified that since I wasn't
hitting any timeouts anymore (but that may just be luck).

I think there are a few issues happening at the same time, which makes
everything a bit hard to diagnose. My best understanding of the
issues/situation is currently:

- There is an issue where the NMI hits the race between acquiring the
lock & grabbing a held lock entry on the fast path that Alexei
spotted. This is the "recursive lock" case I originally posted about.
This breaks the AA detector, and *if* you hit this path, you'll stall
for 250ms+ because whichever timeout you hit inside the slow path will
not break out early due to the AA detector being broken. This is the
cause of the *visible* freezes. The patch from Kumar fixes this.

- With that fixed, the *visible* freezes are gone. The AA detector
properly works in all cases. However, when you hit this same recursive
lock situation now, *you'll still freeze*, but for ~1ms. This is due
to how check_timeout() works: it only performs the AA check every 1ms,
so if the timeout is larger than 1ms, you'll wait for 1ms at a minimum
before aborting the lock acquisition. These stalls are too short to
notice by eye, but the NMI handler does catch them. I think this is
where the ~1-2ms NMI handler warnings are coming from. The AA check
won't trigger exactly at 1ms; it'll trigger whenever check_timeout()
is called when at least 1ms has passed, which may be longer than 1ms
depending on timing.

- Then there's the 6ms+ NMI warnings mentioned above (i.e. test 2
where Kumar's patch is applied, but the timeout change from Alexei
isn't). It's clear from test 3 (Alexei's timeout change) that these
are caused by the trylock loop in the in_nmi() path, since changing
the timeout makes these outliers go away. It's also clear that this is
not the recursive lock situation, since in that case, with Kumar's
race fix, the AA detector would have aborted the trylock loop after
~1ms. I suspect that this is the case Kumar mentioned originally,
which he can reproduce with the stress test, where spamming NMIs can
prevent the lock owner from making progress. This would explain the
variability in the NMI warnings, ranging from a few milliseconds to
dozens of milliseconds that I've seen. As Kumar mentioned, if you're
unlucky enough, you might hit the max timeout of 250ms eventually,
though I think that's unlikely to happen in practice. I *think* these
stalls are also (or can be?) system freezes, but that they're again
too short to detect by eye, but I'm not sure about that.

I don't know whether the changes I made are the right way to go to fix
this; I made them mainly to gather more information about what's going
on. Let me know if you want a patch with my changes, but they should
be pretty straightforward.

I'm now fully set up with a custom kernel workflow, so if there's any
more tests/changes you'd like to me run, please let me know!

[1] https://lore.kernel.org/bpf/20251125203253.3287019-1-memxor@gmail.com/
[2] https://lore.kernel.org/bpf/CAADnVQ+WrJ3kwccbwMOkuqvFGJKJzGSoHh_46Kgus8=
PzH+k9vA@mail.gmail.com/

