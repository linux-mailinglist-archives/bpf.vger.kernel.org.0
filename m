Return-Path: <bpf+bounces-28377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0538B8E82
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 18:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA54A1C2194B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154111CAB;
	Wed,  1 May 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw4iEbZq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97783234;
	Wed,  1 May 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582231; cv=none; b=uwEexJWVPBT+UXSE4rNJrBNqZOQH2u1KQ0/Sh4lmXfTa5BsX6CD9OU9HCm9KM47uGNo+28Ntp16trdOSkUryRW8ClneCPZoTjV703O3v4/8f4sMpQWYgj41qMug2RIj3hvIjiljVRtzKwSgvb0W+AvMlajR413Qehs//bb+RnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582231; c=relaxed/simple;
	bh=T5uWjQn0TdTai7lZsSs6aSnBx3aKCjraRrFmpU3ySSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1IMewGxdvRNyMcOpAMkIfz7dVDvi2/u4qwCH2+kvRygrqgGijN86dMhibCDLw3rIfM4yGEh1N6cuFhPAt7lgw6kFakSGhu16xS1QMx492sRj0CsCOS+1PuOxULxk98Ia/qdiInA/EHeiXPXCPksPsLbwEluTaaqTWX9XtgEbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw4iEbZq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec69e3dbe5so14030255ad.0;
        Wed, 01 May 2024 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582229; x=1715187029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aksft0yTn/V06U1VI9NL6+QbOurl0GnC7c4G4bkaC4s=;
        b=bw4iEbZqMgtryJK8jVcUh+L7aGw1WXn2xuw+mp3DnHua2S0t8xrhjUNBua6TmyRQly
         aW3TV9PEoa8gx/T2fh7IcGG9SjdaYzKCW8YU+BU7BQ/AQgKwjnRAvx6Xi9eFrl4i27e2
         9HwiVAeq2H0CqobYNmNrp3oYQfEPbELWJooN4yqVn68QgsIkF2BSuOjqTO/dIvAVcGJV
         SnhfDIZQGAGnvmS25JfUsstTaz9xD6xE2Wts81ycNaztE3CAlNcRew0Jj6onbEMsRccp
         gb0GpokqfcIUj/yjTcg38Sg8kaPC9vScq9dsoNw869ZwMJdDUkE3km1Ke863H2bC2yXZ
         hXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582229; x=1715187029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aksft0yTn/V06U1VI9NL6+QbOurl0GnC7c4G4bkaC4s=;
        b=Kc3NfFKi8Go7+RFk+QXQUrdVC0RjZVpdot88TdPWVCXsMMGUMpHlauKH4/o/NT2bTN
         WOO3hRrajzlq2R2DTQKAa4YC/Dr0xmoklJZ7l+XQ+onqZ2NV5hkWd4jQWNOfa4Orz9e8
         /XcULzsdT0tF6K/C1srTpa+Ro/DKaJicy76fhdZkHzX82YlKCDj6bK2WbNC7r9udwqGD
         Pp0ude6FMHhNVdcIEeujKujAGf4S1kGSXplzSkfTpWFd9BkaPnGBvkPu7H1qmUuU2MGL
         Fu3cPUJ9t+0sI8MY/TAnxmeeYHeDSkPbSMhX9vBvvOod3DiW3sayMy7hSvTnBVNmr2Kx
         5ShQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEOpzP7o4uRNRXm+Fgvank3qORKMczukEmA+Jq0aKAx34Kc9yeZnjosZZrY3mI0VJZc2axtPVRQrSe9fPk5SW06/Hs2whltD+3MHwlQyGF0zYGzn2bsaiSqYX8N1jzHTvo
X-Gm-Message-State: AOJu0YwMz51EwFmliUBWnSy128l1l/f15vhAtZpjG0g7vz64y/zxTjUp
	0NeA45ogi5LWxdi4sV0BzcAzdKr21ROfeq5zssCLERY2jwHvwlLWcYuIo9Lw15q11x0gOny0uNH
	rl8KDgs/aob/DBYxhQ259y02uUeQ=
X-Google-Smtp-Source: AGHT+IGphJowQwPdQc/IaHX5fYRv9tLnSqbTNSMg8oYW9E7t5aRvVSuJjG7AQiuaR5dOEj0zY6wFvDFEVRQ7xzc7xek=
X-Received: by 2002:a17:90b:68e:b0:2a5:4e39:6a8 with SMTP id
 m14-20020a17090b068e00b002a54e3906a8mr3089123pjz.33.1714582229167; Wed, 01
 May 2024 09:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430234739.79185-1-puranjay@kernel.org> <20240430234739.79185-3-puranjay@kernel.org>
In-Reply-To: <20240430234739.79185-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 May 2024 09:50:16 -0700
Message-ID: <CAEf4BzbszfMGoOCx7hQPBfDLNLfBuAQ1PQDEq=ut=WiEubm_oA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf, arm64: inline bpf_get_smp_processor_id()
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
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:48=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Inline calls to bpf_get_smp_processor_id() helper in the JIT by emitting
> a read from struct thread_info. The SP_EL0 system register holds the
> pointer to the task_struct and thread_info is the first member of this
> struct. We can read the cpu number from the thread_info.
>
> Here is how the ARM64 JITed assembly changes after this commit:
>
>                                       ARM64 JIT
>                                      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>               BEFORE                                    AFTER
>              --------                                  -------
>
> int cpu =3D bpf_get_smp_processor_id();        int cpu =3D bpf_get_smp_pr=
ocessor_id();
>
> mov     x10, #0xfffffffffffff4d0             mrs     x10, sp_el0
> movk    x10, #0x802b, lsl #16                ldr     w7, [x10, #24]
> movk    x10, #0x8000, lsl #32
> blr     x10
> add     x7, x0, #0x0
>
>                Performance improvement using benchmark[1]
>
> ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc
>
> +---------------+-------------------+-------------------+--------------+
> |      Name     |      Before       |        After      |   % change   |
> |---------------+-------------------+-------------------+--------------|
> | glob-arr-inc  | 23.380 =C2=B1 1.675M/s | 25.893 =C2=B1 0.026M/s |   + 1=
0.74%   |
> | arr-inc       | 23.928 =C2=B1 0.034M/s | 25.213 =C2=B1 0.063M/s |   + 5=
.37%    |
> | hash-inc      | 12.352 =C2=B1 0.005M/s | 12.609 =C2=B1 0.013M/s |   + 2=
.08%    |
> +---------------+-------------------+-------------------+--------------+
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/include/asm/insn.h |  1 +
>  arch/arm64/net/bpf_jit.h      |  2 ++
>  arch/arm64/net/bpf_jit_comp.c | 23 +++++++++++++++++++++++
>  3 files changed, 26 insertions(+)
>

Nice improvements! I suggest combining arm64 and risc-v patches
together when resubmitting, so that we can land them in one go. This
one depends on RISC-V patches landing first to avoid a warning about
global function without a prototype, right?

Please add my ack as well

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.=
h
> index 8de0e39b29f3..8c0a36f72d6f 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -138,6 +138,7 @@ enum aarch64_insn_special_register {
>  enum aarch64_insn_system_register {
>         AARCH64_INSN_SYSREG_TPIDR_EL1   =3D 0x4684,
>         AARCH64_INSN_SYSREG_TPIDR_EL2   =3D 0x6682,
> +       AARCH64_INSN_SYSREG_SP_EL0      =3D 0x4208,
>  };
>
>  enum aarch64_insn_variant {
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index b627ef7188c7..b22ab2f97a30 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -302,5 +302,7 @@
>         aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL1)
>  #define A64_MRS_TPIDR_EL2(Rt) \
>         aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
> +#define A64_MRS_SP_EL0(Rt) \
> +       aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_SP_EL0)
>
>  #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index ed8f9716d9d5..8084f3e61e0b 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1215,6 +1215,19 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx,
>                 const u8 r0 =3D bpf2a64[BPF_REG_0];
>                 bool func_addr_fixed;
>                 u64 func_addr;
> +               u32 cpu_offset =3D offsetof(struct thread_info, cpu);
> +
> +               /* Implement helper call to bpf_get_smp_processor_id() in=
line */
> +               if (insn->src_reg =3D=3D 0 && insn->imm =3D=3D BPF_FUNC_g=
et_smp_processor_id) {
> +                       emit(A64_MRS_SP_EL0(tmp), ctx);
> +                       if (is_lsi_offset(cpu_offset, 2)) {
> +                               emit(A64_LDR32I(r0, tmp, cpu_offset), ctx=
);
> +                       } else {
> +                               emit_a64_mov_i(1, tmp2, cpu_offset, ctx);
> +                               emit(A64_LDR32(r0, tmp, tmp2), ctx);
> +                       }
> +                       break;
> +               }
>
>                 ret =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass=
,
>                                             &func_addr, &func_addr_fixed)=
;
> @@ -2541,6 +2554,16 @@ bool bpf_jit_supports_percpu_insn(void)
>         return true;
>  }
>
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +       switch (imm) {
> +       case BPF_FUNC_get_smp_processor_id:
> +               return true;
> +       }
> +
> +       return false;

same minor nit to use default: return false inside the switch itself


> +}
> +
>  void bpf_jit_free(struct bpf_prog *prog)
>  {
>         if (prog->jited) {
> --
> 2.40.1
>

