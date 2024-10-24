Return-Path: <bpf+bounces-43107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7C9AF527
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 00:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ED01F22A35
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D1200BA4;
	Thu, 24 Oct 2024 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4H4t48D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F122B674
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808114; cv=none; b=ICV34C1kExSgN59XxYh0ShiMrMm7it89TWhJwidsX9IApyRYQ6UrdW7Pwvr8Crya8rLlK8E2NObyosWVc76mB4TOhMLS2lZrbyD490tIn6k4h9PUsYFrzZeVq8X0wFqhcnnkF/DGyG5fxEsT0B4Lo4FZY6+7DwkM9hjxqhrWCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808114; c=relaxed/simple;
	bh=mVFthaggG8nx8qqS5DRrVB2ZPHz1fG08bu1EZ0lNV2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h48EeGPlbDuolMhAgVe8n7BuZvoxt24IQ/JpkCkDCxbsbdW8hj9TEVH1lWPyIL7IbT8QV0+g04E9yK+vwnbp3Yv7B2LApvDDVj79XlngEljlpFwX96ofEJiaNOw+pnlerGBHfRmGVcBmlFn0Q4JmsjZe7G8Jpe+Leuf270rzcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4H4t48D; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431695fa98bso14147925e9.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 15:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729808110; x=1730412910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBa6BYQOPoO0nhVddfcQt5/bE4ysb8ezX+LoOFh4BCA=;
        b=k4H4t48D/Rp4QyhBlzPrHoQJ5SLjA5ImfN8TJMnvcEEysDHbcTJ0h6YJQM/Zz2GdyV
         QzioE9ALG0TQIzNQZJory+7RGe/2G+A+yYIVZj2uGuBtUz+03VOF40djV5p945c0Wdkh
         Adz2BZYpZqJJXtaS8H52vZYjSsW0emoUd7v9jWheZ8HE3+CJGORJ5HsKnLkOw+NhMw8C
         Ssidtgpe9IvbMRBNwJ68Wx+XIyJur4Ee59P4P9IocDYYOlAITUSWcKBSgaWzzYSID/TH
         hHwE75NXnvtqyfIfZXo0E/PoWBbKzR59cP4qy7PhhHk4HQ7qNwBXuvG9Wg/Kq6NGblMe
         D7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808110; x=1730412910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBa6BYQOPoO0nhVddfcQt5/bE4ysb8ezX+LoOFh4BCA=;
        b=qzc4KF/PnDieh9hOsFz6SLa9ZvzPicf9inAgpKBD6/SBbPVYbS6piQ5qYWrcv/sLG3
         s7oItbhUjCKONkVwD+KE3vdndFbED6w4OgX48LNlcXQCiKc3me8EP8gPqbTslOI4/tgn
         QoTwNuv2uIDWm01SsKGXLxMCFF3limrEizZuXjvDw0A/ejetwf5WeuFn7zxqTRpKlNn4
         XKS0Xx7fLQ+gYYHeewZiFc+F++1/kudiAth/eAk65s3QUKFjR7Ps2glWO1CVCvsHj7Z0
         Y8RwQj2pOTliKcVhTDLy02Hki2Q44DAAil34mvalfzcc8RkYUScJxJBDt8MteM84azzU
         52qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtnP/huz87XLl+aOU9nwr+ve3Cc9q2NKv1J0ffJSk2aEwJMj5by2RSbnEyAEKEgS9DLw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8yrYLCl85Z9oktO4cb9GDuzMyW6p87UW9FAifcyxxuAy8PqK
	UGm0PLudGCygawxiv8Uac/+uow+Ov28DC2oAq4fNyQnPAzNFR0JxfMqRouyvcUexLwVqwIsQ3/Q
	fnThps3LBfVjVXpbZunNqCRd09Ds=
X-Google-Smtp-Source: AGHT+IEcDNCnQZyZ1vMtYuho+lr8R3c+kh4FfmbBi0pmm19yk5sSVXvGReMye7D62+gDVyddmhU04IXrYX9rp/+F1QM=
X-Received: by 2002:a05:6000:1ca:b0:37d:4527:ba1c with SMTP id
 ffacd0b85a97d-380458cd7b1mr2161093f8f.49.1729808109898; Thu, 24 Oct 2024
 15:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024205113.762622-1-vadfed@meta.com>
In-Reply-To: <20241024205113.762622-1-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Oct 2024 15:14:58 -0700
Message-ID: <CAADnVQJnM5uu-Nu-okWTwDvbPQjiYTcVrX0mmP-JUhVOFxWDVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_get_hw_counter kfunc
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 1:51=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2:
> * Fix incorrect function return value type to u64
> * Introduce bpf_jit_inlines_kfunc_call() and use it in
>   mark_fastcall_pattern_for_call() to avoid clobbering in case of
>         running programs with no JIT (Eduard)
> * Avoid rewriting instruction and check function pointer directly
>   in JIT (Alexei)
> * Change includes to fix compile issues on non x86 architectures
> ---
>  arch/x86/net/bpf_jit_comp.c   | 30 ++++++++++++++++++++++++++++++
>  arch/x86/net/bpf_jit_comp32.c | 16 ++++++++++++++++
>  include/linux/filter.h        |  1 +
>  kernel/bpf/core.c             | 11 +++++++++++
>  kernel/bpf/helpers.c          |  7 +++++++
>  kernel/bpf/verifier.c         |  4 +++-
>  6 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..a8cffbb19cf2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1412,6 +1412,8 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8=
 src_reg, bool is64, u8 op)
>  #define LOAD_TAIL_CALL_CNT_PTR(stack)                          \
>         __LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
>
> +u64 bpf_get_hw_counter(void);

just add it to some .h

>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
>                   int oldproglen, struct jit_context *ctx, bool jmp_paddi=
ng)
>  {
> @@ -2126,6 +2128,26 @@ st:                      if (is_imm8(insn->off))
>                 case BPF_JMP | BPF_CALL: {
>                         u8 *ip =3D image + addrs[i - 1];
>
> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +                           imm32 =3D=3D BPF_CALL_IMM(bpf_get_hw_counter)=
) {
> +                               /* Save RDX because RDTSC will use EDX:EA=
X to return u64 */
> +                               emit_mov_reg(&prog, true, AUX_REG, BPF_RE=
G_3);
> +                               if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC=
))
> +                                       EMIT_LFENCE();
> +                               EMIT2(0x0F, 0x31);
> +
> +                               /* shl RDX, 32 */
> +                               maybe_emit_1mod(&prog, BPF_REG_3, true);
> +                               EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32=
);
> +                               /* or RAX, RDX */
> +                               maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_=
3, true);
> +                               EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF=
_REG_3));
> +                               /* restore RDX from R11 */
> +                               emit_mov_reg(&prog, true, BPF_REG_3, AUX_=
REG);
> +
> +                               break;
> +                       }
> +
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->sta=
ck_depth);
> @@ -3652,3 +3674,11 @@ u64 bpf_arch_uaddress_limit(void)
>  {
>         return 0;
>  }
> +
> +/* x86-64 JIT can inline kfunc */
> +bool bpf_jit_inlines_helper_call(s32 imm)

kfunc

> +{
> +       if (imm =3D=3D BPF_CALL_IMM(bpf_get_hw_counter))
> +               return true;
> +       return false;
> +}
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
> index de0f9e5f9f73..66525cb1892c 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -1656,6 +1656,8 @@ static int emit_kfunc_call(const struct bpf_prog *b=
pf_prog, u8 *end_addr,
>         return 0;
>  }
>
> +u64 bpf_get_hw_counter(void);
> +
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>                   int oldproglen, struct jit_context *ctx)
>  {
> @@ -2094,6 +2096,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
>                         if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>                                 int err;
>
> +                               if (imm32 =3D=3D BPF_CALL_IMM(bpf_get_hw_=
counter)) {
> +                                       if (boot_cpu_has(X86_FEATURE_LFEN=
CE_RDTSC))
> +                                               EMIT3(0x0F, 0xAE, 0xE8);
> +                                       EMIT2(0x0F, 0x31);
> +                                       break;
> +                               }
> +
>                                 err =3D emit_kfunc_call(bpf_prog,
>                                                       image + addrs[i],
>                                                       insn, &prog);
> @@ -2621,3 +2630,10 @@ bool bpf_jit_supports_kfunc_call(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_inlines_helper_call(s32 imm)

kfunc

> +{
> +       if (imm =3D=3D BPF_CALL_IMM(bpf_get_hw_counter))
> +               return true;
> +       return false;
> +}
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 7d7578a8eac1..8bdd5e6b2a65 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1111,6 +1111,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
>  bool bpf_jit_needs_zext(void);
>  bool bpf_jit_inlines_helper_call(s32 imm);
> +bool bpf_jit_inlines_kfunc_call(s32 imm);
>  bool bpf_jit_supports_subprog_tailcalls(void);
>  bool bpf_jit_supports_percpu_insn(void);
>  bool bpf_jit_supports_kfunc_call(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 233ea78f8f1b..ab6a2452ade0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2965,6 +2965,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
>         return false;
>  }
>
> +/* Return true if the JIT inlines the call to the kfunc corresponding to
> + * the imm.
> + *
> + * The verifier will not patch the insn->imm for the call to the helper =
if
> + * this returns true.
> + */
> +bool __weak bpf_jit_inlines_kfunc_call(s32 imm)
> +{
> +       return false;
> +}
> +
>  /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls.=
 */
>  bool __weak bpf_jit_supports_subprog_tailcalls(void)
>  {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5c3fdb29c1b1..f7bf3debbcc4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <vdso/datapage.h>
>
>  #include "../../lib/kstrtox.h"
>
> @@ -3023,6 +3024,11 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, =
u32 dst__sz, const void __user
>         return ret + 1;
>  }
>
> +__bpf_kfunc u64 bpf_get_hw_counter(void)
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
> index f514247ba8ba..428e7b84bb02 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11326,6 +11326,7 @@ BTF_ID(func, bpf_session_cookie)
>  BTF_ID_UNUSED
>  #endif
>  BTF_ID(func, bpf_get_kmem_cache)
> +BTF_ID(func, bpf_get_hw_counter)
>
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -16291,7 +16292,8 @@ static void mark_fastcall_pattern_for_call(struct=
 bpf_verifier_env *env,
>                         return;
>
>                 clobbered_regs_mask =3D kfunc_fastcall_clobber_mask(&meta=
);
> -               can_be_inlined =3D is_fastcall_kfunc_call(&meta);
> +               can_be_inlined =3D is_fastcall_kfunc_call(&meta) && !call=
->off &&

what call->off check is for?

See errors in BPF CI.

pw-bot: cr

