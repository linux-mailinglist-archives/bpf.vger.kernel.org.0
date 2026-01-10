Return-Path: <bpf+bounces-78432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F362D0CA1E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D141A3037CDD
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB661E5B63;
	Sat, 10 Jan 2026 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2JzXxOG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392DD42048
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005324; cv=none; b=RkrGsIDgHbZsclOeyyUht1wZAwnpDWGmuCUBUWcFk4W410eAxDETS9O583n/yYtZjQ/NZLOpovkp1y/3r5BQcVTtHvQRyE1vFUIA1xNPXiQI0ddiORJCP6ccpIzeMXWqR0rRxlwJL3et54zqfbDesVL/aUQGASHm/AWk5AbTNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005324; c=relaxed/simple;
	bh=nYiS4uilyETQDbIQtzOwkALPQdi5rc3kAMuT+u+f0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmjNxhFX9xmA7SGtkqRwE0+3SOjw1r+RewO6BkpAVaZeu4uTrUEH+0622Wy/RbBSk92w4ihFkx0ta8u6DtAD2r6hkDihx0p/bdvAfoPGGVR3WKpHhtVq4aKUZw8wjYNGMrwQrWfSYPnfZvPZPxy5TNwGDjm2CM0btW7meJCPREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2JzXxOG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2662935f8f.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005321; x=1768610121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYiS4uilyETQDbIQtzOwkALPQdi5rc3kAMuT+u+f0uI=;
        b=Q2JzXxOGTtFSFyPFluAF3u5gX2ODdDU/TIPq7CtJjSK/eAP9UlOi9TGlXCKeVArL9X
         oioJAxrZqpH+vq9r4VHxt91/Ev2y+ODEO5hy8IhA605RcQRDNbkpgIz7+IzgdgLLvR+3
         KlON4Ab60r2iLSjX001bOxDIDHNbz+499fuvOvGS+dvfIwrAc7h36RgCJlkB9B3ytTnQ
         X5Eg++bOb/efmHCQ9QJp4RUjEhh4l7UJkntfUpYep9U7nzkfT3wAboVzCyV9GgZZrPam
         nom9kgE6Cve9xJWkRA84l32UQn+Z2GueWKlhvi1Uq+T8SMVtHBEjljEHBgj56i4Uvc4B
         dWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005321; x=1768610121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nYiS4uilyETQDbIQtzOwkALPQdi5rc3kAMuT+u+f0uI=;
        b=T/NzqvoWnN1bela5acLoWheBVDsBWXHDw7lS8faiRoQyMf4kxkgFOytgfJgmQuxYb6
         0Ho491RWY0PfSilQ6aa0D+MgD5J1kRGz8WzkRY/X21E4lGq153sT3WUW5B1GEFuiMlXh
         Gt+a+zD7mj6LOIvgJKHhQKqBHKblDUXQq2LjGEbxXXeQfIRH4WsxM2DsBPXi5NdkwNZ2
         Hx8twHd4mswH5sdy5bSj2arr1O3hG3CwKbckveUBabMv8PuQ0zBBx5ibvsz5CA0KdbNY
         oOm7n0f4wtUpykukgydRwVL7WHpND7ZW9IoDOY1bVwYSakboVzTBzErUYxADELVykJ1y
         FJWA==
X-Forwarded-Encrypted: i=1; AJvYcCVv9HB96JoD3N64fBvionPHjmfQbYyMdx5GXd/kIxoPB1Fz9Esxtjfe3U5+PKXEh56jWJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLW6O6/SkSQhYXtlvoMheT9HKoj1IrfNRLC8++SMq7bOrn220s
	6u9zdZwW+itogGl9zRfTNtaWcz8ed1+nc5b0UV/j7uIc1zQgXXyO6Pghs1Dh3Hsq5oIsWs7Dip3
	AYE9XOjKAdHZkgFpy/AZxj78PvsdOjlQ=
X-Gm-Gg: AY/fxX4OqDG3XWGMDWt7tDELWcswijgTxyJA+rWHxcMFtMLA1lHL/lvjImIy5kk7bS3
	O0InOnSjsZHuzbRJKu0K4FmPfLtNCMGahtwE/NgUFzBqayMjYIUULwHiChCSUD5hKBK1MPMH6Tj
	rha5VFmPwKGlIOaON+ZECuod42DiGPBI5LaUxLJGKSmkGcTEY+IESOrIck4hfzNywd6XN47ZmNo
	PIKSRhWG0Yb0TEJy3Wrgfq7WzbNxK2VWKeOUyZMyzMujtjYMFN2SilZt/0Qkjhvgn++nWSyQsyL
	KfA3k59eFh3tMGIfzFSizcBVu/Xj
X-Google-Smtp-Source: AGHT+IE4XaA3jxjGFghWJSP6TdEeGSeNUk/8yX/j0ToKhLfGGGq7jwkCc7XpN+TmOnkbW/zNz1GmPORhjHCbgjOMA7g=
X-Received: by 2002:a05:6000:2087:b0:430:f8b3:e834 with SMTP id
 ffacd0b85a97d-432c3629b4amr15079467f8f.11.1768005321410; Fri, 09 Jan 2026
 16:35:21 -0800 (PST)
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
In-Reply-To: <20260109173915.1e8a784e@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 16:35:10 -0800
X-Gm-Features: AZwV_QisbaDK1B8dOAo5PHdFATblspEn41lOmKMZV_0j2nND-tC1Aq3Fxa83rZk
Message-ID: <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:39=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 9 Jan 2026 17:33:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > How is this about lttng? Sure he cares about that, but even tracepoints
> > that lttng uses doesn't get affected any more than ftrace or bpf.
> > Because lttng is one of the callbacks. The migrate disable happens in
> > the in-tree portion of the code.
> >
> > So you are saying that all the tracepoints for xfs are not in a fastpat=
h?
>
> Regardless of tracing. I now have my RT hat on. The spin_locks that are
> converted to mutex use migrate disable. The fact that migrate_disable
> in modules are close to 10x slower than the same code in-kernel is
> troubling to say the least. It means that modules in RT take a hit
> every time they take a spin_lock().
>
> The migrate disable being slow for modules is no longer just a tracing
> issue. It's a PREEMPT_RT issue.

migrate_enable/disable() wasn't inlined for a long time.
It bothered us enough, since sleepable bpf is the main user
of it besides RT, so we made an effort to inline it.

RT, at the same time, doesn't inline rt_spin_lock() itself
so inlining migrate_disable() or not is not 10x at all.
Benchmark spin_lock on RT in-tree and in-module and I bet
there won't be a big difference.

