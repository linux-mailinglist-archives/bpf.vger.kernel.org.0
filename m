Return-Path: <bpf+bounces-54892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7AA7592D
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39A116786A
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEA191F79;
	Sun, 30 Mar 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JczMJFxE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A67E107
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743327559; cv=none; b=vFudgjT6WgyAmoB23LVR5vWGibfck6V1KvREAcKLAvAJ7za+1HFKTGdGiWAEJO2XlM4KrLtSwz1KTF7Sk04bD1hWjjMQfzq3Q3HclLU4etOta3jxrQDuS+cVmCPnlWaiPDCcUm5VKO3FfgnHAq1iw5fTH/5rMWzK1ueL1gui35U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743327559; c=relaxed/simple;
	bh=qOpGWbK5ldf9SDZDXTtY0WdWTedjnVlVb/1xppOuqDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuTX7e1xU6eCrv9BLHNcfjjeV9La5Yl9xLm3Rj2iopy0o9b14qjdfvn8NIqgCnAMDjgWxIG15Nt2Yos+bUguT5+aTiZVFYoD3zp4w8i8jGnSM066QZl+tECO3rfLfhUkTiMplajXimz9TMfuWjOnKSU9GmAVvkZkNeVHE+QL2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JczMJFxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3965FC4CEED
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743327559;
	bh=qOpGWbK5ldf9SDZDXTtY0WdWTedjnVlVb/1xppOuqDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JczMJFxER4BnUTavz80XKKJDqH1d1P0Mh0kH2++zh2KsyTSRNT4iuj401t7I45sPM
	 KAE1kXVBNUM9NLs+INKRZ4WCQeDJbhEUONwPVZF8CxREk66GRvf7QnmjJuScbbaIjQ
	 BPIitXNFIWp55eabdiV30gClz5/JTdWvupU3SrDdxt+lJJa68iOZ+g6w5604yhpBzU
	 YR5On97oTuBjr6lsmL+w6Ex0jIBXeTi+AFq6YkJBpfqWK/NfRmKBoTEZcgvv/qDnQY
	 +0SDy4EeLxQXZJ0qmM6RMAYCEm3WFID52nrNR6Wj3R3KM1+bjIOp8ferJfy60rl1O9
	 VVcvNayHofuyw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac25520a289so591492266b.3
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 02:39:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXX9WEC3wrEhOX71OHDbGIQHePU6TmPuioJ6OCOfAxb/zZ+tcclFII/eZHlNZRH6stmxXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKE/PmuQ2rf7yiYL/xbysSa4KYdxlWjsXb5sapUf+hv7EVuC7
	ey5vXtvNcZ++HC27g9E0LWMogHSSrhC+Lg+WgHAb+/drKX1t98WzXb26RYAiQOZPXM5qWt+VNd2
	cjn8Bb2QOy2fD7ckexOZenDnX8OY=
X-Google-Smtp-Source: AGHT+IHWI8H6+CX8fiAcFsv3Yp48OfoGmaFvj18P/vmWmGdMxyWIdnFWvMUYHcBxNAkOAhu7vuXeY8nKy9yrJRpupk0=
X-Received: by 2002:a17:906:7955:b0:ac1:e00c:a566 with SMTP id
 a640c23a62f3a-ac738bbe6e9mr484339266b.45.1743327557801; Sun, 30 Mar 2025
 02:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317015755.2760716-1-hengqi.chen@gmail.com>
In-Reply-To: <20250317015755.2760716-1-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 30 Mar 2025 17:39:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7XSTNi6xRM9uoa6GDx=NdZC0pC5Tc-ZJ4waHkU7QPqGg@mail.gmail.com>
X-Gm-Features: AQ5f1JqatnPsluOu6zhLSXxqHM1gqGfuGRKkYraxPMXShwAqSU1_TfO-kkzjJbc
Message-ID: <CAAhV-H7XSTNi6xRM9uoa6GDx=NdZC0pC5Tc-ZJ4waHkU7QPqGg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Use move_addr() for BPF_PSEUDO_FUNC
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, yangtiezhu@loongson.cn, 
	Vincent Li <vincent.mc.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Mon, Mar 17, 2025 at 9:58=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Vincent reported that running XDP synproxy program on LoongArch
> results in the following error:
>     JIT doesn't support bpf-to-bpf calls
> With dmesg:
>     multi-func JIT bug 1391 !=3D 1390
>
> The root cause is that verifier will refill the imm with the
> correct addresses of bpf_calls for BPF_PSEUDO_FUNC instructions
> and then run the last pass of JIT. So we generate different JIT
> code for the same instruction in two passes (one for placeholder
> and one for real address). Let's use move_addr() instead.
>
> See commit 64f50f657572 ("LoongArch, bpf: Use 4 instructions for
>  function address in JIT") for a similar fix.
>
> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcall=
s")
> Reported-by: Vincent Li <vincent.mc.li@gmail.com>
> Closes: https://lore.kernel.org/loongarch/CAK3+h2yfM9FTNiXvEQBkvtuoJrvzmN=
4c_NZsFXqEk4Cj1tsBNA@mail.gmail.com/T/#u
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ea357a3edc09..b25b0bb43428 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -930,7 +930,10 @@ static int build_insn(const struct bpf_insn *insn, s=
truct jit_ctx *ctx, bool ext
>         {
>                 const u64 imm64 =3D (u64)(insn + 1)->imm << 32 | (u32)ins=
n->imm;
>
> -               move_imm(ctx, dst, imm64, is32);
> +               if (bpf_pseudo_func(insn))
> +                       move_addr(ctx, dst, imm64);
> +               else
> +                       move_imm(ctx, dst, imm64, is32);
>                 return 1;
>         }
>
> --
> 2.43.5
>
>

