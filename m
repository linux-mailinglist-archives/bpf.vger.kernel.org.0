Return-Path: <bpf+bounces-54893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE1DA7592E
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D570D7A44FC
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABD19259F;
	Sun, 30 Mar 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+XFXPaN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8178F29
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743327573; cv=none; b=NihS2pnnwX4oa3gaxTKdWj7iqHsc/6M/pdi2vOswO6pUEOFwLJ6GMj3MMVwCrxRRVD8aRshoDR3Zp2PfyZlLzujdS1SBoKv59frM0XblvVl1O/y3eWVFoPsdL9sw/WjpX/c65OA8ik8N9bEZrNQwsI8QmTJdU3X4Hndvw/U5DZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743327573; c=relaxed/simple;
	bh=dqxX88uoSc8jiPaSwkPSFYEM26rcxCmZHen7rkG7jOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyr8FURPBzjU8ig1kGLEE8KFkQrTLDH578pNnZ0nnDKfib2dYCzMRbSASxxtdUE8SN/4vT7UQwSbEvuh0QhWLvHDWNdiJ7a6wdQkL+PGT/skt9HawzgOUqPuMwbG4hgrPe2lYVOIvIbphn5AWb9wht2O2oZI20B/8ulr7Y+N/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+XFXPaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B81DC4CEDD
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743327573;
	bh=dqxX88uoSc8jiPaSwkPSFYEM26rcxCmZHen7rkG7jOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+XFXPaN3WQYmLbn5oZ95OcWqnNrAHyG/X4gvi6qcrthFpMenRgIJAk8iKn/ayJv/
	 IGrDcU8yH9wIetWV2Yn8Ul1CNbDEzJ11Xioor2Ezw+pM6nKCn/pSIzF/9QsqujVqpq
	 jZryjMwzCi/AciHfTbB2gK60ivVe6EH0MydkKx74x8x+jhQgdC06/dFt54vDm+RHD8
	 f0znDZfqflnSfrSj+MPneLkYj0+vYwBTG0er7YLI7yBxsT+h3a2dbRZk08Izyo/9wH
	 FrJZvHLkU5BjM2XR4dzex3EfA9STY5jFuFFBJAX+mkJJIuirXI6ykqDerKfIb/ZXY3
	 4uhJKUOaQJXjQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso561019366b.3
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 02:39:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXg3VGVWrvQPSf1fgqdfwnpB88pjoA8PeN92lX0IoYLNOd1Crnf5F6n1VXR07oERhVDSAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6BBjlg20dKRMYcOSQuZesi+fNZmE9/5xxhvmuz8ryuOb4vfr
	QTACqgcevg2B3X3VFxWccz/cUeP8JPWk7nXrdYzflxJAd223Y1zLvVePX8ezl3p5ePf42LafMz2
	laWTdtDeOP+24rdUNGYtUqpI0URc=
X-Google-Smtp-Source: AGHT+IHBFKdBTMToxsEZlMY82v0AkEQOR+pSjQDV3ODD3ZEeW2eg59rTurjLiz0ovF5SU9ES4ID/NdAlMmA3Lhzmb7k=
X-Received: by 2002:a17:907:72ce:b0:ac2:4b9:dff8 with SMTP id
 a640c23a62f3a-ac738a4f21fmr466846366b.32.1743327571773; Sun, 30 Mar 2025
 02:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325141046.38347-1-hengqi.chen@gmail.com>
In-Reply-To: <20250325141046.38347-1-hengqi.chen@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 30 Mar 2025 17:39:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H71KH_PBRqFKkp0pFzRNdECTp5fecg1_auqnX-gS=cmUw@mail.gmail.com>
X-Gm-Features: AQ5f1Jp31ng2tOT8HmuQn11aEG4AfVcy-DBpG6_n7xxkNUAP2VnT0wYJqqdTE_s
Message-ID: <CAAhV-H71KH_PBRqFKkp0pFzRNdECTp5fecg1_auqnX-gS=cmUw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Don't override subprog's return value
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, yangtiezhu@loongson.cn, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Mar 25, 2025 at 10:11=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> The verifier test `calls: div by 0 in subprog` triggers a panic at the
> ld.bu instruction. The ld.bu insn is trying to load byte from memory
> address returned by the subprog. The subprog actually set the correct
> address at the a5 register (dedicated register for BPF return values).
> But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> we also sign extended a5 to the a0 register (return value in LoongArch).
> For function call insn, we later propagate the a0 register back to a5
> register. This is right for native calls but wrong for bpf2bpf calls
> which expect zero-extended return value in a5 register. So only move a0
> to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).
>
> Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  arch/loongarch/net/bpf_jit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index a06bf89fed67..73ff1a657aa5 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -907,7 +907,9 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>
>                 move_addr(ctx, t1, func_addr);
>                 emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
> -               move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> +
> +               if (insn->src_reg !=3D BPF_PSEUDO_CALL)
> +                       move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0=
);
>                 break;
>
>         /* tail call */
> --
> 2.43.5
>

