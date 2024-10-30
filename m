Return-Path: <bpf+bounces-43560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EA9B66BD
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A90AB236D2
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F71F582A;
	Wed, 30 Oct 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNhX93z8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056F1F1308;
	Wed, 30 Oct 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300407; cv=none; b=ijc29YGpfIDUOsJ8q83u4qMFgw8JZlCHLR65TqBIkF0od4LB+9tQsOS8PzESHZp6IYC6oWm0/mzmJa4Ue53IK66wMabgzT5qBSJ6wre4s+2Cmm2AmCMDcjf9DatTNW3AelUKSl7fK9FL5KFkzKO8I1i1SPHnl4kq+4DfCYipcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300407; c=relaxed/simple;
	bh=oi+p0UaAbcbSXTT3OAwkhFoHLKNlpq/uQ4oKcVjlTF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKJCxMIN5guiuKmGIHrmAvkYAbUjwCkMQvjEhdYacLf5nrCblM70DjxivtFwP11YuthlfzCjkE/0WH+BOGG/GuM2W4nRXJAPTb+xWHai5ZXCeboOcXQdWFhy2v3HGRYRw3vF/uaWKVW0IUKgWeEmOzC8jH4vWitmhYuStQ5RWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNhX93z8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43169902057so62733955e9.0;
        Wed, 30 Oct 2024 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300403; x=1730905203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB2BbgH3O/pZn9GHva0yEd7H2+eN1brmYySZkc0FRto=;
        b=YNhX93z8VqaJNGLjp/FYZW8md4nh2JXseuAfxLxNPv+XXeQYHR39oH12o/uNlgaA0G
         K2YB5I7BPil+VooV8FxPHD3ThaLMe14fHltGA5fW7/0tG0TRxRyXrsSa12x19vfIuTtx
         MHTBdqLxL2X6euhyw0nOvRgPmyLePJHETeuqRw3YOCv6JV9XcIORZw3/9W5fzb58kvXB
         Eq5QQN4tjfw2AFA4/3/3Va6PdWn3+aMDSrco50Os39eg0u/B0FT9bVCL2IW/i+pLKyWy
         al6vm6b3Xva1iIwco6jMdCrpuzcHMDVxZDP5xCu7NgZSTOSyBNrMh/Oo2nLaWCVQQXRf
         s7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300403; x=1730905203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iB2BbgH3O/pZn9GHva0yEd7H2+eN1brmYySZkc0FRto=;
        b=oKvwEG0Dw99gceDtao4wkL4jm8gybRbqnYQPYs+2UMPPWleM+2qrAK5ieLg2k9ollG
         lPYTFvci+fyaq45sqCscpr5UYW7G3ihRCkRrW20W9673SUE+9+ky33ExeRRPHjU6PlYg
         GlD2XgVXUSqTfYj3ty/+JCPgwerpxfWe8OS4KqC2Gin1dj1ZFtIyPUplfah2hqZXHTg6
         /crIguvX/w9fFVHONKT/wHD0sTXw1OHNoaISv9PVYRouqvW2VOvw1R9v67HotQNvI4yH
         sP6xxYyZVFUMTkZ4jz8xl52mHpSclAJlC5BCphUe7ouIl9iae/h6wwXq4J4P7FJf/JJC
         Yilg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQkazNErNOnoST5UbBEpSdeSOWLadfF720qSu54jBoCbtqoAN87577nTvCRyZo1PEUt8=@vger.kernel.org, AJvYcCVoD2KxH1kfj7Pnj66/GD/QEULz0tfk85bYNFXvnHGU2JuGlTQRVLftU+ww+f1wndxi4GPnuCvREMPtQkpX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1/0eoBOWqJl2vIJBPFjUr+xyrUSyL/FLdarPOWu7Q/7w4qtq
	9NS0yoFlHLY6cBW/6CvSRvT2u6AW+SvHBlc4FGmmresmi2m8U/ZbBrTV6IvkH3xaTzT8pt3OH85
	2zXHd9WhBKbdEP8Y4ond6BNBqd28=
X-Google-Smtp-Source: AGHT+IGbdD9XkGELUxPU2xXBDJ5pZ7pFApkwCRDH2KPXtQTXM7qdOqXzI16WAuOmidLvDlYhZjgd+XtOmODaugd5HbE=
X-Received: by 2002:a5d:564d:0:b0:37d:39f8:a77a with SMTP id
 ffacd0b85a97d-381b7056ba4mr2600263f8f.8.1730300403240; Wed, 30 Oct 2024
 08:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
 <20241029002814.505389-1-jrife@google.com>
In-Reply-To: <20241029002814.505389-1-jrife@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Oct 2024 07:59:51 -0700
Message-ID: <CAADnVQJeWj2t9XSRxK5NU99GJsOBnropoOOohDNPj7N2xZFGEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Jordan Rife <jrife@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:28=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
>
> 1. Applied my patch from [1] to prevent any failures resulting from the
>    as-of-yet unpatched BPF code that uses call_rcu(). This lets us

...

> [1]: https://lore.kernel.org/bpf/20241023145640.1499722-1-jrife@google.co=
m/
> [2]: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google=
.com/
> [3]: https://syzkaller.appspot.com/x/repro.syz?x=3D153ef887980000
>
>
> [  687.323615][T16276] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  687.325235][T16276] BUG: KFENCE: use-after-free read in __traceiter_sy=
s_enter+0x30/0x50
> [  687.325235][T16276]
> [  687.327193][T16276] Use-after-free read at 0xffff88807ec60028 (in kfen=
ce-#47):
> [  687.328404][T16276]  __traceiter_sys_enter+0x30/0x50
> [  687.329338][T16276]  syscall_trace_enter+0x1ea/0x2b0
> [  687.330021][T16276]  do_syscall_64+0x1ec/0x250
> [  687.330816][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  687.331826][T16276]
> [  687.332291][T16276] kfence-#47: 0xffff88807ec60000-0xffff88807ec60057,=
 size=3D88, cache=3Dkmalloc-96
> [  687.332291][T16276]
> [  687.334265][T16276] allocated by task 16281 on cpu 1 at 683.953385s (3=
.380878s ago):
> [  687.335615][T16276]  tracepoint_add_func+0x28a/0xd90
> [  687.336424][T16276]  tracepoint_probe_register_prio_may_exist+0xa2/0xf=
0
> [  687.337416][T16276]  bpf_probe_register+0x186/0x200
> [  687.338174][T16276]  bpf_raw_tp_link_attach+0x21f/0x540
> [  687.339233][T16276]  __sys_bpf+0x393/0x4fa0
> [  687.340042][T16276]  __x64_sys_bpf+0x78/0xc0
> [  687.340801][T16276]  do_syscall_64+0xcb/0x250
> [  687.341623][T16276]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I think the stack trace points out that the patch [1] isn't really fixing i=
t.
UAF is on access to bpf_link in __traceiter_sys_enter
while your patch [1] and all attempts to "fix" were delaying bpf_prog.
The issue is not reproducing anymore due to luck.

