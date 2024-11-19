Return-Path: <bpf+bounces-45145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEAA9D2022
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 07:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F8EB20C3E
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B41547E9;
	Tue, 19 Nov 2024 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoKq42x7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E61527B4;
	Tue, 19 Nov 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996798; cv=none; b=hmKzGCEF79ndysnlvRFA4ydLNE41yF96W/yQxs4DORN2jTnPajbuE0H43+N+rC6w6VcWTzG7x7fHWvk8HCg5UDdiJpeGtvp3DX5RdyQDDpWRKNSHYkHha646eopR8bRV662v1D5LKKgOobsB/YdTimOYA+g8qKf4EEtzHbGfZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996798; c=relaxed/simple;
	bh=8M/lEnIq/jKzK/KW/cJtvu6eWiKsSVTv67NZcriLZGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1caK5ERM6O06mWd0IrdpDhPvsS5VJvV6DdLEQko3aFyFBvpRrcrB+X6QaES9c3ePb+m76WvZG6G/JAHhyYHEfweFBqkUEf4y2yytBNgeOk5mH34PjftWP35EabYhJAvp8ggih2mftJS48KfnZnEo1B+0oM02e04x57CnxGmYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoKq42x7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e9e377aeadso3070556a91.1;
        Mon, 18 Nov 2024 22:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731996796; x=1732601596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M/lEnIq/jKzK/KW/cJtvu6eWiKsSVTv67NZcriLZGU=;
        b=EoKq42x7ssOeyayisRPzSxEYFf/NFZIH9hrYWUwppEHP9J5ByCzdyPV7NmjNC5jayE
         JILjhXSkLAZhqpardL0YkDKRJpInWP2a65DounnOP/+R42ieXXEDqJCBbUxZJpQ9EfpX
         +G1sRShHCD84el2BvdkfaO4qseEJ0jM9zUP8gla81Ylfl35FHOr+kWjS7tYiYsIGRWX0
         1+782df8U6oXkifZeaw+B8n5WANN3sxVSuV0c+JzFxUBCxtSbzIjjmWctime3K/yHYEy
         Z6xx5VL842UC8elTbRQ8fx+S+bV6tSEb//WpjqL6skqaTOAxoRCZc5C662C0pqi71qTA
         4m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731996796; x=1732601596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8M/lEnIq/jKzK/KW/cJtvu6eWiKsSVTv67NZcriLZGU=;
        b=dRgmsIq//ycwJP6X4IJFTIMCI3DToG1f7+aU2yFm4CR3ic/4zJg6PWO12wrdsRA3TA
         zuTVaFG2vge2x6D7JGhXpxjPreIckLrVF9a62g022Rl8FkzOp/nBp7yafeQeN5NjESSn
         KaJq/s/iOjseIqkLHA93vB79s/ZyXWj2uTha+uNxnaviQDCj6MFbkOQ1m3Ac9qqwR6NL
         aiSBOsAIUERrqOcCZb9TyyBXH+LOJRSRPqO3JlPsSdGy3IK8lESZlUN8nYJdU0GUi0hY
         l+q82dMAbpQjnPEJg4Uq6eJfS25MCNrnx53A5nID8ZlusfBIyRjlWARc8y0ycLHSg9t8
         Ebkg==
X-Forwarded-Encrypted: i=1; AJvYcCWV0u1Hf0AuXBY6stq8ObTA26/658kN5Dvds6PA5X3BUV3wRfyYV1+zApLcFDwu4oN2EnocCde5OWa3RvxD@vger.kernel.org, AJvYcCXCFKXKYJfDgTqeUmh8WkmeidRTkQlSbOptVl7pog8wXmBNopq/v/IrzcY6fPFmRevU8bg=@vger.kernel.org, AJvYcCXLCgpZdZZRdJgve9FCzjffIKcT2blOixefsO6xCLmANL/KB7DFmc95mqfkGEhL2nxteHdewy00Xw8Yxe2ga4I9KHNy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Fzr1cwj9EqbR9yGeScIonDneDTKsajXC8RQGtWjQohVIP4Ks
	TsAWRViftfXsGu5iJtMMb/X+fyOSL7d/0PsMbrCu2Hi0hd1hTZji1coNSTZxQT0Ulsu38Az344X
	XBwValRSEnZpqotl9e4VYZtiWmjk=
X-Google-Smtp-Source: AGHT+IHkjWub5fzfQ1YUHv7B9CkKDJ2ytxkic4ZvhJNruosAltuxflg+vAYVQt9lu58Pj5U/zyvkWRWlTb0lQKUEzMA=
X-Received: by 2002:a17:90b:380a:b0:2ea:5fed:4a37 with SMTP id
 98e67ed59e1d1-2ea5fed4bd9mr8011565a91.21.1731996796320; Mon, 18 Nov 2024
 22:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241117114946.GD27667@noisy.programming.kicks-ass.net>
 <ZzsRfhGSYXVK0mst@J2N7QTR9R3>
In-Reply-To: <ZzsRfhGSYXVK0mst@J2N7QTR9R3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Nov 2024 22:13:04 -0800
Message-ID: <CAEf4BzbXYrZLF+WGBvkSmKDCvVLuos-Ywx1xKqksdaYKySB-OQ@mail.gmail.com>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on x86_64
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 2:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Sun, Nov 17, 2024 at 12:49:46PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 05, 2024 at 02:33:54PM +0100, Jiri Olsa wrote:
> > > hi,
> > > this patchset adds support to optimize usdt probes on top of 5-byte
> > > nop instruction.
> > >
> > > The generic approach (optimize all uprobes) is hard due to emulating
> > > possible multiple original instructions and its related issues. The
> > > usdt case, which stores 5-byte nop seems much easier, so starting
> > > with that.
> > >
> > > The basic idea is to replace breakpoint exception with syscall which
> > > is faster on x86_64. For more details please see changelog of patch 7=
.
> >
> > So this is really about the fact that syscalls are faster than traps on
> > x86_64? Is there something similar on ARM64, or are they roughly the
> > same speed there?
>
> From the hardware side I would expect those to be the same speed.
>
> From the software side, there might be a difference, but in theory we
> should be able to make the non-syscall case faster because we don't have
> syscall tracing there.
>
> > That is, I don't think this scheme will work for the various RISC
> > architectures, given their very limited immediate range turns a typical
> > call into a multi-instruction trainwreck real quick.
> >
> > Now, that isn't a problem if their exceptions and syscalls are of equal
> > speed.
>
> Yep, on arm64 we definitely can't patch in branches reliably; using BRK
> (as we do today) is the only reliable option, and it *shouldn't* be
> slower than a syscall.
>
> Looking around, we have a different latent issue with uprobes on arm64
> in that only certain instructions can be modified while being
> concurrently executed (in addition to the atomictiy of updating the

What does this mean for the application in practical terms? Will it
crash? Or will there be some corruption? Just curious how this can
manifest.

> bytes in memory), and for everything else we need to stop-the-world. We
> handle that for kprobes but it looks like we don't have any
> infrastructure to handle that for uprobes.
>
> Mark.

