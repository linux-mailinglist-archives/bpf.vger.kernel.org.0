Return-Path: <bpf+bounces-28957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B58BEE9D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B4E1F25F69
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14FF73183;
	Tue,  7 May 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEXEINa9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C522973163;
	Tue,  7 May 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116085; cv=none; b=Uniic3Ox9DgkJecixgIGmrLE7CvsJQbO5us83oG//gKVTV6SwWNn4ERexP9GR0c7xkP0NW0CYm2OtpjQyxnKfAPpNhNXhwr6gEfbc/3wijGTj6Gzw9210L1QjYgWaLUxoU2YbysWCx91i9R4HcY87fo6M0oIs/LUAyz0QMeNNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116085; c=relaxed/simple;
	bh=B6UyPSjkD4lPVXtW9MIZrPpHMifBqYpqqtm47NjnchY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf28kGSO+6NOVGjE4+CGBKvwjjQMYDG6NB2k4Arr7Jdg7KoAc18eTPQzTLcG5Fb0E1/dCQfZrVa/VeDzhzD8YXYhj7xTFLGkUp5Q6g8qJYBzALsbRRTVpVCX3VOt7bYmvOQwym1SRoVgqcg+pfoV8yMYZe3n4JR4ZQS84sgPzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEXEINa9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4702457ccbso947716566b.3;
        Tue, 07 May 2024 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116082; x=1715720882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieHKWE/362CtrkuwJG+D03/eKpQ3iQM4fqC19j9FWgg=;
        b=CEXEINa9LB5L1K0I9mGM+0JpL9F9qpMUlCnSAZCIFmhhjKw5D79kAmJNOSoGrZ2QWD
         48ScQ1OUWzJnhZT8W++4u5LM108rb6zoz+XrKAMYtmT62Oo53lyO6vWTY5Ey4XkQ2OEI
         tLnnrkoRcAjPvmpF5AFLtSV95CbOp44Ia80LK8x+WCcT+m/TFFRqzdk5TUvbm5KLRWYt
         /J6NufyZrebUaZuKGD0EFwnEY6W3BP9ZoiQw3IwDu4EsJEjbcCHa7YSRerLMx5KOqy79
         Y2pFT1SKZDTgFSigqBiDGEjbSR3/b4yk6yKRynScGdeETi7yjWIUgb4QRNCcjEp2dFzU
         odWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116082; x=1715720882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieHKWE/362CtrkuwJG+D03/eKpQ3iQM4fqC19j9FWgg=;
        b=vIe8z2YXOU8JGVBfFW1rp3jIIeWXZaykrpXGaAjcfYQvl6E8DZuA2sL8slo8N9onsn
         NgO5RZrZNvwuQqn+EIbverqvmzBINl1TwLMERTho2BCRtLQHkAM7SDMrJIE9PuDc9PQt
         AI7d0Vfg3pQRLv0mDET6MwVwnNP+vVhCh1LTfvyz2MMMDvqL6M4ZcpZ6Y2ZH/x188Wk/
         0svu6MBODCs1J+LYNKA+naz9Vkqx1Wy7Jx0Y72oWYXzATglazNWTfMuY5uHTbC+/UbPp
         km7MVhNFo8kHfVz9OnIu0snLUxA9Hd8hgagQC1HYeRePVrJSqHCK5wEGvVhe+17oj3eD
         f3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVb6c9ejdODjgvFkobFmSej2w1Ngrus+jJ0mOBgpHqazP9jztT5VbUaxPONUuzLwMCGOXLbG9ma13ntqrG+EO2MdLFCOkYlVFFy//gmBxoMYFOng85p6wvDOCF/EjVoUmzA
X-Gm-Message-State: AOJu0YwPyjPZbth5+LpzpP8nQUcgUy2IAa5CkgKP0pGWViT5xWGkhWzS
	Frnnj9SRgBvf+gqahEMNEfA3RuRF/XZM4ueJjKOKy5Dp/T7DT0MvhWXKoegwNJ9w+Yz02vXfJBa
	XCllzyLEPRYaOY5UAEc8IdXo8efY=
X-Google-Smtp-Source: AGHT+IEw3/qNsNoUP7aAcOanTDPmGmWt8ZwnfCP9de7aC18zb/HtIe1tDLKzU3KIIw24p7yI1mX2F4HjYsuumVBJOf8=
X-Received: by 2002:a17:906:7181:b0:a59:c9ad:bd26 with SMTP id
 a640c23a62f3a-a59fb922db9mr35896566b.12.1715116081732; Tue, 07 May 2024
 14:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502151854.9810-1-puranjay@kernel.org> <20240502151854.9810-2-puranjay@kernel.org>
In-Reply-To: <20240502151854.9810-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:07:46 -0700
Message-ID: <CAEf4BzZoB2jGZu7MVXbhyWKXNu1UCpvxznFCazH-vGPRPrYFFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/4] riscv, bpf: add internal-only MOV
 instruction to resolve per-CPU addrs
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 8:19=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> RISC-V uses generic per-cpu implementation where the offsets for CPUs
> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
> the address of the task_struct in TP register. The first element in
> task_struct is struct thread_info, and we can get the cpu number by
> reading from the TP register + offsetof(struct thread_info, cpu).
>
> Once we have the cpu number in a register we read the offset for that
> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
> offset to the destination register.
>
> To measure the improvement from this change, the benchmark in [1] was
> used on Qemu:
>
> Before:
> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
> arr-inc        :    1.121 =C2=B1 0.004M/s
> hash-inc       :    0.681 =C2=B1 0.052M/s
>
> After:
> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
> arr-inc        :    1.366 =C2=B1 0.006M/s
> hash-inc       :    0.676 =C2=B1 0.001M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>

Please carry over acks you got on previous revisions, unless you
significantly change something about the patch, invalidating previous
acks. You had Bjorn's ack on this one, I believe:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 15e482f2c657..1f0159963b3e 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -12,6 +12,7 @@
>  #include <linux/stop_machine.h>
>  #include <asm/patch.h>
>  #include <asm/cfi.h>
> +#include <asm/percpu.h>
>  #include "bpf_jit.h"
>
>  #define RV_FENTRY_NINSNS 2
> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>                         emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>                         emit_mv(rd, RV_REG_T1, ctx);
>                         break;
> +               } else if (insn_is_mov_percpu_addr(insn)) {
> +                       if (rd !=3D rs)
> +                               emit_mv(rd, rs, ctx);
> +#ifdef CONFIG_SMP
> +                       /* Load current CPU number in T1 */
> +                       emit_ld(RV_REG_T1, offsetof(struct thread_info, c=
pu),
> +                               RV_REG_TP, ctx);
> +                       /* << 3 because offsets are 8 bytes */
> +                       emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
> +                       /* Load address of __per_cpu_offset array in T2 *=
/
> +                       emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extr=
a_pass, ctx);
> +                       /* Add offset of current CPU to  __per_cpu_offset=
 */
> +                       emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1, ctx);
> +                       /* Load __per_cpu_offset[cpu] in T1 */
> +                       emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
> +                       /* Add the offset to Rd */
> +                       emit_add(rd, rd, RV_REG_T1, ctx);
> +#endif
>                 }
>                 if (imm =3D=3D 1) {
>                         /* Special mov32 for zext */
> @@ -2038,3 +2057,8 @@ bool bpf_jit_supports_arena(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_supports_percpu_insn(void)
> +{
> +       return true;
> +}
> --
> 2.40.1
>

