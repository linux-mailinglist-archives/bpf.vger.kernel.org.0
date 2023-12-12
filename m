Return-Path: <bpf+bounces-17622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3C80FB78
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664FF1F218F8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC965A9B;
	Tue, 12 Dec 2023 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8rsWgGH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E79A0;
	Tue, 12 Dec 2023 15:37:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c41df5577so32019005e9.0;
        Tue, 12 Dec 2023 15:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702424277; x=1703029077; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JDRHHu41MUvYy9KEdDWgKfdTcRdh7spHhW6VGjs11Mo=;
        b=G8rsWgGH71vbuO0EB9y7r7W3kg/XqvfPf6ffYgVpDfBOI/pOVOLE1WxhSEyuRRQFE/
         gogcFHrevGF+Gu7FSHzLcqIp42tyq7kwV4+ZL+ew2OFgt3de6k7H1H3ANT3ogdb+laqg
         RYYvmY28TvXRSUHyTkQQG/lHDb7AjoGqKcC2OXzJ/cjWxHqHK5AB3KSg6eNWKKYnbWJT
         6hvvf8r0uP9/m+7lXvGV7GoKWvWGGqLQwtWK320S6hSRRt16yvzSjOQZ26dUF2cRPmQj
         c2VQ9KnKne2QX4Y3lbdmNZ2BAsxoF2d9RDlJ3wmOlb67ahoKe3orFdRMaU8oTzLbXJZ7
         ICkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702424277; x=1703029077;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDRHHu41MUvYy9KEdDWgKfdTcRdh7spHhW6VGjs11Mo=;
        b=Z8hhhH+BbpAyUtZ0hb73Q62E7vgMKIEBWtTFawS8cgP+cNkHqQraG2vXJhhxtifEef
         jPdSpKkyr1vw2KK3F93vZeGUTybP3Cz3cDcp+oQ7zuqsAkff7GO8+aCZzcPhJ5Ma3PLe
         njjLeG1F5WKc4zITcswYWOG9wC+v8QH3wa2hc1EKg0U0Z1WZdYPMkuryfUFRU3gVcx76
         ti0k3r2zAtcAkNvig9j6PexZVd3spGc35bIunfCZeCWMwa9Q81HW7llk2DCtKeQqsbxw
         8SaMcxGJB+DgM84vW8s3ecp+/KoFEhltgPczPo7Gs/BPDZEMDaWSTeWuRk8KCVfOvdNJ
         phmw==
X-Gm-Message-State: AOJu0YwdHdESMWz83XQkCK7fPdXWNVFxl2laKibNuKKBpOftzGGutOj3
	WZN6ZNn1ONRpnUTH3zXT23k=
X-Google-Smtp-Source: AGHT+IEyCBBiSFw4UjL5YO9pJqkRzY4Ck6yvZL6gY29TnAwnQL/bblhhtoKTb3h3AIaOiBjMrnjJJQ==
X-Received: by 2002:a05:600c:54cf:b0:40c:32ee:3837 with SMTP id iw15-20020a05600c54cf00b0040c32ee3837mr1849173wmb.173.1702424277130;
        Tue, 12 Dec 2023 15:37:57 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0040c490db950sm7912788wmq.47.2023.12.12.15.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:37:56 -0800 (PST)
Message-ID: <8a9d03eb74918123615cc3579cefc484566cad5d.camel@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: activate the OP_NE login
 in range_cond()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, andrii@kernel.org, 
	yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 13 Dec 2023 01:37:55 +0200
In-Reply-To: <20231212131031.3088661-3-menglong8.dong@gmail.com>
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
	 <20231212131031.3088661-3-menglong8.dong@gmail.com>
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

On Tue, 2023-12-12 at 21:10 +0800, Menglong Dong wrote:
> The edge range checking for the registers is supported by the verifier
> now, so we can activate the extended login in
> tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
> such logic.
>=20
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 0c9abd279e18..49d8d4bafe99 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range x,=
 struct range y,
>  		*newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b));
>  		break;
>  	case OP_NE:
> -		/* generic case, can't derive more information */
> -		*newx =3D range(t, x.a, x.b);
> -		*newy =3D range(t, y.a, y.b);
> -		break;
> -
> -		/* below extended logic is not supported by verifier just yet */
> +		/* below logic is supported by the verifier now */
>  		if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
>  			/* X is a constant matching left side of Y */
>  			*newx =3D range(t, x.a, x.b);

I think that some crafted tests have to be added.
Note that reg_bounds only runs a subset of tests during CI
(controlled by variable SLOW_TESTS).
By default only randomized and crafted tests are run.
It appears to me that probability of randomly generating specific
ranges explored by this series is quite low.

