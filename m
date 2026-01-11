Return-Path: <bpf+bounces-78503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D139D0FC18
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EF0330021C6
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD723ED6A;
	Sun, 11 Jan 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y209hanC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E84221F2F
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161906; cv=none; b=hsNRjmEi/vwZVPWaMItZHaBs5GKjX1JN8kY6A98KFo2cISqCw7yQLaX/kjZFrjmIbNjUgzOQ/G4XbBgCQTCWTpOmFr2P02eHg30WMbEx9yLvw6OuRTut/Re9SYF0CC2snqgMTRVEPTb2wyzyapOfpkJrxFTiQWaR/K5RATBUoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161906; c=relaxed/simple;
	bh=VnD9VQIsOYRuD2TRSfBYBzobHdi1a55IuYUd9pyL4jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KErJrpkG7GETMuvCR8XEF1y1QkQjfY3yN2NCZrmGHkTBU0INYaBzqtQizmbhYWmF3KUilC/zZsYX8jH8/ELUAhrHv1cL7Sy9l0YCZrKZbqNuxdEnMJDAtm9k9QSnemLQaEjX/HBhgjW2mpolpltKy0b0Rh4xZbzTiQukrKDaB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y209hanC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4327778df7fso3564665f8f.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768161903; x=1768766703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnD9VQIsOYRuD2TRSfBYBzobHdi1a55IuYUd9pyL4jo=;
        b=Y209hanCdlkhdl+rc9Kxxk9KhOyf+6y/pJSwa0tW077/l4fZ/gNOwOYw7Db69D+GvS
         4e67nXCWdrdfQ9UaaiT/h1LJuLZRXjoimXf0tWTH2QrjLPXMd6B8zR/T1Y8RwyuPF6nA
         tCj2Z3hiN7puwrVoz+kOuP0SxrD0bXLWnA/DmTsPgHwQQajAdWDdfnyy4+/eUvoMf+zY
         PkZiTja1EAGdz3TGJVTVKMa5EV0glvbJQDuvefsl2UDQ4/53/ZDYo2ceD+kgaqw3cHXV
         3mFX5P29OhK0DRsArw8KC4KtjdomoG6+DOc8ppX9A4IeP7Zecv65IUc7Wv496HzCTZvU
         l+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161903; x=1768766703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnD9VQIsOYRuD2TRSfBYBzobHdi1a55IuYUd9pyL4jo=;
        b=VSTlv0haTwkCd+/ynE1VJIefbcLDQMeA1CvVeMAjpEx7ghz6TwvMph1h59n9UyA6pe
         lW5UMWw+ZvCRm7OXIDXBHk4nlmo3c8Y1fklktRNairQ9TX9RhAsfuCLiM3P5eqVFA00E
         UkFhgLJhQkBtkuBUsebC/SxDo0qTlo47yvLHFaY8WQo8h7iAA8WidqBkr/N7lyE3JXKc
         pMuAwaDna+hwrdZ1DFaPw/p7mctKlUEWillyl5+XjqwCApVLoTh4LL39IngVSItF9hH/
         /jkH35mYOJWGssk9qLibdHAY1Lvrvr+zs2rxZ+I/gbpcU4zFCIfNshjJRtcUqtBcisfN
         sf7g==
X-Forwarded-Encrypted: i=1; AJvYcCWCejPvTbFkqpUCPj061AG3USHKxzRnfue7sGZ3NSZo/kNNlGY+Zi6VAlw3nxdGU+038Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9I6OaUn1foP5QPhWg9e4eA7hAJNHQWMV0XhXfSEXT/VUf7vT
	nbD4oo6DpaTC2CYp71rJ1NQGFX8YCvwY7NcX4VZkPCjMmzFYqhVzXunZXB+ak1y/1cqZfPt95v3
	ujY5+wAQk49aDMDA+tPtEc5BvxBT9IcM=
X-Gm-Gg: AY/fxX4vH1TtsP/fwORG4kDIsnuXtb9uXB62SWVHpMnlgJfxlmsGgviIbUc80bdn3U+
	jQeH33a2yo2vmKPpluB1gq4ZKPwc2PXTZ3hAFKnMLIQqTp8tqSWpn2qjQR0juB5AA+nxK+soqGq
	Hfk7qlN2aKEw4ujeX6QQeMc3tZQgurxqchlGi4p8F5y7+Dq8y/IRMYVGtPYgJ24qRqiIeakEFYX
	gHrx+pq0NhMEzGSVhUDjUrINxPp37Dwi7BPx+79vzIEvrvQ67HuC5GxGgd6nnfSBzBi31MYOETJ
	4LjHwA0gbOVAVNNGthkAISq9wE6l
X-Google-Smtp-Source: AGHT+IEKZRrWP3vGMG5mEyctC7P1X4jEpLLMEM8zFqBJqcHJv1TYRiUxZ+Y31COICMXVYqH7Chn2rYWs4tVKLwxDBTo=
X-Received: by 2002:a05:6000:3104:b0:42f:bc6d:e468 with SMTP id
 ffacd0b85a97d-432c3778de3mr15674848f8f.55.1768161902844; Sun, 11 Jan 2026
 12:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
 <20260109170028.0068a14d@fedora> <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
 <20260109173326.616e873c@fedora> <20260109173915.1e8a784e@fedora>
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com> <20260110111454.7d1a7b66@fedora>
In-Reply-To: <20260110111454.7d1a7b66@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 11 Jan 2026 12:04:51 -0800
X-Gm-Features: AZwV_Qh7Wgo_T3tbbD-7bHz3BAnmG7D3hD0wHDV0Nrd5u0SMnqSUPlz3CHnt7p8
Message-ID: <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 8:14=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 9 Jan 2026 16:35:10 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > migrate_enable/disable() wasn't inlined for a long time.
> > It bothered us enough, since sleepable bpf is the main user
> > of it besides RT, so we made an effort to inline it.
>
> It did bother us too. it went through lots of iterations to become more
> efficient over the years (it was really bad in the beginning while
> still in the rt-patch), and hopefully that will continue.
>
> >
> > RT, at the same time, doesn't inline rt_spin_lock() itself
> > so inlining migrate_disable() or not is not 10x at all.
> > Benchmark spin_lock on RT in-tree and in-module and I bet
> > there won't be a big difference.
>
> I'll put that on my todo list. But still, having migrate_disable a
> function for modules and 100% inlined for in-kernel code just because
> it needs access to a field in the run queue that doesn't need to be in
> the run queue seems like it should be fixed.

There was plenty of discussion with Peter regarding different
ways to inline migrate_disable. What was landed was the best
option at that point, but feel free to restart the discussion.

>
> As for tracepoints, BPF is the only one that needs migrate disable.
> It's not needed for ftrace or perf (although perf uses preempt
> disable). It should be moved into the BPF callback code as perf has its
> preempt disable in its callback code.
>
> If BPF doesn't care about the extra overhead of migrate_disable() for
> modules, then why should XFS suffer from that too?

The diff has nothing to do with bpf needs and/or bpf internals.
It's really about being a good citizen of PREEMP_RT.
bpf side already does migrate_disable,
rcu_read_lock, srcu_fast/task_trace when necessary.
Most of the time we don't rely on any external preempt state or rcu/srcu.
Removing guard(preempt_notrace)(); from tracepoint invocation
would be just fine for bpf. Simple remove will trigger bug
on cant_sleep(), but that's a trivial fix.

