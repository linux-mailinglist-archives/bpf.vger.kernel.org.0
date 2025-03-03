Return-Path: <bpf+bounces-53123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0525A4CE43
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60301886F5F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2A1F0E5B;
	Mon,  3 Mar 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f86n/eIP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CE11CA9
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040779; cv=none; b=szKRMapfoMHRA5+KQ1pIwaYr5yv6FcsEbUyAWto+ijfGdCwRQCU9SpFBb+38HbCGFfUwmS1Epa7eC4g73u/Nx9Sgozlx7PqjtjPETv5yttnnvn4CCPqvE47q8rzegdurc/LW3wzQtqpYtC1hYTA7NVBWBxjuU2DvZysSfn1B6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040779; c=relaxed/simple;
	bh=X4Jf9to7dKrXAPsFukJcvUf2XI9iyIYSOROGpka1q4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atthhRCYxe7wG2NlI65HQwH94VqRIQUh2GNCWIuin4wXpxQWovgiRSJMYO9/xaVrrTefDqL2q4XJukH4/mYmJr6P58tL6j6pKCtl74tkswT+7b6PcmshtoNMB+OBA5rINkHQ5Z+a3YtBZtuPKPWjkJ/I9o7WwT2ed3NcAVGVlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f86n/eIP; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so7642647a12.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741040776; x=1741645576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bHE2Frbqa6XDGSNV6trXktVlblWMPTe3w+P+xMwZ7M=;
        b=f86n/eIPFIuLFEArgKdhO4i2SlouCRElzgREGYsrrj2pf4fxE6D5C/DMeJfbzlsvqS
         vANBd8m+py07ugspq/8zTgGr4AvXPK6cOXu+iEOX1MQP45pILEcFEJcDicPmQkmMnwSq
         YF1UAqrJJYkL2EyFCaC+K6bdZOqt+nk5VAXWwJXokVm6+N2ZEX4gSxF0xnk/dO+hfTil
         cHP+z0k4NmmPBA9gkUnK+QLWloHlPox0VtcNxQCtCxfB/DNsRZKd/upB/G4ewjnXOTLl
         qLii68+1+4Os8NdEck2lJEK6iajxoPtfTHrTVD00fPTTPsV68FB/ekWD6v8ZDQw92g30
         /eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040776; x=1741645576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bHE2Frbqa6XDGSNV6trXktVlblWMPTe3w+P+xMwZ7M=;
        b=BWnh5Ua2zfEcU956f8L81zKRG/MfJkSBRUIgocV3Wef/iqnWAD9IOU/0W0GPq8h5zh
         sFazkAPfb3q4uThfqwlJ0LIQHedwMdg+VFTMirifuJminkfbL+BZfPFvDNFkbbhA5RZF
         x/SYoPKIoQI7mAHS5N2/lTpTdxvHD+xUwV2GQC2sgyXzm19B5tnPGD9nooXXpnS8XUE0
         2Xj5t3X77NR4c6DnotmHLOyE+DKpw9Jws+GCuCrJlC/JQY+IrNI5LwMvp/DwrFUYb5/A
         hvgtFuQ1v5sDynho8XEWcLyidWHA3jcYhYym+S2Blj0ooRT1jmogiknAnA7ny+EF5REO
         nPMA==
X-Gm-Message-State: AOJu0YzUzJ8Z9ICxvNqfbdlybieR+JdG2LWgKdYyCHUb8ueI0rMhBiFx
	EDJBfLVHldDeg5bBG4VO6KcuQubnqfe1NY8g3keJVUeDe5bhvJBBfcvPItBYzmmLThFtUfLsSEE
	4q2OqHwDW7Am3Qj2krDPZEf5l6fg=
X-Gm-Gg: ASbGncujQDm0CVT23VQLBYN3BSJdmc5Xn/r17/0ElrQXs8zyUczL0VhjWZB7+YKiXLU
	onRrfp6VJyq+2ip/56NQvnhDQdOWF3VPA5kg+E1ntP8m9h89yjAo/9LzJ+0/r1Pmei4osLFCDm5
	Enzp2YfgK/UsqDs702+j2O4M1sW5dBbRN4u+hZtidU90s0p5o=
X-Google-Smtp-Source: AGHT+IGaFHxyXglrUg5RrVJhRQz2R8bm1E4SWppH0gSDT/93HkZfX0M+ch7wQzt5ZOd5wST6I3/jWf2c4L5+8gjwscw=
X-Received: by 2002:a05:6402:270f:b0:5e4:ce6e:3885 with SMTP id
 4fb4d7f45d1cf-5e4d6ad469emr17095511a12.2.1741040775304; Mon, 03 Mar 2025
 14:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302201348.940234-1-memxor@gmail.com> <20250302201348.940234-2-memxor@gmail.com>
 <CAADnVQJsW1Nk_yhz=fiAtuDsx-V0vPWZHzVyx25cbVpX+SvOiA@mail.gmail.com>
In-Reply-To: <CAADnVQJsW1Nk_yhz=fiAtuDsx-V0vPWZHzVyx25cbVpX+SvOiA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 3 Mar 2025 23:25:38 +0100
X-Gm-Features: AQ5f1JoR3Dj-jUBcRx36PnHm_tOBAK8GjkrTLT9a0AOgtogclRxDJkuZc9vSOq0
Message-ID: <CAP01T744+9NQEPhjY=4oSB88r-DiL0-SV9Fa_JsOWbJmhA94EA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add verifier support for timed may_goto
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Mar 2025 at 22:59, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Mar 2, 2025 at 12:13=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Implement support in the verifier for replacing may_goto implementation
> > from a counter-based approach to one which samples time on the local CP=
U
> > to have a bigger loop bound.
> >
> > We implement it by maintaining 16-bytes per-stack frame, and using 8
> > bytes for maintaining the count for amortizing time sampling, and 8
> > bytes for the starting timestamp. To minimize overhead, we need to avoi=
d
> > spilling and filling of registers around this sequence, so we push this
> > cost into the time sampling function 'arch_bpf_timed_may_goto'. This is
> > a JIT-specific wrapper around bpf_check_timed_may_goto which returns us
> > the count to store into the stack through BPF_REG_AX. All caller-saved
> > registers (r0-r5) are guaranteed to remain untouched.
> >
> > The loop can be broken by returning count as 0, otherwise we dispatch
> > into the function when the count becomes 1, and the runtime chooses to
> > refresh it (by returning count as BPF_MAX_TIMED_LOOPS) or returning 0
> > and aborting it.
> >
> > Since the check for 0 is done right after loading the count from the
> > stack, all subsequent cond_break sequences should immediately break as
> > well.
> >
> > We pass in the stack_depth of the count (and thus the timestamp, by
> > adding 8 to it) to the arch_bpf_timed_may_goto call so that it can be
> > passed in to bpf_check_timed_may_goto as an argument after r1 is saved,
> > by adding the offset to r10/fp. This adjustment will be arch specific,
> > and the next patch will introduce support for x86.
> >
> > Note that depending on loop complexity, time spent in the loop can be
> > more than the current limit (250 ms), but imposing an upper bound on
> > program runtime is an orthogonal problem which will be addressed when
> > program cancellations are supported.
> >
> > The current time afforded by cond_break may not be enough for cases
> > where BPF programs want to implement locking algorithms inline, and use
> > cond_break as a promise to the verifier that they will eventually
> > terminate.
> >
> > Below are some benchmarking numbers on the time taken per-iteration for
> > an empty loop that counts the number of iterations until cond_break
> > fires. For comparison, we compare it against bpf_for/bpf_repeat which i=
s
> > another way to achieve the same number of spins (BPF_MAX_LOOPS).  The
> > hardware used for benchmarking was a Saphire Rapids Intel server with
> > performance governor enabled.
> >
> > +-----------------------------+--------------+--------------+----------=
--------+
> > | Loop type                   | Iterations   |  Time (ms)   |   Time/it=
er (ns) |
> > +-----------------------------|--------------+--------------+----------=
--------+
> > | may_goto                    | 8388608      |  3           |   0.36   =
        |
> > | timed_may_goto (count=3D65535)| 589674932    |  250         |   0.42 =
          |
> > | bpf_for                     | 8388608      |  10          |   1.19   =
        |
> > +-----------------------------+--------------+--------------+----------=
--------+
> >
> > This gives a good approximation at low overhead while staying close to
> > the current implementation.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h    |  1 +
> >  include/linux/filter.h |  8 +++++++
> >  kernel/bpf/core.c      | 31 +++++++++++++++++++++++++
> >  kernel/bpf/verifier.c  | 52 +++++++++++++++++++++++++++++++++++-------
> >  4 files changed, 84 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index aec102868b93..788f6ca374e9 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1986,6 +1986,7 @@ struct bpf_array {
> >   */
> >  enum {
> >         BPF_MAX_LOOPS =3D 8 * 1024 * 1024,
> > +       BPF_MAX_TIMED_LOOPS =3D 0xffff,
> >  };
> >
> >  #define BPF_F_ACCESS_MASK      (BPF_F_RDONLY |         \
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 3ed6eb9e7c73..02dda5c53d91 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -669,6 +669,11 @@ struct bpf_prog_stats {
> >         struct u64_stats_sync syncp;
> >  } __aligned(2 * sizeof(u64));
> >
> > +struct bpf_timed_may_goto {
> > +       u64 count;
> > +       u64 timestamp;
> > +};
> > +
> >  struct sk_filter {
> >         refcount_t      refcnt;
> >         struct rcu_head rcu;
> > @@ -1130,8 +1135,11 @@ bool bpf_jit_supports_ptr_xchg(void);
> >  bool bpf_jit_supports_arena(void);
> >  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
> >  bool bpf_jit_supports_private_stack(void);
> > +bool bpf_jit_supports_timed_may_goto(void);
> >  u64 bpf_arch_uaddress_limit(void);
> >  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 =
sp, u64 bp), void *cookie);
> > +u64 arch_bpf_timed_may_goto(void);
> > +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
> >  bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
> >
> >  static inline bool bpf_dump_raw_ok(const struct cred *cred)
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index a0200fbbace9..b3f7c7bd08d3 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -3069,6 +3069,37 @@ void __weak arch_bpf_stack_walk(bool (*consume_f=
n)(void *cookie, u64 ip, u64 sp,
> >  {
> >  }
> >
> > +bool __weak bpf_jit_supports_timed_may_goto(void)
> > +{
> > +       return false;
> > +}
> > +
> > +u64 __weak arch_bpf_timed_may_goto(void)
> > +{
> > +       return 0;
> > +}
> > +
> > +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
> > +{
> > +       u64 time =3D ktime_get_mono_fast_ns();
>
> let's move the call after !p->count check to avoid unused work.
>

Ok.

> > +
> > +       /* If the count is zero, we've already broken a prior loop in t=
his stack
> > +        * frame, let's just exit quickly.
> > +        */
>
> Let's use normal kernel comment style in all new code.
> I think even netdev folks allow both styles now.
>

Ack.

> > +       if (!p->count)
> > +               return 0;
> > +       /* Populate the timestamp for this stack frame. */
> > +       if (!p->timestamp) {
> > +               p->timestamp =3D time;
> > +               return BPF_MAX_TIMED_LOOPS;
> > +       }
> > +       /* Check if we've exhausted our time slice. */
> > +       if (time - p->timestamp >=3D (NSEC_PER_SEC / 4))
> > +               return 0;
> > +       /* Refresh the count for the stack frame. */
> > +       return BPF_MAX_TIMED_LOOPS;
> > +}
> > +
> >  /* for configs without MMU or 32-bit */
> >  __weak const struct bpf_map_ops arena_map_ops;
> >  __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index dcd0da4e62fc..79bfb1932f40 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21503,7 +21503,34 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         goto next_insn;
> >                 }
> >
> > -               if (is_may_goto_insn(insn)) {
> > +               if (is_may_goto_insn(insn) && bpf_jit_supports_timed_ma=
y_goto()) {
> > +                       int stack_off_cnt =3D -stack_depth - 16;
> > +
> > +                       /* Two 8 byte slots, depth-16 stores the count,=
 and
> > +                        * depth-8 stores the start timestamp of the lo=
op.
> > +                        */
> > +                       stack_depth_extra =3D 16;
> > +                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX,=
 BPF_REG_10, stack_off_cnt);
> > +                       if (insn->off >=3D 0)
> > +                               insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BP=
F_REG_AX, 0, insn->off + 5);
> > +                       else
> > +                               insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BP=
F_REG_AX, 0, insn->off - 1);
> > +                       insn_buf[2] =3D BPF_ALU64_IMM(BPF_SUB, BPF_REG_=
AX, 1);
> > +                       insn_buf[3] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX=
, 1, 2);
>
> Maybe !=3D 0 instead ?
> Otherwise it's off by 1.

We'll never do the sub with AX=3D0, we'll always break out in that case.
It starts at 0xffff, so when it's 2 in stack, and 1 on subtraction, we
will do the call.
This resets it to 0xffff or 0.

But it's late and I could be missing something.

>
> > +                       insn_buf[4] =3D BPF_MOV64_IMM(BPF_REG_AX, stack=
_off_cnt);
>
> Please add a comment that BPF_REG_AX is used as an argument
> register and contains return value too.

Ok, will do.

>
> I looked at a couple other non-x86 JITs and I think this calling
> convention should work for them too.
>
> > +                       insn_buf[5] =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL=
, 0, 0, 0, BPF_CALL_IMM(arch_bpf_timed_may_goto));
>
> Use BPF_EMIT_CALL() instead?
>

Ack.

> > [...]

