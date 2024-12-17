Return-Path: <bpf+bounces-47134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F49F566D
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 19:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D162B7A3A79
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 18:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBF1F8AD1;
	Tue, 17 Dec 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dyp9/OYf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150A1F8929;
	Tue, 17 Dec 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460698; cv=none; b=fzbaJpUvvHL+oI+XDtd9zSZuvtaOmzqAcKttQMrbJClNC5wm/WgGjIxh4vETXS9w2URYMSMAERnHYtvrpr26Uck7Btr0vxg1rfr8mwoPZbtpLxxuAiCquBCQ+sy33OSWHvJNNSPVfOqBouzkIySE8tqxcRDXLHd80i0dkuOmeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460698; c=relaxed/simple;
	bh=f2FzyaOyPDsaxGvjsPFzwqvEoZrvAjj453BH8q7XiRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5Key6jEJL8IBaB2M6M8yvUqoAr/Q4hz6+7UJFcIlb1kbCcWnsarFqumlVrS2KAnMykoOv5ymhTgBv8NqjQktWNgLfl/H1sV4apG5mKyXoQ9cJQ5+iWrcrgNFpnFDds03FHa6szKHxnRII+58s5Mbb9Co2aoRvNaFzwnYkMWLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dyp9/OYf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb95317so52590885ad.1;
        Tue, 17 Dec 2024 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734460696; x=1735065496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRGe4dTLtYwj2VBbTgj28SHXLo2nIoOZT7krPn0WOLo=;
        b=Dyp9/OYf8gNBATmCgDUeIyk5m8XzjqDMNyKasSsVjXM0SljRgmKRJ5UmYFP8ZQmblP
         kd47wwgXLbPOFHGkksqTBjjyleaRaAgOZX0ZdGkk0gB+iaYCFPPpHo/Wq4SGZhte8+vc
         KdJTHypQgbe+euf6lqaSUXg/CedOZUPj3eoJQOFk3SyLU9eN39ZY7M62gE/cOnDZXVf7
         Fik335abDnUBF7mba4ge24rr9bZqbqs8OyWf+9u7yCCVfOX7wuW7ogsDfS+aK2v5EfO3
         YGZNDTYJt9h3iOxQs9CbCl7ukzOA0B+h5uumvzHV1V3Cm5XawkH5748wy/P2nkIgLd+B
         gK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460696; x=1735065496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRGe4dTLtYwj2VBbTgj28SHXLo2nIoOZT7krPn0WOLo=;
        b=Dxzf988NuaIuZhhZzFxPy4KAwTVS15/A3Imwmvd+qQruAMRP56IMNlbpm8KMvbfMUr
         P05kp9dUYxMAN1dNUR0J4hMz/TxduHkOS1+vdnIv2DAuk6gexxRSSGo8bXlGSkICAcZ4
         m1IkRSnJ0icEMV7ylgcNKFfLO7IKJnYaRJUeIf2zMELY33GgzZZ+4mHXBsTlw6pjSZsk
         OZy+ztpTkEK+/8hOj9Zd4czU2eA5wWPHn7DdJvEKSR2bO9keQxMSFgfkSRIOozljlGb+
         2EU9vxoADqE+9+693dDXtDlOlbUtKfqvCcxXbQtd+Av5L5HRbcyqTlg3UDrzduLHOm6g
         h/wA==
X-Forwarded-Encrypted: i=1; AJvYcCUcH4abNpRJhDtiKRFhtsZByRFOSKlZ5Um9PTWYHLvrXEp0/6moIeeSP4FBC2Alj05nU1E=@vger.kernel.org, AJvYcCXgY8POITllJf5232G+6+/764n9QuKm+61Cm/L0BD8h1OtByTHg/aGa0lKyEYqUoba7fRqSe2isdk27kQnF@vger.kernel.org
X-Gm-Message-State: AOJu0YydOL49Rlbx7IMBsQubgKJgyzY1m+BvmAoeIoHSDqEgOwOHcSvP
	fHI+Gwhv5lRHo/ryapKN0Ajpr+738JCOLPg+Df1nG/egWNN2MTs2bc2ujXFgljZ7iUyWJPRY6zu
	g5ZYNULKAAbpbSwHF3iaGpPt2/WM=
X-Gm-Gg: ASbGnctFX1dJ3HZlMfm3PhQsmW1B6wBhsUgFbaHBuwC9p63LKL9069yBuDeKeyRcDNV
	EdjP8nYfWSYzctwzHgz0zxG+r6VcrTi6EE3VFGv5xyVN9n0TuVZRzpg==
X-Google-Smtp-Source: AGHT+IFADJk/V58dwhr51hK6ZTD8QXMcJm0GrImcTeXtre7ml3uwCxBqdwX/u0y6Z9dO1DDy1js2m/uLEUa1z8MzI5I=
X-Received: by 2002:a17:903:946:b0:215:a179:14d2 with SMTP id
 d9443c01a7336-21892a5c0ecmr241780545ad.50.1734460696019; Tue, 17 Dec 2024
 10:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216210031.551278-1-arighi@nvidia.com>
In-Reply-To: <20241216210031.551278-1-arighi@nvidia.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Dec 2024 10:38:04 -0800
Message-ID: <CAEf4BzbKZ3JL7FigJ1aRDJSiRYBA8wYjh0+TYNfnsNVHd30j7g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP
To: Andrea Righi <arighi@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:00=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> On x86-64 calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP
> disabled can trigger the following bug, as pcpu_hot is unavailable:
>
>  [    8.471774] BUG: unable to handle page fault for address: 00000000936=
a290c
>  [    8.471849] #PF: supervisor read access in kernel mode
>  [    8.471881] #PF: error_code(0x0000) - not-present page
>
> Fix by inlining a return 0 in the !CONFIG_SMP case.
>
> Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/bpf/verifier.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> ChangeLog v1 -> v2:
>   - inline a "return 0" instead of not inlining bpf_get_smp_processor_id(=
) at
>     all in the !CONFIG_SMP case, as suggested by Daniel
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f7f892a52a37..761c70899754 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                          * changed in some incompatible and hard to suppo=
rt
>                          * way, it's fine to back out this inlining logic
>                          */
> +#ifdef CONFIG_SMP
>                         insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(un=
signed long)&pcpu_hot.cpu_number);
>                         insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
>                         insn_buf[2] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF=
_REG_0, 0);
>                         cnt =3D 3;
> -
> +#else
> +                       BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0),

um... shouldn't this be `insns_buf[0] =3D ` assignment? And that comma
instead of semicolon at the end?

pw-bot: cr

> +                       cnt =3D 1;
> +#endif
>                         new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
>                         if (!new_prog)
>                                 return -ENOMEM;
> --
> 2.47.1
>

