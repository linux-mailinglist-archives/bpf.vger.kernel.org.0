Return-Path: <bpf+bounces-21700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8F85038A
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 09:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC67D1C220FB
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F012EAF9;
	Sat, 10 Feb 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIVBaYgG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F563B3
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707554442; cv=none; b=p9T61Vn9w/PY6rheSV8QZL5f0gAdxZbhwBHA3Bm5coIfPSNBayOISegnq/cs96Y5+/vK4FLcyX1kSYUXmBnuOOcD97B40kquqqZpxr8tkXPHmFBeH/l8bfJMu/hBxaYgP8T8laD8WhJ15Aij4JJZupnlA4S7NVrz7HEWczSlefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707554442; c=relaxed/simple;
	bh=oqYlrHQDfKd9jvW/73DfDnID9udvBre57Xo70oL6atc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndq5hcP6fPVZFAZLYAW31Z/cOCWKIhmEIAxJSjFBAvAxbRtS4j5gqwd1gitxQBdQ6/nYBWL+yVt0KxhVC1gEPlfIx2n0tFzOjOA3fKfCVWu7/mI4OFWDfN7rAzpGSo/j5qGdDI2H7jTXUmU14/cmRRx99crY9oxXtbTJffwBdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIVBaYgG; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso247192666b.2
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707554439; x=1708159239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+00sUbXiBrbWYfwTjD//uEYTOjpRrk8T2WJqJateYas=;
        b=YIVBaYgGFkbpZnlzAnQBGvsE+hgWcCyRH83zHE1NWOZBbuoMVltmQBTyEwW/ZQiOJ/
         LE7oxqGfLzVkXCjEWxvqVKAj8qpOB8fiwOVbzT05BLl8Z06EV8YxJ+Uk0MfQN51uqWi0
         hijXwmTbWYJZoPe9EBY9hdNNHh/Jx004A7IcrFtkXwYtw6DScGYV9mnvICUO5YzAwUL5
         //zvidtFugIkqz10jteTAQJxWqVmiOK6Stq7TImV3NvQW82B655hoAe4nMt271YBkjl3
         J/utBrRoJucQ8oR/z09zvnc7tlqlG4LdoEdr/3OxgdopXakGswRYeINTUjKXpfuOejP/
         w5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707554439; x=1708159239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+00sUbXiBrbWYfwTjD//uEYTOjpRrk8T2WJqJateYas=;
        b=g1oKD0vxaTQoHwKKYbAVFjxR9EtyKOdkAD/8EnN1CcMkX8raY940ZV7MjgwSONKnfA
         X8cz7RyVgiuYr18Cbe6Mt1KuUf/vUBJwOlPSDzSy2S1zynxA/bOz6DD8uJ0ekUvtTxwL
         bkspFbp2XoRyL4LbWZ8qtvBYnTo/J1WqAbYpMREI9IQUY1d4Td7EI1PkMLSU/SeBOEaL
         Z+QYrGH8nJuztk2eOGrhjmk+CHULe+KgHhbt2/9CPklch4r6UIN3ztks1c9hMIebSOnM
         cQ89t0T05o+gR9x7inmnhnu2JEsGc+4YqKVZENU+Y9uv6JjQV0W3Vp4duqXzAbmMtk3J
         OGfA==
X-Gm-Message-State: AOJu0YwLSAr3HOoBR607ZJYbkLaXHMo0WUUcvsjHMsBQ4oVKElW/pqL0
	snYKDK59ly2oDeGfMhLQGq0uJVaKtAAiDAzJ49FMptaV08SdgPReIElY2F2Ujmup4lmnNC3cMyI
	AjPnAZMSGcCchfKU/vQAA09MHppY=
X-Google-Smtp-Source: AGHT+IGb847Cq7vSucixQDqIv9VM7cHx4UAU1esLPzfRDaZfuKMed/GBnUdQ5/9IQN55Ky0UYh9naF4Of0CPfoayRgI=
X-Received: by 2002:a17:906:1b15:b0:a3b:e9c5:8a4f with SMTP id
 o21-20020a1709061b1500b00a3be9c58a4fmr1175018ejg.16.1707554438889; Sat, 10
 Feb 2024 00:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-9-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 09:40:02 +0100
Message-ID: <CAP01T76JMbnS3PSpontzWmtSZ9cs97yO772R8zpWH-eHXviLSA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/20] bpf: Add x86-64 JIT support for
 bpf_cast_user instruction.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:06, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> LLVM generates bpf_cast_kern and bpf_cast_user instructions while translating
> pointers with __attribute__((address_space(1))).
>
> rX = cast_kern(rY) is processed by the verifier and converted to
> normal 32-bit move: wX = wY
>
> bpf_cast_user has to be converted by JIT.
>
> rX = cast_user(rY) is
>
> aux_reg = upper_32_bits of arena->user_vm_start
> aux_reg <<= 32
> wX = wY // clear upper 32 bits of dst register
> if (wX) // if not zero add upper bits of user_vm_start
>   wX |= aux_reg
>

Would this be ok if the rY is somehow aligned at the 4GB boundary, and
the lower 32-bits end up being zero.
Then this transformation would confuse it with the NULL case, right?
Or do I miss something?

> JIT can do it more efficiently:
>
> mov dst_reg32, src_reg32  // 32-bit move
> shl dst_reg, 32
> or dst_reg, user_vm_start
> rol dst_reg, 32
> xor r11, r11
> test dst_reg32, dst_reg32 // check if lower 32-bit are zero
> cmove r11, dst_reg        // if so, set dst_reg to zero
>                           // Intel swapped src/dst register encoding in CMOVcc
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 41 ++++++++++++++++++++++++++++++++++++-
>  include/linux/filter.h      |  1 +
>  kernel/bpf/core.c           |  5 +++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 883b7f604b9a..a042ed57af7b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1272,13 +1272,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>         bool tail_call_seen = false;
>         bool seen_exit = false;
>         u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
> -       u64 arena_vm_start;
> +       u64 arena_vm_start, user_vm_start;
>         int i, excnt = 0;
>         int ilen, proglen = 0;
>         u8 *prog = temp;
>         int err;
>
>         arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
> +       user_vm_start = bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
>
>         detect_reg_usage(insn, insn_cnt, callee_regs_used,
>                          &tail_call_seen);
> @@ -1346,6 +1347,39 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>                         break;
>
>                 case BPF_ALU64 | BPF_MOV | BPF_X:
> +                       if (insn->off == BPF_ARENA_CAST_USER) {
> +                               if (dst_reg != src_reg)
> +                                       /* 32-bit mov */
> +                                       emit_mov_reg(&prog, false, dst_reg, src_reg);
> +                               /* shl dst_reg, 32 */
> +                               maybe_emit_1mod(&prog, dst_reg, true);
> +                               EMIT3(0xC1, add_1reg(0xE0, dst_reg), 32);
> +
> +                               /* or dst_reg, user_vm_start */
> +                               maybe_emit_1mod(&prog, dst_reg, true);
> +                               if (is_axreg(dst_reg))
> +                                       EMIT1_off32(0x0D,  user_vm_start >> 32);
> +                               else
> +                                       EMIT2_off32(0x81, add_1reg(0xC8, dst_reg),  user_vm_start >> 32);
> +
> +                               /* rol dst_reg, 32 */
> +                               maybe_emit_1mod(&prog, dst_reg, true);
> +                               EMIT3(0xC1, add_1reg(0xC0, dst_reg), 32);
> +
> +                               /* xor r11, r11 */
> +                               EMIT3(0x4D, 0x31, 0xDB);
> +
> +                               /* test dst_reg32, dst_reg32; check if lower 32-bit are zero */
> +                               maybe_emit_mod(&prog, dst_reg, dst_reg, false);
> +                               EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
> +
> +                               /* cmove r11, dst_reg; if so, set dst_reg to zero */
> +                               /* WARNING: Intel swapped src/dst register encoding in CMOVcc !!! */
> +                               maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
> +                               EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
> +                               break;
> +                       }
> +                       fallthrough;
>                 case BPF_ALU | BPF_MOV | BPF_X:
>                         if (insn->off == 0)
>                                 emit_mov_reg(&prog,
> @@ -3424,6 +3458,11 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
>         }
>  }
>
> +bool bpf_jit_supports_arena(void)
> +{
> +       return true;
> +}
> +
>  bool bpf_jit_supports_ptr_xchg(void)
>  {
>         return true;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index cd76d43412d0..78ea63002531 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -959,6 +959,7 @@ bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_jit_supports_exceptions(void);
>  bool bpf_jit_supports_ptr_xchg(void);
> +bool bpf_jit_supports_arena(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
>  bool bpf_helper_changes_pkt_data(void *func);
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 2539d9bfe369..2829077f0461 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2926,6 +2926,11 @@ bool __weak bpf_jit_supports_far_kfunc_call(void)
>         return false;
>  }
>
> +bool __weak bpf_jit_supports_arena(void)
> +{
> +       return false;
> +}
> +
>  /* Return TRUE if the JIT backend satisfies the following two conditions:
>   * 1) JIT backend supports atomic_xchg() on pointer-sized words.
>   * 2) Under the specific arch, the implementation of xchg() is the same
> --
> 2.34.1
>

