Return-Path: <bpf+bounces-18318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EAE818D97
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 308F6B230E6
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61F41C8D;
	Tue, 19 Dec 2023 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKiNLpr8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690620DE3
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33668163949so2686970f8f.2
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005301; x=1703610101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7NV5LWhvUDYZf+HYwAooiTmLw30EZvE8riWNGb6udw=;
        b=aKiNLpr8lBPnji87ivq6312NfJFU/isQHz4ISs4lm+BkpZzi5c4Hzw7UFxrzshTrVe
         /iOUYIG8I2aMglk5F6NryhrlItJuw5V06pQIa9sI8BSWOpGhllItRo0ycFKfiKvgPMhU
         lDOsUQk2RUkd07LY4qwjsVvjyG9m0Iz6pDh7w7wiynP7IdONruJKXob1waNfn6gtMfKL
         IrpfdUVKikKqIXdJv166xRI5gi9iYCOnP2/MfYR1SHrBQ4vfNiFituH5sW1/zp65dEf3
         4ecT7R2vOQFA5jVMbuf6DEB6nLzA3fz8MBhsDs+hq64defJUH7/U0nhFHDtu1eyYxd9U
         e8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005301; x=1703610101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7NV5LWhvUDYZf+HYwAooiTmLw30EZvE8riWNGb6udw=;
        b=DTQNYTH5gJnBhE4YtL8i65gP/z8XUivap2ivjlRXnZyvc7EfA2jh6cfI9fCA46P7jC
         ap0yQj59xn3oyRHmkhZv/Sxb+Kqw3WtFZkxCkBOTBFN0zhSsNJXUcDL8MOGDVP/TCWa0
         fe96r3D5GAObAkLn3W7ZSgsQXHMLpfduKR+nQZ5f9uxybnimWvpsMjsLViewk9H5wxH3
         JJzlIMNmtkDKW/S2PABLX7mWu5nL/yl7j8nEKXSl+1xwiWssFW7X/9qjAKs7B4DPYUKX
         wHbCha2bqCbFOoi1Du/fA+qpD0qvqgfhlbWOfIVASNcn/Kx1H2D87cA9GNeB+DZxMouB
         2u1Q==
X-Gm-Message-State: AOJu0YzIt8YOu0yuFxT65sLxnz+JGuTgVyySGRxqxuiftnsQB1JVOTO/
	OoKt1ZBa9ijeaSc5VXkwrZgcRVUNozRjddpaERM=
X-Google-Smtp-Source: AGHT+IEnR2qmsJ8uaWUI9sWlTZiot7GoHQURS1RaY36RjaamC6gOmz+9tSrY7AADZ+z76tErCc0MRpJDOwSBJrFvUlE=
X-Received: by 2002:adf:f9c3:0:b0:336:76c9:f452 with SMTP id
 w3-20020adff9c3000000b0033676c9f452mr154058wrr.140.1703005301045; Tue, 19 Dec
 2023 09:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3dd9114c-599f-46b2-84b9-abcfd2dcbe33@linux.alibaba.com>
 <c3c47250-2923-c376-4f5e-ddaf148bbf32@oracle.com> <CAEf4BzZOBdV9vxV6Gr9b5pQ8+M6tPVnHdmELWqOd5jdcL=KpiA@mail.gmail.com>
 <23691bb5-9688-4e93-a98c-1024e8a8fc62@linux.alibaba.com> <CAEf4BzaQv23wzgmmoSFBja7Syp3m3fRrfzWkFobQ4NNisDTEyA@mail.gmail.com>
 <qdiw6a7acgvepckv6uts5iusp74m7ud4i4lpniu3mgq6jdrs6s@mnttkagth64k> <20231219083851.0ec83349@gandalf.local.home>
In-Reply-To: <20231219083851.0ec83349@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 09:01:29 -0800
Message-ID: <CAADnVQJ-E225UUyCjEayYG=QujYT9vKNY8uPPLR0=htxB9Unhw@mail.gmail.com>
Subject: Re: Question about bpf perfbuf/ringbuf: pinned in backend with overwriting
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Philo Lu <lulie@linux.alibaba.com>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, guwen@linux.alibaba.com, 
	"D. Wythe" <alibuda@linux.alibaba.com>, hengqi@linux.alibaba.com, 
	Nathan Slingerland <slinger@meta.com>, "rihams@meta.com" <rihams@meta.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:37=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 19 Dec 2023 14:23:59 +0800
> Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> > Curious whether it is possible to reuse ftrace's trace buffer instead
> > (or it's underlying ring buffer implementation at
> > kernel/trace/ring_buffer.c). AFAICT it satisfies both requirements that
> > Philo stated: (1) no need for user process as the buffer is accessible
> > through tracefs, and (2) has an overwrite mode.
>
> Yes, the ftrace ring-buffer was in fact designed for the above use case.
>
> >
> > Further more, a natural feature request that would come after
> > overwriting support would be snapshotting, and that has already been
> > covered in ftrace.
>
> Yes, it has that too.
>
> >
> > Note: technically BPF program could already write to ftrace's trace
> > buffer with the bpf_trace_vprintk() helper, but that goes through strin=
g
> > formatting and only allows writing into to the global buffer.
>
> When eBPF was first being developed, Alexei told me he tried the ftrace
> ring buffer, and he said the filtering was too slow. That's because it
> would always write into the ring buffer and then try to discard it after
> the fact, which required a few cmpxchg to synchronize. He decided that th=
e
> perf ring buffer was a better fit for this.

Well. A lot of things have changed since then :)
It might be a good idea to teach bpf to interface with ftrace ring buffers.

