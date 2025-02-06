Return-Path: <bpf+bounces-50570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A11A29DC4
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFF73A7689
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519641373;
	Thu,  6 Feb 2025 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKY+xhny"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A562F2F
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800566; cv=none; b=ZzpZ0+3KOXREqwIIP/qzX2RnQtjpHWmRUQCVAG+PDsnbUAJd9IiT0kMo0i/L8/ndvO2Jj3Uva16gCdR46RpFbueIEe0KMLqT9ZkEIHEpeB9ZDCYGDHSLwfI4QeYSYGokdPJ3+umm7+oshGGIuXJreoKa5CxqC79gct4IJDxgC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800566; c=relaxed/simple;
	bh=yFDfN6cKIGhAMXgcTk1CImuBaqSpYvM97tKCB5nVXcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFELuPMNjfo5pLBMoF8Xhf6DrqwtBtaGBOjIX/nhwRzXlpD++3PA67uPOHE4Hp3keKFJuUrTvB/YA8ngr8SkyS/CuQp18+F+dyuBMC/kVlLOCjB4MPuzSB5eUHjwck2mWZv9n3ZEJLqFdXRhaG5TMICLcEvLhlT1LqqXGSYrcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKY+xhny; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so384005a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738800564; x=1739405364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pey7XR2f8EzAYbD5hXq2a8tt4T7Epr9Rked2dpHvTrQ=;
        b=TKY+xhnymXgghtz8lQc58hozfSd25VZDG91TwOsFpqahllno7l1l5xhsacqIGUg3Wo
         /Sv7DRzMSiev7udgilF191EfRA70rO2kYehSxcT04JlRAcZKlCXWc0L9L1T5UH+avy60
         SVpW8kJVF5dzD0tyzqOJxfS5qnzAoKcp2hI65RuoATZuIrXfQ3Cnj914oFdizW0qOde3
         DoYf6iNZpgJrhxHn8v4+llUbmuNtuOsm76lQ+BKh8bdYgXcN7JZaLI4N0XW36vAwUNg6
         WK4G9jKot/FT14dY0hTAEomlkA8pZHLrDimrVB4iJ5fiTPrNLHFkgJ+Ny6T8FuO2p1y0
         CzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800564; x=1739405364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pey7XR2f8EzAYbD5hXq2a8tt4T7Epr9Rked2dpHvTrQ=;
        b=r8ck9TOHtVLAwZEFT1WHnHar7UMH0SnWvNUqSuR5liqZ0UGiMy/YX+a3zdcpxCnMOE
         GiYK8X0NVlh0sGB6dageonyHfrai3Oy5YF1o/aIo2G3Gzn3tQPBmrqQF7nE4V5WAMIwc
         zCF00wxl0gRbD/nMquJNe7FEcig+tXuFGIaev0v6nxakUbyQUHFBV78CvqZrl/6BLsPk
         /zfoeyZ/waRD18rqLtkpDjoepOrammRKommv4tyYaW/aTosomyCNT3cSWP+ZXJ2xZxjS
         OCKoUcy0/XMWJ8JPcwz6WDHEbPJeyMCi0vQzvvfGeEJJ2SLk7OakWt54It3/hC6uCbN2
         Fjgw==
X-Gm-Message-State: AOJu0YxCoU+liCjUrhE8+eu8HCINK2DwF1RALxhymFX5YR9Ln3T2mkhk
	BucHT+8mYn/AIrDfJ3N2kAsdJmqyRxZWnYaSP7vxqZMlFBprEJuut2d2w5xdF7msS93Q2TD9zO1
	Na4lp57KeCCK5TmtA4jrDGFEwAfo=
X-Gm-Gg: ASbGnctzzoWtDknrMCVKyTX+ymawxDGnZKf+dtogEPuGkgg9zqGY+OaXAaJZxNYFYHR
	twcVInyhKuIif3QpHe0xFLoPX64mp1hrtzPb2mx4h/ZkGleSJN+RTR5w4MtVh+MpN27HKiMuNHS
	kU9bL3y4qw2saN
X-Google-Smtp-Source: AGHT+IErWPk/TR9c5d57xIgMO+Qu4+TThtEHw214+DTKQaYDP7z/cvB9QfKYsWBfBO2ZkiPthPRoXKZrqMySrpOkFzo=
X-Received: by 2002:a17:90b:52d0:b0:2ee:a76a:820 with SMTP id
 98e67ed59e1d1-2f9e079613amr8822922a91.18.1738800564535; Wed, 05 Feb 2025
 16:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-2-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 16:09:09 -0800
X-Gm-Features: AWEUYZm0wvpKi4iguu7XH3Cw0SQGhv5rkEAWVnT1H1fM1pBBEm5nbD2tQLL_Xos
Message-ID: <CAEf4BzaWjg50fXo=dC2sDpKfkdY-3A_DmSjwjJufU2yg=pw3cQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch introduces global percpu data, inspired by commit
> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
> definition of global percpu variables in BPF, similar to the
> DEFINE_PER_CPU() macro in the kernel[0].
>
> For example, in BPF, it is able to define a global percpu variable like
> this:
>
> int percpu_data SEC(".percpu");
>
> With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
> BPF code for handling LBRs. The code can be updated from
>
> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs"=
);
>
> to
>
> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".percpu.lbrs")=
;
>
> This eliminates the need to retrieve the CPU ID using the
> bpf_get_smp_processor_id() helper.
>
> Additionally, by reusing global percpu data map, sharing information
> between tail callers and callees or freplace callers and callees becomes
> simpler compared to reusing percpu_array maps.
>
> Links:
> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe=
90be28c5a3/include/linux/percpu-defs.h#L114
> [1] https://github.com/anakryiko/retsnoop
> [2] https://github.com/Asphaltt/bpflbr
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/arraymap.c | 39 ++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5d..9d99497c2b94c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map,=
 int off, int size, u64 *val,
>         u64 addr;
>         int err;
>
> +       if (map->map_type !=3D BPF_MAP_TYPE_ARRAY)
> +               return -EINVAL;
>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>         if (err)
>                 return err;
> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>                         /* if map is read-only, track its contents as sca=
lars */
>                         if (tnum_is_const(reg->var_off) &&
>                             bpf_map_is_rdonly(map) &&
> +                           map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY =
&&

shouldn't this rather be a safer `map->map_type =3D=3D BPF_MAP_TYPE_ARRAY` =
check?

>                             map->ops->map_direct_value_addr) {
>                                 int map_off =3D off + reg->var_off.value;
>                                 u64 val =3D 0;

[...]

