Return-Path: <bpf+bounces-13709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C97DD0A5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECEB1B20E9D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8D1E52D;
	Tue, 31 Oct 2023 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbqvvo0w"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607B10F3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:37:18 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913DBC1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c2a0725825so927105166b.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766635; x=1699371435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qgyiklkZyZ0Xf/SW4jXYAGh47nIB2uhVltbHaBPTBwc=;
        b=cbqvvo0w0LjC47i726o0+g2ZohCRoQLLhI1w1q3yN6Rm++FN0gswJ5B9C7pDQfa64j
         KRltxAdfZf9N9zZrJnVfYfx30RyiQ5/qwXyEYIe4TfnJU7twy7Z+IY/+8ChzIHLPG0ko
         OGSbOeTRB+qs+3/KXx5ry2aFNt3r4xXJEq8mNrMieX/wBgTPwpUpW1qvbWPuSyyKvrEW
         fn4He0N5IDZD9ALd5gruxAgYfy2F2eExYrq6Nlls9/V8kVvkFNOrTUJcb7o6pqaXo+3Q
         cyNJhYOANEscmJ/vWlJ/s0XrOFxoN1ypGcTZ/Ckhnc+kSM00k8tTq1c9jafVZbkYUu+P
         gXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766635; x=1699371435;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgyiklkZyZ0Xf/SW4jXYAGh47nIB2uhVltbHaBPTBwc=;
        b=ePJDghvEoZwc+KyGsLaN3v+CYNMPL9herSMyvlXWyhkr0fgMim2lBHjvMbyts4VT99
         /se781vM9MbO886nZbOibzyAKMEIZnrtRT7p6LatTwt/lHAjgL8kYUMvSjnA8zQKAcx5
         XpZEJB8FcqytFlLmmH8HJZmdUQmtPlRoNaWjJHzMSU3+VdmRkf72H/5WxBD7a9mTwGW8
         EIl/1z+3bv6BNe5RHxQfrArcrmtocSYn0vKtgw7cHTCTjTDYt/PHCBTyGSH9+zaJ5wse
         Tj9T4UY2pfUNzaWUmJmfvzcNykJcJj/My8hq0NBsNX23cQYSDDIVJPmS3fZtJxSMRN0Y
         bk7g==
X-Gm-Message-State: AOJu0YyTPO5Xnf0UpUCdbOy3vDpUr8HrJlsZp65o+1S/GIwuWUSd2NAc
	2USN3rfW3FEWM1SDFfwoSMw2t6e2dJt+Bg==
X-Google-Smtp-Source: AGHT+IFsZQuM/XzmFNvckRsoYWaT9ivS4oD5Fy6vEfbs7Lh6iGqGJ5ey1t3efqsQY5tc6hW66B80nw==
X-Received: by 2002:a17:906:b74d:b0:9d3:8d1e:cef with SMTP id fx13-20020a170906b74d00b009d38d1e0cefmr4658432ejb.59.1698766634767;
        Tue, 31 Oct 2023 08:37:14 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ga16-20020a170906b85000b009d152059ad7sm1156838ejb.39.2023.10.31.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:37:14 -0700 (PDT)
Message-ID: <487ae806ba081a07b43733d0698752f4414cd01d.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/23] bpf: derive smin/smax from umin/max
 bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Tue, 31 Oct 2023 17:37:12 +0200
In-Reply-To: <20231027181346.4019398-4-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> Add smin/smax derivation from appropriate umin/umax values. Previously th=
e
> logic was surprisingly asymmetric, trying to derive umin/umax from smin/s=
max
> (if possible), but not trying to do the same in the other direction. A si=
mple
> addition to __reg64_deduce_bounds() fixes this.
>=20
> Added also generic comment about u64/s64 ranges and their relationship.
> Hopefully that helps readers to understand all the bounds deductions
> a bit better.
>=20
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nice comment, thank you. I noticed two typos, see below.

> ---
>  kernel/bpf/verifier.c | 70 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 857d76694517..bf4193706744 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2358,6 +2358,76 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
> =20
>  static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
>  {
> +	/* If u64 range forms a valid s64 range (due to matching sign bit),
> +	 * try to learn from that. Let's do a bit of ASCII art to see when
> +	 * this is happening. Let's take u64 range first:
> +	 *
> +	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
> +	 * |-------------------------------|--------------------------------|
> +	 *
> +	 * Valid u64 range is formed when umin and umax are anywhere in this
> +	 * range [0, U64_MAX] and umin <=3D umax. u64 is simple and
> +	 * straightforward. Let's where s64 range maps to this simple [0,
> +	 * U64_MAX] range, annotated below the line for comparison:

Nit: this sentence sounds a bit weird, probably some word is missing
     between "let's" and "where".

> +	 *
> +	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
> +	 * |-------------------------------|--------------------------------|
> +	 * 0                        S64_MAX S64_MIN                        -1
> +	 *
> +	 * So s64 values basically start in the middle and then are contiguous
> +	 * to the right of it, wrapping around from -1 to 0, and then
> +	 * finishing as S64_MAX (0x7fffffffffffffff) right before S64_MIN.
> +	 * We can try drawing more visually continuity of u64 vs s64 values as
> +	 * mapped to just actual hex valued range of values.
> +	 *
> +	 *  u64 start                                               u64 end
> +	 *  _______________________________________________________________
> +	 * /                                                               \
> +	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
> +	 * |-------------------------------|--------------------------------|
> +	 * 0                        S64_MAX S64_MIN                        -1
> +	 *                                / \
> +	 * >------------------------------   ------------------------------->
> +	 * s64 continues...        s64 end   s64 start          s64 "midpoint"
> +	 *
> +	 * What this means is that in general, we can't always derive
> +	 * something new about u64 from any random s64 range, and vice versa.
> +	 * But we can do that in two particular cases. One is when entire
> +	 * u64/s64 range is *entirely* contained within left half of the above
> +	 * diagram or when it is *entirely* contained in the right half. I.e.:
> +	 *
> +	 * |-------------------------------|--------------------------------|
> +	 *     ^                   ^            ^                 ^
> +	 *     A                   B            C                 D
> +	 *
> +	 * [A, B] and [C, D] are contained entirely in their respective halves
> +	 * and form valid contiguous ranges as both u64 and s64 values. [A, B]
> +	 * will be non-negative both as u64 and s64 (and in fact it will be
> +	 * identical ranges no matter the signedness). [C, D] treated as s64
> +	 * will be a range of negative values, while in u64 it will be
> +	 * non-negative range of values larger than 0x8000000000000000.
> +	 *
> +	 * Now, any other range here can't be represented in both u64 and s64
> +	 * simultaneously. E.g., [A, C], [A, D], [B, C], [B, D] are valid
> +	 * contiguous u64 ranges, but they are discontinuous in s64. [B, C]
> +	 * in s64 would be properly presented as [S64_MIN, C] and [B, S64_MAX],
> +	 * for example. Similarly, valid s64 range [D, A] (going from negative
> +	 * to positive values), would be two separate [D, U64_MAX] and [0, A]
> +	 * ranges as u64. Currently reg_state can't represent two segments per
> +	 * numeric domain, so in such situations we can only derive maximal
> +	 * possible range ([0, U64_MAX] for u64, and [S64_MIN, S64_MAX) for s64=
).
                                                                  ^
Nit:                                                      missing bracket

> +	 *
> +	 * So we use these facts to derive umin/umax from smin/smax and vice
> +	 * versa only if they stay within the same "half". This is equivalent
> +	 * to checking sign bit: lower half will have sign bit as zero, upper
> +	 * half have sign bit 1. Below in code we simplify this by just
> +	 * casting umin/umax as smin/smax and checking if they form valid
> +	 * range, and vice versa. Those are equivalent checks.
> +	 */
> +	if ((s64)reg->umin_value <=3D (s64)reg->umax_value) {
> +		reg->smin_value =3D max_t(s64, reg->smin_value, reg->umin_value);
> +		reg->smax_value =3D min_t(s64, reg->smax_value, reg->umax_value);
> +	}
>  	/* Learn sign from signed bounds.
>  	 * If we cannot cross the sign boundary, then signed and unsigned bound=
s
>  	 * are the same, so combine.  This works even in the negative case, e.g=
.




