Return-Path: <bpf+bounces-76926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D4CC9B6A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F68E303EBBB
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC9312834;
	Wed, 17 Dec 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxPpkksj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D3312800
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010580; cv=none; b=gloL0SLXhTAF+SwGkBt2dphG0EpDGlXqrmbYDRr3qlAVAT7DpSdvTFs8U2N6QzRftVQgHp5qLN7LzzgAdjksikhAJZx7aNxS0V33p9IM3vxELABZj5vp1aGQQ57uQi0M8I7ZJNaxiDOEHR2r0jYfrotH7B4re2YDOXjoh1pXdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010580; c=relaxed/simple;
	bh=hGRkPUnoAhcn6WCIHsRizvFWmK4QEgHb0kZo7QZmjdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhfwqGKcWSPk1YxU9XMBZnanZ4tQcp1LRECpsPsB45w/lQ8KYFtxnIb6BOweiPr9p53jVTu6fqFEtaABbzYN6tlKhJmrqrguL8/MW5+Cu5rh3xzW85FsfgIFr9DDFhAM8gkLYH7PRS556Ah8V4maTF91P6fiUtaSfDlmqnRLV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxPpkksj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so10459560a12.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766010576; x=1766615376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H54kmn96vNV3ygwYbBRomzNZ50c+SuQtzurnnIVdFI=;
        b=lxPpkksjQ9fn2Sf8k6zFGorQP9OxVPNQat/ryivmciD0qbX/6SrxZl3CDdbr+YSDBK
         lSoMhWdf/iamjSvEgtYe5zW9K1VpDVzAkaANdMzWVAK5uFuMkAGaeIoNeyO7kaNLegwA
         LQy9M2FORTfZJdkwe/b4jxep3CVd35JI1EDQ/bi6l6WCv01qxk1M+Jc0BoQnP1uFN1ab
         4/WbnqNQaJIpNuDElUzGJka+4ny0jPcdMu5zUYWCJBkGoCioRSaJzdf0BKw6NN9yBqdL
         8jubhuJA7uZPPeUUPgLgbvPrXuBGHyBptY1k8bRtmbWcGAG5fruIBKusKz4AFJ/e7bRh
         p5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010576; x=1766615376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9H54kmn96vNV3ygwYbBRomzNZ50c+SuQtzurnnIVdFI=;
        b=QvptAhhu5Cq8CMg2nr1iRl2H/SrarRJC/JzYeL/TsInShSVMpTKR5nSO1XFI47tGCh
         mmkrhddV03tDKLwSVzYAMr+iI9GtrLCet73/YjjMDiqzZfqn5SvxTgCGNSAb5r7ByPC2
         snQ+iyi1P2j/JFc0O2Hwv3iYwU/cfV7RQIEPY6xNG2c3kco9cN2yAJ4vMPl+JKVJM6Rs
         w1mMT07RjxRk5bME6x1qqf3wruDBktFA6cVFU31y3bHPwYX6wU80Pk7TFWIEjAY8nOW0
         F2CH98erCPm+z41+No66Oj06GZv+rlMkMC2AoPiApj2rBCj6t65uiYIF/p/cQHRfb7uB
         3IHA==
X-Forwarded-Encrypted: i=1; AJvYcCXgh0/EHfxi54MzEDAhoqpn+ooKc6ajomjIEW6uafID7k6Nh1Pix6ZoE6O4PDPRuPvz41w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5y2ndngeFFuzrrug3ADEgoI3bjvV9sbKBb9DRVE/dMzvxDO+u
	w+pa1+fhTWlvQzU69qXEPGwiIjDNxbzpm2j4gwnPKiOCvu8t8HOMjOlCwb9zLPra80uMjIyXwur
	RGwcknOYlw72FZIf79e6FnMmhqdWpF7o=
X-Gm-Gg: AY/fxX6CFpDyrwyey5VFPmDlwsj2dtGMqPWJGclLdhZl6q3V4cP4ClyTP+iY/JUqtZe
	OWBHq+GOjGxeylTLMoCGnmdfUuEpjzG9HfyCq3MP2ZYQPUbw5qyebgqB5LdIPq0TvWr5fSj27Im
	xcxipIXBUqMn/LnsSsnCA0V+fR/oKfCOY3yPL6HgvSz2r6ypJCcFaGj10/iFZGhB6pad8wYvdKO
	YYO2T1OdyCVZDVO8z8xZ7dTmYaOCQArYXhJ9sfL0c3auc/7XxSwfGGfER3HPTEhazwJpCpu3AB0
	/oZKkLJ7KnM=
X-Google-Smtp-Source: AGHT+IHy0SPC7NZr09ACBkL+rzU7+b/jgSqQD84mqbjPUZWVOXQVxca90u4aU06tyBxNkzJ7qSjRrdzf2U7LHwjmhAk=
X-Received: by 2002:a05:6402:35ce:b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-6499b1c6ab0mr18878629a12.22.1766010576228; Wed, 17 Dec 2025
 14:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217162830.2597286-3-puranjay@kernel.org> <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
 <CANk7y0h4JO2-tp9HjRHjcQdTOgmRSsw0rxmK-=G89AVY92U8Jw@mail.gmail.com>
 <CAADnVQ+E6Tgcf1E5x-wk_TA+Lz83cA=SL8EZUGL70bQpywwexg@mail.gmail.com>
 <CANk7y0jNj0SDOBr=3n_0jhQbLzaj--yVUF4oDA-ManQG-=bkhw@mail.gmail.com> <a0c04178-2159-4475-9be8-93320ffc2138@linux.dev>
In-Reply-To: <a0c04178-2159-4475-9be8-93320ffc2138@linux.dev>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 17 Dec 2025 22:29:23 +0000
X-Gm-Features: AQt7F2pS1XvtGfaw6CsXi5lqqcqMe8RcxTask6GUikNhKVbwDkxTVzHOwPa4ixM
Message-ID: <CANk7y0hs2E6SVuxt1oHRFek0TD4y0DVP63755K5jxGd9BM3VwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 9:32=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 12/17/25 10:56 AM, Puranjay Mohan wrote:
> > On Wed, Dec 17, 2025 at 6:46=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Wed, Dec 17, 2025 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay@kern=
el.org> wrote:
> >>> On Wed, Dec 17, 2025 at 4:56=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote=
:
> >>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>>> index 2da986136d26..654fb94bf60c 100644
> >>>>> --- a/include/linux/bpf.h
> >>>>> +++ b/include/linux/bpf.h
> >>>> [ ... ]
> >>>>
> >>>>> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> >>>>>
> >>>>>   static inline bool bpf_prog_get_recursion_context(struct bpf_prog=
 *prog)
> >>>>>   {
> >>>>> +#ifdef CONFIG_ARM64
> >>>>> +     u8 rctx =3D interrupt_context_level();
> >>>>> +     u8 *active =3D this_cpu_ptr(prog->active);
> >>>>> +
> >>>>> +     active[rctx]++;
> >>>>> +     barrier();
> >>>>> +     if (get_unaligned_le32(active) !=3D BIT(rctx * 8))
> >>>>> +             return false;
> >>>>> +
> >>>>> +     return true;
> >>>>> +#else
> >>>>>        return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> >>>>> +#endif
> >>>>>   }
> >>>> Can preemption between the increment and check cause a counter leak =
on
> >>>> CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
> >>>> rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
> >>>> (documented at include/linux/rcupdate.h:856).
> >>>>
> >>>> Consider this scenario on an ARM64 system with PREEMPT_RCU:
> >>>>
> >>>> 1. Thread A increments active[0] to 1
> >>>> 2. Preemption occurs before Thread A reaches the check
> >>>> 3. Thread B on same CPU increments active[0] to 2
> >>>> 4. Thread B checks: sees 2 !=3D BIT(0), returns false
> >>>> 5. Thread A resumes, checks: sees 2 !=3D BIT(0), returns false
> >>>> 6. Both threads return false, neither runs BPF
> >>>> 7. Neither calls bpf_prog_put_recursion_context() (see
> >>>>     __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> >>>> 8. Counter permanently stuck at 2, all future BPF on this CPU fails
> >>> Step 7 is incorrect. Looking at the JIT-generated code, the exit
> >>> function is ALWAYS called, regardless of whether the enter function
> >>> returns 0 or a start time:
> >>>
> >>>    // x86 JIT at arch/x86/net/bpf_jit_comp.c:2998-3050
> >>>    call bpf_trampoline_enter()    // Line 2998
> >>>    test rax, rax                   // Line 3006
> >>>    je skip_exec                    // Conditional jump
> >>>    ... BPF program execution ...   // Lines 3011-3023
> >>>    skip_exec:                      // Line 3037 (jump lands here)
> >>>    call bpf_trampoline_exit()      // Line 3049 - ALWAYS executed
> >>>
> >>>    The bpf_trampoline_exit() call is after the skip_exec label, so it
> >>> executes in both cases.
> >>>
> >>> What Actually Happens:
> >>>
> >>>    Initial state: active[0] =3D 0
> >>>
> >>>    Thread A (normal context, rctx=3D0):
> >>>    1. active[0]++ =E2=86=92 active[0] =3D 1
> >>>    2. Preempted before barrier()
> >>>
> >>>    Thread B (scheduled on same CPU, normal context, rctx=3D0):
> >>>    3. active[0]++ =E2=86=92 active[0] =3D 2
> >>>    4. barrier()
> >>>    5. get_unaligned_le32(active) =E2=86=92 reads 0x00000002
> >>>    6. Check: 0x00000002 !=3D BIT(0) =3D 0x00000001 =E2=86=92 returns =
false
> >>>    7. __bpf_prog_enter_recur returns 0
> >>>    8. JIT checks return value, skips BPF execution
> >>>    9. JIT ALWAYS calls __bpf_prog_exit_recur (see
> >>> arch/arm64/net/bpf_jit_comp.c:2362)
> >>>    10. bpf_prog_put_recursion_context(prog) executes
> >>>    11. barrier(), active[0]-- =E2=86=92 active[0] =3D 1
> >>>
> >>>    Thread A resumes:
> >>>    12. barrier()
> >>>    13. get_unaligned_le32(active) =E2=86=92 reads 0x00000001 (Thread =
B already
> >>> decremented!)
> >>>    14. Check: 0x00000001 =3D=3D BIT(0) =3D 0x00000001 =E2=86=92 retur=
ns true =E2=9C=93
> >>>    15. __bpf_prog_enter_recur returns start_time
> >>>    16. BPF program executes
> >>>    17. __bpf_prog_exit_recur called
> >>>    18. bpf_prog_put_recursion_context(prog) executes
> >>>    19. barrier(), active[0]-- =E2=86=92 active[0] =3D 0 =E2=9C=93
> >>>
> >>>    Final State
> >>>
> >>>    - Counter returns to 0 =E2=9C=93
> >>>    - No leak =E2=9C=93
> >>>    - Thread B detected interference and aborted =E2=9C=93
> >>>    - Thread A executed successfully =E2=9C=93
> >>>    - Only ONE thread executed the BPF program =E2=9C=93
> >>>
> >>>
> >>> Now that I think of it, there is another race condition that leads to
> >>> NEITHER program running:
> >>>
> >>> Consider this scenario on an arm64 system with PREEMPT_RCU:
> >>>
> >>> 1. Thread A increments active[0] from 0 to 1
> >>> 2. Thread A is preempted before reaching barrier()
> >>> 3. Thread B (same CPU, same context) increments active[0] from 1 to 2
> >>> 4. Thread B executes barrier() and checks: sees 2 !=3D BIT(0), return=
s false
> >>> 5. Thread A resumes, executes barrier() and checks: sees 2 !=3D BIT(0=
),
> >>> returns false
> >>> 6. Both threads return false to __bpf_prog_enter_recur()
> >>> 7. Both skip BPF program execution
> >>> 8. Both call bpf_prog_put_recursion_context() and decrement: 2->1->0
> >>> 9. Neither BPF program executes, but the counter correctly returns to=
 0
> >>>
> >>> This means the patch is changing the behaviour in case of recursion
> >>> from "One program gets to run" to
> >>> "At most one program gets to run", but given the performance benefits=
,
> >>> I think we can accept this change.
> >> Agree. It's fine, but we can mitigate it, but doing this rctx trick
> >> only when RCU is not preemptable. Which pretty much would mean
> >> that PREEMPT_RT will use atomic and !RT will use rctx
> >> and this 'no prog executes' will not happen.
> >
> > The issue is also with sleepable programs, they use
> > rcu_read_lock_trace() and can end up with
> > 'no prog executes' scenario.
> >
> > What do you think is the best approach for them?
>
> For sleepable programs, maybe we can use the original approach like
>    return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> ?
> This should solve the 'no prog execution' issue.


I tried putting preempt_disable/enable() around inc+read in entry and
dec in exit:

New data, a little different config, so ignore exact values.

This patch:                           56.524M/s
This patch with preempt_disable():    53.856M/s
bpf-next/master:                      43.067M/s
bpf-next/master without Catalin fix:  51.862M/s


This is still very good and covers the sleepable case as well. So let's do =
this?

Thanks,
Puranjay

