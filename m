Return-Path: <bpf+bounces-33431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AE91CD64
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9521C216B8
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBB80C09;
	Sat, 29 Jun 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhzeeLLX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243C3BB48;
	Sat, 29 Jun 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668943; cv=none; b=p1qNTZNbwcqBMsq7V1Ldkr1uLFReMrHJr/zdyg79zkwC4dGINTQcJrQlJRLvudRZpgeQM6n/6lshkcHHHFHHHI2jlpDvJODijZm2VOoqkoGCQCdnAoGBTBaChzEk1a3+cLofWLUeRGGWroVW0HeOaDcE75cxuIV3+6h+zuXPbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668943; c=relaxed/simple;
	bh=WiIYb9cC5EAuADaMUe08j6s2UcKHYuM3Gx1IKekhAAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic+ii6LquZcV1Gf6fyqCtKZacVqzLFxaTc9FJ1AlTbYUK+xg8XrZPnz8yxLtgnhEiVp/zpw0aqOiAdgKelDXrOgMvZ9wbYS/y4HArp774D6PHSlm5GyLFKHRKe++WujbKGhdgGTNW32X0zmj/qcTKj1gIwTDjTIV8RmOV7p3AG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhzeeLLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7207AC4AF0B;
	Sat, 29 Jun 2024 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719668943;
	bh=WiIYb9cC5EAuADaMUe08j6s2UcKHYuM3Gx1IKekhAAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mhzeeLLXHyIQ4hWaaLwoxyNzATXWywulB0eOGo40Gp+aUO9ZfCBcP/F+HGYaUSqzf
	 qssZz0umv7xALkG/KxmUBeKVXg/bklt9GYU+LL9DlOXKA9tSzQhBf/WBmPv8k5k9n6
	 mDWvsT2bEKgwR1oFmqG0vQpMeEWFrw9Yj/2LRNeQeoDqNypikgOgzFwB+U5TEF39b6
	 xzo8MikhPz05uJpzwVGWi/Od8QcmyJevVJ7D/J5TARJSmX4wUXflpbFLXh0qpBeNJP
	 R+SICOrC/WQqphpYuT3SYJQNYX6QTHvtvCWb8jj9l8IXDamiPvc8eidc9kWr8AiCN+
	 ew7YgHVaeCB1g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a725ea1a385so185458466b.3;
        Sat, 29 Jun 2024 06:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3J4kNIPINESgSAZRXWnqfCTLO88/q2K39E+XOSVEKzDZMcurRGbb1l2/GpHib0Td5I9DOT/dppqtNeBXN+DGIfS0EY3w1x6W2MQ8HZUf6pinto2XNabJGba7q8I2Ae83kzeObVc2JbZMWQt4QXYjJwWCieUxKY/rX9M867qUtahjkAgi4
X-Gm-Message-State: AOJu0YyJRt+uGpKBqRvCX4nFs0XGcV9NFUXCK/rAEZgKm0MO9ej0c1Z+
	BB3b9r8i59BJV7gnlc7/Hg6GC9xXS+6AO7CS+kmv/SPldcDMR5/KJgePijakTNnnhm4ZtZkASxN
	TwlQlOgRtjzoRa5gy7eGqaQgbGiI=
X-Google-Smtp-Source: AGHT+IELIawk3PoWQBWTKhv0vIBu6L+CwseEJx4vQnCEBSln22iyDVGrK2hxvpsbh+UBzIAn9Gt2SvOdw44oKHs3iUQ=
X-Received: by 2002:a17:906:1e0e:b0:a72:5470:1d6a with SMTP id
 a640c23a62f3a-a7514422b75mr67650366b.35.1719668941951; Sat, 29 Jun 2024
 06:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627173806.GC21813@redhat.com> <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com>
In-Reply-To: <20240629133747.GA4504@redhat.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 29 Jun 2024 21:48:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
Message-ID: <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: uprobes: make UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN
 constant
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, andrii.nakryiko@gmail.com, andrii@kernel.org, 
	bpf@vger.kernel.org, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, mhiramat@kernel.org, nathan@kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 9:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 06/29, Tiezhu Yang wrote:
> >
> > On Thu, 27 Jun 2024 19:38:06 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > ...
> >
> > > > > +arch_initcall(check_emit_break);
> > > > > +
> > > >
> > > > I wouldn't even bother with this, but whatever.
> > >
> > > Agreed, this looks a bit ugly. I did this only because I can not test
> > > this (hopefully trivial) patch and the maintainers didn't reply.
> >
> > The LoongArch maintainer Huacai told me offline to reply this thread to=
day.
> >
> > > If LoongArch boots at least once with this change, this run-time chec=
k
> > > can be removed.
> >
> > I will test it next Monday.
>
> Thanks!
>
> > > And just in case... I didn't dare to make a more "generic" change, bu=
t
> > > perhaps KPROBE_BP_INSN and KPROBE_SSTEPBP_INSN should be redefined th=
e
> > > same way for micro-optimization. In this case __emit_break() should b=
e
> > > probably moved into arch/loongarch/include/asm/inst.h.
> >
> > Yeah. I think so too.
>
> OK... should I send v2? Or another change which does this on top of this
> patch? Or will you do it yourself?
I prefer V2.

Huacai
>
> >
> > Thanks,
> > Tiezhu
> >
>

