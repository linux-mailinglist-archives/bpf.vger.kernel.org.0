Return-Path: <bpf+bounces-78798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1CD1BEA4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E512B30537A6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CE529B8D9;
	Wed, 14 Jan 2026 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jiw+OVm6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E37293B75
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353847; cv=none; b=DenmU3P7ZtNnHB2IdbyYet5U1FRlufuBBKSvnAdfW4Oy+Mz3y8tmBOWlViCFeM9o4fCL+PlAg8FTxmuqjJqPKGghZqK7Hq8IDjBY6/02yNHdBIWCP+KZ+Z7n7qyP/8hYkaSjhAiXakuJsPQ7TQ9rB2lJLYyY2NkHSYKIWRim0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353847; c=relaxed/simple;
	bh=AH47uxadgfiEdcOQwb1ZukuRWMz/dxNoKIcMpvCvfgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJVQdiYMoXhhQdLhMCZJJbMl5MXn9jfSy4AFo0KcquvB22Y/pD+ZXLR2jz41ahUZO4cJSjLVZRqvPOc4Ix0dS1ds74k45MltSsfcmVmXb4YQRceHhrshIReaJ934wMzYy5PH4BtFJsS4WRSHyyoRum4jjO2gP5tkVxzkr3ACOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jiw+OVm6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b86f81d8051so63903266b.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353844; x=1768958644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyCkWzRw27W+PcJc2aWOLu43DBTDJBPxgsYIG4uySlw=;
        b=Jiw+OVm60VGTQi0r+y9HByfnFKrOQ+2CReaqvnB8Fvj52OPwchMaJjbCVTQV0IO7kb
         gSLHBcRbt/6+j024Z8Dzfleobrk+aODqD3EfR2ViVE1pXJniPB6tfVvgriF8ObkvggOs
         WRJT/stqD9lJDs+QYaRJdpo1ilkUyL4DBMR61x1eXSMDCpKO7gmu2XA1KrbmgX7QJEt9
         GTj2ad1i3hL9HoMC9W/glnHMAYjZUhbYhzfJZheQ6utdY59uwYPSdHrGRcnP7/Af2MzS
         0p2bGOkd8xcwyVFyt+SPTknI87FgE7yMi3P8ucmWo3Sojbp/rqa0z5Eup/0tzdogcQio
         yj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353844; x=1768958644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyCkWzRw27W+PcJc2aWOLu43DBTDJBPxgsYIG4uySlw=;
        b=kX4TChIvxymvsu4dirJKobDtgyo5rRILdW7rSR3w9GeWGVnEVpO9WF9+Xuqjrd+enh
         XgP3roKfjcU4WpWlI/EH3/xE3/h0VZVOStbmw9sD7w1GnVWTI+xlgl/G0/nybJTiU5NV
         91fDQzOAP5pRBcguRO+Eptpk+Mqy49WdCggdlct6RttjdSnwm4iPkyGzt6q3WYWTmUTD
         ix+EgFDig4d915mciD8jah/IN+4mzpsmh5zOybgXAXLaGu34pY0xL2CfBmRMAyUKiW/G
         M+CE+MNtCsiSF6vmztc//Ca9hTJ7R9Y4Y3PVs5fk3VDiqUj7184HJosNln44jQpVix/6
         FlIg==
X-Forwarded-Encrypted: i=1; AJvYcCVrt/NFhr+zO6/V9FtkTX5kkVamoq9ziDtenzGH+nTAIOXpj0MekdAZ8auenTH3rpiAN70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+m71dlVUVhwUtSqf/OgpY4tj8XKoQagZB4+ylwujkIzAXV9Y
	A184JygmqfQCN9+iWGfwfO2WvAOOu25h/XWBrLDwGFozJzJ3kWz8sQ3iihX9Oo7MIPgc2ltAIob
	MDsvI3rl+lAF+AOiLrlXs5R0EzJzMHj0=
X-Gm-Gg: AY/fxX7e4PItICKBlxD29MUBhpVA8OcsivsWw0Q4upFYDDnzciHvS6o+nuweqQbIyMI
	QeXics0nA0njh0P7SJnSEk/dBG2tEHnH7kmSEbegiZob2P2MmzJP8pi/lML/38bVIJyeRiO55+d
	brpsZLB+H5BHIsoDFcXdB+ul2J6KWuTr2CPff2aicH6gbaKiorg2IPmdm2nJYY4gcBoYSF7lJRe
	7l+5zg5C1lw7txynYNF8qbvLGCFS12lNd11afMduibCEP9GS5js+DaekMGcjRudmumZgKMjGh1F
	I+FMMvOlxEk=
X-Received: by 2002:a17:907:9625:b0:b87:2f29:2054 with SMTP id
 a640c23a62f3a-b8761c1b85cmr73995266b.8.1768353843749; Tue, 13 Jan 2026
 17:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-7-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-7-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:55 -0800
X-Gm-Features: AZwV_QgeW2XUiFqi7ys8fraiqUratkAtDLiI-AOzKNh5gOu7JrWkJaWZDMDPwuQ
Message-ID: <CAEf4BzbKKmNnqQP0g8OVSgwqb2DTidBpKBjyi-QQJBRJ+-6SWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 06/11] bpf,x86: introduce emit_store_stack_imm64()
 for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Introduce the helper emit_store_stack_imm64(), which is used to store a
> imm64 to the stack with the help of r0.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v9:
> - rename emit_st_r0_imm64() to emit_store_stack_imm64()
> ---
>  arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e3b1c4b1d550..d94f7038c441 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 =
dst_reg, int off, int imm)
>         emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
>  }
>
> +static void emit_store_stack_imm64(u8 **pprog, int stack_off, u64 imm64)
> +{
> +       /* mov rax, imm64
> +        * mov QWORD PTR [rbp - stack_off], rax
> +        */
> +       emit_mov_imm64(pprog, BPF_REG_0, imm64 >> 32, (u32) imm64);

maybe make the caller pass BPF_REG_0 explicitly, it will be more
generic but also more explicit that BPF_REG_0 is used as temporary
register?

> +       emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -stack_off);

why are you negating stack offset here and not in the caller?..

> +}
> +
>  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
>                            u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size=
)
>  {
> @@ -3352,16 +3361,14 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
>          *   mov rax, nr_regs
>          *   mov QWORD PTR [rbp - nregs_off], rax
>          */
> -       emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
> -       emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> +       emit_store_stack_imm64(&prog, nregs_off, nr_regs);
>
>         if (flags & BPF_TRAMP_F_IP_ARG) {
>                 /* Store IP address of the traced function:
>                  * movabsq rax, func_addr
>                  * mov QWORD PTR [rbp - ip_off], rax
>                  */
> -               emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, =
(u32) (long) func_addr);
> -               emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
> +               emit_store_stack_imm64(&prog, ip_off, (long)func_addr);

see above, I'd pass BPF_REG_0 and -ip_off (and -nregs_off) explicitly,
too many small transformations are hidden inside
emit_store_stack_imm64(), IMO


>         }
>
>         save_args(m, &prog, regs_off, false, flags);
> --
> 2.52.0
>

