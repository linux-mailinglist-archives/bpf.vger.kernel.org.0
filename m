Return-Path: <bpf+bounces-67494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E75B446A3
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F9AA4646F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26922749C4;
	Thu,  4 Sep 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsMSQaIh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A72701C4;
	Thu,  4 Sep 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014961; cv=none; b=Gvg4Al6F+AwtpXfFh90t11RxDSLeGCD1mJGsQEUaVrn9d85V86DE4WWYg5GuLgBpQ+DqvbibeUxiqjg5Jvvo1q/s5StSKTgGhkCUAc09KidPVn3IMkSa0w0HN3lyNF9qQlMNj4t5M4Hz+ezcOVM2eEo+P6sEX5o9oThTH0do+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014961; c=relaxed/simple;
	bh=RnviVVbWEOiXEHtL4IcjzUZfgue4MBSlmwXOenkFBFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehzkltmOEjPPLDQrbEDKbGn1WI6VD9edNT8QW1Q16/8DfZrqEzFUSgNDVlc4EF5iW91kY5wB2/cHK6CSuOrhD6yudzYFC8GU87eHEe0hp7LQV2S2P6fjTwSmWFoo1xBUvPpdXHA7f1Y+hhh2T0+bF2F8JFQuYAXTIOM67dgRLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsMSQaIh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so1371814a91.1;
        Thu, 04 Sep 2025 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757014959; x=1757619759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRRH8xuKcexqodKPmFErIaLChAXFetcv8fz2tMfV9ZI=;
        b=PsMSQaIhZKSOitxrtb5BMqCgbKq6RdqpwQXxj6QwzZvzzLFBmkb4uUNWlxr0/8kwrr
         mTHWw2XWdX0wATHauVxGGYiKUtflM8MokcUhQaLvSgRKmbSrwmb+fGjsCC8zoMnUAKZw
         FhLN3w4PJgAsYbx9lOWPgXh9qvASZ0NdJ9NkJ3GXHi+BK/5K841voh4/k2qfDugPbE3F
         y4eV+mhiydpiVdoKJMfPBMsGDxs9zK7OMk3h20078n9pxO+Y+uwUKb6HaZciplj/yjF8
         d8CYLObQQDAwE4vlONEiKTvOxOezysseWJoxLKCa/M0j6f21LmdLw6EOc75DY9CunI75
         BH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014959; x=1757619759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRRH8xuKcexqodKPmFErIaLChAXFetcv8fz2tMfV9ZI=;
        b=cjPupRwP6k8Z0Y1jWFAgY9aGn9N0aWYhCMcIFP0uzFDg7BRPQZxeYNlx6A80x1RPKY
         E0KI2WpzduD/L8v86nv52EOBXO+DqnVxKjbVaIEcXhgyFqlENsGnXcDP1kJ0J73Jh02O
         j+5HtGAHPdkZX3yMIp4Gf46IGQvbSITk/mAFhbmOPVl2vyGyuqkvEhixKFDUpE5rN68h
         fpe+eDFU7YUZ3m9oAgKpYXdqiLPkg8RXNG56k9WMewoiFkn9sWHwJC1PcWtoXgQR7Oqa
         zgMYNJItzwN/jmKJN/T8vsOWFQ/SRVhokx8k8RP5D/gAdtq2gfVwdJ2i3oKihDwv+y9U
         vk8A==
X-Forwarded-Encrypted: i=1; AJvYcCU7mHUcTMwZvXCIXMz5UaMWNgPcWDGbpsXyByKl+ynEmf2Ko0ZLU0YysCtEOGiL9HGEYn+NfutXvS/KO5TOxHhS5/Nv@vger.kernel.org, AJvYcCW5sXogWglBIUzVRw+Gh/ulhFMEDSQTsrvPXJZRfhjVc9fETLayNLJjJQ0Dg9vyMzHKDhA=@vger.kernel.org, AJvYcCX8ynNeZj3JBKdJE4urAMwDI+3ElaHqzOHZwbF/j5rFZ+ZJiJyt4TPVBWb7K9rCAmtN1LxN4bxRxoj2O1uh@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAWO5CHWXT3W3oNaJqaGXWLahHV7jgURDJ4i5R6R1Uuzcfx9T
	uxQ4dpjBRUnGipHKujJQwGyjJtyDDoNJT2PQp6PU/bFiiB3XKoYZAchM+em7xNxbNYCpax77npi
	gd3RaZUgotqJiHEOK4cDuc5MWhCmEzQc=
X-Gm-Gg: ASbGncvfm3+8gdnVUh5RaxbIo0Mlsh/LDiXbZqguSc5G8RQYAuWRLE07UTJm6LTxwSI
	Nsp1FnVaVhgtCSgXgXVPOp3v2uA6ilEYuYDbVvhWGJN63WuYFHuhh0BxjaBckRpV6p6C7efz0zS
	z+FqfCylhTWNZ/s/SUOTBEMLMCShh7TR/tGg1DouLTYzmlRvzIkwD1U+ecVgsSWVTO5cUMVPLOp
	pNRDDPuLFPSYwHW7PmPc5E=
X-Google-Smtp-Source: AGHT+IH+FSKKN9rspP5eEoPLAKkz+ytKYowGIauifwS5Ywzucmk/3A+wIJDBwpzQ6AC0BXwu5SDZBr5uK9EqvWD3ioM=
X-Received: by 2002:a17:90b:1c12:b0:329:d8d2:3602 with SMTP id
 98e67ed59e1d1-329d8d23bbbmr17688480a91.17.1757014958776; Thu, 04 Sep 2025
 12:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com> <aLicCjuqchpm1h5I@krava>
 <20250904084949.GB27255@redhat.com> <aLluB1Qe6Y9B8G_e@krava>
 <20250904112317.GD27255@redhat.com> <CAADnVQ+DHGc8R0Tdxf7eUj1R0TDGHXLwk5D4i_0==2_rfXGbfw@mail.gmail.com>
 <CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com> <20250904185553.GB23718@redhat.com>
In-Reply-To: <20250904185553.GB23718@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 12:42:23 -0700
X-Gm-Features: Ac12FXzy5H0zV8JjGNVM9nTVhltOVCESG_bHF7Ua-LTn184gsKfoxNXLvmdrFBo
Message-ID: <CAEf4BzYb=mqN84a8+xc-Du1QkUBYMgwAuStYqastJJHQE4Os5g@mail.gmail.com>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 09/04, Andrii Nakryiko wrote:
> >
> > On Thu, Sep 4, 2025 at 8:02=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 4, 2025 at 4:26=E2=80=AFAM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > > >
> > > > On 09/04, Jiri Olsa wrote:
> > > > >
> > > > >
> > > > > ok, got excited too soon.. so you meant getting rid of is_unique
> > > > > check only for this patch and have just change below..  but keep
> > > > > the unique/exclusive flag from patch#1
> > > >
> > > > Yes, this is what I meant,
> > > >
> > > > > IIUC Andrii would remove the unique flag completely?
> > > >
> > > > Lets wait for Andrii...
> > >
> > > Not Andrii, but I see only negatives in this extra flag.
> > > It doesn't add any safety or guardrails.
> > > No need to pollute uapi with pointless flags.
> >
> > +1. I think it's fine to just have something like
> >
> > if (unlikely(instruction_pointer(regs) !=3D bp_vaddr))
> >       goto out;
> >
> > after all uprobe callbacks were processed. Even if every single one of
> > them modify IP, the last one that did that wins.
>
> OK. If any consumer can change regs->ip, then I can only repeat:
>
>         Yes... but what if we there are multiple consumers? The 1st one c=
hanges
>         instruction_pointer, the next is unaware. Or it may change regs->=
ip too...
>
> > Others (if they care)
> > can detect this.
>
> How? If the the consumer which changes regs->ip is not the 1st one?
>

We are probably speaking past each other. uprobe consumers (including
BPF ones) see struct pt_regs, so they get what's the latest regs->ip.
Sure, they won't know that it was changed, but oh well, not sure that
matters all that much. And if it does matter, then we can solve that
by giving users ability to carefully order consumers (we have similar
problems and some solutions for that in BPF for some other BPF
programs; it just never been necessary for uprobes/kprobes
specifically).

> That said. If you guys don't see a problem - I won't even try to argue.

I don't, yep.

>
> As I said many times, I have no idea how people actually use uprobes ;)
>
> Oleg.
>

