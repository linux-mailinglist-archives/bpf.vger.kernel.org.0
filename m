Return-Path: <bpf+bounces-57376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E36AA9DEB
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A5189F348
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956626FA50;
	Mon,  5 May 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgBgUvqV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287201F5858;
	Mon,  5 May 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479966; cv=none; b=Q/ds8jN2nClN3miO/AZfaJ0pyF5eFNfsa0IwF3wGPzec9njBILNm+ELK0nN/BaWtBEFiwUSQCmdsCtVaGMyZrLtuNh6r2BHl4UP1tpuU5RXe81iQaczdUdjr7bQcZFExqTo45CqNQScap1EVZqTEkO/lfAbVlcQtdtSTiBzKARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479966; c=relaxed/simple;
	bh=WA6A66jbSumBpnvo1CcnCAQKj8o6kE3NizSJHiWr8+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcR+EMkNiAMqrlFG0lBQ/xuNyVQU5CgEvX1XPMnV2jQOl9aRvTUdfTOQs5uIcG2OR6Vx5sPzarT5e8P0iLvJLZI4BXGGPczud5nwsqNhoSox5JpRs7MNNjB6Ejn/qATIoZ3th4rBkrn4H4OwKuAqXf2CH42JyYlFFxw90dadozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgBgUvqV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so61713785ad.1;
        Mon, 05 May 2025 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746479964; x=1747084764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTF79k6zfut3vyuBRV47WUrLWL2J4fqa+kyc5623FDw=;
        b=KgBgUvqVbfGFdxwPJ4IJTDSFugR1QnpmiFh7M95txjFwZgt7V2hdwY57hJHjJzj1sy
         ExRXVarYWTt5fUJu3eEPr+aTz7k0yrmc+P42MteoKkwcVY0SLc0aiuM/6q74jtdBGjOH
         BPuWKcH8pjX8GY6mBajQWEbh5W1hrkgDyxwOXd3M7oHOsFDRZFq3ev0l3H3fl149z5SP
         kaxSO2EQpj2uQ1FxVUCgT2zmfarEvaePt1sxGAqjbzuCG6ATLcKt6Dr15vcPYcjIGNEp
         7l1XmkGy/G8jn6Xwp+sGoYWR3kD4jlvEKt+E87+A8mFhiMtClY1uxXziYpMQUEuNZr3i
         txdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746479964; x=1747084764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTF79k6zfut3vyuBRV47WUrLWL2J4fqa+kyc5623FDw=;
        b=Ap1bBzlTGzy2RADPB8Vkt9wzQw/F4I70pyjt9H64/O3cmnQ5fzNjCElMYJF0x2bWr9
         2ZvU33/Se2gOuBIVe7SiiVmvpIvBJPu1gPzG7xK7McyPVNsYMynR1GYVh0vBkEWmrWM2
         7YkpLZNyeQ8xKc/7d7zOUSrXvKVaPJ72/u0WNuFRDaTa4CgEjioexD+E9sgyHW4GP9A5
         snZnTZInMX6+KjE4XU/n2m9ykTcrhqaYqKEj6DHa/oTjSPUHdG0T34TVktitQPD+wpRR
         JqcKxIsEz+mtZ/hfZMb3Hjvzr0HStu5zkvujfjOkyms5YPuUU24QWyYnlZfEwYf/3yR0
         WVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV59dtHAT0a2v8hU1UwbpgSZ4qUtmD1hhUk2mxKqrWxBV8PePmHxA577IId8juvzn8DpznbBl+ZeWxuwJes@vger.kernel.org, AJvYcCVdVVfM+g96T5Y21B6agQOHds420jM+DRgZat8/E+eZ87B6UkkbNb+VbSEKhMvaC0gqUBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvrItW/eKKd0wCFSBz9lFYozrS97oKAjHZj/wXUYESZmkpe/x
	OfzHxdwpHwrcVd4oiTpZfgZzN16k7NxnqS5/i9y8uy+5epbmQulTaYKudhIGZcz3dGmr/Ml+HBO
	neqkbda/IjqXVciNswGSmH/AXtxs=
X-Gm-Gg: ASbGncuzw9azzlKHS8qIgJvMCc2ns3FE5fkwpHqwcT16iKm938qG8pp2LGyxSl8iadZ
	CeDlv69c/tnFxMRkcQA3zneHdftIc0PpNDAa92NP11auuNM7U6BUY5ea/Dji8nOZ755GL9eZnK4
	PS0DToS/P2xfRWyNYRLZn3zFc8GuZ7R+fnRejA+w==
X-Google-Smtp-Source: AGHT+IF8sIfP+b2pX+6nGVhu6p6m8YWE3x1NnyOUcdFc5sb94pwg4KCarjU2wYpAJD1ujHcVYnKTRwkgMKocHg8P61Q=
X-Received: by 2002:a17:903:3ba6:b0:22d:b305:e097 with SMTP id
 d9443c01a7336-22e1eac746emr118775325ad.50.1746479964318; Mon, 05 May 2025
 14:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
 <CAEf4BzZkVg39JqGeuAjypf=WXsOG8JVDS8SSkVLDjHUuHzxoow@mail.gmail.com> <CAP01T754qZJNS7N8Q3dTB-2ApCRPbG1sUU2RpxT4ePFbv9-8=g@mail.gmail.com>
In-Reply-To: <CAP01T754qZJNS7N8Q3dTB-2ApCRPbG1sUU2RpxT4ePFbv9-8=g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 May 2025 14:19:12 -0700
X-Gm-Features: ATxdqUEFZfPbUvdt1GunL_wNNl67r443_SdCxbHf8qX8sPZXXMALz5XG2wrkRLg
Message-ID: <CAEf4BzZWTS6QhgdEGVrkeuJCB26ySaKW1VRgCOgtrB-FG-WdSQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 1:46=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Mon, 5 May 2025 at 21:57, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Sun, May 4, 2025 at 11:40=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > bpf_msleep_interruptible() puts a calling context into an
> > > interruptible sleep.  This function is expected to be used
> > > for testing only (perhaps in conjunction with fault-injection)
> > > to simulate various execution delays or timeouts.
> >
> > I'm a bit worried that we'll be opening a bit too much of an
> > opportunity to arbitrarily slow down kernel in a way that would be
> > actually pretty hard to detect (CPU profilers won't see this, you'd
> > need to rely on off-CPU profiling, which is not as developed as far as
> > profilers go).
> >
> > I understand the appeal, don't get me wrong, but we have no way to
> > enforce "is expected to be used for testing only". It's also all too
> > easy to sleep for a really long time, and there isn't really any
> > reasonable limit that would mitigate this, IMO.
> >
> > If I had to do this for my own testing/fuzzing needs, I'd probably try
> > to go with a custom kfunc provided by my small and trivial kernel
> > module (modules can extend BPF with custom kfuncs). And see if it's
> > useful.
> >
> > One other alternative to enforce the "for testing only" aspect might
> > be a custom kernel config, that would be expected to not make it into
> > production. Though I'd start with the kernel module approach first,
> > probably.
> >
> > P.S. BPF's "sleepable" is really "faultable", where a BPF program
> > might wait (potentially for a long time) for kernel to fault memory
> > in, but that's a bit more well-defined sleeping behavior. Here it's
> > just a random amount of time to put whatever task the BPF program
> > happened to run in the context of, which seems like a much bigger
> > leap. So while we do have sleepable BPF programs, they can't just
> > arbitrarily and voluntarily sleep (at least today).
> >
> > P.P.S. And when you think about this, we do rely on sleepable/trace
> > RCU grace periods to be not controlled so directly and arbitrarily by
> > any one BPF program, while here with bpf_msleep_interruptible() we'll
> > be giving a lot of control to one BPF program to delay resource
> > freeing of all other BPF programs (and not just sleepable ones, mind
> > you: think sleepable hooks running non-sleepable BPF programs, like
> > with sleepable tracepoints of uprobes).
> >
>
> I agree with the sentiment, but I think it's already possible such that
> adding this will neither worsen or improve the status quo.
>
> You can have a userfaultfd in user space, and do a bpf_copy_from_user
> on the address such that you can trap the fault for as long as you
> wish (with rcu_tasks_trace read section open) [0]. I used it in the
> past to reconstruct race conditions.

That's true, but a) you can disable userfaultfd if you can't accept
user-space arbitrarily delaying kernel page fault code path, and b)
you'd have to jump through quite a lot of hoops to achieve this. So
yes, similar issue exists with userfaultfd, but here it's quite a lot
easier to accidentally misuse.

>
>   [0]: https://lore.kernel.org/bpf/20220114163953.1455836-11-memxor@gmail=
.com.
>
> So we probably need a solution to this problem even for 'faulting'
> sleep, perhaps by scoping the read section to the program with SRCU,
> or something similar.

The problem is that whatever flavor of RCU we use, it can't be just
bound to individual programs. RCU is used to protect maps from being
freed too soon, and maps are a shared resource across BPF programs (in
arbitrary configurations that are completely user dependent). So the
solution would have to be a bit more nuanced than just using a
separate RCU domain for a given program or a group of programs,
probably.

>
>
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >  include/linux/bpf.h            |  1 +
> > >  include/uapi/linux/bpf.h       |  9 +++++++++
> > >  kernel/bpf/helpers.c           | 13 +++++++++++++
> > >  kernel/trace/bpf_trace.c       |  2 ++
> > >  tools/include/uapi/linux/bpf.h |  9 +++++++++
> > >  5 files changed, 34 insertions(+)
> > >
> >
> > [...]
> >

