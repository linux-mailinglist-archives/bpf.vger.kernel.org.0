Return-Path: <bpf+bounces-41457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3037997343
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EA81F261A7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC91836D9;
	Wed,  9 Oct 2024 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW0uIn6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316A7710C
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495513; cv=none; b=C/gt32efK/N3r/a1r8zXBogHSoVKE9ytvLn/zm6EHJSojJHruqCPt3nMlhDS+SLYzOeRakPwu40aEr8e2Ox8Jcci8/7wHR49Mqadxhn5fclNkdzL4OGR/TpIFK7bZwmgQSqxpjV6XbYit0dh2Slk08WDFT41VX1E+Q3QPCpKZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495513; c=relaxed/simple;
	bh=S5JKNiFUDktzkEDgsLKbc0C6hBI6788b46nJU6wuF40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6w2vFH7o/4CDL5xvAfuSqGjAG0auzAlwJv1HRwYU8U0bSKlV/U9ehY2mWExV7LR8jYTKNr+2V30txcoCt8hM4taAM+6dvFlT0CZrg9trildGHmH/pcFFWR24ekQ7c3otqqmSjEpNE/qX49f40lG9j/w5oXg9FSfuT+bvR5QSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW0uIn6j; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c915308486so2325157a12.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728495510; x=1729100310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llLkBn8mVtMvKVPdde8I0LSUP0kr63fQGXbKEeMxcQQ=;
        b=iW0uIn6jMtQlc3KHXNJ4cN3JM8dVS5DGONNyaUNyaJwFwcldVKlH83e57JteeDGB1m
         SvpwE1v4YT178WM21DFHtm89rRji6+oFEQsqdkJyBhd2sfLkvxXy1/QvDLQw4ZzsbV0+
         xLp/JdHAZ2H36CcUtkJ3CZAz+NbtZ+GD/jDC7cxsg8GMBPgDQwEZTJUp5LZ/1B77nbDj
         MhhxFuy/bpXeyvbTmAU6kJG5OpdY7MbYoA2WLdUXu9QnJ+CvyHzR612pg97miYTM659A
         G/HVZqgeqoeO1JphmQ4vX/2aob4a38aN4yA7DUtE/7mnaZ4d1k9SrMfRao6hyBO0Acq6
         Zo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728495510; x=1729100310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llLkBn8mVtMvKVPdde8I0LSUP0kr63fQGXbKEeMxcQQ=;
        b=B7GLDgdVnqcxUhM+c75E0vpeAuexRM7ZS1Kc6rW6R7nw7M8BCqsYGqldhfhgojjXit
         XOSrjV81ijPN9eekBQUKYtqz72IGtQkK2fkT62WZ5/nUvGqYmsP+MP4Du+St8aPluUIH
         Fh7bMNRNLx6jHv3r6zePvrCZU6ufnrlcAXQTuYJ/PNtPcDOF4jlF4jnkm5rDv9YuLJAz
         UZHcTVj1nLAWyr7L5Q+33DTzJwE4B7pVQIvJxPZbJNFL0KhbjW7klqf22y1AchiqJRH1
         rg8CiMVT0loNePBmh1jnRz+OOJHNS8BrcHb3Rk8dfY3OJqsv7Kcc4YAx6axbkiNnvPu1
         swUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU+rUsSmtrBEKf9ONxNPgnU1grD5LSRb+h8RQAREF7uPQt+e9ekvdcohAQtX+Vf7ADWIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVSq3CZGeUq9aXpYV1DxKYbwLCLeMaiQHIHKxezVefflF9Oa8
	5F77JpZuC9HCRUnS/oCvGqVamb8Hzp0/TjidGVb9pwb8XHSH+29xLu+1LTHK2qqaSjA8O9txkaS
	Q+sXz1CARkhawfXzKIVHs71JIpl8=
X-Google-Smtp-Source: AGHT+IEMzVV7UBV87JszE8r9dtl/Z0Rd8ZojcnbtmPMe2QMGP3JSGVwJGDE0bqF52DOFJA/B51vfR3mISooZK46IGbw=
X-Received: by 2002:a05:6402:50d3:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c91d6869e8mr2073889a12.31.1728495509496; Wed, 09 Oct 2024
 10:38:29 -0700 (PDT)
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
 <CAP01T751eMtFv-LAym3Go_f-QLHSeU2GY08p--hCcdxzADte1w@mail.gmail.com> <CAP01T769+fM3YqYOm4bw-LhocMiq0OqBYH50TRGFjkxqHntf+A@mail.gmail.com>
In-Reply-To: <CAP01T769+fM3YqYOm4bw-LhocMiq0OqBYH50TRGFjkxqHntf+A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Oct 2024 19:37:53 +0200
Message-ID: <CAP01T76Kr52opr0d8cfFayZs83TMa0hKe7V=Mw1uuefrLGDNWQ@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 18:38, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Wed, 9 Oct 2024 at 18:36, Kumar Kartikeya Dwivedi <memxor@gmail.com> w=
rote:
> >
> > On Wed, 9 Oct 2024 at 04:06, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Oct 8, 2024 at 3:10=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > We need to scrap this idea.
> > > > Let's go back to push/pop r11 around calls :(
> > >
> > > I didn't give up :)
> > >
> > > Here is a new idea that seems to work:
> > >
> > > [  131.472066]  dump_stack_lvl+0x53/0x70
> > > [  131.472066]  bpf_task_storage_get+0x3e/0x2f0
> > > [  131.472066]  ? bpf_task_storage_get+0x231/0x2f0
> > > [  131.472066]  bpf_prog_ed7a5f33cc9fefab_foo+0x30/0x32
> > > [  131.472066]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x68/0x6=
d
> > > ...
> > > [  131.417145]  dump_stack_lvl+0x53/0x70
> > > [  131.417145]  bpf_task_storage_get+0x3e/0x2f0
> > > [  131.417145]  ? selinux_netlbl_socket_post_create+0xab/0x150
> > > [  131.417145]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x60/0x6=
d
> > >
> > >
> > > The stack dump works fine out of main prog and out of subprog.
> > >
> > > The key difference it to pretend to have stack_depth=3D0,
> > > so there is no adjustment to %rsp,
> > > but point %rbp to per-cpu private stack and grow it _up_.
> > >
> > > For the main prog %rbp points to the bottom of priv stack
> > > plus stack_depth it needs,
> > > so all bpf insns that do r10-off access the bottom of that priv stack=
.
> > > When subprog is called it does 'add %rbp, its_stack_depth' and
> > > in turn it's using memory above the bottom of the priv stack.
> > >
> > > That seems to work, but exceptions and tailcalls are broken.
> >
> > I fixed exceptions, the reason it breaks is because we:
> > We get rsp and rbp for the main frame from unwinding.
> > rsp has undergone subtraction for: stack depth, push r12, push callee r=
egs.
> >
> > When setting up the frame for exception cb, we need to pop saved
> > registers from stack and then 'reset stack frame' using mov rsp, rbp.
> > That effectively undoes the subtraction that happened for stack depth,
> > and at this point rsp =3D=3D rbp. Then the verifier will set up the fra=
me
> > for exception cb like it does normally for any prog: subtract stack
> > depth, and push callee saved regs.
> >
> > Now all of this was ok before, but this patch makes two changes:
> > stack_depth is not subtracted, and rbp is a per-cpu stack pointer.
> >
> > Therefore, at the top of the stack is just the callee saved regs and r1=
2.
> > After popping those, it will be equal to the original rbp which was
> > overwritten with per-cpu stack pointer.
> >
> > Doing mov rsp, rbp for this patch will reset rsp to per-cpu stack
> > pointer. Instead, we do mov rbp, rsp. This restores the rbp to kernel
> > stack pointer, and then the subsequent leave etc. return control back
> > into the kernel.
> >
> > At least this seems to make everything work fine, and things no longer
> > crash, and it looks sane etc.
> >
> > I will dig into the tail call case a bit later, but most likely it's a
> > variation of this problem.
>
> FYI, this is the fix.
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 268f7d37466c..02267adee14b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -523,7 +523,7 @@ static void emit_prologue(struct bpf_prog
> *bpf_prog, u8 **pprog, u32 stack_depth
>                 pop_callee_regs(&prog, all_callee_regs_used);
>                 pop_r12(&prog);
>                 /* Reset the stack frame. */
> -               EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
> +               EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
>         } else {
>                 EMIT1(0x55);             /* push rbp */
>                 if (tail_call_reachable || !bpf_prog->aux->priv_stack_ptr=
) {
>
> >

Figured out the problem with tail calls as well.
It was actually incorrect X86_TAIL_CALL_OFFSET, since a tail call
target using private stack will emit different instructions (to set up
private stack) now.
When it is actually called it has to skip over all that stuff, but the
offset to skip past the endbr is incorrect now.
Figured out since the page fault was happening to access the address
equal to per-cpu offset (say X) and the faulting instruction was in
the middle of add r11, gs:X.

Calculation is:
5 for emit_nops, 3 for emit_nops of 3 bytes (for alignment), 1 for
push rbp, and 22 bytes for the sequence to set up the private stack.
This, + ENDBR_INSN_SIZE.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 268f7d37466c..004e3ba1d338 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -323,7 +323,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE         5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET   (12 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET   (5 + 3 + 1 + 22 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)

 {

> > > I ran out of time today to debug.
> > > Pls see the attached patch.

