Return-Path: <bpf+bounces-55110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A4A78457
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 00:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D691891663
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBAB21149F;
	Tue,  1 Apr 2025 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFuyc1Em"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83122F4ED;
	Tue,  1 Apr 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545065; cv=none; b=aNIm+hjprvRmjPEKha2LurscRWghkQY+ZG8r8bdCw0WK1NukdXHdWcpaN7NdHMxn7Rn2Z5Jk0q58xzCIMdF6Uxgu+cPVP0eIaDNFUH26ZpxybsDWN09gDKrSt1eMbWu5jvmHR9PIhtg+yJJ124ivBpPy4iZGmt6/ZrpNrgNWB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545065; c=relaxed/simple;
	bh=kNeM3AfjvmVAgQkPZnV5x2QcbPKtM5Qu243dN60BN7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1l2flO/uVl9B+Ta2G3yOln73FYiJSiC2hC0frXFce/nyOw2DkyYs0Egu3EtJCa/aY0Y4vk1dCA8SLxToMy+a9qwkOJxN93FINfwp/UkPk7xcrsYrnD887ehalpUFMSoXjocFB040AtotFHACfEJpv6Ny9z71l6IZ1WfGBjfeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFuyc1Em; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30549dacd53so474776a91.1;
        Tue, 01 Apr 2025 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743545064; x=1744149864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYYJD7xkUBqu9ap/Y96qrO8h5YwCvqqRfC+EFJyEBAQ=;
        b=eFuyc1Em0B5EQZUvQ5jprAr6RioGUozOJvEA5mARQyY1iFbo1jeF53tGmHW6QXdDI/
         1D0q9iGu2WF7hdm7LWTEhgiWhU062ZeuoNrZP/3l/5mE2/87nPb/fXWQQ1XhuPvxmjWu
         ADAPNF1Qzab1ULt4ggoMbPtQ4eoXyBmWGaamQandkEuQSp88rpubiqM9EMgyV2Ac8w4Z
         L+/W13Hi7+1ayyE3M88yP6ZlOCf1kMLXPhsMuEc9Y+zX1BEbaSjW968PS+xRGW8TBUpL
         +QZDa4z4Rd0iLPHG2q1VktP7T95Poq4QB26xJKCNBRTW6h8cA4WUkdG97vsAQsf5hfev
         zD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743545064; x=1744149864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYYJD7xkUBqu9ap/Y96qrO8h5YwCvqqRfC+EFJyEBAQ=;
        b=M26urWfaNqYfUZ//AwhqK24M7TWeZcRIqipAnxBOxDPjBvCSVWie/uZ7iVHADcFRGl
         sGbx9c8wVb7/id1VpP3rUEPqw3ZTmjpEoboaB/hqHpPlsEkH1+HzbWJqntwVY7EJ4xLc
         3JK/WgYxI6LN8bKR2Hbk5Vbv3+WeYfqSl+s714RyKx+BDox+GBxT0uPlTez0gcoFoB8c
         nTjowuC7cPAOvvMdSApHhWkKaN9sPBtIrFjhbTAfhy3/32SlbpNaLv9D9R6xlcVT4YKc
         vd/P8bmtlifCnSdXYEeI9U1svOXNMcNsw2jmbPP5XO064sZaqmDPiBBZnSeZX/m9Gc9y
         3fMg==
X-Forwarded-Encrypted: i=1; AJvYcCU4knnvsneR3Iapm/8TDMnEnOCWyefEjJs4ne85VX/v4fKYUuv3EEZQUVjQpFXbPrr3iNCXkXZi15IqQq5a@vger.kernel.org, AJvYcCUfkdKHvEdKTAIOsaxtx4lZV6+Jx9TzNZ0bjbx0KMUvTfX55mpfp1foEDOs46Zh6sW6M6RyZhkZtwMlZzW0XNkWisoC@vger.kernel.org, AJvYcCWjB23GvB9xBRnDCA39cFiSQ6alZoKZpxCGbMhTa0dCC4JxM5hG9QFUGJPcIlE8sKEFIRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJeptK1DfBArRhXX2BxsjS9ERKylWNggw4DcADI3SShlquRVLh
	q/yKuOcxPsdPMJqBYegbl9fP+grlHfWIxNR6/48WmwiDi2WO06Ivcy8qyfUF8XVQsF8IUNzQ/UJ
	nMOqa4nnT7gA7dBC0BjSPfUykKAQ=
X-Gm-Gg: ASbGncuXKfjieZC5Us6ztaKZBSJDuOZvvEQ4cwYUMlexjbAJmb9MNihGjn5vK1JcfpD
	R5CGr6l91aZGK5XSME4IoOBfln9UcJNwwv+D0UF4qBA/YfuxOD08LFEsrrxCd81AVosronrphIp
	gOZtLD3pZBUDS0/kvrchsYKZR2nViY8459Pkq5xcfMNw==
X-Google-Smtp-Source: AGHT+IH61ZC+ygiGLUwoWNS9qjFPvZFm8o+P28rd4NNUJn+1Mq/jAQo0sDEThx6KTrPqjsKiXrLNfDZkPmd/cVWkhRA=
X-Received: by 2002:a17:90b:51cd:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-3056b6b84c7mr2262676a91.2.1743545063643; Tue, 01 Apr 2025
 15:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401184021.2591443-1-andrii@kernel.org> <20250401173249.42d43a28@gandalf.local.home>
In-Reply-To: <20250401173249.42d43a28@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Apr 2025 15:04:11 -0700
X-Gm-Features: AQ5f1Jr1cQJuU0xbDn4ROMgihO8o5vD3rAc_UvCumbOLWLOzqP9DNWn-HVzWBf4
Message-ID: <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before current->mm
 is reset
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, mhocko@kernel.org, 
	oleg@redhat.com, brauner@kernel.org, glider@google.com, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:31=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  1 Apr 2025 11:40:21 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Hi Andrii,
>
> > It is useful to be able to access current->mm to, say, record a bunch o=
f
> > VMA information right before the task exits (e.g., for stack
> > symbolization reasons when dealing with short-lived processes that exit
> > in the middle of profiling session). We currently do have
> > trace_sched_process_exit() in the exit path, but it is called a bit too
> > late, after exit_mm() resets current->mm to NULL, which makes it
> > unsuitable for inspecting and recording task's mm_struct-related data
> > when tracing process lifetimes.
>
> My fear of adding another task exit trace event is that it will get a
> bit confusing as that we now have trace_sched_process_exit() and also
> trace_task_exit() with slightly different semantics.
>
> How about adding a trace_exit_mm()? Add that to the exit_mm() code?

This is kind of the worst of both worlds, no? We still have a new
tracepoint, but this one can't tell if it's a `group_dead` situation
or not... I can pass group_dead into exit_mm(), but it will be just
for the sake of that new tracepoint.

How bad would it be to just move trace_sched_process_exit() then? (and
add group_dead there, as you mentioned)?

>
> static void exit_mm(void)
> {
>         struct mm_struct *mm =3D current->mm;
>
>         exit_mm_release(current, mm);
>         trace_exit_mm(mm);
>
> ??
>
> >
> > There is a particularly suitable place, though, right after
> > taskstats_exit() is called, but before we do exit_mm(). taskstats
> > performs a similar kind of accounting that some applications do with
> > BPF, and so co-locating them seems like a good fit.
> >
> > Moving trace_sched_process_exit() a bit earlier would solve this proble=
m
> > as well, and I'm open to that. But this might potentially change its
> > semantics a little, and so instead of risking that, I went for adding
> > a new trace_task_exit() tracepoint instead. Tracepoints have zero
> > overhead at runtime, unless actively traced, so this seems acceptable.
> >
> > Also, existing trace_sched_process_exit() tracepoint is notoriously
> > missing `group_dead` flag that is certainly useful in practice and some
> > of our production applications have to work around this. So plumb
> > `group_dead` through while at it, to have a richer and more complete
> > tracepoint.
>
> There should be no problem adding group_dead to the
> trace_sched_process_exit() trace event. Adding fields should never cause
> any user API breakage.
>
> -- Steve
>

