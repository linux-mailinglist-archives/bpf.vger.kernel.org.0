Return-Path: <bpf+bounces-61388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E57AE6C06
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35983B5A4A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E002E174E;
	Tue, 24 Jun 2025 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhyYdfPS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403726CE13
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781003; cv=none; b=AxbDjQEzeH3rVkhzUwmKYQPSjf4k7zMpJkl8dUm834brqdRyOWCIn8Wi7cz6mTFKI4bRUt4hzfYz8qU5wpBuLU6FgL3+VxCklEV5V7q5sbDYEcK3Js8VtHnZOpmGEG1KyZdLwcVUebhIjnxxn6h/AI/syQhhheuZnQLuE6xbTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781003; c=relaxed/simple;
	bh=hXawdhAkJZeyB33uC67SYm13VaHSv8kWcLT+M6yr+fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrGoe3+c3s+EDSvvh322zF73g8Wv5vejdjUqmuNHsIhEGezdC1oEbmgTT0UG8mkq73f7jW6SfUMQGh0pBSYmzakDJxKTQ7PxxNChmOiNSpF+My/N+5ap6WlIXJgg/ulAVUm+XO97tAELkK0zOkoixwqq1+VyfH6ox8k5UaRG5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhyYdfPS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453608ed113so49102075e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780998; x=1751385798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXawdhAkJZeyB33uC67SYm13VaHSv8kWcLT+M6yr+fw=;
        b=DhyYdfPSqXrH0BDnJ0cqaf3hFgxFEWVqy7XrK79cRn2TCLkGj5P5V4DVKfNzHyXOj8
         X8CkDnDSarQzGUvgtA9jxpr8MYtTKHyDwO+371S2Jf2PU6uFFY8JUQG7C7j+r6x8opVZ
         lwb8nh1xvjNswxLkfrklWXFXJ8ZQxkRHRLU3eWVbGr+29jMujFG+blZiMVu1spwXN70s
         TEO15A3C7mEAbXyg6qjoJyGZZBMw7UVtRRaNc8QvGYiWZskD033bj18UKNc/lNnRg2Qz
         Askfn+MGivbqYq2zl33xv0zkWjOa+XPGJ51SG9sRrKH+Tb1ptyIv6Pk7cOuimGdcgrnc
         Kx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780998; x=1751385798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXawdhAkJZeyB33uC67SYm13VaHSv8kWcLT+M6yr+fw=;
        b=cIuEeG7wa0RMhUkEFOQNR5kYPuLe4LYBhS2mzN8cKXE+DNEj817hlziFIPG8H4ybcR
         cQzJz7OwcPOWw/yeYIOku3oUhNdpgGmyzIdN2hWDSnHYS/8/6t92YeJmIsv1mxzFi9Fd
         KQwHduxUqGmCtNw67lmsPRozAghVJFOSD1PasII86FizvvJx6VC5cCOfiPgE3h2+QLCE
         J9JsGEyQ7XgAOcb2+BPYqstMZGn0AQnfNnQ+dAgx8OVyCYdTX3e7S9bLW3owAqHvHPCk
         76LObImcGNURe/9PgPk4IhclQk08l+QF1vo/Uajue8Zg54vbmoaP2Bfak5Zmaw++WYdm
         ojlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5P+s4GNsqK0mcz2QvBVxsDGJAV5xaQyhCoO2vYt9D32yidLvWRZIupAbDAjcS/uPfkkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCERxqEgvly+fRjr8aMx1eliOp4ELkfmMsV8gTJNBQ42uXqPb
	du11vwF4x6DqIw447lCRu0C2PCEb0SsyjvefEakeU1vx0SGqjaIVSlzn1BUl31WGYcri8d0Xlsq
	hm/0yR0guXaMafnExTjtj/QFsrhXFuaY=
X-Gm-Gg: ASbGnctaXL1ax3wf+hQ7mGbPK9fq3mWFP9CZZr+Vwam+5eqCY4nZd4A0NEKN8E2F1A9
	ZhUiUe/YQBDKFcagFC+6ekLywxP+6mrGsrBpHcju+PUbvKrN1A+SAwfZvywlK1+yutBF/c0mlqI
	yxs7faC7r8WZVrcuL+ayzdYQoxa2GO8kntPr1owm96Sz6tFPf2l6TOeUo9o5k=
X-Google-Smtp-Source: AGHT+IGS3GWfrNgOjZScVXyve5dSUedvOMD8hoZC1XiqYBmxqRvBaquy1cDi0Y2/7Za2MWGdTNUVonO7Uy2OHfJ1eqc=
X-Received: by 2002:a05:6000:2d11:b0:3a4:e1e1:7779 with SMTP id
 ffacd0b85a97d-3a6d130707cmr8782917f8f.32.1750780997697; Tue, 24 Jun 2025
 09:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-3-memxor@gmail.com>
 <aFqTiLd4HmjPS5eP@krava> <CAP01T77EXWDdRYtrJHUR6qLBgLqe4oT0A0N74CGBBRVGYPuKnQ@mail.gmail.com>
 <aFqpdkLaRsjTw7Ik@krava>
In-Reply-To: <aFqpdkLaRsjTw7Ik@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Jun 2025 09:03:06 -0700
X-Gm-Features: Ac12FXy2Q1BNwV6AkD2QnnBRs7HoRCnausP3YjrvVbOoL3WJ6oA3FOgCQ0L9yrU
Message-ID: <CAADnVQJ+rCkrykbs-_qT9VTpp0in20U8K-eYEfXEyus88PihwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/12] bpf: Introduce BPF standard streams
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jun 24, 2025 at 02:15:09PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 24 Jun 2025 at 14:01, Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Jun 23, 2025 at 08:12:42PM -0700, Kumar Kartikeya Dwivedi wro=
te:
> > > > Add support for a stream API to the kernel and expose related kfunc=
s to
> > > > BPF programs. Two streams are exposed, BPF_STDOUT and BPF_STDERR. T=
hese
> > > > can be used for printing messages that can be consumed from user sp=
ace,
> > > > thus it's similar in spirit to existing trace_pipe interface.
> > > >
> > > > The kernel will use the BPF_STDERR stream to notify the program of =
any
> > > > errors encountered at runtime. BPF programs themselves may use both
> > > > streams for writing debug messages. BPF library-like code may use
> > > > BPF_STDERR to print warnings or errors on misuse at runtime.
> > >
> > > just curious, IIUC we can't mix the output of the streams when we dum=
p
> > > them, right? I wonder it'd be handy to be able to get combined output
> > > and see messages from bpf programs sorted out with messages from kern=
el
> > >
> >
> > Yeah, this is a good point.
> > Right now, no, in the sense that sequentiality is definitely broken
> > across the two streams.
> > We can force print a timestamp for every message and do the sorting
> > from bpftool side, or it can just be piped to sort after dumping both
> > stdout and stderr.
> > Output will look like trace_pipe with some fixed format before the
> > actual message.
> > WDYT? Others are also welcome to chime in.
>
> yes, keeping the kernel simple (just adding timestamp) and sorting
> it in bpftool seems good to me

I don't see the point in all that complication.
If bpf prog wants to separate its printk vs kernel printks
it should use a different stream.
Right now there is only stdout and stderr.
Eventually we will allow for more.

