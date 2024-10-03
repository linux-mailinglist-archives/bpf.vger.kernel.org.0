Return-Path: <bpf+bounces-40866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8C98F835
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A371C21966
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B74197A65;
	Thu,  3 Oct 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVR+cF5A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623D80BFC
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727988464; cv=none; b=XQWSrqWapwv5tn3y3EAcnF/VWnE8tMZMqauXKB6WTLLrnB6pjgsfYGmDLSVN1lzB2ZRGjacKYBhL/iLxMf3LdmaCUy5QwER799WfJMvzj3Q+rRhMf+yg5aEIgzCnQJ4ntqoH8FfCJW8G7ldJDNMmGw7NCj01+kUiSiF83A+yhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727988464; c=relaxed/simple;
	bh=pTfLehxTxnxoY/ljtEAhGAeRs/u9/WW0WVhvJZH7jcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUjnEhUWw+6OZBkXmUF5rz+prUXmqj1mGFI+X+TTv/WhZeJOpOeGqpOJRSwQJB2PZZQcdk6h9Cy7/gRy/iPOoMy+z515eNiGsaVLA4umA81ftnzgBaX6flmzczwugRL/vN3eF8AtKUh+cJS2jNLqQnW+goRyoymNXcvADzfzC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVR+cF5A; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso22715001fa.3
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727988460; x=1728593260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka+GdKWfSIsLOhdOpxjLK7toKIFYmk7QtE17QaSyi4g=;
        b=gVR+cF5A8XUN8blAwNvKVRzTHOgJKtU5LWuPHsUAdPeXPRQTWjq0KZktllsrBFOJr+
         np6W3RX1OECbg4xUHlIUcCdZaYM/ueUciZPTQoXiaBoEQ9Ld7mKkrnxHzwj4MOYmbmTf
         IO4KObP2OIXvVCOvCSsOA1tZ68dnJgV2AVuHShJsKL4fonaUMWLW4a/8VDiTW7cIHMkQ
         83dmzgNgmc6gUBdEaqW11hT3lrkyp3ppaYZ8cVZ4QHogAiYxYSj/iJ1Uld5fczgbuE32
         xRsZDnL2Eih3IovQRcpW4Xge2I2Oa8YhiZwtQsAshbW9/nwRfkUXiKs5orq5z17+8yZW
         +QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727988460; x=1728593260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka+GdKWfSIsLOhdOpxjLK7toKIFYmk7QtE17QaSyi4g=;
        b=MwKcPkw/SmJWG1Tqrg+ZttIpbrcchI07VtvzKKTLRQSVa1W+GyU+BbvPH82zsHBxjj
         nb/K9YY9v33aIU+VwYGot+smzUb1mR4l55VvelGirBD/d6bQYn/7fWkyc0aVFMLM/3If
         FcPVyUyKORihddmzAH9PzneyHMZIJH9QgTsIB3iFNg5SWTuGZ3rLpuIyqrbh6P+tN7jn
         hB3E5R4glm80eAB5oroeGcK1IsGH2XAIK87Lz1yyH/IhscOH+UU2Xu+yZD3U5g9ShJPJ
         5pEnz55OgnAl4q+b7YO4yAgRsl6Z/AbyyIthAq/knWwOsL1Ivh6hoL4KUFg7JaEhZ29G
         5Uzw==
X-Forwarded-Encrypted: i=1; AJvYcCXumg9BCtySAscKfqhgk8oJhz+7tkKunZ9ZzGAzeS0kBJ1ZpYT4dXixjuNFr4Gj1NUl3J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStWR/a5N+iZPsP8VBvghvnbS8h4Bnh+FDuzt5W9nLDkGucz2i
	3xzymssKvZzX623q0Gxh9e/qLBqBSj7qvjQNS7OiZWGvdaYfoyGxbI9STPzoLmuEzi7JDtLSVC+
	QtoaHzZbE72iVhJeGFysjNqlZ4N4=
X-Google-Smtp-Source: AGHT+IHwr3V7ioifcOQacU+VLJsOHL19384S4bYi1vCNULHn4TznxYSVIFqnwjiWaFz+cv16x5uaz++8PlwCHTAoaHk=
X-Received: by 2002:a05:6512:2395:b0:536:a7e0:131a with SMTP id
 2adb3069b0e04-539ab87d60cmr599536e87.26.1727988459664; Thu, 03 Oct 2024
 13:47:39 -0700 (PDT)
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
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com> <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
In-Reply-To: <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 3 Oct 2024 22:47:03 +0200
Message-ID: <CAP01T75CB=dEzXaHjJK6GCUrZUEqyzw+dxqHZuZLjCE-UyVH4w@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 22:44, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
> On 10/3/24 10:35 AM, Alexei Starovoitov wrote:
> > On Thu, Oct 3, 2024 at 6:40=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> >> On Thu, 3 Oct 2024 at 08:17, Yonghong Song <yonghong.song@linux.dev> w=
rote:
> >>>
> >>> On 10/1/24 6:26 PM, Alexei Starovoitov wrote:
> >>>> On Tue, Oct 1, 2024 at 5:23=E2=80=AFPM Kumar Kartikeya Dwivedi <memx=
or@gmail.com> wrote:
> >>>>> Makes sense, though will we have cases where hierarchical schedulin=
g
> >>>>> attaches the same prog at different points of the hierarchy?
> >>>> I'm not sure anyone was asking for such a use case.
> >>>>
> >>>>> Then the
> >>>>> limit of 4 may not be enough (e.g. say with cgroup nested levels > =
4).
> >>>> Well, 4 was the number from TJ.
> >>>>
> >>>> Anyway the proposed pseudo code:
> >>>>
> >>>> __bpf_prog_enter_recur_limited()
> >>>> {
> >>>>     cnt =3D this_cpu_inc_return(*(prog->active));
> >>>>     if (cnt > 4) {
> >>>>        inc_miss
> >>>>        return 0;
> >>>>     }
> >>>>    // pass cnt into bpf prog somehow, like %rdx ?
> >>>>    // or re-read prog->active from prog
> >>>> }
> >>>>
> >>>>
> >>>> then in the prologue emit:
> >>>>
> >>>> push rbp
> >>>> mov rbp, rsp
> >>>> if %rdx =3D=3D 1
> >>>>      // main prog is called for the first time
> >>>>      mov rsp, pcpu_priv_stack_top
> >>>> else
> >>>>      // 2+nd time main prog is called or 1+ time subprog
> >>>>     sub rsp, stack_size
> >>>>     if rsp < pcpu_priv_stack_bottom
> >>>>       goto exit  // stack is too small, exit
> >>>> fi
> >>> I have tried to implement this approach (not handling
> >>> recursion yet) based on the above approach. It works
> >>> okay with nested bpf subprogs like
> >>>      main prog  // set rsp =3D pcpu_priv_stack_top
> >>>        subprog1 // some stack
> >>>          subprog2 // some stack
> >>>
> >>> The pcpu_priv_stack is allocated like
> >>>     priv_stack_ptr =3D __alloc_percpu_gfp(1024 * 16, 8, GFP_KERNEL);
> >>>
> >>> But whenever the prog called an external function,
> >>> e.g. a helper in this case, I will get a double fault.
> >>> An example could be
> >>>      main prog  // set rsp =3D pcpu_priv_stack_top
> >>>        subprog1 // some stack
> >>>          subprog2 // some stack
> >>>        call bpf_seq_printf
> >>> (I modified bpf_iter_ipv6_route.c bpf prog for the above
> >>> purpose.)
> >>> I added some printk statements from the beginning of bpf_seq_printf a=
nd
> >>> nothing printed out either and of course traps still happens.
> >>>
> >>> I tried another example without subprog and the mainprog calls
> >>> a helper and the same double traps happens below too.
> >>>
> >>> The error log looks like
> >>>
> >>> [   54.024955] traps: PANIC: double fault, error_code: 0x0
> >>> [   54.024969] Oops: double fault: 0000 [#1] PREEMPT SMP KASAN PTI
> >>> [   54.024977] CPU: 3 UID: 0 PID: 1946 Comm: test_progs Tainted: G   =
        OE      6.11.0-10577-gf25c172fd840-dirty #968
> >>> [   54.024982] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >>> [   54.024983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>> [   54.024986] RIP: 0010:error_entry+0x1e/0x140
> >>> [   54.024996] Code: ff ff 90 90 90 90 90 90 90 90 90 90 56 48 8b 74 =
24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 =
56 <41> 57 56 31 f6 31 d1
> >>> [   54.024999] RSP: 0018:ffffe8ffff580000 EFLAGS: 00010806
> >>> [   54.025002] RAX: f3f3f300f1f1f1f1 RBX: fffff91fffeb0044 RCX: fffff=
fff84201701
> >>> [   54.025005] RDX: fffff91fffeb0044 RSI: ffffffff8420128d RDI: ffffe=
8ffff580178
> >>> [   54.025007] RBP: ffffe8ffff580140 R08: 0000000000000000 R09: 00000=
00000000000
> >>> [   54.025009] R10: 0000000000000000 R11: 0000000000000000 R12: dffff=
c0000000000
> >>> [   54.025010] R13: 1ffffd1fffeb0014 R14: 0000000000000003 R15: ffffe=
8ffff580178
> >>> [   54.025012] FS:  00007fd076525d00(0000) GS:ffff8881f7180000(0000) =
knlGS:0000000000000000
> >>> [   54.025015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [   54.025017] CR2: ffffe8ffff57fff8 CR3: 000000010cd80002 CR4: 00000=
00000370ef0
> >>> [   54.025021] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> >>> [   54.025022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> >>> [   54.025024] Call Trace:
> >>> [   54.025026]  <#DF>
> >>> [   54.025028]  ? __die_body+0xaf/0xc0
> >>> [   54.025032]  ? die+0x2f/0x50
> >>> [   54.025036]  ? exc_double_fault+0x73/0x80
> >>> [   54.025040]  ? asm_exc_double_fault+0x23/0x30
> >>> [   54.025044]  ? common_interrupt_return+0xb1/0xcc
> >>> [   54.025048]  ? asm_exc_page_fault+0xd/0x30
> >>> [   54.025051]  ? error_entry+0x1e/0x140
> >>> [   54.025055]  </#DF>
> >>> [   54.025056] Modules linked in: bpf_testmod(OE)
> >>> [   54.025061] ---[ end trace 0000000000000000 ]---
> >>>
> >>> Maybe somebody could give a hint why I got a double fault
> >>> when calling external functions (outside of bpf programs)
> >>> with allocated stack?
> >>>
> >> I will help in debugging. Can you share the patch you applied locally
> >> so I can reproduce?
> > Looks like the idea needs more thought.
> >
> > in_task_stack() won't recognize the private stack,
> > so it will look like stack overflow and double fault.
> >
> > do you have CONFIG_VMAP_STACK ?
>
> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard private =
stack support with
> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
> CONFIG_VMAP_STACK or not.
>

I think it is the default on most distributions (Debian, Ubuntu, Fedora, et=
c.).

