Return-Path: <bpf+bounces-65219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50BCB1DBFE
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833E41AA3070
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CC273D6E;
	Thu,  7 Aug 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiztritw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CF1E832E;
	Thu,  7 Aug 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585460; cv=none; b=gDZMYSxSZbtqa+2AyLYMDIzR0sbumSaKL7Scw0UGBwobl07FVzD82mbsW6efuoDqT7TfsCmZMenivsc3DMLX0UN1kodKVk1ffDoL+Jj4wn1EASTCUz4gX8YR+/6K6BSuIqeVl90fkuqO1txbRMxqeoyBx4VbPuiTNcdIzEiRm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585460; c=relaxed/simple;
	bh=rvHzHNNeX42Ajw+oPnvddqWVsP011jQpeQ76XsjgJjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=es+sHrMvbxLFy2skIIlJkKzw9yCnbcpSQSCVUtZPicIPxDNiz/qBTGKbpu0/zHZxlrHHuwDdn8riXykkXORBP7Z7BHOZcFGk0M4b84KEc24Iupb1j1crpOjbIPEMmoM16aXHGHwwJ63CwazmkwCWO1iEF5PLED+fOby5Dffp+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiztritw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b783ea5014so645549f8f.0;
        Thu, 07 Aug 2025 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754585456; x=1755190256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI+CDnO3S/HRsnMbehWHSmPi1UCDpaAWXx0mQumQV1k=;
        b=Aiztritw9v4+tpsmzFwFTRRbi+GnbOMWKtnXixfTZ22lPVNg+YepO4A2dEk2QpWt9n
         fOI9xp3YEe7NRhFcNzYKVSDiH5l0bD73RKNFUbaLtdggh3mxN67ulo7bdMKgc2rvLXD0
         rm8iWSgKF7L8Pwut4v+rPRE3S21RFVlrUrIhPw8v5TqDrHQ+EqlP3rmAyBnnUrgITfn3
         j3axnt035ISz3f+unlVu5o8iK25/f+X1sOSiQtWAMkwnpvv93R1H2+oqhv5N5fT6VR7p
         20sypjSH5gY4jEY7PgrOkTgzK4N4J4OsUbJlw5ZcGrjlUyd/doXf0acCVhwSxxx5YAis
         9ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754585456; x=1755190256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI+CDnO3S/HRsnMbehWHSmPi1UCDpaAWXx0mQumQV1k=;
        b=mHgAO6ApiC7XeL7OF9kIV80z7cZ38YZ0cEdjtEINGO3nIfDEvUZ98Y+pJWjYFN9gBw
         vF8NOo8ENHQ5wt6yqDrltX8U+cniscKOkMBN9sGU5MWlWvD+319Pz+KlaJZK5T/WjjW0
         oMi8fH5qMdTZvW1NloCmNhiBNOF/H8zOhUqN9Bi/NZ8ncF7mOr/1ct2MQpytIKZLJVJq
         p2DIgUw2bCH1TNcsp1jxW7/Y5jQbxJS4uS+PelSp5ORrj3MBdNuD7PMVsTR0Qt9JKtXB
         ImSo8BdkTFR9cHZcmE8pvwWWz8IWB8I2GZHK1e9/+zHr2Ez6IsMCJAQlQ6JeBKPV96gi
         A/2g==
X-Forwarded-Encrypted: i=1; AJvYcCUP9iQ8CV/oWvyBjFMZM5pj+XLq3Sjz59+sXpHeTPkJ5qrZo4S5G73lDqR9YaMbUOvFn6o=@vger.kernel.org, AJvYcCWCoBvKmb4Re2XQqVo30Cy6kvRmzq3AXdYtepIJqGeNJ8iVUFPqx38HFgUjJrWMlk8p73GiOzXF2oamwZyU@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQDYrZmDaN1StPTzVeQo16PWwlfl1oqOXy2hbdZICmycbhguv
	JML1RcCM60Z8u5ro7+UJlcRgGRV9xUoGxV4SG9Q2eS/c2t3VVysqxsy+1LZLWXySWOhKCoXltKZ
	wJkM/d/zlN3xLQ8Vn4SdpawwhlrjPpqs=
X-Gm-Gg: ASbGncs0xwcLbc4HCFJ/ktATyn20MChz0yqhPbEFE4U2xcKUA0X12pdjE+g0qxfTYnQ
	+KXqhbyYVm/l9u9uzHVUIuO0T+ZKpJe83aiEAEBVz4LjSx07ev24DLxZT+ddchIWLql28jGC9ay
	Zr+Tl4xA1iHUwDg3IXtaROcJ2nBdCjComWIZAcP/kh1jPWIH4NfnHz3frwFgFu6fAq1Xdh4YANE
	T09iHpV5hT1u5CARX4uIQc=
X-Google-Smtp-Source: AGHT+IGq3jfQ2I7+YTZKWmezts8ksMJtEUFLNuu7yd4Jw8iw8OJixukAUDSMkhzOoJ9jzYlKEOSlPd43kV56ZahM0w8=
X-Received: by 2002:a05:6000:2003:b0:3b7:820b:a830 with SMTP id
 ffacd0b85a97d-3b8f48f66aemr6042295f8f.25.1754585455883; Thu, 07 Aug 2025
 09:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805115513.4018532-1-kafai.wan@linux.dev>
In-Reply-To: <20250805115513.4018532-1-kafai.wan@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 09:50:42 -0700
X-Gm-Features: Ac12FXwDvr7D5yeAtsPz6ePp67cc_tchJz2vkfuTXMoJDP0gbWSavjnd2i11164
Message-ID: <CAADnVQLecBEmQzxOzUwv_2mO9BDrKSp1xiC4WY8-gL2w4OaxaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Allow fall back to interpreter for
 programs with stack size <= 512
To: KaFai Wan <kafai.wan@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiayuan Chen <mrpre@163.com>, KaFai Wan <mannkafai@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:55=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wrot=
e:
>
> OpenWRT users reported regression on ARMv6 devices after updating to late=
st
> HEAD, where tcpdump filter:
>
> tcpdump -i mon1 \
> "not wlan addr3 3c37121a2b3c and not wlan addr2 184ecbca2a3a \
> and not wlan addr2 14130b4d3f47 and not wlan addr2 f0f61cf440b7 \
> and not wlan addr3 a84b4dedf471 and not wlan addr3 d022be17e1d7 \
> and not wlan addr3 5c497967208b and not wlan addr2 706655784d5b"
>
> fails with warning: "Kernel filter failed: No error information"
> when using config:
>  # CONFIG_BPF_JIT_ALWAYS_ON is not set
>  CONFIG_BPF_JIT_DEFAULT_ON=3Dy
>
> The issue arises because commits:
> 1. "bpf: Fix array bounds error with may_goto" changed default runtime to
>    __bpf_prog_ret0_warn when jit_requested =3D 1
> 2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error when
>    jit_requested =3D 1 but jit fails
>
> This change restores interpreter fallback capability for BPF programs wit=
h
> stack size <=3D 512 bytes when jit fails.
>
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Closes: https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@=
nbd.name/
> Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")

This commit looks fine.

> Fixes: 86bc9c742426 ("bpf: Avoid __bpf_prog_ret0_warn when jit fails")

But this one is indeed problematic.
But before we revert, please provide a selftest that is causing
valid classic bpf prog to fail JITing on arm,
because it has to be fixed as well.

Sounds like OpenWRT was suffering performance loss due to the interpreter.

> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
>  kernel/bpf/core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 5d1650af899d..2d86bd4b0b97 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2366,8 +2366,8 @@ static unsigned int __bpf_prog_ret0_warn(const void=
 *ctx,
>                                          const struct bpf_insn *insn)
>  {
>         /* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
> -        * is not working properly, or interpreter is being used when
> -        * prog->jit_requested is not 0, so warn about it!
> +        * or may_goto may cause stack size > 512 is not working properly=
,
> +        * so warn about it!

We shouldn't have touched this comment. Let's not do it again.

>          */
>         WARN_ON_ONCE(1);
>         return 0;
> @@ -2478,10 +2478,10 @@ static void bpf_prog_select_func(struct bpf_prog =
*fp)
>          * But for non-JITed programs, we don't need bpf_func, so no boun=
ds
>          * check needed.
>          */
> -       if (!fp->jit_requested &&
> -           !WARN_ON_ONCE(idx >=3D ARRAY_SIZE(interpreters))) {
> +       if (idx < ARRAY_SIZE(interpreters)) {
>                 fp->bpf_func =3D interpreters[idx];

this is fine.

>         } else {
> +               WARN_ON_ONCE(!fp->jit_requested);

drop it. Let's not give syzbot more opportunities
to spam us again with fault injection -like corner cases.

>                 fp->bpf_func =3D __bpf_prog_ret0_warn;
>         }
>  #else
> @@ -2505,7 +2505,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf=
_prog *fp, int *err)
>         /* In case of BPF to BPF calls, verifier did all the prep
>          * work with regards to JITing, etc.
>          */
> -       bool jit_needed =3D fp->jit_requested;
> +       bool jit_needed =3D false;

ok

>
>         if (fp->bpf_func)
>                 goto finalize;
> @@ -2515,6 +2515,8 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf=
_prog *fp, int *err)
>                 jit_needed =3D true;
>
>         bpf_prog_select_func(fp);
> +       if (fp->bpf_func =3D=3D __bpf_prog_ret0_warn)
> +               jit_needed =3D true;

This is too hacky.
Change bpf_prog_select_func() to return bool and
rename it bpf_prog_select_func/bpf_prog_select_interpreter()

true on success, false on when interpreter is impossible.

And target bpf tree.

--
pw-bot: cr

>
>         /* eBPF JITs can rewrite the program in case constant
>          * blinding is active. However, in case of error during
> --
> 2.43.0
>

