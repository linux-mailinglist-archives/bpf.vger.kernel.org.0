Return-Path: <bpf+bounces-18135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C64E816193
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3AC282E44
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3247F46;
	Sun, 17 Dec 2023 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXE7JMB/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15847A51;
	Sun, 17 Dec 2023 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3365b5d6f0eso1096846f8f.3;
        Sun, 17 Dec 2023 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702837219; x=1703442019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rvNRlKQCII+W9/za8llc8bUhZndn3boPniTO/N3JSc=;
        b=KXE7JMB/NVK9RkqzlDSiqwXLaTCs95K5dAB645Wf6ly2FRRtkYIkS2OCFhmLoCZ5+B
         c19u+9ugykNY1t3Zo6J7BkNpyFBUFGjQIsI7VUMftr/6/Wlt7DY264hRJuP3z9MvL6Fj
         rgTpM3lix7hHljEJT9mPn7TnWQLm6LibzWQN93gwgkiRFuUOiRWNHNaRS0ndeBzuFgft
         9BgiVm0rqwUEN43Z6itbb9GUVQ6Fu9121pxJDddf8cjkt77tNJpeER39jRFksINsRKHW
         WSksoX5B9SDpDQgWaEJL3eGDjMdhkLu/jPGJvWGmFGdkl5W2IfFingpjr1Yzz80c0Qcs
         /nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702837219; x=1703442019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rvNRlKQCII+W9/za8llc8bUhZndn3boPniTO/N3JSc=;
        b=GT47TyxMIxOvhcxW5Fn8VL+KkamznRjwe4/FI5iRCkJQmk8PwbB7yuwuOqDSGfy/yc
         9OYe/8zx1yM4eXw3NSwE5Sr+IKajNBRanqHvPsHO0qe9as+P12wG2p4sanTg5M7RAlh6
         Ta4KVfRbO3MZVXHGqeJWgJgld9fcQCYymcItQOhpXWbs8VOqIrE73R5j6dLULbTUJG0S
         3PwuOzZr72aUiMd75sk0TJZwiAA/ZzMhn4AGUEDJIvgjApxC1vMGTC/Vn5fDjG5livff
         v0fhL69Yh4BMMw91Ed4TXRuDiCbxD/TEdBuV1BoPTdQiLpRr3bsFZMQodlZct/FUXtjL
         TBAg==
X-Gm-Message-State: AOJu0YxBaoWyX9SRzmoJeYZMevQHqinmliuc4L3gw4GPJLDpXKQyMWjm
	hkoWPSfTKhIxGDGcRWooVIOUjMSoRp2Ni40I2jw=
X-Google-Smtp-Source: AGHT+IGx+3iTTTrHonTIpnEoNO+lh4BjRfCi38pYNyOVhmHl4+25bUkJSJ7UQMrgDLFvhtMGbCMnbdXkJo9+yFFQIGQ=
X-Received: by 2002:a05:6000:4e:b0:336:6555:442e with SMTP id
 k14-20020a056000004e00b003366555442emr657643wrx.35.1702837219312; Sun, 17 Dec
 2023 10:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com> <20231217131716.830290-3-menglong8.dong@gmail.com>
In-Reply-To: <20231217131716.830290-3-menglong8.dong@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 Dec 2023 10:20:08 -0800
Message-ID: <CAADnVQJ6yVJzzAnHT9dWcQ+-0czcT9qf6Qm_b_tmYsBs3UVUEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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
> +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {0, 0}},
> +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {(u32)(s32)S32_MIN, (u32)(s32)=
S32_MIN}},
> +       {S32, U32, {(u32)(s32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},

I think you're copying the style of the casts from few lines above,
but (s32)S32_MIN is unnecessary. S32_MIN includes the cast already.
Please remove and fix the above lines too.

