Return-Path: <bpf+bounces-78410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BDD0C70A
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7083C300E4F5
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA98345753;
	Fri,  9 Jan 2026 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTWgrUn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBBF268690
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997130; cv=none; b=kr4phNZg3we2DaDqHuPM3pGwFFRTq5+ycKZ4yS5sI646U5NnBAlurjmmXTpz0uMUwfbc0kvAcWKZvvl1YlnMBrOd7E7mzNn4+B52hCFrygKADnHxi8AfqRQvSu8hFAZLjtfioaaCbhQShTLWUzB/MWvdCZ+/iLltw5+9zW2jIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997130; c=relaxed/simple;
	bh=7DP4SbOI7MwsA76pyuJXnkVQWxGL0svdQt3P6pE7d80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW5eDWGH+CPvbLOLOJ0+1uTxjGNGW4bG07oQdTapflx2mT4ID0TdBTFASu5ZPoaVpiPYPv+wDcUslSabERJTJt5SnOh4EzCntNpl4tCgd1oUvjGi3ZvzJ5Dx79YNTWfBLMZYnACKTpHmuF5aZXWy9sDqqv57Czg+M+WmiLzXbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTWgrUn6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so4072915f8f.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997128; x=1768601928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItpKy8a2tRkPvLh65km1qhs/wsP1zsrKdWCpxLRhfMM=;
        b=mTWgrUn6smMIcsuwtJDCOqXxQYmRUJjzoCptza0aB9Go866hf25mfD+cx6QboMkD+v
         iVbKqqkJeP4nt8GYezTitpg0Rig0EN6HEGW8OGuu7/mz0Lcrp3rUzctUOIERiaBSRUYC
         Je/n7oNVRtB4cOzkDQAqtUxQA86Aw9ZkZmZafOsoN+F5xfBKpHpnHqOFAnKlv721Q3hY
         jm9yUTseoInScyLeCACJrrSR70G5S5qhXc1MwN8It2OFgkUoXezfdTxGAE9lt98Q4Mpj
         Ljcmf9dqGefL4oxikW3vGDuCfUHcIBF4IiUiCJwXZ7kZvH+g0IdnT3f8+05KUkjoB69o
         orwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997128; x=1768601928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItpKy8a2tRkPvLh65km1qhs/wsP1zsrKdWCpxLRhfMM=;
        b=V5a8BodbSV//yvB3bjOLEppU3nQbNjBNIRTo2VzABH5ycoVeN2XNIKr2Qbxibc4XHh
         t0uv4b2ZtXj/ARlxnV4tsj8N61syzgVg2ixUtsmlG8sRQ1dFhR/ce0i0POGusBNEcO5M
         kVJpqsc/T5floNvU7F4Bo0FUnwHXRsd44LYxh+tHajP8Egfq25NkYe438szdrLlT1NU3
         +KbKGxmNqN+12T08naVgWtOc6xaJb0YgLfwCtW27C8nC+BlXhhnkS1+/KMKPVLhKtYiU
         iwSQRFdke5UPcVOivNO4qGwUnqciPb4h5XFdVzi+D3AUyFdwJZx+ev7fLB9MkM72U2pr
         cmxA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0YBSCkWcIadhRtICy004H9F4KHJY1nzeQYHy6GRXUUsOB/tq/HXtjugFbH/z4XquG5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkFnuGmwhtFkZ5GX104qXG4r/gtzXOmLY2X7NYJylMcnV2/7p
	OrcgHgnHJr9tZBvygmUN2RwFo21mG/vKF3j6pacmZ7tIEWBQVaKlyK4bXJ2mDoTdWGao6NuZtcO
	hk+VO0MeDVOJ1dHhsyTVSUvAOLbVXhAN+pQhH
X-Gm-Gg: AY/fxX6VeukTU8348WVw9JzBm8uDxYGuyf7DlUUSczsmsf0qu6NrXN86+baBkJzeQ95
	XBmbtRK6FVIYCn09lmmxiTNaqvd2HRHmx2IFTYo/+lvmzr/32X7i3lheDQHjve0RTaC4jfVzA9R
	/VgMOeDTTlDKUVYp0gJo/FdzN9oDnu7I4Anx3imn2l/J2wTbgSdMra/2ov0AKgW9/5FnRjUbmjY
	IibHXUiQmPpn4Jq+Me4Z75Jgr4mfZXq72gYXqbW0V/eG0bE5rZvdPIIgukIR4kVbW6s5msQmqCD
	F6QWZE+BW5HAheGCjxK1Mr/s+963
X-Google-Smtp-Source: AGHT+IFSRSeqxcL/83us6RFgsLWVachx5Pmr9hMA7/DUx04sE/951SBsyh1BOH6LVMtuWdNm7n+PADNSKu7yXoW1PrA=
X-Received: by 2002:a05:6000:607:b0:432:b956:663e with SMTP id
 ffacd0b85a97d-432c37d2eb4mr15663490f8f.52.1767997127603; Fri, 09 Jan 2026
 14:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com> <20260109170028.0068a14d@fedora>
In-Reply-To: <20260109170028.0068a14d@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 14:18:36 -0800
X-Gm-Features: AZwV_Qiapp_GS-K-9Img7XZ_91c4zgO8ElKLxz0cMYD6_cWQa82tpdZp3H3EH18
Message-ID: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 9 Jan 2026 13:54:34 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Fri, Jan 9, 2026 at 12:21=E2=80=AFPM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > >
> > >
> > > * preempt disable/enable pair:                                     1.=
1 ns
> > > * srcu-fast lock/unlock:                                           1.=
5 ns
> > >
> > > CONFIG_RCU_REF_SCALE_TEST=3Dy
> > > * migrate disable/enable pair:                                     3.=
0 ns
> >
> > .. and you're arguing that 3ns vs 1ns difference is so important
> > for your out-of-tree tracer that in-tree tracers need to do
> > some workarounds?! wtf
>
> This has nothing to do with out of tree tracers. The overhead of the
> 22ns is for any tracepoint in an in-tree module. That's because the
> rq->nr_pinned isn't exported for modules to use.

None of the driver's tracepoints are in the critical path.
You perfectly know that Mathieu argued about not slowing down lttng.

