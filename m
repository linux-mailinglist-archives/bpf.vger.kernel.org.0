Return-Path: <bpf+bounces-53126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59451A4CE8E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74301884393
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 22:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087E22FF4F;
	Mon,  3 Mar 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB31QIwk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BB235C04
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041642; cv=none; b=lsOErts7O8wm6WtMKRPMYHlRU5c1wvfGP6Uqq8v/a1wK4oZujp31S7dI40pG0aYQgEqQm6M07FI9NTRq/GDOIaOe7+fXNLSD/DLMYYQBdBsVqDBU1Y1zJnUjabBlfrF+VBfO/+prbMifQg+S8iMbrHUpYMebwc2JQkHLkPi9MGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041642; c=relaxed/simple;
	bh=IqgLxeCMlfBdzQki6LnMs2BdOJSR0rECl/dEEWY8VKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikAi26ywnNyj7pRruu1azsh2L+m6mVvFMWTcRE/l2D2cIyK2cUR2MiFIkn7FeU2Y1waNVaZ6qDNol4UluikokXYkkxdAQQf4+zrrm5x3uup5huSqMarTfc74s3zRwr6Y/vD3BOM+cfvcfv5y7jl22FvNT80h+yFS0z89piJR/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB31QIwk; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-abec8b750ebso877216566b.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741041639; x=1741646439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O231FrObHmxXnqZ/jwLjkCWGFZIYFiR4JoLxtX7kZb8=;
        b=jB31QIwksQwqykFOFmDtA45YwmkJPbpiVSC8SW7CZCh49T6Ua0OpkaT1ctn1GHe2+G
         UW0CKgJ+TAD1kpbAtCEJ8ypLXhZSE8L6MzPCzlrJCqDywC8igUYI87sVe3qN/Jou3686
         KWm1E831ulZ0wwCNmbqKrC3W6GOe3KM+o3lVOrtZ/ZQLlltX6af240Iw2NPvHDrtx1J6
         ONoyrfwbWFLPvsbU6uunbHsQHCw8quzkAFMTJTyDEhyz+PNJQaGBzyGkfmjmhqVjCOSK
         YZx18+ZPOoPuWU1PbzawO7pZWFZNnDDacbk8870Jey29QY/NW3jvPQY3YcEPfPoi07m9
         GXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041639; x=1741646439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O231FrObHmxXnqZ/jwLjkCWGFZIYFiR4JoLxtX7kZb8=;
        b=NHXhyrPMaJ8fk5llhbAVwCJfgHj7YfsC2ONwTxsdOrvuhW3RwJhHzAKP6r3mf3ue4c
         Ys6/t3AD6GBEF4gVC8/uUqzkzg2ZazPNPHBAkj4LuB/XohZ1hBpM+Z3AmLuHY3h+Vfst
         87v0kZG7jnW0S8Ek8mqvOmfFyo4BHfoGvTwpLdNVSi/+q3BzX9Fc/eajFXV9q0WLlbsb
         29eqgFWt7X6ACyh1/tJH9XvTY1KVYZ6/dBvb7TeF+Zer9HwzVHFsB+u6TBV3I0XtXiHl
         0/d8zQj0nYZisk6ctZE5rihw5gaNGP243JmgptRL0p8QiIQj/DxnYj2oAkMi0jFwhQDl
         iCXw==
X-Gm-Message-State: AOJu0YzFV207TRmTgh+RGhq0TgdTQk5sKpLwkA4hBD8yUUG7CEv3c5Zv
	poqHURZP7lp4LoLwEukAqYBkGVDXuyxSKIhl4YnzWL5J224twLy2Gpvqintq+bS0WRALZE/Jxya
	XtT38bqYQrwFa4Xh5dQ2cXmdEjxE=
X-Gm-Gg: ASbGncsx4fJv9HazeSq3pcIXB1lXngKRtF8tvjUlm3STjOkRqoQWbC9siFfvNHPyZh4
	8l7Ib0AaXwO6sOnlfd/7TpuED8NKV2Wh1aJxTUxcLHm56ilSYda+Gtp7bsbwcRccwi4gzu3FWPU
	WZw9ko0ZVOjI2fBBAw55omND12rZOLwCKspbdFzNFS8LMpqzk=
X-Google-Smtp-Source: AGHT+IErFqkf5sQ3aAwFYLmJFkNhpsf64Y63KG5hQLU2zK0hW1bAOP2ahWq6gyAbINivdElPF30/GfmD7r+dWLbO9g0=
X-Received: by 2002:a17:907:781:b0:ab7:9df1:e562 with SMTP id
 a640c23a62f3a-abf2682aed4mr1713499166b.48.1741041638324; Mon, 03 Mar 2025
 14:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302201348.940234-1-memxor@gmail.com> <20250302201348.940234-2-memxor@gmail.com>
 <CAADnVQJsW1Nk_yhz=fiAtuDsx-V0vPWZHzVyx25cbVpX+SvOiA@mail.gmail.com> <CAP01T744+9NQEPhjY=4oSB88r-DiL0-SV9Fa_JsOWbJmhA94EA@mail.gmail.com>
In-Reply-To: <CAP01T744+9NQEPhjY=4oSB88r-DiL0-SV9Fa_JsOWbJmhA94EA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 3 Mar 2025 23:40:01 +0100
X-Gm-Features: AQ5f1JovmoQwYvExNhBG8LlSChZh_vixas-twSjNlyOgMHkBcjaL0L8YoWpADC4
Message-ID: <CAP01T74bSfnATGd6mo1p41hKAz=UNpYdmAXWfbcs3uS+M-Q0Pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add verifier support for timed may_goto
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, 
	Dohyun Kim <dohyunkim@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Mar 2025 at 23:25, Kumar Kartikeya Dwivedi <memxor@gmail.com> wro=
te:
>
> On Mon, 3 Mar 2025 at 22:59, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Mar 2, 2025 at 12:13=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Implement support in the verifier for replacing may_goto implementati=
on
> > > from a counter-based approach to one which samples time on the local =
CPU
> > > to have a bigger loop bound.
> > >
> > > We implement it by maintaining 16-bytes per-stack frame, and using 8
> > > bytes for maintaining the count for amortizing time sampling, and 8
> > > bytes for the starting timestamp. To minimize overhead, we need to av=
oid
> > > spilling and filling of registers around this sequence, so we push th=
is
> > > cost into the time sampling function 'arch_bpf_timed_may_goto'. This =
is
> > > a JIT-specific wrapper around bpf_check_timed_may_goto which returns =
us
> > > the count to store into the stack through BPF_REG_AX. All caller-save=
d
> > > registers (r0-r5) are guaranteed to remain untouched.
> > >
> > > The loop can be broken by returning count as 0, otherwise we dispatch
> > > into the function when the count becomes 1, and the runtime chooses t=
o
> > > refresh it (by returning count as BPF_MAX_TIMED_LOOPS) or returning 0
> > > and aborting it.
> > >
> > > Since the check for 0 is done right after loading the count from the
> > > stack, all subsequent cond_break sequences should immediately break a=
s
> > > well.
> > >
> > > We pass in the stack_depth of the count (and thus the timestamp, by
> > > adding 8 to it) to the arch_bpf_timed_may_goto call so that it can be
> > > passed in to bpf_check_timed_may_goto as an argument after r1 is save=
d,
> > > by adding the offset to r10/fp. This adjustment will be arch specific=
,
> > > and the next patch will introduce support for x86.
> > >
> > > Note that depending on loop complexity, time spent in the loop can be
> > > more than the current limit (250 ms), but imposing an upper bound on
> > > program runtime is an orthogonal problem which will be addressed when
> > > program cancellations are supported.
> > >
> > > The current time afforded by cond_break may not be enough for cases
> > > where BPF programs want to implement locking algorithms inline, and u=
se
> > > cond_break as a promise to the verifier that they will eventually
> > > terminate.
> > >
> > > Below are some benchmarking numbers on the time taken per-iteration f=
or
> > > an empty loop that counts the number of iterations until cond_break
> > > fires. For comparison, we compare it against bpf_for/bpf_repeat which=
 is
> > > another way to achieve the same number of spins (BPF_MAX_LOOPS).  The
> > > hardware used for benchmarking was a Saphire Rapids Intel server with
> > > performance governor enabled.
> > >
> > > +-----------------------------+--------------+--------------+--------=
----------+
> > > | Loop type                   | Iterations   |  Time (ms)   |   Time/=
iter (ns) |
> > > +-----------------------------|--------------+--------------+--------=
----------+
> > > | may_goto                    | 8388608      |  3           |   0.36 =
          |
> > > | timed_may_goto (count=3D65535)| 589674932    |  250         |   0.4=
2           |
> > > | bpf_for                     | 8388608      |  10          |   1.19 =
          |
> > > +-----------------------------+--------------+--------------+--------=
----------+
> > >
> > > This gives a good approximation at low overhead while staying close t=
o
> > > the current implementation.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/bpf.h    |  1 +
> > >  include/linux/filter.h |  8 +++++++
> > >  kernel/bpf/core.c      | 31 +++++++++++++++++++++++++
> > >  kernel/bpf/verifier.c  | 52 +++++++++++++++++++++++++++++++++++-----=
--
> > >  4 files changed, 84 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index aec102868b93..788f6ca374e9 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1986,6 +1986,7 @@ struct bpf_array {
> > >   */
> > >  enum {
> > >         BPF_MAX_LOOPS =3D 8 * 1024 * 1024,
> > > +       BPF_MAX_TIMED_LOOPS =3D 0xffff,
> > >  };
> > >
> > >  #define BPF_F_ACCESS_MASK      (BPF_F_RDONLY |         \
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index 3ed6eb9e7c73..02dda5c53d91 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -669,6 +669,11 @@ struct bpf_prog_stats {
> > >         struct u64_stats_sync syncp;
> > >  } __aligned(2 * sizeof(u64));
> > >
> > > +struct bpf_timed_may_goto {
> > > +       u64 count;
> > > +       u64 timestamp;
> > > +};
> > > +
> > >  struct sk_filter {
> > >         refcount_t      refcnt;
> > >         struct rcu_head rcu;
> > > @@ -1130,8 +1135,11 @@ bool bpf_jit_supports_ptr_xchg(void);
> > >  bool bpf_jit_supports_arena(void);
> > >  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
> > >  bool bpf_jit_supports_private_stack(void);
> > > +bool bpf_jit_supports_timed_may_goto(void);
> > >  u64 bpf_arch_uaddress_limit(void);
> > >  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u6=
4 sp, u64 bp), void *cookie);
> > > +u64 arch_bpf_timed_may_goto(void);
> > > +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
> > >  bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
> > >
> > >  static inline bool bpf_dump_raw_ok(const struct cred *cred)
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index a0200fbbace9..b3f7c7bd08d3 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -3069,6 +3069,37 @@ void __weak arch_bpf_stack_walk(bool (*consume=
_fn)(void *cookie, u64 ip, u64 sp,
> > >  {
> > >  }
> > >
> > > +bool __weak bpf_jit_supports_timed_may_goto(void)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > > +u64 __weak arch_bpf_timed_may_goto(void)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
> > > +{
> > > +       u64 time =3D ktime_get_mono_fast_ns();
> >
> > let's move the call after !p->count check to avoid unused work.
> >
>
> Ok.
>
> > > +
> > > +       /* If the count is zero, we've already broken a prior loop in=
 this stack
> > > +        * frame, let's just exit quickly.
> > > +        */
> >
> > Let's use normal kernel comment style in all new code.
> > I think even netdev folks allow both styles now.
> >
>
> Ack.
>
> > > +       if (!p->count)
> > > +               return 0;
> > > +       /* Populate the timestamp for this stack frame. */
> > > +       if (!p->timestamp) {
> > > +               p->timestamp =3D time;
> > > +               return BPF_MAX_TIMED_LOOPS;
> > > +       }
> > > +       /* Check if we've exhausted our time slice. */
> > > +       if (time - p->timestamp >=3D (NSEC_PER_SEC / 4))
> > > +               return 0;
> > > +       /* Refresh the count for the stack frame. */
> > > +       return BPF_MAX_TIMED_LOOPS;
> > > +}
> > > +
> > >  /* for configs without MMU or 32-bit */
> > >  __weak const struct bpf_map_ops arena_map_ops;
> > >  __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index dcd0da4e62fc..79bfb1932f40 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -21503,7 +21503,34 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> > >                         goto next_insn;
> > >                 }
> > >
> > > -               if (is_may_goto_insn(insn)) {
> > > +               if (is_may_goto_insn(insn) && bpf_jit_supports_timed_=
may_goto()) {
> > > +                       int stack_off_cnt =3D -stack_depth - 16;
> > > +
> > > +                       /* Two 8 byte slots, depth-16 stores the coun=
t, and
> > > +                        * depth-8 stores the start timestamp of the =
loop.
> > > +                        */
> > > +                       stack_depth_extra =3D 16;
> > > +                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_A=
X, BPF_REG_10, stack_off_cnt);
> > > +                       if (insn->off >=3D 0)
> > > +                               insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, =
BPF_REG_AX, 0, insn->off + 5);
> > > +                       else
> > > +                               insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, =
BPF_REG_AX, 0, insn->off - 1);
> > > +                       insn_buf[2] =3D BPF_ALU64_IMM(BPF_SUB, BPF_RE=
G_AX, 1);
> > > +                       insn_buf[3] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_=
AX, 1, 2);
> >
> > Maybe !=3D 0 instead ?
> > Otherwise it's off by 1.
>
> We'll never do the sub with AX=3D0, we'll always break out in that case.
> It starts at 0xffff, so when it's 2 in stack, and 1 on subtraction, we
> will do the call.
> This resets it to 0xffff or 0.
>
> But it's late and I could be missing something.

Which means we will never see p->count as 0 in
bpf_check_timed_may_goto, since we'll go through the first condition
checking ax to be 0, so I will just remove that condition from the
function.

>
> >
> > > +                       insn_buf[4] =3D BPF_MOV64_IMM(BPF_REG_AX, sta=
ck_off_cnt);
> >
> > Please add a comment that BPF_REG_AX is used as an argument
> > register and contains return value too.
>
> Ok, will do.
>
> >
> > I looked at a couple other non-x86 JITs and I think this calling
> > convention should work for them too.
> >
> > > +                       insn_buf[5] =3D BPF_RAW_INSN(BPF_JMP | BPF_CA=
LL, 0, 0, 0, BPF_CALL_IMM(arch_bpf_timed_may_goto));
> >
> > Use BPF_EMIT_CALL() instead?
> >
>
> Ack.
>
> > > [...]

