Return-Path: <bpf+bounces-42992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C39AD95A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A952827D2
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6341C79;
	Thu, 24 Oct 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEv41LkP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5E2C9A
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734013; cv=none; b=QGBxmEVOM9QGR0lJHsB7wVW7cwxRmKcAg+6yKNNs+dY4vVGz38vIJpjhPyhvAeZLADGcufItdiacZxdD8Ewwntc29RRP+cOrpH5b0R7JxMpxssWoXYL/hJ57rEO13bmqZEdhkIS+7mS4u3pNGWWifPiBpgUjaudBxvDmKytc7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734013; c=relaxed/simple;
	bh=HxK26J9xbp+r2eG95VkfSMWF0pcEmQeQkKQqnwC9Vk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re+xvG3V/YcTidbOSqAy+d7m/FDBt5dekZGtoGG8nrpFC6+LWBFonfvCazYrgsIOY57JfAqcUNWMKO2B/gDI3yvof2fv6pFU+3FPnI0tu02txlHDLzgJfM0FLiKvTZmKYTJMqB9+nWK+EpoXxAdQ/u3T042Ya4BMFh+3gpTqqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEv41LkP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d41894a32so249509f8f.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729734009; x=1730338809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR715dE3uzKXB3emTQiy4YCPZbTqxpQB6RGIoIRd39o=;
        b=gEv41LkPzzQ9Ss9SNP4LHPFofsA6qwR2iSLwC81CGlEEkO4/n9iU2A6GPHrqYyWOHU
         yVb3hQLaOvZr5UxDHYmoB46jIJ5H/66La/KseNx/9tlwIhflfWeXRDde4UUg5eKQ/Kni
         2z4Ou9Nw9Z33sPNr3XDRjeEUYBYjVC/62yEfRBzkdY1QNyPViqkq+PNzGoFKQ03ZXEyN
         D1KGICrqRrQn0iKKwHw9yCdyADt0dFYnsg2/6S29+SHoMjq+fXXGO90YlYx3Y8Piy5q2
         VeXpv8FePsvWWxAx4qsvlULyMg7n5PeOUCzkjbcf4T8rp0DSm+a3oA6QLve2hQ7OWU4+
         nyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729734009; x=1730338809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR715dE3uzKXB3emTQiy4YCPZbTqxpQB6RGIoIRd39o=;
        b=UigWJxDpoq5weK5KNhfNIvqOwf6E0WvVts57ZupJ0aLyjcyKP5oz6ZLkzGdbku27UR
         HRtKwKskjqkLMi+llsYwgoekxhAUAMDWGqIoAc+Nqxz6C9tfXe1kd4QEChvwWxTLDGfi
         Gbzl5dE+KRAnqmlanOk9m07f7nEd8mmX0v7Hpo0sMh2JI3SzUpq/cHlCqlYI83ROLuI8
         zp7H4PFSRy7tOHTcY0pWiUB+vS9dPlcknANPhgawSSKGc69sTxJ86aOIM/FdKV8xGea8
         hQWf3S6YVLpzBooISJdyR+1qVFyzD46dAQj/7maTzZIYtaOHqF7/g1nPbkLOvxtaCBdj
         s5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN+3QdSbaMLszW5bgBP43trUNV3xYr0wjs0biUwY4qza9p/uC2hxPIiXBEVG/p61nf1ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoPQShdvk+r7wWU2+FBP2qd13n3lVbcuabi5W5UcjHODbKoW0F
	jtBdW0BqZTB3INj6ws3N/dAnoY7Or0CP3othkBBApzPBA/Z/pSeUTCLzEtPJsHgyENwOZoSb9MO
	h3JiLy3zLxJJf0zcQUEl9iWsqqnY=
X-Google-Smtp-Source: AGHT+IEiZsNT+QOkzhetvTv9aCgxBfS58o2Y4F1BMq6mGoHo585CHgYGyGYU4N2y2bZvSPa8dp2EaqmoZp4LwJlC0J0=
X-Received: by 2002:adf:e602:0:b0:37d:43a8:dee0 with SMTP id
 ffacd0b85a97d-3803ac7d59bmr163239f8f.17.1729734009398; Wed, 23 Oct 2024
 18:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023210437.2266063-1-vadfed@meta.com>
In-Reply-To: <20241023210437.2266063-1-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Oct 2024 18:39:58 -0700
Message-ID: <CAADnVQ+YRj2_wWYkT20yo+5+G5B11d3NCZ8TBuCKJz+SJo37iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_get_hw_counter kfunc
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:05=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().

arch_get_hw_counter is a great idea.

> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  arch/x86/net/bpf_jit_comp.c   | 23 +++++++++++++++++++++++
>  arch/x86/net/bpf_jit_comp32.c | 11 +++++++++++
>  kernel/bpf/helpers.c          |  7 +++++++
>  kernel/bpf/verifier.c         | 11 +++++++++++
>  4 files changed, 52 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..55595a0fa55b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2126,6 +2126,29 @@ st:                      if (is_imm8(insn->off))
>                 case BPF_JMP | BPF_CALL: {
>                         u8 *ip =3D image + addrs[i - 1];
>
> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&=
 !imm32) {
> +                               if (insn->dst_reg =3D=3D 1) {
> +                                       struct cpuinfo_x86 *c =3D &cpu_da=
ta(get_boot_cpu_id());
> +
> +                                       /* Save RDX because RDTSC will us=
e EDX:EAX to return u64 */
> +                                       emit_mov_reg(&prog, true, AUX_REG=
, BPF_REG_3);
> +                                       if (cpu_has(c, X86_FEATURE_LFENCE=
_RDTSC))
> +                                               EMIT_LFENCE();
> +                                       EMIT2(0x0F, 0x31);
> +
> +                                       /* shl RDX, 32 */
> +                                       maybe_emit_1mod(&prog, BPF_REG_3,=
 true);
> +                                       EMIT3(0xC1, add_1reg(0xE0, BPF_RE=
G_3), 32);
> +                                       /* or RAX, RDX */
> +                                       maybe_emit_mod(&prog, BPF_REG_0, =
BPF_REG_3, true);
> +                                       EMIT2(0x09, add_2reg(0xC0, BPF_RE=
G_0, BPF_REG_3));
> +                                       /* restore RDX from R11 */
> +                                       emit_mov_reg(&prog, true, BPF_REG=
_3, AUX_REG);

This doesn't match
static inline u64 __arch_get_hw_counter(s32 clock_mode,
                                        const struct vdso_data *vd)
{
        if (likely(clock_mode =3D=3D VDSO_CLOCKMODE_TSC))
                return (u64)rdtsc_ordered() & S64_MAX;

- & is missing
- rdtsc vs rdtscp

but the later one is much slower (I was told).

So maybe instead of arch_get_hw_counter() it should be modelled
as JIT of sched_clock() ?

> +
> +                                       break;
> +                               }
> +                       }
> +
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->sta=
ck_depth);
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
> index de0f9e5f9f73..c36ff18a044b 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -2091,6 +2091,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
>                         if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
>                                 goto notyet;
>
> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&=
 !imm32) {
> +                               if (insn->dst_reg =3D=3D 1) {
> +                                       struct cpuinfo_x86 *c =3D &cpu_da=
ta(get_boot_cpu_id());
> +
> +                                       if (cpu_has(c, X86_FEATURE_LFENCE=
_RDTSC))
> +                                               EMIT3(0x0F, 0xAE, 0xE8);
> +                                       EMIT2(0x0F, 0x31);
> +                                       break;
> +                               }
> +                       }
> +
>                         if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>                                 int err;
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5c3fdb29c1b1..6624b2465484 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <asm/vdso/gettimeofday.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, =
u32 dst__sz, const void __user
>         return ret + 1;
>  }
>
> +__bpf_kfunc int bpf_get_hw_counter(void)
> +{
> +       return __arch_get_hw_counter(1, NULL);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3112,6 +3118,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT=
 | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_get_kmem_cache)
> +BTF_ID_FLAGS(func, bpf_get_hw_counter, KF_FASTCALL)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f514247ba8ba..5f0e4f91ce48 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11260,6 +11260,7 @@ enum special_kfunc_type {
>         KF_bpf_iter_css_task_new,
>         KF_bpf_session_cookie,
>         KF_bpf_get_kmem_cache,
> +       KF_bpf_get_hw_counter,
>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -11326,6 +11327,7 @@ BTF_ID(func, bpf_session_cookie)
>  BTF_ID_UNUSED
>  #endif
>  BTF_ID(func, bpf_get_kmem_cache)
> +BTF_ID(func, bpf_get_hw_counter)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -20396,6 +20398,15 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                    desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_=
cast]) {
>                 insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>                 *cnt =3D 1;
> +       } else if (IS_ENABLED(CONFIG_X86) &&

It's better to introduce bpf_jit_inlines_kfunc_call()
similar to bpf_jit_inlines_helper_call().

> +                  desc->func_id =3D=3D special_kfunc_list[KF_bpf_get_hw_=
counter]) {
> +               insn->imm =3D 0;
> +               insn->code =3D BPF_JMP | BPF_CALL;
> +               insn->src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> +               insn->dst_reg =3D 1; /* Implement enum for inlined fast c=
alls */

Yes. Pls do it cleanly from the start.

Why rewrite though?
Can JIT match the addr of bpf_get_hw_counter ?
And no need to rewrite call insn ?

