Return-Path: <bpf+bounces-21690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16188502CA
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 07:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC121F23A55
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 06:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDC18030;
	Sat, 10 Feb 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWWJq74U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8463B3
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707547749; cv=none; b=LSCJzIU4grK4SToDAn/gWIF8dHDdUgUaxKzC7bHnoMPC+LYAFMKgoGXCSW/ftpsylE4jce2QkQCIQra38yt7hRxqGYFDipZqRkehNyJwrDbIDqV8VQpB83hrDsk4Q7zza1pndAGozV5jM4u4NSjE6DgXsP/+bjSW3FEe0EwRixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707547749; c=relaxed/simple;
	bh=Jpc+cOMyE+4DVBT+NwwqbHK7nDDQGgTpyehcPVL5B3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnDuFVUDRzlfQeS7Eayszt7QWgzTBMhgno8iWN35YNWWkwNIheOe/g2RV0sQtyDEO4rkE7Nu3IB8DXGObEimBXZ39lK4MKMCeWAXaoa6wtrlzhPytK8/r0G05YTyT1hZYO8p5wOaECJzywcnVer9ALYtho6OLeOTCZPDaETn4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWWJq74U; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a3566c0309fso193125666b.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 22:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707547746; x=1708152546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iiz6UJOuXTimhdLrSPYSuLISbwbt12FK3FTUuxprYg4=;
        b=bWWJq74UlOADgXMEyvVUO9mLEvVzQR0HlOst7HQuODF8mwe/SLtHUIXEY/yDffXDi6
         FW0zIN9VWMpnTrcDpykQ93BZrWuoz2O3uuoAXvbYRlm/0F631+ufSZDZzRsxk66cv+Ws
         Z6L8dF3EXvYL/FNugv/mbqUFfcog2YBymokUKv/EnNBCK9ucvN7hj301fmvnq07xx2Mn
         WvkRfm/WOA6L6vFlw81g7F2SbkON5dbOev2Rr++pGww/SYK0Dnj+XG//LkqS5f+tNkfE
         XvBcfnKxNrzsskf8W56YceeIEbFhMZMGV3pnFlTiis6zEqI0gR+WivFDoYesgl1qz6Za
         yi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707547746; x=1708152546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iiz6UJOuXTimhdLrSPYSuLISbwbt12FK3FTUuxprYg4=;
        b=Zp0yHGbpHXLEaAMF8jKTBPB3Fs3F3uQgNFGyJ3reuNSKV6SRRQxT9+2LoVtFVAKShq
         7TGLyEPa+YV21RZ/uiW3ifolgL0VEJPQTp5KPDcu5vXb5guOTfR8Wr9RH1LH7fjfpbOc
         FBVo4M8Jhrh2Q/Zyc2zSXzwM1mt+YKXZ+xhCwfxbqp89wpexz7HdZJIwddm+8YyYZkfH
         lXAqjRxkMBhc19pu7FoiErN/oMuE3UVAYtBI05mbV1bdjuDa3uf8U9dH4+NU6QJOnQ7w
         8v7TkRenaPFYlClufFP0AeYlPhT3iBFBnyq0vabYUlwfFcrn9mor0O71+jOpYF3uQIf2
         xEdw==
X-Gm-Message-State: AOJu0YxtP+tnAXbejgybuWXO0Q7D7Uri6z07upcJVRJlgk/s4khM0mC3
	QMU3HDCmTQ9gTGYvNvRC2g/AT+WEusk+5APxgRvXppWVF/g2rwdliUZgod1x2hK/j5JCDlm8z5h
	pQ19srewavm10ZNzJhhyzoPtxmGs=
X-Google-Smtp-Source: AGHT+IFM+AYQtMNCnNgU3WiABHcULOys+X0RhN6dHtv/2IRzmhGaEYWSe2shmanqvrDwbaXCmRSSJod9OuVhw8TIQe4=
X-Received: by 2002:a17:906:d296:b0:a3c:14f1:972b with SMTP id
 ay22-20020a170906d29600b00a3c14f1972bmr831820ejb.50.1707547745573; Fri, 09
 Feb 2024 22:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-8-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 07:48:29 +0100
Message-ID: <CAP01T75sq=G5pfYvsYuxfdoFGOqSGrNcamCyA0posFA9pxNWRA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/20] bpf: Add x86-64 JIT support for
 PROBE_MEM32 pseudo instructions.
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
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW] instructions.
> They are similar to PROBE_MEM instructions with the following differences:
> - PROBE_MEM has to check that the address is in the kernel range with
>   src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE check
> - PROBE_MEM doesn't support store
> - PROBE_MEM32 relies on the verifier to clear upper 32-bit in the register
> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in %r12 in the prologue)
>   Due to bpf_arena constructions such %r12 + %reg + off16 access is guaranteed
>   to be within arena virtual range, so no address check at run-time.
> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop.
>   When LDX faults the destination register is zeroed.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Just a potential issue with tail calls, but otherwise lgtm so:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  arch/x86/net/bpf_jit_comp.c | 183 +++++++++++++++++++++++++++++++++++-
>  include/linux/bpf.h         |   1 +
>  include/linux/filter.h      |   3 +
>  3 files changed, 186 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e1390d1e331b..883b7f604b9a 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -113,6 +113,7 @@ static int bpf_size_to_x86_bytes(int bpf_size)
>  /* Pick a register outside of BPF range for JIT internal work */
>  #define AUX_REG (MAX_BPF_JIT_REG + 1)
>  #define X86_REG_R9 (MAX_BPF_JIT_REG + 2)
> +#define X86_REG_R12 (MAX_BPF_JIT_REG + 3)
>
> [...]
> +       arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
> +
>         detect_reg_usage(insn, insn_cnt, callee_regs_used,
>                          &tail_call_seen);
>
> @@ -1172,8 +1300,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>                 push_r12(&prog);
>                 push_callee_regs(&prog, all_callee_regs_used);
>         } else {
> +               if (arena_vm_start)
> +                       push_r12(&prog);

I believe since this is done on entry for arena_vm_start, we need to
do matching pop_r12 in
emit_bpf_tail_call_indirect and emit_bpf_tail_call_direct before tail
call, unless I'm missing something.
Otherwise r12 may be bad after prog (push + set to arena_vm_start) ->
tail call -> exit (no pop of r12 back from stack).

>                 push_callee_regs(&prog, callee_regs_used);
>         }
> +       if (arena_vm_start)
> +               emit_mov_imm64(&prog, X86_REG_R12,
> +                              arena_vm_start >> 32, (u32) arena_vm_start);
>
>         ilen = prog - temp;
>         if (rw_image)
> @@ -1564,6 +1697,52 @@ st:                      if (is_imm8(insn->off))
>                         emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>                         break;
>
> +               case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> +               case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> +               case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> +               case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> +                       start_of_ldx = prog;
> +                       emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
> +                       goto populate_extable;
> +
> +                       /* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
> +               case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
> +               case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> +               case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> +               case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> +               case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> +               case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> +               case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> +               case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> +                       start_of_ldx = prog;
> +                       if (BPF_CLASS(insn->code) == BPF_LDX)
> +                               emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> +                       else
> +                               emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
> +populate_extable:
> +                       {
> +                               struct exception_table_entry *ex;
> +                               u8 *_insn = image + proglen + (start_of_ldx - temp);
> +                               s64 delta;
> +
> +                               if (!bpf_prog->aux->extable)
> +                                       break;
> +
> +                               ex = &bpf_prog->aux->extable[excnt++];
> +
> +                               delta = _insn - (u8 *)&ex->insn;
> +                               /* switch ex to rw buffer for writes */
> +                               ex = (void *)rw_image + ((void *)ex - (void *)image);
> +
> +                               ex->insn = delta;
> +
> +                               ex->data = EX_TYPE_BPF;
> +
> +                               ex->fixup = (prog - start_of_ldx) |
> +                                       ((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
> +                       }
> +                       break;
> +
>                         /* LDX: dst_reg = *(u8*)(src_reg + off) */
>                 case BPF_LDX | BPF_MEM | BPF_B:
>                 case BPF_LDX | BPF_PROBE_MEM | BPF_B:
> @@ -2036,6 +2215,8 @@ st:                       if (is_imm8(insn->off))
>                                 pop_r12(&prog);
>                         } else {
>                                 pop_callee_regs(&prog, callee_regs_used);
> +                               if (arena_vm_start)
> +                                       pop_r12(&prog);
>                         }

... Basically this if condition copied to those two other places.

> [...]

