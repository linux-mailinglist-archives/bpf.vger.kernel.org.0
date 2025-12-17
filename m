Return-Path: <bpf+bounces-76903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A9CC952D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E6B43016930
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BA19CD0A;
	Wed, 17 Dec 2025 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdM3PXV/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1DF50F
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997195; cv=none; b=RAGv+GOGhRpufqdZCqgc8a3EMz/4zogoNUtamGRucFi/4S528IWpg191LIFkaQm3RAZ2n6QjmJxpoGV3ig70bxl+G6kjs7mpwza40YgF23xVAHqLf1jiK4lzuy/SSlwMgOtEhO2gUatQevRueqUJgK7ikgcBnzkq81Whyb73Sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997195; c=relaxed/simple;
	bh=CIe+ZU9oxZaSCq2WDiD7PNAozXKlplZSPqtl5CpE4Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb9YV/7Cu43mw445c8wJzhlE79JsH7Z8UnFbrFqlLWsIk7bSRQZICv4Hte3n7ht9KO1Gmiy/eA52BI9uE6WhQJ/0xzUr8OGP1seQ1E5mYp5VNKvUHdDEOfwl0jmvLKAtIsV+83tROBvuv76bxtqFMk9Ve51mmf+exMaQFj911oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdM3PXV/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso3348317f8f.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765997192; x=1766601992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lG992SzARwSD2CfwNAdMfhT0lO+gSHnEw3eG59WhYA=;
        b=mdM3PXV/lPUJp34jgHYHXBe0QxZhCf8N3Lgy1ZcJqpueaDy3Fz6SHerJPjt2Nnf80D
         vR1J2bshvk92TnqReLXEGTkL+vIyWoT1Q1ptzFllX/xXJZvJxZ+Dz/9kytxQUDx99iyH
         1Zc28l651sqI5J6XXC63W3vnRtDQ+p1UxLTurvOCOtOtrdpYKMq2m/ZOr8s2tatGQKYc
         OwuQZYeFichluBmguXjyrnZWSu7xYy6hzJnUv9cipY26iAtoUrurehQKWnxoUaCQI5Kc
         rScpkG+czGk6/XZeeaUtrXZ1Y0VwX1kfFWzhW5Ag4KAXE3le804svguGrS/3x0NC7pN0
         +krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765997192; x=1766601992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lG992SzARwSD2CfwNAdMfhT0lO+gSHnEw3eG59WhYA=;
        b=H86CH4b3nZtNrd+XhyqxMN1033JwQwXh3bHY7Qqe5+XNl0fBl2RoXxefXwHlUpKbvc
         CaiXMhy4paYxViAM0T1hVl+EwX72Ek8hXPbZFxj3QkE+G26Ixwc1NkCg0yx5rhCGDL11
         Nd6v5krYXtdb2OkMhJhmA0Hio13qB1ouVAEHGhIxjpnYJ7dwzWRLRqhOvrONRnugN3Ss
         aKg9viazbFnE3JF7XkIY39f+AYlimj6V22EFoCbIwEYsx++J7PCBiwmRXZ+tOK+CoACK
         u0ERRyTIVjrJCXbOG9kWFrmW/cw8TRJhSiRmLh8n95whTotrh07XdFmLPJWjblOzYDDo
         jzJg==
X-Forwarded-Encrypted: i=1; AJvYcCVWztswU03I97/TEbBm4pE4hpg7Ntc6ukLJ95ysazCf5bk6kemAVqBAQpuZ4saZ/b/MdPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+V+/YI9UOIAN7oxcxbCvxYHaZClNAgYw7Zm8Ag25z8uMqoaa
	ap+9Xe53GoqG4ilwAOpE524Y0dFs8OZUpTiXa2SBuQA43752PtNoKaYI7kdZlg5po1dwixMWbEn
	plnW2Wq2KhOQ2u4j0/ZK3KBxkDuNSS8g=
X-Gm-Gg: AY/fxX4s3ulnaBzFEJRPGEIS8GSLM57kkTL/FGlAs1lHHCi3k/pjj2qo/6xHUBQTniX
	IH4ebch1Cmg0S6SWYgbNbD77SeWhLk37S8pUFHj41wOEJSViwAqZIht2YZDyN1ZL0quGmXqh3a9
	l8Hiy0ItE8hFNq9JZKK8YtBcZU7nAImD+HgA57MSxxhfbRDyGLvCnJ4cyRkzPnmYMVRxT7YBlO1
	Bp8uT0aSU/DG1IdEn4xfAoGlhgh41O9sa0wNXBF6jd8zflmDsgr7HrAAvVnNGzNvA1/+S0u5GHI
	o4sRdJXIxo/KGu8LIS54j+jRg53XuMp+IXB8Y3A=
X-Google-Smtp-Source: AGHT+IE9b/9uPlHb9PZEwXpux39kKBe7I37eUW2J7udF3uAvIEhu7nxR8gBmRi8tLubji4uKhOQgNcXNQgIdS4SDjys=
X-Received: by 2002:a05:6000:3112:b0:430:8583:d19e with SMTP id
 ffacd0b85a97d-4308583d30bmr13279792f8f.8.1765997192095; Wed, 17 Dec 2025
 10:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217162830.2597286-3-puranjay@kernel.org> <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
 <CANk7y0h4JO2-tp9HjRHjcQdTOgmRSsw0rxmK-=G89AVY92U8Jw@mail.gmail.com>
In-Reply-To: <CANk7y0h4JO2-tp9HjRHjcQdTOgmRSsw0rxmK-=G89AVY92U8Jw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 10:46:21 -0800
X-Gm-Features: AQt7F2pLMd_hQpf761wgyiSeU22_SrSfSiYZpZD7ova6qKN6XhTev4AL9vLtgqk
Message-ID: <CAADnVQ+E6Tgcf1E5x-wk_TA+Lz83cA=SL8EZUGL70bQpywwexg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
To: Puranjay Mohan <puranjay@kernel.org>
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

On Wed, Dec 17, 2025 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> On Wed, Dec 17, 2025 at 4:56=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 2da986136d26..654fb94bf60c 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> >
> > [ ... ]
> >
> > > @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> > >
> > >  static inline bool bpf_prog_get_recursion_context(struct bpf_prog *p=
rog)
> > >  {
> > > +#ifdef CONFIG_ARM64
> > > +     u8 rctx =3D interrupt_context_level();
> > > +     u8 *active =3D this_cpu_ptr(prog->active);
> > > +
> > > +     active[rctx]++;
> > > +     barrier();
> > > +     if (get_unaligned_le32(active) !=3D BIT(rctx * 8))
> > > +             return false;
> > > +
> > > +     return true;
> > > +#else
> > >       return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> > > +#endif
> > >  }
> >
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
> >    __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> > 8. Counter permanently stuck at 2, all future BPF on this CPU fails
>
> Step 7 is incorrect. Looking at the JIT-generated code, the exit
> function is ALWAYS called, regardless of whether the enter function
> returns 0 or a start time:
>
>   // x86 JIT at arch/x86/net/bpf_jit_comp.c:2998-3050
>   call bpf_trampoline_enter()    // Line 2998
>   test rax, rax                   // Line 3006
>   je skip_exec                    // Conditional jump
>   ... BPF program execution ...   // Lines 3011-3023
>   skip_exec:                      // Line 3037 (jump lands here)
>   call bpf_trampoline_exit()      // Line 3049 - ALWAYS executed
>
>   The bpf_trampoline_exit() call is after the skip_exec label, so it
> executes in both cases.
>
> What Actually Happens:
>
>   Initial state: active[0] =3D 0
>
>   Thread A (normal context, rctx=3D0):
>   1. active[0]++ =E2=86=92 active[0] =3D 1
>   2. Preempted before barrier()
>
>   Thread B (scheduled on same CPU, normal context, rctx=3D0):
>   3. active[0]++ =E2=86=92 active[0] =3D 2
>   4. barrier()
>   5. get_unaligned_le32(active) =E2=86=92 reads 0x00000002
>   6. Check: 0x00000002 !=3D BIT(0) =3D 0x00000001 =E2=86=92 returns false
>   7. __bpf_prog_enter_recur returns 0
>   8. JIT checks return value, skips BPF execution
>   9. JIT ALWAYS calls __bpf_prog_exit_recur (see
> arch/arm64/net/bpf_jit_comp.c:2362)
>   10. bpf_prog_put_recursion_context(prog) executes
>   11. barrier(), active[0]-- =E2=86=92 active[0] =3D 1
>
>   Thread A resumes:
>   12. barrier()
>   13. get_unaligned_le32(active) =E2=86=92 reads 0x00000001 (Thread B alr=
eady
> decremented!)
>   14. Check: 0x00000001 =3D=3D BIT(0) =3D 0x00000001 =E2=86=92 returns tr=
ue =E2=9C=93
>   15. __bpf_prog_enter_recur returns start_time
>   16. BPF program executes
>   17. __bpf_prog_exit_recur called
>   18. bpf_prog_put_recursion_context(prog) executes
>   19. barrier(), active[0]-- =E2=86=92 active[0] =3D 0 =E2=9C=93
>
>   Final State
>
>   - Counter returns to 0 =E2=9C=93
>   - No leak =E2=9C=93
>   - Thread B detected interference and aborted =E2=9C=93
>   - Thread A executed successfully =E2=9C=93
>   - Only ONE thread executed the BPF program =E2=9C=93
>
>
> Now that I think of it, there is another race condition that leads to
> NEITHER program running:
>
> Consider this scenario on an arm64 system with PREEMPT_RCU:
>
> 1. Thread A increments active[0] from 0 to 1
> 2. Thread A is preempted before reaching barrier()
> 3. Thread B (same CPU, same context) increments active[0] from 1 to 2
> 4. Thread B executes barrier() and checks: sees 2 !=3D BIT(0), returns fa=
lse
> 5. Thread A resumes, executes barrier() and checks: sees 2 !=3D BIT(0),
> returns false
> 6. Both threads return false to __bpf_prog_enter_recur()
> 7. Both skip BPF program execution
> 8. Both call bpf_prog_put_recursion_context() and decrement: 2->1->0
> 9. Neither BPF program executes, but the counter correctly returns to 0
>
> This means the patch is changing the behaviour in case of recursion
> from "One program gets to run" to
> "At most one program gets to run", but given the performance benefits,
> I think we can accept this change.

Agree. It's fine, but we can mitigate it, but doing this rctx trick
only when RCU is not preemptable. Which pretty much would mean
that PREEMPT_RT will use atomic and !RT will use rctx
and this 'no prog executes' will not happen.

> I am not sure what would change in reality if we allow both BPF
> programs to be skipped in case of high interleaving
> like above.
>
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
> >
> > > @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> > >
> > >  static inline void bpf_prog_put_recursion_context(struct bpf_prog *p=
rog)
> > >  {
> > > +#ifdef CONFIG_ARM64
> > > +     u8 rctx =3D interrupt_context_level();
> > > +     u8 *active =3D this_cpu_ptr(prog->active);
> > > +
> > > +     barrier();
> > > +     active[rctx]--;
> > > +#else
> > >       this_cpu_dec(*(prog->active));
> > > +#endif
> > >  }
> >
> > The barrier() is placed before the decrement. Does this provide the nee=
ded
> > ordering guarantee, or should there also be a barrier after the decreme=
nt
> > to ensure visibility?
> >
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index c66316e32563..b5063acfcf92 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> >
> > [ ... ]
> >
> > > @@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned=
 int size, gfp_t gfp_extra_flag
> > >               vfree(fp);
> > >               return NULL;
> > >       }
> > > -     fp->active =3D alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL=
 | gfp_extra_flags));
> > > +     fp->active =3D __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), =
8,
> > > +                                     bpf_memcg_flags(GFP_KERNEL | gf=
p_extra_flags));
> >
> > The allocation changes to u8[4] for all architectures, but the non-ARM6=
4
> > code path still uses *(prog->active) which now dereferences only the fi=
rst
> > byte. This changes the counter from int (typically 4 bytes, range ~2^31=
)
> > to u8 (1 byte, range 256). While 256 recursion levels is sufficient in
> > practice, is this intentional for non-ARM64 platforms, or should they
> > continue using a full int-sized allocation?
>
> This was intentional so that we don't add another #ifdef here, 256
> recursion levels are more than enough.

256 will be fine for !RT.
So suggestion above will address this concern as well when 256+ tasks
are racing concurrently on this cpu.

