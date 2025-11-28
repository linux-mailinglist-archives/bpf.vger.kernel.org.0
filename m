Return-Path: <bpf+bounces-75744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E5C93498
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B3B3A838B
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2CC2E92D2;
	Fri, 28 Nov 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff2oOOwb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9A233704
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371856; cv=none; b=oQ14dR/jlZo4QkS1oe3AT8Ig66gd/dgY9ldU16AARhHBtqZJmkeIHxZj8ynBEIhRdd1bNP0LKFVfwk4/2krDBFML7twevMSuLtIaXQhbiry16IBZQ3P1/Unzgck0p5QMcpwHD6g6Hbv2dco2J52q0KfJEPVfxgd9akD4ZySPr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371856; c=relaxed/simple;
	bh=TUYuzutxib4x0JCBe/Yw5ToToNZSElA01URaJiC4pyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3mN291g7jKRxk2vXKjGOPGkLx3yGLekjW9s2SiK7LbceQ7cmLfA9K4kmRewdSJ5jalWAvebJq6yx7gJCNAv6e8cCSZ8o2ZvtGvHJ5W6/E4BOtT8ppDSppsi9IF9EwOpdQKSc1hj0S5UZpiksslHXWn5L3e7MwW/CNKxnaqZ5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff2oOOwb; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-477a1c28778so25989805e9.3
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371852; x=1764976652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOLzkFcGSHxVqpSslvxepY5tXIT1yzvi9Vz7voeFDRg=;
        b=Ff2oOOwb1R5DAjomF+10vnwqnlyoOnWLVLIIEBQN+HPKVcmcYuTQsD9KrRboVcX35y
         xmQg7V8KqXOJGMA4TcKxRB+EOx6/GdHAow4+YJu6FH1O3bue4ij4wGydC70HjO2gkZVU
         5wsn404WAvB7WoGaKagNz6EQi0XKd+i01kduWyhq45xCWrQiavi6QymstzK0rdKBK9XH
         PBxrk1XPO0n/7ptIzx0PlJUxGYrKOxP4icxggx0ErfmjKAwouNLvDkvYNuYuWufQqCws
         ZYlf6OrXYkUn1mcEk1TMVoMIvKUTFx0etogTNnxb/dD0Ax4+c2YvuMAZvDj0HV2LmPId
         psdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371852; x=1764976652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOLzkFcGSHxVqpSslvxepY5tXIT1yzvi9Vz7voeFDRg=;
        b=a1uNDLLxWgkaIuynoT3wmhIX26+PxoswJJYg6tFO4rjERIWTSMYYTAex1EgkC555h7
         ovqEW7DdXTrtcTr88lHwEblZcpBX0PnVfasmR9w76PS12o/G9lseQNX1KOQsq6v1DBID
         BQXf1kdiaLbmml874A7HacxRHDuCwtOUadDC03Gpeif99bLqtdgdXA7OobF8cGgy36Ir
         UOEGw1Ck2EaNRU6Lq+BM6MYO5yaUklt6jIGpqVvakOGZwarTaSuY2ajoGZBGx/sXXuBt
         S1sc5PS8ELR/JWu2IHasyRs8/+G1z4iW+uWXdy73oZMxNRBmi5RBBeIWXrubtUVcUp5I
         q1lg==
X-Forwarded-Encrypted: i=1; AJvYcCWq/Qmlj5Q8jrafOB3nnAR3ejjWK2e5WNW2zBx/yn6iI7h5ceMYuDMFwjSJiuem6/hMScw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKbONHzcmgQ3OqlmxXJtoAThja+MFk4fz/54CuywMKZr0Cdta
	vlN1m/hxwYasWcHQ9OFfLd6b4odoKKX1YiHCP4TVAbO6cibdoCAbFmmLZuCZTXZI/fJT4k9no+3
	Y1v0kNHPQwp3FeGjiRaE3jFqeCbM/hAw=
X-Gm-Gg: ASbGnctQ5IlifDu+l3J4Rw4+aWa306nXVwCZiSvZw41NWr23H1+gEd8SHXRR65u0LhU
	y1Vc44F4GzltHenubkD5zvOp0cyJwAmlDky2iSfRfKhfp7/kbET9GTv1WuhYstX49jlaVgXXEPt
	saWZMxzqiGk1uY4wL11k8dNLuz/fo/hhG1ceeUNjX2OxnmX0u3iO7OaHgct0spP8Eu/0gNjQSG8
	p9JoTOZbrk643aCE8BKxEpabV2iCaSwTlrwXki1HP0PiTIB/9kQmIyUqH+69+1CINPC5Hy8jehi
	pvOkzW0m3xvPYkv4doNNSYf4Bfkk
X-Google-Smtp-Source: AGHT+IFuaLNQjWN6c8HqaQnGMBiWTVC58ThPbgyc0RCGkWTh8YF/E/Rfs4st2aGjLoEtdBiQtdBQ2JbmKs6SCPUScNo=
X-Received: by 2002:a05:600c:6287:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-47904acae5fmr137619205e9.6.1764371851454; Fri, 28 Nov 2025
 15:17:31 -0800 (PST)
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
 <CAADnVQ+F8v3f+aOJG6AsV9EO+Mp=-uY4OzigNR6jh=SoT+KTFA@mail.gmail.com>
 <CAP01T77z4h2QhQxgDxLPxzGZVase3xPSqSHq0v_3VWK5sjvqqw@mail.gmail.com> <CAH6OuBQXcKsVDnFAY_8sKF6snsMurV_KkmmyeKb0dxFOjhfF=w@mail.gmail.com>
In-Reply-To: <CAH6OuBQXcKsVDnFAY_8sKF6snsMurV_KkmmyeKb0dxFOjhfF=w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 29 Nov 2025 00:16:54 +0100
X-Gm-Features: AWmQ_bkfBBV8WOtxbVRybYeRguYw6wwLUXaQQHdQr8bVwRLJgCvmBZWE83mBYZY
Message-ID: <CAP01T74Bh2HKPY5i226oHEASWz=qaHiNPPcCXQuHgTE8yHv1oA@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Nov 2025 at 01:40, Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> On Tue, Nov 25, 2025 at 9:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, 24 Nov 2025 at 19:45, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Nov 20, 2025 at 1:46=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > > <ritesh@superluminal.eu> wrote:
> > > >
> > > > On Mon, Nov 17, 2025 at 4:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > > <memxor@gmail.com> wrote:
> > > > >
> > > > > On Sun, 16 Nov 2025 at 15:11, Ritesh Oedayrajsingh Varma
> > > > > <ritesh@superluminal.eu> wrote:
> > > > > >
> > > > > > On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh =
Varma
> > > > > > > <ritesh@superluminal.eu> wrote:
> > > > > > > >
> > > > > > > > Hi Alexei,
> > > > > > > >
> > > > > > > > Thanks for the info! I wasn't aware of that fix, but I just=
 checked,
> > > > > > > > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.=
x86_64.
> > > > > > > >
> > > > > > > > I just installed the kernel sources locally to make sure, a=
nd the code
> > > > > > > > for rqspinlock matches that of the commit you linked (i.e. =
the
> > > > > > > > is_nmi() check added in the commit is there). The code for =
the related
> > > > > > > > commit  164c246 ("rqspinlock: Protect waiters in queue from=
 stalls")
> > > > > > > > is also present. You can verify this yourself on Fedora's 6=
.17.1 git
> > > > > > > > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kern=
el-6.17.1-1/kernel/bpf/rqspinlock.c#L474
> > > > > > > >
> > > > > > > > So it's good to know issues have already been fixed in this=
 area since
> > > > > > > > the original commit, but it looks like there's still someth=
ing lurking
> > > > > > > > here. To clarify, I'm not exactly sure which of the various=
 timeout
> > > > > > > > cases in raw_res_spin_lock_irqsave() this recursive lock si=
tuation is
> > > > > > > > hitting.
> > > > > > >
> > > > > > > Ohh. Interesting. It's a new issue then. We thought that
> > > > > > > that commit fixed it for good.
> > > > > > > How quickly does your reproducer hit it ?
> > > > > >
> > > > > > It reproduces ~instantly on the machines I've tested on, which =
is a
> > > > > > bit surprising given the inherently racy nature of this issue.
> > > > > >
> > > > > > I've reproduced this on 4 core / 8 threads and 16 core / 32 thr=
eads
> > > > > > machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The us=
er who
> > > > > > first reported the issue was also on a 16 core / 32 thread mach=
ine
> > > > > > (kernel 6.17.4-200.fc42.x86_64).
> > > > > >
> > > > > > I'll be out of town for a few days from tomorrow, but I'll try =
to put
> > > > > > together a more complete repro before then if possible. I can a=
lso
> > > > > > provide more diagnostic information if needed.
> > > > >
> > > > > I think I see the problem, but don't have a good solution except
> > > > > reverting to a trylock with 0 timeout until we have something bet=
ter.
> > > > > Any other value will likely lead to freezes that are as long as t=
he timeout.
> > > > > I can trigger it with the stress test we have in the tree when we
> > > > > repeatedly spam the CPU with NMIs.
> > > > >
> > > > > I don't think the problem is when you have reentrancy on the same=
 CPU,
> > > > > but when you
> > > > > have a situation as follows:
> > > > >
> > > > > CPU 0
> > > > > NMI : tail waiter
> > > > > Task: random unrelated thing
> > > > >
> > > > > CPU 1-2
> > > > > <other waiters in the middle>
> > > > >
> > > > > CPU 3
> > > > > NMI: head waiter
> > > > > Task: Owner
> > > > >
> > > > > There is no AA deadlock in CPU 0, so we keep spinning.
> > > > > If the NMI keeps spamming and delaying the owner from making prog=
ress
> > > > > (on multiple CPUs), it is possible to timeout the NMI CPU.
> > > > > It feels a bit extreme to be able to cause delays up to 250 ms su=
ch
> > > > > that we timeout.
> > > > >
> > > > > I will look at this in closer detail in a couple of days when I h=
ave more time.
> > > > >
> > > >
> > > > Thanks for the update (and sorry for the late response -- I was out=
 of town).
> > > >
> > > > Great to hear you were able to repro, though I wonder if it's exact=
ly
> > > > the same issue we're hitting. In our case, we were able to "fix" th=
is
> > > > issue on our side purely by preventing reentrancy via the sampling =
NMI
> > > > using a per-CPU map to flag whether that CPU is already executing
> > > > another eBPF program. Something like this, expanding on my repro fr=
om
> > > > before:
> > > >
> > > > struct {
> > > >     __uint(type, BPF_MAP_TYPE_RINGBUF);
> > > >     __uint(max_entries, 512 * 1024 * 1024);
> > > > } ringBuffer SEC(".maps");
> > > >
> > > > struct {
> > > >     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> > > >     __uint(max_entries, 1);
> > > >     __type(key, u32);
> > > >     __type(value, bool);
> > > > } sRecursionFlag SEC(".maps");
> > > >
> > > > SEC("tp_btf/sched_switch")
> > > > int cswitch(struct bpf_raw_tracepoint_args* inContext)
> > > > {
> > > >     u32 zero =3D 0;
> > > >     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFla=
g, &zero);
> > > >     if (*isAlreadyInHandler)
> > > >         return 0;
> > > >
> > > >     *isAlreadyInHandler =3D true;
> > > >
> > > >     struct CSwitchEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> > > > sizeof(struct CSwitchEvent), 0);
> > > >     if (event =3D=3D NULL)
> > > >     {
> > > >         *isAlreadyInHandler =3D false;
> > > >         return 1;
> > > >     }
> > > >
> > > >     bpf_ringbuf_submit(event, 0);
> > > >
> > > >     *isAlreadyInHandler =3D false;
> > > >     return 0;
> > > > }
> > > >
> > > > SEC("perf_event")
> > > > int sample(struct bpf_perf_event_data* inContext)
> > > > {
> > > >     u32 zero =3D 0;
> > > >     bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFla=
g, &zero);
> > > >     if (*isAlreadyInHandler)
> > > >         return 0;
> > > >
> > > >     *isAlreadyInHandler =3D true;
> > > >
> > > >     struct SampleEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
> > > > sizeof(struct SampleEvent), 0);
> > > >     if (event =3D=3D NULL)
> > > >     {
> > > >         *isAlreadyInHandler =3D false;
> > > >         return 1;
> > > >     }
> > > >
> > > >     bpf_ringbuf_submit(event, 0);
> > > >
> > > >     *isAlreadyInHandler =3D false;
> > > >     return 0;
> > > > }
> > > >
> > > > (note the addition of the sRecursionFlag per-CPU map and the
> > > > reentrancy checks in both programs)
> > > >
> > > > If the issue really isn't same-CPU reentrancy as you mention, then =
I
> > > > don't understand why this workaround would "fix" the issue; due to =
the
> > > > usage of the per-CPU map, this can *only* prevent reentrancy on the
> > > > same CPU.
> >
> > I think it can mitigate the case I described, because you now have one
> > waiter per CPU at most and no reentrancy, with no one impeding the
> > owner's progress.
> >
> > > >
> > > > You are right though that in this case, you would expect it to hit =
the
> > > > AA deadlock detection case when it goes into the timeout loop, whic=
h I
> > > > can't explain why it isn't hitting that either.
> > > >
> > > > If it's helpful, I can put some time into putting together a more
> > > > self-contained repro now that I'm back. Let me know if you think th=
at
> > > > would be of use.
> > >
> > > I suspect I see the race.
> > > We do:
> > > static __always_inline int res_spin_lock(rqspinlock_t *lock)
> > > {
> > >         int val =3D 0;
> > >
> > >         if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
> > > _Q_LOCKED_VAL))) {
> > >                 grab_held_lock_entry(lock);
> > >
> > > and if NMI happens before grab_held_lock_entry() then AA detector
> > > won't see it and it will timeout while waiting for a pending bit.
> > >
> > > Kumar,
> > > how does it sound?
> >
> > Ritesh, I just sent a fix for the above, more details are in the commit=
 log.
> >
> > https://lore.kernel.org/bpf/20251125203253.3287019-1-memxor@gmail.com
> >
> > This is one of the two cases I think are behind the cause of the freeze=
 you saw.
> > Could you give it a spin with your reproducer? It will give us more sig=
nal.
> > Either way I think this was a real problem so it's worth closing the ga=
p anyway.
>
> Thanks for the patch! I've spent the day setting up a kernel build and
> testing various scenarios. I'm not sure whether it's best to reply
> here or on the patch, let me know if we should move the discussion
> there.

Hi Ritesh,
Thanks for putting in your time testing the patches and the excellent analy=
sis.
I'll respond more below.

>
> I've built two repro executables based on the reproducers I shared
> before. They both only reserve & commit to a ringbuf within a
> cswitch/sampling handler, but one doesn't protect against same-CPU
> recursive locking, and one does. I've then tested these reproducers in
> various scenarios. For all tests, other than watching for system
> freezes, I've also logged dmesg output to spot NMI handler warnings. I
> rebooted the machine between each test/executable to ensure each test
> was run against a clean state.
>
> In all scenarios, the version *with* the recursion guard neither
> freezes the system, nor results in any NMI handler warnings in dmesg
> output, so I won't focus on that. The interesting results are about
> the version *without* the recursion guard (i.e. the original
> reproducer).
>
> 1) The first scenario is against baseline Fedora 6.17.9 built from
> source to verify the issue still occurs (my PC had upgraded the kernel
> from the 6.17.1 it was on before). The symptoms are the exact same as
> previously reported: without the recursion guard, the system
> temporarily freezes. dmesg has output like:
>
> [  +0.014286] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.723 msecs
> [  +0.232451] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 250.424 msecs
> [  +0.000006] perf: interrupt took too long (1956558 > 60421),
> lowering kernel.perf_event_max_sample_rate to 1000
> [  +0.000001] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 250.424 msecs
> [ +10.199727] perf: interrupt took too long (3735113 > 3657913),
> lowering kernel.perf_event_max_sample_rate to 1000
> [  +0.250938] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 250.936 msecs
> [  +0.000003] hrtimer: interrupt took 501441082 ns
>
> 2) Next up I tested the patch Kumar sent [1], which fixes the AA
> deadlock detection race. The good news is that this indeed fixes the
> freeze in the sense that the system doesn't *visibly* freeze anymore.

Nice, thanks for the confirmation.

> Looking at dmesg, however, there are still NMI handler warnings (see
> below). Of note is that the the 250ms case isn't hit anymore, but
> there are still significant outliers. My suspicion is that some of
> these are still system freezes, but that they're not noticeable
> anymore because they're too short to see by eye (but still an eternity
> in CPU time of course...)
>
> [  +0.000002] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.584 msecs
> [  +0.014555] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.701 msecs
> [  +0.004845] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 26.229 msecs
> [  -0.000001] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 15.120 msecs
> [  +0.000000] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 24.805 msecs
> [  +0.000000] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 6.855 msecs
>
> 3) I then tested the suggestion from Alexei [2] to use a 1msec timeout
> for the in_nmi() path of resilient_queued_spin_lock_slowpath() to see
> if this would improve the NMI timeouts further. And it does (see below
> again). The NMI handler spikes are now much less severe; the outliers
> are gone and everything is between 1-2ms.

I will share patches shortly, but I ended up removing the spinning in
the trylock fallback.

It was partly coming from qspinlock, where it cannot fail, but we can,
and the probability of the trylock succeeding under contention is
really low.
So changing it to a single attempt will address this part.

>
> [  +0.002396] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.580 msecs
> [  +0.001680] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.580 msecs
> [  +0.000077] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.630 msecs
> [  +0.006197] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.756 msecs
> [  +0.000311] hrtimer: interrupt took 4883753 ns
> [  +5.693066] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.973 msecs
> [  +0.246851] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.974 msecs
> [  +0.163526] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.981 msecs
> [  +0.235492] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.996 msecs
> [  +0.816012] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 2.003 msecs
> [  +0.004036] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 2.019 msecs
>
> 4) This result made me curious whether these timings were the result
> of the now-1ms-minimum timeout, or whether something else is going on.
> I added support for a 0 timeout to check_timeout() and updated the
> in_nmi() path to use a 0 timeout like so:
>
>        if (unlikely(idx >=3D _Q_MAX_NODES || in_nmi())) {
>                lockevent_inc(lock_no_node);
> -               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
> +               RES_RESET_TIMEOUT(ts, in_nmi() ? 0 : RES_DEF_TIMEOUT);
>
> This made no difference. The NMI handler warnings still show up, in
> the same ballpark as the previous test:
>
> [Nov26 23:17] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.520 msecs
> [  +0.050890] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.578 msecs
> [  +0.032047] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.580 msecs
> [  +0.110371] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.583 msecs
> [  +0.005776] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.583 msecs
> [  +0.010408] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.610 msecs
> [  +0.084021] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.789 msecs
> [  +0.088464] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.967 msecs
> [  +0.011376] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.968 msecs
> [  +0.057254] INFO: NMI handler (perf_event_nmi_handler) took too long
> to run: 1.973 msecs
>
> 5) This made me think it must be one of the other timeout paths that's
> still being hit here. So I also added the same 0 timeout for the
> _Q_LOCKED_MASK (i.e. the PENDING case):
>
>        if (val & _Q_LOCKED_MASK) {
> -               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
> +               RES_RESET_TIMEOUT(ts, in_nmi() ? 0 : RES_DEF_TIMEOUT);
>
> And with this change, the NMI handler warnings are all gone. There is
> another timeout (timeout * 2, actually) path when the locker is at the
> head of the waitqueue, but I haven't modified that since I wasn't
> hitting any timeouts anymore (but that may just be luck).
>
> I think there are a few issues happening at the same time, which makes
> everything a bit hard to diagnose. My best understanding of the
> issues/situation is currently:
>
> - There is an issue where the NMI hits the race between acquiring the
> lock & grabbing a held lock entry on the fast path that Alexei
> spotted. This is the "recursive lock" case I originally posted about.
> This breaks the AA detector, and *if* you hit this path, you'll stall
> for 250ms+ because whichever timeout you hit inside the slow path will
> not break out early due to the AA detector being broken. This is the
> cause of the *visible* freezes. The patch from Kumar fixes this.
>
> - With that fixed, the *visible* freezes are gone. The AA detector
> properly works in all cases. However, when you hit this same recursive
> lock situation now, *you'll still freeze*, but for ~1ms. This is due
> to how check_timeout() works: it only performs the AA check every 1ms,
> so if the timeout is larger than 1ms, you'll wait for 1ms at a minimum
> before aborting the lock acquisition. These stalls are too short to
> notice by eye, but the NMI handler does catch them. I think this is
> where the ~1-2ms NMI handler warnings are coming from. The AA check
> won't trigger exactly at 1ms; it'll trigger whenever check_timeout()
> is called when at least 1ms has passed, which may be longer than 1ms
> depending on timing.

Yes, I prepped a fix for this, and I think it adds to this delay you
see in NMIs.

>
> - Then there's the 6ms+ NMI warnings mentioned above (i.e. test 2
> where Kumar's patch is applied, but the timeout change from Alexei
> isn't). It's clear from test 3 (Alexei's timeout change) that these
> are caused by the trylock loop in the in_nmi() path, since changing
> the timeout makes these outliers go away. It's also clear that this is
> not the recursive lock situation, since in that case, with Kumar's
> race fix, the AA detector would have aborted the trylock loop after
> ~1ms. I suspect that this is the case Kumar mentioned originally,
> which he can reproduce with the stress test, where spamming NMIs can
> prevent the lock owner from making progress. This would explain the
> variability in the NMI warnings, ranging from a few milliseconds to
> dozens of milliseconds that I've seen. As Kumar mentioned, if you're
> unlucky enough, you might hit the max timeout of 250ms eventually,
> though I think that's unlikely to happen in practice. I *think* these
> stalls are also (or can be?) system freezes, but that they're again
> too short to detect by eye, but I'm not sure about that.

Yes, I think those are simply because of the owner not making progress
quick enough.
Combined with AA checks triggering a ms later, it is possible you hit
multiple NMIs on the owner CPU that end up delaying the owner 1ms each
time while the other CPU in the NMI path spins on the pending bit
waiting.

>
> I don't know whether the changes I made are the right way to go to fix
> this; I made them mainly to gather more information about what's going
> on. Let me know if you want a patch with my changes, but they should
> be pretty straightforward.
>
> I'm now fully set up with a custom kernel workflow, so if there's any
> more tests/changes you'd like to me run, please let me know!

I've posted tentative fixes that aim to resolve all ms delays, and I
no longer see NMI warnings with them for various combinations that I
tried.
It would be great if you can report on what you see with the patch
series applied on your tree.

https://lore.kernel.org/bpf/20251128231543.890923-1-memxor@gmail.com

Thanks a lot!

>
> [1] https://lore.kernel.org/bpf/20251125203253.3287019-1-memxor@gmail.com=
/
> [2] https://lore.kernel.org/bpf/CAADnVQ+WrJ3kwccbwMOkuqvFGJKJzGSoHh_46Kgu=
s8PzH+k9vA@mail.gmail.com/

