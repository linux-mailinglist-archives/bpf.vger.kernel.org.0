Return-Path: <bpf+bounces-18230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05D81794B
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7027BB20DC5
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8FB5D73F;
	Mon, 18 Dec 2023 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr8kMxHQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328F5BFA2;
	Mon, 18 Dec 2023 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc794df8aaso9136171fa.0;
        Mon, 18 Dec 2023 09:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702922298; x=1703527098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6HN2zwRhmMViQksauP5mSHc2h+svhYEJtdLhAQeySs=;
        b=mr8kMxHQk8aYpNo+pep17UR3QMCHV8J9NdXC00k0NxCoDNKv5sbo0aCAmOemyFGOQe
         n98s5pgHapE6H3uhjzEmvVP0Vy6/pdRxm77EtpmmWq2nh03jwUhJq0kam0Jvee8MMr5E
         BEjZI9EAp1IJmMp1UBT6SzPmbr1wLWh1gDs56GPqdqgeuVT/oQMhvRRYytNh0XC7kdZ9
         8XoksFrKwV0hURLudAPNFnps1i6O4QmpJkGtNL3ZR7DAI1DQcTQVTZ+wU3o94ZZz/1ae
         PnlJzzXfdyEEZkP2wDDqBZ9ibcFLheGroTIzgSLCk4+Pi6Hqglrf4dgS1LSqigx28MAE
         uJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702922298; x=1703527098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6HN2zwRhmMViQksauP5mSHc2h+svhYEJtdLhAQeySs=;
        b=myTPm9+WSpTcMZV0rnZkP8/x5MXc3eug1X8aBVBBg8jOdIzPqYadllQ7c4W8EOiJX7
         F4f7/1kIDWgvwUlcK9DM2hnuo1CrGPfyU5hWHddFEOFO4FlS8FhyIwAsTFIBQKKHQqmt
         jiXAIIQWASOX09qw99sZpMydFgPakeL4VtYc+T3mSIbAXZYbZv++Id68GDweL1CzEr1X
         lnXRD34N+LTYL2Eq1tzYefYb17VOT69WT4Pqq3BuE8gcRZLyooUf9kzC4FR7EqSIeXjX
         akAza270PySlJFILj7wYwZSD3OorKDI1DS6255MlTblnp3TMnX2UrRLQkGyNrPMg//02
         G4wA==
X-Gm-Message-State: AOJu0Yxj1RK+hajgai7W8I5e3yhGYxVyBUGDFwnxpqYA3HSpPIyuBqg0
	jc3kej1z8Rpl9nzZivtCjrgx1wyxufnsgX9JBq8=
X-Google-Smtp-Source: AGHT+IE0jD9e/ZNcL+DBQK5DFPDx5Nyc8KgWO+G6sj5na8nCURt/+6domfaYBsDBb95RIBDLdNOQI55VfnWGfeHM+dM=
X-Received: by 2002:a2e:6a07:0:b0:2cc:540a:2601 with SMTP id
 f7-20020a2e6a07000000b002cc540a2601mr1960152ljc.98.1702922298235; Mon, 18 Dec
 2023 09:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com> <20231217131716.830290-3-menglong8.dong@gmail.com>
In-Reply-To: <20231217131716.830290-3-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 09:58:06 -0800
Message-ID: <CAEf4Bza8UtCTCxe5QgstxexDhU1oz83MMmnT1w5xzV7czF+7zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The edge range checking for the registers is supported by the verifier
> now, so we can activate the extended login in
> tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
> such logic.
>
> Besides, I added some cases to the "crafted_cases" array for this logic.
> These cases are mainly used to test the edge of the src reg and dst reg.
>
> All reg bounds testings has passed in the SLOW_TESTS mode:
>
> $ export SLOW_TESTS=3D1 && ./test_progs -t reg_bounds -j
> Summary: 65/18959832 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
> v3:
> - do some adjustment to the crafted cases that we added
> v2:
> - add some cases to the "crafted_cases"
> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c     | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 0c9abd279e18..c9dc9fe73211 100644
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
> @@ -2101,6 +2096,19 @@ static struct subtest_case crafted_cases[] =3D {
>         {S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}=
},
>         {S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
>         {S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32=
_MIN, (u32)(s32)S32_MIN}},
> +
> +       /* edge overlap testings for BPF_NE, skipped some cases that alre=
ady
> +        * exist above.
> +        */
> +       {U64, U64, {0, U64_MAX}, {U64_MAX, U64_MAX}},
> +       {U64, U64, {0, U64_MAX}, {0, 0}},
> +       {S64, U64, {S64_MIN, 0}, {S64_MIN, S64_MIN}},
> +       {S64, U64, {S64_MIN, 0}, {0, 0}},
> +       {S64, U64, {S64_MIN, S64_MAX}, {S64_MAX, S64_MAX}},
> +       {U32, U32, {0, U32_MAX}, {0, 0}},

missing case where we compare against U32_MAX constant?

> +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {0, 0}},
> +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {(u32)(s32)S32_MIN, (u32)(s32)=
S32_MIN}},
> +       {S32, U32, {(u32)(s32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
>  };
>
>  /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
> --
> 2.39.2
>

