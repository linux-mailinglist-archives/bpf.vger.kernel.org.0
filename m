Return-Path: <bpf+bounces-68021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99BB51962
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4C318896A2
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C4324B10;
	Wed, 10 Sep 2025 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAtVOB1N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5E1863E;
	Wed, 10 Sep 2025 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514655; cv=none; b=VyTeLiq8IKGnk+19MoTgSX/kHSJDGLXErVrPvWHzAXt09d7UCnFDcCcWEZyFnzhh248LSaKhxygMP3J7KFjNoEFYp+XnmZhYOATGxvdWkpJ+98VMZJpLNaB4SBaHVWfLfXcgMXfM9bcZj6v7dAKI2biuEwAq/vLkEsp12r0ZVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514655; c=relaxed/simple;
	bh=Q5JQwy5iVhfba4PDMTkG83RMB/eStM9/LUOcXOEGAew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOvaC8YxJXtnRiLHquHw7TP0V/xyBON/uZ3snayy0YqirYgiPr1MXLTFAfm5XyQ2NWv1aYQcHGskc/eouiSz2+8jhK7D3ZjRVQzD7ZLvKnbwC/Vv/iddpzNI3hvqnNv/ibBllJvjqE575EmDUMdfLfbP/hoMEiZoYEHU39DYFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAtVOB1N; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32c54c31ed9so4210839a91.3;
        Wed, 10 Sep 2025 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757514653; x=1758119453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wYpny2eAiLj7phFAVb8K9lZatmDsPErPszMysbW8mQ=;
        b=MAtVOB1NKnKz6geac9nzuy//9A/G44ULZVNzAfLa0nLITKltddgFRavnw65QrFbJwv
         0lMcg9Rcuh47AA0l8vSO4GqukrathxA035EAmjf9bI97XNcFRJPxb8iA5BpAdIHSNN6V
         IA/ZGwxpOJFLARTb7F7MxOOLmgCiKa7vJYpwB/0UCVrdevJmEunKYN+jjilVAe11h6Lg
         mjpNObCDTu3yK4OuGywR77JcZht4AyOZOZSSGirKZBWW7f0iE/OjR9LZW0H4AxV+LslW
         vs5DjvekbIQWl3aw7xAcP9so2CZWAwIE5q/SqWmb5GbUpcHgGg2TipqulpIYZKfx/kum
         WlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514653; x=1758119453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wYpny2eAiLj7phFAVb8K9lZatmDsPErPszMysbW8mQ=;
        b=pXCeGdJyUXp/uD2Kt7ToZwWkmivAhEgKJVxkd9XTUyuKLZqJ5XuDxP5Oc6dQC9Texn
         XJHAhZ0hSymcyntx8aVv5sRrqLiCWq6iyC1/v8NQ4Sofzm5gcm5phyPGEpxohsCezFKv
         BLlvOJ10UmtbMI3VXUQqyK+A443kpSJT4VnvCW8PCpqNvhLmHEeB9mwL0VSXd9cWqVQn
         hqEqW1r20AOdnPByWreGqvCxjom8iVvTtUR7/RgrvXQDxru+W+r7W4pxeqdt+tL7DFS/
         AlvfD7Xfy/xcXkwDZyRHTxD2Pr5ESyQnqaDz0qWThvOrGuh1HdVxzTHMNIYnrBwg0KIE
         rWnw==
X-Forwarded-Encrypted: i=1; AJvYcCU28MgcY6MYYWCKBvIlOJ8Jk/kqNNB0S+VeYaoLw4yppQF4bRbg3icG7SAwRuht7+LgETY=@vger.kernel.org, AJvYcCUMCkF0gyNQ3PLZcuXZGub+UAy12G8+tOtrkHbTpd45pcFn3NUWDnbhgqnayp8i56zYR0LMT+JWsQdZktvf@vger.kernel.org, AJvYcCVPK36cgllN0vSWkHx9l0TCD7mbQtCxDrepORxJOrJZFQPRy1duyy9vnga8b1dKKJWBNwgJNLdOVbWhAppFGKkUU/Fd@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdgMc2+98wu9wwRXnVNeFM2UAIpYkJoAqeLv/YMaeMTaDT8qZ
	bMQ20E1YjF6y2Bl/bPJv4F93YN4Z2Y0X7L5GtwPMROumfm8eRmWCGO1Ge9qpN9u+iqyXXfgzAQ7
	PI00C/V8hFn8b5Pbu8AuDmKhQLKHTuYY=
X-Gm-Gg: ASbGncvavKaLmxTMbTJc5R7aGl8TjNmbt8xj1MGnOgAj1tF3Q5GlC+7YGnHgmzWK1YZ
	mQ1mgpR8Gk/0U8pp/y1LGK/It7V5KISDp1ahNGNSlrngfuF7WIKsrdAuKYeQZRDfwDAzCmF3c+S
	/5sXXbMhSuTJQWwJuSx9Haqqzy3Ad4xJ3rp3zXXTnv5qDnSdM2teuaQqX9GARkyCCyWc0FubFhr
	R9ZxAKdg7QqULKjeq05bYc=
X-Google-Smtp-Source: AGHT+IHPs0H+Nl6iUhu9rYC0Wlyk8tBA3VNM2+wR0NhG/M+6OrnQbgCQG795h4/ENIUQDSSHEOVK6c7HZ0cQlc+zNJA=
X-Received: by 2002:a17:90a:ec85:b0:32b:4c71:f423 with SMTP id
 98e67ed59e1d1-32d43f81c16mr18840924a91.32.1757514652864; Wed, 10 Sep 2025
 07:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-10-jolsa@kernel.org> <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava> <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com>
 <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
 <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>
 <20250904215617.GR3245006@noisy.programming.kicks-ass.net>
 <20250904215826.GP4068168@noisy.programming.kicks-ass.net> <20250905082447.GQ4068168@noisy.programming.kicks-ass.net>
In-Reply-To: <20250905082447.GQ4068168@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Sep 2025 10:30:39 -0400
X-Gm-Features: Ac12FXyq3p703r3UwDyOpTo5nqGiR2kP5WHNyX8x7vM4ABOKKe20-gT57SVI1hg
Message-ID: <CAEf4BzaHcs2wa_F4ro4Lg31WX-7+uo=CGpUKUD_2MfhGEAvazQ@mail.gmail.com>
Subject: Re: nop5-optimized USDTs WAS: Re: [PATCHv6 perf/core 09/22]
 uprobes/x86: Add uprobe syscall to speed up uprobe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Sep 04, 2025 at 11:58:26PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 04, 2025 at 11:56:17PM +0200, Peter Zijlstra wrote:
> >
> > > Ooh, that suggests we do something like so:
> >
> > N/m, I need to go sleep, that doesn't work right for the 32bit nops tha=
t
> > use lea instead of nopl. I'll see if I can come up with something more
> > sensible.
>
> Something like this. Can someone please look very critical at this fancy
> insn_is_nop()?

Can't truly review that low-level instruction decoding logic (and you
seem to have found an issue yourself), but superficially the cases
that are claimed to be handled seem like legit no-op instructions. And
the overall logic of nop handling in can_optimize and emulation seems
to be intact as well.

Thanks for generalizing all this!

To the extent that this means anything:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> ---
>  arch/x86/include/asm/insn-eval.h |  2 +
>  arch/x86/kernel/alternative.c    | 20 +--------
>  arch/x86/kernel/uprobes.c        | 32 ++------------
>  arch/x86/lib/insn-eval.c         | 92 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 98 insertions(+), 48 deletions(-)
>

[...]

