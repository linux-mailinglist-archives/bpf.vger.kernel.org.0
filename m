Return-Path: <bpf+bounces-75258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA63C7BC60
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA52A4E0F48
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 21:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69993064B9;
	Fri, 21 Nov 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N96HfCcE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9F2D780C
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761252; cv=none; b=acAPhzFcZGvytb4HmhflwAf3hIfIQ/MHeW65HpgpfvLbX7zP/LwPKLTG8jH+xspDgxfTSY79s2eSSjEw+67l6lxp1i1irKOCIZdxJVKCMGvAU+908I+IHAWqHcF7/TUi2ihNfB9QF0nmmo9fNsun1ppW66R0HbnsqpRs42zraao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761252; c=relaxed/simple;
	bh=FRZ50aYUtcrgGU6T19iGqtHp4MvFQNOJJrYNa3+byPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXbczepQAW1If3/jJCw18atv6UmWVwPECsc7Grbjn6rPdx1evauonKv+10TQYTW/Yxe26lDn9nplRyPZC75v6H7ClZDK+XiqIrfym+CW1umDVhiUfrfXxD4tOdxn7LZcpdUVNvwmrIegn1MUJfuFdKaxBRKcWx2b9NK0utv2adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N96HfCcE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso1550694f8f.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763761248; x=1764366048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STfVZTvJ5u/1DSHeWAxiKxp8wq8NwPWQjK8gQ1lGFGQ=;
        b=N96HfCcEcgO5QjIyqMQUjg2k0xeE+XNJltSsta5oAvjz2E1ippNjyqV3LUYQtjPYzK
         zLcgK5S1YhjYXSrMp01kxBgkJZdkkaYA4rof54Ma2dBjrzM4+qx5tOH8Yu+WHDKa0GJo
         9cBWUMH17EkqZVsrxr3u2wFFTzqOocz/W6qbCA3SPryQXtaZfm4aDF1Ngi9sSWTFwNZ2
         mArPkEfUH860ai3mWjK7/kw5JeH0xJ9rXt3ihqsfNsp8VU60/1fM46XVOnSlpcCGe36C
         zQsFLKB6vwM2EgtNF1P9zY3E0VfIoHznHT3gcc52eykOZlxJ/XtLN2B+8s844JkkVMvt
         ww2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763761248; x=1764366048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=STfVZTvJ5u/1DSHeWAxiKxp8wq8NwPWQjK8gQ1lGFGQ=;
        b=lMFx0b1tRpnjDt5mUyKPIaF90C8dE6pNKIYUG1a6O+GUl8h7+24VJ8MCut4DHqn6Cu
         g9v4YieOuEFr6wYb634KCfanQPGQ4Vu4PvHBpg6wnVopTPiRrGNPAUNd36eJEJVnlpcZ
         ixh4W7Eld/rBZuEvzQ4guKbC+FqKcZpSdxkTtnqQnBP+QJVP+t2cQFKviTSoIq2Z5jqW
         +K2IN3N0iTOGi7vzn+1r0r+Qz+z3YEfSzPzOd5uBKBuZvudR1jasQXdZJ9X3t/xVPXjc
         sC9vh6GGL5je8Qgn6lHA1exd0mJ17wTxKTc1gbIQ6lDvFx6+Cudn4MSUHUx9VuQmgyNl
         6H8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaEPH7VUltbisLIEvLODEMJKJ3S+ZMYbacXWphyXUW6I285wbMyVQd/tImhThJDoSaU2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxl2TC5C5jyJvnCyyWR4l3Vr6x3x9ZjdvxDgDOjXz7pBNujVcx
	sOXFgIe+lyMudep4/5cBKrQT7k/ptA6JL+lAhf1d6fsBHBPsY+9ytbbH8oyQD121L98IWYoCENS
	P1tXAHV9qG2g2dAUuk4PejsCX8/iU61U=
X-Gm-Gg: ASbGncsNyBtCB/jSwrXtnaq1xr7lkQgvEugEHp/Ne+jk72Af+9CPlnK7rnUCj+damuw
	CNUSucFRMzN9+E0XhJSvim/QPeGcbzq3AbWojZe5KMAXGzK92yLLX7PxyZ5uN20BhC9w5ZKX8pl
	EZANTaaW9m3FYZvKUqgloJcrDrb44zd18llW+kIR0VqK2HF5cDE9+JikPOkYdPTxduMy1y3ZI76
	W8UUanx5EeT47stPJqm4uQ9MAGkSBDzlHk8Ksc+VKeNqK/ChN7Z3QGyuaRWYDNgeSY61/VSODyP
	tgbNEcQJWZIA6cS03Ypf3rfqVhNuNXeiWm8G+6c=
X-Google-Smtp-Source: AGHT+IE57OgXWGpaWjQKE3XKXQ8tZakolTW28uTm/uZoNVLyCv12VeiNDH3vN49WeqmBnI0JM8eSjJVhBSND98wh6f8=
X-Received: by 2002:a05:6000:2902:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-42cc1cbb516mr4005417f8f.16.1763761247743; Fri, 21 Nov 2025
 13:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119224140.8616-1-david.laight.linux@gmail.com> <20251119224140.8616-7-david.laight.linux@gmail.com>
In-Reply-To: <20251119224140.8616-7-david.laight.linux@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 13:40:36 -0800
X-Gm-Features: AWmQ_bkrDq5Sy9ZDwUnEnBRGSTSoJnIDtxROTDLoYODXJgIZb-Zn1Fl-VND75l8
Message-ID: <CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
Subject: Re: [PATCH 06/44] bpf: Verifier, remove some unusual uses of min_t()
 and max_t()
To: david.laight.linux@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:42=E2=80=AFPM <david.laight.linux@gmail.com> wrot=
e:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> min_t() and max_t() are normally used to change the signedness
> of a positive value to avoid a signed-v-unsigned compare warning.
>
> However they are used here to convert an unsigned 64bit pattern
> to a signed to a 32/64bit signed number.
> To avoid any confusion use plain min()/max() and explicitely cast
> the u64 expression to the correct signed value.
>
> Use a simple max() for the max_pkt_offset calulation and delete the
> comment about why the cast to u32 is safe.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  kernel/bpf/verifier.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff40e5e65c43..22fa9769fbdb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struct bpf_reg_=
state *reg)
>         struct tnum var32_off =3D tnum_subreg(reg->var_off);
>
>         /* min signed is max(sign bit) | min(other bits) */
> -       reg->s32_min_value =3D max_t(s32, reg->s32_min_value,
> -                       var32_off.value | (var32_off.mask & S32_MIN));
> +       reg->s32_min_value =3D max(reg->s32_min_value,
> +                       (s32)(var32_off.value | (var32_off.mask & S32_MIN=
)));
>         /* max signed is min(sign bit) | max(other bits) */
> -       reg->s32_max_value =3D min_t(s32, reg->s32_max_value,
> -                       var32_off.value | (var32_off.mask & S32_MAX));
> -       reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)var32_=
off.value);
> +       reg->s32_max_value =3D min(reg->s32_max_value,
> +                       (s32)(var32_off.value | (var32_off.mask & S32_MAX=
)));

Nack.
This is plain ugly for no good reason.
Leave the code as-is.

pw-bot: cr

