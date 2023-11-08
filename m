Return-Path: <bpf+bounces-14519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AB97E5D1A
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 19:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FC02815C0
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46F358BC;
	Wed,  8 Nov 2023 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV87ORwG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407532C67
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 18:22:09 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688461FF9
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 10:22:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso2768266b.2
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699467727; x=1700072527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UTrz+tYempZCMpWWeip9zpzhWVogHH0erWUyjtHwww=;
        b=MV87ORwGTSR9dRKbSE7ksZV2BH+6xjkwdCUJYW5BM0kuk4JK3n33Xv4WmyOwHmGZB5
         V1/03vR4ql1E3q0+PJsCqcOIc0Xa1axSwS9EuZn3PZDQmUCzCxTyX6EapIYsrNaiKoDZ
         gM55PtX80DnlBu597sDlWPgUb0/+TWJYr7EOqktTsGtfwkFrlj9Or+0sfXps9BhMb/BF
         VKIJ7BhVJycFeiGizcuoQJbCJnRyPU4V5IgE8mRQQb+yENFpWTSPcPp4b55+gefXxYt2
         04i3e+B1xqc6MQ4wtwPEdoAeVATvrZaIZ0D3xxGFJO/ESR3riWsm1osusANcQqUCAoVg
         vQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467727; x=1700072527;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UTrz+tYempZCMpWWeip9zpzhWVogHH0erWUyjtHwww=;
        b=tB9OSyvDw4xuafJDbVRzqt02TrFE4NnMSFX4OidacMqyY/5SOphXLkKkn+ZkVjacpZ
         umh01CHQH5+qV2WL4pRpoVp1/slOCFa27Cltz+AViGQ1eVVjhieEHeLa9iHisC/V4iXS
         J9+2UjtNMItkfQtpCFIgwmU90FDFMDsdQgtdwuR+iRtz72Nr0+HgpPEm0AZlX/vE1Dq1
         emFaVVpP9RbAgnQNEpugpATPNGukAh1miKGqWPBwIG2o2UupNIjtbwWkzh0hdwOu1PQY
         XXgmrDFuUxTTMo1tam+GQEyhwdE8sTBWn4NuWvTMhe2pvgQVoh+kZbAVKOQTlomtiLrV
         1SUw==
X-Gm-Message-State: AOJu0YxZSJrzyWLkugqcN6CX8ja8+js2n4dTJDOBFNCBCZw6qiEYntH+
	O8y6zvEKEhkV8x3SSQyrR6OURaKjNMo=
X-Google-Smtp-Source: AGHT+IGv84yEZeAYqHNmUf8hMv7DRioaBr1eoE6YMtWUUPOveVRb+BCg2B/7eSyOeMB38+NSUmTo0A==
X-Received: by 2002:a17:907:9304:b0:9d2:e2f6:45b2 with SMTP id bu4-20020a170907930400b009d2e2f645b2mr2178787ejc.71.1699467726679;
        Wed, 08 Nov 2023 10:22:06 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709060acf00b0099cb0a7098dsm1408468ejf.19.2023.11.08.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:22:06 -0800 (PST)
Message-ID: <a54dfe9cf85c41508acc7b31a399d7477e667a1d.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 21/23] selftests/bpf: adjust OP_EQ/OP_NE
 handling to use subranges for branch taken
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 08 Nov 2023 20:22:04 +0200
In-Reply-To: <20231027181346.4019398-22-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-22-andrii@kernel.org>
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
> Similar to kernel-side BPF verifier logic enhancements, use 32-bit
> subrange knowledge for is_branch_taken() logic in reg_bounds selftests.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c     | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index ac7354cfe139..330618cc12e7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -750,16 +750,27 @@ static int reg_state_branch_taken_op(enum num_t t, =
struct reg_state *x, struct r
>  		/* OP_EQ and OP_NE are sign-agnostic */
>  		enum num_t tu =3D t_unsigned(t);
>  		enum num_t ts =3D t_signed(t);
> -		int br_u, br_s;
> +		int br_u, br_s, br;
> =20
>  		br_u =3D range_branch_taken_op(tu, x->r[tu], y->r[tu], op);
>  		br_s =3D range_branch_taken_op(ts, x->r[ts], y->r[ts], op);
> =20
>  		if (br_u >=3D 0 && br_s >=3D 0 && br_u !=3D br_s)
>  			ASSERT_FALSE(true, "branch taken inconsistency!\n");
> -		if (br_u >=3D 0)
> -			return br_u;
> -		return br_s;
> +
> +		/* if 64-bit ranges are indecisive, use 32-bit subranges to
> +		 * eliminate always/never taken branches, if possible
> +		 */
> +		if (br_u =3D=3D -1 && (t =3D=3D U64 || t =3D=3D S64)) {
> +			br =3D range_branch_taken_op(U32, x->r[U32], y->r[U32], op);
> +			if (br !=3D -1)
> +				return br;
> +			br =3D range_branch_taken_op(S32, x->r[S32], y->r[S32], op);
> +			if (br !=3D -1)
> +				return br;

I'm not sure that these two checks are consistent with kernel side.
In kernel:
- for BPF_JEQ we can derive "won't happen" from u32/s32 ranges;
- for BPF_JNE we can derive "will happen" from u32/s32 ranges.

But here we seem to accept "will happen" for OP_EQ, which does not
seem right. E.g. it is possible to have inconclusive upper 32 bits and
equal lower 32 bits. What am I missing?

