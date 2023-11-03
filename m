Return-Path: <bpf+bounces-14083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204457E075D
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 18:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A621C210AF
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9D20B01;
	Fri,  3 Nov 2023 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4YzgC6B"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088D18626
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 17:28:11 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38338184
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 10:28:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so3876611a12.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699032484; x=1699637284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QLh1ThO/pecSLGmi9KoJbla/HOAqh4ov8B3T0B3+HNs=;
        b=B4YzgC6BlDQS1nVBTkbLoSh3ghSn508GOIBqEJKeiKCFow//DMALWWIDHnsBpIh5j4
         Jcwla3ZpYCW0VNndKeeAy4dHCDG6Sl1VU3L8R0NVKwoZhbZlwPdgJ+JHEEEVMSLH0weX
         dZcT4ORXbieFMBJdwnA9XUbnzf2DnGn1SosTe2UHpZGQWyD7+R2LMN90CoA0+yeC1sBE
         FT6+ob5TwE1ZPnp07f3Pvafj71EeVbR9YknuuWVSsK2nlx5rvBbvVSm7P/6TsulqH5i9
         /V36t301xvyrjXLk3yOqdQCiv84KgZ6U6yEuJVWRiD3cOnKEbfO23L0cyPWgJGXI6PxR
         KRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032484; x=1699637284;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLh1ThO/pecSLGmi9KoJbla/HOAqh4ov8B3T0B3+HNs=;
        b=EAzqK710AKeXLG0GnoDyM9FJJ9PSszN7LPRLUK189h1Ov+aTOADzjxmrQOfNgOUYD1
         bVEbne+2Pq+Pd/+romeMtRBZGAAcZqZNgO7QoDq8u1pEKYZUiLssoeD3eIhJG4SN/a5t
         n1lZW8yi7+tXVr1pI1Etgw4DkEWQLzpjqjvbDUwqaoFbIpjPV/GVEFsswMSZeOk1c+Mj
         jJOojtcjeDEhDgoeGaWDKc3KBAU0CrUGu3Vf2EbK8mC//FkxEH/oGIr5zXZyD32KTvnx
         eoPt4oJ+3jsSz523U+kw0DrGavp4GAxpS8sBB0cbNF+JURQSqYMlsBvnCgkzaNcq67/0
         9YOw==
X-Gm-Message-State: AOJu0YwcYExaGV9nbdOB0F4JfAm3yJEdtps3lZgtsn4PQUb3wx8s4ymP
	m6AXfgdB6wwCoWHmR1dV4bw=
X-Google-Smtp-Source: AGHT+IF94ALi4W53tQmQTvG9A6AXFKPFuM4AwH2xr9uXk/0TRgDisfLP3elGMz0T6EnmV35UqBVuUw==
X-Received: by 2002:a17:907:7f06:b0:9be:6ff7:1287 with SMTP id qf6-20020a1709077f0600b009be6ff71287mr8235155ejc.57.1699032484568;
        Fri, 03 Nov 2023 10:28:04 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b009a168ab6ee2sm1117661ejq.164.2023.11.03.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:28:04 -0700 (PDT)
Message-ID: <8d2ada70affa8559cf954f64316b5ea0c9d1d348.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Fri, 03 Nov 2023 19:28:02 +0200
In-Reply-To: <20231103000822.2509815-4-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-4-andrii@kernel.org>
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

On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditions
> that otherwise would be "inconclusive" (i.e., is_branch_taken() would
> return -1). This can happen, for example, when registers are initialized
> as 64-bit u64/s64, then compared for inequality as 32-bit subregisters,
> and then followed by 64-bit equality/inequality check. That 32-bit
> inequality can establish some pattern for lower 32 bits of a register
> (e.g., s< 0 condition determines whether the bit #31 is zero or not),
> while overall 64-bit value could be anything (according to a value range
> representation).
>=20
> This is not a fancy quirky special case, but actually a handling that's
> necessary to prevent correctness issue with BPF verifier's range
> tracking: set_range_min_max() assumes that register ranges are
> non-overlapping, and if that condition is not guaranteed by
> is_branch_taken() we can end up with invalid ranges, where min > max.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>=20
>   [0] https://lore.kernel.org/bpf/CACkBjsY2q1_fUohD7hRmKGqv1MV=3DeP2f6XK8=
kjkYNw7BaiF8iQ@mail.gmail.com/
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2627461164ed..8691cacd3ad3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14214,6 +14214,18 @@ static int is_scalar_branch_taken(struct bpf_reg=
_state *reg1, struct bpf_reg_sta
>  			return 0;
>  		if (smin1 > smax2 || smax1 < smin2)
>  			return 0;
> +		if (!is_jmp32) {
> +			/* if 64-bit ranges are inconclusive, see if we can
> +			 * utilize 32-bit subrange knowledge to eliminate
> +			 * branches that can't be taken a priori
> +			 */
> +			if (reg1->u32_min_value > reg2->u32_max_value ||
> +			    reg1->u32_max_value < reg2->u32_min_value)
> +				return 0;
> +			if (reg1->s32_min_value > reg2->s32_max_value ||
> +			    reg1->s32_max_value < reg2->s32_min_value)
> +				return 0;
> +		}
>  		break;
>  	case BPF_JNE:
>  		/* constants, umin/umax and smin/smax checks would be
> @@ -14226,6 +14238,18 @@ static int is_scalar_branch_taken(struct bpf_reg=
_state *reg1, struct bpf_reg_sta
>  			return 1;
>  		if (smin1 > smax2 || smax1 < smin2)
>  			return 1;
> +		if (!is_jmp32) {
> +			/* if 64-bit ranges are inconclusive, see if we can
> +			 * utilize 32-bit subrange knowledge to eliminate
> +			 * branches that can't be taken a priori
> +			 */
> +			if (reg1->u32_min_value > reg2->u32_max_value ||
> +			    reg1->u32_max_value < reg2->u32_min_value)
> +				return 1;
> +			if (reg1->s32_min_value > reg2->s32_max_value ||
> +			    reg1->s32_max_value < reg2->s32_min_value)
> +				return 1;
> +		}
>  		break;
>  	case BPF_JSET:
>  		if (!is_reg_const(reg2, is_jmp32)) {


