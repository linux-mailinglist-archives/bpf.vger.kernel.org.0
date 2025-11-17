Return-Path: <bpf+bounces-74742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E068C64D7B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7499D244ED
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896113370E1;
	Mon, 17 Nov 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sum0HjGz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BE339714
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392859; cv=none; b=JzFEx3f11jvQMO6rbv+QuNImEFAW1EavJsA2ugVTVyibUuk9nPzUbqSz50671KAlngYN1CraO53eeDTh2yvvSlxtacBLldN0FDeKEvmKwBkVGD+f8WKpARQx99BouhFs8P1PKv8Y1THLkfLvBdmwgiR8ja/3tCPtr6OLRvItgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392859; c=relaxed/simple;
	bh=nBXRJ/Lj6pHLUFwwVnbtUqA95tBUTPdLw2xPFfQxMq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyMkpoG4DqpQkyL70n8ODV5wW7UlUkfBbklmnyKkZc7CbDXa3vj9uKmmHtamoVT7hcP4FI2enc40BME2F1d3eE4HlZj5ZZ7Kn/bCPzcMiA6Ue2UGghlkLwjBxIQFP4ZbRZZ8GNTrbjYj5+cGYXv1sN2Y2XgkiQuAkVFvVAwkhfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sum0HjGz; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso1472835f8f.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 07:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763392856; x=1763997656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kCvOypSRgSH1aaHCxG43EYVQi35m8kcAmfWU/9CkF8=;
        b=Sum0HjGzAcnJXMWt/XxvJ5bo1T6ZudIb/K3EbevhPEsQJjy8mv9a+QdHPx71E9WeXK
         AI5pml0Dds7AYEjeTYUnrjdq9t/1W0ilvLiZUL1SQ/oVWzORhAphXkLTli/0LgAes8QZ
         u6tvIV+SG4ISn0oLpO73xu1ElPM+nwfVCr9hwXiH+GIh0TctjNAZskxZcheHDAR+gsnA
         qOP7NCOwxRuysYzObfvdU0AZX2oJJWRmeu1vf1ipRBDJI15nTIKnZcK9ntZMZdynLQCY
         oRztikWURvwuRFgzVUQou2F1rmsXKtB3V9cXx9EsN2hbu1pdqdqagmicvCNLuWfkCqji
         +t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392856; x=1763997656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kCvOypSRgSH1aaHCxG43EYVQi35m8kcAmfWU/9CkF8=;
        b=JaBDN1nbciWYRdjCeJNQxf7ZgvEjA0I4vQTLONPo2YkQM1/mK5P4PxPM/8oAlax6kJ
         Z+aFFnFzS2uT229j7XUsmMCUsC/7dl0ic02GKgL6b59ySB0lPMhiKGpi/aJToJADVm5a
         3+Kl8Crd9opkoRGCZnT/IbnU0unn+PcMaReJ4I6bmdm7sIjpkyEOZhOo01ylyhnXQe6O
         GRXwXVB+r3DvHEbQxFJk5b4wk2Q5XJ6WP/mS0VWvsAOl5w3XN9khclBmoH+TNZjqp/Ss
         MqYMZSuW65Cy4mbSgT/v3gcN5uZCbbhlUZcoGLj1ACqjIsfkHE0+fV9OOP+CLIcF6g1E
         Lydg==
X-Forwarded-Encrypted: i=1; AJvYcCVl1rsgbfrO7iBvzRMaWFRRBTVKdfHyC471MeQvrSGt6AarvVhcGqFUN/G/XtRwAQvFvto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9D3w4tGPQA7m6VyJdbS7ktogCeiERNWLZWqA0LaGVVxjwiYMt
	FqCCNRPKbbw9bkzkFJoGn8pXerFBrifItURzbwd274qQBqdKD2Zfj93/CTBwafAjOhF5X2rlRbv
	YVbJY7uMdAxJ0N58aDoQXXsb0YqWQRVs=
X-Gm-Gg: ASbGncsejdV20wo7wbz6YJtG5YG1O42LXR5hId5SUCBWP6eP5a7uMSrfBhn/Vk3zJZ8
	exhvUQFCSs1+Buac/71efVzFSG5Tz4P7EWFH24wKRSyXXbN33iswNC3p4THycsQxX0ITXyc0Ki9
	g5KQ2tK+AnFkipGsfDy8YGvs4rBme8pNFweDLdGxI7ye8dvOcOyHQBHyzxMCB3AdRI0q5TPVXBT
	pgJNfr/GbrJUXayb4xUja9v1ac6ddVlq9BbZF3iY3Gicm7umd/W+MnI12TyExw1WwY6hIoStDyx
	m050maWbD3RZ/tayXZxrIdMb
X-Google-Smtp-Source: AGHT+IFSzKx/vUTmdhKWcVO389atLqUwRqzhByZxIiqOEJ3O/ICevGF/Oeb7Tt9yovbUu/S0SQ9Wso3dbAz3BAn3yKA=
X-Received: by 2002:a5d:5885:0:b0:42b:5448:7b07 with SMTP id
 ffacd0b85a97d-42b59345897mr12624473f8f.2.1763392855396; Mon, 17 Nov 2025
 07:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
 <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
 <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com>
 <CAADnVQ+DycJQ7eW_FDE59Qc1SzJseYy2f8yniqh0C354ruLdCw@mail.gmail.com> <CAH6OuBRtCyRhvn4E3yQSqpynoqRiB+sYbiZP1ATqXE4LQDTQmA@mail.gmail.com>
In-Reply-To: <CAH6OuBRtCyRhvn4E3yQSqpynoqRiB+sYbiZP1ATqXE4LQDTQmA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 17 Nov 2025 10:20:18 -0500
X-Gm-Features: AWmQ_bndKnYAFCQanZYFSY8RNfFGIqBnu-Uze_xQ6I0P82qNYW0GL0YO9PStMZM
Message-ID: <CAP01T776rsC_aNF4AijRGDqZRfmeKDbSfFmGYPTYh+zaOuwrWw@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Nov 2025 at 15:11, Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> On Sun, Nov 16, 2025 at 1:23=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Varma
> > <ritesh@superluminal.eu> wrote:
> > >
> > > Hi Alexei,
> > >
> > > Thanks for the info! I wasn't aware of that fix, but I just checked,
> > > and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_64.
> > >
> > > I just installed the kernel sources locally to make sure, and the cod=
e
> > > for rqspinlock matches that of the commit you linked (i.e. the
> > > is_nmi() check added in the commit is there). The code for the relate=
d
> > > commit  164c246 ("rqspinlock: Protect waiters in queue from stalls")
> > > is also present. You can verify this yourself on Fedora's 6.17.1 git
> > > tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6.17.1-=
1/kernel/bpf/rqspinlock.c#L474
> > >
> > > So it's good to know issues have already been fixed in this area sinc=
e
> > > the original commit, but it looks like there's still something lurkin=
g
> > > here. To clarify, I'm not exactly sure which of the various timeout
> > > cases in raw_res_spin_lock_irqsave() this recursive lock situation is
> > > hitting.
> >
> > Ohh. Interesting. It's a new issue then. We thought that
> > that commit fixed it for good.
> > How quickly does your reproducer hit it ?
>
> It reproduces ~instantly on the machines I've tested on, which is a
> bit surprising given the inherently racy nature of this issue.
>
> I've reproduced this on 4 core / 8 threads and 16 core / 32 threads
> machines myself (kernel 6.17.1-300.fc43.x86_64 on both). The user who
> first reported the issue was also on a 16 core / 32 thread machine
> (kernel 6.17.4-200.fc42.x86_64).
>
> I'll be out of town for a few days from tomorrow, but I'll try to put
> together a more complete repro before then if possible. I can also
> provide more diagnostic information if needed.

I think I see the problem, but don't have a good solution except
reverting to a trylock with 0 timeout until we have something better.
Any other value will likely lead to freezes that are as long as the timeout=
.
I can trigger it with the stress test we have in the tree when we
repeatedly spam the CPU with NMIs.

I don't think the problem is when you have reentrancy on the same CPU,
but when you
have a situation as follows:

CPU 0
NMI : tail waiter
Task: random unrelated thing

CPU 1-2
<other waiters in the middle>

CPU 3
NMI: head waiter
Task: Owner

There is no AA deadlock in CPU 0, so we keep spinning.
If the NMI keeps spamming and delaying the owner from making progress
(on multiple CPUs), it is possible to timeout the NMI CPU.
It feels a bit extreme to be able to cause delays up to 250 ms such
that we timeout.

I will look at this in closer detail in a couple of days when I have more t=
ime.


>
> >
> > Kumar,
> > please take a look.

