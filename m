Return-Path: <bpf+bounces-45632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEC9D9D2D
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF34D28315F
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A11DDC28;
	Tue, 26 Nov 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEGzwAHW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91F1DDC03
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644793; cv=none; b=qXCgqfIUTH1Do4nkgeB2eNoAo+tTQw9wujh0K7zp53j14BDGvJqsM4UE5DGlpdHi67839zUJtmIKAu6xnPX80ctKF4IwOViXThkgqwQx8dutWVltRXlPXbmEdhagROH4ou/kQBFJPwL/nJMQam+gQ+XErlrlOW5pA2cTCC9Evs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644793; c=relaxed/simple;
	bh=Myqkm6O1vWK41AgqKUL2HTzbJ3bOYSkgP/7eOuGwOOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROQcTTKXeuTRiQf2raVdMlVQmm2N2EoFHcAeFynB7kM7ZYOtiMs3WMA35OmQzzOONkSRG/rMyfI5SKjLvQuElLs3te4cpxN1iEpA7i2LETsKrYK/TXeX0OGddTM/mhGBzCQNFSmc+dVHsiD31jewQjUkMRzut55x6+Yv6MAazss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEGzwAHW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so4040747a12.2
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732644791; x=1733249591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myqkm6O1vWK41AgqKUL2HTzbJ3bOYSkgP/7eOuGwOOg=;
        b=YEGzwAHWNB6jqOJ7AFf4LonE8211+5UZejqj4qV3He6y/3VyNffbij4gGTnW6WldvR
         jIX0YdZeVjXPKudwkywpFFgYttAqHGJqamHufYmBYewOl0GqDJni62qZW+r/03IhsgXR
         okI/c9j9UpiCMSqnZ4KKkvAEWzWt3zGhZvOFkpHJ0QAfFKbfeL18bYP4dyXdtLj5n4j5
         y8A5k+M9F0pQ6F9OERt4H41abpj7sL0jlwtXyiRngga1Ua80BFIjBsVmaFyg09b5Hz+r
         McuVVCTxK4sMJ59wDNY6kSkgBcVoPBQnm3xAu7RfzALm3bbNodSFZ/n8Lr3lXKHet1Yg
         v7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644791; x=1733249591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Myqkm6O1vWK41AgqKUL2HTzbJ3bOYSkgP/7eOuGwOOg=;
        b=qSwADjdQx8Lt1N2RP1u1eIN+CinEy+szwjsI4CcdPhIlo0CrOD+xwV5PDQZAnq+NZs
         hT64pR1BMabj5PveOJnS30o8bKADBtoU7ocWuVWNezbStr0Vdv/MbhO6aa04j4bf2crk
         hHanUfNgACFRclZUzKlmMnDsj8uknyRDcWdbfpfBIVxjcVP78WtUwCENi+f6Zotc01A3
         VZQu8+PTHjeCGn8eT/hP9SLa0e967F13vrFX0Dy90/r7bcjtwDWdxYF1IbrMXOX2pDd0
         IKRgxpgcB520pZSNWdwyD/2K1pVYn7FHu0MS6ie+sBFFdNCJVu6EEApYfvbaG8SvXXTO
         h5rA==
X-Forwarded-Encrypted: i=1; AJvYcCUO1NwokEDJI7YGU/ZIPnRmXb2GeCCDbbBSAaoUAs/VX/tx8zUhYwzOjnaTlv8PpdQUi8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dzB5Rx1MRpMqspnHLiKDiI5tZdRukHWRNd5BzsepsEpkKl5X
	JI73SC1EqlL4qXBDUMr35NRrZ5yQr5ZZ0UsUsYZE2xgKlfITc3aoAfH3GGH0ZNP+Mny9E00jVaZ
	E8+sloLKFXDSyuvfzZMhHzUfsvj0=
X-Gm-Gg: ASbGncs36nFGBpNNSSDC09ZhWEcXE5XZ88hQblGD2AyHTeRWCM4VzK20laoCkJy2zH0
	YTE33Y6LJhFXc6E4BaWXD2sxjmYCrMqjOqOp3ma3Y9Wkgam8=
X-Google-Smtp-Source: AGHT+IGgOy1+dN4gLgH9YDxX1dwYKIZT+knPVr1/AUlLSr58w8xo6H4kQz7gzzctyrm0rHZHqCyFoBb4a2Vvpxkg6RY=
X-Received: by 2002:a17:90b:1bcb:b0:2ea:9cd6:985d with SMTP id
 98e67ed59e1d1-2ee097e33c3mr264624a91.35.1732644790943; Tue, 26 Nov 2024
 10:13:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121000814.3821326-1-vadfed@meta.com> <20241122113409.GV24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122113409.GV24774@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 10:12:57 -0800
Message-ID: <CAEf4BzYa5_jOhY3oDgJ-R4jhX7K+EmhcKQAt0VdDeNnpXicJ4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 0/4] bpf: add cpu cycles kfuncss
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yonghong Song <yonghong.song@linux.dev>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Mykola Lysenko <mykolal@fb.com>, x86@kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Nov 20, 2024 at 04:08:10PM -0800, Vadim Fedorenko wrote:
> > This patchset adds 2 kfuncs to provide a way to precisely measure the
> > time spent running some code. The first patch provides a way to get cpu
> > cycles counter which is used to feed CLOCK_MONOTONIC_RAW. On x86
> > architecture it is effectively rdtsc_ordered() function while on other
> > architectures it falls back to __arch_get_hw_counter(). The second patc=
h
> > adds a kfunc to convert cpu cycles to nanoseconds using shift/mult
> > constants discovered by kernel. The main use-case for this kfunc is to
> > convert deltas of timestamp counter values into nanoseconds. It is not
> > supposed to get CLOCK_MONOTONIC_RAW values as offset part is skipped.
> > JIT version is done for x86 for now, on other architectures it falls
> > back to slightly simplified version of vdso_calc_ns.
>
> So having now read this. I'm still left wondering why you would want to
> do this.
>
> Is this just debug stuff, for when you're doing a poor man's profile
> run? If it is, why do we care about all the precision or the ns. And why
> aren't you using perf?

No, it's not debug stuff. It's meant to be used in production for
measuring durations of whatever is needed. Like uprobe entry/exit
duration, or time between scheduling switches, etc.

Vadim emphasizes benchmarking at scale, but that's a bit misleading.
It's not "benchmarking", it's measuring durations of relevant pairs of
events. In production and at scale, so the unnecessary overhead all
adds up. We'd like to have the minimal possible overhead for this time
passage measurement. And some durations are very brief, so precision
matters as well. And given this is meant to be later used to do
aggregation and comparison across large swaths of production hosts, we
have to have comparable units, which is why nanoseconds and not some
abstract "time cycles".

Does this address your concerns?

>
> Is it something else?
>
> Again, what are you going to do with this information?

There are many specific uses, all of which currently use pairs of
bpf_ktime_get_ns() helper calls, which calls into
ktime_get_mono_fast_ns(). These new kfuncs are meant to be a faster
replacement for 2 x bpf_ktime_get_ns() calls.

The information itself is collected and emitted into a centralized
data storage and querying system used by tons of engineers for
whatever they need. I'm not sure we need to go into specific
individual use cases. There are tons and they all vary. The common
need is to measure real wallclock time passage.

