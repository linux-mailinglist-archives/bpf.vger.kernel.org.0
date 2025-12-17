Return-Path: <bpf+bounces-76905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F25EFCC9565
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDCD304B22B
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4B2D8DA6;
	Wed, 17 Dec 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DggpGzGF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3E2BCF5D
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997808; cv=none; b=c0WVI8+4ElHcmXUI8wIXBOlHpuipEajWauKbkgUthPiJqDIRXjhMdeAN6nGEpxBweX/I9NqRZLfGaxbxlwlVBX0Bp+D8ZBWtLPYWHXUKzg+dOI1owbHPv9zLX/AQIMBsDysBTV/8C9E/jvu6GmKJT212JG6NlIdb4UlLY1tQ750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997808; c=relaxed/simple;
	bh=5OajcWIX4SWYmlTyjONg/oz+c5eqogNpxrICmODYcJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNDBCJydSNksiTQXQHDkXvv0w/DrstA+xbnJpmNBjpEAAA/G/+T9dIn7gPaBxKv0IlbyjEetCySc9abwT8j6rzJBFpKnleRXYe2Q2wGJOACVlyEjr1XTWYZxpLorkCZjlZ2c+89mr0VxBqaGUgvcuCEdDFmxhAvc60PhArLBGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DggpGzGF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7a6e56193cso1120351666b.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765997805; x=1766602605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtiU/2clMBttef5AKMoDZy0XlbtAsCi9HawhyqUoC2g=;
        b=DggpGzGFRXKsEeQOTa1NWJ3q7HjZec/qpUUXJW1h3WWhVRclwti6rnjmbJOPejn2tR
         Lpn6yIFQbzprBopDPV7E31IIlqB4ymN+BWEwu1MfwL/nUOGZyTADmdISW7bd+KpP8kbd
         M9mwluLSQ+QWbNpbtV1LVMbcD+rJhkQ6bSvjy4FxW6MXJC+MpJE45kklIGPZFQPnViRj
         CDplrc1SYMSQreT8gbq9G87PME/M8UUENUzDxK8SR5Nc7ThQGDcT/a17jtqAt8yYL6PZ
         /tXbnwiIlbwfMx3POFfG7+1+Ua+nH+g+Y9ChMmJGWJHu3HEyOgrgkXJPjf0289m64Yaj
         LQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765997805; x=1766602605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtiU/2clMBttef5AKMoDZy0XlbtAsCi9HawhyqUoC2g=;
        b=DfqR+XHAsQjq5eW0jj0eJJCTzwXE10mFrsVktuhzRD56f/ZENsNW8Lson6JPRRPrfn
         WmLCf0HFxKDFWGTINqfXENJZ2+ekK0BhYe7EnQs9PRQhEwmrfmF57fx4ta8bzVNBdXFQ
         gAWVMsHd+wqejbgrRO55zr81/eQSvPtQGF6KONlxg+pw/TPADsfUOC9GYbwjvpWEK3XR
         3N9T/NkZXc7XtcY7zaRRu/3eVjYAW8xHdEttDfrJkA0JvYwH4469GX7jBa0yofUvP/9d
         fGwHBVYM6LIdx7if59+oj60pPqLEG76BHimDI0z+S0bIcp7ZoBLOUEFV7galFwjjBgjy
         5OYA==
X-Forwarded-Encrypted: i=1; AJvYcCXY2vVfcO7aDl/PzAuOuMrtQ8qikZa6HdKvTLvVuOHeZxh0InJyw7wEPXmKkXIYVaeIdL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmT9njpPPiGFmjtk34UAgeEjcZP5rT3T2Nau7ASuWBgbvFywjk
	dyGvpywL7nd23t7EhyIZHIHBBvnvdpiUnITdC4ymcwW647t/pE0Uishtxx0R+Jkj0YET6UOLHcr
	YdfjpAqUd8m5LLKlTE3eqN/n/Mx4lCEs=
X-Gm-Gg: AY/fxX5LnTaHgw03QLP/UDorBNbeBPTJXBtTsR1SHugiQaVp/dfZSJpqYBQMy0WqMiu
	OL0Trsk0B+vVlj3aH5HjsAwJv0FoHJxIDXbx3s3yMq8nBBlcHFtVuS1mBXAz0b92tUlpNX8qiGd
	UiLUVJhIX1O5uAuAGcUTo/4/I0ZO3psvSoddjsghwON+0pxP6rOXuzEXEsMkMpqJWS4Y/lMEIXV
	K4cpV8yMOlHo+vS9l/u3At4QuusulMwYw4kTxOHzAZ53f5WWyR4NJqh8bhaEmc/9R0otYypktcD
	g0dM6FhTcQ8=
X-Google-Smtp-Source: AGHT+IEfi7Vyy1yRCus1ZuFKFQihTwTTNqloTTDJXE/9K4O4ppNrwV31Rjl8S7kTvepHHbBWbJjxHDmnO8oaHLrUqMs=
X-Received: by 2002:a17:906:f5a3:b0:b7d:1cbb:5d29 with SMTP id
 a640c23a62f3a-b7d23ad698dmr1758130666b.36.1765997804403; Wed, 17 Dec 2025
 10:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217162830.2597286-3-puranjay@kernel.org> <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
 <CANk7y0h4JO2-tp9HjRHjcQdTOgmRSsw0rxmK-=G89AVY92U8Jw@mail.gmail.com> <CAADnVQ+E6Tgcf1E5x-wk_TA+Lz83cA=SL8EZUGL70bQpywwexg@mail.gmail.com>
In-Reply-To: <CAADnVQ+E6Tgcf1E5x-wk_TA+Lz83cA=SL8EZUGL70bQpywwexg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 17 Dec 2025 18:56:30 +0000
X-Gm-Features: AQt7F2q5M8-DeFJwvLAnx1rE-WEEZp2rZ4czRk_Nxz9WqbfN28-XP_vVyjYOBkM
Message-ID: <CANk7y0jNj0SDOBr=3n_0jhQbLzaj--yVUF4oDA-ManQG-=bkhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 6:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 17, 2025 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> >
> > On Wed, Dec 17, 2025 at 4:56=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 2da986136d26..654fb94bf60c 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > >
> > > [ ... ]
> > >
> > > > @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> > > >
> > > >  static inline bool bpf_prog_get_recursion_context(struct bpf_prog =
*prog)
> > > >  {
> > > > +#ifdef CONFIG_ARM64
> > > > +     u8 rctx =3D interrupt_context_level();
> > > > +     u8 *active =3D this_cpu_ptr(prog->active);
> > > > +
> > > > +     active[rctx]++;
> > > > +     barrier();
> > > > +     if (get_unaligned_le32(active) !=3D BIT(rctx * 8))
> > > > +             return false;
> > > > +
> > > > +     return true;
> > > > +#else
> > > >       return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> > > > +#endif
> > > >  }
> > >
> > > Can preemption between the increment and check cause a counter leak o=
n
> > > CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
> > > rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
> > > (documented at include/linux/rcupdate.h:856).
> > >
> > > Consider this scenario on an ARM64 system with PREEMPT_RCU:
> > >
> > > 1. Thread A increments active[0] to 1
> > > 2. Preemption occurs before Thread A reaches the check
> > > 3. Thread B on same CPU increments active[0] to 2
> > > 4. Thread B checks: sees 2 !=3D BIT(0), returns false
> > > 5. Thread A resumes, checks: sees 2 !=3D BIT(0), returns false
> > > 6. Both threads return false, neither runs BPF
> > > 7. Neither calls bpf_prog_put_recursion_context() (see
> > >    __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> > > 8. Counter permanently stuck at 2, all future BPF on this CPU fails
> >
> > Step 7 is incorrect. Looking at the JIT-generated code, the exit
> > function is ALWAYS called, regardless of whether the enter function
> > returns 0 or a start time:
> >
> >   // x86 JIT at arch/x86/net/bpf_jit_comp.c:2998-3050
> >   call bpf_trampoline_enter()    // Line 2998
> >   test rax, rax                   // Line 3006
> >   je skip_exec                    // Conditional jump
> >   ... BPF program execution ...   // Lines 3011-3023
> >   skip_exec:                      // Line 3037 (jump lands here)
> >   call bpf_trampoline_exit()      // Line 3049 - ALWAYS executed
> >
> >   The bpf_trampoline_exit() call is after the skip_exec label, so it
> > executes in both cases.
> >
> > What Actually Happens:
> >
> >   Initial state: active[0] =3D 0
> >
> >   Thread A (normal context, rctx=3D0):
> >   1. active[0]++ =E2=86=92 active[0] =3D 1
> >   2. Preempted before barrier()
> >
> >   Thread B (scheduled on same CPU, normal context, rctx=3D0):
> >   3. active[0]++ =E2=86=92 active[0] =3D 2
> >   4. barrier()
> >   5. get_unaligned_le32(active) =E2=86=92 reads 0x00000002
> >   6. Check: 0x00000002 !=3D BIT(0) =3D 0x00000001 =E2=86=92 returns fal=
se
> >   7. __bpf_prog_enter_recur returns 0
> >   8. JIT checks return value, skips BPF execution
> >   9. JIT ALWAYS calls __bpf_prog_exit_recur (see
> > arch/arm64/net/bpf_jit_comp.c:2362)
> >   10. bpf_prog_put_recursion_context(prog) executes
> >   11. barrier(), active[0]-- =E2=86=92 active[0] =3D 1
> >
> >   Thread A resumes:
> >   12. barrier()
> >   13. get_unaligned_le32(active) =E2=86=92 reads 0x00000001 (Thread B a=
lready
> > decremented!)
> >   14. Check: 0x00000001 =3D=3D BIT(0) =3D 0x00000001 =E2=86=92 returns =
true =E2=9C=93
> >   15. __bpf_prog_enter_recur returns start_time
> >   16. BPF program executes
> >   17. __bpf_prog_exit_recur called
> >   18. bpf_prog_put_recursion_context(prog) executes
> >   19. barrier(), active[0]-- =E2=86=92 active[0] =3D 0 =E2=9C=93
> >
> >   Final State
> >
> >   - Counter returns to 0 =E2=9C=93
> >   - No leak =E2=9C=93
> >   - Thread B detected interference and aborted =E2=9C=93
> >   - Thread A executed successfully =E2=9C=93
> >   - Only ONE thread executed the BPF program =E2=9C=93
> >
> >
> > Now that I think of it, there is another race condition that leads to
> > NEITHER program running:
> >
> > Consider this scenario on an arm64 system with PREEMPT_RCU:
> >
> > 1. Thread A increments active[0] from 0 to 1
> > 2. Thread A is preempted before reaching barrier()
> > 3. Thread B (same CPU, same context) increments active[0] from 1 to 2
> > 4. Thread B executes barrier() and checks: sees 2 !=3D BIT(0), returns =
false
> > 5. Thread A resumes, executes barrier() and checks: sees 2 !=3D BIT(0),
> > returns false
> > 6. Both threads return false to __bpf_prog_enter_recur()
> > 7. Both skip BPF program execution
> > 8. Both call bpf_prog_put_recursion_context() and decrement: 2->1->0
> > 9. Neither BPF program executes, but the counter correctly returns to 0
> >
> > This means the patch is changing the behaviour in case of recursion
> > from "One program gets to run" to
> > "At most one program gets to run", but given the performance benefits,
> > I think we can accept this change.
>
> Agree. It's fine, but we can mitigate it, but doing this rctx trick
> only when RCU is not preemptable. Which pretty much would mean
> that PREEMPT_RT will use atomic and !RT will use rctx
> and this 'no prog executes' will not happen.


The issue is also with sleepable programs, they use
rcu_read_lock_trace() and can end up with
'no prog executes' scenario.

What do you think is the best approach for them?

