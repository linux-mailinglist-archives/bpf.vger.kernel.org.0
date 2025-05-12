Return-Path: <bpf+bounces-58067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C78AB4742
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CA9175B95
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E6F29A304;
	Mon, 12 May 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpVjwt1P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11761C84BA;
	Mon, 12 May 2025 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747088966; cv=none; b=kNNeEWbI2Vmq5eSJmQr4TBY5RZoLx3XDCddNtp/rR94oMEfapLkR10oX8kOeMGj2SQ4DtYi1nu0T58uEMeB+kTKSkhFKbCUL5iWU1ry3fVxgeiVMy2JPQRSzAEdXmsx8P84dT3YpIWhqeG4C/B1+t2BEgT1xafaENj2FqI1DTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747088966; c=relaxed/simple;
	bh=l2xeO2rkOB0/oqLU3KotW45xj64QhuSGVliez2qkXUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZSDbbtErJaV+Toc+8v1IE4DdSNzilMLkXhzgkGxwIGbHzmHPUJm+F/6Sk3JSufjq05npszvZL7DAUB9e6pbYGKlbWTmCwYaelTqeEkoLP/etWcHqmGogVGiLxcrbjgrr77gD8nNLi1ZexX/U3/FeBnMRnOBiuHdwxOt4FWnTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpVjwt1P; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30a9718de94so4769786a91.0;
        Mon, 12 May 2025 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747088964; x=1747693764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYwVPWq3J6N1zilnpGZGRbtewnVJ2UNrxWn55cB7mUU=;
        b=MpVjwt1PoAlTrwiNt1NVkuosAeT0MZj00PK6a5CFl0idFsjU3LqJzo0lnIPiPR0vLD
         Zmzq9WAlmc0x3/FSjlSC6Zur0HtoFnXvLwgiGvhHeBv4EU9KzoMWxXf7/CXRsKT3vf/G
         do77v62PWbZhhWrUkXaFbuSewjUhSbmDXIzWauL160jPQn7Wb3/y17xlL40/Qf4NlVm8
         Zc5u58bRolLh12zdc807Izw6b/3DIy/2oT7CHmV1famCrNOcTxTEDe2eF5I4ZiIYWjuN
         VuD0mkzD0Fmyh40ZWAum8Wh5bRrkP0+m9ZOJPLHDji9o1rDSqep+IOMGCcN/sdAhsCsH
         bVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747088964; x=1747693764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYwVPWq3J6N1zilnpGZGRbtewnVJ2UNrxWn55cB7mUU=;
        b=bc3XeJ81MRnLCKJbIE4WU90gP1zkWfmQAyyB1y1yEV/2YVg89lXpQbTZlD0I9HZn6R
         5se21oihRXU1L/eWKVAK/Gz+YRczk79QujzVVU54bsga2PS/C7A0nuEj4jc1eMC8qGx1
         juW4ZF7P7QBAcLHsVzXe9+Phc9rSG90g/Woi7+hDwNFtvc/Qh06Gvoza8EFs9hHokIw1
         TKLEIUwqBDLZHoKgZdaAOUkWVTpkjqEQj7KMDmVYc6hBILkKexCaVub4cINbxVyxjPz4
         GPYeFHaVD+5Ox7amfyHJqfGD+yflQkqfHNj+aJJBmSwNAPKxGNSFYynEzQ8hug/du4FJ
         4prA==
X-Forwarded-Encrypted: i=1; AJvYcCUCfN36SQd4VvLSYmvwawjba+G4v3SxDMgZxl65BD4PxBlWEexl6qD5+u0dzGQtI9/KKhdqw8eo@vger.kernel.org, AJvYcCUZTqMiFaX/1p4cvRNV2MQ1WfnBw4UUP/Sokww2ap47aprcWbWUlXonYf6g42jC9TWAOtw=@vger.kernel.org, AJvYcCXRWBpJg2luUIqP7x9oJ8N1atLLFiklpi2MRc2fO/SKioYyXqXhOxa3bi2QtYHLLPFxgVHpXa335ijuMweHbo8XzpCv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwpy4sjtqBSxNA/WeVQEYKuadA2BKMaOEIAV8NYDTar1mTODj+
	QjmnSbLPjUHbK9IJMGqRW1wPxz9Rj2gFgO41T1G4Vqif1bq7allVACW4u0kwMWPgWjhqNELzN2H
	G3Lau9fXE8gnZU2ed4L1KwOnmSr4=
X-Gm-Gg: ASbGncs6VrzzmI1+BWSvyxItI3To+cW89OA7Gkp54g4yVqx44Q9SGsilKoCLn08DPdj
	PDUS1zWy/NNXj+6ZLNqvSd8UCzb01Z6BkiXowSleKou6ljBn+btUVhPmDVtzs71MQ/3KbaubwE4
	nt4s6BK36nibKNTe+V61duSk6/D2QH3uC5ToBYe+6nHYmQEsQ3
X-Google-Smtp-Source: AGHT+IG0iT25hedkTym++cqk89LT1uIJwoUyiWgWvV+ksUhWI84bYUpkdd5XowLKkuyq/vfitLDh2fIfw22A4/9cIJE=
X-Received: by 2002:a17:90b:3908:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-30c3cefe5cfmr23091186a91.13.1747088963951; Mon, 12 May 2025
 15:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510163730.092fad5b@gandalf.local.home>
In-Reply-To: <20250510163730.092fad5b@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 15:29:11 -0700
X-Gm-Features: AX0GCFvUISD-tt7hcAgaaLgJZ-tB02v_XDVWKkiY8z1iJhBlwg18KbzxqQKGMbA
Message-ID: <CAEf4BzammxSa48ZBxQgGQjOBbdVniJcrQ+-52-76TqMYUHx8cg@mail.gmail.com>
Subject: Re: [PATCH v4] tracepoint: Have tracepoints created with
 DECLARE_TRACE() have _tp suffix
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	netdev <netdev@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@gmail.com>, Breno Leitao <leitao@debian.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 1:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Most tracepoints in the kernel are created with TRACE_EVENT(). The
> TRACE_EVENT() macro (and DECLARE_EVENT_CLASS() and DEFINE_EVENT() where i=
n
> reality, TRACE_EVENT() is just a helper macro that calls those other two
> macros), will create not only a tracepoint (the function trace_<event>()
> used in the kernel), it also exposes the tracepoint to user space along
> with defining what fields will be saved by that tracepoint.
>
> There are a few places that tracepoints are created in the kernel that ar=
e
> not exposed to userspace via tracefs. They can only be accessed from code
> within the kernel. These tracepoints are created with DEFINE_TRACE()
>
> Most of these tracepoints end with "_tp". This is useful as when the
> developer sees that, they know that the tracepoint is for in-kernel only
> (meaning it can only be accessed inside the kernel, either directly by th=
e
> kernel or indirectly via modules and BPF programs) and is not exposed to
> user space.
>
> Instead of making this only a process to add "_tp", enforce it by making
> the DECLARE_TRACE() append the "_tp" suffix to the tracepoint. This
> requires adding DECLARE_TRACE_EVENT() macros for the TRACE_EVENT() macro
> to use that keeps the original name.
>
> Link: https://lore.kernel.org/all/20250418083351.20a60e64@gandalf.local.h=
ome/
>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v3: https://lore.kernel.org/20250510092342.77371990@gandalf=
.local.home
>
> - Added "_tp" suffix in bpf tests to:
>
>   tp_btf/bpf_testmod_test_raw_tp_null in raw_tp_null.c
>   tp_btf/bpf_testmod_test_raw_tp_null in raw_tp_null_fail.c
>   raw_tp.w/bpf_testmod_test_writable_bare in test_module_attach.c
>
>   Hopefully this passes the bpf verifier tests.
>

Yep, BPF CI is happy, changes look good. Thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Documentation/trace/tracepoints.rst           | 17 ++++++---
>  include/linux/tracepoint.h                    | 38 +++++++++++++------
>  include/trace/bpf_probe.h                     |  8 ++--
>  include/trace/define_trace.h                  | 17 ++++++++-
>  include/trace/events/sched.h                  | 30 +++++++--------
>  include/trace/events/tcp.h                    |  2 +-
>  .../testing/selftests/bpf/progs/raw_tp_null.c |  2 +-
>  .../selftests/bpf/progs/raw_tp_null_fail.c    |  2 +-
>  .../selftests/bpf/progs/test_module_attach.c  |  4 +-
>  .../bpf/progs/test_tp_btf_nullable.c          |  4 +-
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  8 ++--
>  11 files changed, 83 insertions(+), 49 deletions(-)
>

[...]

