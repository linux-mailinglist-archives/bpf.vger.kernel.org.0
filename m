Return-Path: <bpf+bounces-64761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B1B16A37
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 03:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1AC7AA159
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17714B092;
	Thu, 31 Jul 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi9Gd/5k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2D7F477;
	Thu, 31 Jul 2025 01:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926279; cv=none; b=Xv6Yon/OM7wMdNkkCYfgBje5ssOJEa+A0+9IRuYjEwugDeV9yvCuIpnoAV2HALWuCU8Y9rIjDAQMiG163K6CDFc1nJvQYgETjtSBm3DWs4bg4aQuzpQTQNMpj4MKFHmuO0oHhmNeSalvmYxjgxt5rZNQ4Vj6SY0PnwIwnfVfACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926279; c=relaxed/simple;
	bh=PXcFVb3XfNEVPp/Kfyksg9teOS85x7QJyRpu+lxqObY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3l49SFwEPF0NNyEOpFch+OcTuE7dQ2gyxhLTAIj+DpqII/rs+XMC+0NXBxhNP7kh8sbCCugN807Hj3E44K1ZvCrDJvtG/jyetbokMt7V2QYhyg3Fz81ApjHsnuSfmOWBBguBDyqFNZz37pza+wARdDScN4pn1DfiecVnGwoFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi9Gd/5k; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-41b9e3c8bd4so268721b6e.0;
        Wed, 30 Jul 2025 18:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753926276; x=1754531076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvqjHObjQC7JX2Ub4wOeZhni34SLZZkthzxU3aytJEM=;
        b=hi9Gd/5kYy3oeB+itP8ngJmL1MabdSk9GXUX2fhtStoT7FtLvV/QYb2q3gRrmYbjXk
         if5H4JU58fNH3zdNYWaydjnjERXtxjFOfiiAVvJUagK1jTB4A4MEqzAVAjjAKAuGKd/a
         ZaC+goz9NiTiX/7bGHWdyQkmFxCKN/ryCAKLW9Cyt7hmyDc8rMAiMAw8umKQTMN6vP+E
         1TYNFNqd7dngx+yJdABq9Acge2RI0QaBXmVmb2mGQp5Wcm/U9KDYjsE5E5TfxiTc3MHK
         Gd8tV23N9OBju17aiwvP1nHvspW/HxNzWWTYIdcOOQgvYj1DFbeYJXnC9Ifz6Fr7P15i
         DXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753926276; x=1754531076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvqjHObjQC7JX2Ub4wOeZhni34SLZZkthzxU3aytJEM=;
        b=H8F3KDo7+ZYDSpBgyYzhqUZIow/95QrL/ykbMZpJWj5VjzM1lYdpx6H5+bqvBJ2c2N
         gLP36r/EijE8LewgtUpHFVHCxKaMAnm68qTi/jds57Nx5c65ZbUgxSQzJFe4chtBus1+
         1AH5qggOg97EizuSndxiLDuh3v2LJ24uLRd+Xk1Yf1bw0E9Ce2t1dSgPWgW5BZdpGwux
         eqlqMOkkiCxmChkHEGGcr4VUdbdbE2HbTmYjEzK6XqluGyO/Au4o5A3DSFY2hE9FHU51
         X0a3vVX1sOUEWEKO/H61lmVFpXqjfA2VHltcc6JYu0KRX42R8gEZI74FjmMTb9fceeGl
         g5rg==
X-Forwarded-Encrypted: i=1; AJvYcCW/7pPn0sp1YNTXhbPExolDeKHhK0top5jyO5YlaZRJPtELzGmjLZY5W8tSJJS+vB3SRPc=@vger.kernel.org, AJvYcCWgnRgKvZuR1NmbKfdyMjNuT9bVoZ9A/dC4ZHOJScMjw+gy1C9lE2TYkPGLcsBr5qwM7tpgvG5I1cgfT7zt@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaM2a5AcKwHbeRbT8PisvXf2zwHCrfc88q1Rh6Ps0yhbIcL2y
	g+BxBN+fW0W60Y7C9DSVOevbG4RAbVG0vnM+Q+J8goFKDEv/N6deJ+hkYDiSKuCRLcGZxwjyrOq
	cdyquhOeGuZ7mcOdcOixk2tEj7SmoNYU=
X-Gm-Gg: ASbGncvd6em4xXOlbem/WCNZ2r3SAFP7tEPBeXiPGJ16l464t6zFum/jkSWEN1ay/OX
	wegQO241SeB8wxGYvlYgapnGRiemtKbIAj3ouxdDczIuXGUJ3dqK0pi7RrWkgYIqfpdphaejCuV
	nU9Ir0XKJ2+jtfYewKl6G+1UmxBLXD7t+kitD3LFUmSqhTJ3JdxCHjTmcNziQ9fIaauRQe4JMjV
	47vTsQ=
X-Google-Smtp-Source: AGHT+IFqiRnMtLMxFx16WSrBf6XJxsgbu5jgcccCl5t+5itNCUcmqyUoKLelAaghTDww78kjcfJl+bfst0NoWS3TiK8=
X-Received: by 2002:a05:6808:1521:b0:406:697f:a62f with SMTP id
 5614622812f47-4319999e1e4mr3911664b6e.10.1753926275877; Wed, 30 Jul 2025
 18:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730131257.124153-1-duanchenghao@kylinos.cn> <20250730131257.124153-3-duanchenghao@kylinos.cn>
In-Reply-To: <20250730131257.124153-3-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 31 Jul 2025 09:44:23 +0800
X-Gm-Features: Ac12FXw2Om8UPwVFQYngJybFlYBDlP0KxfqNZ7udcHhvklhAejZcvU7iATJRcmY
Message-ID: <CAEyhmHRzvazN06DsrqTO9PiBj7kJpZ3XdcOpxE2khjaKaE5jZQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] LoongArch: BPF: Update the code to rename
 validate_code to validate_ctx
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	vincent.mc.li@gmail.com, geliang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 9:13=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Rename the existing validate_code() to validate_ctx()
> Factor out the code validation handling into a new helper validate_code()
>
> * validate_code is used to check the validity of code.
> * validate_ctx is used to check both code validity and table entry
>   correctness.
>
> The new validate_code() will be used in subsequent changes.
>

I still feel uncomfortable about the subject line.
Hope Huacai can rephrase it when apply.
other than that,

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>

> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4a..7032f11d3 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1180,6 +1180,14 @@ static int validate_code(struct jit_ctx *ctx)
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
> @@ -1288,7 +1296,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
>         build_epilogue(&ctx);
>
>         /* 3. Extra pass to validate JITed code */
> -       if (validate_code(&ctx)) {
> +       if (validate_ctx(&ctx)) {
>                 bpf_jit_binary_free(header);
>                 prog =3D orig_prog;
>                 goto out_offset;
> --
> 2.25.1
>

