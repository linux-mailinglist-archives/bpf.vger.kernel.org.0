Return-Path: <bpf+bounces-46029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF19E2E0D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE33161414
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A02207A20;
	Tue,  3 Dec 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1sworwo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5A189F3F
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261173; cv=none; b=FTQhfiIfVDb2JmeTcM7HuTQmamirn5B8Jc8A8Ryo2WKG66og7fU0/VkMMlnSCpvvC5WkWjMAp6s7VeBJF17kfOm/pN9xOAW+gX7iKewPXI2KC0kBvNa1WbV/nd/XviwGewScssOo1tTJSbhlHPA7w9CW5nQ++oiZuwljeOf+v6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261173; c=relaxed/simple;
	bh=pSAuyMCsU2//B4vQgO+0cyfBbV1Xt+BIFe91EznZ2yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLsHvqcCK27GtZrTEB39nMHug206ZLEEwIxYvOySrpMV1mNqSljzNXB4imF6kFuiOqcfvHQK4Bncy1DEDXezCf8h/1RetjojGU2wOhbsRpN00Q7wa+pw5M3eYV4OxVwJlpEl5Zjed5B5nP3vGjqqYDWBrAf9Cxpx36VuYHOhLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1sworwo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso5283381b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 13:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733261171; x=1733865971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwb9OGVCqgmBk75Jye+gKXOC/DgpcoHrcp1jshO7/1g=;
        b=E1sworwow5Fd510RBpG2rlUH77iZ7esMLGTOrbeqesEUfXm+cnLUjwFq7QRrQ8wrX2
         7QeBkBeMcL5YxGJe9FQoMjI6GZqzu/SS/WpmmW+PKBDyAG+JqIXUI9Wnm70P//zd/BjJ
         yxzWXlDme5Lf94fhP6Up2zWwjpc97QkN0LpEb/+vFfGoMyYqeybFH5esIJ57oNkmzCw8
         gf0cxvZhR4/PVQv4BXoxnVdKx5PDZ+fGW078McdU3ej8TNJXazIKDrkiIOSuqKyeTFik
         5gT5T8jo0DBmnxXZfH85+wpkL1qT+owNrEuf/89Zad+aDcFnydOglyc15QVHsFYNgC3J
         gaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261171; x=1733865971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwb9OGVCqgmBk75Jye+gKXOC/DgpcoHrcp1jshO7/1g=;
        b=jDeNghp5I9dRxoFrWYJQbrT2jLtcusde4uo+ICmY5IwWHrCdF0dkDEdkrPzWhs5nZA
         chgpjWLcEx36rmjHn3t+cGxZdvVGRfNzd0dVaRoF8tVqIWy1wCcxD2g52Tv9w0bBADEW
         14qcxrVGzaUpSsljOjT2LzWRdqFXYkyFpoWSXXDlyVoLdvbpEE2iildiMAexvjSTn49W
         jZC/vLSwFzBh8EYBqcPLp6U7RelFTOrpJ/fD9GNpqookidFYLFDPvDVGKThI/iGV62+x
         OfdMrW8Dw4RpTxUIYwmfGEiANwv3OBJd9OYZ/drPY8fz+jNhpCM3ghmwaGkjEWikRSjF
         SJ4A==
X-Gm-Message-State: AOJu0Yyb34spLd/IYMU8GLCK5RU/lKo6rgXn1/2csoGHOCm+OTJl6L8l
	qyMhSXkGkB6XUWNJtDMQnFL5zdB8m9WnHnrJrcNppCutBqs69OrzO0Wx1enYFo9rWML5uSmfdK9
	tVVPkNRK5rti06Q/0/Wo5cS90VZVdoQ==
X-Gm-Gg: ASbGnctvG/PDuH5XIGgXCjiumImy0Qlqqj2Wm+6gaadBi7gotyTTtkvvh1eIJSLOsdN
	KEQNSG5C+Np6UGg639roB976w9WoQRGM/ybmJWbVjQBdE1es=
X-Google-Smtp-Source: AGHT+IFmPfrsuax/lOHf5a1E5QkBvQVEuGobdvZ4PElfRagt6ojG2cmpcjGVLygwdVa+ytUK2VqIMhA8DfFwcnkOeNo=
X-Received: by 2002:a17:90b:33cd:b0:2ee:bbd8:2b7e with SMTP id
 98e67ed59e1d1-2ef011ff932mr6709330a91.12.1733261171044; Tue, 03 Dec 2024
 13:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-4-aspsk@isovalent.com>
In-Reply-To: <20241203135052.3380721-4-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Dec 2024 13:25:58 -0800
Message-ID: <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:48=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> of file descriptors: maps or btfs. This field was introduced as a
> sparse array. Introduce a new attribute, fd_array_cnt, which, if
> present, indicates that the fd_array is a continuous array of the
> corresponding length.
>
> If fd_array_cnt is non-zero, then every map in the fd_array will be
> bound to the program, as if it was used by the program. This
> functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> maps can be used by the verifier during the program load.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/uapi/linux/bpf.h       | 10 ++++
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h | 10 ++++
>  4 files changed, 104 insertions(+), 16 deletions(-)
>

[...]

> +/*
> + * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-ze=
ro. In
> + * this case expect that every file descriptor in the array is either a =
map or
> + * a BTF. Everything else is considered to be trash.
> + */
> +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> +{
> +       struct bpf_map *map;
> +       CLASS(fd, f)(fd);
> +       int ret;
> +
> +       map =3D __bpf_map_get(f);
> +       if (!IS_ERR(map)) {
> +               ret =3D __add_used_map(env, map);
> +               if (ret < 0)
> +                       return ret;
> +               return 0;
> +       }
> +
> +       /*
> +        * Unlike "unused" maps which do not appear in the BPF program,
> +        * BTFs are visible, so no reason to refcnt them now

What does "BTFs are visible" mean? I find this behavior surprising,
tbh. Map is added to used_maps, but BTF is *not* added to used_btfs?
Why?

> +        */
> +       if (!IS_ERR(__btf_get_by_fd(f)))
> +               return 0;
> +
> +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", f=
d);
> +       return PTR_ERR(map);
> +}
> +
> +static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr=
 *attr, bpfptr_t uattr)
> +{
> +       size_t size =3D sizeof(int);
> +       int ret;
> +       int fd;
> +       u32 i;
> +
> +       env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
> +
> +       /*
> +        * The only difference between old (no fd_array_cnt is given) and=
 new
> +        * APIs is that in the latter case the fd_array is expected to be
> +        * continuous and is scanned for map fds right away
> +        */
> +       if (!attr->fd_array_cnt)
> +               return 0;
> +
> +       for (i =3D 0; i < attr->fd_array_cnt; i++) {
> +               if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size,=
 size))

potential overflow in `i * size`? Do we limit fd_array_cnt anywhere to
less than INT_MAX/4?

> +                       return -EFAULT;
> +
> +               ret =3D add_fd_from_fd_array(env, fd);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +

[...]

