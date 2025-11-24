Return-Path: <bpf+bounces-75389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B85FDC82242
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 863A24E5E6F
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835F221F03;
	Mon, 24 Nov 2025 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMCE3UCO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA4256D
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009956; cv=none; b=Q9QzumfTK6adwWEw8M+6lsXqvsImdzeBcradFL5dDGQULqyZv0reIjoOAJ9EJHyvLh/xgSqAzCoTdWI5N63nW26LFVNr6aVlhBgXXnmVcr3SvT+hWmSJ6M0xj7m6jOX67w+m/7vIwZ7E2V0em4QwO4fYkiQPbgUdc/SPAlhZWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009956; c=relaxed/simple;
	bh=r1fyCksvvHEn6jX7ALmNPP30lqsripoR1VMKO/z9LSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5ySmdu0EUcTN7BYPsTS1dtgpVc4q/caFVOwlQ+RPdZcBpEUOVHIy/lvWz2rDGf6+z6kEmDGUJHwkaqjlQYx6QcHzprU25XIfZw7FkcKMW0sS8bk97/ELbvYCL8RFy6wfYwtd528roydNQz2Q/32RnYoTbPqRlNouMzIP+KkNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMCE3UCO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c82bf86bso2731410f8f.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764009952; x=1764614752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pex+fOjUPBvbxmOLEb/uLjQBEH6Ok8bXEGu+z1DQd4A=;
        b=HMCE3UCOJ40zICzeey2JEysUs75qnY4E9IM4f2+AXSZGWrYTYCuwNkzYWJ8cgUdw09
         4wXRi0YbYDlRr+aJ9w+q/i1eUPZX9H5pB+oVf1maGvgVbuMkfjbVo9TQR9NY2z1x2RbH
         4xvAPfQUv+E6uufS+hj1PPiiddoXplvbvbyeQSFnCgM8iBPdSTfglDmXdBb7617gfRas
         A6X8GJYSBeKfhHkfCMAVeI7lxZvW0abN6Fmg2YQTSmPAEaKsXJfh7ujGvZiJe7ExD8u+
         foync82ZLg9KIMkyMGv44R/D+Uje0dl0dYVpVyvQr0UUanbqFJqJfl6KXtpowkg3rRIz
         380w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764009952; x=1764614752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pex+fOjUPBvbxmOLEb/uLjQBEH6Ok8bXEGu+z1DQd4A=;
        b=DyzYJ12gLCa6pZrw/6AGF+MdiL3yYi+SAIbXYU8SkPZYuPFXzju1Sx0VYIS8OoeJVt
         62Vc+Se+6oh7SIjks9PbFErGY1gozbPlcW2btv0GnGx7kdHyMqv3/E7JFBaLWQZr9Agj
         wBZNMGAkTxhUrVQFXU5sgm0UFpCH09vPx9Db9aGdk9hFQxMS3P/tnlJb0hllKWQ6cJTG
         RBdkkRr3d2vmjR3jAn2+HxeAS7xAz3eHySjBwlJfX1Hwjo+KSLabC3l6IvS0QOf3v9Wm
         JlTUeCuclhw6g4WbeHDepZ5CqWs0JyYLwSlYLmvvElLKSftQlEmnOwaObbTZEbPTWoeJ
         tqwA==
X-Forwarded-Encrypted: i=1; AJvYcCWjF8KyWCZ6jMLeDXjebsKi9F+rWD8MNHAW8efTP+Q7tRuDgLRsQUMA9/GVnf7x6jIccZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTmB+X1BPJ35M7eihWQ7pmrK1VVGXrFRnbCUYz3USEm8aXDUy
	RwB3PG8WXOhWU9t3Xd9uelomSfANn/CcyyNEOxjtNIHdqyCu/ih2W9mcIK8BAj1kvlIOa1Ltzjl
	JPjsY0DIR0Yw1qzp0er3hz6wD6dossJQ=
X-Gm-Gg: ASbGncvGckrlC1ZplG8jeKzumJivF5KNZ2iIavMf1HKkH71L5xAr1ZNfZ8PGtxu5qmZ
	GMqEtChHg0V8cOrTEqEbmNs/iHyp/GgVSOrMqAKrqJFCTBH49UrJHn9+xScWe/i5hY2O+/krqSz
	X+/33h/ic/Px4EOMbDZr+L+dd4WRb8G9zfm+3zUpSBpalEaAc3D53V+G2nRzhxIM2h+0w03f1MO
	0rMG14ZQrcvBvye0QWHFMHZHQW9vMNk2uTU9dGE+bILqQbOafYXfN2+svpdNyCTITr0+td6gHsm
	nMNkzBxgDwH+MddvsFZ0mg==
X-Google-Smtp-Source: AGHT+IEPewU/1Y8R5Gyw/2Z3sDtGXZP5KHFLrawNdKE+pVdia9OngAvtejKjJSYfcn6YPiYO1TqBVqj1zqhlrleZY0k=
X-Received: by 2002:a05:6000:26c8:b0:42b:3bfc:d5cb with SMTP id
 ffacd0b85a97d-42cc1d190d6mr13043834f8f.51.1764009952119; Mon, 24 Nov 2025
 10:45:52 -0800 (PST)
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
 <CAP01T776rsC_aNF4AijRGDqZRfmeKDbSfFmGYPTYh+zaOuwrWw@mail.gmail.com> <CAH6OuBQ3UY7AHHp1ZMacMO6zq4YFsi=ycqE_FPSZGBm0FRnuVg@mail.gmail.com>
In-Reply-To: <CAH6OuBQ3UY7AHHp1ZMacMO6zq4YFsi=ycqE_FPSZGBm0FRnuVg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Nov 2025 10:45:40 -0800
X-Gm-Features: AWmQ_bk4n2VZMilMIuThmAUV-1Qw5CJw2-HN5MJexahJynrF_V-SS5HS39BAlVI
Message-ID: <CAADnVQ+F8v3f+aOJG6AsV9EO+Mp=-uY4OzigNR6jh=SoT+KTFA@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:46=E2=80=AFAM Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> On Mon, Nov 17, 2025 at 4:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sun, 16 Nov 2025 at 15:11, Ritesh Oedayrajsingh Varma
> > <ritesh@superluminal.eu> wrote:
> > >
> > > On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Varma
> > > > <ritesh@superluminal.eu> wrote:
> > > > >
> > > > > Hi Alexei,
> > > > >
> > > > > Thanks for the info! I wasn't aware of that fix, but I just check=
ed,
> > > > > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_64=
.
> > > > >
> > > > > I just installed the kernel sources locally to make sure, and the=
 code
> > > > > for rqspinlock matches that of the commit you linked (i.e. the
> > > > > is_nmi() check added in the commit is there). The code for the re=
lated
> > > > > commit  164c246 ("rqspinlock: Protect waiters in queue from stall=
s")
> > > > > is also present. You can verify this yourself on Fedora's 6.17.1 =
git
> > > > > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6.1=
7.1-1/kernel/bpf/rqspinlock.c#L474
> > > > >
> > > > > So it's good to know issues have already been fixed in this area =
since
> > > > > the original commit, but it looks like there's still something lu=
rking
> > > > > here. To clarify, I'm not exactly sure which of the various timeo=
ut
> > > > > cases in raw_res_spin_lock_irqsave() this recursive lock situatio=
n is
> > > > > hitting.
> > > >
> > > > Ohh. Interesting. It's a new issue then. We thought that
> > > > that commit fixed it for good.
> > > > How quickly does your reproducer hit it ?
> > >
> > > It reproduces ~instantly on the machines I've tested on, which is a
> > > bit surprising given the inherently racy nature of this issue.
> > >
> > > I've reproduced this on 4 core / 8 threads and 16 core / 32 threads
> > > machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The user who
> > > first reported the issue was also on a 16 core / 32 thread machine
> > > (kernel 6.17.4-200.fc42.x86_64).
> > >
> > > I'll be out of town for a few days from tomorrow, but I'll try to put
> > > together a more complete repro before then if possible. I can also
> > > provide more diagnostic information if needed.
> >
> > I think I see the problem, but don't have a good solution except
> > reverting to a trylock with 0 timeout until we have something better.
> > Any other value will likely lead to freezes that are as long as the tim=
eout.
> > I can trigger it with the stress test we have in the tree when we
> > repeatedly spam the CPU with NMIs.
> >
> > I don't think the problem is when you have reentrancy on the same CPU,
> > but when you
> > have a situation as follows:
> >
> > CPU 0
> > NMI : tail waiter
> > Task: random unrelated thing
> >
> > CPU 1-2
> > <other waiters in the middle>
> >
> > CPU 3
> > NMI: head waiter
> > Task: Owner
> >
> > There is no AA deadlock in CPU 0, so we keep spinning.
> > If the NMI keeps spamming and delaying the owner from making progress
> > (on multiple CPUs), it is possible to timeout the NMI CPU.
> > It feels a bit extreme to be able to cause delays up to 250 ms such
> > that we timeout.
> >
> > I will look at this in closer detail in a couple of days when I have mo=
re time.
> >
>
> Thanks for the update (and sorry for the late response -- I was out of to=
wn).
>
> Great to hear you were able to repro, though I wonder if it's exactly
> the same issue we're hitting. In our case, we were able to "fix" this
> issue on our side purely by preventing reentrancy via the sampling NMI
> using a per-CPU map to flag whether that CPU is already executing
> another eBPF program. Something like this, expanding on my repro from
> before:
>
> struct {
>     __uint(type, BPF_MAP_TYPE_RINGBUF);
>     __uint(max_entries, 512 * 1024 * 1024);
> } ringBuffer SEC(".maps");
>
> struct {
>     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>     __uint(max_entries, 1);
>     __type(key, u32);
>     __type(value, bool);
> } sRecursionFlag SEC(".maps");
>
> SEC("tp_btf/sched_switch")
> int cswitch(struct bpf_raw_tracepoint_args* inContext)
> {
>     u32 zero =3D 0;
>     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag, &ze=
ro);
>     if (*isAlreadyInHandler)
>         return 0;
>
>     *isAlreadyInHandler =3D true;
>
>     struct CSwitchEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> sizeof(struct CSwitchEvent), 0);
>     if (event =3D=3D NULL)
>     {
>         *isAlreadyInHandler =3D false;
>         return 1;
>     }
>
>     bpf_ringbuf_submit(event, 0);
>
>     *isAlreadyInHandler =3D false;
>     return 0;
> }
>
> SEC("perf_event")
> int sample(struct bpf_perf_event_data* inContext)
> {
>     u32 zero =3D 0;
>     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag, &ze=
ro);
>     if (*isAlreadyInHandler)
>         return 0;
>
>     *isAlreadyInHandler =3D true;
>
>     struct SampleEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> sizeof(struct SampleEvent), 0);
>     if (event =3D=3D NULL)
>     {
>         *isAlreadyInHandler =3D false;
>         return 1;
>     }
>
>     bpf_ringbuf_submit(event, 0);
>
>     *isAlreadyInHandler =3D false;
>     return 0;
> }
>
> (note the addition of the sRecursionFlag per-CPU map and the
> reentrancy checks in both programs)
>
> If the issue really isn't same-CPU reentrancy as you mention, then I
> don't understand why this workaround would "fix" the issue; due to the
> usage of the per-CPU map, this can *only* prevent reentrancy on the
> same CPU.
>
> You are right though that in this case, you would expect it to hit the
> AA deadlock detection case when it goes into the timeout loop, which I
> can't explain why it isn't hitting that either.
>
> If it's helpful, I can put some time into putting together a more
> self-contained repro now that I'm back. Let me know if you think that
> would be of use.

I suspect I see the race.
We do:
static __always_inline int res_spin_lock(rqspinlock_t *lock)
{
        int val =3D 0;

        if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
_Q_LOCKED_VAL))) {
                grab_held_lock_entry(lock);

and if NMI happens before grab_held_lock_entry() then AA detector
won't see it and it will timeout while waiting for a pending bit.

Kumar,
how does it sound?

