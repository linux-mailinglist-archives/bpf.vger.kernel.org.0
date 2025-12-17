Return-Path: <bpf+bounces-76897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0ECC9506
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8128307E5B9
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1F2D8376;
	Wed, 17 Dec 2025 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHchwKZl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7629E0F6
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997060; cv=none; b=d8slYoLcChZQxpRhZyBks4YlvZju8O5lE4Tx4SvHB0WpTXHtCZ+gg3ebH+eGwtk78uv0T24Et2Zhx9FUb+DzHKsYxdihm62e7Kwvb0jE/nSnWzxg5a3dSyHZXtM5RZ+t7Aho1rEy2MsFOPcc/b7VH2vvK7BdPiSbHslT6kBZiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997060; c=relaxed/simple;
	bh=3rYIDYFHdXedEuS/ZuXKyvTmmCDGJpW1GVoD55c5fN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmmkpR15KrBv8LcByzRHWmzo5AjHgXVblZL7qwtJbyM8o1IqOZs+GY+OtcsG/hM1N3nBOKqoi67wb4QdDJW3cFSo1PYHtkvc5XorhQ0cqTAlyRPvxhWwhTyC3ZWaHYsia1vqNPPNral5BaGwQfMkDvr07CPUTCMCnOejT8hDTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHchwKZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A55C19423
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765997059;
	bh=3rYIDYFHdXedEuS/ZuXKyvTmmCDGJpW1GVoD55c5fN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nHchwKZl5O3iz3jUuTqNnm2YVYdBXL4iAewe2jVC9gMf6rjR6+TdyUwHA6xa6XUAN
	 3t3ErjGgKsw/oC7lEpGF0mkUirjrpBlKBLoyq+1N0RmgRUeAP38WKGhif4zM6iYF/1
	 VuqlcZfrT3G3eeJr9J6kb9RzGL79MBAxC1UwWAodmosULccBCJ3ch04hErrrV5TAuf
	 H46NBIrnULsp0R5izBcn8ADgO8Sg5XpQVuSdoV5r00awUgMaYXMZLJOnaiVm0Y/Geu
	 gk2iZkDPMF3Ut0lO+hJWgVnFs+NxPQQAEs5m2zh9No5F1tnFAOZcn67TWuPpl+1k2Y
	 DGpa9cgbaTeWw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7633027cb2so1094562566b.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 10:44:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUh0X3ZEcCx0VVLYJCpc1PJGxZjcxBXNhNtbxME6lInmYf1i+lIDiTxToToRtukpYZMBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwqbl4a2WjWfk81NwYZYWuHzrMmccKriuVI0nG3AHkjbHfZmUh
	JTpcXAPXeyBrEnWyQj6XyqXUILJIvJHGfgZCXBKQpol7Uf8ymkd6RroB3kXbwdKYTQi+yt9ayxF
	2wLAAY313xvrJlaS5vs9Nr9U0lybNCfU=
X-Google-Smtp-Source: AGHT+IGcJxf+wC4kKl38d/ObGhHN9ATqLnM291xtGzdG8ztJK68L1w7pPiyvzPfqUb+uEDkw7T8fItr1Dpsx9fpJK0M=
X-Received: by 2002:a17:907:9617:b0:b76:8163:f1f8 with SMTP id
 a640c23a62f3a-b7d23a7d742mr1899012966b.53.1765997058340; Wed, 17 Dec 2025
 10:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217162830.2597286-3-puranjay@kernel.org> <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
 <51466fd3-c837-46a6-af50-28a8336fd8cd@linux.dev>
In-Reply-To: <51466fd3-c837-46a6-af50-28a8336fd8cd@linux.dev>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 17 Dec 2025 18:44:04 +0000
X-Gmail-Original-Message-ID: <CANk7y0irgYcHLH_e9ozjX3wTeDb3GH-PA+6UiLRSBFzpYs8eVQ@mail.gmail.com>
X-Gm-Features: AQt7F2rj3bSMNLu8ufN8iIw42zX_ibMhxtoHDmKCykdihEmY6NNJdkyfVkghfX4
Message-ID: <CANk7y0irgYcHLH_e9ozjX3wTeDb3GH-PA+6UiLRSBFzpYs8eVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	linux-arm-kernel@lists.infradead.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 6:24=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 12/17/25 8:56 AM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 2da986136d26..654fb94bf60c 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> > [ ... ]
> >
> >> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> >>
> >>   static inline bool bpf_prog_get_recursion_context(struct bpf_prog *p=
rog)
> >>   {
> >> +#ifdef CONFIG_ARM64
> >> +    u8 rctx =3D interrupt_context_level();
> >> +    u8 *active =3D this_cpu_ptr(prog->active);
> >> +
> >> +    active[rctx]++;
> >> +    barrier();
> >> +    if (get_unaligned_le32(active) !=3D BIT(rctx * 8))
> >> +            return false;
> >> +
> >> +    return true;
> >> +#else
> >>      return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> >> +#endif
> >>   }
> > Can preemption between the increment and check cause a counter leak on
> > CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
> > rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
> > (documented at include/linux/rcupdate.h:856).
> >
> > Consider this scenario on an ARM64 system with PREEMPT_RCU:
> >
> > 1. Thread A increments active[0] to 1
> > 2. Preemption occurs before Thread A reaches the check
> > 3. Thread B on same CPU increments active[0] to 2
> > 4. Thread B checks: sees 2 !=3D BIT(0), returns false
> > 5. Thread A resumes, checks: sees 2 !=3D BIT(0), returns false
> > 6. Both threads return false, neither runs BPF
> > 7. Neither calls bpf_prog_put_recursion_context() (see
> >     __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> > 8. Counter permanently stuck at 2, all future BPF on this CPU fails
> >
> > The old atomic code handled this correctly because this_cpu_inc_return(=
)
> > completes atomically, ensuring Thread A reads the value 1 before Thread=
 B
> > can interfere. With non-atomic operations, Thread A increments but hasn=
't
> > read the value yet, allowing Thread B to interfere and cause both threa=
ds
> > to see the modified value.
> >
> > Is there a guarantee that same-context preemption cannot occur in the B=
PF
> > execution path on ARM64, or does this need additional synchronization?
>
> AI is correct here. See below for another thread:
>    https://lore.kernel.org/bpf/20251217093326.1745307-1-chen.dylane@linux=
.dev/T/#m906fd4502fbbedd4609c586122a393363003312a
> where preempt_disable is necessary to prevent the above scenario.

See my other reply, the above scenario presented by AI is wrong
because step 7 is wrong.

> But adding preempt_disable may impact the overall system-level performanc=
e.
>
> Does this patch can improve performance for *all* ARM64 cpu versions?
> Do you have numbers to show how much performance improvement?

This should improve performance on all arm64 CPUs because atomics are
expensive because they are atomic across all cpus.

I see a 33% improvement in the fentry trigger benchmark, but I can do
more benchmarking.

> >
> >> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> >>
> >>   static inline void bpf_prog_put_recursion_context(struct bpf_prog *p=
rog)
> >>   {
> >> +#ifdef CONFIG_ARM64
> >> +    u8 rctx =3D interrupt_context_level();
> >> +    u8 *active =3D this_cpu_ptr(prog->active);
> >> +
> >> +    barrier();
> >> +    active[rctx]--;
> >> +#else
> >>      this_cpu_dec(*(prog->active));
> >> +#endif
> >>   }
> [...]

