Return-Path: <bpf+bounces-40850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C764798F55F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B54B28207F
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFA41A706F;
	Thu,  3 Oct 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFJL7niQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B17182A0
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976951; cv=none; b=gr00dc2odkv8UjHfbK5EktLRDTZMfS87ZeOm6jJG2DllCC2vKY+0ajQq73fvcSHgmnIGs9jvBOV1yTDwAMDTbMMh48MgQVBcFuRItaPmfb4itFvT9L8YNCwwsI4gao2VKBW46yW+lzt4sS2fq5mlB+6Pe7DRWBUzjUuBi/hqqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976951; c=relaxed/simple;
	bh=pp1dFN6q5dzWhfSzERzlR4eEQHjcgkDP5NVapSUFEb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7ZO7IK1tmThzzD0dhRQ8/N73XewzawSEjpFTpMHTgSOP7GIEbxzTh8LpKwWOUiX+GCirIkIBOKKBbebjeIKGh3pv+r270U9UBNVP3mN0m5M14Z66IXah2r3g/XpeAAprg0U/OBGdm8kjLUPkJtI7Q6vGvCDEhdViKVMaB4Fpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFJL7niQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d60e23b33so179124966b.0
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976948; x=1728581748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjPJzeWKURnrq7QzyGJPHWZV6gqTMkMjlNdYTOa9SFI=;
        b=VFJL7niQ+EeO1dOIsPxbhH77VrE5a8JkT0REKoNZqan9zRYdOuLA7ZhpeeSSLysMMT
         y927NEtvX/sd9rnYQhKYmKeCai2OamtdXtMj3NK8TKo8TGz7Z4YPx0TZe0RHZDZ3WHWi
         +YjvOEIiE4OcQZN/bLoeKksZ1FqeUcrX4Ng5rPNcxIikVFivC5zTHxmsTAL4eeTOx6sk
         iAfux9P9cAWL/0J56KOwJuB9tniqMki17Xucg8C+wz2I215xLQDliz89nmc4sDDw4pJg
         FqRu15HtLA3KDrCtWz6c3H12DCIRuL+aJdWezT9ggj19zf14arIB7D/YCevV/DBCHltv
         pd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976948; x=1728581748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjPJzeWKURnrq7QzyGJPHWZV6gqTMkMjlNdYTOa9SFI=;
        b=FwmRqTwdG2BBbDB5Xm4sSPC3QN/28eeSnZZ5pDjFZC4pDjNo7skEAeMv8rh8if+SW6
         huzyfvxc6fEvUKf/lDhLBciuiKobf/KTHQjPUKbRHer/ZhFOO9AzOugy+OXaNKy4YMcC
         6to+/TkAUEIaVyr+qqhuQut/YsDCjvs/paLz9EY6wNZxNo27Pz1ZJLZmVQHDlmAA8fHj
         rCJsN1WyZeRawenVA9QWMGerJ7FsBBlrC1SDQ7sZIXKYdNFPSh7XQ0c0Yo6MlE4hXjtk
         OMKkk8TCYHDbvYTHtkc116+AkwgtIc7/1XTYhOXqrsf7WmKMZ3gZ5Hq9yLb6bWQEhl4e
         5Huw==
X-Forwarded-Encrypted: i=1; AJvYcCUdQsbVXHNPExqjBiP7dhKkUGFz11Agq54KjdnGIiSL+jlWdXFb/dakn5ZbraA6jeIvWS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmH+HCh7i0RG3eUkE2Wq9gxGoLx8yucU2wPmj1FyK7Ys6Iouys
	3e1fxMQhwZPCix3tgDsuh7KOwxPvSP+il7hqiJG0Uki9yO9w00vz90fftE78b6lRQQ+WxwAw8i6
	mfRbfBUFZtSu6/pVqQdaG6O/SUfm57twx
X-Google-Smtp-Source: AGHT+IE4s29nBWKmjgSrop1ofUDSItKvOvGvKSBzYHAwQgz6lB87dA+Sgb9NcMf2OgcYcdfd4oOc64QUSTaHyMY5X9E=
X-Received: by 2002:a17:907:26c4:b0:a8d:3d36:3169 with SMTP id
 a640c23a62f3a-a991c0107d6mr12081366b.63.1727976947919; Thu, 03 Oct 2024
 10:35:47 -0700 (PDT)
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
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev> <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
In-Reply-To: <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Oct 2024 10:35:36 -0700
Message-ID: <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 6:40=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Thu, 3 Oct 2024 at 08:17, Yonghong Song <yonghong.song@linux.dev> wrot=
e:
> >
> >
> > On 10/1/24 6:26 PM, Alexei Starovoitov wrote:
> > > On Tue, Oct 1, 2024 at 5:23=E2=80=AFPM Kumar Kartikeya Dwivedi <memxo=
r@gmail.com> wrote:
> > >> Makes sense, though will we have cases where hierarchical scheduling
> > >> attaches the same prog at different points of the hierarchy?
> > > I'm not sure anyone was asking for such a use case.
> > >
> > >> Then the
> > >> limit of 4 may not be enough (e.g. say with cgroup nested levels > 4=
).
> > > Well, 4 was the number from TJ.
> > >
> > > Anyway the proposed pseudo code:
> > >
> > > __bpf_prog_enter_recur_limited()
> > > {
> > >    cnt =3D this_cpu_inc_return(*(prog->active));
> > >    if (cnt > 4) {
> > >       inc_miss
> > >       return 0;
> > >    }
> > >   // pass cnt into bpf prog somehow, like %rdx ?
> > >   // or re-read prog->active from prog
> > > }
> > >
> > >
> > > then in the prologue emit:
> > >
> > > push rbp
> > > mov rbp, rsp
> > > if %rdx =3D=3D 1
> > >     // main prog is called for the first time
> > >     mov rsp, pcpu_priv_stack_top
> > > else
> > >     // 2+nd time main prog is called or 1+ time subprog
> > >    sub rsp, stack_size
> > >    if rsp < pcpu_priv_stack_bottom
> > >      goto exit  // stack is too small, exit
> > > fi
> >
> > I have tried to implement this approach (not handling
> > recursion yet) based on the above approach. It works
> > okay with nested bpf subprogs like
> >     main prog  // set rsp =3D pcpu_priv_stack_top
> >       subprog1 // some stack
> >         subprog2 // some stack
> >
> > The pcpu_priv_stack is allocated like
> >    priv_stack_ptr =3D __alloc_percpu_gfp(1024 * 16, 8, GFP_KERNEL);
> >
> > But whenever the prog called an external function,
> > e.g. a helper in this case, I will get a double fault.
> > An example could be
> >     main prog  // set rsp =3D pcpu_priv_stack_top
> >       subprog1 // some stack
> >         subprog2 // some stack
> >       call bpf_seq_printf
> > (I modified bpf_iter_ipv6_route.c bpf prog for the above
> > purpose.)
> > I added some printk statements from the beginning of bpf_seq_printf and
> > nothing printed out either and of course traps still happens.
> >
> > I tried another example without subprog and the mainprog calls
> > a helper and the same double traps happens below too.
> >
> > The error log looks like
> >
> > [   54.024955] traps: PANIC: double fault, error_code: 0x0
> > [   54.024969] Oops: double fault: 0000 [#1] PREEMPT SMP KASAN PTI
> > [   54.024977] CPU: 3 UID: 0 PID: 1946 Comm: test_progs Tainted: G     =
      OE      6.11.0-10577-gf25c172fd840-dirty #968
> > [   54.024982] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > [   54.024983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   54.024986] RIP: 0010:error_entry+0x1e/0x140
> > [   54.024996] Code: ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 24=
 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56=
 <41> 57 56 31 f6 31 d1
> > [   54.024999] RSP: 0018:ffffe8ffff580000 EFLAGS: 00010806
> > [   54.025002] RAX: f3f3f300f1f1f1f1 RBX: fffff91fffeb0044 RCX: fffffff=
f84201701
> > [   54.025005] RDX: fffff91fffeb0044 RSI: ffffffff8420128d RDI: ffffe8f=
fff580178
> > [   54.025007] RBP: ffffe8ffff580140 R08: 0000000000000000 R09: 0000000=
000000000
> > [   54.025009] R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0=
000000000
> > [   54.025010] R13: 1ffffd1fffeb0014 R14: 0000000000000003 R15: ffffe8f=
fff580178
> > [   54.025012] FS:  00007fd076525d00(0000) GS:ffff8881f7180000(0000) kn=
lGS:0000000000000000
> > [   54.025015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   54.025017] CR2: ffffe8ffff57fff8 CR3: 000000010cd80002 CR4: 0000000=
000370ef0
> > [   54.025021] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [   54.025022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [   54.025024] Call Trace:
> > [   54.025026]  <#DF>
> > [   54.025028]  ? __die_body+0xaf/0xc0
> > [   54.025032]  ? die+0x2f/0x50
> > [   54.025036]  ? exc_double_fault+0x73/0x80
> > [   54.025040]  ? asm_exc_double_fault+0x23/0x30
> > [   54.025044]  ? common_interrupt_return+0xb1/0xcc
> > [   54.025048]  ? asm_exc_page_fault+0xd/0x30
> > [   54.025051]  ? error_entry+0x1e/0x140
> > [   54.025055]  </#DF>
> > [   54.025056] Modules linked in: bpf_testmod(OE)
> > [   54.025061] ---[ end trace 0000000000000000 ]---
> >
> > Maybe somebody could give a hint why I got a double fault
> > when calling external functions (outside of bpf programs)
> > with allocated stack?
> >
>
> I will help in debugging. Can you share the patch you applied locally
> so I can reproduce?

Looks like the idea needs more thought.

in_task_stack() won't recognize the private stack,
so it will look like stack overflow and double fault.

do you have CONFIG_VMAP_STACK ?

