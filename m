Return-Path: <bpf+bounces-75152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D5C7345F
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8CA702FFBC
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836E2E2F14;
	Thu, 20 Nov 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="T75tIBoc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249832D97B0
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631976; cv=none; b=sVncCwHH9beXo2gqI++XYlKq+1ANQmc6d3m2NtqN7+EAymbL8DtyE+Xb2DPSt4qSX8zLMXOTZ4j70NMunl5pAntpHg6KGvPrwPJhlDUesqiDtsArKyWBUZNLhtwYkf3m+7DQsbhMEjpl/SW/OTXyaWXzNeGck2+eaz4VutV0+fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631976; c=relaxed/simple;
	bh=9+niiAnngx/rlywbdD9CIvmowHRcuQHQk35EMneTUlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTIGM606IYwDsl5Q/iCSDWzRbPubMzi/06dg6DbaplLZyC9wVs0zJByQbIsiIt3ZPIIlVK8BuIIS6r9SMdRLzjAWFEXs99WHYOBT4U/919bYrO7mW49wUb7jgBGIlooNLuSn0QNxllYFUxbz8x08sdVoXnbikI2FJyJHmn5Fbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=T75tIBoc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3437af8444cso671308a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 01:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1763631970; x=1764236770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI20jKZgtKNtZ+bsUab+HqytBKDrmCB7m9DvF93LWuQ=;
        b=T75tIBoc5QxhJb+NMlmJmFhBIDMX0Is6Xj43XPcCBvewxcM+gacsQpOo/n1Q285fDt
         HpmzWJp7q9dgodfHfvFhVWtT2X8BQU81uiZ3n1/XPzXl/7LEsuleTRxywaGJUA0l5SiT
         XrMM8lgB3yuPs5zxibLRReO10e0X043T69ZHC7LEb1+O0n/ox9HUWLxOY8d8qB3hsyGq
         F+xmOgITHpoTba48qW6Wpn8Pr4a5mKrwjuqSWB2X6zRCrHK+TnG/5QXNmzhU+Dx4hu6k
         MlbQZ4UGGPCKQJ0ce2Epx2zr5zX0nimz7n+2nwaDpJ/C9Gr2AJ586xjREHOqlLgKauLc
         F+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763631970; x=1764236770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GI20jKZgtKNtZ+bsUab+HqytBKDrmCB7m9DvF93LWuQ=;
        b=wlY2dCiWcZLOGzIWVq1CB5w/GI1WfMeukskpO//x2dDmzYzBIqPFBKSPPIat4Vxkt2
         RoXcFRtkEvjZy34WvY9vhRvs/HjGCXkydQBVyyzlmN0OHFLMScttyo4+z+NTRACEGA4W
         xjGT+Xal37Z1ZxFM24cRXyHG1jYOqvlDa5T37mqUkreHSgwY8Srp+g1cLjiuEevlsU3W
         irDkyww4H0gR7s/rYQAdf/hpWI+q+ms4JV+HTwUI6ggmQyWCQg2QzcirYLZAHlnk6C+3
         S2hFNpjbgw73sdq6Att7Fw3VOLEwC5d/fmL/EE8ZIh1mFRRMfQAMqKYo5QS8f6bfQg+f
         PSwA==
X-Forwarded-Encrypted: i=1; AJvYcCUP+6UKKo8SMXW8a/pJ9LfWKS1qKS72wjUdVJ9EzdctvaTVDGPpjR+vuaD266RZ4SO18lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3umshUDXsobNg3nsr2UioqNNM6gzn+tq8poRre/Z6x7GBEhQA
	3QArTQRBNv5EEhYPfywL3CKAaZIITwc7SromPiYRMAFFMjYxlhpmV9bOi5yKIvBKCkd9pM+MNN+
	0zHMa9TF0oUx9tg473FkfzN8asyksNF8gzhaXj/a1uA==
X-Gm-Gg: ASbGncvKbjIxj+Wvdsk+8uy12DTSWkM3jNt+3QYcCEEJOJm/rZ8fEopjWUPics+7rcP
	znOJ/dz5wtJjg+Ygi9o9IQ6fP+z7E3fwhinCr9tO4y7xS4vOohKCIEt162qiAyvoxu7poYsDRAH
	2cnsjIoOhPhp6PXu3N17w5+vP3JfOiMqprzgy6i6H07B+vr5qAQEPkKFIHlK6U7cm0jEIjCLpvN
	L9bUuz5Ln8irxhvZpUD1BUP1nH3f12v6QazAiFxs1RTED+GecIUeWeS25tFRTE8eDTn3tb/
X-Google-Smtp-Source: AGHT+IELpUkfB2bjRwtAYNFmLHodBnmIt5n9VTgXmF7/yZbkxisQvAOk/egHga+jMz6ZDEujwfFVCgrQfvGbcuEL3m0=
X-Received: by 2002:a17:90b:3bc6:b0:341:88ba:bdda with SMTP id
 98e67ed59e1d1-34728518cb1mr2418585a91.31.1763631970066; Thu, 20 Nov 2025
 01:46:10 -0800 (PST)
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
 <CAH6OuBRtCyRhvn4E3yQSqpynoqRiB+sYbiZP1ATqXE4LQDTQmA@mail.gmail.com> <CAP01T776rsC_aNF4AijRGDqZRfmeKDbSfFmGYPTYh+zaOuwrWw@mail.gmail.com>
In-Reply-To: <CAP01T776rsC_aNF4AijRGDqZRfmeKDbSfFmGYPTYh+zaOuwrWw@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Thu, 20 Nov 2025 10:45:59 +0100
X-Gm-Features: AWmQ_bl__Y6gZ-_i4DPQARHyoOJNw538rQIUnq01GFO3J8Kq3JTyDfBShEsbz5s
Message-ID: <CAH6OuBQ3UY7AHHp1ZMacMO6zq4YFsi=ycqE_FPSZGBm0FRnuVg@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:20=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sun, 16 Nov 2025 at 15:11, Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Varma
> > > <ritesh@superluminal.eu> wrote:
> > > >
> > > > Hi Alexei,
> > > >
> > > > Thanks for the info! I wasn't aware of that fix, but I just checked=
,
> > > > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_64.
> > > >
> > > > I just installed the kernel sources locally to make sure, and the c=
ode
> > > > for rqspinlock matches that of the commit you linked (i.e. the
> > > > is_nmi() check added in the commit is there). The code for the rela=
ted
> > > > commit  164c246 ("rqspinlock: Protect waiters in queue from stalls"=
)
> > > > is also present. You can verify this yourself on Fedora's 6.17.1 gi=
t
> > > > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6.17.=
1-1/kernel/bpf/rqspinlock.c#L474
> > > >
> > > > So it's good to know issues have already been fixed in this area si=
nce
> > > > the original commit, but it looks like there's still something lurk=
ing
> > > > here. To clarify, I'm not exactly sure which of the various timeout
> > > > cases in raw_res_spin_lock_irqsave() this recursive lock situation =
is
> > > > hitting.
> > >
> > > Ohh. Interesting. It's a new issue then. We thought that
> > > that commit fixed it for good.
> > > How quickly does your reproducer hit it ?
> >
> > It reproduces ~instantly on the machines I've tested on, which is a
> > bit surprising given the inherently racy nature of this issue.
> >
> > I've reproduced this on 4 core / 8 threads and 16 core / 32 threads
> > machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The user who
> > first reported the issue was also on a 16 core / 32 thread machine
> > (kernel 6.17.4-200.fc42.x86_64).
> >
> > I'll be out of town for a few days from tomorrow, but I'll try to put
> > together a more complete repro before then if possible. I can also
> > provide more diagnostic information if needed.
>
> I think I see the problem, but don't have a good solution except
> reverting to a trylock with 0 timeout until we have something better.
> Any other value will likely lead to freezes that are as long as the timeo=
ut.
> I can trigger it with the stress test we have in the tree when we
> repeatedly spam the CPU with NMIs.
>
> I don't think the problem is when you have reentrancy on the same CPU,
> but when you
> have a situation as follows:
>
> CPU 0
> NMI : tail waiter
> Task: random unrelated thing
>
> CPU 1-2
> <other waiters in the middle>
>
> CPU 3
> NMI: head waiter
> Task: Owner
>
> There is no AA deadlock in CPU 0, so we keep spinning.
> If the NMI keeps spamming and delaying the owner from making progress
> (on multiple CPUs), it is possible to timeout the NMI CPU.
> It feels a bit extreme to be able to cause delays up to 250 ms such
> that we timeout.
>
> I will look at this in closer detail in a couple of days when I have more=
 time.
>

Thanks for the update (and sorry for the late response -- I was out of town=
).

Great to hear you were able to repro, though I wonder if it's exactly
the same issue we're hitting. In our case, we were able to "fix" this
issue on our side purely by preventing reentrancy via the sampling NMI
using a per-CPU map to flag whether that CPU is already executing
another eBPF program. Something like this, expanding on my repro from
before:

struct {
    __uint(type, BPF_MAP_TYPE_RINGBUF);
    __uint(max_entries, 512 * 1024 * 1024);
} ringBuffer SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
    __uint(max_entries, 1);
    __type(key, u32);
    __type(value, bool);
} sRecursionFlag SEC(".maps");

SEC("tp_btf/sched_switch")
int cswitch(struct bpf_raw_tracepoint_args* inContext)
{
    u32 zero =3D 0;
    bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag, &zero=
);
    if (*isAlreadyInHandler)
        return 0;

    *isAlreadyInHandler =3D true;

    struct CSwitchEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
sizeof(struct CSwitchEvent), 0);
    if (event =3D=3D NULL)
    {
        *isAlreadyInHandler =3D false;
        return 1;
    }

    bpf_ringbuf_submit(event, 0);

    *isAlreadyInHandler =3D false;
    return 0;
}

SEC("perf_event")
int sample(struct bpf_perf_event_data* inContext)
{
    u32 zero =3D 0;
    bool* isAlreadyInHandler =3D bpf_map_lookup_elem(&sRecursionFlag, &zero=
);
    if (*isAlreadyInHandler)
        return 0;

    *isAlreadyInHandler =3D true;

    struct SampleEvent* event =3D bpf_ringbuf_reserve(&ringBuffer,
sizeof(struct SampleEvent), 0);
    if (event =3D=3D NULL)
    {
        *isAlreadyInHandler =3D false;
        return 1;
    }

    bpf_ringbuf_submit(event, 0);

    *isAlreadyInHandler =3D false;
    return 0;
}

(note the addition of the sRecursionFlag per-CPU map and the
reentrancy checks in both programs)

If the issue really isn't same-CPU reentrancy as you mention, then I
don't understand why this workaround would "fix" the issue; due to the
usage of the per-CPU map, this can *only* prevent reentrancy on the
same CPU.

You are right though that in this case, you would expect it to hit the
AA deadlock detection case when it goes into the timeout loop, which I
can't explain why it isn't hitting that either.

If it's helpful, I can put some time into putting together a more
self-contained repro now that I'm back. Let me know if you think that
would be of use.

