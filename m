Return-Path: <bpf+bounces-76559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B5CBAFEE
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60F993011EF5
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320CD2D7DCF;
	Sat, 13 Dec 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGe/n8U6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A95288D6
	for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765631750; cv=none; b=omAsGalEuxbb8mrz1ihh8Yjv1Mf1RPYuR9LPXIbYlMJOW8DMwXQe0ACnl0QYeIJIOBfvCNiHwp3p9xgSsk5eOFuh/t6ZD+voxyOm/T/20CHXiVfrxqxrfq+lq949O/TzNQQi9iP2UQVCGVGIHnOaCQSXEPLO0h4HliG5dbEYWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765631750; c=relaxed/simple;
	bh=m4ovU1acjiG8ID7BZpH7BYzu5TtfWTbMqmKk7Dy+fhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFXGSEWirzUajbCsjX4rnY7064oXi0TTz9c9z4ju9kTgfSkTb2k+yN5b4WVy43yXwuTkhX1WSJ64XEo53ulp8ls60dP3L6R6G6KIf0c+wIRKomOhbGcMvK4g/1Vea+F9utiIbnxOcHfnh6a4Uya9fIF8JwBk7UZDUdYqlD2JB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGe/n8U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B0FC19421
	for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 13:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765631750;
	bh=m4ovU1acjiG8ID7BZpH7BYzu5TtfWTbMqmKk7Dy+fhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VGe/n8U67LRM2qBiU5iOB3ZInro96peZ/mX7KezRuJFWrjAJ3TISYkTkacut0gi2f
	 C2clWaBtdrPhFQWkDy10PpOFYDgEKDsBXXWKb4qfzbddyyDS2UZJN+vto4KrujyLh1
	 WSkNW20aGjCqlqgCR/2MbWra6i5AQwkJ53NjRRSyz0ggTWjdhmg+qF+RrS2GBSn+f9
	 fVlDU9f36feq/l/tfpPtWD50oTJlpDBl9UZclls5fBDMHXrA6obpclz5WLs7bDrkCF
	 2UhkwEj/r7MsI0b5yQvkn6oy1/MljLZ8w5FWf2HUnG7lMq+FDLSpjEfFHV20u9MqNQ
	 WBuWefRbEb74A==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so3246351a12.0
        for <bpf@vger.kernel.org>; Sat, 13 Dec 2025 05:15:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/FScfoJpif3PbgoyuEp3MjfL7j4DDwO+VJDvQhPrTyqag1ztL7H46tI6jXpYUwmQwSRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOMtRd2vzc9p//XcdCr7sjinMhEpth9uRzOGOgc86EuBLz/cV
	YjonHnqZtPkfOUa9qqqMNHl2C15YVQTQjt7a740+f9N5sPRTt6PuwWEDymFQroOD7HNjlW93pmg
	y+IwQgW+YLWu3zLzOuYqZJq9lpcc4/58=
X-Google-Smtp-Source: AGHT+IH6c2aGs3pGV2qbzSdgH67yeANRBt4zKi9fHupRbRB3sspdfzK1/4vZz9l03lJOOO5Iclqd0HQjP9hVV01NzE0=
X-Received: by 2002:a17:907:d90:b0:b7a:1be1:985 with SMTP id
 a640c23a62f3a-b7d23a9c7f4mr452642966b.65.1765631748772; Sat, 13 Dec 2025
 05:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212091103.1247753-1-duanchenghao@kylinos.cn> <20251212091103.1247753-5-duanchenghao@kylinos.cn>
In-Reply-To: <20251212091103.1247753-5-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 13 Dec 2025 21:16:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-AaD9SuRWt5gK4ODVA356EO7byqf-AnXvr_0C+FuUPg@mail.gmail.com>
X-Gm-Features: AQt7F2qKTklsRl-sx-vCdUFzzD1Fmp1fcr3FKsh_aSrBNnvldyT7mT7iFuedr0g
Message-ID: <CAAhV-H5-AaD9SuRWt5gK4ODVA356EO7byqf-AnXvr_0C+FuUPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: BPF: Enable BPF exception fixup for
 specific ADE subcode
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, hengqi.chen@gmail.com, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, youling.tang@linux.dev, 
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chenghao,

On Fri, Dec 12, 2025 at 5:11=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> This patch allows the LoongArch BPF JIT to handle recoverable memory
> access errors generated by BPF_PROBE_MEM* instructions.
>
> When a BPF program performs memory access operations, the instructions
> it executes may trigger ADEM exceptions. The kernel=E2=80=99s built-in BP=
F
> exception table mechanism (EX_TYPE_BPF) will generate corresponding
> exception fixup entries in the JIT compilation phase; however, the
> architecture-specific trap handling function needs to proactively call
> the common fixup routine to achieve exception recovery.
>
> do_ade(): fix EX_TYPE_BPF memory access exceptions for BPF programs,
> ensure safe execution.
>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/kernel/traps.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.=
c
> index da5926fead4a..4cf72e0af6a3 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -534,7 +534,13 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs,=
 unsigned long fcsr)
>
>  asmlinkage void noinstr do_ade(struct pt_regs *regs)
>  {
> -       irqentry_state_t state =3D irqentry_enter(regs);
> +       irqentry_state_t state;
> +       unsigned int esubcode =3D FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr=
_estat);
> +
> +       if ((esubcode =3D=3D EXSUBCODE_ADEM) && fixup_exception(regs))
> +               return;
No chance for ADEF? And I don't think ixup_exception() can be done out
of irqentry_enter().

This patch is needed by BPF but not part of BPF, so I think the
subject should be:
LoongArch: Enable exception fixup for specific ADE subcode

Huacai

> +
> +       state =3D irqentry_enter(regs);
>
>         die_if_kernel("Kernel ade access", regs);
>         force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)regs->csr_badv=
addr);
> --
> 2.25.1
>

