Return-Path: <bpf+bounces-41451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143E9971DA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341311C23313
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658361DF722;
	Wed,  9 Oct 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm9P3LXt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F919DF6A
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491800; cv=none; b=ZdbLzlryOYR5v+mHYysYX6cxfX6j+AcAf1/f64As7vcfTj3abl31yXKqwJHMynuregtELLsI++n4/TexFOZcvxyZAUPNrSFfTiPZ4qqY15r7Oogf6uUgt+6LlLnL3qS1Zp3SNpbgD+SwLLlEYX1uP4IZDJKN8Lw1c4wrDTtvigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491800; c=relaxed/simple;
	bh=aiYaq/LMUVxpbLOQV4chWrwdPX9zfNJRDjQhnyGNfI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LT4XbZoJkAHqAfRiUX7c2givNZJa3TIm3gt5O0s5XQMjvVMYIuZXntxSuNF+kd2rayEpAwsxmgojHnxh/sa0OH/f7DFNuavMjgNXFRTPRXjjo3opn8zh9QlSBlQKO4wIsAXmBTPttChDTdjPc175Cf1bGQ/QZoyuEP0Ail+lAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm9P3LXt; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso9091834a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728491797; x=1729096597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIFfJOTMBFyfVompdVZeH8TD3DhGBG5Ob5oC9agYjiw=;
        b=Bm9P3LXtoXWc10U/beq/O23CFGlnMc5VyqDTjnECpN+XFtx4qvQiXUJqAhaHnWpVmD
         lzvRvn+lbIOQ4ymC0gk5zYe2almI4yZtaVX7ZckC15JaZ0aBUlj+zqPj7NxVsQAyM5ud
         5my8hjwlkg4fVv2BpEAnscwhZI7LD1sb2siQuh3sguy3eW9/V2tsxhEurvrmLmDaMmqI
         3PO1ZsRSV6N0Oe/otuDYTawK+Hjldbzsfm/2ssuHJ9wwCVvEOM/qX7XEFnxP8EMANEls
         3pN7RjEpbvrMoZnCUKVcQNpohDwfqw6AKapWEQ96uee1WjPop+3s+XyQSo1IebsAtCwe
         0xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491797; x=1729096597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIFfJOTMBFyfVompdVZeH8TD3DhGBG5Ob5oC9agYjiw=;
        b=Rm0q4d2kbzTN12uHBzlxCdO1fQUOCFoX/HKQUlWc+Da1r9KSvcDLccufcrawZia1nD
         DKgpCIm9hmoDVdyDmX0BS2SskobU1ojAt8orZJ2SZunxr0eHczTd7LFvuHhqVOUlKOgX
         Ak3DL3SakQ5wuDFudpOYA2Vh609+2L3qnbyJebKAnv1GjKXuD9D6/5PW1m3/kMFSDbJR
         ZB2cKekGOa2wlk8DEV3LilQ5RlMifRMD2cFdfDeq+/O26NMp4MW/DIBtnTQR5xlVPtyt
         Os5s4GTqxuO9TMWHKdK3UiPYN3Fsb729IL7Bkg31FMK1LKg3IVncSbZFQNXMJ1GVoXCS
         D9KA==
X-Forwarded-Encrypted: i=1; AJvYcCWUbiA9lKxy5FrQEpKE5FulV0b5VOCK7k1U15tOXj5hD/6WBuoL5g/BUzfyPG26JEamPig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfqNZRjfi8CGm9KuLFDS0xPds6JJJKDtMAI5Dz6M877f3Fyvx
	rFuyMPFnb/aSv/pfI9omILRLFryzZLdPdxG3GfFoP6wuWcwunONKVMpfa7ui0zrrqxcJtmPd4Ny
	/NYqqDNtWMXkQAfwu/35aK6QXTZY=
X-Google-Smtp-Source: AGHT+IH1U2WOS1pRvwSY5xwddFd3eNgusr9MER9YqBxhYQ6KNpaVW7k+emitSsj49IjxX3CJHBue9rBADz+T+7ax+08=
X-Received: by 2002:a05:6402:278f:b0:5c3:1089:ff23 with SMTP id
 4fb4d7f45d1cf-5c91d6a03femr2430254a12.35.1728491797232; Wed, 09 Oct 2024
 09:36:37 -0700 (PDT)
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
 <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com>
In-Reply-To: <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Oct 2024 18:36:00 +0200
Message-ID: <CAP01T751eMtFv-LAym3Go_f-QLHSeU2GY08p--hCcdxzADte1w@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 04:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 8, 2024 at 3:10=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > We need to scrap this idea.
> > Let's go back to push/pop r11 around calls :(
>
> I didn't give up :)
>
> Here is a new idea that seems to work:
>
> [  131.472066]  dump_stack_lvl+0x53/0x70
> [  131.472066]  bpf_task_storage_get+0x3e/0x2f0
> [  131.472066]  ? bpf_task_storage_get+0x231/0x2f0
> [  131.472066]  bpf_prog_ed7a5f33cc9fefab_foo+0x30/0x32
> [  131.472066]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x68/0x6d
> ...
> [  131.417145]  dump_stack_lvl+0x53/0x70
> [  131.417145]  bpf_task_storage_get+0x3e/0x2f0
> [  131.417145]  ? selinux_netlbl_socket_post_create+0xab/0x150
> [  131.417145]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x60/0x6d
>
>
> The stack dump works fine out of main prog and out of subprog.
>
> The key difference it to pretend to have stack_depth=3D0,
> so there is no adjustment to %rsp,
> but point %rbp to per-cpu private stack and grow it _up_.
>
> For the main prog %rbp points to the bottom of priv stack
> plus stack_depth it needs,
> so all bpf insns that do r10-off access the bottom of that priv stack.
> When subprog is called it does 'add %rbp, its_stack_depth' and
> in turn it's using memory above the bottom of the priv stack.
>
> That seems to work, but exceptions and tailcalls are broken.

I fixed exceptions, the reason it breaks is because we:
We get rsp and rbp for the main frame from unwinding.
rsp has undergone subtraction for: stack depth, push r12, push callee regs.

When setting up the frame for exception cb, we need to pop saved
registers from stack and then 'reset stack frame' using mov rsp, rbp.
That effectively undoes the subtraction that happened for stack depth,
and at this point rsp =3D=3D rbp. Then the verifier will set up the frame
for exception cb like it does normally for any prog: subtract stack
depth, and push callee saved regs.

Now all of this was ok before, but this patch makes two changes:
stack_depth is not subtracted, and rbp is a per-cpu stack pointer.

Therefore, at the top of the stack is just the callee saved regs and r12.
After popping those, it will be equal to the original rbp which was
overwritten with per-cpu stack pointer.

Doing mov rsp, rbp for this patch will reset rsp to per-cpu stack
pointer. Instead, we do mov rbp, rsp. This restores the rbp to kernel
stack pointer, and then the subsequent leave etc. return control back
into the kernel.

At least this seems to make everything work fine, and things no longer
crash, and it looks sane etc.

I will dig into the tail call case a bit later, but most likely it's a
variation of this problem.

> I ran out of time today to debug.
> Pls see the attached patch.

