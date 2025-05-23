Return-Path: <bpf+bounces-58847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216F4AC2865
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7322B176BEC
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397E4298254;
	Fri, 23 May 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiEfgbxx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8972980BA;
	Fri, 23 May 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020660; cv=none; b=CwVjL19yCD5aq+1CMompi8uljbDMz1/K0D2uHFGf0ewX5NaMvSzuHaTHF6QpBrTwEwmFALAMSlLjt7wDtRNt6ZUbbuyZmFaSqO/LJs1nQplmg0tKaalhKD54te/SzgopEDZXgEgF6q1AOUOjRCbBPLw+DJdbUuObjY+nLmv8Eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020660; c=relaxed/simple;
	bh=dXqyC8onlMCGx7bgGvbd6oe6+Yn1lkQ2kVJSZPh8pbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZD4cZSS/G5UOyRsQ6z1UBcAlvV5giF9jsZ+mCYtDN7ad9hcRM0/UyWVp8Cw6hH3ovB9OQ+MmNGBdHODoNsVU7Pox/p9mic4Pr+qSzxm2WxcITzbqMzrQ7ap1xg1FM3RfXCKjvhoeT5Ha/1zzUqSq3WoywDlmlkXEux3cpPvf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiEfgbxx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso45311a12.2;
        Fri, 23 May 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748020658; x=1748625458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YFTP5lUlE1QjHF8yyWUrq58B97+VhwR7KGRjGcZgPs=;
        b=CiEfgbxxLiEGfTYPYdI0abWgIyyIvnlGBR26tUHD7itGTrpTuJrFKw4OxkxK+49NJ7
         /Tl1GEWJm5OeXgVQSkN/plZ1jo05b5FRZjD1zDj1TbQVeRUPUZeZ8Oe+nIo5Ml6LAyGZ
         LBwAQLEQ/W8LH9dLa+o7owm25QuhpILIDcZW9hnipc9kMk5LqMTEtE5p8VBdXuVRGDeV
         O19i33bRTm6lGlP4JDMEY4FJIqMWmnmjh6lGSjjMvo2l6Ce3dD/pO3hr2roh8X+cP6Bw
         jo0GNtF6qTb/1byUxz6aPhT0A2A1pA4G3FaYZg78B9oyDfBpso76pfU2Ql9g+JnVhzYn
         ybYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020658; x=1748625458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YFTP5lUlE1QjHF8yyWUrq58B97+VhwR7KGRjGcZgPs=;
        b=lpq0EbVHV3QfwuqYbFt7rjPkiQsnjVodiHNsswVrMUsVrBxw99FLb4zlv58a/qjbr8
         O5P/nY+vlHlg9JgpuAbDR1galzUiumeSR0VQdYus2NbQYi58fT3lIoJScbPLFS5s5oJN
         +CjQuomD7gJ0PaIuhjXJfXg+AkG1kbpcB5hAjZ6qMiEvw/CGPwdftzaGO0RjboB1G7+g
         aRxN5NOG1Mzxfr5sYZgG9RK8jPlbyAnH91hIkmQj/s9Wegyni9/45VteNwGyDuNrcCNG
         8O+VgrwrXuhqmZ9pIjuIUyiqhFeV8OoUKkwJUUKAFO2uDIneKi/oMgKnoEbmA4Q20Mt2
         U49w==
X-Forwarded-Encrypted: i=1; AJvYcCUL9+Wkjd9Cae4XpDGOnmaSkG6ImNsOAuBYYnbh+ky/cw1jEu3mZrTQ61bfCTl+OR5xge6ekk7YM4B9w6IE@vger.kernel.org, AJvYcCXrM0ux8Xly69HAWmThe36ngcLRhGv4yPz5Fl9IDzWsyb3R0PRdj32klMYDFHS9tV/GlWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEL6hwcoCdoydEe6dAd0mf0M27Ey0tlOSIYVP9+zrs1EcMId8
	+HjsKko22ctuZudxKLy8NmNdoRgyx7gP9p2mhmV7YR0JIPZzVTpXIxDGmwid4lZhBVjFz3wDUmQ
	jcdACrgsMFVdoXsNkqM4mBs/Xm1qsQBE=
X-Gm-Gg: ASbGncuJYBJLIkmHQSKmlPONDb+epl40shauiZe6VHXUhNc5x99vy4oBCVONGzQEl5Z
	vt++ftBAQgy0I4fX4Cbac3BrBHB/X2HMC4KAilJKvI7p3Kka3V9ipVlLxMy3iAC7u7eumYR8Wed
	nelm7ujTseKdxgP6fnTlFtkAfDycNTzC95yp/srxMOi4DFr5hNTBafDUnejQ==
X-Google-Smtp-Source: AGHT+IHxnUGtdhm0ZP99cQHtnMkhM1UZm0zCWjs0mx/nTwYTlO/TXJHnxSx4FYWEjrKj3bzbamrBih5AuADjXyO3I+Y=
X-Received: by 2002:a17:90b:134b:b0:301:1bce:c26f with SMTP id
 98e67ed59e1d1-30e830c7a7cmr37275562a91.3.1748020658522; Fri, 23 May 2025
 10:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515064800.2201498-1-senozhatsky@chromium.org>
 <CAEf4BzYTiPuOUbQgkNvT2haAupeep79q0pVu=fcD5fEgnAjR_A@mail.gmail.com> <z4gvqyk3ktqhd4wmi7ju3qw67c56brf5klxcer3vqmp3v6sujn@2xq7j3ji4kic>
In-Reply-To: <z4gvqyk3ktqhd4wmi7ju3qw67c56brf5klxcer3vqmp3v6sujn@2xq7j3ji4kic>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 May 2025 10:17:25 -0700
X-Gm-Features: AX0GCFsaeoqPTWi3rJBb3CU87mJdvE_ZJLIUN_YDjWlkSxqikPbDITrdaOUf1WI
Message-ID: <CAEf4BzZ_5+717wK7g-3zuB6=DL-yfN6YYX=6RdZNf+DJfnkyhg@mail.gmail.com>
Subject: Re: [PATCHv2] bpf: add bpf_msleep_interruptible() kfunc
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 12:23=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/05/20 16:26), Andrii Nakryiko wrote:
> > On Wed, May 14, 2025 at 11:48=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > bpf_msleep_interruptible() puts a calling context into an
> > > interruptible sleep.  This function is expected to be used
> > > for testing only (perhaps in conjunction with fault-injection)
> > > to simulate various execution delays or timeouts.
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > ---
> > >
> > > v2:
> > > -- switched to kfunc (Matt)
> > >
> > >  kernel/bpf/helpers.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index fed53da75025..a7404ab3b0b8 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/bpf_mem_alloc.h>
> > >  #include <linux/kasan.h>
> > >  #include <linux/bpf_verifier.h>
> > > +#include <linux/delay.h>
> > >
> > >  #include "../../lib/kstrtox.h"
> > >
> > > @@ -3283,6 +3284,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigne=
d long *flags__irq_flag)
> > >         local_irq_restore(*flags__irq_flag);
> > >  }
> > >
> > > +__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msec=
s)
> > > +{
> > > +       return msleep_interruptible(msecs);
> > > +}
> > > +
> >
> > What happened to the trying out custom kernel module for
> > fuzzing/testing use case you have?
>
> Oh, my bad.  I think it wasn't clear to me that this was the final
> conclusion, it looked to me that the conversation ended up with a
> number of open questions.
>
> > I'll repeat my concerns. BPF maps and progs are all interdependent
> > between each other by global RCU Tasks Trace "domain". Delay one RCU
> > tasks trace grace period through the use of msleep() will delay
> > everything BPF-related in the entire kernel.
> >
> > Until we have some way to give some of BPF programs and its isolated
> > BPF maps its own RCU domain, I don't think we should allow arbitrary
> > sleeps inside BPF programs.
>
> I see.  How are sleepable BPF programs operate wrt RCU currently?

What we call "sleepable BPF" is really "faultable BPF", meaning we
only allow the kernel to handle page faults to bring data into
physical memory. There is no real sleeping (though userfaultfd is its
own set of problems when it comes to page fault predictability). So we
consider this fault delay to be bounded. With msleep() that
boundedness is explicitly abandoned.

