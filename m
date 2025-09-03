Return-Path: <bpf+bounces-67353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C8B42D3C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE811C22DB8
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230A302CD9;
	Wed,  3 Sep 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRxOlfiH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06372BDC1D;
	Wed,  3 Sep 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941178; cv=none; b=IBBkfhFYTUX9UMN1QBYv4/dkpXSbDC6BbIMIwTFtXGcPF1TqE+25oPtfeA8NkYVZblNvO6gaJ8VbcMNNNw77eMtGWXDLwNqk0Q159GOHDgHGm7gAQj0faJR5IM18MydHTV05wRBl32JjPCzC7vo7uB4jz1PaFITD6mF9+3jbsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941178; c=relaxed/simple;
	bh=7Nluk1zrxvjw8V2VyZPB8fuv98T1UivfeQbKQNgU1ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foMB6r5cbl6F9NUxKcVjjQlxO02jhbA/caVaHjZ1Z4L/M4880xlLmTfdN8lllSC1dq/HDlnLhbAkxkA8O51ENWJ53hJ3k8pdCvuxsqJgMpacEHwc+LCfTDanuiyvzJfYRV8Wyk4ckSOZaRcmUVzSe6jYslQe+xqcXqrPcvKodjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRxOlfiH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2489acda3bbso3886145ad.1;
        Wed, 03 Sep 2025 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756941173; x=1757545973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It0e2JrH3ZFKYa+3DcELj8Z5oxYFVPHQ8lvRREkQ5Mw=;
        b=JRxOlfiHYB+O1iyfN5G5pJ1mATmW9HBpyWrOP3i+ziTkg60Fl1trWb8F+jmRbvbcBT
         jjqfySzsJcUL+37nXYqOVkn6++/j1gIpatbWoIzu/n6DLXjck/WFRku1JaDpn7f9cPIm
         SKa8ZwdJWpEOSMDrHieBXMOWpKsR3lnjg7pO122i/aAaaCuHDYjyO7nspM8A2b1FJ+z4
         QIuhUmKuRPLtOBti4CsqKbeogeARbbCLiTxT9DgFpnC+V/8lZ3xy6KLYCv4qigQr9KfT
         9RvHvub2cnvQcFb2LT9mMMBy6joT54CJif5U06dCiXEmhgU8WV/LMix1PtCk/+97PutA
         TJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941173; x=1757545973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It0e2JrH3ZFKYa+3DcELj8Z5oxYFVPHQ8lvRREkQ5Mw=;
        b=Of77DUCsEtRCU0aqfBXihfGNgvmBYerJC2L5KT98TYyBr8Ug27E4kgzT37XGyizj6R
         FlsEKobQFtIaSDPBAFWQkBq466IAma/THZG31NcCtT3ResR+mRUSYIOOOpRYGEZp3Nle
         1LYX8yNS0X4UhLCnBT7QGdI0jscc5GVZllJKkJJB5k8Yak34Qv74zsf6eiyTfJgFbGa5
         5cewWT9TU8IFM0LzujKjb8Z5uJ2s+3GZuUKyrLqdUR6JZiOilbTwLfAKiHGMv/uTbswu
         RXWaKsifgYKN3M65LGasdk7MHDzoWjj2AxN7HNzxILKN/xhKGCOtnq76a1UNc9Kob4pS
         /Mdw==
X-Forwarded-Encrypted: i=1; AJvYcCWKnah3MVUcUYDPG6SgoZulYcHevVt4GaL7Nz1LlXnWNmpwWFON/lJfAPYBSFR8+H2Gp/r9azl00RsWlw+i@vger.kernel.org, AJvYcCXeFj8SDu8HLajrLE/UOGV85HynyLxFZTykjhFzVN1P7QVJZjAfjwudaCySmwKQD3+Xn5M=@vger.kernel.org, AJvYcCXpp8tdQRfO/zvJwnqm+17g4oGIho0hTPcCccT8C480gNCapaPzSzcjFOm0WIDX99iRezhb6uPTP9RdIBwC3RAbZlss@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6H8/TAnqqQXMZl3dXPZM42D85HEpdYpv1o19vUoUW15Kq8Dgz
	z2YOhrtR3T/UfGDPYLevXS7JpbSw6gX3xaOBx4BEd3U7PCGa/4cpZTVUXTtlPcch3m26m0Yg/O+
	/gayj7kLSojtAqthJ8PKvPDX9fcnUtrg=
X-Gm-Gg: ASbGncvDdQ7XQB1rW9HMewCAZYtryOfQ8NE+m1hw+2lD2v54HFlZWgMvrYoncFkRXPb
	jrkObRzLG0RjbPn0gg3vOHwyi/0tjk/Gady9A7xecm+Q2M/dnrb1lcLswWoVEN0K816ypu4sZUQ
	hCS4J/u7GCKN19LiH80icnjmlc78dJz1+C93is4CYErtLPNZd510AY6BS1EWEnw7hEPb8keojwH
	5/art5vz7MRtEYSvEkR4NM=
X-Google-Smtp-Source: AGHT+IHg6YdmCGOkFZDj+ngDvMe3gELnPnahcq0/S2zwKwB7gDpYCReU64s3GLtiHUKRxPc7YPlJCg8iUuX6U3MVxTQ=
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-24944b15b8cmr209445105ad.50.1756941173012; Wed, 03 Sep 2025
 16:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava> <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 16:12:37 -0700
X-Gm-Features: Ac12FXxfFG0VC2mv82k-Eyv4Nse4_KEUPqQBdCPeUV8pfy3v3M8bUeEFsmZ36pI
Message-ID: <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
>
> > > > +SYSCALL_DEFINE0(uprobe)
> > > > +{
> > > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > > +       struct uprobe_syscall_args args;
> > > > +       unsigned long ip, sp;
> > > > +       int err;
> > > > +
> > > > +       /* Allow execution only from uprobe trampolines. */
> > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > +               goto sigill;
> > >
> > > Hey Jiri,
> > >
> > > So I've been thinking what's the simplest and most reliable way to
> > > feature-detect support for this sys_uprobe (e.g., for libbpf to know
> > > whether we should attach at nop5 vs nop1), and clearly that would be
> > > to try to call uprobe() syscall not from trampoline, and expect some
> > > error code.
> > >
> > > How bad would it be to change this part to return some unique-enough
> > > error code (-ENXIO, -EDOM, whatever).
> > >
> > > Is there any reason not to do this? Security-wise it will be just fin=
e, right?
> >
> > good question.. maybe :) the sys_uprobe sigill error path followed the
> > uprobe logic when things go bad, seem like good idea to be strict
> >
> > I understand it'd make the detection code simpler, but it could just
> > just fork and check for sigill, right?
>
> Can't you simply uprobe your own nop5 and read back the text to see what
> it turns into?

Sure, but none of that is neither fast, nor cheap, nor that simple...
(and requires elevated permissions just to detect)

Forking is also resource-intensive. (think from libbpf's perspective,
it's not cool for library to fork some application just to check such
a seemingly simple thing as whether to

The question is why all that? That SIGILL when !in_uprobe_trampoline()
is just paranoid. I understand killing an application if it tries to
screw up "protocol" in all the subsequent checks. But here it's
equally secure to just fail that syscall with normal error, instead of
punishing by death.

