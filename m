Return-Path: <bpf+bounces-60548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB77AD7EED
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C926D7AEB7F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165802DECC7;
	Thu, 12 Jun 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkx+8+w6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393292288F9;
	Thu, 12 Jun 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749771015; cv=none; b=MClsyzYcdOJ5Rb5LIv+dLWu0AnvTm/BxRWSqMwFpxSZHYJ4kLhvgmArIqJ4aBMsYQXO8nPMp5l9XSThIhMgKP0smM8Ls348P1Lxx50MQR6n2y6h2Fjz6Pkja2d6sWdEXneKLQsz/psNLNEX62ZmlmbFGferk+CPCR44cZy8H8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749771015; c=relaxed/simple;
	bh=QBSJJLbkVh/sfY6gCTyV9ImrIqi97ccBxBNjq9Z/JDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMFomHGs8zC3cplDGFlWZuD6x5Q8jITLINjAl+Tjvqk7L1HIvpJ48WEMu0+qNXFJ6lV9Bc/CpArThfQ6ocoy1zaKl2uMOpz4k0qAbNambRYsBcCVVnWTfI4ioJBhrb+PbhUdN/x8XdKceFY8CEeo/GU6mLx8xhmXVVuKwKsLOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lkx+8+w6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c33677183so13794025ad.2;
        Thu, 12 Jun 2025 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749771013; x=1750375813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBSJJLbkVh/sfY6gCTyV9ImrIqi97ccBxBNjq9Z/JDc=;
        b=Lkx+8+w6rWIS0E+JX59ENY5rLUAdGex0kL0o1mCSxcyms7BmnBi+QNAEnFfsluea1M
         q+I/MUeQhm4vsRPM7g5jfBu82eFM+yc6TXH7RPF5NH3kXaAO03cy6F2uo2AIWfeaE16g
         shCSvGAyhvMoyH4deJ+yRUTn5hxYiJs5BkqggGnl+0RH084gbtTPOKbrJF48CXflUfbu
         TgoVPXd9WqvEhpO/qHBbgtG5nY1iGadNZOPKOy/DySkWOrTsU2gJHziJIn8B2QkIhwfI
         kJEDGPaT5lhTfmsyWLiSHNgtjtO/CZwKH2xWzEhl3uO5e0PPNnNIBvNDUUu9TkiWTN/S
         eJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749771013; x=1750375813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBSJJLbkVh/sfY6gCTyV9ImrIqi97ccBxBNjq9Z/JDc=;
        b=kbieJyX4wdA8wLhm8zRAENc5WfT6yeO4rgmcCKdL+xeFLTzGbisMrYxS6kwSn9lozT
         wPNYrH/82lwrGIqIJLcduaiC0vrS6hoPvzoEOoI75pjpF/R8Qz+6QBFIiHA0j29TpGT4
         EEk6eoDOtqWj2xqxb73q416S/7okwqpIoeIk/blyg9mIXbVqUTikl8XdWrF7ueGN6/aS
         aHhm7Yx2jZ2cTjz8tJZ5iDPfY7axKBSQuUuAS9/85jU6RYWtBaH+y597WCbEXe2Q57eR
         SiGTkq8L3Ggi0h+5cl08Y+QZ0x6gCMrpUvo5kxBjgnGn3h2tHm5TvnaxQgq05ousAm3i
         XwnA==
X-Forwarded-Encrypted: i=1; AJvYcCUlECxz5WNPWy4Nj4HXRcvNV3XhYKuaB32kd5dtvtN1ZrYvztNF3MGw8L29bEd4Izg2V3McqiS5e4pRi3OrY/xzYvXm@vger.kernel.org, AJvYcCUxoeZ3uHPqmqyg6fy/bxIu4r9Il7Suf9WCA4uibHoh3kuOvtJUoCzpkgOOxd1lxU8iJa8=@vger.kernel.org, AJvYcCXGtiqMWrnUYV72P7cvy5svnm9G4s54IqW5IMkJOTFfhJMtJ/HHZ+xOyGLtzpiQGiQ2UtF0nf1Ztm39NkzX@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRDeeUywZC/MzoEt53FCGGn1BEaxaZizvNTNOZlhTBG2Exxxl
	yKQxu8C5SI/AxftK9bwo/bw338al7Ua6Sn9TFgO0YLCJzSLLyRNqjA5/56V+r1tzYjN6Dee9Cgo
	TWoPWpm5RgV8TPdLnJXGYqWtPTEowlkQ=
X-Gm-Gg: ASbGncv7ACjYo3i1Qvp55G2qjzTohUglVe8avOpZUMwHMI6hn388YEvuogn6ipGrlfs
	h59tvG6OvsfGMwvMwbConMZigOfx0Aw5QUWbksl5F7ZmMeLe2xI1Fz3LLAhNM17LvcEV5Kt1wRw
	VJP34melZP+uXavFVakuSngK2pCI6ng7kjSlN0nIqDeYY9NBxjuZBM4phg9uk=
X-Google-Smtp-Source: AGHT+IEYqGdJqUNKIdRsB/HowX/im2B1kRSmkiEERPQ8iHBOmhhPb1gDj9rbaiZ0boo+XCSoL/M95mhC7FQ31TcKubA=
X-Received: by 2002:a17:902:d584:b0:235:129e:f640 with SMTP id
 d9443c01a7336-2365dc0a93fmr11974605ad.38.1749771013448; Thu, 12 Jun 2025
 16:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611005421.144238328@goodmis.org> <CAEf4BzZ9-wScwgYAc5ubEttZyZYUfkuAhr3dYiaqoVYu=yWKog@mail.gmail.com>
 <ldnmzsofhpy7rxk7rslgs5mevep7s22ltaqd7pxuoshs67flvm@cakolwpjdkwm>
In-Reply-To: <ldnmzsofhpy7rxk7rslgs5mevep7s22ltaqd7pxuoshs67flvm@cakolwpjdkwm>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 16:30:00 -0700
X-Gm-Features: AX0GCFsletYbAxfzTbaieGo9hqnFkli_Ooy53vK0_Wf5ogiiXP7rsCTVyenKqIs
Message-ID: <CAEf4BzY4JtvZa=ubyiO8AKGcKpOjk_YX2yHqW5JzaBLjM5gjDw@mail.gmail.com>
Subject: Re: [PATCH v10 00/14] unwind_user: x86: Deferred unwinding infrastructure
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:02=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Thu, Jun 12, 2025 at 02:44:18PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 10, 2025 at 6:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > >
> > > Hi Peter and Ingo,
> > >
> > > This is the first patch series of a set that will make it possible to=
 be able
> > > to use SFrames[1] in the Linux kernel. A quick recap of the motivatio=
n for
> > > doing this.
> > >
> > > Currently the only way to get a user space stack trace from a stack
> > > walk (and not just copying large amount of user stack into the kernel
> > > ring buffer) is to use frame pointers. This has a few issues. The big=
gest
> > > one is that compiling frame pointers into every application and libra=
ry
> > > has been shown to cause performance overhead.
> > >
> > > Another issue is that the format of the frames may not always be cons=
istent
> > > between different compilers and some architectures (s390) has no defi=
ned
> > > format to do a reliable stack walk. The only way to perform user spac=
e
> > > profiling on these architectures is to copy the user stack into the k=
ernel
> > > buffer.
> > >
> > > SFrames is now supported in gcc binutils and soon will also be suppor=
ted
> > > by LLVM. SFrames acts more like ORC, and lives in the ELF executable
> >
> > Is there any upstream PR or discussion for SFrames support in LLVM to
> > keep track of?
>
> https://github.com/llvm/llvm-project/issues/64449

Great, thank you!

>
> --
> Josh

