Return-Path: <bpf+bounces-42818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBC9AB735
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DBB285F26
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3217C98;
	Tue, 22 Oct 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcXY/I9B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827314A08E;
	Tue, 22 Oct 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626820; cv=none; b=VAD986T/jhphLYN12noElYcp+q3jkk20s8b5ZSzck1VSTcdukiGPUmPqfRyySUKRwcFXSNL/sKqCmruBYDYNfjGOID/wAxG1tKlHrmCx8fBGTiMIcd1AKwXd0ObLT50dyH8xiE9GjzN06eZnWdp3jZPjNAqghdRN4VmNKmgFmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626820; c=relaxed/simple;
	bh=zu7g/5/HL9SF2IcaPb9inbSL3XyFjVTKJymFXr+UTSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hk6CI7gM6U/uGRlFY38boVrSX4I5P+C2JgpdOh39poLj6j53E94KmBhHFQfXDgVq0ZdjbL6jVA+AVMzmg+4xjJtOWShW/RBN9glb5WIIsWebFaFGHxacI1lVNtaBLTw4gH3ctjmjBO0JxNtwPBFf+GLQM2qliWUWpeXwJkaGMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcXY/I9B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso4637162b3a.2;
        Tue, 22 Oct 2024 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729626819; x=1730231619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNkjBtHU4XKCMlHjJjLAXcu/TDvDDIWXc1q654mkyxQ=;
        b=bcXY/I9BUwPtUFst+nrR7YJwoT1ANDwmzZdgpFFs0K0EZaFCcIepiJzelq9VBAuj2X
         hFK+nK3hiHp50dLVhA4t32mgW/Gb/N8OMOEXFJ2qf7Iannm4+36IdQ0Ye6Qr8Ipm6MCH
         n5PsFevgy5NXEPx7eX8Oslxxk6PSZy0+oFVvbOMp8g9fgz/QEHKn/8otnzI0Kd8aQpK/
         fkzTibjfxN//n6KbrdTh8INk/Fcze+ozaGLoLaw5kkjzuXcDKEiYcpsogHwOCElHSpCR
         PGmHiymJaSKFNzSUKpo++UBwKXWRFpjmLh1zwGZi312mBlpM350MRjVDFJaXIwb6lSdU
         uE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729626819; x=1730231619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNkjBtHU4XKCMlHjJjLAXcu/TDvDDIWXc1q654mkyxQ=;
        b=rb1DVchta6h7rp50tmVZnxO6JYX0ll1Nwa/92p2nYqNwnASbHBW4UM5cEq7F1gT0s0
         5qBXOkS/ygWCkkDsET7TL+ZJPGIxk/x7zAjnlY/xaEGTjJbCB914Cn3PUCNISA6A1T/y
         25P2GBwsM3w9MGIPfExqLMyrGiX0SX3ME1D0U6gOVTj4AsQys8hw3Yx1n0K4ZCfASN1U
         ai52jNJ4wVtCVqZTu4l2K3ROutrB+VaOpxQVAC3AXeikHOoQybFMoQf4KKhmkkKBJnXM
         i2dcq66ZdPNlUJQkHgYksjSGXeDJDLq59FxSv9w484nKkBpGhUQr91luM4+pJAI8B2a7
         FoPA==
X-Forwarded-Encrypted: i=1; AJvYcCVIkzrJbLcLUkFV4x/rrqPbr8mHoT09yi9d6pDQCJl4m0JPQy7Z6psk4zF6c2mWggWZHWc=@vger.kernel.org, AJvYcCVygo27y1Lxpg9uc4VA9+n4u+bXsyd0dyEQ18YaFawmAzyZB3V+7sBng76Hudp5+yQ4EKCPx4GE/ZOW1e4P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5y3AToMW24FeVyqv2vSYNlAwGt+lUkDKdueBcWi66daRQGb2P
	LpoHsEkPq7fLWTSsFC9Mes8t2QefXBQ9BDlFvI6oEfOMlGvg4Fcjbm7+O8KPGWlb5j4wRnyvDmW
	FMLvqUp4wUo8q5WIEXPHzwZUlgMo=
X-Google-Smtp-Source: AGHT+IFzk7Nh40kBQ6xkmyIgVm5JC7G4/Bq1Zbz4rnk61TDXGTY7casCuor9L/wYCf/R7X7DPuIgfWlWnT7Xn1qxvdU=
X-Received: by 2002:a05:6a00:3c8e:b0:71e:4bfb:a1f9 with SMTP id
 d2e1a72fcca58-72030ba0874mr556152b3a.22.1729626817848; Tue, 22 Oct 2024
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
 <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com> <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com>
In-Reply-To: <3362d414-4d6f-43a7-80af-1c72c5e66d70@efficios.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Oct 2024 12:53:25 -0700
Message-ID: <CAEf4BzYBR95uBY58Wk2R-h__m5-gV0FmbrxtDgfgxbA1=+u0BQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jordan Rife <jrife@google.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:55=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-10-22 12:14, Jordan Rife wrote:
> > I assume this patch isn't meant to fix the related issues with freeing
> > BPF programs/links with call_rcu?
>
> No, indeed. I notice that bpf_link_free() uses a prog->sleepable flag to
> choose between:
>
>                  if (sleepable)
>                          call_rcu_tasks_trace(&link->rcu, bpf_link_defer_=
dealloc_mult_rcu_gp);
>                  else
>                          call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_=
gp);
>
> But the faultable syscall tracepoint series does not require syscall prog=
rams
> to be sleepable. So some changes may be needed on the ebpf side there.

Your fix now adds a chain of call_rcu -> call_rcu_tasks_trace ->
kfree, which should work regardless of sleepable/non-sleepable. For
the BPF-side, yes, we do different things depending on prog->sleepable
(adding extra call_rcu_tasks_trace for sleepable, while still keeping
call_rcu in the chain), so the BPF side should be good, I think.

>
> >
> > On the BPF side I think there needs to be some smarter handling of
> > when to use call_rcu or call_rcu_tasks_trace to free links/programs
> > based on whether or not the program type can be executed in this
> > context. Right now call_rcu_tasks_trace is used if the program is
> > sleepable, but that isn't necessarily the case here. Off the top of my
> > head this would be BPF_PROG_TYPE_RAW_TRACEPOINT and
> > BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, but may extend to
> > BPF_PROG_TYPE_TRACEPOINT? I'll let some of the BPF folks chime in
> > here, as I'm not entirely sure.
>

From the BPF standpoint, as of right now, neither of RAW_TRACEPOINT or
TRACEPOINT programs are sleepable. So a single RCU grace period is
fine. But even if they were (and we'll allow that later on), we handle
sleepable programs with the same call_rcu_tasks_trace -> call_rcu
chain.

That's just to say that I don't think that we need any BPF-specific
fix beyond what Mathieu is doing in this patch, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> A big hammer solution would be to make all grace periods waited for after
> a bpf tracepoint probe unregister chain call_rcu and call_rcu_tasks_trace=
.
>
> Else, if we properly tag all programs attached to syscall tracepoints as
> sleepable, then keeping the call_rcu_tasks_trace() only for those would
> work.
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

