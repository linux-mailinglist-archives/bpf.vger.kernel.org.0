Return-Path: <bpf+bounces-17301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C580B1A0
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 03:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA501F21426
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 02:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293BEA5;
	Sat,  9 Dec 2023 02:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnW3tYXR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF639EB
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 18:01:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c26a45b2dso15072735e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 18:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702087287; x=1702692087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h5orN2ARCHO/6zd1rEwmcv0ut+xZWYG16KI2rHyTEEc=;
        b=YnW3tYXRMuuhED8nCKNJaeF/LGF4wQpzWOBNhePunI6g4vWUhvBm0RMxGyTjDHDJP3
         7dfeykTrb3x8yCjVg+N1x78LY1Rqnlw7IyPVjm40WvEI7Tt/xwf6+RJ2ADeIBypPzs/y
         tu7apSoz+rr2fMqgOvLRWZQihUemcoxJ5uSzXhE7v5w97HURdgktmy13LMaVlZgb46jF
         L4W5poJNVTfLb8KdO4woHB+CxUS+pRH44FlOnxZPH/pHTj4FDdZKrCIMi75N62w3fseu
         TtewrTGxTlLDji4VKYGFHklzY5p37MFn3JYobPFCG7mzNjlQ0tZRAmbfaPcggW5HqP7Q
         YFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702087287; x=1702692087;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5orN2ARCHO/6zd1rEwmcv0ut+xZWYG16KI2rHyTEEc=;
        b=OU0kR+mQoUewUg39OlhhKRavt6+0kjKhIPz+q2kniBia+/TCGqve3+Vw43b7zkHLPi
         syJsw5/X3b1lZzdBCIPH0HYP1NxSuXBv+NZEHyIIE32xMWmVreebnQMxE1mYerAM2dk2
         6NVKF2N4wGpTaLtnuVPLtwunTLAx6+jhHypgybPkIm9NAm5UtckkTJ1Py5CBG4DSoXXw
         TcUqLsXUoiVE9CRA2M8T9LkknvnwpQ4MNCNo6QgaEon1AtoEy/CsXkOBy2aJ3FA+bFk4
         kIYuLuFBOKa3ETvbDoSlfVxP755eNikAmSxvUXreccCpo/sKd+hW8eA9c+yYV2rFutOb
         BopA==
X-Gm-Message-State: AOJu0Yx19YWrfBxfCjj8VluOpXRTLxvsJkR+IMzRtZ6JI5X0JmvCS8y3
	STK/UHT2ACP5YbdW0XFz+4w=
X-Google-Smtp-Source: AGHT+IGP699oh95R7MT1GKZIBITiRt1ezzoGuVsY7dptTYZs98r9wmoJBuFRqntNXv3Ie4NoJORz9g==
X-Received: by 2002:a05:600c:518a:b0:40b:5e4a:2354 with SMTP id fa10-20020a05600c518a00b0040b5e4a2354mr545749wmb.86.1702087287226;
        Fri, 08 Dec 2023 18:01:27 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6767476wmo.16.2023.12.08.18.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 18:01:26 -0800 (PST)
Message-ID: <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack
 with BPF_ST_MEM instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Sat, 09 Dec 2023 04:01:25 +0200
In-Reply-To: <20231209010958.66758-1-andrii@kernel.org>
References: <20231209010958.66758-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 17:09 -0800, Andrii Nakryiko wrote:
> When verifier validates BPF_ST_MEM instruction that stores known
> constant to stack (e.g., *(u64 *)(r10 - 8) =3D 123), it effectively spill=
s
> a fake register with a constant (but initially imprecise) value to
> a stack slot. Because read-side logic treats it as a proper register
> fill from stack slot, we need to mark such stack slot initialization as
> INSN_F_STACK_ACCESS instruction to stop precision backtracking from
> missing it.
>=20
> Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from st=
ack in precision tracking")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fb690539d5f6..727a59e4a647 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4498,7 +4498,6 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>  		__mark_reg_known(&fake_reg, insn->imm);
>  		fake_reg.type =3D SCALAR_VALUE;
>  		save_register_state(env, state, spi, &fake_reg, size);
> -		insn_flags =3D 0; /* not a register spill */
>  	} else if (reg && is_spillable_regtype(reg->type)) {
>  		/* register containing pointer is being spilled into stack */
>  		if (size !=3D BPF_REG_SIZE) {

So, the problem is that for some 'r5 =3D r10; *(u64 *)(r5 - 8) =3D 123'
backtracking won't reset precision mark for -8, right?
That's not a tragedy we just get more precision marks than needed,
however, I think that same logic applies to the MISC/ZERO case below.
I'll look through the tests in the morning.

