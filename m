Return-Path: <bpf+bounces-66117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09856B2E7E5
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EACF1CC1E6E
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DD1F4192;
	Wed, 20 Aug 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta8ZAuhH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FC6FBF
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727375; cv=none; b=Rmfz4RZQvfTyyvge9pVh2EUhkIeylznRwk9MMHktSsG5QCuK66ZZhSFn0B5/xlOoNjbT+NEFk/cqoXoIHiqO/C8Y9YHw49yz9YmBbtkHc0ioH0pCxuEsLDuyeL8+XfDbFzH4lES1YbHnbiO4T0VtdO7PwlZ7LERotpYtxSQeu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727375; c=relaxed/simple;
	bh=r0pMFh0R0Wbsrja1tUFGR9jA8ATIImXfJhcV+tg96MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvm7OQ9HoL7ME7CWgMlP73+3loRdmnFYKtFEprn8gP4ma+XGh+HMSFmIH7FrZGTuN0GdQIsee2RpHFphCIZnW9LAQ0ULu12gKJLZdVRPHALMz38fRord8xgJ1s0KgnOOqU8uaYO2aXtCqEnWrYUfLjwFV4ygZeeS3cpRMz2vpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta8ZAuhH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2e614b84so445636b3a.0
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755727373; x=1756332173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR3X6PWDiiOQ3Roq11jbbC1mpvFpKJZnMuD1c+KtLF0=;
        b=Ta8ZAuhHZhdoTqK7Jgs5nUk1vNOEcRtRpZeD39nn/EW26+3KfF1tZTx5XfyyF1f4XA
         DRIVNy65Ghyq6IG10KdYAdG7Tm6DwCIr9+YHq+25IEkYMj5L4D9BPQYozio6pVq6Z5L8
         fAlVVGC1nhuK4b3mS0AzfCzAIxf3feBnyVHOpQ1zZpXyeLbuIWVTs9oPQEz71mw2zLEz
         pyiwkj3LOa94OxxRF0Q4vNOQZIbJFkW/8w+luftBhz4Czp0oMG5aVawH0Jic0y4ehg5n
         c9LI96uiKt/evqI05Q/aLyDH9QFq0AJDvjIxX1BMusjvxb5oDL8sZD+rqwgMidC2GpOG
         wH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727373; x=1756332173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR3X6PWDiiOQ3Roq11jbbC1mpvFpKJZnMuD1c+KtLF0=;
        b=GxMn3bOK+9UYYMTBH/Zf1IOWld5gqgku1cpnueGTcp/LSt6LEWKfY2tej/DiPWzzS8
         rHEn2bG/tI9sBbNzGT/DOtKz9K3JMjdg+/WqeElXWqT+KI1dkeGZeYdiKz+k7l4RuT3N
         oCN+vpzMNeGIeUDRG9KLUfiWLVShgEz3IexBNoR1QMjbpm2F/SVRnkGjLXyQslIfAk4h
         zuTZmDLOa0rXGvTpmcRoFubdZUPUYmrfUs8vcDaQcJ5zu9chm+FEdVgAd+TJaQT8DtMU
         s/PHundz4q22PdEFu4nDEcOnC5MzPUCuuAU/j9179M9xXQNHbhbir6fQUj3GyCBAQ76w
         1Uuw==
X-Forwarded-Encrypted: i=1; AJvYcCXO2K/5RWbnQ65tS42wUZ2BAe2/zIIQ8X4KptZItBdpcOL54U/3zfdS0rh7rgU9HSewF14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFROD240cs3ikugeqjE6zuWa49Xst6XGHTTT4BwQtU5KtZjeRE
	HZYBakon3mnenvRewXDNsHp6dvZaQE+fDOEmkzVAwQQcb/baoxPOeox9H+qif0H8qsL/iMHw5xW
	fO3eSIe59E5OzLcXXZuwVxPBImuGEKHSmeA==
X-Gm-Gg: ASbGncuk70piCRF53LEz3AGZ/1ugz01wDh5HSuhHZ8Vwc7cvHS7n8GB+MGoFZCUl09K
	JHWi3KJdm1VLuvOS4euIpHq4gh8rLEU49lxnYd5wTPp96gWGALh8ZAMT3FrYzh7Jq+nBLPlKqDB
	XAG7hfIUfOmSxGNOPiKCZErK+dBUmxH2dO9KlklwW/7Z+IHG1PjQPEzv6v1UsJtSuVI6Rsh8bMJ
	PvYwJjPs3YikOTxpI3UjAL9od1pkjMK3/H63+znIydJ
X-Google-Smtp-Source: AGHT+IFU0332Uxrc6pu7Qp95AAK00kQxGdEaHSrZ4ZJDGpk7Wnv87dJRZ8EfkZxKUc3vPhmb3yeV3nWUMAT8pRQ0EuY=
X-Received: by 2002:a05:6a20:a10c:b0:23f:fc18:77af with SMTP id
 adf61e73a8af0-24330b3584dmr71383637.44.1755727373167; Wed, 20 Aug 2025
 15:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819114340.382238-1-mykyta.yatsenko5@gmail.com>
 <CAEf4Bzbwnwj125ogm5u8pY6GNrR0EWLVH9J-diC49aZp3xi9RQ@mail.gmail.com> <3dc1c46e5cae319823a43edbefc4f7b1d8e8e657.camel@gmail.com>
In-Reply-To: <3dc1c46e5cae319823a43edbefc4f7b1d8e8e657.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 15:02:38 -0700
X-Gm-Features: Ac12FXxy09arX8r97GALvyGNWTMtJIoWubSEf6MtCJugATY-k3FluSyG5bIdJMw
Message-ID: <CAEf4BzbtzTZ5t3UwN-cgDNUqSE6vMdDZCHtPWy6bjAUaDhHsKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add BPF program dump in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-08-20 at 14:34 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +       system(command);
> >
> > Quick googling didn't answer this question, but with system() we make
> > assumption that system()'s stdout/stderr always goes into veristat's
> > stdout/stderr. It might be always true, but why rely on this if we can
> > just popen()? popen() also would allow us to do any processing we
> > might want to do (unlikely, but it's good to have an option, IMO).
> >
> > Let's go with popen(), it's not much of a complication.
>
> I actually double-checked this yesterday:
>
> man system:
>
> > The system() library function behaves as if it used fork(2) to
> > create a child process that executed the shell command specified in
> > command using execl(3) as follows:
> >
> >     execl("/bin/sh", "sh", "-c", command, (char *) NULL);
>
> man execl:
>
> > The exec() family of functions replaces the current process image
> > with a new process image.  The functions described in this manual
> > page are lay=E2=80=90 ered on top of execve(2).
>
> max execve:
>
> > By default, file descriptors remain open across an execve().  File
> > descriptors that are marked close-on-exec are closed;
>
> So, stdout/stderr is guaranteed to be shared.
>
> (and on a different topic we discussed, 'popen' is documented as doing
>  "sh -c command > pipe", so it differs from 'system' only in that it
>  creates an additional pipe and adds redirection to sh invocation).
>
> But there is a different complication, if one tests this with
> iters.bpf.o, it becomes clear that the following is necessary:
>
>   @@ -1579,7 +1579,9 @@ static void dump(__u32 prog_id, const char *prog_=
name)
>           snprintf(command, sizeof(command), "bpftool prog dump %s id %u"=
,
>                    env.dump_mode =3D=3D JITED ? "jited" : "xlated", prog_=
id);
>           printf("Prog's '%s' dump:\n", prog_name);
>   +       fflush(stdout);
>           system(command);
>   +       fflush(stdout);
>           printf("\n");
>    }
>
> So, whatever.

What's the concern with popen()? That we have to copy one stream into anoth=
er?

I didn't like (instinctively) the implicitness of system() adding
something to veristat's output, and you just proved that instinct
correct with that fflush()... ;)

It's like an argument of passing data through explicit function
arguments vs some global variable, IMO. Both can work given enough
care (assuming single-threaded execution), but explicit beats implicit
most of the time. And if we ever want to parallelize, then the winner
is obvious.

>
> [...]

