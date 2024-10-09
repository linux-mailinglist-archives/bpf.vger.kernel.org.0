Return-Path: <bpf+bounces-41452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DA997200
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF40F283DDE
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3D1E32D6;
	Wed,  9 Oct 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkRQtYNm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A9197A77
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491957; cv=none; b=tuK8/lyPWBLRUljTWGKe4Ix+HclkYY2E1J5UOBQSx/V1bZkimZ7MCmr8O0WNRROdvFP/cuqXF3EO3hwU/+bnX4BfMvWXcFxcCi+uCvccWUfLpBAF/bVOu71CfLXgZZ/93DdjHK2+ofNZLLA2r98PAZg9Qw4ziLMGjqr5FAKgcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491957; c=relaxed/simple;
	bh=xaHQEDLKurqVJ+z/6K+4k5gKX7c/TyI7BvwUTxhvb1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhKSGIhIuxo9NB2eVfY/elbwUbYWivrYVoGAg0JA1SwmpYI/2Czz95srnsJVBuWI689yVcGq+LJi7sCFV78KIgY7mY19jOkgCg9KkucsmziTqYWdVXqs94sXNrMmqZiVUWlttBwL6CxuwBPNCySufMEQ9183MiyFVZTB5ghZq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkRQtYNm; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so9801293a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728491953; x=1729096753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRlm28+lq32CHGaWM61eOBxyV5f9MQ0t/z+xOs2oY3w=;
        b=TkRQtYNmONlyBGrtV1/X4Pqj6rRd/xEtpFZ6TZ9zXgDl/9QQdhVbmymV3QKc6dUyCx
         AzyhywYhqnowQ6cWiUriU8blDwwlwjUc/RTH20Cz201PvO4056fxgkjMp9FoM5wpE87s
         Tt9++5Sp7uiDTXQuDJVO9UmAj9g+o1rjbclv1M0mByHnKP1jLMg9tHw/vzW/GGa77SMU
         EGo6wLSMlI8XOXAzD9rH2xbSufWSPRCxIxY1qbGKkpMbwjyKPrBtixPOD47ngXJN3o8n
         ZgF8U5vclr+xNGOqfBJJbjI/oyncdGKueCcmz8emVeNkOTJsYh451Ebxlr4Aj5DZ5wu2
         tgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491953; x=1729096753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRlm28+lq32CHGaWM61eOBxyV5f9MQ0t/z+xOs2oY3w=;
        b=QEuNLqxUrD6Jhz22zADDC6Kl0J201R7ghFIm5Idg2nT3QrFjHtLanpoUevRZJIQZ3I
         nawoYNtR2eYEr8d2xaxV79o+c/WUWpyvdaUfHdlqEHDA4DQ5g2aauxXXiz1ojs3NRiZV
         GvNRMh7DfP86Wx5ucIZ7U5hAbloSdMM6Y8XO1xrcaknqz0l2DzBAqGVOdm4Yo1ixXEWx
         EN2WhMNw4IZXMpH7QQj6iCTqzaMINQZofJExj28V3W75KiRJdujbW+y1aKA+lS9KzEDJ
         wY865lolpNjy/yASi/pbYmeXnjPGlAiQWZBPM3tbovgDh/o4zlgA/KtzA9b8lOorT5LO
         I69w==
X-Forwarded-Encrypted: i=1; AJvYcCWNJACxjxOJbx6Uo4it1meNfP11l6fEKrU3Rkit02AxZ8JcX4Ncq1EPQIjSTYOWenIpEQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8xbvJ606aJsR3CJKfhCpGpelildN/iYy0kalfE6bhv0CVlij
	MVrhlIVds94fnsBfV45ENe7CQOtde8Azm2ixOPrX0EIiA4MPk1cdsvAe8UEfEXLfjPIB834hSUe
	3rJnmxHs7IT17qDPkCjD+5iBFwSI=
X-Google-Smtp-Source: AGHT+IEkSbwoSuKLf3vCHKp3dlZfppVAtdo2vJzjelhFmlvQPljYK52OgqTA2d1toBvvwh2jxd5vq3iNSnnvNrWBQiE=
X-Received: by 2002:a05:6402:2815:b0:5c5:b9c2:c5bb with SMTP id
 4fb4d7f45d1cf-5c91d6f6c17mr2838806a12.35.1728491952804; Wed, 09 Oct 2024
 09:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
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
 <CAADnVQJRd-ngE8UBVUZVzwUwK6cGLMtZngwoUK+HOh2t_evcgQ@mail.gmail.com>
 <1fc78197-c266-41d2-8d8a-c9dbf2e35d8f@linux.dev> <CAADnVQ+tvGMFnEuZmKyXxJX25pL+G6X+9445Ct-RSU1sZ+57xw@mail.gmail.com>
 <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com> <CAP01T751eMtFv-LAym3Go_f-QLHSeU2GY08p--hCcdxzADte1w@mail.gmail.com>
In-Reply-To: <CAP01T751eMtFv-LAym3Go_f-QLHSeU2GY08p--hCcdxzADte1w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Oct 2024 18:38:36 +0200
Message-ID: <CAP01T769+fM3YqYOm4bw-LhocMiq0OqBYH50TRGFjkxqHntf+A@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 18:36, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Wed, 9 Oct 2024 at 04:06, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Oct 8, 2024 at 3:10=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > We need to scrap this idea.
> > > Let's go back to push/pop r11 around calls :(
> >
> > I didn't give up :)
> >
> > Here is a new idea that seems to work:
> >
> > [  131.472066]  dump_stack_lvl+0x53/0x70
> > [  131.472066]  bpf_task_storage_get+0x3e/0x2f0
> > [  131.472066]  ? bpf_task_storage_get+0x231/0x2f0
> > [  131.472066]  bpf_prog_ed7a5f33cc9fefab_foo+0x30/0x32
> > [  131.472066]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x68/0x6d
> > ...
> > [  131.417145]  dump_stack_lvl+0x53/0x70
> > [  131.417145]  bpf_task_storage_get+0x3e/0x2f0
> > [  131.417145]  ? selinux_netlbl_socket_post_create+0xab/0x150
> > [  131.417145]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x60/0x6d
> >
> >
> > The stack dump works fine out of main prog and out of subprog.
> >
> > The key difference it to pretend to have stack_depth=3D0,
> > so there is no adjustment to %rsp,
> > but point %rbp to per-cpu private stack and grow it _up_.
> >
> > For the main prog %rbp points to the bottom of priv stack
> > plus stack_depth it needs,
> > so all bpf insns that do r10-off access the bottom of that priv stack.
> > When subprog is called it does 'add %rbp, its_stack_depth' and
> > in turn it's using memory above the bottom of the priv stack.
> >
> > That seems to work, but exceptions and tailcalls are broken.
>
> I fixed exceptions, the reason it breaks is because we:
> We get rsp and rbp for the main frame from unwinding.
> rsp has undergone subtraction for: stack depth, push r12, push callee reg=
s.
>
> When setting up the frame for exception cb, we need to pop saved
> registers from stack and then 'reset stack frame' using mov rsp, rbp.
> That effectively undoes the subtraction that happened for stack depth,
> and at this point rsp =3D=3D rbp. Then the verifier will set up the frame
> for exception cb like it does normally for any prog: subtract stack
> depth, and push callee saved regs.
>
> Now all of this was ok before, but this patch makes two changes:
> stack_depth is not subtracted, and rbp is a per-cpu stack pointer.
>
> Therefore, at the top of the stack is just the callee saved regs and r12.
> After popping those, it will be equal to the original rbp which was
> overwritten with per-cpu stack pointer.
>
> Doing mov rsp, rbp for this patch will reset rsp to per-cpu stack
> pointer. Instead, we do mov rbp, rsp. This restores the rbp to kernel
> stack pointer, and then the subsequent leave etc. return control back
> into the kernel.
>
> At least this seems to make everything work fine, and things no longer
> crash, and it looks sane etc.
>
> I will dig into the tail call case a bit later, but most likely it's a
> variation of this problem.

FYI, this is the fix.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 268f7d37466c..02267adee14b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -523,7 +523,7 @@ static void emit_prologue(struct bpf_prog
*bpf_prog, u8 **pprog, u32 stack_depth
                pop_callee_regs(&prog, all_callee_regs_used);
                pop_r12(&prog);
                /* Reset the stack frame. */
-               EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
+               EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
        } else {
                EMIT1(0x55);             /* push rbp */
                if (tail_call_reachable || !bpf_prog->aux->priv_stack_ptr) =
{

>
> > I ran out of time today to debug.
> > Pls see the attached patch.

