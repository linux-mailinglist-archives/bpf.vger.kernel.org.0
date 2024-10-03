Return-Path: <bpf+bounces-40886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1EE98FA3A
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8768E1F23F92
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80C1CF5C4;
	Thu,  3 Oct 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joWcI1HA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC11AB52C;
	Thu,  3 Oct 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996749; cv=none; b=NciefPMVUk1aQ5Bcc+W1c/S+xDzuwYzIfQs3HtOHo/jQpWdayQSR9Kh6E15zG/qarxDoy+FLQgFOoBCpZk+c74G1BPIc3zkO31Tt+nkf9cDwjyGs7NxepWpuOj4q0005vgtbA2C/wOHsUAVbUud0Yo+q0IDHQDetH3Pdx8n1Zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996749; c=relaxed/simple;
	bh=GJK8MxVOy9r24pLbZWAA+hcaotGVtjt0vYTanGiEQBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiwuHI0Dz++APW3jkNIN6hQTmPLAUgVpsckjHJZzmc2iwf+kBh8C4uYjZs+5aF5LNIKu9+BvjodhVoUvLukSYXI9c6/DTqcey8C9fCKb1OpEfDHeM1Kk4vG2ZZI+4A+BqmRioQmYvI5EKyF7XLqPQYBv6UBHXTj4xj7N1CXHBFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joWcI1HA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90188ae58eso190137266b.1;
        Thu, 03 Oct 2024 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727996745; x=1728601545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qiv5EFW/VrsTiKdI6YCW2xt9YR/sCLybPV9j/RuSzd8=;
        b=joWcI1HADKzeHLQRDqaf0NqLpSayvBHlLccsfnWzyTQKjBxpHAk7lhN3FXcBA6rL14
         QxHuhZXcCGZSStFviYPJo29RLIGJG5Ce3ramWSgRJGWSMgaeIVGvH36Et9fBbqJCxa+q
         0Y/HXDO4WZHF3d1Yd0OJZKy8gbmvMRh243YIwv53zs3Xrf+X0qe2/vx1SQVBc5hr90M+
         7CVaQdY0mF5wLHVLHJMo+OdnzF0ejEtvA9aUhVj86TtAu7P+sGgJCY7VOi+buXxDnAH1
         wJmde5CN1grGYW1VdSUmI+yxpHgupxKLEQ5i7C5VJN8X41hj/CNKqlbTHAhhneaHZbJQ
         HvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727996745; x=1728601545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qiv5EFW/VrsTiKdI6YCW2xt9YR/sCLybPV9j/RuSzd8=;
        b=YpFr6pLwN/CknTAu3Dq3l/Mz2lr+WVeHqKid/3UOr2o9iXjOaJUh+RbJfmFd5enmsN
         33OERJ2tz9fry3g0KphEShiJ3eBGBvaM1lGzu68DDRehhUHhvZc0E0psiN+IQ/sCgYTG
         E7dTcLrDmE17Oj2xl7aU7PkYyPs7F7gKVGyYG3frGB26Qz053uBc1ToJIxXlxcbXWALu
         kJUDKcotDiWGiQFmFueKrxzD3wlRKaiqj+KC+0DcRt5Y5swtBfWDzY38kGGubryDYCLE
         B2msLZTR0bMw+L7lcKqUJyi287qQS54teRNjs2e7C23p3H86+RU3JH4ovkj+jLpHFW5q
         RuAA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQAM6AmBsZKYFIXVqTx/EvCX/npcUXj6CQGPuk+wc4mQtkindSfzgEda73B4I/w5LQe1y+I0VqUKYNdvp@vger.kernel.org, AJvYcCWk0L+gIiIGFp/wvRmmm9MagLbpM8yAimAC0UGHRM/fVP/hFrZX0WdEYQF278mDSk/w659ArHbwex5u95ccJUuOT+7D@vger.kernel.org, AJvYcCWly7lDozJkfKuCcfKgDHiJnQXBD4WlJJKfvBuWQcbHlj3YZuHAf8+WF/ktU4T7MAb6qWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy390Gt/bGSIvYjQhRhPnklsPZYvKj1HS8PUXUSNi+mdRpnwqQg
	X5W01Tm1u3nPOSq1fXH7O/T2+FY+Khdt806oN1ceIrPPr+vuOvSlyiqJtiILnkhpHNKQrpA+aGZ
	0Xa8O0ezUF8WGsA7K2NVKsJn1+AM=
X-Google-Smtp-Source: AGHT+IHQAbJf0SjHlooLFwT3AMWZlGMPUoE9vfL5iZoG8q8yjr86EKrsaiYSlEZFeN28E6i32Z8MUDazi37kLGhOlns=
X-Received: by 2002:a17:907:1c10:b0:a8a:445f:ac4d with SMTP id
 a640c23a62f3a-a991bd3f96fmr80094066b.18.1727996744662; Thu, 03 Oct 2024
 16:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-5-mathieu.desnoyers@efficios.com> <20241003182604.09e4851d@gandalf.local.home>
In-Reply-To: <20241003182604.09e4851d@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Oct 2024 16:05:33 -0700
Message-ID: <CAADnVQJf535hwud5XtQKStOge9=pYVYWSiq_8Q2YAvN5rba==A@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] tracing/bpf: guard syscall probe with preempt_notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Michael Jeanson <mjeanson@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:25=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  3 Oct 2024 11:16:34 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>
> > In preparation for allowing system call enter/exit instrumentation to
> > handle page faults, make sure that bpf can handle this change by
> > explicitly disabling preemption within the bpf system call tracepoint
> > probes to respect the current expectations within bpf tracing code.
> >
> > This change does not yet allow bpf to take page faults per se within it=
s
> > probe, but allows its existing probes to adapt to the upcoming change.
> >
>
> I guess the BPF folks should state if this is needed or not?
>
> Does the BPF hooks into the tracepoints expect preemption to be disabled
> when called?

Andrii pointed it out already.
bpf doesn't need preemption to be disabled.
Only migration needs to be disabled.

