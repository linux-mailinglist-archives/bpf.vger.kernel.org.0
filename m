Return-Path: <bpf+bounces-77164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06FCD0F57
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC9DA30CECE2
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CB342538;
	Fri, 19 Dec 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hseb6uVW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33F33CEA5
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766162464; cv=none; b=HFYSMYaA8A/6YVjmcIjxKjMVpuYX3n0+FH9GAxr3VSQkuf21piGjVDnflJTuDJ7WZx8X9wazI5pWErGwIdrrO9B/dOXiolFpqSeu4Nm/9uv9YnxHD/0JNrMFztcl1kgxKcqxByAiytV3BHJ8otdpzr6G+lkQeMzk/dGZnH590c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766162464; c=relaxed/simple;
	bh=PlNgCFLWP1sflSNg7tigi2WDl62KM7a41QAwKhaVpaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIfCquk7UYggqivUmPyUGSJQgj7IjM1z4Dfe84wSQ6sh7ZiridIXvILv/tFrOzPeBgx1lysHR4Rd/9g+wEEG8Aud2DQbwlO55mZ60It5YbF4EDnxDTQSbx22b/rlPVznpxB5yvKK8o1gAi9d+dTiWPdRyXqQ7jGIM2yCcf4yFVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hseb6uVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DAEC4AF0B
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766162463;
	bh=PlNgCFLWP1sflSNg7tigi2WDl62KM7a41QAwKhaVpaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hseb6uVWoB7IAkj1OJ8DsM/ePVhzU815GZwAZd6C1JXgAP1CsKyWopo/Q2RVRlz7a
	 6splEHqWI3ttNkhTuyv+Uu4KMIKr01JoZw2pAhqrPTnNLcgYr8vS+0bsyWH7l+I3MK
	 l0r0lQ9qIJcJKJRP0q4FTsRrmHui2UeASTCYoRRMHaH39J3m6da0fLRQqV2fijMFqb
	 WJvEDeycLr6q1OsOjv8bDT9nVQfiPeXxg+iNodWolLh350ggCx1ZoF5DANPlB1Xq/A
	 SPE/uA2cW3F/dvxw5LlqPgU64BSJe+7DtMkcvAVoCDUME6b8PyLl/Ozjfhijpe/CXv
	 ZaDONJL0MVd1Q==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so729138a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 08:41:03 -0800 (PST)
X-Gm-Message-State: AOJu0YyoFWNw7PRWw/ICcRUoBZLx+OdtTtvHtiwUeCqnBuYaJT0uWRil
	gmIocDV9dciB72bDv3hmo8gFQ+Owx/9YR+hSSRvEmBYTVqOFFPgKE7t9Cdu0ZFMgp6o133BGp9u
	UsJJyQTyw/i56z8I4dSUauuevxplnRdg=
X-Google-Smtp-Source: AGHT+IG3JMxK9+f+aKtrDqj92Mm3pfwAOTLKaX5/1tmaxUvKOPQ5vMBzAhZsVwGvZtA4hozbU/aji1fgU4Fj+OoHJUU=
X-Received: by 2002:a05:6402:1d55:b0:64b:4540:ef94 with SMTP id
 4fb4d7f45d1cf-64b8eb618d0mr2880511a12.21.1766162462076; Fri, 19 Dec 2025
 08:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217233608.2374187-1-puranjay@kernel.org> <20251217233608.2374187-3-puranjay@kernel.org>
 <1728d4e1-ce5c-476e-b057-b8a9a7621e1b@linux.dev>
In-Reply-To: <1728d4e1-ce5c-476e-b057-b8a9a7621e1b@linux.dev>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Fri, 19 Dec 2025 16:40:45 +0000
X-Gmail-Original-Message-ID: <CANk7y0gRJ4u-R+Pzv9M1LTJtRgTR+BxxFJia8q_u0cY-kM0JzA@mail.gmail.com>
X-Gm-Features: AQt7F2rvl-ovAXOzmsq69b_3L79BATrKKY5QTW4qNzx-IhMT7QjvWwyYryCPIJ0
Message-ID: <CANk7y0gRJ4u-R+Pzv9M1LTJtRgTR+BxxFJia8q_u0cY-kM0JzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: arm64: Optimize recursion detection
 by not using atomics
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:56=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 12/17/25 3:35 PM, Puranjay Mohan wrote:
> > BPF programs detect recursion using a per-CPU 'active' flag in struct
> > bpf_prog. The trampoline currently sets/clears this flag with atomic
> > operations.
> >
> > On some arm64 platforms (e.g., Neoverse V2 with LSE), per-CPU atomic
> > operations are relatively slow. Unlike x86_64 - where per-CPU updates
> > can avoid cross-core atomicity, arm64 LSE atomics are always atomic
> > across all cores, which is unnecessary overhead for strictly per-CPU
> > state.
> >
> > This patch removes atomics from the recursion detection path on arm64 b=
y
> > changing 'active' to a per-CPU array of four u8 counters, one per
> > context: {NMI, hard-irq, soft-irq, normal}. The running context uses a
> > non-atomic increment/decrement on its element.  After increment,
> > recursion is detected by reading the array as a u32 and verifying that
> > only the expected element changed; any change in another element
> > indicates inter-context recursion, and a value > 1 in the same element
> > indicates same-context recursion.
> >
> > For example, starting from {0,0,0,0}, a normal-context trigger changes
> > the array to {0,0,0,1}.  If an NMI arrives on the same CPU and triggers
> > the program, the array becomes {1,0,0,1}. When the NMI context checks
> > the u32 against the expected mask for normal (0x00000001), it observes
> > 0x01000001 and correctly reports recursion. Same-context recursion is
> > detected analogously.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>
> LGTM with a few nits below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   include/linux/bpf.h | 33 ++++++++++++++++++++++++++++++---
> >   kernel/bpf/core.c   |  3 ++-
> >   2 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 2da986136d26..5ca2a761d9a1 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -31,6 +31,7 @@
> >   #include <linux/static_call.h>
> >   #include <linux/memcontrol.h>
> >   #include <linux/cfi.h>
> > +#include <linux/unaligned.h>
> >   #include <asm/rqspinlock.h>
> >
> >   struct bpf_verifier_env;
> > @@ -1746,6 +1747,8 @@ struct bpf_prog_aux {
> >       struct bpf_map __rcu *st_ops_assoc;
> >   };
> >
> > +#define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NM=
I */
> > +
> >   struct bpf_prog {
> >       u16                     pages;          /* Number of allocated pa=
ges */
> >       u16                     jited:1,        /* Is our filter JIT'ed? =
*/
> > @@ -1772,7 +1775,7 @@ struct bpf_prog {
> >               u8 tag[BPF_TAG_SIZE];
> >       };
> >       struct bpf_prog_stats __percpu *stats;
> > -     int __percpu            *active;
> > +     u8 __percpu             *active;        /* u8[BPF_NR_CONTEXTS] fo=
r rerecursion protection */
> >       unsigned int            (*bpf_func)(const void *ctx,
> >                                           const struct bpf_insn *insn);
> >       struct bpf_prog_aux     *aux;           /* Auxiliary fields */
> > @@ -2006,12 +2009,36 @@ struct bpf_struct_ops_common_value {
> >
> >   static inline bool bpf_prog_get_recursion_context(struct bpf_prog *pr=
og)
> >   {
> > -     return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> > +#ifdef CONFIG_ARM64
> > +     u8 rctx =3D interrupt_context_level();
> > +     u8 *active =3D this_cpu_ptr(prog->active);
> > +     u32 val;
> > +
> > +     preempt_disable();
> > +     active[rctx]++;
> > +     val =3D get_unaligned_le32(active);
>
> The 'active' already aligned with 8 (or 4 with my below suggestion).
> The get_unaligned_le32() works, but maybe we could use le32_to_cpu()
> instead. Maybe there is no performance difference between
> get_unaligned_le32() and le32_to_cpu() so you pick get_unaligned_le32()?
> It would be good to clarify in commit message if get_unaligned_le32()
> is used.
>
> > +     preempt_enable();
> > +     if (val !=3D BIT(rctx * 8))
> > +             return false;
> > +
> > +     return true;
> > +#else
> > +     return this_cpu_inc_return(*(int __percpu *)(prog->active)) =3D=
=3D 1;
> > +#endif
> >   }
> >
> >   static inline void bpf_prog_put_recursion_context(struct bpf_prog *pr=
og)
> >   {
> > -     this_cpu_dec(*(prog->active));
> > +#ifdef CONFIG_ARM64
> > +     u8 rctx =3D interrupt_context_level();
> > +     u8 *active =3D this_cpu_ptr(prog->active);
> > +
> > +     preempt_disable();
> > +     active[rctx]--;
> > +     preempt_enable();
> > +#else
> > +     this_cpu_dec(*(int __percpu *)(prog->active));
> > +#endif
> >   }
> >
> >   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index c66316e32563..b5063acfcf92 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
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
> Here, the alignment is 8. Can it be 4 since the above reads a 32bit value=
?

Yes, It should be 4. Will change in next version and add your acked by.

Thanks,
Puranjay

