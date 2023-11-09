Return-Path: <bpf+bounces-14592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1707E6D3B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291AB281074
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB641A73B;
	Thu,  9 Nov 2023 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXIQCzk6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD0200D8
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:21:02 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238C30E5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:21:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9dbb3d12aefso171964466b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543260; x=1700148060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+x/PX+iK/7RFvN4QfswAeTVec4PLOOY/3WxBtPhxzy4=;
        b=UXIQCzk6a/J8S73E1wex+NI94m3+qf8LPdaHU7WcPntieO97s15Omdm1C3MmMFroxP
         73ZkTH1W4tXhtTUFpko92e9Zz6nPY9cpoltglQoHUhrZCQH8GlOjW04bchGHrYVprOoo
         3yIjUGiWfNDrdxGis4REm5EMkAb2SDiyZ5g8RinqtK9JpPGtWFnka3o9P/GXcOFUxUvp
         8IjF3QTwxmG3SQrVqzrLNAqurW/HpG76JLeUOyaOBla+O3TpztpNlNURAvf/CFZQpOO8
         jwwGPVFQY7GkCOeeiS4c1RaMgq4OgE7fAiSayl5l+/p7TEs88DI7LI88lOlZtQdXgWRC
         uMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543260; x=1700148060;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x/PX+iK/7RFvN4QfswAeTVec4PLOOY/3WxBtPhxzy4=;
        b=nc5zMS3SLVwjeXqGUsVN8u5zflA2kCFlZJD0kNunPBGWnud/WDVdBWMm8scZHUX7z0
         QR/wtA1FImnA9UuSlO+bJBj3rqBPwMaB21glQNUO2qmVa53JAoqAU0hBO/b+bzgCiDOX
         0Rm9MWUqV/cF8k25/TJEnkcoi8/KJkIKAz8vKlEAK0azMmu/FD2T5KqSJYf1fybDHcbY
         D97xBh5BdJQ76A4RjJPxBIVmMw74+D0L9E8KNGDvR4nRQH/ygsBa18l9l6DY55QiVJQt
         x6vjAK17mOXLNDVKQfPxRACouP22YG4V/McARWqTO4y6XuGbQKxlbK1ho4Yw42boMZFT
         FhZQ==
X-Gm-Message-State: AOJu0YxGcwJfcwZ/zkJQBxcm+JomNJ1dqlKvRJxh1rGLUPM8AFXVx+X1
	kGBLZP6FBTNmUqfgQM/XMuM=
X-Google-Smtp-Source: AGHT+IHhRrM2P6cVV0mYcaiqRaILF6woorSipg3wZLmC6xJWyne6NUmEojVr5qrx73gB7vs/NLZWbg==
X-Received: by 2002:a17:907:26c4:b0:9dd:bd42:4ec7 with SMTP id bp4-20020a17090726c400b009ddbd424ec7mr4016627ejc.38.1699543260243;
        Thu, 09 Nov 2023 07:21:00 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b009b928eb8dd3sm2641447ejz.163.2023.11.09.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:20:59 -0800 (PST)
Message-ID: <891df9e42aee4ce7c46010cd93744e2b90819502.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: preserve constant zero when doing
 partial register restore
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 17:20:58 +0200
In-Reply-To: <20231031050324.1107444-7-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-7-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes from
> stack from slot that has register spilled into it and that register has
> a constant value zero, preserve that zero and mark spilled register as
> precise for that. This makes spilled const zero register and STACK_ZERO
> cases equivalent in their behavior.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Could you please add a test case?

[...]

> ---
>  kernel/bpf/verifier.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0eecc6b3109c..8cfe060e4938 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4958,22 +4958,39 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
>  				copy_register_state(&state->regs[dst_regno], reg);
>  				state->regs[dst_regno].subreg_def =3D subreg_def;
>  			} else {
[...]
> +
> +				if (spill_cnt =3D=3D size &&
> +				    tnum_is_const(reg->var_off) && reg->var_off.value =3D=3D 0) {
> +					__mark_reg_const_zero(&state->regs[dst_regno]);
> +					/* this IS register fill, so keep insn_flags */
> +				} else if (zero_cnt =3D=3D size) {
> +					/* similarly to mark_reg_stack_read(), preserve zeroes */
> +					__mark_reg_const_zero(&state->regs[dst_regno]);
> +					insn_flags =3D 0; /* not restoring original register state */
> +				} else {
> +					mark_reg_unknown(env, state->regs, dst_regno);
> +					insn_flags =3D 0; /* not restoring original register state */
> +				}

Condition for this branch is (off % BPF_REG_SIZE !=3D 0) || size !=3D spill=
_size,
is it necessary to check for some unusual offsets, e.g. off % BPF_REG_SIZE =
=3D=3D 7
or something like that?

[...]



