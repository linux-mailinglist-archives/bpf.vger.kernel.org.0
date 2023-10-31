Return-Path: <bpf+bounces-13712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274317DD0A9
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4851C1C20CC6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D3F1E531;
	Tue, 31 Oct 2023 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g63eWY6a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CE1DDFC
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:37:52 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F78F
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso825994366b.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766669; x=1699371469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3htT3DQ9wREQsv/N/wX54gWg6z6W5bfOj7fFWd2V2GI=;
        b=g63eWY6alGpIVDxB4kb7qgl3WTZKyvLFdIG0cLSLxvBFrYdoLEU00qBSPOWvyEPNll
         R4drnnPB5aWMNK/uOBGyYFGIdQ/OgvGqdsO92nDxyTsCW3C7law1BF40WhqJ/j6STmxC
         iBVKOUMFHqW6xF9yLd29iDqXlUlcI6F9SzIvx+DJM9pe1zVlWqhNOJm1azv8v5gm3xR4
         anMaMOWCVcXQy07+llomlTzdFs1rxFuwMdtmqwnBI+Pv/ZQKwLp9fa2eY7/OXm4fPhUG
         Il/9bMHTDzQjs6Vl+C+CQlsYVvUOEGBW8AHuY3shlTQT89ggoGKek01YmxdtkHBngolt
         Y30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766669; x=1699371469;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3htT3DQ9wREQsv/N/wX54gWg6z6W5bfOj7fFWd2V2GI=;
        b=g9cd2U7L19bYeNy3DDNouWnn3DMogypfWCQNqVD/V1B2jLCb9S7l6JU9W6t3A4KrSG
         gZrZ/zo/nmDKcQbmnHprrjvGmiPdiphe+JPLr5oX+uhOuIKFlw1NgIzbVMXZu8ufd8Yu
         ey48k/wCsErLbC2BO5uD1a/9PbDj+CdaJx+m8fix04VnipkR8lGDZttQbFmquLuV8ZFy
         58bVz3OGpGKKu8Fp1NV8LLX+nwBXoRE4Rtc0CMK1euBwTwxJMcwbHIrM6Okuwv09FZ7k
         FXimeABsVIayEk4rpifc2CNvESRrUIe4hQfBYZ54qrk+mpgHbXEXpzQmjjwFwvKIMhnv
         0nXw==
X-Gm-Message-State: AOJu0YzVB8vclovhssTWqf9otF1AEJCjohg4JoSiY1Qr7gLau9AV1ynH
	17aN8jC1MD2WQW1Dji43bbM=
X-Google-Smtp-Source: AGHT+IEKO6w+kawRz0pJwfVzplgk27Ax25koFokNifIuWO7ZVTlxGbnXg2v7L0UZ53QyaBmRlVZE4A==
X-Received: by 2002:a17:907:3f1a:b0:9be:b41d:4f7e with SMTP id hq26-20020a1709073f1a00b009beb41d4f7emr10887656ejc.17.1698766668745;
        Tue, 31 Oct 2023 08:37:48 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u11-20020a1709063b8b00b009829d2e892csm1176267ejf.15.2023.10.31.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:37:48 -0700 (PDT)
Message-ID: <d7af631802f0cfae20df77fe70068702d24bbd31.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 06/23] bpf: add special smin32/smax32
 derivation from 64-bit bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Tue, 31 Oct 2023 17:37:47 +0200
In-Reply-To: <20231027181346.4019398-7-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-7-andrii@kernel.org>
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
> Add a special case where we can derive valid s32 bounds from umin/umax
> or smin/smax by stitching together negative s32 subrange and
> non-negative s32 subrange. That requires upper 32 bits to form a [N, N+1]
> range in u32 domain (taking into account wrap around, so 0xffffffff
> to 0x00000000 is a valid [N, N+1] range in this sense). See code comment
> for concrete examples.
>=20
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

fwiw, an alternative explanation might be arithmetic based.
Suppose:
. there are numbers a, b, c
. 2**31 <=3D b < 2**32
. 0 <=3D c < 2**31
. umin =3D 2**32 * a + b
. umax =3D 2**32 * (a + 1) + c

The number of values in the range represented by [umin; umax] is:
. N =3D umax - umin + 1 =3D 2**32 + c - b + 1
. min(N) =3D 2**32 + 0 - (2**32-1) + 1 =3D 2
. max(N) =3D 2**32 + (2**31 - 1) - 2**31 + 1 =3D 2**32
Hence [(s32)b; (s32)c] form a valid range.

At-least that's how I convinced myself.

> ---
>  kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5082ca1ea5dc..38d21d0e46bd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2369,6 +2369,29 @@ static void __reg32_deduce_bounds(struct bpf_reg_s=
tate *reg)
>  			reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_=
value);
>  		}
>  	}
> +	/* Special case where upper bits form a small sequence of two
> +	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
> +	 * 0x00000000 is also valid), while lower bits form a proper s32 range
> +	 * going from negative numbers to positive numbers. E.g., let's say we
> +	 * have s64 range [-1, 1] ([0xffffffffffffffff, 0x0000000000000001]).
> +	 * Possible s64 values are {-1, 0, 1} ({0xffffffffffffffff,
> +	 * 0x0000000000000000, 0x00000000000001}). Ignoring upper 32 bits,
> +	 * we still get a valid s32 range [-1, 1] ([0xffffffff, 0x00000001]).
> +	 * Note that it doesn't have to be 0xffffffff going to 0x00000000 in
> +	 * upper 32 bits. As a random example, s64 range
> +	 * [0xfffffff0ffffff00; 0xfffffff100000010], forms a valid s32 range
> +	 * [-16, 16] ([0xffffff00; 0x00000010]) in its 32 bit subregister.
> +	 */
> +	if ((u32)(reg->umin_value >> 32) + 1 =3D=3D (u32)(reg->umax_value >> 32=
) &&
> +	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >=3D 0) {
> +		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->umin_v=
alue);
> +		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->umax_v=
alue);
> +	}
> +	if ((u32)(reg->smin_value >> 32) + 1 =3D=3D (u32)(reg->smax_value >> 32=
) &&
> +	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >=3D 0) {
> +		reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s32)reg->smin_v=
alue);
> +		reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s32)reg->smax_v=
alue);
> +	}
>  	/* if u32 range forms a valid s32 range (due to matching sign bit),
>  	 * try to learn from that
>  	 */




