Return-Path: <bpf+bounces-67441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B7B43DF2
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB871C20F57
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F730275B;
	Thu,  4 Sep 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqoTEP1S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CF20408A;
	Thu,  4 Sep 2025 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994589; cv=none; b=IeTUlZN6JbHgXMKw1evYWV8r9oo7Smfiiq7sVDr8NYAyREMk87bftXxyBrU7IeqBx2vw7mYTDdoi8TdxwR/vgWyX2MaWDeRG2YDWXyIbf3QbGOPuLvHoKBYPdCcWbEx4NR1eW/NwcpO/IPxwTdFKQIJaZqXZ2/fdjjb1/y75kSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994589; c=relaxed/simple;
	bh=3qM7uV+5UMLViDXjERZK/FA9M3c/FnFeaYWRo66RaHs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIu3U8J6Sieb9FF/Xw4gw45bjobA2ZvO3a6Bf2iHUPe6H5IHIcIVNLNzBSvbKV+1WjO6p0lBwK+acFZNz3ADnm4xys4FmFHe6uX0YXhMl5vdy7mUwROZYuu6EmrxvT2yGf8ZD+AO46qq+4hO+hPYlyfQwHnBODyKuYcAOusInko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqoTEP1S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so1692881a12.0;
        Thu, 04 Sep 2025 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756994586; x=1757599386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GhoiaZNxxlj25tTSW2x4zxK6+7X5oeucikOwx7TRzr8=;
        b=AqoTEP1SUSyia0OCh1Viu5CDtQa0H1OWZinNORt5h4BWxVfxFwZ1FMBXP+t3hIaDG4
         BF40LzMG5zv68jno8prxV4TffG6dxpPyxf2XmxB1DPvtJ0xywxwo1Y9JMjmmKgj1EhLa
         IQJiXwLV3Foor/mE6ra8RobYjkyT2A7olxahY+byiq7WLsv9RgVVzS+8yiZrRffr0yQq
         4rmuK4wE4j31B8dXpY53mWWVbwKO8T1ys/ZU8PMiovT/2lZVwXvSngkM6aIBJzWnv89D
         4mYBhGdO9nEeZrZe/3uutecMNC5pF2MZ58TKTJR+wFHXK0NjEIbH5piJ5p9fAUBfjccb
         yX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994586; x=1757599386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhoiaZNxxlj25tTSW2x4zxK6+7X5oeucikOwx7TRzr8=;
        b=aQQIXDiiDRPC1eWqzCB0geQczol3qo8AEpy3pw7+Surxu6EPtUPCIp72D8jU+LcUWI
         3W4JC5koNrhZk+R2qkwLXXVlJ9g/W+ThbOEcsHqtVP/tQZaeobW8BjIFxaF8TARPkqtF
         rVdqXAmCSXx7bsUlHmqL8TInON1sLo8tFmbp/AT/bkCvwtqzPu767JzRsbAx0/wrFdZY
         Smp1a5AXWBnWxZbpOMrn6uOsJ2quB1L3pfJ3vlsHFDKvkmVx8+a3sIMnsjgGl21LHuXd
         pRbbbXqe7bQWdxNsrZ22H+ANF48TpRp7CpvhGooTIU32bYlzNRBalQoPdydljma3wyft
         opfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHupM1So0YTxyC5Ee8zvMQlEQoGFo/8an6Zkit0EyJXUyKIL2acbSmLmwHWdP77diSG6pRGpbXbZGWn0no+RQZOvud@vger.kernel.org, AJvYcCVhf7Hvumk1Mb/NDoAyPVXZMaxy2eyfwyFd9rxGLVHxpxKIO1UNAB+L8I/KG4+xGnLVNMU=@vger.kernel.org, AJvYcCWI4tVaANrya/Ur114e+ipfBGZsbIm56GZxuz3jjvn2mBdnSheKTgyGIgGE4/+ieZGI5NeLiaXmdmkc1y/N@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGXlboCusjQCHbIprjLop3r/bQn0jkg7iEsHU9g6P485kKXmj
	uIC+xRlx3gn13PacEybppPK806NHjuyWzFsugK+KP/azsYX4GJNRpnQt
X-Gm-Gg: ASbGnctM+EXm8olwmpwkt72YPd3M0i+c0FHjPbJGJ3XmQqd66qpkVvkDAfOzstv7Uc6
	D7szxK4OJv4HcmZhB57dFUMpagMc1pefV4XFwyMDMBjhnfVXoVyswQ7YpMFpGJ7WaFECUoLNJ+G
	HGO5yNKuNcazCyDZklkcTOtvcvWD8aAId9CA8BN18MChlNEoy0ATQyubbeBnqmvFyv1FyKGPlT6
	wFy9uHdtNrIt97rccmFCcXQrUhtZetthkPorP3bb6bU3sxiIGErMcLWF/R2j7XVPfMTE3VKGMRZ
	Lgb3hXNAgFFfxnLyfrNSvtJQT8TnNQZZXfvQinbUeAhnh3Vi1WPynhAVrGrFaI6P9k+kPMefBeV
	1x2umO+9Pmrg=
X-Google-Smtp-Source: AGHT+IFAbZiozd6cdFmgXfmverq93S0YaAXJcno52giATX+FJi/xSH9+WMm7vLIv18AeMJeuskQpJg==
X-Received: by 2002:a05:6402:1e8c:b0:620:894c:656c with SMTP id 4fb4d7f45d1cf-620894c7c6fmr1002749a12.29.1756994585528;
        Thu, 04 Sep 2025 07:03:05 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5575dcsm14326489a12.49.2025.09.04.07.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:03:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Sep 2025 16:03:02 +0200
To: Jann Horn <jannh@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aLmcFp4Ya7SL6FxU@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava>
 <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>
 <aLlGHSgTR5T17dma@krava>
 <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>

On Thu, Sep 04, 2025 at 11:39:33AM +0200, Jann Horn wrote:
> On Thu, Sep 4, 2025 at 9:56 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Sep 3, 2025 at 2:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> > > >
> > > > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > > > +{
> > > > > > > +       struct pt_regs *regs = task_pt_regs(current);
> > > > > > > +       struct uprobe_syscall_args args;
> > > > > > > +       unsigned long ip, sp;
> > > > > > > +       int err;
> > > > > > > +
> > > > > > > +       /* Allow execution only from uprobe trampolines. */
> > > > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > > > +               goto sigill;
> > > > > >
> > > > > > Hey Jiri,
> > > > > >
> > > > > > So I've been thinking what's the simplest and most reliable way to
> > > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > > > > whether we should attach at nop5 vs nop1), and clearly that would be
> > > > > > to try to call uprobe() syscall not from trampoline, and expect some
> > > > > > error code.
> > > > > >
> > > > > > How bad would it be to change this part to return some unique-enough
> > > > > > error code (-ENXIO, -EDOM, whatever).
> > > > > >
> > > > > > Is there any reason not to do this? Security-wise it will be just fine, right?
> > > > >
> > > > > good question.. maybe :) the sys_uprobe sigill error path followed the
> > > > > uprobe logic when things go bad, seem like good idea to be strict
> > > > >
> > > > > I understand it'd make the detection code simpler, but it could just
> > > > > just fork and check for sigill, right?
> > > >
> > > > Can't you simply uprobe your own nop5 and read back the text to see what
> > > > it turns into?
> > >
> > > Sure, but none of that is neither fast, nor cheap, nor that simple...
> > > (and requires elevated permissions just to detect)
> > >
> > > Forking is also resource-intensive. (think from libbpf's perspective,
> > > it's not cool for library to fork some application just to check such
> > > a seemingly simple thing as whether to
> > >
> > > The question is why all that? That SIGILL when !in_uprobe_trampoline()
> > > is just paranoid. I understand killing an application if it tries to
> > > screw up "protocol" in all the subsequent checks. But here it's
> > > equally secure to just fail that syscall with normal error, instead of
> > > punishing by death.
> >
> > adding Jann to the loop, any thoughts on this ^^^ ?
> 
> If I understand correctly, the main reason for the SIGILL is that if
> you hit an error in here when coming from an actual uprobe, and if the
> syscall were to just return an error, then you'd end up not restoring
> registers as expected which would probably end up crashing the process
> in a pretty ugly way?

for some cases yes, for the initial checks I think we could just skip
the uprobe and process would continue just fine

we use sigill because the trap code paths use it for errors and to be
paranoid about the !in_uprobe_trampoline check

jirka

> 
> I guess as long as in_uprobe_trampoline() is reliable (which it should
> be), it would be fine to return an error when in_uprobe_trampoline()
> fails, though it would be nice to have a short comment describing that
> calls from uprobe trampolines must never fail with an error.



