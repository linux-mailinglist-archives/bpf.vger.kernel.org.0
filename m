Return-Path: <bpf+bounces-41415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3285996EEC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CFE2850AD
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D41DFD93;
	Wed,  9 Oct 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Pw8N21"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1D1A3020
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485825; cv=none; b=mDydK/tGj+HrvgAIcodGSbG5jFQNXkfXjiyVB+90wec3QhZ4uqtaeW1pHRysa32zrJiZgNCgFCAJUrgrfEFY4pCvUlNja5C7QDo47gssy60a9OMJ3ksfZLvVII7eQdE97nnopDfz7Ds4dva0cKBfNUeqs1T0LE2hGZf8ol53rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485825; c=relaxed/simple;
	bh=DtH2WoJ9cEPS9b/gM7fqSWiecBo06z8hBNHNTM8di/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZOGA1gQZgo21UbUBH6oloHnf2MkcUaydjqQSPYWg0GGYPbfYbaJMN560uDLOJCU/OTC5x44J7uYQYqvcHmg1NENEjerPJFdVI7qcN8BnpFTiT7+O+tOwOdUgXJ0gTXNqGgIw3LnSDRihisOP1DKJvGauD6d0IykdH686oDQoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Pw8N21; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so7410165e9.2
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728485821; x=1729090621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmkXHmc20kvSf+P+j8X8Neikacv61yr0W58GkUgUUIo=;
        b=Y0Pw8N21IqIDesnNdJB9ByYWWrudeQqZBosTmCtT/NEkvypozhRNubIVKSbQJPRg4A
         lqQBUcmFvBf/itubbv+daZtiDBqASq9fRRil+WiK+9Bg/CrcWpRRgX1LRmbn3H5xJLwC
         sfIRNMuMmxHfaJHqTnDzmVxE1wCJRWLwG87znioZs9tBiUrlxJvvFEClZw65f19G/huC
         QkRL81Xk4ZmB8NRAAATOnXhQUzOshEoXueklyELAeMTer4PvghlKB/WDooq7j7wSJD32
         bW6YPd9J6Y+x6lvRKguT1wrK+1OH92PNqMgMgp0ykfM4rIzjo6fv6rhD+qPtNH8aoO92
         1vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485821; x=1729090621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmkXHmc20kvSf+P+j8X8Neikacv61yr0W58GkUgUUIo=;
        b=LFGfWjm39t1uiOs/yX6AIPcJt6moakcIu6MKF2S7mwZy9bg8cOC9LHlTGL9zGy+6IB
         7f4hVycLhh8OhZqOY0kVtCf59X4AUP0T5ZzVlceE6p3IlEYL39TrVgaGoBszdncz4HmW
         oLB3W/9LWlPcKsZHofx4zfIyNGyoFJIDt4+Vt3/KLDbfGBeIb2KM7gronVEt6ZnC0hkX
         3IH+d7pMY3l2bfqBDh1ctnKjUvMQI4R2Qnm237rFxNPzgIj42NLnHVi7xrlBVKTYbhHN
         2pTAmnMg/y55FGpxJMbLctMVrYMGs/bP8597s+rwpP/XBRmXqfOoUQ1cvgkPSo8jw+BI
         YaKA==
X-Forwarded-Encrypted: i=1; AJvYcCWzhb4/7HhtpSTQrEMbLgWzCDSqLGbxIKd5NJBS+/ff85huaIy6hhuKfiksGs8Rz9JS25g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6O0EW8lDiHRRIBhBRNmu/r7i6yjXe5j7EqXXCEOKfNkd2nom
	rvoM9w9vN4Dy90EogQ5lPNlSitid+SMytUNBeEWCTUdp4OlLxTm6n0xyPWwV0yS5iA4LNh5rkff
	9+APJabypgsClZW7dLPVafw+04is=
X-Google-Smtp-Source: AGHT+IHqnY4bdWVFa/kkArivhZMkqNmerqfhOSUqlX+3DMnv9JXSX99N98NRAF4HbVXWuQEzixuvqwuvQTKEubCxVMA=
X-Received: by 2002:a5d:6944:0:b0:37d:3760:1d9a with SMTP id
 ffacd0b85a97d-37d3a9d3c1emr1687407f8f.17.1728485821182; Wed, 09 Oct 2024
 07:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
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
 <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com> <62260dde-9e1d-430a-b350-01c28613b062@linux.dev>
In-Reply-To: <62260dde-9e1d-430a-b350-01c28613b062@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 07:56:49 -0700
Message-ID: <CAADnVQ+T5AD8J_p3U5vpTs=5nqpypuQeGBE+wezB7mnh8Axo0Q@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 11:31=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/8/24 7:06 PM, Alexei Starovoitov wrote:
> > On Tue, Oct 8, 2024 at 3:10=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> We need to scrap this idea.
> >> Let's go back to push/pop r11 around calls :(
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
> > I ran out of time today to debug.
> > Pls see the attached patch.
>
> The core part of the code is below:
>
> EMIT1(0x55); /* push rbp */ - EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp
> */ + if (tail_call_reachable || !bpf_prog->aux->priv_stack_ptr) { +
> EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */ + } else { + if
> (!is_subprog) { + /* mov rsp, pcpu_priv_stack_bottom */ + void __percpu
> *priv_frame_ptr =3D + bpf_prog->aux->priv_stack_ptr +
> round_up(stack_depth, 8); + + /* movabs sp, priv_frame_ptr */ +
> emit_mov_imm64(&prog, AUX_REG, (long) priv_frame_ptr >> 32, + (u32)
> (long) priv_frame_ptr); + + /* add <aux_reg>, gs:[<off>] */ +
> EMIT2(0x65, 0x4c); + EMIT3(0x03, 0x1c, 0x25); + EMIT((u32)(unsigned
> long)&this_cpu_off, 4); + /* mov rbp, aux_reg */ + EMIT3(0x4c, 0x89,
> 0xdd); + } else { + /* add rbp, stack_depth */ + EMIT3_off32(0x48, 0x81,
> 0xC5, round_up(stack_depth, 8)); + } + }

your mailer garbled the diff.

> So for main program, we have
>
> push rbp rbp =3D per_cpu_ptr(priv_stack_ptr + stack_size) ... What will
> happen we have an interrupt like below? push rbp rbp =3D
> per_cpu_ptr(priv_stack_ptr + stack_size) <=3D=3D=3D interrupt happens her=
e ...
> If we need to dump the stack trace at interrupt point then unwinder may
> have difficulty to find the proper stack trace since *rbp is a arbitrary
> value and *(rbp + 8) will not have proper func return address. Does this
> make sense?

Hard to read above... but I think you're saying that rbp will point
to priv stack, irq happens and unwinder cannot work ?
Yes. I was also expecting it to break, but orc unwinder
with fallback to fp somehow did it correctly. See above stack dumps.
For the top frame the unwinder starts from SP, so it's fine,
but for the subprog 'foo' above the 'push rbp' pushes the
addr of priv stack, so the chain should be broken,
but the printed stack is correct, so I'm puzzled why it worked :)

