Return-Path: <bpf+bounces-21382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A784C151
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 01:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F56B22B09
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 00:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7653A0;
	Wed,  7 Feb 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C20XykOc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806E46A0
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265296; cv=none; b=iD9wNaXVXuleqe3fd8k1+HqNre9M6UomdmzagTVJX4VAHsXZVBSbkrltTx3RPGdzDRNZIUMMAA09LB9YmkUEFA7Jw/CWKfdi4teYiRquo5MAHusO+pSVhN4IIAvvhaKKLQzf1LyHj7jJ0pXSSRkgUmwV38UwnW6sUSX9t+sb7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265296; c=relaxed/simple;
	bh=G1J7MN4XO7wCvuWtir+jaGz0ieIqu/Gd+tdT5qEFIfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+BhE+EF3+/UbSBflAI+T1v5RB+blhhqBAPjV3FBZP4I3gFba9Ha/bpR5VRTtuqD+Q9oEUjhNOFYt51HPN+FOWW4kAGxakGSKjnGoqW3mURpAgIw7+VNuv7G2q+dFR4a0tWc1If4oPVJ8KUHnlvH2bmPNSj0tp3JwDjZt+c7G44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C20XykOc; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c0245cba99so51113e0c.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707265293; x=1707870093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHu/VLcSGFfHSWmBxGOZd5SNru7pDGQihzr8t3VpWps=;
        b=C20XykOcedGbFg/oRsejiUQTp+VixraHEDShfK0ifc/hdE74ZfRKzSY1/k0sGrzBb/
         BKAwffd+SgheZ/nzZrE5QqlDI3gimiOgrtVEr494rn/euJ5QNgyhpfqU74nMu3KSZa0B
         KAqCiAU7ETtXn2qKx8mpkUV+Bb56IhSzkXJJh6sR+lvxRLEMGsh2HPESK88vuBoFrirk
         NQa4DefI1klWJiyc94NGqkczwykCB9exWozoTxsyxir0+Y09dbiv/iEBDi9UsC7P61ZF
         fthEfNdBy8lVc3R5VV0WllRNuJL0mf32MSH9xOUNC/cMMtoL3O1bJL0w8b+E91304NRZ
         gzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265293; x=1707870093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHu/VLcSGFfHSWmBxGOZd5SNru7pDGQihzr8t3VpWps=;
        b=mQFml1PeFstoyLeVwDv8NRoeuHbRf9aIJznU6bev5EUFnFYIFCgCFKmpWvtnWKBCe3
         GqgHsLgqel2j5dW1SlDdURhpCF7qB92VELfkp0phLPsWMmO1B1wXg9sk0cY9DvSVxuii
         +2xTz9gQk+De7ZPMgjRjqgHmWdy7QOZP5PtK+6+WYhXaP+J7pTWStVNwyaHShRFTJC1v
         Y/1nI3Xa4YefGKGJrv6xLEtQKLXhIEaJGQws5IkvcS2FLPisub7iMfMvmsXCb6OAGtY9
         Aowgw9Bjee9yt/irCiuXjVKb1R5boXgnFzlh/0Pzvexs6WsZCYkZDg5ZqFpavkh/Te3N
         g63w==
X-Forwarded-Encrypted: i=1; AJvYcCWn7x8ODrUWjpwu3Ru50z1u5yuNh2KtGlhI/RdVqKTD1eUVAs9KGYL/4A9AKgh/AxNa+vpxrE3n9AVQ+xdJ2VwJFKMT
X-Gm-Message-State: AOJu0YxitVf5xtB0Gp+V1Q0+zkmRXe3F9UQcQgsnOhpxppftXLXaBwmo
	lDxHEHyQdJy6Suejq16zlZMGlfQiL2etzkJ5WM08o1dML3QvVI7/wUuEArKCSIfn35KVWSPXP9w
	kRb5ck4xXfRYCzhMLj3IZr5KN6mU=
X-Google-Smtp-Source: AGHT+IF5AvJPN1nLtJpVOdCwSE5Uoo3Z1JuK9o14kzh5T3kHejRuNUrZebqYyj1iqsS+CjhNMTaJjWw45DcbJZRfpqE=
X-Received: by 2002:a05:6122:a09:b0:4b6:cc19:42dc with SMTP id
 9-20020a0561220a0900b004b6cc1942dcmr1180312vkn.11.1707265292993; Tue, 06 Feb
 2024 16:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com>
 <ZbjAod-tqcjQJrTo@krava> <CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2srJnef0ZrQkZew@mail.gmail.com>
 <d320eb5c-3276-49f9-879a-fb318164d4f1@linux.dev>
In-Reply-To: <d320eb5c-3276-49f9-879a-fb318164d4f1@linux.dev>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 6 Feb 2024 19:21:22 -0500
Message-ID: <CAE5sdEgWJHyRyS8jVJtZ8awPbyDZY+Pcc-27nYYXtZFbEfrreA@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: Prevent recursive deadlocks in BPF programs
 attached to spin lock helpers using fentry/ fexit
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, 
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"Williams, Dan" <djwillia@vt.edu>, "Somaraju, Sai Roop" <sairoop@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>, 
	"Craun, Milo" <miloc@vt.edu>, "sidchintamaneni@vt.edu" <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 14:09, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
> On 2/2/24 4:21 PM, Siddharth Chintamaneni wrote:
> > On Tue, 30 Jan 2024 at 04:25, Jiri Olsa <olsajiri@gmail.com> wrote:
> >> On Wed, Jan 24, 2024 at 10:43:32AM -0500, Siddharth Chintamaneni wrote:
> >>> While we were working on some experiments with BPF trampoline, we came
> >>> across a deadlock scenario that could happen.
> >>>
> >>> A deadlock happens when two nested BPF programs tries to acquire the
> >>> same lock i.e, If a BPF program is attached using fexit to
> >>> bpf_spin_lock or using a fentry to bpf_spin_unlock, and it then
> >>> attempts to acquire the same lock as the previous BPF program, a
> >>> deadlock situation arises.
> >>>
> >>> Here is an example:
> >>>
> >>> SEC(fentry/bpf_spin_unlock)
> >>> int fentry_2{
> >>>    bpf_spin_lock(&x->lock);
> >>>    bpf_spin_unlock(&x->lock);
> >>> }
> >>>
> >>> SEC(fentry/xxx)
> >>> int fentry_1{
> >>>    bpf_spin_lock(&x->lock);
> >>>    bpf_spin_unlock(&x->lock);
> >>> }
> >> hi,
> >> looks like valid issue, could you add selftest for that?
> > Hello,
> > I have added selftest for the deadlock scenario.
> >
> >> I wonder we could restrict just programs that use bpf_spin_lock/bpf_spin_unlock
> >> helpers? I'm not sure there's any useful use case for tracing spin lock helpers,
> >> but I think we should at least try this before we deny it completely
> >>
> > If we restrict programs (attached to spinlock helpers) that use
> > bpf_spin_lock/unlock helpers, there could be a scenario where a helper
> > function called within the program has a BPF program attached that
> > tries to acquire the same lock.
> >
> >>> To prevent these cases, a simple fix could be adding these helpers to
> >>> denylist in the verifier. This fix will prevent the BPF programs from
> >>> being loaded by the verifier.
> >>>
> >>> previously, a similar solution was proposed to prevent recursion.
> >>> https://lore.kernel.org/lkml/20230417154737.12740-2-laoar.shao@gmail.com/
> >> the difference is that __rcu_read_lock/__rcu_read_unlock are called unconditionally
> >> (always) when executing bpf tracing probe, the problem you described above is only
> >> for programs calling spin lock helpers (on same spin lock)
> >>
> >>> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> >>> ---
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index 65f598694d55..8f1834f27f81 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
> >>>   BTF_ID(func, __rcu_read_lock)
> >>>   BTF_ID(func, __rcu_read_unlock)
> >>>   #endif
> >>> +#if defined(CONFIG_DYNAMIC_FTRACE)
> >> why the CONFIG_DYNAMIC_FTRACE dependency?
> > As we described in the self-tests, nesting of multiple BPF programs
> > could only happen with fentry/fexit programs when DYNAMIC_FTRACE is
> > enabled. In other scenarios, when DYNAMIC_FTRACE is disabled, a BPF
> > program cannot be attached to any helper functions.
> >> jirka
> >>
> >>> +BTF_ID(func, bpf_spin_lock)
> >>> +BTF_ID(func, bpf_spin_unlock)
> >>> +#endif
> >>>   BTF_SET_END(btf_id_deny)
>
> Currently, we already have 'notrace' marked to bpf_spin_lock
> and bpf_spin_unlock:
>
> notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
> {
>          __bpf_spin_lock_irqsave(lock);
>          return 0;
> }
> notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
> {
>          __bpf_spin_unlock_irqrestore(lock);
>          return 0;
> }
>
> But unfortunately, BPF_CALL_* macros put notrace to the static
> inline function ____bpf_spin_lock()/____bpf_spin_unlock(), and not
> to static function bpf_spin_lock()/bpf_spin_unlock().
>
> I think the following is a better fix and reflects original
> intention:

My bad, I somehow incorrectly tested the fix using the notrace macro
and didn't realize that it is because of inlining. You are right, and
I agree that the proposed solution fixes the unintended bug.



>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fee070b9826e..779f8ee71607 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -566,6 +566,25 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
>   #define BPF_CALL_4(name, ...)  BPF_CALL_x(4, name, __VA_ARGS__)
>   #define BPF_CALL_5(name, ...)  BPF_CALL_x(5, name, __VA_ARGS__)
>
> +#define NOTRACE_BPF_CALL_x(x, name, ...)                                              \
> +       static __always_inline                                                 \
> +       u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
> +       typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
> +       notrace u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
> +       notrace u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))          \
> +       {                                                                      \
> +               return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
> +       }                                                                      \
> +       static __always_inline                                                 \
> +       u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
> +
> +#define NOTRACE_BPF_CALL_0(name, ...)  NOTRACE_BPF_CALL_x(0, name, __VA_ARGS__)
> +#define NOTRACE_BPF_CALL_1(name, ...)  NOTRACE_BPF_CALL_x(1, name, __VA_ARGS__)
> +#define NOTRACE_BPF_CALL_2(name, ...)  NOTRACE_BPF_CALL_x(2, name, __VA_ARGS__)
> +#define NOTRACE_BPF_CALL_3(name, ...)  NOTRACE_BPF_CALL_x(3, name, __VA_ARGS__)
> +#define NOTRACE_BPF_CALL_4(name, ...)  NOTRACE_BPF_CALL_x(4, name, __VA_ARGS__)
> +#define NOTRACE_BPF_CALL_5(name, ...)  NOTRACE_BPF_CALL_x(5, name, __VA_ARGS__)
> +
>   #define bpf_ctx_range(TYPE, MEMBER)                                            \
>          offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
>   #define bpf_ctx_range_till(TYPE, MEMBER1, MEMBER2)                             \
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4db1c658254c..87136e27a99a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -334,7 +334,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
>          __this_cpu_write(irqsave_flags, flags);
>   }
>
> -notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
> +NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
>   {
>          __bpf_spin_lock_irqsave(lock);
>          return 0;
> @@ -357,7 +357,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
>          local_irq_restore(flags);
>   }
>
> -notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
> +NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
>   {
>          __bpf_spin_unlock_irqrestore(lock);
>          return 0;
>
>
> Macros NOTRACE_BPF_CALL_*() could be consolated with BPF_CALL_*() but I think
> a separate macro might be easier to understand.
>
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > ---
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 65f598694d55..ffc2515195f1 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20617,6 +20617,10 @@ BTF_ID(func, preempt_count_sub)
> >   BTF_ID(func, __rcu_read_lock)
> >   BTF_ID(func, __rcu_read_unlock)
> >   #endif
> > +#ifdef CONFIG_DYNAMIC_FTRACE
> > +BTF_ID(func, bpf_spin_lock)
> > +BTF_ID(func, bpf_spin_unlock)
> > +#endif
> >   BTF_SET_END(btf_id_deny)
> >
> >   static bool can_be_sleepable(struct bpf_prog *prog)
> [...]

