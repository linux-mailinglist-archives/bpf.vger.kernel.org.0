Return-Path: <bpf+bounces-69268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF4B9343D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E516A195
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE772C159D;
	Mon, 22 Sep 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBirfv6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33E24E4C6
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574085; cv=none; b=IpZJV1ESkZx4ncMLv7GdapS2hMsUTLL4SGpb6rvvs0LRvWTGiNW9oqjVYrXYyXXuS5t19rHQKfcIcEElddzp+ln+TIE+FxG02Iz1Qn8Y65oRX0jkEXDterhIBe+MXLVginCeJMdHgxWi4BvvJIFEZk41nyF3eQ6TefbU4llZXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574085; c=relaxed/simple;
	bh=pE10PShoxNlFwAuYiz+gEtT3x6OgXhVGNZoXiBF2uwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdmNw7xFNWyvsB+QrPWfuUX1+HscR/Ka+Qb0mC1ajDWenJkYsy6pfNvIEjgRBTBf0DyGkgVG8CxQIJ72iaBItxu1HeV4XJeKyhdQDAs8BrWld3Cf3i9tqVtx9TKfSH1CqsJvHvjDnBoQukr3fuAXJO/44BacSfMw6EiMZl8HsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBirfv6j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-273a0aeed57so21759755ad.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758574082; x=1759178882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRupgu2oLIRJ4YbwydOEX0rzUmWrxjSy6aJdxKz3zYU=;
        b=cBirfv6jWy8u9WTREiNseQmsYvd1hKHw316OWDLFZrQIkhn5JVMyWeKBMUSmTv4Pn8
         G+glio0whtwBlMqLPteSE7XoiHPtfOI1haargHIpgmA7q/UlbdNvGXUR7bn5bXUm3Usg
         NQ3XE7Jpk0OE95rvfv8W8/s/vWtrSMWWxD5jAY/40o4ybM35QfnBFII3FWEXBwez3WHM
         HMJzSNQyMqPrp2Htmdh91hX9Q6bQC2OFeJS0g3sBKAZ3o1Nz5tWbfJISM9pN6RP2LMHH
         Fa97Ie8m2nbhxuxnFWdww2i4frkTBeW1ZTOfrTJE0Z14nqRJAJE9n6vXd4UVT/fM3K7N
         Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574082; x=1759178882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRupgu2oLIRJ4YbwydOEX0rzUmWrxjSy6aJdxKz3zYU=;
        b=pNd+K/XQZoJObznoyEClNRso8RkhgVcw9IfzkZasbqEjvE/9lA7BRAwA6tJHU3DS+M
         sZyC5bWa6U/9przGMtlYqcp2kqL6SR3mq/0DSSWmNl5Pd7WAZQQfVRHbTJtAS7e3fJdf
         OCnutYhGb2XoSAhMuQsQsIxQIdu8s9ptXdxQ3ClkS/VyzOi87iC+sIq7clk7DgkEfJlS
         sl801LTDgiTyn32KLOe052PxLg2hlGTWl6wUwBBogzXMoQrHQzCxJfzU/vM0JOw8MEHP
         s5PITAadxKMmUHUfw/eG0DHa7FfKULKN/QLOJiSP+2ESPvuROC7LcbfG1YkfoVkdCBAu
         udhA==
X-Forwarded-Encrypted: i=1; AJvYcCVSPaCMqjmifc3W93KK9amifnQbZV/CuGclVSOA4QhixpLGIuKl3F9z0uQPhZUeGkSuOR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynn+LLdU7QT3Wf18CmlX4Ix/wa3KzwGaka/0h7wJFO3e4O0oaC
	4TOtAtLoTMHLaq4eN3PFm9IBGxBIXtx3tY4D40Xwwp3HcGKmANjXs1zKRpUJw8RhWnZTg6oFKIS
	BScCRx/qp/riPieA8x6Ja2Pmc0APf4Dw=
X-Gm-Gg: ASbGnct7lMhy5EdGGu/cp2ZlkWxldGjFfMTrS/jfN0/NBRWTmnLjJT6QgVzQ+Y+jnZs
	C3dTwVyVrMI9qgmPU3fukia4HveAe1dia+bZqbEK+eEWOpY3p90g7Pny7RyH/cV0t7Z6umzyaiZ
	r/n8YctOKjsKh5SgXlIKWgcx4D7vjsj/uQ6UM3Sgcj99dt7TnFC9BODmxtARGProKWdobwYcH6O
	SUgDmvLl/F1pF/sXalBuLY=
X-Google-Smtp-Source: AGHT+IEUuRWAd6fG0rfybE+0nP/IJA4IiQhjz/jt+hdzGma+ca+nrEuDJjaAUdoxzJ1xY3vBRwKee/XUZdJVl1Lpshw=
X-Received: by 2002:a17:902:f64f:b0:274:823c:8642 with SMTP id
 d9443c01a7336-27cd7464367mr926955ad.10.1758574082268; Mon, 22 Sep 2025
 13:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 13:47:47 -0700
X-Gm-Features: AS18NWDxAmgOz0mcGrQMXGNUADECY-kaOgTXybxwa3vFyGGUnDZr74-MswLax0s
Message-ID: <CAEf4BzYfh_oqMOCq8G1S48Ym3th4+wQS1=ZTgRE3OTQrAJnCMQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > If uprobe handler changes instruction pointer we still execute single
> > step) or emulate the original instruction and increment the (new) ip
> > with its length.
> >
> > This makes the new instruction pointer bogus and application will
> > likely crash on illegal instruction execution.
> >
> > If user decided to take execution elsewhere, it makes little sense
> > to execute the original instruction, so let's skip it.
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 7ca1940607bd..2b32c32bcb77 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> >
> >         handler_chain(uprobe, regs);
> >
> > +       /*
> > +        * If user decided to take execution elsewhere, it makes little=
 sense
> > +        * to execute the original instruction, so let's skip it.
> > +        */
> > +       if (instruction_pointer(regs) !=3D bp_vaddr)
> > +               goto out;
> > +
>
> Peter, Ingo,
>
> Are you guys ok with us routing this through the bpf-next tree? We'll
> have a tiny conflict because in perf/core branch there is
> arch_uprobe_optimize() call added after handler_chain(), so git merge
> will be a bit confused, probably. But it should be trivially
> resolvable.

Ping. Any objections for landing this patch in bpf-next?

>
> >         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> >                 goto out;
> >
> > --
> > 2.51.0
> >

