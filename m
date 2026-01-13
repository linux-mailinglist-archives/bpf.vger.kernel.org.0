Return-Path: <bpf+bounces-78743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC08D1ABBC
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AECE1302C8EF
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4148350285;
	Tue, 13 Jan 2026 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgD7C9SC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1D329C74
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326624; cv=none; b=PNFt7Sff4D/5ZV2eD6MFOecGjdCgDPX81dcrJkYTayxbEX99bN6b+ujrWNOqpMgwryCfF0fLlbQPd9YddWKUIuYRykShzYw7gfxCuLInWiImi4M7KbKC3v5U+BJENiEhBfG5uf02p6XNu4avZP5NZO9m/NnkiIWhVRtPa6qA6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326624; c=relaxed/simple;
	bh=yvtATxvntIONIeu7tCkO7/DBIbbWQzwIrQI8gP5er6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxXmL3BOq39Qn8eNz6D9HLE8d8/XbI0CjR0+0md1n1zyOZf+PvQ0S5Uz7c2Jq5iCvCqnF/gj6JYSasAFGMusT1o85gk0IynmvsZDg0E2Hi0LtmXgeGAvH0pSOi6dYW6HvnK9qYbGtcVxkgbPbHT+DIE9UEm26W8Xrlmwxn520LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgD7C9SC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so6974835e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768326621; x=1768931421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTSAaAKJKjmdyoQwz5h5Y5dDJTSFPiip4+2oV5TweqA=;
        b=TgD7C9SC2JHamOu+/eDepe5qbqYBQw2PA5m2W24d9Gf8s1yQZ7j/+15wlkaFzrcYBj
         uegHkCVtRj63LommEiisr2NPTaYDCy6KBDY7hc1UQg9tdSD7nt9GQWK/SytBx3SHCsle
         widddKm6xDl7PPriKnmRmcTfbyg4kguCnAida5NbHmuPZmdU5WomsGx/NDLI3Zajh+PR
         B925lsu3mlScs+R5EpriJzm7k7WyOb1rVgOW7BtULxxA3LFMXP74F/4fIr8z08XMkqQL
         2Z7hJhKcsqWX2R3VhH+R9SSDKfLVNbMdBndywBkUSb5vOoPotmt9K/J91L+NYfgu/DqA
         CBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768326621; x=1768931421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mTSAaAKJKjmdyoQwz5h5Y5dDJTSFPiip4+2oV5TweqA=;
        b=oEkRwD8TDKnbJGplCc+IEhP6Y/gI7v4YjjAhI+RWS+/V9qnQPUjeW37vlxDm9Ii3XA
         y9LoNyBPcqSo9Iom9EncP6ZhNh7Q9IQ/5JJKw+abmKa6/VXwf+Pi7yyFcmWAxIfCO8Me
         UbxMkJdtxATwlM4lFO+QWr6aDJ6l3M2Ng8Q1Wmg4Jh6XSPedJpbDQ53uqsyS5QcoAxjA
         xxrdWkFRbFRMg7HHepiyj4yQ6PogJH1bqmDvnt7GtyuINs0/yNj1YmK2eSsUcOsuoNM3
         lcKykLaqxCNPI9G3+H3KRf0BECArw2zDm8FGTqbsW7l/Yy/p+RDq4oh+dWYFxskLzVWs
         uDnw==
X-Forwarded-Encrypted: i=1; AJvYcCUpVrag+dgHNZxhlczs3s58doowjLmLW0qOeCuTRobmPgkAXnw6+IwsnhrqsjHiA8BKBew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSOxdbjPr6cSDqfOsmbsrRDmjkc/dPlcqm9hjySkqXrZdQyL6
	PVTmHceK87E6FeyEq9xZOpx0WYem/MgqLM818s7xqLn0sISsJG1dHYHH2HxBZqdXnAe05YO03tN
	1FODi8LIS26gNYZPhj3VSdLGzniHYPSM=
X-Gm-Gg: AY/fxX6ju1nw6fZ+cZE7hmg9ox/0eFF3Ez+Q6Ctx6pJU42oe/62OaJ14yrdX83fmE4F
	Su6rmpzUWEGWa2WHP9GTNAGmq9mp1cjnJxT+Kjr1wZ2IbJggwT7A+kMFSVRoPOVKMOVezCqfbOe
	8/p9u3+WSBs+yhJNNpdXdhAf2eztEuorxLYm3kaDz1hVpTMRpZFmtPxz1YllEWr5a85gQFYhQSb
	zGJ65eNzPlyohMddadz87f/cIaPijILoWKQtXnxXLKxg3B8tXdANxFDwGjm4l+IHND702e4o9m8
	Jjf0X+inzPmbLujSYg+9ZSchnkir
X-Received: by 2002:a05:600c:35c3:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-47ee338c150mr230355e9.27.1768326621287; Tue, 13 Jan 2026
 09:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112104529.224645-1-dongml2@chinatelecom.cn> <20260112104529.224645-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260112104529.224645-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 09:50:09 -0800
X-Gm-Features: AZwV_Qi9no7Gk6JTVzhk-tHSf6BaxSAoq33DCAhPs2svUU2YlMOpDhNV_kI_PVY
Message-ID: <CAADnVQLMztSfxCSxak900PVN+CtiN0FF=hkRcB8cHKiHipd4Dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 2:45=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
>
> In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> we can read the current_task directly.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - handle the !CONFIG_SMP case
>
> v3:
> - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
>   x86_64 JIT.
> ---
>  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d44c5d06623..12e99171afd8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct b=
pf_verifier_env *env, s32 imm)
>         switch (imm) {
>  #ifdef CONFIG_X86_64
>         case BPF_FUNC_get_smp_processor_id:
> +       case BPF_FUNC_get_current_task_btf:
> +       case BPF_FUNC_get_current_task:
>                 return env->prog->jit_requested && bpf_jit_supports_percp=
u_insn();
>  #endif
>         default:
> @@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> +
> +               /* Implement bpf_get_current_task() and bpf_get_current_t=
ask_btf() inline. */
> +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->=
imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> +                   verifier_inlines_helper_call(env, insn->imm)) {

Though verifier_inlines_helper_call() gates this with CONFIG_X86_64,
I think we still need explicit:
#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)

just like we did for BPF_FUNC_get_smp_processor_id.
Please check. I suspect UML will break without it.

> +#ifdef CONFIG_SMP
> +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(un=
signed long)&current_task);
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +#else
> +                       struct bpf_insn ld_current_addr[2] =3D {
> +                               BPF_LD_IMM64(BPF_REG_0, (unsigned long)&c=
urrent_task)
> +                       };
> +                       insn_buf[0] =3D ld_current_addr[0];
> +                       insn_buf[1] =3D ld_current_addr[1];
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +#endif

I wouldn't bother with !SMP.
If we need to add


On Mon, Jan 12, 2026 at 2:45=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
>
> In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> we can read the current_task directly.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - handle the !CONFIG_SMP case
>
> v3:
> - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
>   x86_64 JIT.
> ---
>  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d44c5d06623..12e99171afd8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct b=
pf_verifier_env *env, s32 imm)
>         switch (imm) {
>  #ifdef CONFIG_X86_64
>         case BPF_FUNC_get_smp_processor_id:
> +       case BPF_FUNC_get_current_task_btf:
> +       case BPF_FUNC_get_current_task:
>                 return env->prog->jit_requested && bpf_jit_supports_percp=
u_insn();
>  #endif
>         default:
> @@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> +
> +               /* Implement bpf_get_current_task() and bpf_get_current_t=
ask_btf() inline. */
> +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->=
imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> +                   verifier_inlines_helper_call(env, insn->imm)) {

Though verifier_inlines_helper_call() gates this with CONFIG_X86_64,
I think we still need explicit:
#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)

just like we did for BPF_FUNC_get_smp_processor_id.
Please check. I suspect UML will break without it.

> +#ifdef CONFIG_SMP
> +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(un=
signed long)&current_task);
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +#else
> +                       struct bpf_insn ld_current_addr[2] =3D {
> +                               BPF_LD_IMM64(BPF_REG_0, (unsigned long)&c=
urrent_task)
> +                       };
> +                       insn_buf[0] =3D ld_current_addr[0];
> +                       insn_buf[1] =3D ld_current_addr[1];
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +#endif

I wouldn't bother with !SMP.
If we need to add


On Mon, Jan 12, 2026 at 2:45=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
>
> In !CONFIG_SMP case, the percpu variable is just a normal variable, and
> we can read the current_task directly.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v4:
> - handle the !CONFIG_SMP case
>
> v3:
> - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
>   x86_64 JIT.
> ---
>  kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d44c5d06623..12e99171afd8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct b=
pf_verifier_env *env, s32 imm)
>         switch (imm) {
>  #ifdef CONFIG_X86_64
>         case BPF_FUNC_get_smp_processor_id:
> +       case BPF_FUNC_get_current_task_btf:
> +       case BPF_FUNC_get_current_task:
>                 return env->prog->jit_requested && bpf_jit_supports_percp=
u_insn();
>  #endif
>         default:
> @@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> +
> +               /* Implement bpf_get_current_task() and bpf_get_current_t=
ask_btf() inline. */
> +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->=
imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> +                   verifier_inlines_helper_call(env, insn->imm)) {

Though verifier_inlines_helper_call() gates this with CONFIG_X86_64,
I think we still need explicit:
#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)

just like we did for BPF_FUNC_get_smp_processor_id.
Please check. I suspect UML will break without it.

> +#ifdef CONFIG_SMP
> +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(un=
signed long)&current_task);
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +#else
> +                       struct bpf_insn ld_current_addr[2] =3D {
> +                               BPF_LD_IMM64(BPF_REG_0, (unsigned long)&c=
urrent_task)
> +                       };
> +                       insn_buf[0] =3D ld_current_addr[0];
> +                       insn_buf[1] =3D ld_current_addr[1];
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +#endif

I wouldn't bother with !SMP.
If we need to add defined(CONFIG_X86_64) && !defined(CONFIG_UML)
I would add && defined(CONFIG_SMP) to it.

pw-bot: cr

