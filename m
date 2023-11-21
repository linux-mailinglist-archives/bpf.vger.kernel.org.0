Return-Path: <bpf+bounces-15542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24ED7F3381
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E6C28114C
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91C5A0FC;
	Tue, 21 Nov 2023 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVFaLk+1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A29E192
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:20:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a002562bd8bso337644666b.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700583613; x=1701188413; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0zAewIPsLIKzBjojwrvV275OwoH614oIU/UBLUQgsl8=;
        b=fVFaLk+1WO/3pAB7OGLk0wSxjUI2/ldFQFCIMfbo/RVpsS0PyNa9jePXDqgxC2p+ig
         ofx+hUakcO0g18qcTJqV5+njA65A9Ta3BwF5JUUMSdsPz/IaF079Z1v6Eay4ouL7gbQB
         yfbGlEYldvD+/lZy+mBI18NA5pSDWg4nukw1bGFZr9t5LDnyi8FabiQnVtCg7mkJZLqR
         8pTxVVSqgwskIJdJH7gaD+at3jUXo/OYTBE+WJR1KZLKd3z1BAcA4FcOTEYD3CZATGEq
         LKy/fvO1skdWBXP8AzkZjbQKUgNBAV8PhRlW2+nmOwJuVaoBMrnrBF0quKkletaU4REH
         W/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583613; x=1701188413;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zAewIPsLIKzBjojwrvV275OwoH614oIU/UBLUQgsl8=;
        b=c5GdRzSKHRBcMUYzPljZ8GcTrha4xeWXM4Acl1a6XUy3quTN08X/FZsRCrWWDmQfwT
         q4hK1ImOR4uSEgUuvj/lFy3LisLpsX2wZhWJjWfprGeJkPiShrXe6iohJueFiRtpxFG4
         OETIKh3TpsIO++65VhMGWHeKfyc2bkhaDZcoSwzEvAU7e/wfpWgTM+FXI6GzCVY3wRfP
         TsIZBWGAUJSKe3RfbzYtSMxqwPA/jobVL+xv7Jsa3dCLRWQrLHwuLGdkIpzhCwVIuc+n
         dEqjfA9Yg8/X000pa6cNRt1ykYn3fWIz/CL+ijHcqa0AKIASLBBJ59bqQhshu6R1dWB0
         qpFw==
X-Gm-Message-State: AOJu0Yy4c+p9AnbfT0lXaOWgFODAziuq9oBOiLZMuk0XlKM1h8vf+zTa
	zaEc6+tiJo69deOrODScvloumQhfIo8=
X-Google-Smtp-Source: AGHT+IFvzNRa2hPD6wot74PT5OEo4T2Pn18EGd0GBojOFgVGLusfr2qaDqzjRB5JIWpQ0r/GitXquw==
X-Received: by 2002:a17:906:1001:b0:9ee:295:5696 with SMTP id 1-20020a170906100100b009ee02955696mr2646126ejm.2.1700583612712;
        Tue, 21 Nov 2023 08:20:12 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090630c800b009de3641d538sm5420378ejb.134.2023.11.21.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:20:11 -0800 (PST)
Message-ID: <d2cc304ac744e2663c8802e3853ed1e948743b32.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/10] bpf: preserve constant zero when
 doing partial register restore
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 21 Nov 2023 18:20:00 +0200
In-Reply-To: <20231121002221.3687787-7-andrii@kernel.org>
References: <20231121002221.3687787-1-andrii@kernel.org>
	 <20231121002221.3687787-7-andrii@kernel.org>
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

On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
> Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes from
> stack from slot that has register spilled into it and that register has
> a constant value zero, preserve that zero and mark spilled register as
> precise for that. This makes spilled const zero register and STACK_ZERO
> cases equivalent in their behavior.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +				if (spill_cnt =3D=3D size &&
> +				    tnum_is_const(reg->var_off) && reg->var_off.value =3D=3D 0) {
> +					__mark_reg_const_zero(&state->regs[dst_regno]);
> +					/* this IS register fill, so keep insn_flags */
> +				} else if (zero_cnt =3D=3D size) {
> +					/* similarly to mark_reg_stack_read(), preserve zeroes */
> +					__mark_reg_const_zero(&state->regs[dst_regno]);
> +					insn_flags =3D 0; /* not restoring original register state */

nit: In case if there would be v3, could you please
     leave a comment here, something like below:
    =20
       when check_stack_write_fixed_off() puts STACK_ZERO marks
       for writes, not aligned on register boundary, it marks source
       registers precise. Thus, additional precision propagation is
       necessary in this case and insn_flags could be cleared.

     or something along these lines?

> +				} else {
> +					mark_reg_unknown(env, state->regs, dst_regno);
> +					insn_flags =3D 0; /* not restoring original register state */
> +				}
>  			}
>  			state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
>  		} else if (dst_regno >=3D 0) {




