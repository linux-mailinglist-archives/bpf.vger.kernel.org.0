Return-Path: <bpf+bounces-32356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F299A90BFBE
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 01:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309E9283A7F
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B441993A9;
	Mon, 17 Jun 2024 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWAVAmHR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6944163A97
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666404; cv=none; b=hXcqccXKAk5UK8Oj+rQpPqZdLdlSIg45LCMXXXhivZHR4InlOEe0nf/YRAxUARJdIiqRduA4vPAaD5Tx/8HMWUJRGqY+0ADpva7+gEWz5JScei8ddomHgUwFuvONTv2p/0MqS+teDkapNpOybbjTGQZmMJ4FYwchrzK+mplAiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666404; c=relaxed/simple;
	bh=1y6ittx7kHNLGO4IaZmp7xudVgGpNlw8yPsKisgTs8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOvrqe8CjRO3tnjGO3EQ3v/1xY76bii5o1rDUkBbgFzV26y93/+uaBH5DLnSOKhU+kOh3Noq9JvgGZH9rZGUDI5dveErprsZt0jbpmFvrAGwjWUY8yZ7nXz+mLmmBzFlayPJpjbo9ekLbEceec41P+pHR4csOuQJ8FrMoSkafig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWAVAmHR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4603189f8f.1
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718666401; x=1719271201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4S/URabLN2oy6Qc1QnORRjNy515opp70GYBEYiPacM=;
        b=FWAVAmHRx13BCEd3jN/xIFVnc4uPTywzMm/wCv4F0cylC5GawiIdYPDa54/jSXuBRg
         75CwC8Qvxa/PEWWJKJm4LsIiL6ns1sRrgfKGlrOJc25XYXx7Fl3JFnTFnwZYb4kIcR7M
         DzbMLj/6ozebmAhCa3Aha85XYpHyItn89xDwO2Kxmq7gEF3Skpf6/dwPDob4DYlFIpjw
         iEg5B3IFQ+nojoTJM3hbgjnCTsrtWPc3X6gt7pRLLcw2eQKMUt5XQE/NeN1ZIm+3m5gI
         UFPkx7KBbjRhDrcZm6m/YaF7XK7BBzBGHDOTNU9iGMxsFEzBZBLeJxvaZv9w1xTv/+AT
         S7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718666401; x=1719271201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4S/URabLN2oy6Qc1QnORRjNy515opp70GYBEYiPacM=;
        b=WLaXZ7YYpAIpP6X02JWFQYditLCERFny50kJQ2CH35UaHQVVGoV5zbRejrwT8IeiYR
         6ocBlaNSFExbSt9uMPloRiBZSiP30YWyPaGdauLHOItXiqBKqPbtEyEh6XkfQsgxW2JZ
         RimDIxgItnrvrrnf510RqKMwJq4x66GdDosa3GMZWulZDplEZUPSCNRqt176YZdc4cn8
         BTm5e2+hoiA0OQjVIB/IxFR26IbonR67IQtUCNQLyt0SEo/ElSZQMfVxQ6m8oPPFOM9V
         Fd7lI1ceOd/LcucJu6yzd0QXXAeOPj6pScO8fjbjz1eda8ATa0r7/fVWmAn5uNHf79Ot
         LWOA==
X-Gm-Message-State: AOJu0YxGkz+paR7nxetnpp7j8ouV8AO8DP4jRFyjwduLicd4yq6PIGjl
	pf+dABv9k/hiZnnoRd5kNqywWhxCQujAtYzCI+M0lsIuHDDTlIBVzjcTtJffxJw6d8MCe1D6+NW
	gEWObgpUoRv1soipP11OOz+YIY+OTqysW
X-Google-Smtp-Source: AGHT+IHcSrxYpJpTbdRahcYqfNeeZGbbHAs5EwxLT+UYmDZSjrNNjwP91not2vLbJjH8yTUBai/WMS5pEALjX78oYy0=
X-Received: by 2002:adf:e811:0:b0:360:8fb4:e810 with SMTP id
 ffacd0b85a97d-3608fb4e8femr5022924f8f.35.1718666400821; Mon, 17 Jun 2024
 16:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610051839.1296086-1-yonghong.song@linux.dev>
 <CAADnVQ+FwPAbeiiD78xnkRLZAiSDC4ObkKWV+x9bpSK9aM_GsA@mail.gmail.com> <707970c5-6bba-450a-be08-adf24d8b9276@linux.dev>
In-Reply-To: <707970c5-6bba-450a-be08-adf24d8b9276@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jun 2024 16:19:49 -0700
Message-ID: <CAADnVQL3pLgJJGoQ=cWC7V5wcrMR00Qx-PUDWAA2Yu6igw71gg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Support shadow stack for bpf progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 10:52=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 6/13/24 5:30 PM, Alexei Starovoitov wrote:
> > On Sun, Jun 9, 2024 at 10:18=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> > I think "shadow stack" already has at least two different meanings
> > in the kernel.
> > Let's avoid adding 3rd.
> > How about "divided stack" ?
>
> Naming is hard. Maybe "private stack" which suggests the stack is private
> to that program?

I like it. "private stack" fits the best.

> >
> >> +static void emit_percpu_shadow_frame_ptr(u8 **pprog, void *shadow_fra=
me_ptr)
> >> +{
> >> +       u8 *prog =3D *pprog;
> >> +
> >> +       /* movabs r9, shadow_frame_ptr */
> >> +       emit_mov_imm32(&prog, false, X86_REG_R9, (u32) (long) shadow_f=
rame_ptr);
> >> +
> >> +       /* add <r9>, gs:[<off>] */
> >> +       EMIT2(0x65, 0x4c);
> >> +       EMIT3(0x03, 0x0c, 0x25);
> >> +       EMIT((u32)(unsigned long)&this_cpu_off, 4);
> > I think this can be one insn:
> > lea r9, gs:[(u32)shadow_frame_ptr]
>
> Apparently, __alloc_percpu_gfp() may return a pointer which is beyond 32b=
it. That is why my
> RFC patch failed CI. I later tried to use
>
> +       /* movabs r9, shadow_frame_ptr */
> +       emit_mov_imm64(&prog, X86_REG_R9, (long) shadow_frame_ptr >> 32,
> +                      (u32) (long) shadow_frame_ptr);
>
> and CI is successful. I did some on-demand test (https://github.com/kerne=
l-patches/bpf/pull/7179)
> and it succeeded with CI.
>
> If __alloc_percpu_gfp() returns a pointer beyond 32bit, I am not sure
> whether we could get r9 with a single insn.

I see. Ok. Let's keep two insns sequence.

>
> >
> >> +       if (stack_depth && enable_shadow_stack) {
> > I think enabling it for progs with small stack usage
> > is unnecessary.
> > The definition of "small" is complicated.
> > I feel stack_depth <=3D 64 can stay as-is and
> > all networking progs don't have to use it either,
> > since they're called from known places.
> > While tracing progs can be anywhere, so I'd enable
> > divided stack for
> > stack_depth > 64 && prog_type =3D=3D kprobe, tp, raw_tp, tracing, perf_=
event.
>
> This does make sense. It partially aligns what I think for prog type
> side. We only need to enable 'divided stack' for certain prog types.
>
> >
> >> +               if (bpf_prog->percpu_shadow_stack_ptr) {
> >> +                       percpu_shadow_stack_ptr =3D bpf_prog->percpu_s=
hadow_stack_ptr;
> >> +               } else {
> >> +                       percpu_shadow_stack_ptr =3D __alloc_percpu_gfp=
(stack_depth, 8, GFP_KERNEL);
> >> +                       if (!percpu_shadow_stack_ptr)
> >> +                               return -ENOMEM;
> >> +                       bpf_prog->percpu_shadow_stack_ptr =3D percpu_s=
hadow_stack_ptr;
> >> +               }
> >> +               shadow_frame_ptr =3D percpu_shadow_stack_ptr + round_u=
p(stack_depth, 8);
> >> +               stack_depth =3D 0;
> >> +       } else {
> >> +               enable_shadow_stack =3D 0;
> >> +       }
> >> +
> >>          arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux-=
>arena);
> >>          user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->=
arena);
> >>
> >> @@ -1342,7 +1377,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int=
 *addrs, u8 *image, u8 *rw_image
> >>          /* tail call's presence in current prog implies it is reachab=
le */
> >>          tail_call_reachable |=3D tail_call_seen;
> >>
> >> -       emit_prologue(&prog, bpf_prog->aux->stack_depth,
> >> +       emit_prologue(&prog, stack_depth,
> >>                        bpf_prog_was_classic(bpf_prog), tail_call_reach=
able,
> >>                        bpf_is_subprog(bpf_prog), bpf_prog->aux->except=
ion_cb);
> >>          /* Exception callback will clobber callee regs for its own us=
e, and
> >> @@ -1364,6 +1399,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int=
 *addrs, u8 *image, u8 *rw_image
> >>                  emit_mov_imm64(&prog, X86_REG_R12,
> >>                                 arena_vm_start >> 32, (u32) arena_vm_s=
tart);
> >>
> >> +       if (enable_shadow_stack)
> >> +               emit_percpu_shadow_frame_ptr(&prog, shadow_frame_ptr);
> >> +
> >>          ilen =3D prog - temp;
> >>          if (rw_image)
> >>                  memcpy(rw_image + proglen, temp, ilen);
> >> @@ -1383,6 +1421,14 @@ static int do_jit(struct bpf_prog *bpf_prog, in=
t *addrs, u8 *image, u8 *rw_image
> >>                  u8 *func;
> >>                  int nops;
> >>
> >> +               if (enable_shadow_stack) {
> >> +                       if (src_reg =3D=3D BPF_REG_FP)
> >> +                               src_reg =3D X86_REG_R9;
> >> +
> >> +                       if (dst_reg =3D=3D BPF_REG_FP)
> >> +                               dst_reg =3D X86_REG_R9;
> > the verifier will reject a prog that attempts to write into R10.
> > So the above shouldn't be necessary.
>
> Actually there is at least one exception, e.g.,
>    if r10 > r5 goto +5
> where dst is r10 and src r5.

Good point. We even have such a selftest to make sure it's rejected in unpr=
iv.

SEC("socket")
__description("unpriv: cmp of frame pointer")
__success __failure_unpriv __msg_unpriv("R10 pointer comparison")
__retval(0)
__naked void unpriv_cmp_of_frame_pointer(void)
{
        asm volatile ("                                 \
        if r10 =3D=3D 0 goto l0_%=3D;                         \

> >
> >> +               }
> >> +
> >>                  switch (insn->code) {
> >>                          /* ALU */
> >>                  case BPF_ALU | BPF_ADD | BPF_X:
> >> @@ -2014,6 +2060,7 @@ st:                       if (is_imm8(insn->off)=
)
> >>                                  emit_mov_reg(&prog, is64, real_src_re=
g, BPF_REG_0);
> >>                                  /* Restore R0 after clobbering RAX */
> >>                                  emit_mov_reg(&prog, true, BPF_REG_0, =
BPF_REG_AX);
> >> +
> >>                                  break;
> >>                          }
> >>
> >> @@ -2038,14 +2085,20 @@ st:                     if (is_imm8(insn->off)=
)
> >>
> >>                          func =3D (u8 *) __bpf_call_base + imm32;
> >>                          if (tail_call_reachable) {
> >> -                               RESTORE_TAIL_CALL_CNT(bpf_prog->aux->s=
tack_depth);
> >> +                               RESTORE_TAIL_CALL_CNT(stack_depth);
> >>                                  ip +=3D 7;
> >>                          }
> >>                          if (!imm32)
> >>                                  return -EINVAL;
> >> +                       if (enable_shadow_stack) {
> >> +                               EMIT2(0x41, 0x51);
> >> +                               ip +=3D 2;
> >> +                       }
> >>                          ip +=3D x86_call_depth_emit_accounting(&prog,=
 func, ip);
> >>                          if (emit_call(&prog, func, ip))
> >>                                  return -EINVAL;
> >> +                       if (enable_shadow_stack)
> >> +                               EMIT2(0x41, 0x59);
> > push/pop around calls are load/store plus math on %rsp.
> > I think it's cheaper to reload r9 after the call with
> > a single insn.
> > The reload of r9 is effectively gs+const.
> > There is no memory access. So it should be faster.
>
> Two insn may be necessary since __alloc_percpu_gfp()
> may return a pointer beyond 32 bits.
>
> >
> > Technically we can replace all uses of R10=3D=3Drbp with
> > 'gs:' based instructions.
> > Like:
> > r1 =3D r10
> > can be jitted into
> > lea rdi, gs + (u32)shadow_frame_ptr
> >
> > and r0 =3D *(u32 *)(r10 - 64)
> > can be jitted into:
> > mov rax, dword ptr gs:[(u32)shadow_frame_ptr - 64]
> >
> > but that is probably a bunch of jit changes.
> > So I'd start with a simple reload of r9 after each call.
>
> This is a good idea. We might need this so we only have
> one extra insn per call.

Since reload of r9 is a two insn sequence of 64-bit mov immediate,
and load from gs:this_cpu_off, I suspect, push/pop r9
might be faster. So I'd stick to what you have already.

Interesting though that static per-cpu vars have 32-bit pointers,
but dynamic per-cpu alloc returns full 64-bit? hmm.

