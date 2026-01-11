Return-Path: <bpf+bounces-78508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52740D10276
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 00:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0606D304718E
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BBD2D97A2;
	Sun, 11 Jan 2026 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1GsXbc7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094051E4AB
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768174732; cv=none; b=Qbf46DcKMAxugxmJywMfQYZIwfrop1wOL+WaV5CdqmrlhQd2HTmyGDOwUZiFmF1XUaxqfNzAJFp18XdibByVyAvEDyl4qiKUVUPy8tiLGv8r2GXwLHgXtWA/8R799Xs/JMfohu67HRwRFcuuW5WRfTFbJmf61YtKOIwpZ7XQRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768174732; c=relaxed/simple;
	bh=kiXWuKzIX1x06aBMcxfYYewoOyDtnrGOZE+OOoXbLNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6NSpk1tVY6zh1TlCxjLYEIR99nFmP+QwnH5DiZIl0YEcATL5cEU2XZfGTrxDehexP8WHZDveoUmM1d6vBrlcuRtvenw5wiyLtWf7rA8ae5fNe7AuPQ3cg9ewevMZ7XucbB3AryaJ9BrM4OP9eZNXnXBKssWqZlW5exHi1BH9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1GsXbc7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d256c2a9so2545841f8f.3
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 15:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768174729; x=1768779529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiXWuKzIX1x06aBMcxfYYewoOyDtnrGOZE+OOoXbLNM=;
        b=V1GsXbc7qHCqdkB30tri7P3dRfDxGmDg0h3datuwhBVVKAOL5jgFJGSqVrdNh3BVBP
         nZ9mEM/ZJVFaOtyz4T4p8FvlYEzgOgdFipeGG08JMgQiGPCzgOLYkuKxJnR1JB5losbd
         eCgF4tvyZG3SwinyLbXgQ3GYf6Q0c3vXHnaM5vIhzEOUYfoCBXRVypCiVIaaUj5jNaYg
         Iu6rFaUfK4zPKfFHO+ofbtpWH6ts5f+HH3rktq6suD9b9AfXyqF7fW/HwGZL2hKYKY/6
         adPlUKDesamGBDUxC0m6bJscDn5RCoOJbIfmFT+/Yu2JXFED52+JeUwtKeBP+TpdBuBZ
         N4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768174729; x=1768779529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiXWuKzIX1x06aBMcxfYYewoOyDtnrGOZE+OOoXbLNM=;
        b=CPZcU3/XtFb9ANnVuc8LZ6GZtaAdOVDnC4X6tAeR70b93kQUJIt3/HddYXbY+VKWMp
         4EetM42jBiR55D2iPpZJzSPAzQGgQTL16CkQneoucAALUTAmi41aLFud8NWyVAhTuyTg
         ErlvYGaHIT1H0ce1rKO8I1R69li1e/j4vxLIo4S8K3l9fy4gc4uT2bH4f5vomzMy1UyX
         l9vy0G5vZXQPYNdpCHU7s1gvGw+8MGsv/UZ/7XkyEDdp3H26u63aEdAaW+Okva3tPLw/
         gnphI2LJv3+bm0BK8SA78DJ5OJ5hreLaD2PZjev7PHM5RS//a5bwAZaQhEMrwpSCiozv
         5Fzw==
X-Forwarded-Encrypted: i=1; AJvYcCUIRO36vLx0fqUymxp4bf5FFNk263cYJqnh/i/2a2iBETHn02LUeyYugZcXqmywXQHaVFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgpdiNaUzIp9Cwr9Niwv9dZ2GumphaHovj26kr/QlWHb1afot
	Tiy4rLBBIARTRqnc84FNPzZafhirAddgQPFKUII02Qq6l1wLjf9pdUGVuHH6NQESNYosWXpfa6Y
	6PfOKXRQZ7dcKR9/Bm2+KEwg8hJVuGTo=
X-Gm-Gg: AY/fxX6cyVdWhxVlfmcBBsrKXeZfyZd7PdIqanc+5yDqEiwJWV1NIEIaS4BvTXIA/Cx
	IAyUuBqLv+CJIpS9FFlYtFA5zWU8WbSKBzoOu5HI/3r9dOsFdBhVH6tD356l1sq9itS7xvMOu8t
	YQdLlesRlozKNiuYPRa0ZkaNUxQ01klLddUMakFD6HxrDs2ztEx7mF3WtXx3hoOn3pUbLAtTIAZ
	RHjO/ZWX2rDr4FELUJ3PfwsEaab9SNNlToVM2hfgkIsBWnjfgDAU1DurcfwhcQj5SepEzQXH7uB
	/qTzXEVsuarLw3yP8osoIBTbXKaHviGk0ZXyFvU=
X-Google-Smtp-Source: AGHT+IFUOvDT34dvyomwn3c7ZwM6ALEAOAqRH7FWOKzQCzQUJjuK/9NtjeBwyRJsMcrShx2AnzXOyQRd8inlOoww4Fo=
X-Received: by 2002:a05:6000:4287:b0:430:f41f:bd5d with SMTP id
 ffacd0b85a97d-432c37a300emr17145280f8f.55.1768174729186; Sun, 11 Jan 2026
 15:38:49 -0800 (PST)
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
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
 <20260110111454.7d1a7b66@fedora> <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
 <20260111170953.49127c00@fedora>
In-Reply-To: <20260111170953.49127c00@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 11 Jan 2026 15:38:38 -0800
X-Gm-Features: AZwV_QhL36czEI7sCQwGEwK5X-GlTAcDBYsReVH0tRCSZhjpYR06hlv9A0Tnzbo
Message-ID: <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 2:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 11 Jan 2026 12:04:51 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > The diff has nothing to do with bpf needs and/or bpf internals.
> > It's really about being a good citizen of PREEMP_RT.
> > bpf side already does migrate_disable,
> > rcu_read_lock, srcu_fast/task_trace when necessary.
> > Most of the time we don't rely on any external preempt state or rcu/src=
u.
> > Removing guard(preempt_notrace)(); from tracepoint invocation
> > would be just fine for bpf. Simple remove will trigger bug
> > on cant_sleep(), but that's a trivial fix.
>
> Oh, so you are OK replacing the preempt_disable in the tracepoint
> callbacks with fast SRCU?

yes, but..

> Then I guess we can simply do that. Would it be fine to do that for
> both RT and non-RT? That will simplify the code quite a bit.

Agree. perf needs preempt_disable in their callbacks (as this patch does)
and bpf side needs to add migrate_disable in __bpf_trace_run for now.
Though syscall tracepoints are sleepable we don't take advantage of
that on the bpf side. Eventually we will, and then rcu_lock
inside __bpf_trace_run will become srcu_fast_lock.

The way to think about generic infrastructure like tracepoints is
to minimize their overhead no matter what out-of-tree and in-tree
users' assumptions are today, so why do we need preempt_disable
or srcu_fast there?
I think today it's there because all callbacks (perf, ftrace, bpf)
expect preemption to be disabled, but can we just remove it from tp side?
and move preempt_disable to callbacks that actually need it?

I'm looking at release_probes(). It's fine as-is, no?

