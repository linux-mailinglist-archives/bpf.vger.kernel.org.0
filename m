Return-Path: <bpf+bounces-17896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB58813E38
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A1F1C21F1B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2616C6EF;
	Thu, 14 Dec 2023 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIsT7k7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E4A6C6DC;
	Thu, 14 Dec 2023 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55225ed7ef9so64992a12.3;
        Thu, 14 Dec 2023 15:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702596270; x=1703201070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH7KARAejqAmd4NZA5cpMQIeqpV2b6Ne0T86GLGIoxM=;
        b=eIsT7k7xGRINeUlbrrc8PwfZOM0QCTrxDlsp+3+GYgkt4Qgj421gTDu6J1/WKBb4fa
         X0r40dNS0fi7WGx53VWQQYzsL0squo0X69M8oY0BaLHBJ/FttX7UKBeXGgGDgmogbSbZ
         qW1LXGBsySw/naY7w7WIYP4TUn31A+FbT4I1w+Hllht9ftzlEpJyECFmTPC2VrP7tJwe
         PH/rnGW4izhkVgu74eyllIb9bx7bYkz6RxbSQysd6OpfZ2dV7kDNMWK1coRCrviyR/ga
         c5JQzD6SwIpwiilO3Vd9qhuz4s0eW8CSHiGjWEtpBQeO3Ppnm7Ngc14gPwyc/IRcn4Lc
         bOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702596270; x=1703201070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH7KARAejqAmd4NZA5cpMQIeqpV2b6Ne0T86GLGIoxM=;
        b=IVgEuH2IY7wF4o7yz+hZViGFxrS/mbU0sUrm+NI96sPAgpt34OdBtJdMmeDZIbkQd9
         bL7LIKlO++l0CTMP5Ja4la+eR38z6QqnmAWSEJTBdYkKhP82cgbbn3ggE3ZNpfJ5uZqg
         BT38YC8bX+PyT/fRWDWXUhVdoGPfiUDJBgIFmw3KcVNDijOM3dvAFUqWBO4csMSEjooj
         FB0+K/nVPEbONpu0uzyl/POuZ1Ha+4gfxTChNNvlzO7h5YN+ZYyItNjVRlPew6rEbCxo
         /ABCipBTZvjsHTSiG88udYzjC0qcMcVTVjeode7b/RsRLQ/y+Zg35M4HuDP3AFbQFIZO
         I3iA==
X-Gm-Message-State: AOJu0Yy4NoiGi+IHVn2yXi6rXG26vK2d/uKHUJ/+ATyLBsDp8c4Tv0Nt
	hp5jdBflVkszggPRL9p9tOWAv1cn47oeBT52idk=
X-Google-Smtp-Source: AGHT+IHsJSgir9UVHsZ5FV04hryiHKZZOz15ybak56dJK8+jyatlOJqVUTMG0NoOhteyY7LJhIGDN/3SDJu6dhwBdB4=
X-Received: by 2002:a50:d61b:0:b0:552:17c8:fa4f with SMTP id
 x27-20020a50d61b000000b0055217c8fa4fmr1492622edi.72.1702596269898; Thu, 14
 Dec 2023 15:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214062434.3565630-1-menglong8.dong@gmail.com> <20231214062434.3565630-3-menglong8.dong@gmail.com>
In-Reply-To: <20231214062434.3565630-3-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 15:24:17 -0800
Message-ID: <CAEf4BzZdLvwbh_-GNoqD=ghgK+GxgXwUBKP6yQQH=vWMP4Csqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:28=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> The edge range checking for the registers is supported by the verifier
> now, so we can activate the extended login in
> tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
> such logic.
>
> Besides, I added some cases to the "crafted_cases" array for this logic.
> These cases are mainly used to test the edge of the src reg and dst reg.
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
> v2:
> - add some cases to the "crafted_cases"
> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c     | 25 ++++++++++++++-----
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 0c9abd279e18..53b8711cfd2d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range x,=
 struct range y,
>                 *newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b)=
);
>                 break;
>         case OP_NE:
> -               /* generic case, can't derive more information */
> -               *newx =3D range(t, x.a, x.b);
> -               *newy =3D range(t, y.a, y.b);
> -               break;
> -
> -               /* below extended logic is not supported by verifier just=
 yet */
> +               /* below logic is supported by the verifier now */
>                 if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
>                         /* X is a constant matching left side of Y */
>                         *newx =3D range(t, x.a, x.b);
> @@ -2101,6 +2096,24 @@ static struct subtest_case crafted_cases[] =3D {
>         {S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}=
},
>         {S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
>         {S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32=
_MIN, (u32)(s32)S32_MIN}},
> +
> +       /* edge overlap testings for BPF_NE */
> +       {U64, U64, {1, 1}, {1, 0x80000000}},
> +       {U64, S64, {1, 1}, {1, 0x80000000}},
> +       {U64, U32, {1, 1}, {1, 0x80000000}},
> +       {U64, S32, {1, 1}, {1, 0x80000000}},
> +       {U64, U64, {0x80000000, 0x80000000}, {1, 0x80000000}},
> +       {U64, S64, {0x80000000, 0x80000000}, {1, 0x80000000}},
> +       {U64, U32, {0x80000000, 0x80000000}, {1, 0x80000000}},
> +       {U64, S32, {0x80000000, 0x80000000}, {1, 0x80000000}},
> +       {U64, U64, {1, 0x80000000}, {1, 1}},
> +       {U64, S64, {1, 0x80000000}, {1, 1}},
> +       {U64, U32, {1, 0x80000000}, {1, 1}},
> +       {U64, S32, {1, 0x80000000}, {1, 1}},
> +       {U64, U64, {1, 0x80000000}, {0x80000000, 0x80000000}},
> +       {U64, S64, {1, 0x80000000}, {0x80000000, 0x80000000}},
> +       {U64, U32, {1, 0x80000000}, {0x80000000, 0x80000000}},
> +       {U64, S32, {1, 0x80000000}, {0x80000000, 0x80000000}},

JNE and JEQ are sign-agnostic, so there is no need to use both U64 and
S64 variants for comparison. As for the choice of values. Wouldn't it
make sense to use really a boundary conditions:

0, 0xffffffffffffffff, and 0x80000000000000 for 64-bit and
0, 0xffffffff, and 0x80000000 for 32-bit? For this one use U32 as the init =
type?

BTW, all these cases should be tested with auto-generated tests, so
please make sure to run

sudo SLOW_TESTS=3D1 ./test_progs -t reg_bounds_gen -j

locally. It will take a bit of time, but should help to get confidence
in that everything is working and nothing regressed.

>  };
>
>  /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
> --
> 2.39.2
>

