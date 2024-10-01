Return-Path: <bpf+bounces-40717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86C98C796
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 23:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEB81F2292F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5A51CDA35;
	Tue,  1 Oct 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmq5vhTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B003322E
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818126; cv=none; b=kcGCDCQtdkthU0p7PYyAUJe87221l3YQFf1bQ8VrjOXv0eOgvqSluoRZ6SvbbAsNdRcFGfuf9u40doq4KpbBnqydYBLs/GXpuAr9KZ+ldTcDM68QWx0hOxXm+Ld8YEOueZ1d8TiiNGSUiU6ffbGRy7m/lTEfpRWZD8sZOv2zatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818126; c=relaxed/simple;
	bh=9klHjln5b728Y8KNW3Cof8qua6n5Lkp9hlz4Jdgf9ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw87O5qfsGdQxNrTCErJYd4eQFOWC9QoJKGRIE7HMVS2wIHyWAFVqiDXk+CQ1px2xN5mUQzGYdCj37K3TShhf2SB7kslKuQw9iCisHt4V5tW6nzZoSUWP+K7L5kqy+4yTndWxNrJi6Z4UZClhDXQaUETtDwBq7mJ8pK7w/yAOWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kmq5vhTu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so1316905e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727818123; x=1728422923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9klHjln5b728Y8KNW3Cof8qua6n5Lkp9hlz4Jdgf9ks=;
        b=Kmq5vhTuZAnHjAYlTYa8+2wK+qqSs/G0Ct2sL8QBU9DDeL1UcFaHjheOZu2lrePq8e
         N6FubKw+36SV75CzcgDjkhl5Hx07ch9sUBiaZU4HfKxLDyTAtgTTh8X7y6l3eX34OJoL
         dzIf9PZqBUaslKVjBHU7n7vHjnTQHlf8g89pSGSuaxUKSsvl2Om2Hy3a4r5pdW7XxfB/
         mz88orY60x9MeukwsOkGGt2Ko2F5c9p16jHovAyUEsbQv0h2OYDaQEb87+mx/Cllyec5
         GrVqaS7hdcO1X/ML4ktx3WXj2uauBMJiTeY/C3D2W9XYBEYKduFcYUciZsMZQHWJIIy5
         X27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727818123; x=1728422923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9klHjln5b728Y8KNW3Cof8qua6n5Lkp9hlz4Jdgf9ks=;
        b=FLeWT6iBII0wQa2dj4pBJHOgXCqIVPdhZAqd27B0QG/O7c+wWnQdQDI/M3RHYom4YK
         8LzTO5tLmP9ZxUywMO3tBl0GD96ZD2oco+eETGjZtlxGbtQiiFUPLPQwGOFj5iurB45U
         kDSzjb5zUCAKz8iHI+OgXsY43NzXPA6zJpkeLubiqCcb557MbgFkgzoGy7gIbkSfzFsL
         JfZIFD9DJ6w53/cCQtU+zkb+dMo0eK7y2XqeGexWbD+Km0HtczUR5OTiTe+fK+BFSWkS
         4bsbSRXHClhs7E3eGxWyogwj0M8RU6ZRC9vY/0DfWCRD3kCQ50ZubfvGi9xIrBUtdx2q
         lnnA==
X-Forwarded-Encrypted: i=1; AJvYcCUEh5LBKx8XtCY0D7knck/GzxN28JIuqJfroGmXcM810kz2DBLGrVlOYjkTL6D0UdCcdDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/AV4qXk7C0SZe6mET6pUiBICg1LlaVHofruAXeGWVvx6RugW
	8CstjXrcUdU9eRRexqXjE1ciKF6mviJSDJp97GX5jtZhkmaQgkuCY8eQntPJxLXlcQ8MKTFR2w8
	2V8SKBl7tbk02ReCBrnG4TCbTK6nkLJnl
X-Google-Smtp-Source: AGHT+IHGGyGCFkitzSkMsj1uDPBQbHk/kIfMGxHbEMcW1pFCHUyHRRGxWs74ASblV04vEU/bL8ijuUSiD1Mxtf4qnXc=
X-Received: by 2002:a05:600c:1c81:b0:426:6fb1:6b64 with SMTP id
 5b1f17b1804b1-42f7131daa4mr31361535e9.7.1727818122509; Tue, 01 Oct 2024
 14:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com> <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
In-Reply-To: <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 14:28:31 -0700
Message-ID: <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:51=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Tue, 1 Oct 2024 at 21:53, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Another idea...
> >
>
> Thanks for explaining why push/pop is still necessary. I agree then it
> seems it cannot be avoided.
>
> > Currently the prologue looks like:
> > push rbp
> > mov rbp, rsp
> > sub rsp, stack_depth
> >
> > how about in the main prog we keep the first two insns,
> > but then set rsp with a single insn to point to the top
> > of our private stack that should have enough room
> > for stack_of_main_prog + stacks_of_all_subprogs + extra 8k for kfuncs/h=
elpers.
> >
> > The prologue of all subprogs will stay as-is with above 3 insns.
> > The epilogue is the same in main prog and subprogs: leave + ret.
> >
> > Such stack will look like a typical split stack used in compilers.
> >
> > The obvious advantage is we don't need to touch r9, do push/pop,
> > and stack unwind will work just fine.
> > In the past we discussed something like this, but
> > then we did all 3 insns in the private stack
> > and it was problematic due to IRQs.
> > In this approach the main prog will use up to 512 bytes of
> > kernel stack, but everything that it calls will be in the private stack=
,
> > and since it doesn't migrate there is no per-cpu memory reuse issue.
> >
>
> I think this is much better, but I'm wondering how the hierarchical
> scheduling case will occur in reality.
>
> Will it be the main prog invoking a kfunc, that in turn invokes
> another prog, which can do the same thing again?

I believe that's the plan.

> If so, the lack of using a private stack for main prog would be a
> problem, right? Because effectively if we don't call into subprogs we
> don't use the private stack at all, and all invocations share the same
> kernel stack, which brings us back to the current state.

Not quite. With the above proposal anything that the main prog
calls (kfuncs, helpers, subprogs) will be using private stack
prepared by that main prog.
Then another 'struct bpf_prog' called from kfunc will use
the stack prepared by the main prog and that 2nd main prog
will prepare another priv stack for everything that 2nd main prog calls.
So we can allow arbitrary depth.
The only problem if the same 'struct bpf_prog' is called
recursively (since it will use the same priv stack),
but that issue we avoid with per prog recursion counter.
So I think this proposal should work for all prog types
except those where bpf_prog_check_recur() returns false.

I think we can make it work with a special
__bpf_prog_enter_limited_recur()
that does this_cpu_inc_return(*(prog->active) and allows
limited recursion (up to 4 ?) and then sets %rsp on entry
to a different slot in preallocated private stack
based on prog->active value.

> Instead can we set rbp to point to the top of the private stack in the
> main prog itself?

we cannot change both %rsp and %rbp atomically,
so setting rsp and then adjusting rbp will break stack unwind.
After 'mov %rsp, priv_stack_addr' we can do 2nd pair of
push rbp
mov rbp, rsp
sub rsp, stack_size
so that even the main prog will use the priv stack, but
I'm not sure how unwinder will deal with that.
So I would let the main prog use the kernel stack.

