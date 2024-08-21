Return-Path: <bpf+bounces-37744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31995A325
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E9B2848C1
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A641AF4C9;
	Wed, 21 Aug 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niDm80TQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57831494AD;
	Wed, 21 Aug 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258897; cv=none; b=DeL+6Y/WnoqvOt1udHpDIREL4LgVPXOGACYNSOVb+vrtRx81gqjwSoV2RFMrhzWtbH8dNjyCAX9CVqZVRuDmwopv6vKKHD3+1t1GVEup1wWDE2LMq9Nr9LtxzEvdgWYtUDdK7lI8WVhkEAzdeJq3qZKwU5M+jgoWNJj+UraXpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258897; c=relaxed/simple;
	bh=hu3U2lqHW8XjE3f88Fa6kpBBfcjZdPKg5+0VG4VCd9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCAPLwFWkQ6fIpwUKL2RzAeqbQZhkmUx1ofZb0e8xHUr+JTBnWzTMK2XnhZbgueNUiklJeHwDpQ6x9mbBL9TpRNQPAwpNa5KY+zlvF1J3PcsNRjecdrn8jUUyhadlatvcwGL8Cq/qwNo0rRa/UBmEGP6GsZftcDDt9Nw/Do4IYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niDm80TQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso4809798a91.1;
        Wed, 21 Aug 2024 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724258895; x=1724863695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gccrhG20IPbWQhUWAz+PibihnKQhtgYlc3WP4wSpGCU=;
        b=niDm80TQj3Bcwb0Bp48u/KJEdOx2dyHJzVeUV4kamrlSGxSevnAMx0gVrVRqFvXTYs
         f5wj/rLeP3880Y1hFsR9kpUdfqrFBb5HBg3SjdKUut9DGQ5sO4THj+ti578JsoXm+cRE
         YmG/Ojitpgt+5tz+s64SXCiBY9JX/rpCNfEW31G/SAnblBuGzHOxXndYee4YM8SxHpKm
         yJGUDU1n3cgiQZV4Rr/EK/l5ZeKrzdBLjdmBmNzQ0/OnXEZKCIq/485rvDaELfTUsT1t
         6fUebcqaq0WAwLtDrCSoVg9ky4PANxFOvCkER+iewqd9ItSty/2P2L8GOImV/AtvOhym
         glHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258895; x=1724863695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gccrhG20IPbWQhUWAz+PibihnKQhtgYlc3WP4wSpGCU=;
        b=jpX4eO7TFR5e6RoYSqRLlEpz643PxzSNx6iFFNK1shhSf+/YpZ5+DSJQqfHuZexFra
         bfT1KaBbYWwUvn3Ebl3m1YPFpdudkXhie6geqHfC4I0CR+JiY5waXIXZEhoVFrIoRzHe
         O/MJKxD0MRvEuPAUgf2uy+00EW8FSt5sHPPqjFHApn9XDbcOskUrEaMvMkkRbq0jzCjW
         JJWIZirudTZoGbZmHwtTF9UyebHURdBVLQ0inUxJVc2rek9sPBG5LY8Xr2KHKc4F2MHx
         Mn23u9osIS3cGj4mcoI8WeLbIPEPTV5QljejIl/2UGA6MwipqoZe3Bn4LvqNRZ7SIhGO
         EBJA==
X-Forwarded-Encrypted: i=1; AJvYcCW8vhzGnZkyV4+LGoMWTkc3W66bj5bI43p/SmkhnAAefJOA4l60/7lYmtutCVFJRXaxgK40IVPmQHwHwUIJ@vger.kernel.org, AJvYcCWcC5CfeJv9VkjMrdBjMFMtpCEhOofkbTeW8sRcyj+fK9Y//cBi4BuD67Z9PpO0MGk9k2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLQ5jxcUlRCEuRniQxnpJTYvcadQLmJ+H7SO+lGo61Z9mxeI9
	wPwaGJup1i6uVTlOeKtVQPeKOYiWQXQQBh2WpZZpo1ZpijAUF9senUo+fYv9G5YXa+BfjD42OSI
	CpeH82p8LZTHzCeqffOPLk+UDPKo=
X-Google-Smtp-Source: AGHT+IF6UzOE8u9e/cjaL1j7QVP1dy0v/BLuScWV8YkCpWVl1ix2tr+F5X99AfcWd0F+2chEq1eXkpwju2+D4olFcSg=
X-Received: by 2002:a17:90a:9ae:b0:2d3:c0ea:72b3 with SMTP id
 98e67ed59e1d1-2d5eaa9d24bmr3469171a91.34.1724258894943; Wed, 21 Aug 2024
 09:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821064632.38716-3-soma.nakata01@gmail.com>
In-Reply-To: <20240821064632.38716-3-soma.nakata01@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Aug 2024 09:48:02 -0700
Message-ID: <CAEf4BzaDWU4EEOU+s2tGhNHfqjSZjdyZCU-b=Ws7Lz7NOo7p1A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Initialize st_ops->tname with strdup()
To: Soma Nakata <soma.nakata01@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 11:48=E2=80=AFPM Soma Nakata <soma.nakata01@gmail.c=
om> wrote:
>
> `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
> and these addresses point to strings in the btf. Since their locations
> may change while loading the bpf program, using `strdup()` ensures
> `tname` is safely stored.
>
> Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3be6f8fac09..ece1f1af2cd4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1423,7 +1423,7 @@ static int init_struct_ops_maps(struct bpf_object *=
obj, const char *sec_name,
>                 memcpy(st_ops->data,
>                        data->d_buf + vsi->offset,
>                        type->size);
> -               st_ops->tname =3D tname;
> +               st_ops->tname =3D strdup(tname);
>                 st_ops->type =3D type;
>                 st_ops->type_id =3D type_id;
>

Thanks for the fix, but this has been fixed already ([0]). Please make
sure that you always reproduce the issue on bpf-next/master and send a
fix against that branch.

  [0] https://lore.kernel.org/bpf/20240724171459.281234-1-void@manifault.co=
m/

pw-bot: cr

> --
> 2.46.0
>

