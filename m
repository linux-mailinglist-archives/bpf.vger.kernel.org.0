Return-Path: <bpf+bounces-60772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E1ADBBD3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364743A3949
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C813215077;
	Mon, 16 Jun 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/FccOR6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B21E9B08;
	Mon, 16 Jun 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108766; cv=none; b=rHUnVBV3Al3g/levqLcxxZiCjh0GooNTKjofMzhwluF21LK3KLLDz22BiPWIZYbvIwyECF1mOyhf+6MezlT48d/X2WxSyG2FmJZ9ykVDEUJFgYs2eJmHOrI/SDQQp1AOZ7MJkMkISEGwdO7xSsIXTbwz7oMzoEIT2HT8sHuew8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108766; c=relaxed/simple;
	bh=iFLcAGKrh/I1GWcYINTWT9oulbvPoW+aMXcQxINx8GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swzrhnNRWBSuCqYXgkarlQki6cQkkcQndaidO09BB7JL0qp3L3qKheRMA+iWUoPzBVAV+UAJsRQ77bwjgyyZQcccYYcapyzbga4zvbSA79HmHbmJnaLowDQU/uC7wu7WstFYUDCMVE0qJLA/Kf7mxIDnXQsaz1e9qUituvwbthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/FccOR6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3904459b3a.2;
        Mon, 16 Jun 2025 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750108764; x=1750713564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt7ZZUFT5+GbfWyskAndCdqkVpTr1SmoNxpD1HrCC38=;
        b=Y/FccOR6fw9qWAED0cgalCB3yzgHGCsSCcF8H+hLy6CuQyDda1MFjZack8AIxwva3A
         zL/l78GP1/y37eoBsrsecRbMedr9hGto9hroeXBiQhUIgGEIVPgJvXk+ayKf7NiWw6aG
         Vz2UMm2v5xAh5+jmhM+pfnPVIJ25EPi7TVFGRNfiSwmAKlVwnNL9C+tLoCOXcV4Inm8Y
         kfokRaI0UyD5v/nIZoRQI5od1kp1vQdr35VZ2CzafOCMCq0PumDy6MtfptvS3lTII/B0
         T3/XAzhGKpRWooGPpiRSAvKRws9v5H1dMQ4iIFtqd0K9f4eoGa8vxNoLqIA3iuIEdg6V
         muKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108764; x=1750713564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt7ZZUFT5+GbfWyskAndCdqkVpTr1SmoNxpD1HrCC38=;
        b=upsYJ/w+S72oN9enPByz+f6Cezhd0v27Frb/SXdbS6y5znFmLWtZM/xORrvcFHwMhk
         RaKRb6geLb/9Y851gr/BMn/mb9BFH8xjn9tkotmiERNC4Bhi6AtEsoCu6OCtC5e7d7Qq
         RP45uQgc0+CTI3HrbwUJPfpE8qOasVTA7mE2FocYBudZlRfP3pd3czJZXPhwFFR4TP6i
         4ZqSzykpP4zJjexpRw13dmMcglE0BvJatiMKgi/1Flbkvx3nyjkop1+KLn4zQgX9e6F1
         cmfLwrbnzQt5HZKMQ+cF3ikq10oWWA8zWbWIL5wk/TVaO64vSYQEBNFRmGYqMh+0J9LT
         f0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmIPj7BqUWMK/6xTOthfiFHVRL0J67EaDDAHqdxpudCjoWnI92pF4bQxkxY1nQEG8FsZI=@vger.kernel.org, AJvYcCX+aAp4XhIPqvndcaQbjh1VuGofNowCrnQXhnV4rCgoe6nBHeWw0AKcp2/4JWwHjfGdaI1LRAWbA9IOd8En@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgUdFikBxmq7Xz3xbLsuawsMk+iRMKjHoBVhlwyLAYXMoGe2F
	VdHZ6X4IJTjcdpBo3f2XvJqmrfgmKO/gT90vD4279Kx6KxXmIOZEfQCUThVvOEKvDlp9e6BnfNC
	ki4neZx7LAE717lYZV7I+U7v3W9IXwrtDRvrBoDQ=
X-Gm-Gg: ASbGncupHW4hR6rF9/jS9OuovlchCOpdytKX4lPHfC/luQKfwmqYru6GNMN/QkmbMpY
	M6OrKl2lrUlMu+gH+Uej6DRLuPa1hyFwtiCLIWtlRDRWWsQFbmH8a18fd3+AP+oTgAi4SNophp0
	88AbIA4xPB7W6ohPLnF8qAL83c6un5sgCYEFVrTaFErVwobTnbLElnZqc54Us=
X-Google-Smtp-Source: AGHT+IGzWtHKkiilBheuNMzeC3zGOndTaR/LXWbJQdPBXXkA7lFZ+UY9kOHNJS1iAR0MdwpB0qTRKquzQdI5JlA2IDw=
X-Received: by 2002:a05:6a00:3c8f:b0:746:2c7f:b271 with SMTP id
 d2e1a72fcca58-7489ce0d374mr12913333b3a.9.1750108764065; Mon, 16 Jun 2025
 14:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616152719.28917-1-chenyuan_fl@163.com>
In-Reply-To: <20250616152719.28917-1-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Jun 2025 14:19:12 -0700
X-Gm-Features: AX0GCFuYaBTGQrYuUYhvoYlreKcyca58wqgz2SdhZaTdPf4R-kZWlA6L_cDrCxk
Message-ID: <CAEf4BzbO=E0UTN0OzV9i7G_NsVOkCLJFdOFhRqaUBgTVyG0p3g@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Fix JSON writer resource leak in version command
To: Yuan Chen <chenyuan_fl@163.com>
Cc: qmo@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:30=E2=80=AFAM Yuan Chen <chenyuan_fl@163.com> wro=
te:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> When using `bpftool --version -j/-p`, the JSON writer object
> created in do_version() was not properly destroyed after use.
> This caused a memory leak each time the version command was
> executed with JSON output.
>
> Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible c=
ommands)
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> ---
>  tools/bpf/bpftool/main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index cd5963cb6058..33c68eccd2c3 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -533,8 +533,12 @@ int main(int argc, char **argv)
>         if (argc < 0)
>                 usage();
>
> -       if (version_requested)
> -               return do_version(argc, argv);
> +       if (version_requested) {
> +               ret =3D do_version(argc, argv);
> +               if (json_output)
> +                       jsonw_destroy(&json_wtr);
> +               return ret;
> +       }

there is also btf__free(base_btf), so instead of jsonw_destroy copy,
let's maybe just do

if (version_requested)
    ret =3D do_version(...);
else
    ret =3D cmd_select(...);

jsonw_destroy, btf__free...

return ret;

pw-bot: cr


>
>         ret =3D cmd_select(commands, argc, argv, do_help);
>
> --
> 2.44.0
>
>

