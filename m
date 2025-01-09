Return-Path: <bpf+bounces-48355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96BA06C83
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22409188541B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C814B942;
	Thu,  9 Jan 2025 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCdz8g1y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110D23CE;
	Thu,  9 Jan 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394823; cv=none; b=iOOrAJpImqzpp0QjOxEwmLaDnYJWw1ZWOz2E482I4KvMqo6l2I9zLCwfnW0pG0AzLTlaGvL5ZgmcxcdQ6pjLCWkcif9bkdkLyxTMIvkdaE/TLpPsVqImd2MKR0pOf/lBjYG3hkuZpNeC+7BUcS1vi8OovhAMVMjq6ihiSrbVcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394823; c=relaxed/simple;
	bh=lHAly9D4BPUf+yA5M6vfzhrgsalMMqdhulGPfhiCNnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHEQEwDpkwPoV2IfjERRJjHcxpzcWoR0z+JHSNnTv4Y+3ntZe8TGZneBKifjgQbIU8iXhmLKV0N29LXjObG5bBDmviZKKpztKgmpIR5YvREMrEF9Gd9cX87+zPuAlaI92IM/BzFJ2SKDNDonsA3cFzo9+fCXGppgavXwgAIcXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCdz8g1y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e87b25f0so1013467f8f.0;
        Wed, 08 Jan 2025 19:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736394820; x=1736999620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHAly9D4BPUf+yA5M6vfzhrgsalMMqdhulGPfhiCNnk=;
        b=LCdz8g1yoc/DmThNY0olfNMnp5U8UxCYLc/fRTo/LeaxxePRV29LDsMO8NjH4ubgm5
         /W9dUnHgAPbCa2MpiHqx03qkq5vJZxFf19v/sg6X8+wgrUmWfO7cExWy+UIStUOYc4Z0
         2YNPV0tV6PrxUL+38exApwkwPG7IL3Fs7uJvTnmEusTsuhhGaobGpsmIxCkafs7FmyYI
         eySG5M6CIpuDsv6DZFacrv0fZePKoM/8L4p/f0HA3bN1ESoObwp0mE/tT1LE8k/Qn94J
         l94d3ZHcZYXNhcN2DtEQjMOSLDoc89udA3dj7lNOJbJfziIVMxH9aJcEFV+RAkjUV1aR
         sAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736394820; x=1736999620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHAly9D4BPUf+yA5M6vfzhrgsalMMqdhulGPfhiCNnk=;
        b=GEKuy+/8Sdv7oEinmkMwxp2A8Lree+PoVe51HB2imM0BJEYHKBBsije5kE1RTu0OPN
         PJHR84myV3mZx7IirbB3SNB9xYFT3lHKllYEKrUqFAFggBZOtxY7oKtZkiiqge8EtfbU
         yYWUgXp+JQOPkX4gZq44mKCe6WxZZNYdhdfxlwWiwARV/huR7YRIKkXs+IrPWSR7jIkw
         LqqayABM06yFk45MhE7jJdG8E/7geU00u2/fQDhlGe724d3eQyDnr2cmjBClvYYelMWg
         JVsVNLU+y/BxifbdSe55goF7jO4V1e6AreGrn7ZBVlicKR6JprG7eFQuWBEtk9+BTFYE
         Gpag==
X-Forwarded-Encrypted: i=1; AJvYcCVyXcN5M4/G2dNJLR/yJi5Kbgl5+Os+uaDNX9vt9noTJ+SpoZER50Qa7uMx9bq3n09K1kY=@vger.kernel.org, AJvYcCWjJQ3bd2JUy6eO7Xj+Wpjkq3igSZzBBRUwW8rgW/+2iwo1kbFdwvKSd3J9Y/IJqtYFb2u0Up5LwDuDfgDN@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPSFexX2s1B/g7YvXKbbL7xGkXpXoh1Z9lRnD/Avh35PRSGhH
	zdDZLmwJB//89dhx+9D1QodDp8H6xtJQi8VlKsrK37Hn4yut9JgqFCq0VtekvfSSgcVoaPGcdT0
	24ceCbQjpc/GfPEw+BOK7lJiAHKw=
X-Gm-Gg: ASbGncsozHEWJmxY3UK1OqVgWRA3TJc5qHbJkJFr6tqwkTeK776KYLMpdnd40fZcnF8
	SQ6dhbf1cD+7PwvL2AkzgukhntXFunMHMsfhcXyvdD1D9iqpdYkZTc28+xUslmKGbIJMaGg==
X-Google-Smtp-Source: AGHT+IGSrNEyfosrTzLXJXgQsRKGwjgc1HnlqLonoXqb8Cavh6CagKy369bXPdb6sKd8MiE7PF8cmBgKvEPx3CfN3qI=
X-Received: by 2002:a05:6000:154f:b0:386:32ca:7b5e with SMTP id
 ffacd0b85a97d-38a8b0e5092mr1074754f8f.16.1736394819924; Wed, 08 Jan 2025
 19:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-13-memxor@gmail.com>
 <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com> <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
 <dfbaf200-7c87-41b2-ab87-906cbdf3e0d7@redhat.com> <CAADnVQJdPNOOXzQvTTx_i4yYYAoOKe=u7yHJiRHSt8O13vp6VA@mail.gmail.com>
 <7f1c3db7-a958-4bb5-b552-a20fb5b60a2e@redhat.com> <CAADnVQ+_eBZo5yTWpEd2pdv-dd3x=KEbqU=8awbyW3=9wm9nUA@mail.gmail.com>
 <0c239aaf-ad07-4be2-a608-0d484bc7fe95@redhat.com>
In-Reply-To: <0c239aaf-ad07-4be2-a608-0d484bc7fe95@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 19:53:29 -0800
X-Gm-Features: AbW1kvZfX8VYkvLQJzkqdduhp0Ds50FFxROLdUORTCJpaQHLdYVPbSYIq-gR_wE
Message-ID: <CAADnVQKDg3=cKmjqrQ7YraaW6STckj_w=1yU4oDZ7T+miMvgpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for CONFIG_PARAVIRT
To: Waiman Long <llong@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:46=E2=80=AFPM Waiman Long <llong@redhat.com> wrote=
:
>
> >>>> As for the locking semantics allowed by the BPF verifier, is it poss=
ible
> >>>> to enforce the strict locking rules for PREEMPT_RT kernel and use th=
e
> >>>> relaxed semantics for non-PREEMPT_RT kernel. We don't want the loadi=
ng
> >>>> of an arbitrary BPF program to break the latency guarantee of a
> >>>> PREEMPT_RT kernel.
> >>> Not really.
> >>> root can load silly bpf progs that take significant
> >>> amount time without abusing spinlocks.
> >>> Like 100k integer divides or a sequence of thousands of calls to map_=
update.
> >>> Long runtime of broken progs is a known issue.
> >>> We're working on a runtime termination check/watchdog that
> >>> will detect long running progs and will terminate them.
> >>> Safe termination is tricky, as you can imagine.
> >> Right.
> >>
> >> In that case, we just have to warn users that they can load BPF prog a=
t
> >> their own risk and PREEMPT_RT kernel may break its latency guarantee.
> > Let's not open this can of worms.
> > There will be a proper watchdog eventually.
> > If we start to warn, when do we warn? On any bpf program loaded?
> > How about classic BPF ? tcpdump and seccomp ? They are limited
> > to 4k instructions, but folks can abuse that too.
>
> My intention is to document this somewhere, not to print out a warning
> in the kernel dmesg log.

Document what exactly?
"Loading arbitrary BPF program may break the latency guarantee of PREEMPT_R=
T"
?
That's not helpful to anyone.
Especially it undermines the giant effort we did together
with RT folks to make bpf behave well on RT.
For a long time bpf was the only user of migrate_disable().
Some of XDP bits got friendly to RT only in the last release. Etc.

