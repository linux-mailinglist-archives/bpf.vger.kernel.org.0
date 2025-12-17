Return-Path: <bpf+bounces-76892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364ACC9443
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2114303A738
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF8E33C1BF;
	Wed, 17 Dec 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB7G7XyJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531233B97D
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995224; cv=none; b=mYnhCjRWqrzDKp7qHdzTZEui0wccJbWKBx/q1ip7UKs51osRPGLdvEM30q/HzvULGOEcQkybkY7QjycFJYgiYziin7ztrQ/0qt/lCDcShFYZVLcP8+DL+MqZn74EKtkN11jnlXuK81D2JziwA0/F14wbSWcw5EnlzKxRx5e96HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995224; c=relaxed/simple;
	bh=hOihr4gCEyMrhfE/5QLNZU3ngeMsmPu2ZoalUdWPF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zke2WtF8n8fRubwmM+YggMNHhSj+2ICMDAOujop4VRLmnApybaOraiWF4xFxwyVkOQKOn4F9A+YzewVKHE4i+2VL7UYoJnL3z4TUROGlnKgVBIJfBFw4GRXQky3NOjvwC0roga5HpDLBOTdrxtUG5qkYQ6t0LaFCI3KpJhSEuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB7G7XyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474BBC4CEFB
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765995224;
	bh=hOihr4gCEyMrhfE/5QLNZU3ngeMsmPu2ZoalUdWPF/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZB7G7XyJYgPpDHLzeaUCHK9ronYQ7Y7k+zR7UBAJapomfV5nghlweQ2I80oP3XHaP
	 Qi1Cjg/df+5KWMnGE4iG7Xv/pxB629cxvrhEzV09B4efzW6tCFSuVOUuUSbtD/8JD7
	 xO/XPhqts6b76us9IxLPi5K2JmhHtUCWcvPXCZ20lLiB72fQr3qDVlBAQX8QVupWHy
	 xRGqbBlpj8KaQ5XRWCdVYFguP5tc2mAKBWtXbo2RiEjSCgHTAWIUt9ZfY8nCnpKhA8
	 /14HHO+nS80QvM2DjnwNwjO0v/I5DolbN22RL0hWDBZqT9oZXKOdkCkKdaOwv/86bM
	 ZYg+Ohi2bA3IA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6498a6f8ab4so9401138a12.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 10:13:44 -0800 (PST)
X-Gm-Message-State: AOJu0YxOdR18P1W+F3KCtaG1/v7hXPSZ0GOPF4KgxWvplICZwEXKQVSK
	O2559RlDHlbsHcUE/89WLP2tGxGEaND1r/nd/EJkOAH/RuVz2l77UuX/fr+2icxGmMz41VOvcuw
	ESGfwRzbKMbpBVtgV4ZPGPb45E/rmsJc=
X-Google-Smtp-Source: AGHT+IEhSkSchqPstPJIPXpPn/eKPQmOP0KQAc/JHCHvM8T7cryYL+WcPfKUnw9WwfmX6rK9v8Mo7Y1I0cvCUTO9jHc=
X-Received: by 2002:a05:6402:2546:b0:64b:4239:9339 with SMTP id
 4fb4d7f45d1cf-64b4239955emr3137590a12.17.1765995222735; Wed, 17 Dec 2025
 10:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217162830.2597286-3-puranjay@kernel.org> <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
In-Reply-To: <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 17 Dec 2025 18:13:29 +0000
X-Gmail-Original-Message-ID: <CANk7y0h4JO2-tp9HjRHjcQdTOgmRSsw0rxmK-=G89AVY92U8Jw@mail.gmail.com>
X-Gm-Features: AQt7F2r2iMDKsMir3bPUYrXqtdPNxdo3VdHVQSgznCRPODB9OLKwveKSLu1fEgw
Message-ID: <CANk7y0h4JO2-tp9HjRHjcQdTOgmRSsw0rxmK-=G89AVY92U8Jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, kernel-team@meta.com, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 4:56=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 2da986136d26..654fb94bf60c 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
>
> [ ... ]
>
> > @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> >
> >  static inline bool bpf_prog_get_recursion_context(struct bpf_prog *pro=
g)
> >  {
> > +#ifdef CONFIG_ARM64
> > +     u8 rctx =3D interrupt_context_level();
> > +     u8 *active =3D this_cpu_ptr(prog->active);
> > +
> > +     active[rctx]++;
> > +     barrier();
> > +     if (get_unaligned_le32(active) !=3D BIT(rctx * 8))
> > +             return false;
> > +
> > +     return true;
> > +#else
> >       return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> > +#endif
> >  }
>
> Can preemption between the increment and check cause a counter leak on
> CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
> rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
> (documented at include/linux/rcupdate.h:856).
>
> Consider this scenario on an ARM64 system with PREEMPT_RCU:
>
> 1. Thread A increments active[0] to 1
> 2. Preemption occurs before Thread A reaches the check
> 3. Thread B on same CPU increments active[0] to 2
> 4. Thread B checks: sees 2 !=3D BIT(0), returns false
> 5. Thread A resumes, checks: sees 2 !=3D BIT(0), returns false
> 6. Both threads return false, neither runs BPF
> 7. Neither calls bpf_prog_put_recursion_context() (see
>    __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> 8. Counter permanently stuck at 2, all future BPF on this CPU fails

Step 7 is incorrect. Looking at the JIT-generated code, the exit
function is ALWAYS called, regardless of whether the enter function
returns 0 or a start time:

  // x86 JIT at arch/x86/net/bpf_jit_comp.c:2998-3050
  call bpf_trampoline_enter()    // Line 2998
  test rax, rax                   // Line 3006
  je skip_exec                    // Conditional jump
  ... BPF program execution ...   // Lines 3011-3023
  skip_exec:                      // Line 3037 (jump lands here)
  call bpf_trampoline_exit()      // Line 3049 - ALWAYS executed

  The bpf_trampoline_exit() call is after the skip_exec label, so it
executes in both cases.

What Actually Happens:

  Initial state: active[0] =3D 0

  Thread A (normal context, rctx=3D0):
  1. active[0]++ =E2=86=92 active[0] =3D 1
  2. Preempted before barrier()

  Thread B (scheduled on same CPU, normal context, rctx=3D0):
  3. active[0]++ =E2=86=92 active[0] =3D 2
  4. barrier()
  5. get_unaligned_le32(active) =E2=86=92 reads 0x00000002
  6. Check: 0x00000002 !=3D BIT(0) =3D 0x00000001 =E2=86=92 returns false
  7. __bpf_prog_enter_recur returns 0
  8. JIT checks return value, skips BPF execution
  9. JIT ALWAYS calls __bpf_prog_exit_recur (see
arch/arm64/net/bpf_jit_comp.c:2362)
  10. bpf_prog_put_recursion_context(prog) executes
  11. barrier(), active[0]-- =E2=86=92 active[0] =3D 1

  Thread A resumes:
  12. barrier()
  13. get_unaligned_le32(active) =E2=86=92 reads 0x00000001 (Thread B alrea=
dy
decremented!)
  14. Check: 0x00000001 =3D=3D BIT(0) =3D 0x00000001 =E2=86=92 returns true=
 =E2=9C=93
  15. __bpf_prog_enter_recur returns start_time
  16. BPF program executes
  17. __bpf_prog_exit_recur called
  18. bpf_prog_put_recursion_context(prog) executes
  19. barrier(), active[0]-- =E2=86=92 active[0] =3D 0 =E2=9C=93

  Final State

  - Counter returns to 0 =E2=9C=93
  - No leak =E2=9C=93
  - Thread B detected interference and aborted =E2=9C=93
  - Thread A executed successfully =E2=9C=93
  - Only ONE thread executed the BPF program =E2=9C=93


Now that I think of it, there is another race condition that leads to
NEITHER program running:

Consider this scenario on an arm64 system with PREEMPT_RCU:

1. Thread A increments active[0] from 0 to 1
2. Thread A is preempted before reaching barrier()
3. Thread B (same CPU, same context) increments active[0] from 1 to 2
4. Thread B executes barrier() and checks: sees 2 !=3D BIT(0), returns fals=
e
5. Thread A resumes, executes barrier() and checks: sees 2 !=3D BIT(0),
returns false
6. Both threads return false to __bpf_prog_enter_recur()
7. Both skip BPF program execution
8. Both call bpf_prog_put_recursion_context() and decrement: 2->1->0
9. Neither BPF program executes, but the counter correctly returns to 0

This means the patch is changing the behaviour in case of recursion
from "One program gets to run" to
"At most one program gets to run", but given the performance benefits,
I think we can accept this change.
I am not sure what would change in reality if we allow both BPF
programs to be skipped in case of high interleaving
like above.

> The old atomic code handled this correctly because this_cpu_inc_return()
> completes atomically, ensuring Thread A reads the value 1 before Thread B
> can interfere. With non-atomic operations, Thread A increments but hasn't
> read the value yet, allowing Thread B to interfere and cause both threads
> to see the modified value.
>
> Is there a guarantee that same-context preemption cannot occur in the BPF
> execution path on ARM64, or does this need additional synchronization?
>
> > @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> >
> >  static inline void bpf_prog_put_recursion_context(struct bpf_prog *pro=
g)
> >  {
> > +#ifdef CONFIG_ARM64
> > +     u8 rctx =3D interrupt_context_level();
> > +     u8 *active =3D this_cpu_ptr(prog->active);
> > +
> > +     barrier();
> > +     active[rctx]--;
> > +#else
> >       this_cpu_dec(*(prog->active));
> > +#endif
> >  }
>
> The barrier() is placed before the decrement. Does this provide the neede=
d
> ordering guarantee, or should there also be a barrier after the decrement
> to ensure visibility?
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index c66316e32563..b5063acfcf92 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
>
> [ ... ]
>
> > @@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned i=
nt size, gfp_t gfp_extra_flag
> >               vfree(fp);
> >               return NULL;
> >       }
> > -     fp->active =3D alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL |=
 gfp_extra_flags));
> > +     fp->active =3D __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), 8,
> > +                                     bpf_memcg_flags(GFP_KERNEL | gfp_=
extra_flags));
>
> The allocation changes to u8[4] for all architectures, but the non-ARM64
> code path still uses *(prog->active) which now dereferences only the firs=
t
> byte. This changes the counter from int (typically 4 bytes, range ~2^31)
> to u8 (1 byte, range 256). While 256 recursion levels is sufficient in
> practice, is this intentional for non-ARM64 platforms, or should they
> continue using a full int-sized allocation?

This was intentional so that we don't add another #ifdef here, 256
recursion levels are more than enough.
But to keep the previous recursion levels, I could change the non
ARM64 code to do something like:

this_cpu_dec(*(int __percpu *)(prog->active));

I can do this in the next version.

Thanks,
Puranjay

