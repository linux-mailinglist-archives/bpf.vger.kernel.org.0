Return-Path: <bpf+bounces-19273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E45828C1E
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 19:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9C71F252D7
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C63C473;
	Tue,  9 Jan 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWzY5dej"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F033BB24
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso38562521fa.0
        for <bpf@vger.kernel.org>; Tue, 09 Jan 2024 10:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704823364; x=1705428164; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qdkJC+ujzcdAYnRBhIl4ExzHPcdimqPKuukxz/IQcv4=;
        b=PWzY5dej/Rs/uMlzgp3ybGdmbBmjJvAcYTAhPZ8eoIAg/JYrUCf1hNRYVaNNWjn/01
         JZ5EX91befSXwbPSI1SSnhMiXS51Ar9CJUlfaHvuPv/Kms1mJM53lOiWmzq8h0oWWx99
         EyVtbT+fqyiQrY2Xnmg2U+UcwVXAIkQMtj7sL6+egTVcoMbwTIEDSkgW89+30HPcgUpB
         aShEw2Tl8tULsTS0CDfylneu5BgNq3cNPRz8ex4x/a5cX8r46FuoNomr8kryPgYmOXKP
         ORjWBx47jndzhyRJ5WSHKDasQyDHL0sI3wXqYyS1R1+M8xIh4AoXe1t8bgK9vsOst1ft
         phqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823364; x=1705428164;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdkJC+ujzcdAYnRBhIl4ExzHPcdimqPKuukxz/IQcv4=;
        b=glZkQDh5s9PGsUpCUABYurIxpg7362j4ek342Uz9IHSpXMmEOi5pe7ZzzeWLuH8ErF
         uT5dmQ1ny9fqTcrnAKlCa6P9hEDhUq6Q9d5vcPNbgWw4GQcbZPfpfcjMIu7DborI2V9K
         SZC8br92j96Zg0m3uwpStI376rAuui9oHe+isUNCigyyjQZDB5w3ZjS3A9UmuwQFk7Gb
         gfioBV5RXnzPI/Ij7SPJU2O6FhFopjgnmSQymeW5OvwJzV8YI2v4Bp2hnnmQcjmojbuE
         pZb4aMScEOp7ZO4kKQculLdV8nOw0chO/kxre+kHxMDYN5YlGMZ2zWggYjbMVSvrSw4i
         sHKQ==
X-Gm-Message-State: AOJu0YxJLByDREaatkSwn/baRSjO1VjqxT5EN2Y8DDlwZ87Wm9icPsYO
	5Ae89oXSPmF0VgBFx8PlR2I=
X-Google-Smtp-Source: AGHT+IElW3zYu4XEtkB/6yD9RKqrEWWEJj1PTamCWYSzRrOX71bLUaMogowkkHvu6DFNkCU9TR0tZg==
X-Received: by 2002:a05:651c:200c:b0:2cc:eefc:20af with SMTP id s12-20020a05651c200c00b002cceefc20afmr2117958ljo.52.1704823363904;
        Tue, 09 Jan 2024 10:02:43 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z7-20020a2ebcc7000000b002cd632cea48sm426086ljp.106.2024.01.09.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:02:43 -0800 (PST)
Message-ID: <de8dd3773d84b4c07fbba2776d52bf2114ca5414.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Tue, 09 Jan 2024 20:02:41 +0200
In-Reply-To: <20240109040524.2313448-1-yonghong.song@linux.dev>
References: <20240109040524.2313448-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 20:05 -0800, Yonghong Song wrote:
[...]
> @@ -4640,7 +4641,18 @@ static int check_stack_write_var_off(struct bpf_ve=
rifier_env *env,
>  			return -EINVAL;
>  		}
> =20
> -		/* Erase all spilled pointers. */
> +		/* If writing_zero and the the spi slot contains a spill of value 0,
> +		 * maintain the spill type.
> +		 */
> +		if (writing_zero && is_spilled_scalar_reg(&state->stack[spi])) {

As discussed on offlist today, this should probably look as follows:

-               if (writing_zero && is_spilled_scalar_reg(&state->stack[spi=
])) {
+               if (writing_zero && *stype =3D=3D STACK_SPILL && is_spilled=
_scalar_reg(&state->stack[spi])) {

In order to handle cases like "mmmmSSSS" for slot types.

> +			spill_reg =3D &state->stack[spi].spilled_ptr;
> +			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value =3D=
=3D 0) {
> +				zero_used =3D true;
> +				continue;
> +			}
> +		}
> +
> +		/* Erase all other spilled pointers. */
>  		state->stack[spi].spilled_ptr.type =3D NOT_INIT;
> =20
>  		/* Update the slot type. */
[...]

