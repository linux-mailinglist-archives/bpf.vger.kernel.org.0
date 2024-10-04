Return-Path: <bpf+bounces-41011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1F99104C
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCD3B2FEBC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9C1ADFFE;
	Fri,  4 Oct 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+oAieAA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC81AE000;
	Fri,  4 Oct 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072275; cv=none; b=Wrg23OtnMUiESk4QfyBlV4QV0w14Yr5byltQ9HnV/vy+1+ydmZag9Ix9jTtSqvUlnBEllR8oaWgMmvYF8W1L5FXfGPFnlOheTSJAo/+d/O80O7qjKmHMfqzKq6jc+WvhpGbdEV5eanER+NkfirlRPKNXyK9JRR7DVl352B81uOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072275; c=relaxed/simple;
	bh=cCdDTcUm4bFPThg2lM08rNCWleBMqiey7gEaVCUSrxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czl8jJ845fmz/kNqa/pbTka2HBKFNjtjQvoYkqrnQCD1rnBbVBM8sG2iExSUNH+91/xaoWaed526E7OYhy6Q1dvFhnR/zFfXirmkRgJRClEsLoxvpnbjXOxRjxNVz2Qfx5B/kFi18I42bxolJppiu7ZR9z6D+u8f8NQdiQww9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+oAieAA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so1851982a91.2;
        Fri, 04 Oct 2024 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728072273; x=1728677073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCdDTcUm4bFPThg2lM08rNCWleBMqiey7gEaVCUSrxI=;
        b=h+oAieAATR88aEyk8Fv2uGuwnkrkXOVAVFwBCVYLNuc0Qe2EnlZvDJvdMASRo3zwlH
         Yml1aODVAK0IdeGaY14J2iywMRXoRFK5ACrWhnXYoU1RP9aMIRgcqc7uiV/cY6XJm0ZD
         K8zqdml3YZp01u12xtSAo5ogPWwYjiQtmDydIwLfkB4Z+tDXRoET9/7pPy81PkBOS0XW
         0OTgpO13WeJ4SyVU2aM93movsFbgo/RHf7J0oMckatSE4Q+1pADyM7/qDScPHfJWMDqT
         dMpPZ9i7INa53dLDA8XZpKOgIaiLNW/jn1XecrwqbP5xtc7Kn5folBTHIYaKTK3fqm6N
         qJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728072273; x=1728677073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCdDTcUm4bFPThg2lM08rNCWleBMqiey7gEaVCUSrxI=;
        b=jqxX9QzMim6wjLwmWxjzcx5kQ6iu7HKwcXH6ZB28bj3uPUAOKA3aAThpYhnrse8aRt
         DsdOgJ6mRdI9T9wUAWU4CGF4MBVBITUbr1BT7Kpwy/9fYD9Vz3qAUwlIsuEC4fJyOHM0
         HXerR8J5aQGeHyKjCzRpm46GwlfMQvXlXdvj5m4EU+sMw2e/o+yi+R7Z7yGiJ9PNeFoI
         BCUedbm5E0nVILaVvX6eWgnyGbnlNOiSkjXmow5ww5x2FoGHKEsOsK3ZHliIXTS45pve
         mqpMLHd8UCUUk+81LCV05SLYIvGIwNiFexm+yovDMLUdUkLo6PWlpgLJQwN8Xhyy4qQH
         9lng==
X-Forwarded-Encrypted: i=1; AJvYcCUapnnpWxdxaPc4euxLU/1jslYSpvWQPyoE1QyV25+WO29W6q0WPkaMeRUi8vV5Qs0bBkSoC4cCkdidSkHl@vger.kernel.org, AJvYcCUzQhWVII4C1maCgD195aI/zm+AYsfkX0IHR1cG+7Z/pv/BCCmRM2dpc6/f8KyDwnn+w7S4DtwJK7yE6oyOuTCEFJZf@vger.kernel.org, AJvYcCVD7/G6tTlR0V5YTuYF+lIeYiyrfZMSJKsPKy91u7mBRVIZwwwNxJDb+AWeSCLQqt5T39I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CDJxYxf72HqZkXqRWIsr4GMiw+W7rLguGxZkgnyUg5be3C3U
	S3Yi8xaU3SQ7HiAnanugtXb8FckuO+TbGVjTGGXKEfhSq40BM/PAoZ+A78oAEI17XRgz4ppR/oc
	4ZCejahLeVQsPsZmOxZ/2LL3Hxuc=
X-Google-Smtp-Source: AGHT+IFQaZ6vae6vffxFo9uyG8YGJ9VcxjSrqhSww64Y2yjTDJ/Nrff6qKFiOLgb8v51yyr+nVi0h1iA86TuS8otjmg=
X-Received: by 2002:a17:90b:3889:b0:2cb:4c25:f941 with SMTP id
 98e67ed59e1d1-2e1e6264456mr4150777a91.17.1728072273163; Fri, 04 Oct 2024
 13:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-3-mathieu.desnoyers@efficios.com> <20241003182304.2b04b74a@gandalf.local.home>
 <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com> <20241003210403.71d4aa67@gandalf.local.home>
 <90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com> <20241004092619.0be53f90@gandalf.local.home>
 <e547819a-7993-4c80-b358-6719ca420cf8@efficios.com> <20241004105211.13ea45da@gandalf.local.home>
 <4f1046e7-7b62-4db3-93d4-815dc8c27185@efficios.com>
In-Reply-To: <4f1046e7-7b62-4db3-93d4-815dc8c27185@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Oct 2024 13:04:21 -0700
Message-ID: <CAEf4BzYHXz0UFOOnkAeKDK-yt59cwz-66_4wL-bjmv3zxryftg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with preempt_notrace
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:53=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-10-04 16:52, Steven Rostedt wrote:
> > On Fri, 4 Oct 2024 10:19:36 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> >> The eBPF people want to leverage this. When I last discussed this with
> >> eBPF maintainers, they were open to adapt eBPF after this infrastructu=
re
> >> series is merged. Based on this eBPF attempt from 2022:
> >>
> >> https://lore.kernel.org/lkml/c323bce9-a04e-b1c3-580a-783fde259d60@fb.c=
om/
> >
> > Sorry, I wasn't part of that discussion.
> >
> >>
> >> The sframe code is just getting in shape (2024), but is far from being=
 ready.
> >>
> >> Everyone appears to be waiting for this infrastructure work to go in
> >> before they can build on top. Once this infrastructure is available,
> >> multiple groups can start working on introducing use of this into thei=
r
> >> own code in parallel.
> >>
> >> Four years into this effort, and this is the first time we're told we =
need
> >> to adapt in-tree tracers to handle the page faults before this can go =
in.
> >>
> >> Could you please stop moving the goal posts ?
> >
> > I don't think I'm moving the goal posts. I was mentioning to show an
> > in-tree user. If BPF wants this, I'm all for it. The only thing I saw w=
as a
> > generalization in the cover letter about perf, bpf and ftrace using
> > faultible tracepoints. I just wanted to see a path for that happening.
>
> AFAIU eBPF folks are very eager to start making use of this, so we won't
> have to wait long.

I already gave my ack on BPF parts of this patch set, but I'll
elaborate a bit more here for the record. There seems to be two things
that's been discussed.

First, preempt_disable() vs migrate_disable(). We only need the
latter, but the former just preserves current behavior and I think
it's fine, we can follow up with BPF-specific bits later to optimize
and clean this up further. No big deal.

Second, whether BPF can utilize sleepable (faultable) tracepoints
right now with these changes. No, we need a bit more work (again, in
BPF specific parts) to allow faultable tracepoint attachment for BPF
programs. But it's a bit nuanced piece of code to get everything
right, and it's best done by someone more familiar with BPF internals.
So I wouldn't expect Mathieu to do this either.

So, tl;dr, I think patches are fine as-is (from BPF perspective), and
we'd like to see them applied and get to bpf-next for further
development on top of that.

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

