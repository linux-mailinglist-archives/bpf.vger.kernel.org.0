Return-Path: <bpf+bounces-61089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A686AE0A07
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0573116917A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9421C9F2;
	Thu, 19 Jun 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2xCJ5FH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C93085DB;
	Thu, 19 Jun 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346131; cv=none; b=Us69AUIz16HhcM6LlxdsGaOasGy6MY6DF2Y4mAFQ25VxODORNFnEtFqDV3ebcblV4IGw07Hhrj5IvYUCaq6WlzsuYZ4k6K4S23NUsoIOJgmM/iPKuDKeb6RRJxnRy6wiJYQ6OK6i3RfOB2pZk/5O/mvoNJBGL5miXNylTub71/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346131; c=relaxed/simple;
	bh=Oy26i3upVrCD7UDszTSqhSYEJtW0IGyLV7OlJ6noH/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCkSEuhyc/OPGCZq6ihb1yeAhi7j4TcDT8G1PDnSLbREzSFIuzSi/+rFEFWrLhwyCmrR1UpwaIVU1JpJ/Ty3A4vTpsccN8x25iJEIKOWN2vuIy43jjwV+9COYA9Jwtj85Hwt3YV/5Awyw/NjfEBbiFjZWE1ILsLiNsnBL4M0qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2xCJ5FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A852AC4CEF0;
	Thu, 19 Jun 2025 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346130;
	bh=Oy26i3upVrCD7UDszTSqhSYEJtW0IGyLV7OlJ6noH/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d2xCJ5FHgmFi1M00kIgUy9QjepJRjPhXNxk9CaARVBn9nkV8hCkW258NnW7rtOu21
	 ceiHZmM0AYIKiuyzsQI1YrWgpF8nHG2bpnHqaOIbsPUJo95zA4XgBfMQaJQJF0PbSA
	 QtTxdB1BeFu/mZylSlu+pNgS4ia/pscZywi0eOUxAYhOOJdaMlbCxaUZqN70qHxBmI
	 k3SDEMJtF/tbAHurVeL0Bg9CCKyi2WydslDN2VDgaaaK2JyjHNPVRNzbvXYw4CnN1x
	 g7quU3z9lp0auALyABhG/CHq6FbmUT9TOSOkXRBzsCe6Lm5yhIxzB8WAt8rQ9/zhKB
	 pu6i7EffrNBEA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso1574997a12.0;
        Thu, 19 Jun 2025 08:15:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRmx2h7RlmSyKlDg5D1Y2u5ClyKjHAsQIPQF2PeFDbNgRinyaukuzu2WXGRZa+Ypdi+Y4=@vger.kernel.org, AJvYcCVsgBiqUscSQh0epht82+wgv/bFBblzG/d1RFcRKnegYXDzOwJJn8RofbLjTh//+X1LGCnhPphkMeE78ZNa@vger.kernel.org
X-Gm-Message-State: AOJu0YzpinoIXMaUAmo/KO2nZFjon3SfuF0U01CXzZY/h2GSaEvAaFRi
	jjNtxs07Vzr6qdw1TpFl39PrCHYNveNUOe0ouTw6J6/eHC8a3U2FBNY0dDAJHVMOYHS3Sb+YLxP
	NJAu21ayYfvn8DG5AtFxmNMnDRyMqv7U=
X-Google-Smtp-Source: AGHT+IG2ALZUQRFJMZgCdxYR7KvaYQjH4fcXX42gOqzLIZaoeaGclYBaHEWX2rsYxLFZxRm3Zes8D8IOCfQkDnIzMck=
X-Received: by 2002:a05:6402:4416:b0:607:7aed:feef with SMTP id
 4fb4d7f45d1cf-608d09b1569mr19236212a12.34.1750346129245; Thu, 19 Jun 2025
 08:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618105048.1510560-1-duanchenghao@kylinos.cn> <20250618105048.1510560-5-duanchenghao@kylinos.cn>
In-Reply-To: <20250618105048.1510560-5-duanchenghao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 23:15:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CWK=sNCjFVCLq86A6ZPetux_uL9ZtnBf36TU09AKUVQ@mail.gmail.com>
X-Gm-Features: AX0GCFsc6fJ7KC4_g1yD65ZFe4-rT-z964H3Ww8nKBWhEQck_dJgpapMEyVxsEQ
Message-ID: <CAAhV-H5CWK=sNCjFVCLq86A6ZPetux_uL9ZtnBf36TU09AKUVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: BPF: Update the code to rename
 validate_code to validate_ctx.
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chenghao,

On Wed, Jun 18, 2025 at 6:51=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Update the code to rename validate_code to validate_ctx.
> validate_code is used to check the validity of code.
> validate_ctx is used to check both code validity and table entry
> correctness.
Is this patch really needed? Just keep the same with ARM64?


Huacai

>
> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 348ea3bfb..fa187f727 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1185,6 +1185,14 @@ static int validate_code(struct jit_ctx *ctx)
>                         return -1;
>         }
>
> +       return 0;
> +}
> +
> +static int validate_ctx(struct jit_ctx *ctx)
> +{
> +       if (validate_code(ctx))
> +               return -1;
> +
>         if (WARN_ON_ONCE(ctx->num_exentries !=3D ctx->prog->aux->num_exen=
tries))
>                 return -1;
>
> @@ -1293,7 +1301,7 @@ skip_init_ctx:
>         build_epilogue(&ctx);
>
>         /* 3. Extra pass to validate JITed code */
> -       if (validate_code(&ctx)) {
> +       if (validate_ctx(&ctx)) {
>                 bpf_jit_binary_free(header);
>                 prog =3D orig_prog;
>                 goto out_offset;
> --
> 2.43.0
>
>

