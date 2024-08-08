Return-Path: <bpf+bounces-36702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7F94C448
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99A61F2675B
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10D1494CE;
	Thu,  8 Aug 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agj/M/3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FB146A83;
	Thu,  8 Aug 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141588; cv=none; b=FyL2Ry/cATlRS9liMH+AleimWU1kDul15+9/RV4vIJGOxQRjQBEIBaYH9dolo2N2EumllPjVg9aLbjGVRuKcoNf7pY7tNns4FfpwniNeW3XtPokMJdCK4O1c4jCVraR3CLLSlhTHSRuwbmx87kEJReflek46ia6ok+fFgq8XKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141588; c=relaxed/simple;
	bh=Is0rZwd57NxqIDsIZ1g1j01jSlboD4HKRmZmotCJB2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQu5RBBElgJ0Aosyg25qwR0iuotiucnaxrlIO9KekZC3MMtiPAVnG0Z04nzUg8rhHnFCmhE1aRuyCYGd+35si7axg8dkVSTQvg9vGZM/WeKVe9/Ns2fLWFedU5Dl9PSSEhu4TSzy8xUC5DrYiujZ3n5Xg7ELWFgur5uYLQDm/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agj/M/3Y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so1621255a12.3;
        Thu, 08 Aug 2024 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723141585; x=1723746385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFbPNJ607Go8GjstJ67P2hj+jbMnWzLu1Mne8oBXAYU=;
        b=Agj/M/3Y6SWlAujhDjaDm/asI6/oArRLd0BH1bW/dqI0TX3fOfcIMHaf4nT3KZ2vjB
         liJ5ZSrCjNELpfHQCWMg5a9e6R8pNTUS4Y7fISCZTbW6m3ZwaeWSW7q8UJbmJ+CxHzJk
         aV8E4O17ND8ZDluTyH/xQghRe4eNOloJ84RC1Z58JA8cpmNw3DGx32rLFliyHLr9Qukc
         AVKFX5pM2ohh0F2eEpDAp1VNBx5ZKj1J0VWa4qjlO3pUaPo1q8jL7O+h5+q0PSk6tpKI
         4fgAGWWrloFVM8nk1+8RY/xtagO8gf2qcB3FiwpmNLAkGI37b6aXv2aynAydp3OXi013
         okxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141585; x=1723746385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFbPNJ607Go8GjstJ67P2hj+jbMnWzLu1Mne8oBXAYU=;
        b=m7UMXLEL8RxfAqPMJBskIlzUBWz1UCZW8pVp0gXrO1wB7JKPzOQCvrGr8VC9RSCEnq
         GXvCoY0FrtD98eOJyKJ3KPj+ZdZSqoJW2SneaKgb6yIcGNTO+7C9o1gVSR8jurMZ//i6
         BsdvvOSYRNYd+fz9vXQkXRS0RUeTtqxIML8F4ayHTQ//agjQJOPFgdc1at9Lp/iO6hV/
         95x19yEr9rAWVIrwpyGmyWzKKvXiSRvXBfiNMe5FNNjcNEGzJiJbvCzFVn+3brsVS+tc
         1k/nIp9M8G25IKIvUeRCnhLHlB4benuiSH7LmYlCzLN2QikMzjUUWOPcFRVW95C/oMDn
         VswQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsOVwdKgFPZa4vNgrDa2wPPM0RsItl7hCpPuyyOzd6TLTSt1zApV0alp0FobX7fIkMTSYpexeN92tpMemix4zCSn1I7cftdgs5aktJAicrNTqiSZa5uC+AWoqnKwBo/qwZgdTj0hAc0YuF6AGJ/QOo/JORUQuij91UJxIrPVN/JIlrHNj0TPqqlnEUt26W0WGEWefoRIWr6tsjlJTDbou1xE2HFeu/oA==
X-Gm-Message-State: AOJu0YxwwLHvvOYZPFm3i5UtoWR1AME3UsZ5CCnySsJkpT0XeF9M5dy3
	gEkghXNX8vRirVG3aQLAlGzEeb6Vmx+wKUXHA9P8D99k77l52eEDmiVrVq0Q6mQWAQK7JNqwKHN
	e4DUxJW9I5hyTiWJNP85JRJsLCoY=
X-Google-Smtp-Source: AGHT+IE8LinZySq+1QbfLvKCWRfTp7esYK0feg6Yv0jk0IkVLoPm+6y3QOW51AlKPe11LIy9q4O+hknmoQE3Jz2puRY=
X-Received: by 2002:a17:907:f1e7:b0:a77:eb34:3b4e with SMTP id
 a640c23a62f3a-a8090beb704mr220228566b.7.1723141584537; Thu, 08 Aug 2024
 11:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com> <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com>
In-Reply-To: <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 11:26:06 -0700
Message-ID: <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, 
	"oleg@redhat.com >> Oleg Nesterov" <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huawei.com> =
wrote:
>
> Hi Andrii and Oleg.
>
> This patch sent by me two weeks ago also aim to optimize the performance =
of uprobe
> on arm64. I notice recent discussions on the performance and scalability =
of uprobes
> within the mailing list. Considering this interest, I've added you and ot=
her relevant
> maintainers to the CC list for broader visibility and potential collabora=
tion.
>

Hi Liao,

As you can see there is an active work to improve uprobes, that
changes lifetime management of uprobes, removes a bunch of locks taken
in the uprobe/uretprobe hot path, etc. It would be nice if you can
hold off a bit with your changes until all that lands. And then
re-benchmark, as costs might shift.

But also see some remarks below.

> Thanks.
>
> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> > The profiling result of single-thread model of selftests bench reveals
> > performance bottlenecks in find_uprobe() and caches_clean_inval_pou() o=
n
> > ARM64. On my local testing machine, 5% of CPU time is consumed by
> > find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou() take
> > about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >
> > This patch introduce struct uprobe_breakpoint to track previously
> > allocated insn_slot for frequently hit uprobe. it effectively reduce th=
e
> > need for redundant insn_slot writes and subsequent expensive cache
> > flush, especially on architecture like ARM64. This patch has been teste=
d
> > on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selftest
> > bench and Redis GET/SET benchmark result below reveal obivious
> > performance gain.
> >
> > before-opt
> > ----------
> > trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> > trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> > trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)

I'm surprised that nop and push variants are much slower than ret
variant. This is exactly opposite on x86-64. Do you have an
explanation why this might be happening? I see you are trying to
optimize xol_get_insn_slot(), but that is (at least for x86) a slow
variant of uprobe that normally shouldn't be used. Typically uprobe is
installed on nop (for USDT) and on function entry (which would be push
variant, `push %rbp` instruction).

ret variant, for x86-64, causes one extra step to go back to user
space to execute original instruction out-of-line, and then trapping
back to kernel for running uprobe. Which is what you normally want to
avoid.

What I'm getting at here. It seems like maybe arm arch is missing fast
emulated implementations for nops/push or whatever equivalents for
ARM64 that is. Please take a look at that and see why those are slow
and whether you can make those into fast uprobe cases?

> > trig-uretprobe-nop:  0.331 =C2=B1 0.004M/s (0.331M/prod)
> > trig-uretprobe-push: 0.333 =C2=B1 0.000M/s (0.333M/prod)
> > trig-uretprobe-ret:  0.854 =C2=B1 0.002M/s (0.854M/prod)
> > Redis SET (RPS) uprobe: 42728.52
> > Redis GET (RPS) uprobe: 43640.18
> > Redis SET (RPS) uretprobe: 40624.54
> > Redis GET (RPS) uretprobe: 41180.56
> >
> > after-opt
> > ---------
> > trig-uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> > trig-uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> > trig-uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> > trig-uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> > trig-uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> > trig-uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> > Redis SET (RPS) uprobe: 43939.69
> > Redis GET (RPS) uprobe: 45200.80
> > Redis SET (RPS) uretprobe: 41658.58
> > Redis GET (RPS) uretprobe: 42805.80
> >
> > While some uprobes might still need to share the same insn_slot, this
> > patch compare the instructions in the resued insn_slot with the
> > instructions execute out-of-line firstly to decides allocate a new one
> > or not.
> >
> > Additionally, this patch use a rbtree associated with each thread that
> > hit uprobes to manage these allocated uprobe_breakpoint data. Due to th=
e
> > rbtree of uprobe_breakpoints has smaller node, better locality and less
> > contention, it result in faster lookup times compared to find_uprobe().
> >
> > The other part of this patch are some necessary memory management for
> > uprobe_breakpoint data. A uprobe_breakpoint is allocated for each newly
> > hit uprobe that doesn't already have a corresponding node in rbtree. Al=
l
> > uprobe_breakpoints will be freed when thread exit.
> >
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  include/linux/uprobes.h |   3 +
> >  kernel/events/uprobes.c | 246 +++++++++++++++++++++++++++++++++-------
> >  2 files changed, 211 insertions(+), 38 deletions(-)
> >

[...]

