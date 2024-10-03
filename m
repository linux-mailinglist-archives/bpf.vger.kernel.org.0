Return-Path: <bpf+bounces-40826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1585698F0A9
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 15:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58627B245F1
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444C19D093;
	Thu,  3 Oct 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLLTLlWR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763419D081
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962838; cv=none; b=CCZyYbYmnzrxkwiLhWLG70a1hDEhNWy4E87MhBVy5IsgJosomy/eCHWVDZ1XMg0yauG4iTo+SkIP0fu9xB8Vw17qyQJMIf3KpTJeIPjv/t6OG5hIzFDO8JB6EIWzDe2BQNgpi2mGpkXBqtH7nfcVh4ouBZR82XG25MnJoEpQMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962838; c=relaxed/simple;
	bh=5rH4g9zTJAHRV73ouDpXSq2sqg6+LnXVGusjDVCrsfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7ytv0DZKZ7ftvRHcbrFvpBRH22zEc8UFiCeln8tYB3om1p7wOa/IpCr92ZdrY1cyTHtGLWaUSQZlnNobt3mRl6LayRRcI0ccktnBiAqA7v3PumBC3eRXNLZ0RdmDQRMCci25ePcpCDXe4jfYOYtHxcTWi7eurHUpWU3TuRlzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLLTLlWR; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c8844f0ccaso1247085a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727962835; x=1728567635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4VxuDb1qqCjePsg8EKNfOkFrM+7U3pns4gcJqSzYKw=;
        b=aLLTLlWR4sC7224YvPfqN1aqmGSK+S7iVHt6lq2QCsG2TxIZRHISoprhyeKI+dM4hJ
         jCczP226YfGtdzoCGaaHHPQ1ja3F6NfuDaUu8a9U+v+UJS25RvZIhmVCCAY/KphJM34f
         H+8YC+iUAsgaUAOP75IIEyIY2QjjLTVJ1tnGsxhvZY1fLKhj3tOH624faasqm29PnU2z
         jm5yjm2ZmVbzHcGMgfg7c122ef11zF5C1nuOQB9rUoG+cVeljqhtWzxqIOmaVQ9E2C9W
         /cC1fH1MP9R/N+VT49YiwxJ/0tEjZE+FjuUMxQsixl+dK5ZzEhC/G/biQcO2BTxC0Bs7
         1i9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962835; x=1728567635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4VxuDb1qqCjePsg8EKNfOkFrM+7U3pns4gcJqSzYKw=;
        b=GlFSkE4kGb7u8h3R85I8AZeeO8USvIrqRyd7++Yvyv/gI3awo59UQKYiKNpmZzgpdM
         /vK9eAaG9o9felPmcJ6YHa0bAY2R7+kBz9lw+KGXusl8v/BmAYpsDRw54YusAzgaNfPH
         k/nz637uXbVKUu4r7qWaH9d/NPFgpniO7YN8BbxLz3DFHnKmVgi6t0aIu0PUMwMQ5Ttd
         7FrrX244DEvb94dWM4H+wNig5+Duz2E4m65mAQB72USqw4y093wd+MNTZwI9SQHSTht6
         R35aE6PYwquTJaoV0Fxc6gCtqfLq1H84m7hWBqySqHSvJnFTrTl43IZ7WRpLu+OJEHAt
         /GOg==
X-Forwarded-Encrypted: i=1; AJvYcCWj5LZjgEvzNTu7TzeW6+pV4iHrcqtSj3monFJm/Dxk0DjhXEqR9602Iznq9Louog4ZXlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTFpEhgAWk7V0BIrt1aF5pEpW/TxbSWImDYRGlzt/kfni9AdF
	/RH3yddSMFsvod+hJPG+w0ISS4kPqX4ir/l9lycaY2MqvXZEFwMgbWgKiGmPSizsxaJsCnnTsDT
	6tI9rp7yATYVZdefEMlmvAu4IUxeelD3L
X-Google-Smtp-Source: AGHT+IFuic2lcn5MFt4rO6NhrMw2dOUlAqvQ42mRMD7jU+1s4JtG/7zDBoU5yPv4cqaekAxrX/O0cIPyhUiHpWQiYLc=
X-Received: by 2002:a05:6402:2687:b0:5c5:c5c0:74ec with SMTP id
 4fb4d7f45d1cf-5c8b1b72c57mr5733697a12.24.1727962834421; Thu, 03 Oct 2024
 06:40:34 -0700 (PDT)
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
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com> <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
In-Reply-To: <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 3 Oct 2024 15:39:57 +0200
Message-ID: <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 08:17, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
> On 10/1/24 6:26 PM, Alexei Starovoitov wrote:
> > On Tue, Oct 1, 2024 at 5:23=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> >> Makes sense, though will we have cases where hierarchical scheduling
> >> attaches the same prog at different points of the hierarchy?
> > I'm not sure anyone was asking for such a use case.
> >
> >> Then the
> >> limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).
> > Well, 4 was the number from TJ.
> >
> > Anyway the proposed pseudo code:
> >
> > __bpf_prog_enter_recur_limited()
> > {
> >    cnt =3D this_cpu_inc_return(*(prog->active));
> >    if (cnt > 4) {
> >       inc_miss
> >       return 0;
> >    }
> >   // pass cnt into bpf prog somehow, like %rdx ?
> >   // or re-read prog->active from prog
> > }
> >
> >
> > then in the prologue emit:
> >
> > push rbp
> > mov rbp, rsp
> > if %rdx =3D=3D 1
> >     // main prog is called for the first time
> >     mov rsp, pcpu_priv_stack_top
> > else
> >     // 2+nd time main prog is called or 1+ time subprog
> >    sub rsp, stack_size
> >    if rsp < pcpu_priv_stack_bottom
> >      goto exit  // stack is too small, exit
> > fi
>
> I have tried to implement this approach (not handling
> recursion yet) based on the above approach. It works
> okay with nested bpf subprogs like
>     main prog  // set rsp =3D pcpu_priv_stack_top
>       subprog1 // some stack
>         subprog2 // some stack
>
> The pcpu_priv_stack is allocated like
>    priv_stack_ptr =3D __alloc_percpu_gfp(1024 * 16, 8, GFP_KERNEL);
>
> But whenever the prog called an external function,
> e.g. a helper in this case, I will get a double fault.
> An example could be
>     main prog  // set rsp =3D pcpu_priv_stack_top
>       subprog1 // some stack
>         subprog2 // some stack
>       call bpf_seq_printf
> (I modified bpf_iter_ipv6_route.c bpf prog for the above
> purpose.)
> I added some printk statements from the beginning of bpf_seq_printf and
> nothing printed out either and of course traps still happens.
>
> I tried another example without subprog and the mainprog calls
> a helper and the same double traps happens below too.
>
> The error log looks like
>
> [   54.024955] traps: PANIC: double fault, error_code: 0x0
> [   54.024969] Oops: double fault: 0000 [#1] PREEMPT SMP KASAN PTI
> [   54.024977] CPU: 3 UID: 0 PID: 1946 Comm: test_progs Tainted: G       =
    OE      6.11.0-10577-gf25c172fd840-dirty #968
> [   54.024982] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [   54.024983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   54.024986] RIP: 0010:error_entry+0x1e/0x140
> [   54.024996] Code: ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 24 0=
8 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 <=
41> 57 56 31 f6 31 d1
> [   54.024999] RSP: 0018:ffffe8ffff580000 EFLAGS: 00010806
> [   54.025002] RAX: f3f3f300f1f1f1f1 RBX: fffff91fffeb0044 RCX: ffffffff8=
4201701
> [   54.025005] RDX: fffff91fffeb0044 RSI: ffffffff8420128d RDI: ffffe8fff=
f580178
> [   54.025007] RBP: ffffe8ffff580140 R08: 0000000000000000 R09: 000000000=
0000000
> [   54.025009] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc000=
0000000
> [   54.025010] R13: 1ffffd1fffeb0014 R14: 0000000000000003 R15: ffffe8fff=
f580178
> [   54.025012] FS:  00007fd076525d00(0000) GS:ffff8881f7180000(0000) knlG=
S:0000000000000000
> [   54.025015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.025017] CR2: ffffe8ffff57fff8 CR3: 000000010cd80002 CR4: 000000000=
0370ef0
> [   54.025021] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   54.025022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   54.025024] Call Trace:
> [   54.025026]  <#DF>
> [   54.025028]  ? __die_body+0xaf/0xc0
> [   54.025032]  ? die+0x2f/0x50
> [   54.025036]  ? exc_double_fault+0x73/0x80
> [   54.025040]  ? asm_exc_double_fault+0x23/0x30
> [   54.025044]  ? common_interrupt_return+0xb1/0xcc
> [   54.025048]  ? asm_exc_page_fault+0xd/0x30
> [   54.025051]  ? error_entry+0x1e/0x140
> [   54.025055]  </#DF>
> [   54.025056] Modules linked in: bpf_testmod(OE)
> [   54.025061] ---[ end trace 0000000000000000 ]---
>
> Maybe somebody could give a hint why I got a double fault
> when calling external functions (outside of bpf programs)
> with allocated stack?
>

I will help in debugging. Can you share the patch you applied locally
so I can reproduce?

> >
> > Since stack bottom/top are known at JIT time we can
> > generate reliable stack overflow checks.
> > Much better than guard pages and -fstack-protector.
> > The prog can alloc percpu
> > (stack size of main prog + subprogs + extra) * 4
> > and it likely will be enough.
> > If not, the stack protection will gently exit the prog
> > when the stack is too deep.
> > kfunc won't have such a check, so we need a buffer zone.
> > Can have a guard page too, but feels like overkill.

