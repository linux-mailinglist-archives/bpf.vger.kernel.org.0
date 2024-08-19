Return-Path: <bpf+bounces-37543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9749575BE
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26563B216CB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB215956E;
	Mon, 19 Aug 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlO2eKbC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3011158216;
	Mon, 19 Aug 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099712; cv=none; b=fCRgGUl3E3gw3kGZtLurM4o2KAE/vD1n/R97KVcwO8Jl3cA4yfbnzIRDhnmeD6LF81XUNtmEtBfYAvtxtI4rpiAXzjo49QaRnRT+zQo4UJYDvKayZAIez5fZPmOlVy46pSgV37Jx67wq/omFVANmZAHP2qgHhz/sd4Ca2S12EtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099712; c=relaxed/simple;
	bh=Pd4LwYZUpfjrvY2IOV4MUo7zqr83SAkZktPyGVkDZmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgqyaTq1z1+BH3FH5pCoq4XTsG+wYCRzhvXPX3GVdKjYNr2U6MbN2mv6ZYtjdIIStfekR+GKoOtAl9EeZEzw9eG4VyWbG9WTDvtKTe4KUmyFbAChrpGmMthjWzUFHqFmP7zzW2Zn9MYcdKH0NuIK9LLIu5bn7ioykOapAs2jmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlO2eKbC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d46f2816c0so354279a91.2;
        Mon, 19 Aug 2024 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724099710; x=1724704510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH6MJrjwaF1DExwqq1BAG9TBOgQJbeO0AdhOsYCARpQ=;
        b=jlO2eKbCXof7f4BKEavBZX+YnswIPcRFFcSGWps9FMhr2EKqdJTIDvBmwdTigowT7n
         sb3RKC4S+NS2gusjrICQdwiM6xFz5V2dZhr8ICxbmIOV1w6qUWU5tdcd8PNHmSaMcTc6
         NXMqlGTJv9aliysJ2Fe49UWhwkfCMOGSGI+/FFNPj2aj4vbS04xydBJZIgjOjoIMGiqD
         F1cPy/qN4Tz9rmbiNyFnkkg40Xdr+fT2GA6s7+ZZFj3matM/VPEZyDOs14UPfk21n2d0
         nAgWqAMi9CJW6tJTL9Jiv4A6w3YOYplCfaOJ/Izx6N2d79co4che4cpozxK6M3JKstFB
         /lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099710; x=1724704510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH6MJrjwaF1DExwqq1BAG9TBOgQJbeO0AdhOsYCARpQ=;
        b=iQfZN2EWyjxlnxNpPAYiJ8Aa4KXfkqUdnG3YkGTClvpt7Hb6s/O9e6A3yafm6lDEyt
         XTOgUQjIsvMJXJrlH2hY0pHmLYFoT3HhByFCbYrQE+oPjqwYjXB1Q3lFc7Dcb8Lq4H+T
         wa1URh6tA2v4J2vfwDjOvwig7kA3hhVXGAPezKR9nnEfcOzOZz9M3bVkaphE4NxvQRyN
         hMLEcqkmEz3D4Kv3ZZfO2CzHmm5IYJu+cWGOFLR5wMssCIB02JqBZ+Vhs1qv0CYMzyrs
         UtHesnWa9H9dpqeS5oYPRsyzqNgTtiGO5KpIkQhOuLjv1byV+uyOU1bO0iuDOIb3KQbK
         YRCg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9VAEPGWWDAiCXMVxHuMdyLReUec9jyBCPOZDTVQL4nVQ88u27hSnAfrHprP0QAwdRNM+XzsBGkpHkQJ/BmwzjZT/6gfJpvVFyzKXR/SbzqyUhPVBasVdOjpetE3560KqpYk5RT9TuG5JIHv9aIg65BOSSf/OnUc2uVgFjyQkWqnIBDSu
X-Gm-Message-State: AOJu0YwX5j0lV01bgevkzMWK5KeMob/tJDfu5f+6LY36GrRQYNlDF098
	XIDIwnVv1M+739lOSbgH4dwuMHabRQjDWnMiV2UKsrHzpsOoXsfCKt3atixY6O2MjrFBLn3uKN5
	EYaeLwsiHNc7xlDH2LqPkYDbt2Xk=
X-Google-Smtp-Source: AGHT+IGUFaAMZSC62zrt9/XK41cBx3H4cq8e6deI++UilY88ciWZUojNh5L48XclPwKgVRRXTxRm7ziIqLii28R7Rmk=
X-Received: by 2002:a17:90a:bc81:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2d3dfc75e41mr13272600a91.20.1724099710147; Mon, 19 Aug 2024
 13:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-10-andrii@kernel.org>
 <20240819134107.GB3515@redhat.com>
In-Reply-To: <20240819134107.GB3515@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 13:34:57 -0700
Message-ID: <CAEf4BzYFXmCU83mr9YHy2JtF35WmYBvKpyrmBV4QxFuqubk_6A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/13] uprobes: SRCU-protect uretprobe lifetime
 (with timeout)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:41=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/12, Andrii Nakryiko wrote:
> >
> > Avoid taking refcount on uprobe in prepare_uretprobe(), instead take
> > uretprobe-specific SRCU lock and keep it active as kernel transfers
> > control back to user space.
> ...
> >  include/linux/uprobes.h |  49 ++++++-
> >  kernel/events/uprobes.c | 294 ++++++++++++++++++++++++++++++++++------
> >  2 files changed, 301 insertions(+), 42 deletions(-)
>
> Oh. To be honest I don't like this patch.
>
> I would like to know what other reviewers think, but to me it adds too ma=
ny
> complications that I can't even fully understand...

Which parts? The atomic xchg() and cmpxchg() parts? What exactly do
you feel like you don't fully understand?

>
> And how much does it help performance-wise?

A lot, as we increase uprobe parallelism. Here's a subset of
benchmarks for 1-4, 8, 16, 32, 64, and 80 threads firing uretprobe.
With and without this SRCU change, but including all the other
changes, including the lockless VMA lookup. It's noticeable already
with just two competing CPUs/threads, and it just gets much worse from
there.

Of course in production you shouldn't come close to such rates of
uprobe/uretprobe firing, so this is definitely a microbenchmark
emphasizing the sharing between CPUs, but it still adds up. And we do
have production use cases that would like to fire uprobes at 100K+ per
second rates.

WITH SRCU for uretprobes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uretprobe-nop         ( 1 cpus):    1.968 =C2=B1 0.001M/s  (  1.968M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.739 =C2=B1 0.003M/s  (  1.869M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.616 =C2=B1 0.003M/s  (  1.872M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.286 =C2=B1 0.002M/s  (  1.822M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.657 =C2=B1 0.007M/s  (  1.707M/s/cpu)
uretprobe-nop         (32 cpus):   45.305 =C2=B1 0.066M/s  (  1.416M/s/cpu)
uretprobe-nop         (64 cpus):   42.390 =C2=B1 0.922M/s  (  0.662M/s/cpu)
uretprobe-nop         (80 cpus):   47.554 =C2=B1 2.411M/s  (  0.594M/s/cpu)

WITHOUT SRCU for uretprobes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
uretprobe-nop         ( 1 cpus):    2.197 =C2=B1 0.002M/s  (  2.197M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.325 =C2=B1 0.001M/s  (  1.662M/s/cpu)
uretprobe-nop         ( 3 cpus):    4.129 =C2=B1 0.002M/s  (  1.376M/s/cpu)
uretprobe-nop         ( 4 cpus):    6.180 =C2=B1 0.003M/s  (  1.545M/s/cpu)
uretprobe-nop         ( 8 cpus):    7.323 =C2=B1 0.005M/s  (  0.915M/s/cpu)
uretprobe-nop         (16 cpus):    6.943 =C2=B1 0.005M/s  (  0.434M/s/cpu)
uretprobe-nop         (32 cpus):    5.931 =C2=B1 0.014M/s  (  0.185M/s/cpu)
uretprobe-nop         (64 cpus):    5.145 =C2=B1 0.003M/s  (  0.080M/s/cpu)
uretprobe-nop         (80 cpus):    4.925 =C2=B1 0.005M/s  (  0.062M/s/cpu)

>
> I'll try to take another look, and I'll try to think about other approach=
es,
> not that I have something better in mind...

Ok.

>
>
> But lets forgets this patch for the moment. The next one adds even more
> complications, and I think it doesn't make sense.
>

"Even more complications" is a bit of an overstatement. It just
applies everything we do for uretprobes in this patch to a very
straightforward single-stepped case.

> As I have already mentioned in the previous discussions, we can simply ki=
ll
> utask->active_uprobe. And utask->auprobe.

I don't have anything against that, in principle, but let's benchmark
and test that thoroughly. I'm a bit uneasy about the possibility that
some arch-specific code will do container_of() on this arch_uprobe in
order to get to uprobe, we'd need to audit all the code to make sure
that can't happen. Also it's a bit unfortunate that we have to assume
that struct arch_uprobe is small on all architectures, and there is no
code that assumes it can't be moved, etc, etc. (I also don't get why
you need memcpy

>
> So can't we start with the patch below? On top of your 08/13. It doesn't =
kill
> utask->auprobe yet, this needs a bit more trivial changes.
>
> What do you think?

I think that single-stepped case isn't the main use case (typically
uprobe/uretprobe will be installed on nop or push %rbp, both
emulated). uretprobes, though, are the main use case (along with
optimized entry uprobes). So what we do about single-stepped is a bit
secondary (for me, looking at production use cases).

But we do need to do something with uretprobes first and foremost.

>
> Oleg.
>
> -------------------------------------------------------------------------=
------
> From d7cb674eb6f7bb891408b2b6a5fb872a6c2f0f6c Mon Sep 17 00:00:00 2001
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Mon, 19 Aug 2024 15:34:55 +0200
> Subject: [RFC PATCH] uprobe: kill uprobe_task->active_uprobe
>
> Untested, not for inclusion yet, and I need to split it into 2 changes.
> It does 2 simple things:
>
>         1. active_uprobe !=3D NULL is possible if and only if utask->stat=
e !=3D 0,
>            so it turns the active_uprobe checks into the utask->state che=
cks.
>
>         2. handle_singlestep() doesn't really need ->active_uprobe, it on=
ly
>            needs uprobe->arch which is "const" after prepare_uprobe().
>
>            So this patch adds the new "arch_uprobe uarch" member into uta=
sk
>            and changes pre_ssout() to do memcpy(&utask->uarch, &uprobe->a=
rch).
> ---
>  include/linux/uprobes.h |  2 +-
>  kernel/events/uprobes.c | 37 +++++++++++--------------------------
>  2 files changed, 12 insertions(+), 27 deletions(-)

[...]

