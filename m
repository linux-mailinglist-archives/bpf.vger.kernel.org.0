Return-Path: <bpf+bounces-27942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A98B3CC2
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5335D1C22647
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA164156C65;
	Fri, 26 Apr 2024 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpgAQJLl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93C15686F;
	Fri, 26 Apr 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148816; cv=none; b=t0pBum8hgl9ScCjK4O+TeIiyv3dGjQr8sQDRa8y8cAN4ePdBbnGBD32jpAYLaxHbeMzsct9esgF5VAYXAWFXnzk8RvxVnehRy/8SahbEGjunC6pDeFdXePROivy5LTd18dcoTiG5DRDFa0agxLbsQAGnRlfyOf6sRvp9+sSmYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148816; c=relaxed/simple;
	bh=lorYvYgo5IXa066vwzcU4pNV6jM1EDwnv91nHO/Ds0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP1TW32Iek1qdtscVKn+mdvjHhIrwVv46yehSoisPP2WLqpsfrDwKXuW5cFIwOwPoyxkFDOuwBFCdKT9wt+z1MqDtA4Dr1mXFGvUInJ9MMiF2a+Qkj7kl1JUi6RM5LSuoafPqWSX9iBOUunuLOe05/Dt+CEJz4GktNcIJOcTB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpgAQJLl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a7e19c440dso1826326a91.3;
        Fri, 26 Apr 2024 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714148814; x=1714753614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7F6VSCpFiJAuhOg5TQ3LJ1rWu2w2/9qSNziUYNfTrUs=;
        b=YpgAQJLljIWPgjBUQWkMa29Ht+Hs/3ve9emVnpmAv/3xzx95e4tyy0S71rI8LQxs7/
         z6wI6XV/iQM3+1gzAu0Umzkeu0BDba6xevoJw7jLuNH4h/tePDSOxn1xM/Rsue2/oz1T
         IzaNOU4IWcH6t3GqmEenvJfJ9Mz1FHLxz30RyN3fCr3KP1851KyNxHbsLBYcnJTPylM0
         ktVWTGAv426kXLf/f2KkCx3tfae6spPlYm+W/i04h0Z8qcHAeF3+6h0lgIgFP0iTe10y
         GMvmg3a7esFZlrRLaaqA30DYtYBQrm/aLV0lwi7qIj5OlaP+5SCu6iuuek1VtCnXlVjJ
         cbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148814; x=1714753614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7F6VSCpFiJAuhOg5TQ3LJ1rWu2w2/9qSNziUYNfTrUs=;
        b=aEW0kUka/qRnxuHajO5QI5QvZvsAZE2zbls9pwTevTE2+u1bTnNBHvf6VhlGvZqIJM
         xyObyIPZ9cUXduZ9v7x1VGDlsgJVQ+5ReQC8C9OVYF8ZnNa29Pt8L36mc8GfEJuSBQRV
         wlsp8yaX32vUBinUA2cp3yW5Vv1icNhIA6mdEJ+huHlh41CQ5pXoFUvTJxy/H2xqoCZr
         lk70z5rTHRhKLSNtTWKBErOLjRQhSpBdDXRimFAnNuJs47v6HpxNXH/D2xKr45U7AJj4
         FJpBdlRhSGa5yKBlKDfTaC5brNtF/EuWXUmYmZ7nSp6U2xPPwGcVbit6c1uapL8RxK3K
         8RjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLmSx9zH6E6/dBSps4t1Tfllm6Jv/ncaSpReNxMoysQa069vaYBUFvVoMUA/gvbZ/hlrmteXETXN4UUTarAZVasZLN/u6ShOv1dPkvf/Bm4omJI1+dHGDIZmgt318x7x6i
X-Gm-Message-State: AOJu0Yz20udgxBuB2swfzCJqMmj5T0hX/3R8HYlLgGlrvyDIFHwX7dm3
	e4K3a4jCRgYWoBbRDTdbtT4Z4KtCg9v3bX9MeRvugqw1YMXX12SOrttLBdd3tO+FN9YWzD1qh1X
	9xYa7gw8ZtiHVtnb3H9jVbshv71s=
X-Google-Smtp-Source: AGHT+IGu4GRGYVOdPGc3A474j1UuojtMDmM+IwnLOxDpKwjsEPtu6sZypVBrCcksdi4s4CzHpIfUJFJmvdV1m+wY8JI=
X-Received: by 2002:a17:90b:3692:b0:2af:3088:e36f with SMTP id
 mj18-20020a17090b369200b002af3088e36fmr3049385pjb.7.1714148814036; Fri, 26
 Apr 2024 09:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121349.97651-1-puranjay@kernel.org> <20240426121349.97651-3-puranjay@kernel.org>
In-Reply-To: <20240426121349.97651-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 09:26:42 -0700
Message-ID: <CAEf4BzaNM5H3Ad2=Syhhq1cbfuB5FrtuFTZHPTdQP3QME3naKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, arm64: inline bpf_get_smp_processor_id()
 helper
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:14=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
> bpf_get_smp_processor_id().
>
> ARM64 uses the per-cpu variable cpu_number to store the cpu id.
>
> Here is how the BPF and ARM64 JITed assembly changes after this commit:
>
>                                          BPF
>                                         =3D=3D=3D=3D=3D
>               BEFORE                                       AFTER
>              --------                                     -------
>
> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_smp=
_processor_id();
> (85) call bpf_get_smp_processor_id#229032       (18) r0 =3D 0xffff8000820=
72008
>                                                 (bf) r0 =3D &(void __perc=
pu *)(r0)
>                                                 (61) r0 =3D *(u32 *)(r0 +=
0)
>
>                                       ARM64 JIT
>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>               BEFORE                                       AFTER
>              --------                                     -------
>
> int cpu =3D bpf_get_smp_processor_id();           int cpu =3D bpf_get_smp=
_processor_id();
> mov     x10, #0xfffffffffffff4d0                mov     x7, #0xffff8000ff=
ffffff
> movk    x10, #0x802b, lsl #16                   movk    x7, #0x8207, lsl =
#16
> movk    x10, #0x8000, lsl #32                   movk    x7, #0x2008
> blr     x10                                     mrs     x10, tpidr_el1
> add     x7, x0, #0x0                            add     x7, x7, x10
>                                                 ldr     w7, [x7]
>
> Performance improvement using benchmark[1]
>
>              BEFORE                                       AFTER
>             --------                                     -------
>
> glob-arr-inc   :   23.817 =C2=B1 0.019M/s      glob-arr-inc   :   24.631 =
=C2=B1 0.027M/s
> arr-inc        :   23.253 =C2=B1 0.019M/s      arr-inc        :   23.742 =
=C2=B1 0.023M/s
> hash-inc       :   12.258 =C2=B1 0.010M/s      hash-inc       :   12.625 =
=C2=B1 0.004M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4e474ef44e9c..6ff4e63b2ef2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20273,20 +20273,31 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                         goto next_insn;
>                 }
>
> -#ifdef CONFIG_X86_64
>                 /* Implement bpf_get_smp_processor_id() inline. */
>                 if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
>                     prog->jit_requested && bpf_jit_supports_percpu_insn()=
) {
>                         /* BPF_FUNC_get_smp_processor_id inlining is an
> -                        * optimization, so if pcpu_hot.cpu_number is eve=
r
> +                        * optimization, so if cpu_number_addr is ever
>                          * changed in some incompatible and hard to suppo=
rt
>                          * way, it's fine to back out this inlining logic
>                          */
> -                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
> -                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> -                       insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
> -                       cnt =3D 3;
> +                       u64 cpu_number_addr;
>
> +#if defined(CONFIG_X86_64)
> +                       cpu_number_addr =3D (u64)&pcpu_hot.cpu_number;
> +#elif defined(CONFIG_ARM64)
> +                       cpu_number_addr =3D (u64)&cpu_number;
> +#else
> +                       goto next_insn;
> +#endif
> +                       struct bpf_insn ld_cpu_number_addr[2] =3D {
> +                               BPF_LD_IMM64(BPF_REG_0, cpu_number_addr)
> +                       };

here we are violating C89 requirement to have a single block of
variable declarations by mixing variables and statements. I'm
surprised this is not triggering any build errors on !arm64 &&
!x86_64.

I think we can declare this BPF_LD_IMM64 instruction with zero "addr".
And then update

ld_cpu_number_addr[0].imm =3D (u32)cpu_number_addr;
ld_cpu_number_addr[1].imm =3D (u32)(cpu_number_addr >> 32);

WDYT?

nit: I'd rename ld_cpu_number_addr to ld_insn or something short like that

> +                       insn_buf[0] =3D ld_cpu_number_addr[0];
> +                       insn_buf[1] =3D ld_cpu_number_addr[1];
> +                       insn_buf[2] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[3] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
> +                       cnt =3D 4;

nit: we normally have an empty line here to separate setting up
replacement instructions from actual patching

>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
> @@ -20296,7 +20307,6 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> -#endif
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> --
> 2.40.1
>

