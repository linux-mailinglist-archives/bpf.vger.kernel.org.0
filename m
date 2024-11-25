Return-Path: <bpf+bounces-45558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CA9D79EC
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 03:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B05B21CCE
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 02:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0170125D6;
	Mon, 25 Nov 2024 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOWwi7VA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B782F2D;
	Mon, 25 Nov 2024 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500170; cv=none; b=GfUT2K0C2kVIZ8cco4xn8h41zzibrbPNYeUu9Kh3mwdsRxRkLIIuspIlKkZSpNxqXrOlMYa50Hl1kE2yD1kDaeNUcHFD52VqL/8GPiKGDeIO8oL78cc16NOEdO879q9kTSdBDYpsx/rXAvL1A3e8UEMajDym2XyFx2ImPdLFsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500170; c=relaxed/simple;
	bh=+g6AKYlq4/3r92iGWdjR4OKqfnss8ffR1uZCeCYj7n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzBX36gvuC9aDErAxTVIYwZ5Tzw7G9KpFULNkVXbELuZDIpKbpYowoY9B7ePqWHWbjVDpT9b2CtcTtKpsuUMhg3Rsreb6DBXgDSm6OARQRFlIcOADmXcgz0tee5fo336nqQLkYmHgE5zq0/1gBa9pEUB2RaHr7w+8jvqph/h1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOWwi7VA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3823eb7ba72so2688425f8f.0;
        Sun, 24 Nov 2024 18:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732500167; x=1733104967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb+IdiitV8/KAvhELpNdl6E0qRpMtW+ZNTipCC40/ao=;
        b=QOWwi7VAzwPRxWwXpzy+mzRgqNh0ObAzBx++LQNl+kv7lJwmi7hkRszedWSDPZhLxc
         TAwWt5fpusvIHVzZuZ4q8JgEi3eJzkZd7cbzP97cy9Pg/PB01iN1vRMIKZ6/6jNilFYP
         gTLjfp8UA1wya3k92g3DsuqHFTw8GC8uxkrmYs31bOZ3rVaTN3Y6XBnyGcRaR1grQX4d
         7c9afH826sv3kkPfp4FMIJP9eJhSHBmMNKHBIS9YHBYq4P/4DuxrUkBeBTOqBcmxGibU
         bzLDHOq/vf2W70gniDVpBN6iq1eA2rGGWjt1rKLyBnD+N3lbuvZIxHMJqt6KF9bRHMAM
         Hknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732500167; x=1733104967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb+IdiitV8/KAvhELpNdl6E0qRpMtW+ZNTipCC40/ao=;
        b=M3i013Luzk7/hM7EPGKbnXfywKPtdNmDC/k+ti5jz/ZBV9Jrdzrzk9FwpeEmkJ9bqx
         nm3eNuak/1FxbBcIDlxr1zYlC6raQcunUClWbT9P6cRdhUnaJVn1ypkuacLrSufwzJPg
         wnBDVoXZhW7hMU02h5+UT0jfHkPnyXA5EA3trQuZhz2C3LzUr7OSE4BhnZnbeGPIrmU7
         Ws1W9qqY6l2zfwx1rUUWWzPQsOmi3gSBcp1dPDXTZGNwVH1UjohNGGuuKQYmJX4YDFmy
         sAITQ3JKPGyVr0eL6BpyZHnN/p1N06na1/HHmZyz+/65JEEQzl/qMntSCPyxGvEyHkr9
         kWSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwcKdB9uv3tGQ8ovedg4kqpyHpnLhmYse4bbYg4T905SSe+lPZeIUf5di2rGXm2euOjFQ=@vger.kernel.org, AJvYcCVUCCRTZM4X6CGrd/a8fkw57OlefVbb+wj5w3df9+1Jp6CuokRPQvop9qgpPdgBSVerHC7sd9qV@vger.kernel.org, AJvYcCWUxLBh0r7luaUV1JNnJ7ptVM/Iepxrr1Bszgb0YGjXG3f/8KkR30XAUhf9RLj9x+F+bnDJq4ghf/vJouc6@vger.kernel.org, AJvYcCXv9gijeEuWvFnWphZADqZG2I0M3XOVbRLOIm1DkPWDxXu7hdbiut+BfG1zIjg4d34cb0ZuobimVaQuoMrnfYWuDWsM@vger.kernel.org
X-Gm-Message-State: AOJu0YwWr0ZCh0JeZ7AvF0pAB9G3xZaucNaGih29vQ0JbqQhKPTBY/PS
	48TYczewBxVLUajbkz1I3kD3IF60WclVKUl11+t/ur1KiR+Iwp906LjYHr+/9vrvX6sivXPVCIM
	9rpzTn3plGedPw1mcMJ1Eg30Ysac=
X-Gm-Gg: ASbGncsPAVZ+n+zanCjAsFigIx8Me1MyUc2pSjIk+KAHxM1rrGqX0Ro5NJmp5mBeJoB
	/HhZF3KWcsVge625WIM+fgyY/kEacvd38tDCctq572Gi2bS0=
X-Google-Smtp-Source: AGHT+IFdkN6cqlq6Cu+x0UV122VQlCTSEn68BAxP3I21x7Xme8bcvsGJmXnGmOFS/47AJhGbRh9d28C3wL3WT/mfpbc=
X-Received: by 2002:a05:6000:2d08:b0:382:50d9:bc7c with SMTP id
 ffacd0b85a97d-38260be6bfamr5453968f8f.58.1732500166830; Sun, 24 Nov 2024
 18:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
 <20241123202744.GB20633@noisy.programming.kicks-ass.net> <20241123180000.5e219f2e@gandalf.local.home>
In-Reply-To: <20241123180000.5e219f2e@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Nov 2024 18:02:35 -0800
Message-ID: <CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ruan Bonan <bonan.ruan@u.nus.edu>, 
	"mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, 
	"longman@redhat.com" <longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"mhiramat@kernel.org" <mhiramat@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Fu Yeqi <e1374359@u.nus.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 2:59=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sat, 23 Nov 2024 21:27:44 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Sat, Nov 23, 2024 at 03:39:45AM +0000, Ruan Bonan wrote:
> >
> > >  </TASK>
> > > FAULT_INJECTION: forcing a failure.
> > > name fail_usercopy, interval 1, probability 0, space 0, times 0
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > WARNING: possible circular locking dependency detected
> > > 6.12.0-rc7-00144-g66418447d27b #8 Not tainted
> > > ------------------------------------------------------
> > > syz-executor144/330 is trying to acquire lock:
> > > ffffffffbcd2da38 ((console_sem).lock){....}-{2:2}, at: down_trylock+0=
x20/0xa0 kernel/locking/semaphore.c:139
> > >
> > > but task is already holding lock:
> > > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nest=
ed kernel/sched/core.c:598 [inline]
> > > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kern=
el/sched/sched.h:1506 [inline]
> > > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/=
sched.h:1805 [inline]
> > > ffff888065cbd718 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x140/0x1e=
70 kernel/sched/core.c:6592
> > >
> > > which lock already depends on the new lock.
> > >
> > >        _printk+0x7a/0xa0 kernel/printk/printk.c:2432
> > >        fail_dump lib/fault-inject.c:46 [inline]
> > >        should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
> > >        strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
> > >        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
> > >        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [i=
nline]
> > >        ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inli=
ne]
> > >        bpf_probe_read_user_str+0x2a/0x70 kernel/trace/bpf_trace.c:221
> > >        bpf_prog_bc7c5c6b9645592f+0x3e/0x40
> > >        bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
> > >        __bpf_prog_run include/linux/filter.h:701 [inline]
> > >        bpf_prog_run include/linux/filter.h:708 [inline]
> > >        __bpf_trace_run kernel/trace/bpf_trace.c:2316 [inline]
> > >        bpf_trace_run4+0x30b/0x4d0 kernel/trace/bpf_trace.c:2359
> > >        __bpf_trace_sched_switch+0x1c6/0x2c0 include/trace/events/sche=
d.h:222
> > >        trace_sched_switch+0x12a/0x190 include/trace/events/sched.h:22=
2
> >
> > -EWONTFIX. Don't do stupid.
>
> Ack. BPF should not be causing deadlocks by doing code called from
> tracepoints.

I sense so much BPF love here that it diminishes the ability to read
stack traces :)
Above is one of many printk related splats that syzbot keeps finding.
This is not a new issue and it has nothing to do with bpf.

> Tracepoints have a special context similar to NMIs. If you add
> a hook into an NMI handler that causes a deadlock, it's a bug in the hook=
,
> not the NMI code. If you add code that causes a deadlock when attaching t=
o a
> tracepoint, it's a bug in the hook, not the tracepoint.

trace events call strncpy_from_user_nofault() just as well.
kernel/trace/trace_events_filter.c:830

