Return-Path: <bpf+bounces-67484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4928B4450A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8713E5A53D0
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EFB34166A;
	Thu,  4 Sep 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXXS8GQg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486154654;
	Thu,  4 Sep 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009209; cv=none; b=CAtXPurNczRnbs7FT1QRE3Ry8v2DNO6W8OMyAC/ATj+azdJkv8SLczrx6dW3HtB+Gv+oV0TqX6UrKj1dBYxerw/+smS+6HMbh5ovkV/ikEvf8PnhvxphZQAHRMSui0XJnw5AS0RiEjkDwutE5gVzlAcEN830mSahmopZgurYOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009209; c=relaxed/simple;
	bh=9CiMvOSQWinJMq6NIMYH71ecyKhv5aE1CwwMMJiawrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFV7V26bJRgr/iiSrlIexdqWB4nWfAJit1FdILFQ3OFUv6EXbasKY3lAGKictfItUDw3Sbq3821jyxuH8O8IaHPYEqdgi/P+ch1f5rTnFMTAOYTo6B7wEIm+9pxJWljWcBG9Ln3oytwvPe7LYm/lmwyYV6rnEi9sl9EbOL5ri8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXXS8GQg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so335806a91.0;
        Thu, 04 Sep 2025 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757009206; x=1757614006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuyixO0hwkwyh9bGg9JvqJw6+GK3Lee4B6ulKn5PzeY=;
        b=bXXS8GQg7+G55WXP7sw4YOSdcgqNzo979WaHB+UWgEUbErUDF4g0Dw13jAf0QxNt29
         JQYHGa8wQBwnJkA00ASh088g6lpF0GPqeTsmue38XQZBLtXc7mQVe+sXOZllVgQkU+d7
         qMPwUBIxlLnEKfp5nl7tgT9Hx77NDkU65viYYG6cWWd2owTOff0k53IOsDOpLFPdv7dU
         yeFzsvyJ/vMJSjXwpJx7fnHB6sQYPiGsn79E6Gcm66XOuN4X7uyk3eOc4InX1sF+mZN9
         oi/zo2lC/ds8L5/W67qQcAfEi6I1DGEXpPHAsqeLlcK41GE0ZwOpQCxeDZxvA9G5gyfS
         5IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757009206; x=1757614006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuyixO0hwkwyh9bGg9JvqJw6+GK3Lee4B6ulKn5PzeY=;
        b=AXIVdsrX9dak8vZyY+NVRFbncRZr6+LbmmcQvxylNprP+wSdVUUd4HjD5gUj/pGxQY
         u56kF9MtT/uELzIdrCARUTV+Abw8Cg3f1bKD2wkiXKYMH2su7T1ezDbAFtftj8Iokzub
         EutE54z/Aqs360qWychFXXGon11iU/ulojfBY/xVcrNz2w2I68sikOmZPClPIRZZcE2u
         k4OtWiS54LxtgqMjS26ZPr5i3RCSMpuUovuw2ZfeZjlmuuIlcexuKqZ1QeyG/n00lDDn
         iHgop/GuUVCdPzovxSqd2kV5coWIsSJOpmAqSEuqT5Wq15nLrjZ6JS2BGAq82lneQ5Vm
         X+xg==
X-Forwarded-Encrypted: i=1; AJvYcCUpHq1iYrZ/SUe0d5caAHfafX61NdPIT3sUQOpOa7l1WQb4dd3+DEed8ZYfxGrFiZ0yKjk=@vger.kernel.org, AJvYcCVA5CZuIj4T9j2YkGC83cUi3HVRj8mZJktrt5BPac5+Pq2XZn6f4kwamLby0gfOpCDlJ5fQWgAWck8jscTa@vger.kernel.org, AJvYcCXexh/Bt05N6MnUTCKtRpHVfDicHGWLNSspXgmoAsiOSedbcnbkFx+OYtrK9YNxiWPpnbUiH8FZDU6+Nlb1kDaevQCy@vger.kernel.org
X-Gm-Message-State: AOJu0YwMggedmTugmh2DJFW18kwD4rJu/wMqXCyyzWwT9blWHqPV45Ih
	OvivHVCuoHUD06Tp9+Qu7f39P4pxu+K+Ec0T0djXRVLeg9ZLQdO60B53H+jR9NSkrjENnrsuJZ1
	jUMO1pY/9mYrdHVMALUaNBu0DaYu0I8w=
X-Gm-Gg: ASbGnctxtY/NUoQ51eyeCNPy7wEzaK8OlYQhKrafOK0f9irWM/N1QcCkeXZ/klhXd2n
	iKAW76OjMU4/4IZxu7iXDYnUoYu8RirxDRDatifwlTpVeF33SBubVe0BV9mr8HV4TuntOVBnQzB
	B+tnu/0lCPnnnIiLfLAGGKHo5sIDWWIsuJp1pc4byAgIGP1ctVIP4u/TC0JNV891wAehS9GEFDO
	IdJnvjlwgIdDX7e/JD7BH0=
X-Google-Smtp-Source: AGHT+IHCUO6rhTvzEP9t2OmyzIkR6yMvWXQ4BzuYoMuX/kGOeMKz713GAJpf+6/fxt3zD3e/QK0zSs48VraZx+P8jak=
X-Received: by 2002:a17:90b:4c4b:b0:32b:5c14:3bb6 with SMTP id
 98e67ed59e1d1-32bbcb94786mr624377a91.1.1757009206177; Thu, 04 Sep 2025
 11:06:46 -0700 (PDT)
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
In-Reply-To: <CAADnVQ+DHGc8R0Tdxf7eUj1R0TDGHXLwk5D4i_0==2_rfXGbfw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 11:06:31 -0700
X-Gm-Features: Ac12FXzGYab9OQQet97J76DuBacUMuW8DPWM-yoh5yepaOsk3yRtmPhPFspT8nw
Message-ID: <CAEf4BzbxjRwxhJTLUgJNwR-vEbDybBpawNsRb+y+PiDsxzT=eA@mail.gmail.com>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 4, 2025 at 4:26=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
> >
> > On 09/04, Jiri Olsa wrote:
> > >
> > > On Thu, Sep 04, 2025 at 10:49:50AM +0200, Oleg Nesterov wrote:
> > > > On 09/03, Jiri Olsa wrote:
> > > > >
> > > > > On Wed, Sep 03, 2025 at 01:26:48PM +0200, Oleg Nesterov wrote:
> > > > > > On 09/02, Jiri Olsa wrote:
> > > > > > >
> > > > > > > If user decided to take execution elsewhere, it makes little =
sense
> > > > > > > to execute the original instruction, so let's skip it.
> > > > > >
> > > > > > Exactly.
> > > > > >
> > > > > > So why do we need all these "is_unique" complications? Only a s=
ingle
> > > > > > is_unique/exclusive consumer can change regs->ip, so I guess ha=
ndle_swbp()
> > > > > > can just do
> > > > > >
> > > > > >         handler_chain(uprobe, regs);
> > > > > >         if (instruction_pointer(regs) !=3D bp_vaddr)
> > > > > >                 goto out;
> > > > >
> > > > > hum, that's what I did in rfc [1] but I thought you did not like =
that [2]
> > > > >
> > > > > [1] https://lore.kernel.org/bpf/20250801210238.2207429-2-jolsa@ke=
rnel.org/
> > > > > [2] https://lore.kernel.org/bpf/20250802103426.GC31711@redhat.com=
/
> > > > >
> > > > > I guess I misunderstood your reply [2], I'd be happy to drop the
> > > > > unique/exclusive flag
> > > >
> > > > Well, but that rfc didn't introduce the exclusive consumers, and I =
think
> > > > we agree that even with these changes the non-exclusive consumers m=
ust
> > > > never change regs->ip?
> > >
> > > ok, got excited too soon.. so you meant getting rid of is_unique
> > > check only for this patch and have just change below..  but keep
> > > the unique/exclusive flag from patch#1
> >
> > Yes, this is what I meant,
> >
> > > IIUC Andrii would remove the unique flag completely?
> >
> > Lets wait for Andrii...
>
> Not Andrii, but I see only negatives in this extra flag.
> It doesn't add any safety or guardrails.
> No need to pollute uapi with pointless flags.

+1. I think it's fine to just have something like

if (unlikely(instruction_pointer(regs) !=3D bp_vaddr))
      goto out;

after all uprobe callbacks were processed. Even if every single one of
them modify IP, the last one that did that wins. Others (if they care)
can detect this.

Generally speaking, this is a very specialized use case (which is why
the opposition to complicating UAPI for all of that), and I'd expect
to have at most 1 such uprobe callbacks at any attach point, while all
others (if there are any "others") are read-only and won't care about
return IP.

