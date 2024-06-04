Return-Path: <bpf+bounces-31357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B08FBA0F
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB5E1F24551
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4C149DE2;
	Tue,  4 Jun 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL0OWe+P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D9146D6E;
	Tue,  4 Jun 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521194; cv=none; b=K2YZMsZGXlDK9vUYtgmQpSVIfq/0Qh0lo/IzLS5CXjaaBSH8+os/fOzeWe/ndqaxLQZWwArNWi5DGbr9lHzNhXh6nM4vKTLEW+IHRDv4geipeoOSYYCMQFrm196cil5bLet8upj6cQqDi76H+xthu5g/H0WSAZlJvPtFpHg00yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521194; c=relaxed/simple;
	bh=kXdijRIJocHii0MTon8pAqxmyNLyse1s5VvwstOAHvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxCp0OJeV6Hc6JNWIOBjrUZS/NZ5I9v9qNqnZ1Q8cQARQeJsmZBGanZ7ZKnqMo65MNm2QEMTWdYZB8/s2HV7N+3jfnzm7SHu625nMdnsarN/m5mg2oNlajCqSr53hS5bbaTn2zo8f0cN65mUm91wT19Fj6MlKjRRToCNMXnJlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL0OWe+P; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c19e6dc3dcso4716609a91.3;
        Tue, 04 Jun 2024 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717521192; x=1718125992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OadnoCUmoudPOWNUZp+jb3lQDm1poOGWS7Y8+PUxug0=;
        b=gL0OWe+PH6gezRsfe9nKBTqAA9dJ8imrzTSirxQv1mNg819kd0FkuMOExIikFSWjTC
         EW+fpOzUqovwlnolVBXHkoNUTqSb8xGqIK2d6pZP8D+YS41S6FP96T6h99LMLN+lA0Qt
         4VhHMhleZiQEn4XzozB89JfVAru6vxkpxz7Bm1F2vGmavoO/9LAA3teM5x+ywjOAT44Q
         lmGsKNGJwcwMaHZ4NAdp66eZ3bSSi9tRGqXJvob3YGMhJVzGZ+dz8eIkfoQUVmXxi5WT
         NlkC2N+CWnNe17X+t1MVjVxCHupI84Io49YF65gNu5D8sQZMhhdI57SirEHhZ9sNRMAx
         s2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717521192; x=1718125992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OadnoCUmoudPOWNUZp+jb3lQDm1poOGWS7Y8+PUxug0=;
        b=cHCmLBRwgxmAY9CwAz5ybwG2cXA8lRxaovLqB4JRZmIQ1zsqkGBO01LFOMZ1ritc1i
         H/E0sZAbUCCNFrsdTFggeQ+qMlD6Lxq3Sdlcw0YfJK2avP+5+8x+P1JvJfvtigvnU1O6
         Q3G6+STgA7gtKd/EOi07siBnLoWvSut8723p6ULmpYu1LVPm0tjGNCycK6yAkP28hr/d
         Ts8x0zh/fNAAcGRjO5abqkfuCsetTJkCkYQjmYVeYIEO7IsaykwdqA2Ls1PgaK5nKRDB
         CbkMldlB6CSRKQSlbwwknuBk5L/8yjsyC2qrc9HG/rMDbDFakQFxg7oqEaJXmhnqXIMG
         b/4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbwt9Dt9AsgjZTXsrydvcUdYCP73PceSTQvFuI5+erdcPdceI0r+JRNxjJMKbvgjoqqTvREc3esnfCT/7KaWrIqK3PimbyUAIWbECbzlZbzJY6vd8qWmOzHmhOQI8ej5DKOO8G4PNIpMinuxU2DSORJRixhUDiBcv5tW5a9nVBiXWxGIHaDwmwOA==
X-Gm-Message-State: AOJu0YwtlqOTjst4kSlWecR4mOwltJ3kl8IyxFziergZ0srmG2dfn24C
	nbTJT9hkDJ6oU6IcpQkPkBlCMw0OBVgLSNjlMbZtNGfMmg7QR1SnbYfhfzlQJK+Ikg3G9Oa/5y/
	u6sc3OKCq7t0EZeSmeF3taI3+EXhsCw==
X-Google-Smtp-Source: AGHT+IE0RXAScO87dOsPMaiKHHDRMCITo/LWphNopqp5bczfX0qp/mDUvA1Lm9yX3RXdl8+eL0TGlM52D2/VimUZL68=
X-Received: by 2002:a17:90b:17c1:b0:2bd:edbe:4e1 with SMTP id
 98e67ed59e1d1-2c27db61056mr66947a91.31.1717521192465; Tue, 04 Jun 2024
 10:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522013845.1631305-1-andrii@kernel.org> <20240522013845.1631305-4-andrii@kernel.org>
 <20240604230603.16e5fedaf3d9a4981e619259@kernel.org>
In-Reply-To: <20240604230603.16e5fedaf3d9a4981e619259@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 10:13:00 -0700
Message-ID: <CAEf4BzYEXf0GuiV0P17mjmtJ7hj5tHaYN33A1B3C9YcroGwk0Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, x86@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 7:06=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 21 May 2024 18:38:44 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > When tracing user functions with uprobe functionality, it's common to
> > install the probe (e.g., a BPF program) at the first instruction of the
> > function. This is often going to be `push %rbp` instruction in function
> > preamble, which means that within that function frame pointer hasn't
> > been established yet. This leads to consistently missing an actual
> > caller of the traced function, because perf_callchain_user() only
> > records current IP (capturing traced function) and then following frame
> > pointer chain (which would be caller's frame, containing the address of
> > caller's caller).
>
> I thought this problem might be solved by sframe.

Eventually, yes, when real-world applications switch to sframe and we
get proper support for it in the kernel. But right now there are tons
of applications relying on kernel capturing stack traces based on
frame pointers, so it would be good to improve that as well.

>
> >
> > So when we have target_1 -> target_2 -> target_3 call chain and we are
> > tracing an entry to target_3, captured stack trace will report
> > target_1 -> target_3 call chain, which is wrong and confusing.
> >
> > This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> > instruction being traced.
>
> I like this kind of idea :) But I think this should be done in
> the user-space, not in the kernel because it is not always sure
> that the user program uses stack frames.

Existing kernel code that captures user space stack trace already
assumes that code was compiled with a frame pointer (unconditionally),
because that's the best kernel can do. So under that assumption this
heuristic is valid and not harmful, IMO.

User space can do nothing about this, because it is the kernel that
captures stack trace (e.g., from BPF program), and we will lose the
calling frame if we don't do it here.

>
> > If that's the case, with the assumption that
> > applicatoin is compiled with frame pointers, this instruction would be
> > a strong indicator that this is the entry to the function. In that case=
,
> > return address is still pointed to by %rsp, so we fetch it and add to
> > stack trace before proceeding to unwind the rest using frame
> > pointer-based logic.
>
> Why don't we make it in the userspace BPF program? If it is done
> in the user space, like perf-probe, I'm OK. But I doubt to do this in
> kernel. That means it is not flexible.
>

You mean for the BPF program to capture the entire stack trace by
itself, without asking the kernel for help? It's doable, but:

  a) it's inconvenient for all users to have to reimplement this
low-level "primitive" operation, that we already promise is provided
by kernel (through bpf_get_stack() API, and kernel has internal
perf_callchain API for this)
  b) it's faster for kernel to do this, as kernel code disables page
faults once and unwinds the stack, while BPF program would have to do
multiple bpf_probe_read_user() calls, each individually disabling page
faults.

But really, there is an already existing API, which in some cases
returns partially invalid stack traces (skipping function caller's
frame), so this is an attempt to fix this issue.


> More than anything, without user-space helper to find function
> symbols, uprobe does not know the function entry. Then I'm curious
> why don't you do this in the user space.

You are mixing stack *capture* (in which we get memory addresses
representing where a function call or currently running instruction
pointer is) with stack *symbolization* (where user space needs ELF
symbols and/or DWARF information to translate those addresses into
something human-readable).

This heuristic improves the former as performed by the kernel. Stack
symbolization is completely orthogonal to all of this.

>
> At least, this should be done in the user of uprobes, like trace_uprobe
> or bpf.
>

This is a really miserable user experience, if they have to implement
their own stack trace capture for uprobes, but use built-in
bpf_get_stack() API for any other type of program.

>
> Thank you,
>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/events/core.c  | 20 ++++++++++++++++++++
> >  include/linux/uprobes.h |  2 ++
> >  kernel/events/uprobes.c |  2 ++
> >  3 files changed, 24 insertions(+)
> >

[...]

