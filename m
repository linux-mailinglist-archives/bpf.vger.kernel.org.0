Return-Path: <bpf+bounces-56542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2632A99AA3
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C45F188AC8D
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB61FBCBE;
	Wed, 23 Apr 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw9nxqTh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BDA1CD1E1;
	Wed, 23 Apr 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443299; cv=none; b=KfYbbjfaoP8zXWClEk+8TUti1cc0ADZQQlCwcar3dK5Q5b0hsbox2xVr7aoATbFac5KzpeJIwNcbsKywkkHzVANFl1zSltoYiwB1DvZtpQTfCiPl24c+rhL5F47YoFlDnXoCWtCx2a+Tza72i9jb+Eb68IoAJgo7v6Oad7kj0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443299; c=relaxed/simple;
	bh=zkMWQVZ5NbGUhdn187Fzed6/TVqS8qNaX0QVXio25A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak92QzXlgTyqbQhbnUH1r1wdNjdlZmGlhfW++r777UKTRdeuWQcNJcc6OKReNmEvPMFs0/XUJFaky2eIRR897hVSxrajxhCR409+s5yEY7x2awn2sxTMyeDYczG5EoCGqIkL6J1/ccYJIe+s/j+huF+3a4JH+qdFmpcx54H6xSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw9nxqTh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so217313b3a.3;
        Wed, 23 Apr 2025 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745443297; x=1746048097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkMWQVZ5NbGUhdn187Fzed6/TVqS8qNaX0QVXio25A0=;
        b=cw9nxqThUtzfdJLZaRXrOoNY51RL1DaXKjykaBam5edbsnjMwvj665OzAKv0p1oAc4
         iXJ2JMeyqTuWLcp5k5NI6xCRL9P9RyB+MbTHZ21Wlz92iAMAxP51jr9xuk73a23hsS41
         qN6tFKIMOPuIXgmEPVqhyLNyHRdSa6Zkko5Ks6OQ6u9zGhkLXA18bcH/7Cn6YNyLZZta
         hQCT1OcS0oZeAVCbO5YpZvTtV248W14qby6vVecuZgQzoipJurzWfBUK5xuMAkqa4U1X
         jMQSqxqOn7iIZulxj+GUNaOs2jl2Q6J1f/XENMpFmT5HMknmUlKCjCjT1U5VnUVudCBv
         EHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443297; x=1746048097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkMWQVZ5NbGUhdn187Fzed6/TVqS8qNaX0QVXio25A0=;
        b=XAbCAIODzHpVO46cYneuJ0Jnqsal5gZJsUt/uYOx8nuEy3DZ8E753zbsaln03FSuXg
         5SS3XMRpVDAe1beysui7OrYo0UUvpvnXuiNTTK57ci6loteLYynCsshohv5rnh1WGPe0
         K6XTYKTK492OPs8bSapI7p4hrtb8iAo/p57G/2zEnxC2MxI7p/w451rmnB8JyDZsVsfQ
         UefZJw7Ncl51zJ+OsBt+40BEw0qXPGJSYqPlxoMMZC5ffZjQE+nvgwRLyq2wgRqKTU8b
         1Wz/IGuVWfMDQhkW8+s+2g2o1km72HFWuEbR/vy5JxzfQhY79TERe/v5oAnSl/a+Scti
         JF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDuWj5AsiGOXaJVdsiayKU3V7BSnqx9/dXtuG6xodIKxxnW+d2uX1MMzHRztcmH3KiVKEye3qLarr2WQ2YyT/nT1lz@vger.kernel.org, AJvYcCWWBPqKmdg9dlkYG4YSWpCyKZYJuFi0b9Mzl3JziBSORLGV0bRKgbofForen2/99kAm157EAMI0@vger.kernel.org, AJvYcCXzRFaxq++ONqFflnjECu3VCaTNsOX2kNzeEej72bcyoAxTVx2CBdXyOiUEw6gQAcG+/hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeUesecn1YRyUtQE/k6bcDqM0bI2bGk5sMeWiMzNZLuYVgdah
	++v4SGlQraH3zIKnr0F+8hSKngZiirKEesRZIS2AoGZIuFsF2D9uLSP5z2HqBkJMCFCUedRg5ZQ
	cS3xW7owWTDPe1VO8U9zo048pOdE=
X-Gm-Gg: ASbGncvhSrVHaMdFq0OhMRk89GYtGOmIv42mbsbiHnBbPWswlJDZWn/MwiCS3w4oXls
	nG6vtmExBBYvw382qSc+dVfkwdFQSNRIjYIZcZggZJSXhxrwedRPGeeCr05ROttmM7mnrZjueDz
	1mF5gEj313sK0gu3LnAV6EicowqcG32KkuvQhcFw==
X-Google-Smtp-Source: AGHT+IHMVgzBu3sVxMrc73B+N2cs3NjKgQj7wTiQqRzkab9vc14xaKQ7QTbsKDcmFanDK092hZgnQXAnyc5c1bFR7Fo=
X-Received: by 2002:a05:6a20:9f06:b0:1f5:9961:c40 with SMTP id
 adf61e73a8af0-20444e68f83mr152177637.8.1745443297369; Wed, 23 Apr 2025
 14:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110104.12af6883@gandalf.local.home> <CAEf4BzZfoCV=irWiy1MCY0fkhsJWxq8UGTYCW9Y3pQQP35eBLQ@mail.gmail.com>
 <20250423145308.5f808ada@gandalf.local.home>
In-Reply-To: <20250423145308.5f808ada@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 14:21:24 -0700
X-Gm-Features: ATxdqUHBQ0lXivOozpHUw90J50FwAIlnZQ-4o-9a_BEyGlI23OlVSZ_YRmELz7g
Message-ID: <CAEf4Bzbwoxsv-oAZoKyFDptWYxHRO2SwAEAmDD+Kym9e5oC_Rg@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 11:51=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 23 Apr 2025 11:21:25 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > The part about accessing only from code within the kernel isn't true.
> > Can we please drop that? BPF program can be attached to these bare
> > tracepoints just fine without tracefs (so-called BPF raw tracepoint
> > program types).
>
> Is it possible to see a list of these tracepoints from user space? If not=
,
> then it's only available via the kernel. Sure BPF and even trace probes c=
an
> attach to them. Just like attaching to functions. The point is, they are
> not exposed directly to user space. User space only knows about it if the
> user has access to the kernel.
>
> Unless BPF does expose what's avaliable, does it?
>

BPF by itself doesn't have any API to list tracepoints, so in that
sense, no, BPF doesn't expose *the list* of those tracepoints. But the
same can be said about kprobes or normal tracepoints. But it is
allowed to attempt to attach to those tracepoints by just specifying
their name as a string.

I guess I'm confused about what "accessing only from code within the
kernel" means. In my mind BPF isn't really "code within the kernel",
but we are getting into the philosophical area now :) I just wanted to
point out that this is consumable/attachable with BPF just like any
other tracepoint, so it's not just kernel/module code that can attach
to them.

> >
> > But I don't have an objection to the change itself, given all of them
> > currently do have _tp suffix except a few that we have in BPF
> > selftests's module, just as Jiri mentioned.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks,
>
> -- Steve

