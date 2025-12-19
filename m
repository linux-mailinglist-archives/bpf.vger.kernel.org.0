Return-Path: <bpf+bounces-77191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D84CD15F0
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D181130C1609
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F5346771;
	Fri, 19 Dec 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe5QuZIO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD3F3451A3
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168633; cv=none; b=LXhp21wqr1qJZOolKKPxw97qo4Ccszre4QkIlFWaUV1rP9bMbFDgVLMsFBZ86CCf/mEcuFZNykwJfkYV4vC2fgmQ1zlNYs0ZoPBoT5nTYBxnxW+MPr4cK+h30ozqvWlej/Nqdw23x73GKWNXqyigDBERlWXYnFATVUq9LgXpRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168633; c=relaxed/simple;
	bh=IQUpviy+SHL1m2AGCU0Phcex95pxeDnlr5HcvWpAflI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmjGga91jjwGDvrwCawgUHOMQeR1UHeE6h8fuD/Cwu1VDA1QwiaWcjeCnD8QK7QxdjWdyE8Lgw9zzAACH+9PAzmJYx1js40WW3S4BMpnDeB7aDS98R61DfOFa+oPp+wGkaqgUSS9XUXG2hAQKuGNRCwmJ8WJWi7vaDjsWd02x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe5QuZIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CD1C116B1
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766168633;
	bh=IQUpviy+SHL1m2AGCU0Phcex95pxeDnlr5HcvWpAflI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oe5QuZIOJN98CStdAkRuNoCNjBu/wZ4WvP9adTQuGOn6rjvm7NbL6sXbnVI9Hq0y8
	 yYnJP5iCrnMHevOdZ1oZWV7QlM/QxDotn8XkfS7mWy/mbrVEuLusamXAmee1QfaoaH
	 lgAEJOErNNnD+dSBz7lJ8iJ0nrcfvIDtNs9OXnrrH0X3AqN9cOlAs4Vl7hu/j0Fl1V
	 3qv17NcFcseUHFJJJJkHsOgqQV9U4KfmhfOg1DmCd8DNa9XxrdzA8HrSsLd9ZZlpfs
	 hkEvG/egzmhHR6V+GK4tiContTjoz51DgwRdU3GfQxB5sIrPHxTi2qX1iLCUAGmobw
	 yifdl9XqL6h3A==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7eff205947so277583266b.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 10:23:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yx9LhME0fJyt6l0MoL0tvF9BKSKQYl0bjeshv7VoAhLxaofvTAP
	SOtgV+iAYdIRjaXKf2zAq46JW+YmCKi9xaXuo+0D7ShKWbNK9RJzq0DaBwsssrgk99bwAu7xUe4
	arp1sYQZCpY7IkDvmJryJnjmzGDm/W+o=
X-Google-Smtp-Source: AGHT+IFjUlxRf0zx6cGLNJ3Qo5wrQw2AAItRc97zHUPkb9+LEQBsKoHb9ZtmYfg3Js/RmCbPN8US/NJMfkimXUpNiGU=
X-Received: by 2002:a17:907:6d23:b0:b72:77c7:d8ad with SMTP id
 a640c23a62f3a-b8037058bbbmr367812466b.35.1766168631674; Fri, 19 Dec 2025
 10:23:51 -0800 (PST)
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
Date: Fri, 19 Dec 2025 18:23:38 +0000
X-Gmail-Original-Message-ID: <CANk7y0iGCwKss5Mbdq8+-Xp8d_TRr1tPY4DcAFCPgpFiQW8otg@mail.gmail.com>
X-Gm-Features: AQt7F2qJa8mVqEoknWmPGcn4C9_EwmdJdPhPcZoj-YEjjWHRm79i4XMNMjDAHvY
Message-ID: <CANk7y0iGCwKss5Mbdq8+-Xp8d_TRr1tPY4DcAFCPgpFiQW8otg@mail.gmail.com>
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

I will just use val =3D le32_to_cpu(*(__le32 *)active);

Thanks,
Puranjay

