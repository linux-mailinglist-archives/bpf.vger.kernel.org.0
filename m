Return-Path: <bpf+bounces-51479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4AA3525F
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F93A7A1B0D
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01631C8604;
	Thu, 13 Feb 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FErcSIzZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95019275419
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491007; cv=none; b=XKYobB5bGlYQ0vfMexNHYnE5EQ3ZR2iiDo33O0fBjmqYJiWfSVWx6jDbGAzC7em5U9Vx2ONY2YUoTvVqWc7wU0mzaU45RR8kDvbtr/HRDOrln/uHZqW+b1oJ9rwMb4p6VJKD7iPuS6NHO0Xf1jxf2a4Fqivz4CgIFxlpY4oYNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491007; c=relaxed/simple;
	bh=795ajYxqX6rFGKsX80V5u736+V3fNZlrlBUDV973ddM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+IxiA6JogRCmQtPNAXGYsfqVBdbFBBDce9749Sv3oQHhigx5I2OGSdU5eFpBCzs4j4F9MAx/+JO2cIJ6v/n+Lf2lMfKtJ07nz0E3jxPY3sRvaxLVT40305h8C/MOMvHGlTaR5HJut72PvZeOZbzq/vD08xYqsff739FFtGBN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FErcSIzZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38de17a5fc9so789845f8f.3
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 15:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739491004; x=1740095804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qxw7xuEiANABFhQr+7Tb0yRQvYA9gqimNRNHcP5QJM=;
        b=FErcSIzZyqyy/jgZu442NkZa1/bH/VsuoPpcN0qjjHweNdkppgWMH68egYSMD49KE3
         xSLnVmWBfnbvucB61nxSOJ8eYOjBa9TM9o9qGLCoQ+4+apRTMlI+n+K5HEbTe/9qx2je
         8ogOZNygx3QsgKr+jP45LDa459Xe8A4kLNKmkUuM4c2+TS1AuNfvG/rzGC/FRtly+cwa
         GStNN3Qf3sgSN7aj6EAOnIJUeKjLS5aNqhPjxKj4uKzcbm2HwR5Bf+nGkwKTAtavDg/6
         VZ74WKvHkA7/FEnfdB3gQ8AN/HuBhZo0kGR2Vzq4DI+anZzxV7Q8ahApewnA2iWxsKmw
         aMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739491004; x=1740095804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qxw7xuEiANABFhQr+7Tb0yRQvYA9gqimNRNHcP5QJM=;
        b=mIjQfr9wPISdcgbIxs3VNEU5GPkIXb+TmwECD9sRY+2T7RczikIvjGC/PGKhoLbG4A
         f023NZBro/FmN8jlavCXFZ4n3xA4K7mg+Otrfj0sLbRDMs1gvTeHCSGwGHPcvGalYRnL
         26mQBkwMxHYC8iMhpuuXqhGkZEDocZVtkoLpJwm/YEAa7mN7OT+lKUab09swsXDv07kf
         XBK1gReWcArI5Z7TiCvf+nFah9xJm6lJHw5pfoEsjuCS9xDsOYB8MaCIWsE1eNSlpik9
         9uzi+zyJRdE+EEzJI034c49l9c4s8NZ7rxvF6rIAUAOcZ9U2rJ21uQzV+UQ61aVdU3Qz
         5i6Q==
X-Gm-Message-State: AOJu0YyC0CXqIdFfwTCZ7ZC55eBqy83AF0V7XZMwhSu3DekVjcsYtgu0
	DrQ+Y+Lf5IVG1TJpHMLuq3ZvTmVrN4zwzF5bs28TguFAyTG4V5zGME0drCpGrCvBCfMHn9q9IiX
	wh9eXOQToiMQhYH4OCDSeEkjmn64=
X-Gm-Gg: ASbGnctdP6Pyv580GWAMWiPr/D4kin+jZBanQ+qFvuErk+5jPm1NJXmQMl7rzI/jbM6
	6GDZ4fZ17KBvAbIevT8smt8Dh2fCURVajML+AyLk9430+aUGQLRzGfjW4s7Ssq4ohFgRn00dZf3
	CDIv+oevuzR4vPqKiE/i6Wh8rifX70
X-Google-Smtp-Source: AGHT+IHrjM+nC0H3pxk4iyP+TXG0HDsqPBkjwAehUn8TXszfb2JZUE+KqM+nZ1y4Pmow0VDw1d2EJbq6IeqnETZhVRA=
X-Received: by 2002:a5d:4152:0:b0:38d:e38a:5910 with SMTP id
 ffacd0b85a97d-38f244eebf0mr5419185f8f.28.1739491003580; Thu, 13 Feb 2025
 15:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com> <20250125111109.732718-7-houtao@huaweicloud.com>
In-Reply-To: <20250125111109.732718-7-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 15:56:32 -0800
X-Gm-Features: AWEUYZl0A0cD9Wg2p72GFpdDSjkl6uv4X58iDA61ddQAQGMCUXJ1uTMDMb6JYb8
Message-ID: <CAADnVQL+866m69rv+PC_V1y1-PjL4=w3obTwqLPgW3=kA_BjEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/20] bpf: Set BPF_INT_F_DYNPTR_IN_KEY conditionally
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When there is bpf_dynptr field in the map key btf type or the map key
> btf type is bpf_dyntr, set BPF_INT_F_DYNPTR_IN_KEY in map_flags.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 07c67ad1a6a07..46b96d062d2db 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1360,6 +1360,34 @@ static struct btf *get_map_btf(int btf_fd)
>         return btf;
>  }
>
> +static int map_has_dynptr_in_key_type(struct btf *btf, u32 btf_key_id, u=
32 key_size)
> +{
> +       const struct btf_type *type;
> +       struct btf_record *record;
> +       u32 btf_key_size;
> +
> +       if (!btf_key_id)
> +               return 0;
> +
> +       type =3D btf_type_id_size(btf, &btf_key_id, &btf_key_size);
> +       if (!type || btf_key_size !=3D key_size)
> +               return -EINVAL;
> +
> +       /* For dynptr key, key BTF type must be struct */
> +       if (!__btf_type_is_struct(type))
> +               return 0;
> +
> +       if (btf_type_is_dynptr(btf, type))
> +               return 1;
> +
> +       record =3D btf_parse_fields(btf, type, BPF_DYNPTR, key_size);
> +       if (IS_ERR(record))
> +               return PTR_ERR(record);
> +
> +       btf_record_free(record);
> +       return !!record;
> +}
> +
>  #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
>  /* called via syscall */
>  static int map_create(union bpf_attr *attr)
> @@ -1398,6 +1426,14 @@ static int map_create(union bpf_attr *attr)
>                 btf =3D get_map_btf(attr->btf_fd);
>                 if (IS_ERR(btf))
>                         return PTR_ERR(btf);
> +
> +               err =3D map_has_dynptr_in_key_type(btf, attr->btf_key_typ=
e_id, attr->key_size);
> +               if (err < 0)
> +                       goto put_btf;
> +               if (err > 0) {
> +                       attr->map_flags |=3D BPF_INT_F_DYNPTR_IN_KEY;

I don't like this inband signaling in the uapi field.
The whole refactoring in patch 4 to do patch 6 and
subsequent bpf_map_has_dynptr_key() in various places
feels like reinventing the wheel.

We already have map_check_btf() mechanism that works for
existing special fields inside BTF.
Please use it.

map_has_dynptr_in_key_type() can be done in map_check_btf()
after map is created, no ?
Then when it passes map->map_type check set a bool inside
struct bpf_map, so that bpf_map_has_dynptr_key() can be fast
in the critical path of hashtab.
Or better yet use:
static inline bool bpf_map_has_dynptr_key(const struct bpf_map *map)
{
  /* key_record is not NULL when the map key contains bpf_dynptr_user */
  return !!map->key_record;
}
since htab_map_hash() has to read key_record anyway,
hence better D$ access.

