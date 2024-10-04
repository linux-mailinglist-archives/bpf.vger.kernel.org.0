Return-Path: <bpf+bounces-41009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D4991011
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7DA1F27455
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF51E1058;
	Fri,  4 Oct 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQj6V5m9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAEC1C7612
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071569; cv=none; b=RJiNF8f2jCbtZn6WQtAmedV/Wm3eMJ4yx5cxInKzkMud82aHO3qk5X1gSCzfqC0hJRPOrRgk7tVqP6p+7M0XkCZ9wk+Qx8RnXpc0VHV5R6QIeboMuwsta6xXVIwDukXXY3yIENney0taGs8ugcnG9A3Q3JSp3xH8mUg3MM8Cn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071569; c=relaxed/simple;
	bh=PiNfc+UWTSIdYMNZVoEgTvFFh8HLP+Yvh6gstNClU2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADDAqOCJjziB5AvBd7qeXH17lv8KQrMdgEKqq9mCUivGZwXMxrFvql6OJUapD+np6uZEW7Z3XG0tZScZTnck0F1I/xoZc1b2IXQ+x/mkKre/41YB84CCEFgNgHZ6wJHHL4DmqUc/RMamyWC0KguqE/FdV/2fbIazJDoEmU4ORRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQj6V5m9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so22739345e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728071566; x=1728676366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv807NY5UmwG12uGAANeWdoRLPCcrKuOj0BdXMcJngY=;
        b=BQj6V5m9TDrNTepPl3rOZQ82KGPcQgVNZTq27WjOXdPgO9ewbd6p/7K4oJI+B69HNq
         eMtibDOZA/sahnigJryonE+ZH0WeHj78a18Z0vNJJcqoKEVTAsNFHcEvHdDycOgrov0k
         Il6GwMJ72WIB76MUzJaXdr027HpsNE7icu3iOQK53Ij+l74OGHJ8xguJPJ2EBE0BVi6X
         7nJx0e2Rj9NkC8Ddzbvk14lLTIIg0jqE85iO5gQWCUrOS2r7BPptaQdsyuo+t749vNqH
         /HPVuPyBsSoB41tTDxyCuoKrnIiL9ihY/v9bj5qZJjibRaasyclV19p6VjMq+28zpJMJ
         gBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728071566; x=1728676366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv807NY5UmwG12uGAANeWdoRLPCcrKuOj0BdXMcJngY=;
        b=teDfMNF78eSoDglCrTGFkeCgzf/SDPUPT4K0BuYL41Hew81zJrChRVW7frSJBkXewK
         EsXvy5bIL2v5lgFHqkxG1KssuniX9joNq2uYLRhtkm1E6pfEJ2eJp37R7DMCx5a8AqZv
         FkaRVH5KmCdNyYHkt3AJqfsYClmJvdHV2QQWUkY7s2x8FPC6Vp15fIWcunUGEt9YHPyk
         HlFtWCymqg8ePmVs54lsFl6PEN2B1dxRURwb47lwam0Wk73DKnBb+vqiG8sPwsyRAzyt
         ah1Scd4KQ37f28AQ6KDJjBmURGM+bq1bX0IvVS8n4B9WizS+qbW0OkFQIk3fYccoNu23
         KvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVanaljuyTK6k13+b+JVekPNHGN0dn89AnXmkFYWkDS2Y9Gtyo81071QAHBuK88JNHaF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCO5VJyEDl6J+Tw6ICZDnN8CFwPipeC5rSQMjbulf8IRnkJzPY
	TUC87H5k+cx0Zis75S9+oIN4pa0XZ3NJy0inzJqEtEoh9dDbJ2dwwAAhl0RFCCfDuZxOeNlu482
	VbA3AIuB4i2bd6HbTNABJlW3z900=
X-Google-Smtp-Source: AGHT+IEsnc3akCL/xETg79Bx1dntrVfd2RBM46Coi1iaknhxhdoyrjdFzFPsiGXB9mdp0Z/UbFNcsxJgsob6nNf/kuI=
X-Received: by 2002:a05:600c:2152:b0:429:dc88:7e65 with SMTP id
 5b1f17b1804b1-42f85ab60d8mr25399055e9.12.1728071565658; Fri, 04 Oct 2024
 12:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev> <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
 <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev> <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
 <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev> <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
In-Reply-To: <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Oct 2024 12:52:34 -0700
Message-ID: <CAADnVQJRd-ngE8UBVUZVzwUwK6cGLMtZngwoUK+HOh2t_evcgQ@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:28=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/3/24 10:22 PM, Yonghong Song wrote:
> >
> > On 10/3/24 3:32 PM, Alexei Starovoitov wrote:
> >> On Thu, Oct 3, 2024 at 1:44=E2=80=AFPM Yonghong Song
> >> <yonghong.song@linux.dev> wrote:
> >>>> Looks like the idea needs more thought.
> >>>>
> >>>> in_task_stack() won't recognize the private stack,
> >>>> so it will look like stack overflow and double fault.
> >>>>
> >>>> do you have CONFIG_VMAP_STACK ?
> >>> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard
> >>> private stack support with
> >>> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
> >>> CONFIG_VMAP_STACK or not.
> >> Good! but I'm surprised it makes a difference.
> >
> > That only for the test case I tried. Now I tried the whole bpf selftest=
s
> > with CONFIG_VMAP_STACK on. There are still some failures. Some of them
> > due to stack protector. I disabled stack protector and then those stack
> > protector error gone. But some other errors show up like below:
> >
> > [   27.186581] kernel tried to execute NX-protected page - exploit
> > attempt? (uid: 0)
> > [   27.187480] BUG: unable to handle page fault for address:
> > ffff888109572800
> > [   27.188299] #PF: supervisor instruction fetch in kernel mode
> > [   27.189085] #PF: error_code(0x0011) - permissions violation
> >
> > or
> >
> > [   27.736844] BUG: unable to handle page fault for address:
> > 0000000080000000
> > [   27.737759] #PF: supervisor instruction fetch in kernel mode
> > [   27.738631] #PF: error_code(0x0010) - not-present page
> > [   27.739455] PGD 0 P4D 0
> > [   27.739818] Oops: Oops: 0010 [#1] PREEMPT SMP PTI
> >
> > ...
> >
> > Some further investigations are needed.
>
>
> I found one failure case (with stackprotector disabled):
>
> [   20.032611] traps: PANIC: double fault, error_code: 0x0
> [   20.032615] Oops: double fault: 0000 [#1] PREEMPT SMP PTI
> [   20.032619] CPU: 0 UID: 0 PID: 1959 Comm: test_progs Tainted: G       =
    OE      6.11.0-10576-g17baa0096769-dirty #1006
> [   20.032623] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> [   20.032624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   20.032626] RIP: 0010:error_entry+0x17/0x140
> [   20.032633] Code: ff 0f 01 f8 e9 56 fe ff ff 90 90 90 90 90 90 90 90 9=
0 90 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 49
> [   20.032635] RSP: 0018:ffffe8ffff400000 EFLAGS: 00010093
> [   20.032637] RAX: ffffe8ffff4000a8 RBX: ffffe8ffff4000a8 RCX: ffffffff8=
2201737
> [   20.032639] RDX: 0000000000000000 RSI: ffffffff8220128d RDI: ffffe8fff=
f4000a8
> [   20.032640] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [   20.032641] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [   20.032642] R13: 0000000000000000 R14: 000000000002ed80 R15: 000000000=
0000000
> [   20.032643] FS:  00007f8a3a2006c0(0000) GS:ffff888237c00000(0000) knlG=
S:ffff888237c00000
> [   20.032645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   20.032646] CR2: ffffe8ffff3ffff8 CR3: 0000000103580002 CR4: 000000000=
0370ef0
> [   20.032649] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   20.032650] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   20.032651] Call Trace:
> [   20.032660]  <#DF>
> [   20.032664]  ? __die_body+0xaf/0xc0
> [   20.032667]  ? die+0x2f/0x50
> [   20.032670]  ? exc_double_fault+0xbf/0xd0
> [   20.032674]  ? asm_exc_double_fault+0x23/0x30
> [   20.032678]  ? restore_regs_and_return_to_kernel+0x1b/0x1b
> [   20.032681]  ? asm_exc_page_fault+0xd/0x30
> [   20.032684]  ? error_entry+0x17/0x140
> [   20.032687]  </#DF>
>
> The private stack for cpu 0:
>    priv_stack_ptr cpu 0 =3D [ffffe8ffff434000, ffffe8ffff438000] (total 1=
6KB)
> That is, the top stack is ffffe8ffff438000 and the bottom stack is ffffe8=
ffff434000.
>
> During bpf execution, a softirq may happen, at that point,
> stack pointer becomes:
>     RSP: 0018:ffffe8ffff400000 (see above)
> and there is a read/write (mostly write) to address
>     CR2: ffffe8ffff3ffff8
> And this may cause a fault.
> After this fault, there are some further access and probably because
> of invalid stack, double fault happens.
>
> So the quesiton is why RSP is reset to ffffe8ffff400000?

0x38000 bytes consumed by stack or rounded down?
That's unlikely.

> I have not figured out which code changed this? Maybe somebody can help?

As Kumar said earlier pls share the patch. Link to github? or whichever.

Double check that any kind of tail-call logic is not mixed with priv stack.

