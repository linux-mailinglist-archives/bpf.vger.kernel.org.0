Return-Path: <bpf+bounces-46556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B49EBA26
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A4018876B5
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC6207E18;
	Tue, 10 Dec 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGVx//NM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99823ED5E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859246; cv=none; b=csvPnVqm2aMha4/6vukeCEouKvlPlK2W6tWDdV0LD/QlW3MB7d6FYyHLyazBfX1ywUrQV2C74wPEGY8goqTKyYaewBjo/Efm+F3352BlmlR7pga4y6HAFPfTkFoQMyLKLa9d0MzUGKXSmDJTcZhylfkL9OXwJcv/8ZT0QXFwwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859246; c=relaxed/simple;
	bh=LmgagnXUnlfj+rriQoUXWOa6EmXCrHqtG3TfzktG3KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDaqUC8h9utvvAMUabFWx6CHdy32T0WHNNNLQQd/De5CvePvl/0gIhNRjNObPNekqx4ajjnLRwlgGLxx64ZK0o1PBrPgKfaQ8jNka21bHJJBxqNZD6eYbnH6tKEBWadjk9ZxPbABYhEzguGRqwz2Q7xv/XSXWfCsoWzp4fnldKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGVx//NM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so4825937f8f.0
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733859243; x=1734464043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmgagnXUnlfj+rriQoUXWOa6EmXCrHqtG3TfzktG3KU=;
        b=UGVx//NMQgQFU1KQk2YdmheDhJUAK/DHph7M9hyOIrMNJ71Fv31A5F4hrXAfa+wQm7
         bRPZhtiTIzZnP9lLQY0N4fGcczvRVAXSzqI2wg5nMJ+ggPFtTAfKx+jfSg7e1wQPEe+5
         64Lh+MA1NxMNJopI6q7rArd/6pzsOHUTIRviB3At/fUUdNsGFqQ/XrTXb8y45E39arfq
         1ti5jUoNbUp1h2u4+MnGCfWhPhvFFDEPzIU/XkAKQcgsm3YA0fiUCb93sDhHGQLFM2xs
         VfiF9veQf2Mvwypmf2ALEMsk+b5eUzjkxkYaxmCbJ0MoA5azGRXI7S2OJu1boYh9/Ux2
         ylog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733859243; x=1734464043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmgagnXUnlfj+rriQoUXWOa6EmXCrHqtG3TfzktG3KU=;
        b=XWuSnF6OG4HXbJEoFj5vvDDa76ntJXR+OSGGrUzJtuAP8cBdedG933F4zJ3pM2lmHs
         kR0KlaNPtsViNZITeWH3o0QbtrYvMA/YKCNPtOgln3kZte0qdqEYjF1YMX5jgcUC/yJJ
         /8Q+jaI8VYc8tj7kNEGef2GuHwSiFIrcZV/Gl1G7bDJnOMxhemYVWKN6xMrZ747Z4Cm1
         +H/6b60AftLYom19H7jEky2UzjsMCxVKi7sVL4s9mSWYuD7lO4X74Pd81A5num8D4mFT
         Ame4OvJ9PECfAJSSPhzxn/7KJP6CsksnRUvdRCnaDbei4hfSyIfDKuEGH1Cpup/JT2SM
         vyEA==
X-Forwarded-Encrypted: i=1; AJvYcCVzpJ8Fmt22fBF/jlgfETgZ4kkpCf37+oP8nt1zT8S4OGAXLG6xeTasDfugRTIggXcYNaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMTYDwjYPC7JYHxIraEaYGPzeDdk5ZhdE1OaYXPneDv8k1t6Y
	/rOl8BFSpq4UrhSIRN2LVYmcYkZ3hlJnNLMCnWFWXvRCJDXkJsSBJceBIWiJaRyAkFh9gAU3lp2
	lplOwJEpzeMxDBwVqgTC/lPuHOkw=
X-Gm-Gg: ASbGnctEjOIvWcnhUD28xyHG89ahdCbA4cAqB0PDqk2bbPsZRK6w31+3DmNdt6rccHO
	ejz4Tqs4JIFpZoJt5T47gvgmRhcu8SSgE1I82NvOzLQlo4flkYI0=
X-Google-Smtp-Source: AGHT+IE6sxDr6x5t2rDsRWUY2b9PfcrVWIcTfG1O82YnDXSIIdgReK56blND885XDgwL6VjbEFsk0qdT91e0wVm+qwE=
X-Received: by 2002:a05:6000:4020:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-3864ced2ef8mr238729f8f.53.1733859242578; Tue, 10 Dec 2024
 11:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOzX8ixn1d4ja+LOJq_S_WDq=ZqtUTcV0RZzKpyJ2Yd0pBMx2g@mail.gmail.com>
 <CAOzX8iyS6ODErbnkyZO7RyVfXBCL5CFX5ydoKcvzc9LZf425Vw@mail.gmail.com>
 <20241210141413.GT35539@noisy.programming.kicks-ass.net> <CAOzX8iy=hELHmPAeMxQ3on_6dqJmJryGgvAXRxMOijqr+Jj62w@mail.gmail.com>
 <20241210152156.GX35539@noisy.programming.kicks-ass.net>
In-Reply-To: <20241210152156.GX35539@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 11:33:51 -0800
Message-ID: <CAADnVQJ3Xn-MvXL_UWw3gN6R0GZ0pxtv3_W1jhXG3+pZ56+upQ@mail.gmail.com>
Subject: Re: BPF and lazy preemption.
To: Peter Zijlstra <peterz@infradead.org>
Cc: Usama Saqib <usama.saqib@datadoghq.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:21=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Dec 10, 2024 at 03:48:32PM +0100, Usama Saqib wrote:
> > Thanks for your reply. It is correct that the problem I shared is
> > already present under PREEMPT_FULL, and as such there is no new issue
> > being introduced by PREEMPT_LAZY.

This is not an issue of PREEMPTY_LAZY.

Global bpf_prog_active counter that prevents nesting of bpf
progs attached to kprobes is a bpf side issue.

As we mentioned earlier we're working on resilient spin locks that
will convert bpf maps to use this new resilient spin lock.
At this point we will be able to convert global bpf_prog_active
counter to per-program recursion protection counter, so
that single prog cannot nest, but different progs don't interfere
with each other.
We already use a per-prog counter for raw_tp progs,
but vanilla tp progs rely on a global counter.

> > My main concern is that if PREEMPT_LAZY is intended to become the
> > default mode (please correct me if I am wrong here) before this
> > problem is addressed in the BPF subsystem, then this would result in a
> > big regression for us. This is especially true if distros pick up the
> > changes in the intervening period. I wanted to draw attention to this
> > issue so this situation does not happen.
>
> Fair enough; I think it'll be a few releases before LAZY is in any shape
> to be considered a replacement in any case. Quite a lot of cond_resched
> (ab)use needs to be audited, Live-patching needs a bit of TLC and so on.

Sure, but please don't wait for bpf to enable PREEMPT_LAZY.
bpf quirks should never be in the way of core kernel development.

