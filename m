Return-Path: <bpf+bounces-47456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85489F98C7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E9E7A4BAC
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379322D4E9;
	Fri, 20 Dec 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udq2h3wk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675E21D5A8;
	Fri, 20 Dec 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715855; cv=none; b=aC7u1gMxjqoOpcvlIZkatxLxEC6HPT/fvc/WNlrTVAJffVOt/P2JGPZYNLEfZDtuyDILp+ibxDVDtaePHkz2+Owu/41zbfx9aaILCZEd23CpMkMWb/k14McP/LPJAXgitKoIbZc43SCNkhqmZ3VIxZjG1aPZ4UugVCUMwvTT49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715855; c=relaxed/simple;
	bh=NN200lURRhYPC7rka0Y2j208pGeTsvwM7b8QG/SfXv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKz1ozvLJxiAayLiV0S4waORqdzdTFm9cdeglv3EWMvW3oiozrDWbJR5aW9ciPOHtEq454oLyOtYWCyBjRyS0zYZFLdU/wYUNOU1oIbuxCLXIf/yNlKs/1Dx3tP/1KTGo833ApAzTwLMol5A9OR+lSWwXXLNOmXHm8YUV6Ofrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udq2h3wk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361a50e337so15311395e9.0;
        Fri, 20 Dec 2024 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715852; x=1735320652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wcd5p2PmG3eB0cJIFL5HcNsDmqfOUuQDLffSjTK4uDA=;
        b=Udq2h3wk+9gGhkcTuZOlMyBrHgejdpLur/zH2/mB2q8sc9LEO+QLsvDvCBc+FcX3cE
         raiGgbEBcFHKnJbb+Ts1f6RWZWoPmHw85CBJSEBJaewpWQ7PQXAaUm+2HigsA7CSjt7R
         ZtQ5xRYStqe+joBVfKiqwhIlfK8Xepgc/1JYg/bPPHbp8KpK0m5d3STOBk+9CeyxglKj
         EOjKNsVTalyt44mUMadyh8HtZ82CKw1KPh5K9TumyMIb+cHXohuR5umrTgRS8Ma0tzAn
         /AGbIzq2L+ZEJKLNyYtJCOH2UbrEhH6mVgl5hWjZcBz0Fqi68h7iatvicViW+RCfFS1E
         PkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715852; x=1735320652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wcd5p2PmG3eB0cJIFL5HcNsDmqfOUuQDLffSjTK4uDA=;
        b=HhYzAD/61hpNrDFq/6wYWVWlAuxQhPovINM0OLIjIh/NlzoqIwj8a3XsQGjwUBM2RY
         BSVOwN3yu2Y5bPXo3LWpYnW5TRq0+3i/Axjh0GEwVDFHpJzr27lSJYMxiJGNQn6aqVZS
         xHCw/8deuv0yH4XZwqALYx8wFCxOsKgDFiYAcMynlBZZdt+fFNnFWFyrqIn+22K2Pkqy
         G2Lo6BYwPVqMa1OLWGvOVt/MJs4Ymh2+A8kbIuGccXN8RiUFAt0zRcvf4l4sbM9EMkER
         aaOIBq3nMzd3awZwKZOcpzYlBf80kv9uurAnOLCKSS+LAbXgaG9fy44GJtppLKPpoEHU
         zauQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4u9FY9XjUdwLvwOmaO4xfU09g/SqSzyoaOsqAP5HajMuG6th55mXyM6fLQMEI3FxX9ns=@vger.kernel.org, AJvYcCV6Vmo30UvNVM5GgAdfP4wc8u4N8dtKBeo3uNw3m4loTcTm1znXFzLuKOvgXqATN+7ZwBp3FbiQcRxb2wa+@vger.kernel.org, AJvYcCVLadigAqzYCifdH1KA8bcUtDiQoLkawAHs+pBqF/LpYXqZ17WRiSJeoIY1xJ4piiYYXXKm9sKBh4meZZn2/BnMbKVg@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUFL3xuU/WmaiC5M8/Ztu9OjypaY1BS3uje7hzpOcAC1ujgLu
	OHyzqfPMrsrptT/qwEVqmO7NpR3rbv+LxT2/ATsxvgnmNdn8QUFa4e4/IQPIieQTYwbH4sl4IHL
	EWgS6P+VG0QE0tUJMSfkvo7DPgtM=
X-Gm-Gg: ASbGncs9JONe8UJrHhcOQ2tJUS0a8cE8uv9hhXy9cGmdDgoAExUaaVSnhwn8AnexQrH
	T8z79CxwFDsGmVsHDr5wGug8HMIYNtCplwVTv+g==
X-Google-Smtp-Source: AGHT+IE3bXiqh8lJ6aIUKGCc2P1PBYU+ot7zRyuzP1NngmZMYUqHu/qNwE67Wj0vEOkFRiYDXBwD7l5jaZbDCt6TzyA=
X-Received: by 2002:a05:6000:1446:b0:385:fae4:424e with SMTP id
 ffacd0b85a97d-38a22408624mr3278945f8f.52.1734715851945; Fri, 20 Dec 2024
 09:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67486b09.050a0220.253251.0084.GAE@google.com> <CAADnVQKdRWA1zG6X4XNwOWtKiUHN-SRREYN_DCNU59LsK8S5LA@mail.gmail.com>
 <mb61p8qsymf3i.fsf@kernel.org> <CAADnVQ+_TUjJ6Ytn96QqtHnBB--muefbbOoAsRw4z=40Pf1+tA@mail.gmail.com>
In-Reply-To: <CAADnVQ+_TUjJ6Ytn96QqtHnBB--muefbbOoAsRw4z=40Pf1+tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Dec 2024 09:30:40 -0800
Message-ID: <CAADnVQL=_6n+yJfs+TPxtBEVcpYV6nPEgjfRmacCdm7qLCSj0g@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
To: Puranjay Mohan <puranjay@kernel.org>
Cc: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 2, 2024 at 4:42=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> > > Puranjay, Andrii and All,
> > >
> > > looks like if (irqs_disabled()) is not enough.
> > > Should we change it to preemptible() ?
> > >
> > > It will likely make it async all the time,
> > > but in this it's an ok trade off?
> > >
> >
> > Yes, as BPF programs can run in all kinds of contexts.
> >
> > We should replace 'if (irqs_disabled())' with 'if (!preemptible())'
> >
> > because the definition is:
> >
> > #define preemptible()   (preempt_count() =3D=3D 0 && !irqs_disabled())
> >
> > and we need if ((preempt_count() !=3D 0) || irqs_disabled()), in both
> > these cases we want to make it async.
> >
> > I will try to test the fix as Syzbot has now found a reproducer.
>
> Puranjay,
>
> Any progress on a patch ?

ping.

