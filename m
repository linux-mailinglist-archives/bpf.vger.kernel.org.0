Return-Path: <bpf+bounces-67403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A5B43758
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375D116A3C3
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133D2F747C;
	Thu,  4 Sep 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zkv3yXlH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1F2C21C5
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978813; cv=none; b=qFbLwE+tj4OMeSN+XFUFNZSeAaL+JhxFPtxvm/7Em1u3RxC5BPMZrCCx42QM6mAGvfeD7BSQRTdMPZ51cbiB1PBJDdjvRGYwuax/398pUSOZCyywVg0X93CoMShLFnmBAn478us/UuzOR69qRu9qnc0fLjxcVaNTmF1ZPlNA1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978813; c=relaxed/simple;
	bh=qiPAxPLNsHk954kmsc89B13q3EQZqdgliUn29iZKgKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKsjZsZCeAg/s5rr35bEUrBrUPHr+AlvuSAq0Ur6aole2RI9FTY3igEImEKYdRvsvlU/8XaO5eU+lbbLweuMaPMPKKF6vG4i3vNjagkYAoTPwa3PhjrTp3iE2RpMebHQomuk8lU1XAARjn1P/lHAnpSWpdUd1FrTDpe4zGJ40/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zkv3yXlH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so8879a12.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756978809; x=1757583609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeUX3NDgv06+NcrhTZI/Y6Tb5TiLTC+7+QLeL03CebI=;
        b=Zkv3yXlHEb1VWkFQ94GdbkhSi0ClB30t5y7VZCWt81p1cxHLl7zCXf4I32lPWd17jC
         CIiuwNWTlfieHUSzNCRSUz8Iv1HnKEw+/TBsBWYjsOsSV4Pgw6pMMrTMVGs1NYZBw6yP
         PrEnWFW266+1X965MG2OZ1HOElP5u49Ze8vFdSzvswwx4AR+A42daghpuh6RuX7EuC8Z
         lIHIDDaVuDoSCEjgNO7jfxVRR8uhn4qOzszxn8DagDGqUMeDg3d0vth4n6T28m0elOeb
         I04z9+ijxGsNgTQ5OWi1NK+EgyScKOZvsxP6ZwnIxwHZZ4dQ1YmtzJ7NtKDtpoluIk5O
         3u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978809; x=1757583609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeUX3NDgv06+NcrhTZI/Y6Tb5TiLTC+7+QLeL03CebI=;
        b=SqdDCAlTEXhelhSwW0q0ZtncC/ppLfrOjGW9VrkgJESiXhMVvJ52qbEbJa3bGod7q1
         g0IIvkl7WN7mZyVB7DkPLArOoe/KRYIUaTDIkPCBjnPONl2hcoUohbj6p5xIXcyAw+Zd
         jXIMP/MiTrhSl+UnSvpAzAI4U/aa1X9r887UJyFwOOGrC5/j/WKvoUx1hZ7F//n2N1b8
         uErAuIQg7JosvprznvXYeXEd+hcYgQY8sAXQtTTarITysmtsHOxsK2U+toD243jYT9gK
         OoRe6MOO3Ijv2mIbljwYRTR9Y/cc1t3tdQpcR0C81o/Ysi01n46WSLFor6xjEKqI94x0
         5ziQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmEQ067+dW7U6MR/urNwPcKBG9aSnitAl9O3Zk+hqTkHaPPAUGujC5JYPCzJoNn+xQbFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+cLJnFnxWFqqinppvIT27vCEMTdsNHM9uB1qOfA2DjOVCrXO
	FwIeK6ogPKUulKLDyhi/xWjh5dy06aFhKVOh4G67NBQ6h+z71XxorcN4ZiM/e2P+ojX8YSx3oP3
	FjN1eh+Cx0ml2Tmvam43l+mJg4UYnQjxuiaDrBk7k
X-Gm-Gg: ASbGncuWSeUrJuwJQu/5hjQ4NRs3/JY2GN4LyYsXZ3YBhFqTKUoOp9NujzoPX41qhHj
	pe4d5VX2eq0VDXAjZK0y5Vl7nBudfgn03Hgg5KAun7A6BlvruadoQLmmkOFaPmxynaMNp7Rlaqy
	8zqyPZ+02yAHyaVXeFbcJZzxZBzZdgQHla8SkTfwK4jx6rZc6BpcCdkNQqfVTCRp46fD2nKhlsC
	l0UgCs7I9lVr3wQxesbft2dOUqNJWMwJw9V4AGLCBA4IwI+ftOB
X-Google-Smtp-Source: AGHT+IFvQ09ItdiF9IKa8AKCXWGo8iaQfkCiShjvgTToiej2wu3bQUANg3c8mPRCdKj+Oeo97Rq34yk08Eqg6vMF2/s=
X-Received: by 2002:a05:6402:20d9:b0:61c:c08d:359d with SMTP id
 4fb4d7f45d1cf-61eeeb9e286mr58503a12.4.1756978809259; Thu, 04 Sep 2025
 02:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava> <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com> <aLlGHSgTR5T17dma@krava>
In-Reply-To: <aLlGHSgTR5T17dma@krava>
From: Jann Horn <jannh@google.com>
Date: Thu, 4 Sep 2025 11:39:33 +0200
X-Gm-Features: Ac12FXxsZGDsNFJ-OLi5fgKFV75dsXqfESDrRxdzmAMV29gomXnQnvt7nYNZ2rU
Message-ID: <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:56=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
> On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> > On Wed, Sep 3, 2025 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> > >
> > > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > > +{
> > > > > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > > > > +       struct uprobe_syscall_args args;
> > > > > > +       unsigned long ip, sp;
> > > > > > +       int err;
> > > > > > +
> > > > > > +       /* Allow execution only from uprobe trampolines. */
> > > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > > +               goto sigill;
> > > > >
> > > > > Hey Jiri,
> > > > >
> > > > > So I've been thinking what's the simplest and most reliable way t=
o
> > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to k=
now
> > > > > whether we should attach at nop5 vs nop1), and clearly that would=
 be
> > > > > to try to call uprobe() syscall not from trampoline, and expect s=
ome
> > > > > error code.
> > > > >
> > > > > How bad would it be to change this part to return some unique-eno=
ugh
> > > > > error code (-ENXIO, -EDOM, whatever).
> > > > >
> > > > > Is there any reason not to do this? Security-wise it will be just=
 fine, right?
> > > >
> > > > good question.. maybe :) the sys_uprobe sigill error path followed =
the
> > > > uprobe logic when things go bad, seem like good idea to be strict
> > > >
> > > > I understand it'd make the detection code simpler, but it could jus=
t
> > > > just fork and check for sigill, right?
> > >
> > > Can't you simply uprobe your own nop5 and read back the text to see w=
hat
> > > it turns into?
> >
> > Sure, but none of that is neither fast, nor cheap, nor that simple...
> > (and requires elevated permissions just to detect)
> >
> > Forking is also resource-intensive. (think from libbpf's perspective,
> > it's not cool for library to fork some application just to check such
> > a seemingly simple thing as whether to
> >
> > The question is why all that? That SIGILL when !in_uprobe_trampoline()
> > is just paranoid. I understand killing an application if it tries to
> > screw up "protocol" in all the subsequent checks. But here it's
> > equally secure to just fail that syscall with normal error, instead of
> > punishing by death.
>
> adding Jann to the loop, any thoughts on this ^^^ ?

If I understand correctly, the main reason for the SIGILL is that if
you hit an error in here when coming from an actual uprobe, and if the
syscall were to just return an error, then you'd end up not restoring
registers as expected which would probably end up crashing the process
in a pretty ugly way?

I guess as long as in_uprobe_trampoline() is reliable (which it should
be), it would be fine to return an error when in_uprobe_trampoline()
fails, though it would be nice to have a short comment describing that
calls from uprobe trampolines must never fail with an error.

