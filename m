Return-Path: <bpf+bounces-39553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B627897475D
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 02:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795A528802A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DF0B660;
	Wed, 11 Sep 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrJ62WVZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53731AD5B;
	Wed, 11 Sep 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014443; cv=none; b=iJGkr2F7EDT/Zl9F6PfrlnVv3qSOpzByS/kcr3N6qxPvz8ryNgnY8LWVgeLWAXG4Euycg9eH4HqInvNlI/+4GcPjPrmpDZ6Wyb/v0aURypPzw5pSz+x7+OXLmZmsc68E+GqqwDATwmeRbSd4Im8GPlpur1D0k8hGM0CeaEnc5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014443; c=relaxed/simple;
	bh=O2yLQewcaZ8vIU7ujdubIxdY+3q6dsNeU3j7kfVCkOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1Iy1cq09hCo+CnYt13q/d1qlNDw8FS9Z4ho5Ivu4mSMszCykx7b8d2Fp8L8CUve6Q8Nv/1wFMbgDq/bunPlo9hCZau999IrFIM+3HhchuDHVRSBq7s7fc07ipGBqLMdYf8Z/LRoUhGEfT3pZtElVxFE97su5WBaViq7xx8dSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrJ62WVZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so260236a91.1;
        Tue, 10 Sep 2024 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726014440; x=1726619240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3G46MS/GN1BRk1GDqS+0a3Dqj+XZN03OuynBKhipNo=;
        b=SrJ62WVZnAvaqGwXesPz92utRT7UCcciJTyMk+bjCg2jjXl+25Pu1ReBRrYe9h4Umv
         fL0O/AvGeX3fyCYySm6zsZzX/EmpHFevj90/iOhlweMeQycVCPZlGkdrptRQRcMCFvQV
         w7IO4Q9FRYle1sUA8V8XDIrNKZJ6XmlNH92dYvQMwO46y8XP23OGS4u8Wn41VzoUiYI+
         BgwaHxmXPhcH8vE5DbUQVeBZVAqtmDxSDB33x6vGP3ImXCekNp0xaYH6ObftbK8jX+W7
         W3Mu22fxA6bE7XoOuulc0PbFShddzx0kAKuO2CU1vaWaw0wPYjpdA33BJsLJn/TOqPe+
         jPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726014440; x=1726619240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3G46MS/GN1BRk1GDqS+0a3Dqj+XZN03OuynBKhipNo=;
        b=E2j1/1/65iurzjHD7PH2uW6JzZnSCfQ+pu1ZNXtPFYprHCoYEL39DEl/UP3LCRNL1l
         Up4jXT0SE+PQES+T+QHbPPstsEFZWLKb56qOX65WlJQWABsxd9Wx1IHGZF1470McDaKq
         DPO99UGlAeZc4C5aVTa9jT++iRChcDeaJmbCGZuZZdGW492KlVmtHeqqIkpUp9ylvs1s
         BPN1m7mcv9y7PmPRib4UTca7UP57Sa42A3n6NZ+KQTlvKeU8UoaaRrvMWnLUamIXap1H
         8yJB6VvzHWY4K94DxVbFbncHSbqEburGLz4n7EB7XNH3sVURtvYq2QWAoLUqqAbxZ5jc
         YaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV32JGoOnKpRCGTsw6cO+NLhUTUou25cWzvwWWEx/Llknf7dDwgQhxRqki+XaYJGIR83wg=@vger.kernel.org, AJvYcCWWI+rC6Q3CLdnUuWRow1gFZee5/J//jJ5apAf/30ihmxBteedNsZecvb6YFM8pRRqnWlo7wef+inYG6yOujo9HO+80@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpLyeZCwvvMUuLZYA5WJGI82C0Nh+UjfVx8nRpBLV0i3FGTTt
	dPXJvCF30yAUKXqgfWkHtc8aZJsD8HAEEe8NgZdO+H3d4ImIhKI+CbCRWroVhShHvdyHfOSc8SL
	HZkhkbUITB/PDVJVaTcAVuqjAl9A=
X-Google-Smtp-Source: AGHT+IGh1U+VrPkE+xUyC1wGNgrtRAwe6Jw7TUurE36BNPnKB7qGowjg+hLoplVIH7fmY3hj+wATDFppB4Z9CqlWgps=
X-Received: by 2002:a17:90a:ba96:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2db67181b2cmr6966104a91.3.1726014440425; Tue, 10 Sep 2024
 17:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
 <20240910145431.20e9d2e5@gandalf.local.home> <CAEf4BzZRV6h5nitTyQ_zah6wWMBZD6QQBbTCWyPVzkPpS42sgg@mail.gmail.com>
 <20240910182209.65ab3452@gandalf.local.home>
In-Reply-To: <20240910182209.65ab3452@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 17:27:06 -0700
Message-ID: <CAEf4Bzb12RE6QvLLb1ptSedO2Q2zEZCvxM73BcKXUodJpi5tiw@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, 
	Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:22=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 10 Sep 2024 13:29:57 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Tue, Sep 10, 2024 at 11:54=E2=80=AFAM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > >
> > > On Tue, 10 Sep 2024 11:23:29 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > Does Linus have to be in CC to get any reply here? Come on, it's be=
en
> > > > almost a full week.
> > >
> > > Just FYI, an email like this does piss people off. You are getting up=
set
> > > for waiting "almost a full week"? A full week is what we tell people =
to
> >
> > A full week to get a response to a question? Yes, I find it way too
> > long. I didn't ask for some complicated code review, did I? I don't
> > know who "we" are and where "we" tell people, but I disagree that one
> > week is acceptable latency to coordinate stuff like this across
> > multiple subsystems.
>
> Why do I have to answer to you? Once I saw the "ARM64" in the subject, it
> immediately went down in priority and honesty, I didn't even read it as I=
'm
> not the ARM64 maintainer. I did skim it to see if my name was mentioned a=
s
> I usually try to do with emails, but when it wasn't I ignored it.

So, in the end, it wasn't "And we are busy getting ready for
Plumbers.", but rather you didn't find the right keywords in my email,
right? "Masami" and "Steven" would be the right keywords, but
"CONFIG_FPROBE" and "CONFIG_RETHOOK" aren't. Good to know.

>
> >
> > "pointing out"? You and Masami are maintainers of linux-trace tree,
> > and rethook is part of that. Masami's original code was the one in
>
> Yes, but I don't touch arm code. Masami sometimes does (as is the case
> here), but it is when we work with the arm maintainers.

And? Did I ask you to write that code? Or review that code? Or did I
ask the context on why a portion of the patch set didn't end up
upstream, while the rest did. The patch set submitted by Masami and
signed off by and tested by you. Was it too much to expect that either
you or Masami will have a quick answer? I'm sorry, I didn't know you
don't really read emails addressed *directly* to you in email's To:,
my bad assuming as much.

>
> > question and I did expect a rather quick reply from him. If not
> > Masami, then you would have a context as well. Who else should I be
> > asking?
>
> The arm64 maintainers as they are the ones that maintain that code.

Even if I misrouted the question (which I still don't believe I did),
is it above you to point it out and CC the right people?

>
> >
> > If ARM64 folks somehow have more context, it wouldn't be that hard to
> > mention and redirect, instead of ghosting my email.
>
> You should know they have more context because they are the actual
> maintainers. I shouldn't have to point that out to you.

Maybe they do, maybe they don't. I'm relying and using
kprobes/kretprobes, and I still don't have a clear understanding of
all the nuances and differences of k[ret]probes, rethook, fprobe, and
ftrace, and what works with what. Call me dumb. I don't expect ARM64
maintainers to know these nuances. They are experts in
ARM64-specifics, not in a tracing layer, I presume.

>
>  $ wget -O /tmp/t.patch https://lore.kernel.org/bpf/164338038439.2429999.=
17564843625400931820.stgit@devnote2/raw
>  $ ./scripts/get_maintainer.pl t.patch
> Catalin Marinas <catalin.marinas@arm.com> (maintainer:ARM64 PORT (AARCH64=
 ARCHITECTURE),commit_signer:2/6=3D33%)
> Will Deacon <will@kernel.org> (maintainer:ARM64 PORT (AARCH64 ARCHITECTUR=
E),commit_signer:5/6=3D83%)
> Puranjay Mohan <puranjay@kernel.org> (commit_signer:5/6=3D83%,authored:3/=
6=3D50%,added_lines:30/255=3D12%)
> Mark Rutland <mark.rutland@arm.com> (commit_signer:4/6=3D67%,authored:2/6=
=3D33%,added_lines:105/255=3D41%,removed_lines:47/49=3D96%)
> "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com> (commit_signer:=
2/6=3D33%)
> chenqiwu <qiwuchen55@gmail.com> (authored:1/6=3D17%,added_lines:120/255=
=3D47%)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 =
ARCHITECTURE))
> linux-kernel@vger.kernel.org (open list)
> bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
>
> Neither my name nor Masami's shows up.

$ vim wget -O /tmp/t.patch
https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit=
@devnote2/raw
$ grep -E 'Masami|Steven' /tmp/t.patch
From:   Masami Hiramatsu <mhiramat@kernel.org>
        Masami Hiramatsu <mhiramat@kernel.org>, netdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Furthermore,

$ git grep 'config RETHOOK'
kernel/trace/Kconfig:config RETHOOK

$ scripts/get_maintainer.pl kernel/trace/Kconfig
Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)
Masami Hiramatsu <mhiramat@kernel.org> (maintainer:TRACING)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> (reviewer:TRACING)
linux-kernel@vger.kernel.org (open list:TRACING)
linux-trace-kernel@vger.kernel.org (open list:TRACING)

You can define your responsibilities as narrow as you'd like. I was
asking a question about the RETHOOK patchset/feature overall and why a
portion of the original patch set is missing, in particular.

>
> >
> > >
> > > Funny part is, I was just about to start reviewing Masami's fprobe pa=
tches
> > > when I read this. Now I feel reluctant to. I'll do it anyway because =
they
> > > are Masami's patches, but if they were yours, I would have pushed it =
off a
> > > week or two with that attitude.
> >
> > (I'll ignore all the personal stuff)
>
> Maybe you shouldn't ignore it. If you think you can get answers by jumpin=
g
> immediately to "I'm going to tell on you to Linus", you may want to rethi=
nk

No I don't, and I'd hate to have to do that. Which is why I didn't CC
Linus. And I get that stuff slips through sometimes, as I said. But I
don't get your absolutely overblown reaction to a question born out of
frustration of being ignored.

> your approach. A simple "Hey Steve and Masami, what's going on?" would be
> the "human" thing to do. Especially since you appear to be mad at us for

Don't project, Steven. I'm not mad, though definitely frustrated by a
very unresponsive ML and its maintainers.

I tried a "hey Masami" approach in [0], and it didn't help much, unfortunat=
ely.

And it's not the first time I'm ghosted on this mailing list. Would
you say 4.5 months not getting any reply to [1] is long enough?
Though, let me guess, it's x86-specific and you don't have anything to
do with this, right? Going forward I'll consult get_maintainer.pl
every time to check if you are *NOT* responsible for something, my
bad. I didn't live by get_maintainer.pl up until now.

  [0] https://lore.kernel.org/bpf/CAEf4BzbbVRGROtRn8PM4h1493avHMggz1kSDDJca=
NZ1USO_eVw@mail.gmail.com
  [1] https://lore.kernel.org/linux-trace-kernel/20240425000211.708557-1-an=
drii@kernel.org/

> not replying to an email about code we do not maintain.
>
> Sorry, but you're not my boss, I don't have to reply to any of your email=
s.

I didn't say I am, not sure where you got that from. But I did expect
a bit more ownership from you as a linux-trace tree maintainer. I'm
sorry.

>
> >
> > You are probably talking about [0]. But I was asking about [1], i.e.,
> > adding HAVE_RETHOOK support to ARM64. Despite all your emotions above,
> > can I still get a meaningful answer as for why that wasn't landed and
> > what prevents it from landing right now before Masami's 20-patch
> > series lands?
> >
> >   [0] https://lore.kernel.org/linux-trace-kernel/172398527264.293426.20=
50093948411376857.stgit@devnote2/
> >   [1] https://lore.kernel.org/bpf/164338038439.2429999.1756484362540093=
1820.stgit@devnote2/
> >
> > >
> > > Again, just letting you know.
>
> Because [1] isn't something I maintain. So I ignored it.

Yes, you are doing a great job at ignoring stuff. That I understood
very well, thank you.

>
>  arch/arm64/Kconfig                            |    1
>  arch/arm64/include/asm/stacktrace.h           |    2 -
>  arch/arm64/kernel/probes/Makefile             |    1
>  arch/arm64/kernel/probes/rethook.c            |   25 +++++++
>  arch/arm64/kernel/probes/rethook_trampoline.S |   87 +++++++++++++++++++=
++++++
>  arch/arm64/kernel/stacktrace.c                |    7 ++
>
> None of that would go through my tree unless an arm64 maintainer asked.
>
> In fact, I need a bunch of acks from all maintainers of the architectures
> that are touched by [0] before I can pull it in. Which means it will like=
ly
> not make this merge window.
>
> -- Steve

