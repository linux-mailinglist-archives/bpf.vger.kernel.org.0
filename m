Return-Path: <bpf+bounces-75499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50EFC87157
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 21:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD5A3AB7AC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315792DE6F5;
	Tue, 25 Nov 2025 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGYWNGSI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58451448D5
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764103265; cv=none; b=AYByeG3936+2AdbsnznBew1VSp/xFSjro5sf/CFzoeVeIpTxXga4u63yEsR9dK9V7wz4QX3uNiWn65U1psP0gpPcMQl5kKx+m+LS/p4rSAwEPgrA1847sP1cyMFp4EtcMVheFGL8iGvGwK0WpDwNyIol0V6ctuc1gLfe/gyGLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764103265; c=relaxed/simple;
	bh=+6By5qh1owyEyF02JtYMIEUWhcOE/FcTCcVwmTRzv40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR8xAd/MbIy+1tUHVVHzCS4VjXdnWf+Ny1vq+Mvz1zZhhABubtTLm0hRpWkg8Wt+4Fdf301NB5ZiQ47i4WIpt9wFxfRThsOslzwMJrIUMXhU+RJs5q147hUGNkzokwgXxXMfj8AVaKXfWyRWMYCsv5+RIYNfCe18l8umdgphDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGYWNGSI; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so34011385e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764103262; x=1764708062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I93lEIYgBfF0McDwovH+BLxWTzr388b6Z3VeuVGFtQ=;
        b=kGYWNGSIH5YkYvWaQkohA5b/tl3dbSwcWakpk58JSKrgWB7+9ENicpaWMoHZaJt16E
         WJgEfkPBwvnzKvtz7rtVzfdtPGTgWr25uRJy0Z12TTJG7aP2dvMpl68S9rLnkYAdwp5B
         H6NEMJ//OpeaARa8lWAf5PVR2r4a8RbGglc5xzFd5HNqdiVn5CIR33x02O4CwOg7MWU3
         dol909hPfWGfPi7XzfSussrjPgB62CrTNpTKPwgOqOIt+CodPu5iuh9eYM+uIWbtqfYn
         2z2hWCz2s7k3ljkg64pplb6Itq4xlys21XB6bGZ6bAwx23/KTCZULIqM99Egxmj3xPHQ
         zwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764103262; x=1764708062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9I93lEIYgBfF0McDwovH+BLxWTzr388b6Z3VeuVGFtQ=;
        b=u8y7XiMIxSuCb6cgdyFeQvlnXfIihSg6oq4x9xbheC0AtoSASHivbwh0i5VtRp42Os
         maN+d2G7P+OJMIyNneI7hVI4BJp73yqYKurD544hZ8MeSCr78CnSrFGIkn3iIfBVAIMH
         lMGs2b6+RvNRFrI1rz/Jo5xRsyxwDShEZ1lNRr9UYPsf7GeljQhuidjpRwrjmwhtXPWY
         lRGf323DUkVJTRhtHej4SiXGrC2ScVvk/ELQDLxM5WOPmjiDyIXooGVKnO8sTlnnvNIh
         P2Voc1E3M37haWd9yHzhhF9JFcoTtUPpcFfpyozpCsCoPsjTLklX4MJ5k28u4zTxGDaX
         Ua7g==
X-Forwarded-Encrypted: i=1; AJvYcCUc2Rd11Tvfz/8/yb7yS+LQkcLl/GNcZeyh6MRJ3eGBkVhThlAt0z+GpILf/zX4PbBK2iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAcpYC1MwV/OYLPjaHQXO/qG3rjt632Tw2XvPeHcgcQ9RnrUB6
	ZEIpWrbxJDRaQgUbgJYB1rQ+/HAsQBaUfZwkTuR0aTChI10dmfvbYoVgkIADQ4lWT+LxdRMwkl3
	HK+VjY/SObLTf/Rc7wA4eIc0vZkoAnlk=
X-Gm-Gg: ASbGncsUMQGz/UNZ8a7dIM+OlyCGS6CpjurwVmn7FOIbjbZ175F9MyDsDUsBMbzriv6
	ORmKSPiHJpFiRd53uxvYM1vgQ0qa+P2knLLmGo6SPT+y7I5nSARoahBcYnOnkGlx9a/ZLeZd265
	GKQ9dDcVaH+Q0nkVgxuZKurQHO3hia7Wd78ZMbQ6EQsvJ5CNHAyIJcGntQXJXLXIfHp4QN/gHQm
	F7deObKvNBiC3YHW82FUObSGb1rEhEIMo1sFDqQvkmYQuaoVzmWcnSFIdgk/gWOvB3XQkyMsHB5
	ZEN9yECn8hUF8N9KeLJiplje7fLJPQ==
X-Google-Smtp-Source: AGHT+IHT6xyXOQDwJUb7IReEBs8lpV2XO4DwHNQmSKDcqXPbC2v343wLXGNbeyi3wZaGitgVYf00d60QyT/sCRNSrcc=
X-Received: by 2002:a05:600c:1f8f:b0:477:a0dd:b2af with SMTP id
 5b1f17b1804b1-477c01ea502mr140612485e9.33.1764103261872; Tue, 25 Nov 2025
 12:41:01 -0800 (PST)
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
 <CAH6OuBQ3UY7AHHp1ZMacMO6zq4YFsi=ycqE_FPSZGBm0FRnuVg@mail.gmail.com> <CAADnVQ+F8v3f+aOJG6AsV9EO+Mp=-uY4OzigNR6jh=SoT+KTFA@mail.gmail.com>
In-Reply-To: <CAADnVQ+F8v3f+aOJG6AsV9EO+Mp=-uY4OzigNR6jh=SoT+KTFA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 25 Nov 2025 21:40:25 +0100
X-Gm-Features: AWmQ_bnergrAyG0phlo4iSSu-9xrSyAFZZHmse1PJ9nOVK3DCyQivbsrhE4W300
Message-ID: <CAP01T77z4h2QhQxgDxLPxzGZVase3xPSqSHq0v_3VWK5sjvqqw@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Nov 2025 at 19:45, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 20, 2025 at 1:46=E2=80=AFAM Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > On Mon, Nov 17, 2025 at 4:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sun, 16 Nov 2025 at 15:11, Ritesh Oedayrajsingh Varma
> > > <ritesh@superluminal.eu> wrote:
> > > >
> > > > On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Varm=
a
> > > > > <ritesh@superluminal.eu> wrote:
> > > > > >
> > > > > > Hi Alexei,
> > > > > >
> > > > > > Thanks for the info! I wasn't aware of that fix, but I just che=
cked,
> > > > > > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_=
64.
> > > > > >
> > > > > > I just installed the kernel sources locally to make sure, and t=
he code
> > > > > > for rqspinlock matches that of the commit you linked (i.e. the
> > > > > > is_nmi() check added in the commit is there). The code for the =
related
> > > > > > commit  164c246 ("rqspinlock: Protect waiters in queue from sta=
lls")
> > > > > > is also present. You can verify this yourself on Fedora's 6.17.=
1 git
> > > > > > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6=
.17.1-1/kernel/bpf/rqspinlock.c#L474
> > > > > >
> > > > > > So it's good to know issues have already been fixed in this are=
a since
> > > > > > the original commit, but it looks like there's still something =
lurking
> > > > > > here. To clarify, I'm not exactly sure which of the various tim=
eout
> > > > > > cases in raw_res_spin_lock_irqsave() this recursive lock situat=
ion is
> > > > > > hitting.
> > > > >
> > > > > Ohh. Interesting. It's a new issue then. We thought that
> > > > > that commit fixed it for good.
> > > > > How quickly does your reproducer hit it ?
> > > >
> > > > It reproduces ~instantly on the machines I've tested on, which is a
> > > > bit surprising given the inherently racy nature of this issue.
> > > >
> > > > I've reproduced this on 4 core / 8 threads and 16 core / 32 threads
> > > > machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The user w=
ho
> > > > first reported the issue was also on a 16 core / 32 thread machine
> > > > (kernel 6.17.4-200.fc42.x86_64).
> > > >
> > > > I'll be out of town for a few days from tomorrow, but I'll try to p=
ut
> > > > together a more complete repro before then if possible. I can also
> > > > provide more diagnostic information if needed.
> > >
> > > I think I see the problem, but don't have a good solution except
> > > reverting to a trylock with 0 timeout until we have something better.
> > > Any other value will likely lead to freezes that are as long as the t=
imeout.
> > > I can trigger it with the stress test we have in the tree when we
> > > repeatedly spam the CPU with NMIs.
> > >
> > > I don't think the problem is when you have reentrancy on the same CPU=
,
> > > but when you
> > > have a situation as follows:
> > >
> > > CPU 0
> > > NMI : tail waiter
> > > Task: random unrelated thing
> > >
> > > CPU 1-2
> > > <other waiters in the middle>
> > >
> > > CPU 3
> > > NMI: head waiter
> > > Task: Owner
> > >
> > > There is no AA deadlock in CPU 0, so we keep spinning.
> > > If the NMI keeps spamming and delaying the owner from making progress
> > > (on multiple CPUs), it is possible to timeout the NMI CPU.
> > > It feels a bit extreme to be able to cause delays up to 250 ms such
> > > that we timeout.
> > >
> > > I will look at this in closer detail in a couple of days when I have =
more time.
> > >
> >
> > Thanks for the update (and sorry for the late response -- I was out of =
town).
> >
> > Great to hear you were able to repro, though I wonder if it's exactly
> > the same issue we're hitting. In our case, we were able to "fix" this
> > issue on our side purely by preventing reentrancy via the sampling NMI
> > using a per-CPU map to flag whether that CPU is already executing
> > another eBPF program. Something like this, expanding on my repro from
> > before:
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_RINGBUF);
> >     __uint(max_entries, 512 * 1024 * 1024);
> > } ringBuffer SEC(".maps");
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >     __uint(max_entries, 1);
> >     __type(key, u32);
> >     __type(value, bool);
> > } sRecursionFlag SEC(".maps");
> >
> > SEC("tp_btf/sched_switch")
> > int cswitch(struct bpf_raw_tracepoint_args* inContext)
> > {
> >     u32 zero =3D 0;
> >     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag, &=
zero);
> >     if (*isAlreadyInHandler)
> >         return 0;
> >
> >     *isAlreadyInHandler =3D true;
> >
> >     struct CSwitchEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> > sizeof(struct CSwitchEvent), 0);
> >     if (event =3D=3D NULL)
> >     {
> >         *isAlreadyInHandler =3D false;
> >         return 1;
> >     }
> >
> >     bpf_ringbuf_submit(event, 0);
> >
> >     *isAlreadyInHandler =3D false;
> >     return 0;
> > }
> >
> > SEC("perf_event")
> > int sample(struct bpf_perf_event_data* inContext)
> > {
> >     u32 zero =3D 0;
> >     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag, &=
zero);
> >     if (*isAlreadyInHandler)
> >         return 0;
> >
> >     *isAlreadyInHandler =3D true;
> >
> >     struct SampleEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> > sizeof(struct SampleEvent), 0);
> >     if (event =3D=3D NULL)
> >     {
> >         *isAlreadyInHandler =3D false;
> >         return 1;
> >     }
> >
> >     bpf_ringbuf_submit(event, 0);
> >
> >     *isAlreadyInHandler =3D false;
> >     return 0;
> > }
> >
> > (note the addition of the sRecursionFlag per-CPU map and the
> > reentrancy checks in both programs)
> >
> > If the issue really isn't same-CPU reentrancy as you mention, then I
> > don't understand why this workaround would "fix" the issue; due to the
> > usage of the per-CPU map, this can *only* prevent reentrancy on the
> > same CPU.

I think it can mitigate the case I described, because you now have one
waiter per CPU at most and no reentrancy, with no one impeding the
owner's progress.

> >
> > You are right though that in this case, you would expect it to hit the
> > AA deadlock detection case when it goes into the timeout loop, which I
> > can't explain why it isn't hitting that either.
> >
> > If it's helpful, I can put some time into putting together a more
> > self-contained repro now that I'm back. Let me know if you think that
> > would be of use.
>
> I suspect I see the race.
> We do:
> static __always_inline int res_spin_lock(rqspinlock_t *lock)
> {
>         int val =3D 0;
>
>         if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
> _Q_LOCKED_VAL))) {
>                 grab_held_lock_entry(lock);
>
> and if NMI happens before grab_held_lock_entry() then AA detector
> won't see it and it will timeout while waiting for a pending bit.
>
> Kumar,
> how does it sound?

Ritesh, I just sent a fix for the above, more details are in the commit log=
.

https://lore.kernel.org/bpf/20251125203253.3287019-1-memxor@gmail.com

This is one of the two cases I think are behind the cause of the freeze you=
 saw.
Could you give it a spin with your reproducer? It will give us more signal.
Either way I think this was a real problem so it's worth closing the gap an=
yway.

