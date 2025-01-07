Return-Path: <bpf+bounces-48097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A8A040E3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD554163AC3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B001E47C4;
	Tue,  7 Jan 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2/cxs1a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F642F46;
	Tue,  7 Jan 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256792; cv=none; b=Jig4YVx/z1KKE8CFzigjLIxisxsQ5NbKEOti26Agm0U9JfRxSjDizCmzJNB8dC6QIT6hd0sgJ7nwzHNqjlVFTe2U4banKa97xuoERzNzuGHRTBzPG7IPM4sS9VWMnHC/NtRmoSaRwaY4qPTsuw8B6fbnNjakXDNQEVHDgqgT67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256792; c=relaxed/simple;
	bh=cEOvOeZgOwI9IHEuTVHo259ImHll+IftSCMw0RN+O6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZeff3ZS498daKDsIMdXMASPmhFbmGzcn0YD7Iz8R/ClMFth2tj5FaMy28c0v0HBk4IwaHPOC11L4AnMZFQdxivUdc8qupin+T+yxg1hiF3LGOnTeAUChz49fZ+WwBX4SsOPa12zoqnWWjflqvO8uUXUUUNe56TRvkSh1tj8704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2/cxs1a; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d900c27af7so124169366d6.2;
        Tue, 07 Jan 2025 05:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736256789; x=1736861589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVjhG1AqDVe/Trqz0iURMV78HXARi0uXeKVsIiC5Zu8=;
        b=k2/cxs1aDvd9PAcDuYjbnOx/GNu5oFkhCB8yNz731pp/9rgDOOVVs+OPJ14SDvgXTj
         bK9okHw0rq7dk9t2lRwptJdEAeEQnTks/eIVeIujNDX9PZgodxbZutSEJLMMZ3wmbxVf
         IJSwnpUImCgAsTZz8clkc1ZVzQ0PkBexhq6axGQ0ohpZtXHbm/+Fg+0zJ2xMyNRtj7Q8
         m3uWAfaN6ljxL4P5VfzZh6iieBNOoXdPnyFs2TxPDXBBJpDFlpYqBNNwd5+eezeLYJ29
         oOO091Vql6upDscw37JHr1KTVXTtr/mKavoU3CSMQ8tM6wlXAOGc4kmEu6YM+v6H9gUm
         93PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736256789; x=1736861589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVjhG1AqDVe/Trqz0iURMV78HXARi0uXeKVsIiC5Zu8=;
        b=RrZIJPp1vmvtigPRC1DuqX7aCvTfpUuzYFeLcC8butDGhUBLU0o8+GC8F1WYwKR5iR
         vo01E7Ahko8O3v4kT/ErWhFjCKX4CuI5OZAkRF6njVsHVQUbw68nIBTtzzL8Uxpra+8X
         WQKnvJDehrHeUiN5V4WDK5H9dX2unTmoxrlNEX01P5KqMVnWvz19cQBUfCEKMKZoW7na
         fs11pnLRhSTbIB68oW8euyAU9ZZCWH6jB6mjLRfcfZCZvmqQBvY8cH25n1+hq4YEwuiM
         ajtXJwz8zHWbQ/651rytb4vxNlFkR5d5qb6dKKht65kRw1QoSYk0qqP0jXwN3K9O1eds
         ClKA==
X-Forwarded-Encrypted: i=1; AJvYcCUJmTUNp1XLxJ2Pp6B8rATUZgjFd8cSmBhxe1JD+0zH6pZgETgoRrX5T/P7Uspm1qekMeocca8e@vger.kernel.org, AJvYcCVlwEqyx6lMB9w4fKWq72ecik5AnxQQ9ZGZm3LD9kGzIQDdvKBNWwM0cZMykDD2Qh0+jpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4Gv0FCLIfmJuyBythK5fNhdEowP5nPXTQzqUjzUML4SIi90y
	IXdwzu+xq3pKNJiudxcm4mTcm0nJtdqwMACAjBF7hMoA/uN4PaLKBU35VycKkZhoTX/kco5/tQZ
	RMnnQwjMQ72/ndPFABfP6Qg0d2AXkgJF+fe/D4w==
X-Gm-Gg: ASbGncvRyzIgswz+AfjNLyp/s1epEKmDVtFZasJnwaUkWjv1MIWo26xBiwEIVLPp33R
	oMX1MY8BdHH+xom8H3wYCEIb22dVpimyChv8yoQ==
X-Google-Smtp-Source: AGHT+IGfPXeVoDos3MwpsGdODIYWiEtLQIflXoLBciu5AyhN7YK8UUe1Vb4OwlmHk5A7tcVZJcMxegMdiYd74fnRyAg=
X-Received: by 2002:a05:6214:4281:b0:6dc:d101:2bb2 with SMTP id
 6a1803df08f44-6dd230e17efmr1090839806d6.0.1736256789069; Tue, 07 Jan 2025
 05:33:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105124403.991-1-laoar.shao@gmail.com> <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
 <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com> <Z30bGYeyGQL2UpnX@krava>
In-Reply-To: <Z30bGYeyGQL2UpnX@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Jan 2025 21:32:32 +0800
X-Gm-Features: AbW1kvasYlkQGY7H6MH4qxh1WisX94rlEMW--ZPZkAAA8mTwLE164x7EMFZkjaE
Message-ID: <CALOAHbAW2f-yupU6aedS=-YKGC58DEqcTx6W8nZH86UZQJYexA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic tracepoint
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Eric Dumazet <edumazet@google.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 8:16=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jan 06, 2025 at 10:32:15AM +0800, Yafang Shao wrote:
> > On Mon, Jan 6, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Jan 5, 2025 at 4:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > Dynamic tracepoints can be created using debugfs. For example:
> > > >
> > > >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/=
kprobe_events
> > > >
> > > > This command creates a new tracepoint under debugfs:
> > > >
> > > >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> > > >   enable  filter  format  hist  id  trigger
> > > >
> > > > Although this dynamic tracepoint appears as a tracepoint, it is int=
ernally
> > > > implemented as a kprobe. However, it must be attached as a tracepoi=
nt to
> > > > function correctly in certain contexts.
> > >
> > > Nack.
> > > There are multiple mechanisms to create kprobe/tp via text interfaces=
.
> > > We're not going to mix them with the programmatic libbpf api.
> >
> > It appears that bpftrace still lacks support for adding a kprobe/tp
> > and then attaching to it directly. Is that correct?
> > What do you think about introducing this mechanism into bpftrace? With
> > such a feature, we could easily attach to inlined kernel functions
> > using bpftrace.
>
> so with the 'echo .. > kprobe_events' you create kprobe which will be
> exported through tracefs together with other tracepoints and bpftrace
> sees it as another tracepoint.. but it's a kprobe :-\

exactly.

>
> how about we add support for kprobe section like SEC("kprobe/SUBSYSTEM/PR=
OBE"),
> so in your case above it'd be SEC("kprobe/kprobes/myprobe")

This is similar to what I'm currently proposing:

  SEC("dynamic_tp/kprobes/my_dynamic_tp")

My proposal requires only a 3-line change. In contrast, if we
implement it as you suggested, it may require significantly more code
changes. I prefer to introduce a new section, such as
SEC("dynamic_tracepoint/"), SEC("kprobe_tracepoint/"), or something
similar, for this special type of kprobe. However, if you believe
SEC("kprobe/SUBSYSTEM/PROBE") is a better approach, I=E2=80=99m happy to
implement it that way.

>
> then attach_kprobe would parse that out and use new new probe_attach_mode
> for bpf_program__attach_kprobe_opts to attach it correctly

Yes, that would be a great enhancement for tracing inlined kernel functions=
.

--
Regards
Yafang

