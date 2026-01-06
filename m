Return-Path: <bpf+bounces-77991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF9CF9D10
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D08A43082D03
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E20350A2D;
	Tue,  6 Jan 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN42gavb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D12350A16
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720131; cv=none; b=BkVFcWPLKswBvbdGYLkR2BEkPCpxz0izFBBGc7PHMfxooszqanazhZVN2Ylv7t1oUaOfLziC4Oda6zsPMHKtVjhyVMh1qVvUa4AnLJT6y9lLur+zuvfXGrqBYex21eDLpOAAVXggRlA0EbP4Nz035fjFXek5I48oKrpDrfUpdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720131; c=relaxed/simple;
	bh=mNuNf0GoqZpiXPiSKnBKwesRdbVIpfz5NaEY4M5hk40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwPudrbTDosIlOyAxQjMUFyoKtHtMqT3pFaBOH4KIU/5BEqAM34Yk8RxrlyJcR3+fJIllj+bkHvW/WlkSiDMVSYyCMj1AjHQnbfvVT6Eu80fk3JfqbJn7THv6YoWe6nTWjXfoU+EjLznSUSW/91qZqv4q/eZM78rRjfGXPVLrBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN42gavb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso2412431a12.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767720128; x=1768324928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgvwz2gDwwXwFnFWlzKsD5/iqv4laUDyFosa30OhvdU=;
        b=YN42gavbaYu8hnZRw4FdxfPvgjyymRZMAg77rae/qhRWCGgdVwTOOWMwQFCwCcvfJX
         CKdG1dp9tRJwHg6XA7u5JSQ6P1ZQQOeDlFaCKo0fkCDefeikUyyHHKtBHjZ+LSLezFD4
         Fk1DjleOrIGhXjGiQQKwXR/CKK1h3xc5dXJkrhj47/Pml6pi7cYgULeE9n14eyf0haDo
         3kQDQCblokD/gEKCWs7fc6+jnasBbKJ8C4lD/YwX2xzMeKJypFiRSgWkkCBoo9Dzsbl1
         sl9SoItgCi/WVWiH0InITZtE/H90QtBcpuXBa+U/nMVERspnNY030i+sNazU1OAkMe4e
         BEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720128; x=1768324928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xgvwz2gDwwXwFnFWlzKsD5/iqv4laUDyFosa30OhvdU=;
        b=P6ULQWW21PXI0EoKx5WW4m1UU8xZmAySpiuF579QvepkPT0C7aK0F1/77K0KlDHQEa
         hECcco5SwDWpeTAx1s/r5We/OsNmCRvajMBHXeBPw9/KwheT8y1blC1/5G4K3DZq7W2w
         3go660e05W4FFOIjnERm7J+QJqeLEzdGWjhzhvrbTfkhyDFKhoXfOtwnW/zSkWc22ySt
         r9o/IjZCDA3FToCr2/guINoreE+E+fuTXCy4Nzo2ko3f7kKPCmAX7ddDGlle9sJXhrnN
         NoBFIa9lH/BotrzNZoM4WIC1auSJ3+0E9erbbfXHiaXYIMvfcVln+Svi5l7Ayc7w//iy
         TXHQ==
X-Gm-Message-State: AOJu0YwwRHnlCvcrjU0edgo44AjwhRkAUdOSiV3t1K/A/f4vIZl4qr/n
	fdhDKVIRA9zd5ST8Vbdc61sydgilUxUPwqOxVSPl+dWUD9wJS/aHdG+LsUBK+oVSy4eQWoT0A+5
	Ft+Q2LZ//gXkjGJ6qru6aDyL5U6cEjl0=
X-Gm-Gg: AY/fxX5p6PLzp7laHWiMWZptUu4E47liDw2eO5OmZBEUFMKBPOISTDWaRh+GsNlsJH0
	r1o4nOy3mEJ6Yh7BkfBLrt970GWxL5L92gFkQpkNGl2zkHcYcHeDT4+zSyVjksilfcAaWNNxRKU
	oguGe3umz7NbKIHx9xk1qbKkJOAMMRRBGpKYXZEUOZDIYdHE1k72sSUEZMqXWjsH+4hOa3uFmht
	Drg9EWaQGLmwYmEaKZ9R6zP6/oUS9+IRyD5DRpW7lcynd2ukj+Fu2K1wlNuRf0+aWCGsCzO4Cvi
	Y9ZRmloG
X-Google-Smtp-Source: AGHT+IE8pjDMyDVKpMMbf/2BiQqNtZgddmWmaDb10R4MPn2DoKTVLhyn3/eiAAgllpbNvrDmIvCARFLb3kX+KMUWjGk=
X-Received: by 2002:a17:907:70c:b0:b73:80de:e6b2 with SMTP id
 a640c23a62f3a-b8426bf10a8mr408936466b.31.1767720127814; Tue, 06 Jan 2026
 09:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103022310.935686-1-puranjay@kernel.org> <20260103022310.935686-2-puranjay@kernel.org>
In-Reply-To: <20260103022310.935686-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Jan 2026 09:21:50 -0800
X-Gm-Features: AQt7F2rkeBOoKZwWdih78_H7gWM6d9JlU5oiz-JtbbuJ6f4iYHk1C8pnGeLJ42c
Message-ID: <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 6:24=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> cilium bpf_wiregard.bpf.c when compiled with -O1 fails to load
> with the following verifier log:
>
> 192: (79) r2 =3D *(u64 *)(r10 -304)     ; R2=3Dpkt(r=3D40) R10=3Dfp0 fp-3=
04=3Dpkt(r=3D40)
> ...
> 227: (85) call bpf_skb_store_bytes#9          ; R0=3Dscalar()
> 228: (bc) w2 =3D w0                     ; R0=3Dscalar() R2=3Dscalar(smin=
=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> 229: (c4) w2 s>>=3D 31                  ; R2=3Dscalar(smin=3D0,smax=3Duma=
x=3D0xffffffff,smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134                  ; R2=3Dscalar(smin=3D0,smax=3Duma=
x=3Dumax32=3D0xffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
> ...
> 232: (66) if w2 s> 0xffffffff goto pc+125     ; R2=3Dscalar(smin=3Dumin=
=3Dumin32=3D0x80000000,smax=3Dumax=3Dumax32=3D0xffffff7a,smax32=3D-134,var_=
off=3D(0x80000000; 0x7fffff7a))
> ...
> 238: (79) r4 =3D *(u64 *)(r10 -304)     ; R4=3Dscalar() R10=3Dfp0 fp-304=
=3Dscalar()
> 239: (56) if w2 !=3D 0xffffff78 goto pc+210     ; R2=3D0xffffff78 // -136
> ...
> 258: (71) r1 =3D *(u8 *)(r4 +0)
> R4 invalid mem access 'scalar'
>
> The error might confuse most bpf authors, since fp-304 slot had 'pkt'
> pointer at insn 192 and became 'scalar' at 238. That happened because
> bpf_skb_store_bytes() clears all packet pointers including those in
> the stack. On the first glance it might look like a bug in the source
> code, since ctx->data pointer should have been reloaded after the call
> to bpf_skb_store_bytes().
>
> The relevant part of cilium source code looks like this:
>
> // bpf/lib/nodeport.h
> int dsr_set_ipip6()
> {
>         if (ctx_adjust_hroom(...))
>                 return DROP_INVALID; // -134
>         if (ctx_store_bytes(...))
>                 return DROP_WRITE_ERROR; // -141
>         return 0;
> }
>
> bool dsr_fail_needs_reply(int code)
> {
>         if (code =3D=3D DROP_FRAG_NEEDED) // -136
>                 return true;
>         return false;
> }
>
> tail_nodeport_ipv6_dsr()
> {
>         ret =3D dsr_set_ipip6(...);
>         if (!IS_ERR(ret)) {
>                 ...
>         } else {
>                 if (dsr_fail_needs_reply(ret))
>                         return dsr_reply_icmp6(...);
>         }
> }
>
> The code doesn't have arithmetic shift by 31 and it reloads ctx->data
> every time it needs to access it. So it's not a bug in the source code.
>
> The reason is DAGCombiner::foldSelectCCToShiftAnd() LLVM transformation:
>
>   // If this is a select where the false operand is zero and the compare =
is a
>   // check of the sign bit, see if we can perform the "gzip trick":
>   // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
>   // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A
>
> The conditional branch in dsr_set_ipip6() and its return values
> are optimized into BPF_ARSH plus BPF_AND:
>
> 227: (85) call bpf_skb_store_bytes#9
> 228: (bc) w2 =3D w0
> 229: (c4) w2 s>>=3D 31   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,=
smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0x=
ffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
>
> after insn 230 the register w2 can only be 0 or -134,
> but the verifier approximates it, since there is no way to
> represent two scalars in bpf_reg_state.
> After fallthough at insn 232 the w2 can only be -134,
> hence the branch at insn
> 239: (56) if w2 !=3D -136 goto pc+210
> should be always taken, and trapping insn 258 should never execute.
> LLVM generated correct code, but the verifier follows impossible
> path and rejects valid program. To fix this issue recognize this
> special LLVM optimization and fork the verifier state.
> So after insn 229: (c4) w2 s>>=3D 31
> the verifier has two states to explore:
> one with w2 =3D 0 and another with w2 =3D 0xffffffff
> which makes the verifier accept bpf_wiregard.c
>
> Note there are 20+ such patterns in bpf_wiregard.o compiled
> with -O1 and -O2, but they're rarely seen in other production
> bpf programs, so push_stack() approach is not a concern.
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c9da70dd3e72..6dbcfae5615b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15490,6 +15490,35 @@ static bool is_safe_to_compute_dst_reg_range(str=
uct bpf_insn *insn,
>         }
>  }
>
> +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn,
> +                             struct bpf_reg_state *dst_reg)
> +{
> +       struct bpf_verifier_state *branch;
> +       struct bpf_reg_state *regs;
> +       bool alu32;
> +
> +       if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0=
)
> +               alu32 =3D false;
> +       else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_val=
ue =3D=3D 0)
> +               alu32 =3D true;
> +       else
> +               return 0;
> +
> +       branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fals=
e);
> +       if (IS_ERR(branch))
> +               return PTR_ERR(branch);
> +
> +       regs =3D branch->frame[branch->curframe]->regs;
> +       if (alu32) {
> +               __mark_reg32_known(&regs[insn->dst_reg], 0);
> +               __mark_reg32_known(dst_reg, -1ull);

Did you get a chance to run veristat with these changes against
selftests, scx, maybe also Meta BPF objects? Curious if there are any
noticeable differences.

Also, the choice of which branch gets zero vs one set might have
meaningful differences (heuristically, "linear path" should preferably
explore conditions that lead to more complete and complex states), so
I'd be interested to see if and what difference does it make in
practice.

> +       } else {
> +               __mark_reg_known(&regs[insn->dst_reg], 0);
> +               __mark_reg_known(dst_reg, -1ull);
> +       }
> +       return 0;
> +}
> +
>  /* WARNING: This function does calculations on 64-bit values, but the ac=
tual
>   * execution may occur on 32-bit values. Therefore, things like bitshift=
s
>   * need extra checks in the 32-bit case.
> @@ -15552,6 +15581,11 @@ static int adjust_scalar_min_max_vals(struct bpf=
_verifier_env *env,
>                 scalar_min_max_mul(dst_reg, &src_reg);
>                 break;
>         case BPF_AND:
> +               if (tnum_is_const(src_reg.var_off)) {
> +                       ret =3D maybe_fork_scalars(env, insn, dst_reg);
> +                       if (ret)
> +                               return ret;
> +               }
>                 dst_reg->var_off =3D tnum_and(dst_reg->var_off, src_reg.v=
ar_off);
>                 scalar32_min_max_and(dst_reg, &src_reg);
>                 scalar_min_max_and(dst_reg, &src_reg);
> --
> 2.47.3
>

