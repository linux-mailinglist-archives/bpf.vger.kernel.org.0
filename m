Return-Path: <bpf+bounces-45652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9A9D9EB3
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B87F166E45
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758B1DF73C;
	Tue, 26 Nov 2024 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCG7IZec"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680C2500D5;
	Tue, 26 Nov 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655762; cv=none; b=krdBXjnaduZuxjQagJtxat6/2mDymmGg7wO2ObkK/wzazdc9isRU8dKD4BZQQSwrXn+PUi1C/IrympilywHgVDfb7maMMYVLYB/Y960AIVMYb12xy3c5FrA5WrbqbyG469A37VP9xTlPN8eQ9JMcn9tk3CaT1EDoGw3bqzccDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655762; c=relaxed/simple;
	bh=8zBIAsY7KhKfrx093oiz+bgPbdi4AqBYllyRBnwEjcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kvv+9vjC9UoH2/QKjCPngt2RyzBIfSt3ayZGaiVL1BLL+xViZaTz+a44eUReC2JRAlNfOqTF8NSrmT7x9KzOVY6b/VR2dgkYO3WZAnj5zzn2hwRbdp52HMSfeIoL56gQNGUfq0sCFoHDqgZTdEy6IKVpxgMyRsdYZZFrNMBm3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCG7IZec; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso4182879a12.3;
        Tue, 26 Nov 2024 13:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732655761; x=1733260561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCYkoe4/s2sGIo+e9CICa6BBY2Gz1FRZ8QT5IIMcEsI=;
        b=eCG7IZecg05HBJfx3sRuOm3tBFo6h0eY1QA8jDM/sFEPTgYaCgcXXf7LEgUsHwFpZH
         uzI6KJF9ZeSKJPD7mumqhRw/yvt6sRMoFTVeKpahPbyEeZWMfGJOww+aUFtzqR7QZ+B/
         zQ3JPKPvsRPsvI92z6vZxOKE8MCcoOnn3oHMYZeWXLfye4yJNUaCUoB6y1xpvvF09sbN
         l5cvoRsW0MWaGG07RVmVhXW8oEsEVT0GPnQd6YyGIm+XG9vx6YDqEQBOTsjx7xAtlBIN
         KDDUVD6KLEV/puFwDqfXuS5++odaCNAi4sKydqxbq3ZLH634m4OLfA/maDEnwqVx/zo/
         ZRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732655761; x=1733260561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCYkoe4/s2sGIo+e9CICa6BBY2Gz1FRZ8QT5IIMcEsI=;
        b=Z2gblATwqERe5JvwKZ7FsIIoirXUYj1MAmqzMA/IVqfg7joUxphCW/J35IriVVmkDe
         T11cqHBx5pRW8ND4Sbr4MZAKstWbAqDwPbbpPyPNukzpfLpgDnIX8qyW0168sOGM74oJ
         wOHhq/qN8OWrILPHlrU+8fSwxrB61eE/u5mYbBrrGQ7cz28GxNLgS47/r02JlFcOlXB6
         HXJC5SwVlDu+vTGLyob1NMwm/TSDhquw1g9Q+e08l8sGqWteMZ3iY6xfzf326PZ8YmkL
         1xUKN/3tbMtLI1pJvqlwghwbbn5l0eQ0cliWKLWem9LUWegCE9WiQ/TpagVA2Tkdew6o
         +PZg==
X-Forwarded-Encrypted: i=1; AJvYcCULE4KZXbq5QWMbNidn9UvyaIqtcRJQmUZPbeS4nzKrIQ4paKBdnJ5BIbX51jx0J9JpcGm7dHE7@vger.kernel.org, AJvYcCUqiyL9Q2FxKR85SsN0V1uAcjuS51q4HApvQEInmRw3yKAiFN47vA6JS49cqVbNpyAbQNQ=@vger.kernel.org, AJvYcCVv8z5RLjtFL4SvwbqnrKpcSB4HNfiCESjE26sLXKc1QhrPUF+8VpY+XYMTrkVIXt21nJOE2zwRGFfpkgVaVuEXXJkG@vger.kernel.org, AJvYcCWjg2MoPL5PkMhbS48QRbFSv1GxHjy+Q/M3TfoSxl6Ulx7Er+Y6uhjTwuGB3J1QyvwylWhaI1m1QS5b4P86@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdscQ+Lb9fiA4lcvunebeZ4LjLKuvzKhBEM0rgjF3zAt+nJI6
	YWt4vWi5sk/jjnzYxX/E+fw5nKpFgbLt2gePMQ70uUDlgU6C6FXq9eLcDr68bpZV6x6U523fnNW
	EzR5w1z9RPdSAGYRNMJAp5O5bc+Q=
X-Gm-Gg: ASbGncv9n322ak12PFV+PyncB/rNhCcZ8wzZA/w/sGDBDtKZxcdrFy6tghRq7uRRV0v
	8HECVIbWO7r/5UDcDWDGkLHYjo9q7AXY72MVPorMAOl2U/J8=
X-Google-Smtp-Source: AGHT+IFZpSUfgo8UkY5MOU8q7SMXyP0VRD2sfkfUurm23P4frAw83y0qvmOzmOSggFzJcXEkU6unnV9i2uU1VYlwjco=
X-Received: by 2002:a17:90b:4b8d:b0:2ea:94a1:f63f with SMTP id
 98e67ed59e1d1-2ee097e5f5cmr1129433a91.33.1732655760621; Tue, 26 Nov 2024
 13:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
 <20241123202744.GB20633@noisy.programming.kicks-ass.net> <20241123180000.5e219f2e@gandalf.local.home>
 <CAADnVQLBhV_sSuH+BKu66ZsxTcsvw7RSLnjRGLwQX3TFSjs-Gg@mail.gmail.com>
 <20241124223045.4e47e8b7@rorschach.local.home> <20241124224441.5614c15a@rorschach.local.home>
 <5489FB30-8B09-4F74-9C2B-FF25F4654A3F@u.nus.edu> <20241125094426.GO39245@noisy.programming.kicks-ass.net>
In-Reply-To: <20241125094426.GO39245@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 13:15:48 -0800
Message-ID: <CAEf4BzYHeh_=iHOYL88pXXdHGZuAmQNM0jM+9iPUou+7+YLjjQ@mail.gmail.com>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ruan Bonan <bonan.ruan@u.nus.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"will@kernel.org" <will@kernel.org>, "longman@redhat.com" <longman@redhat.com>, 
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
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

On Mon, Nov 25, 2024 at 1:44=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 05:24:05AM +0000, Ruan Bonan wrote:
>
> > From the discussion, it appears that the root cause might involve
> > specific printk or BPF operations in the given context. To clarify and
> > possibly avoid similar issues in the future, are there guidelines or
> > best practices for writing BPF programs/hooks that interact with
> > tracepoints, especially those related to scheduler events, to prevent
> > such deadlocks?
>
> The general guideline and recommendation for all tracepoints is to be
> wait-free. Typically all tracer code should be.
>
> Now, BPF (users) (ab)uses tracepoints to do all sorts and takes certain
> liberties with them, but it is very much at the discretion of the BPF
> user.

We do assume that tracepoints are just like kprobes and can run in
NMI. And in this case BPF is just a vehicle to trigger a
promised-to-be-wait-free strncpy_from_user_nofault(). That's as far as
BPF involvement goes, we should stop discussing BPF in this context,
it's misleading.

As Alexei mentioned, this is the problem with printk code, not in BPF.
I'll just copy-paste the relevant parts of stack trace to make this
clear:

       console_trylock_spinning kernel/printk/printk.c:1990 [inline]
       vprintk_emit+0x414/0xb90 kernel/printk/printk.c:2406
       _printk+0x7a/0xa0 kernel/printk/printk.c:2432
       fail_dump lib/fault-inject.c:46 [inline]
       should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
       strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]

>
> Slightly relaxed guideline would perhaps be to consider the context of
> the tracepoint, notably one of: NMI, IRQ, SoftIRQ or Task context -- and
> to not exceed the bounds of the given context.
>
> More specifically, when the tracepoint is inside critical sections of
> any sort (as is the case here) then it very much is on the BPF user to
> not cause inversions.
>
> At this point there really is no substitute for knowing what you're
> doing. Knowledge is key.
>
> In short; tracepoints should be wait-free, if you know what you're doing
> you can perhaps get away with a little more.

From BPF perspective tracepoints are wait-free and we don't allow any
sleepable code to be called (until sleepable tracepoints are properly
supported, which is a separate "blessed" case of tracepoints).

