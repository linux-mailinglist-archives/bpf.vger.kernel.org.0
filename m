Return-Path: <bpf+bounces-39403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225C9728F4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562C71C23C89
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 05:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F5175D5F;
	Tue, 10 Sep 2024 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9YcBiKT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5138DD3
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946957; cv=none; b=MOSFEIb7x5lldaL3TCUQa94ZshwoK4T/E4GBIeyRL3oYbSYey1DpaNvvy5CT4fyD4LN1CCqOqAJloouqIHQpPVf32kwk3g6gNYxLdwQ4NwKj+Wkq8YGMHd6z+6/1ZtGRHVz4uRqgl9+/OOzAz65TQ3TRcMxuKRp7yaygGLLzSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946957; c=relaxed/simple;
	bh=p493nzW2LA6VcBP4kpMQ3M+pkWRRsq3jZeYrkqm6YXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvOrO16ZTzlwh0WegUksnIAP5qOWLqGUa9gA/3J8w2VJI3lD8MfbJbFuC+i03qD0uhg/ymuNGoKXWvRPEu87t7wOIAA9F23U2sShoHXX+mTZC7uEx6jAEnHpr4Pnu75NwQGETZnPBQUu9NYxMCx10uMZH8SlYlV38yEOxZ5sgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9YcBiKT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d88c0f8e79so4017031a91.3
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725946955; x=1726551755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iibVxBDW8GrgayE1LBxXGaU1yGzD/thkjE+vR/mcM8=;
        b=N9YcBiKT1CVag4IiGmYfCOYcrP1w0h+Gz0rmeTPfXHX2thhRFSAIClgM+GfTB5DWVu
         nSDgg/OzN0gkwyBDDIKuX+zy581dIrCdglEkvjUOao1pkLhUn0icbZ2qf2HF3tFTf7ul
         fiuDurC+UNFXbPgJqMqfbM07GlZWl5ekwZILtRfL9GqxAZEbMnrWLaXcF0G9p/zX6Zm7
         JDXHhKZjqoNyet14K43EovnWmtwBzYaoIHr1qUFieCbiP/OJ50LOmGGPELb6OVAptrNo
         CfOqsqI2GL8l+Zgr7f4o2DSEg1Z3wxR8O3+LJrCFflcotwzXdyxFZDanI02ueVt2oLYY
         ikNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946955; x=1726551755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iibVxBDW8GrgayE1LBxXGaU1yGzD/thkjE+vR/mcM8=;
        b=bk6LXC4Jr9b/Ao0rfo1B7sD8XQmmPy4Mmw99HaOKvtWrCxnZDwDITHoKbcGOc603KE
         wmal1Yxva9ZdlHjlv27cTH4D3aY54OzD+EqXRFYiPN1UmjPZoUr7IeUDxg5k+lW/inWV
         qQ5TieMpUkZhPK1dsjp+JYVdoUnPNEf06wOmhFLbJgcBQW4/r/FH+exZ2GIo5Uh0r3TH
         +uK+KU81nQ7TM51aLl5CRQ3df1kEwMcQe7yAyOZkmrtU6ce/zdgYIoo3QiWjp9JSYwir
         YCgV7cW9z7df9aofepW2/Jh67xc9kO9uYBRLjkLuHJIOaqRBOmxQyw259fzHpCDgRyH+
         6kzA==
X-Gm-Message-State: AOJu0YyCzcU0OfNO/eIgJrl6d2YwOBJzyuhYsL0tFbH/Rlbj0N76xk+w
	kFev3/29BG98Coc8aV06vqeCz6VPkXsqp0nZpcU2e9GVIPeKTFWgwmGD3y8d4vRWY5BN+rTmlEJ
	7zRA+Izcr5g1kemVweeVHuMdKRgmovg==
X-Google-Smtp-Source: AGHT+IHnfTD/QAmwPfWfT6vpVSmymB325UazqwTd3j91pD9CKt1QUoR49iTVB4YYnvjqng6wF+wMGeV3QMDbUP5W65Y=
X-Received: by 2002:a17:90a:e150:b0:2d4:bf3:428e with SMTP id
 98e67ed59e1d1-2dad50f3f3cmr18069803a91.37.1725946955222; Mon, 09 Sep 2024
 22:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910034306.3122378-1-yonghong.song@linux.dev> <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
In-Reply-To: <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 22:42:23 -0700
Message-ID: <CAEf4BzZC3FyP06p-H8JhQVJqOTRfjLSfNpHBZn3hN2WRfypDsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Salvatore Benedetto <salvabenedetto@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:34=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 8:43=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
> >
> > Salvatore Benedetto reported an issue that when doing syscall tracepoin=
t
> > tracing the kernel stack is empty. For example, using the following
> > command line
> >   bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel Stack=
\n"); print(kstack()); }'
> > the output will be
> > =3D=3D=3D
> >   Kernel Stack
> > =3D=3D=3D
> >
> > Further analysis shows that pt_regs used for bpf syscall tracepoint
> > tracing is from the one constructed during user->kernel transition.
> > The call stack looks like
> >   perf_syscall_enter+0x88/0x7c0
> >   trace_sys_enter+0x41/0x80
> >   syscall_trace_enter+0x100/0x160
> >   do_syscall_64+0x38/0xf0
> >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > The ip address stored in pt_regs is from user space hence no kernel
> > stack is printed.
> >
> > To fix the issue, we need to use kernel address from pt_regs.
> > In kernel repo, there are already a few cases like this. For example,
> > in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs_p=
tr)
> > instances are used to supply ip address or use ip address to construct
> > call stack.
> >
> > The patch follows the above example by using a fake pt_regs.
> > The pt_regs is stored in local stack since the syscall tracepoint
> > tracing is in process context and there are no possibility that
> > different concurrent syscall tracepoint tracing could mess up with each
> > other. This is similar to a perf_fetch_caller_regs() use case in
> > kernel/trace/trace_event_perf.c with function perf_ftrace_function_call=
()
> > where a local pt_regs is used.
> >
> > With this patch, for the above bpftrace script, I got the following out=
put
> > =3D=3D=3D
> >   Kernel Stack
> >
> >         syscall_trace_enter+407
> >         syscall_trace_enter+407
> >         do_syscall_64+74
> >         entry_SYSCALL_64_after_hwframe+75
> > =3D=3D=3D
> >
> > Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  kernel/trace/trace_syscalls.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> Note, we need to solve the same for perf_call_bpf_exit().
>
> pw-bot: cr
>

BTW, we lived with this bug for years, so I suggest basing your fix on
top of bpf-next/master, no bpf/master, which will give people a bit of
time to validate that the fix works as expected and doesn't produce
any undesirable side effects, before this makes it into the final
Linux release.

> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscall=
s.c
> > index 9c581d6da843..063f51952d49 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -559,12 +559,15 @@ static int perf_call_bpf_enter(struct trace_event=
_call *call, struct pt_regs *re
>
> let's also drop struct pt_regs * argument into
> perf_call_bpf_{enter,exit}(), they are not actually used anymore
>
> >                 int syscall_nr;
> >                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
> >         } __aligned(8) param;
> > +       struct pt_regs fake_regs;
> >         int i;
> >
> >         BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
> >
> >         /* bpf prog requires 'regs' to be the first member in the ctx (=
a.k.a. &param) */
> > -       *(struct pt_regs **)&param =3D regs;
> > +       memset(&fake_regs, 0, sizeof(fake_regs));
>
> sizeof(struct pt_regs) =3D=3D 168 on x86-64, and on arm64 it's a whopping
> 336 bytes, so these memset(0) calls are not free for sure.
>
> But we don't need to do this unnecessary work all the time.
>
> I initially was going to suggest to use get_bpf_raw_tp_regs() from
> kernel/trace/bpf_trace.c to get a temporary pt_regs that was already
> memset(0) and used to initialize these minimal "fake regs".
>
> But, it turns out we don't need to do even that. Note
> perf_trace_buf_alloc(), it has `struct pt_regs **` second argument,
> and if you pass a valid pointer there, it will return "fake regs"
> struct to be used. We already use that functionality in
> perf_trace_##call in include/trace/perf.h (i.e., non-syscall
> tracepoints), so this seems to be a perfect fit.
>
> > +       perf_fetch_caller_regs(&fake_regs);
> > +       *(struct pt_regs **)&param =3D &fake_regs;
> >         param.syscall_nr =3D rec->nr;
> >         for (i =3D 0; i < sys_data->nb_args; i++)
> >                 param.args[i] =3D rec->args[i];
> > --
> > 2.43.5
> >

