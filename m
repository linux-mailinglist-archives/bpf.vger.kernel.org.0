Return-Path: <bpf+bounces-67506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0615B448BD
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824D0A02209
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C12C234F;
	Thu,  4 Sep 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg6CPl8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7912C15B1;
	Thu,  4 Sep 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022260; cv=none; b=ruWw4PNpWzsCeQ4GDDjlmQ1tlzrW1uhHziwPobpT5XUMGtgha3wvcwc2nbArvTuSDCx5JrYY9CR55RiY2RK8/SDNEanoHVNTb1HjEVQ+Bxn0uu02EnSpjVXo8Oi5evsQpICvKpKcWqz95JmU9530qhcJZd2akXOdHNs+vQy5qyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022260; c=relaxed/simple;
	bh=syKMR/AOpfxpzqwbxyMg4ORMN7HXCh2N+iOystaCzP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW/5ojID9vszzhQAkSVB3K4bdHiHver6DqkB/0GslVxfsnCyU2ztv/gfeTOz3P2cp1ACg5rnriqsQODQx0x0hUFbWFyHagkROxv+/WSJz69ojhMToahmAWJbpNCV5gV/n5c/CXJKSNBXuyj/IAA9Gp+r4c/FzH+bldtT/hswJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg6CPl8I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47173749dbso981584a12.1;
        Thu, 04 Sep 2025 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757022258; x=1757627058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmlAIj2yK6cLKVpKdW/BVsPqFHfKYJLh109GFYuJvxQ=;
        b=Yg6CPl8I77pFnEEBlwibUPZpjnsk2rnX6K2wB8bW2vK3Bz60s4S++fX1l+nq4Cu88+
         Zaf2EVOawH715/N1NyVLjLCo8oifvjtRjVY+lYJmAM/0wQXVKi+MRaJD/cOGGy85Q/eF
         VMeF4yERYNA0WGk2m57aojz07xRmYYG1VGmd0WHM4DMNPSABYMSa87UqSnpcyLb8K7rb
         LB0Sjwf1nqEu98G8o18ZJqABB1GodVD9iox1ZbDqRjXBjcJ9S9qgknMy58U6YxsZi4DI
         /EjKflL7/ks01lWRimA0vk0LyRowDrL1KQfbBVBxlm1+Pxw0To3uNarhRb2kRzb8UJ7N
         lTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757022258; x=1757627058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmlAIj2yK6cLKVpKdW/BVsPqFHfKYJLh109GFYuJvxQ=;
        b=XiAbf/BeJLmNbbHPufEnRw1NdnNSbH/wNnsnbk6pYDP+vA0wTNxx9l77XfPVTkurCT
         CXYqmhz9AI1/56/lXKpb4UNIOBFO8q1+t5jM7YVSE8qDNvgnw7xjPMyzlV0QwDzk7dPH
         cuLBfeESKnzuTM73l4gQ6Ey7UrzK/DdshFEANqfGpd2bSY4cf95LeyClugoXx7Zm+Cdu
         +3PWpAStEbciAQmEI3ug0QeiCq3EmfNe2bWoOetF8nl+T0ASrkTOowPKWUR4ICKDMN25
         T+HG+BZZCLEdfr9QtIxrhz7+AC5QSXnQtrmoiEuQQRM0GSjHk2bZ5xGPdkgB6RPvInHJ
         W4tA==
X-Forwarded-Encrypted: i=1; AJvYcCUDmxJPTFi5Xk2EgT6cLIVlRU785HlVN2ZpZ6YighQXb7unVmpjAI0tpj7RIoPK7C+eXEdLk71JIaYBlIaimB4RTof6@vger.kernel.org, AJvYcCUwtrmPHP0qsvqSz9Domijy4h1mEKM/00U0dKb6sJlFSAwHbZBY33G8WRiA0QB25ekruBDp4UbXGml1K2NN@vger.kernel.org, AJvYcCVs5diR1tYz0aDSq6UIfp/LgLgbWA7wtbCgv9lPdQrwreegkyuHfELFsSWBln1pwmlmQ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjApc4wi6GkLrgUjAy3O22vwjRU6zeR0cN5gIwvj7sas4QnkbW
	vC9PlhgnZurEIkyHYLQ87RgNOpb6WBMBMt83EcF9ZZSafnEl669t4eVApsbUfGtOw0v8YaY+kIp
	aryqQvBU//soI6TXn2ecNiv+6ksplRvM=
X-Gm-Gg: ASbGncvBzNlaoQi9RxYxsiuE+GG2g99uzaM6a68BvxeWnqPjBxRhsfsjYdtgKSC8khL
	UyPwm+bRRyDoqtRdXL5d/LBvMlJmY+TVGaepE7Q4MHUUqpnbmoHBg+CJxRDPN5Gn1kSmhA3MW5y
	gKSOJNiJ77tvZaAEL1eAfNdU5Y5FY0HHMmQuMj77TV91QqnGfXlvCi1V/VmQlj+RUpOX8po6xQI
	ssS3rLLo1PSCC6VVzYhS/E=
X-Google-Smtp-Source: AGHT+IH3KqHLuBG2Y256PEStaOVthJXQjQF2/yui+Ba8eDmHMQ3zWe/xVpIla0AjUjTi47HwKQn8CNjiK9rDiPGEOiA=
X-Received: by 2002:a17:90b:4e8f:b0:32b:b342:48aa with SMTP id
 98e67ed59e1d1-32bb3424accmr2799651a91.17.1757022257796; Thu, 04 Sep 2025
 14:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLlKJWRs5etuvFuK@krava> <CAEf4BzYUyOP_ziQjXshVeKmiocLjtWH+8LVHSaFNN1p=sp2rNg@mail.gmail.com>
 <20250904203511.GB4067720@noisy.programming.kicks-ass.net>
 <CAEf4BzZ6xSc7cFy7rF=G2+gPAfK+5cvZ0eDhnd5eP5m1t9EK-A@mail.gmail.com> <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250904205210.GQ3245006@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 14:44:03 -0700
X-Gm-Features: Ac12FXwCznCAhdjb_-bJHRE1YiUIOhT03TbKi4SvEU6vWxyS7b5MpYG7YEJ_eRU
Message-ID: <CAEf4BzY216jgetzA_TBY7_jSkcw-TGCj64s96ijoi3iAhcyHuw@mail.gmail.com>
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

On Thu, Sep 4, 2025 at 1:52=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Sep 04, 2025 at 01:49:49PM -0700, Andrii Nakryiko wrote:
> > On Thu, Sep 4, 2025 at 1:35=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Thu, Sep 04, 2025 at 11:27:45AM -0700, Andrii Nakryiko wrote:
> > >
> > > > > > So I've been thinking what's the simplest and most reliable way=
 to
> > > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to=
 know
> > > > > > whether we should attach at nop5 vs nop1), and clearly that wou=
ld be
> > > > >
> > > > > wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,=
nop5
> > > > > and store some info about that in the usdt's elf note, right?
> > >
> > > Wait, what? You're doing to emit 6 bytes and two nops? Why? Surely th=
e
> > > old kernel can INT3 on top of a NOP5?
> > >
> >
> > Yes it can, but it's 2x slower in terms of uprobe triggering compared
> > to nop1.
>
> Why? That doesn't really make sense.
>

Of course it's silly... It's because nop5 wasn't recognized as one of
the emulated instructions, so was handled through single-stepping.

> I realize its probably to late to fix the old kernel not to be stupid --
> this must be something stupid, right? But now I need to know.

Jiri fixed this, but as you said, too late for old kernels. See [0]
for the patch that landed not so long ago.

  [0] https://lore.kernel.org/all/20250414083647.1234007-1-jolsa@kernel.org=
/

