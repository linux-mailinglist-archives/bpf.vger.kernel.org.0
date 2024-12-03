Return-Path: <bpf+bounces-46028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B145C9E2E0C
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72573283B5B
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FDB207A20;
	Tue,  3 Dec 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csB4CeDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2B189F3F
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261167; cv=none; b=U5h0CUmFQiRBpdIhzEk6WxgV3CsJjNwUb218uXE9CQ/9TcXHCVi4Iren30ontPhy29DVNGERkrRWzq/hFXl13u9Gi6oW844pPo8vIN+t688oq119oDdu8dyyXQUHqLKrcC4B5iZQcgEoEY98l2XEJciMGnKnorU3nvgml05Y7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261167; c=relaxed/simple;
	bh=Eajsl17haaTSoQ/RYrZ6vYx2pjpq5J3VXaUBjyMi19o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdyh8wAuxiE6oA+IJLHCJjRd423bfXtK6lGzh4vx359d43mAESC+VvVROA7ToIyCLKG/0iQq2FlwmWx9evDhAOQgXTw3L9+0aFQkpbCvd0F6xDE4yYFRig/7O/L+wAVWSDr893Lywke3LYak2palc/AKEI1djwCghjmLijC1PEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csB4CeDq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so2761053a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 13:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733261165; x=1733865965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z/CS3OhIRtz71ejXglByk/fTvFQHavAstuDCbK3kAU=;
        b=csB4CeDqDziMZyA/BeXoos6ajawAi/Njo0stgpiO1mxCr5DynF6oFQl3oYrS9mA3Vj
         n4/ExxupAHHfY8pGarN3eH1D2OaNxPG7mZ0dC7D4Wb6DfIBkJ7kCLQ4fZ4Gu6iipIlzP
         5//b33jsg2/LEy1SBwh5zbdLFjzTbPkhMC+DbbOA4RI9jy8yBTYIBhhJyeXYJiSFjpLs
         Gm5D30nh9nrIu2vNu9HRAo/tYoT1LjYCO+dC46a9psEncBl0cJGs9EcW8xUMFewJsDDu
         2nNjUAeCW0csdusGyrXaFdJyvwVjcHCf13GeHidjkkaMoBMejPUjGul9HKeVDRULiIUH
         uTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261165; x=1733865965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2z/CS3OhIRtz71ejXglByk/fTvFQHavAstuDCbK3kAU=;
        b=N8TWLYfmQEN0mds+ZPIPICI5nRdNTenZFSJKBjeGVKG9uVvnY+gb/gvjvO0RjysrYh
         N52VqgHF6e3bWhNIQc0a73nnXnGqVp/zYLwqjeDk7tJYIvnAuh9+wLtXhw7Z3g4RX5Vo
         LeKxfoOGwMwh7vAbwec1QQdDbBj+xBhQncgsFo7Pjgwwe6kKD2CWjXHk9LTfrMX2j88O
         k84ok4xSqwZuyEtGGfK9owPPgDXbsT7d4XWeVyO9IyVX3OBQ0EC8lTCClO+RRMmCjCO+
         pReK+UNpBEU2isQlwEDgIEboB/oqKwsutfbDJp4dWzrsPQrwLjzw9m50LeyNgm0BI/EO
         +7mw==
X-Gm-Message-State: AOJu0YwhqKM8YuL1VrLb9bAkQc1hImryUIoqe1qyvvbZ7WqPhggxP1Jz
	HCKC+WRauj1IvTrl03k/TLMy4vKXAg1AuxtH59fEccK5J/gMnA2iYij6aTYt6eB7gR5WBoOYhvG
	xPUBonLKMquxWPu5UYKmfZd4OiBA=
X-Gm-Gg: ASbGnctxDu7hBsI7ESS/mlM8YRMK7UFywRXxGoKja8bCNpjoVrwT1AJ0IOugLjxiZJ/
	CBmCZiD0a3C+7eh25tAQ4nqzNRi5qb+4gGC1QhMTfdeILuRY=
X-Google-Smtp-Source: AGHT+IGT0QNPORsZjMAOCE88lMlCM7lGy4kT312nuORwU2EcwUN+IzfC3z/p6z/w1o7pQ/8WoEH5flicgAeeTVpCxNI=
X-Received: by 2002:a17:90b:3c4a:b0:2ee:e945:5355 with SMTP id
 98e67ed59e1d1-2ef012116camr5801016a91.19.1733261164999; Tue, 03 Dec 2024
 13:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-2-aspsk@isovalent.com>
In-Reply-To: <20241203135052.3380721-2-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Dec 2024 13:25:52 -0800
Message-ID: <CAEf4BzZogXRtHgDLa1nm4neOEbd+b2+UX_fog2hpgYJ5vr-X9A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/7] bpf: add a __btf_get_by_fd helper
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:48=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> Add a new helper to get a pointer to a struct btf from a file
> descriptor. This helper doesn't increase a refcnt. Add a comment
> explaining this and pointing to a corresponding function which
> does take a reference.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/linux/bpf.h | 17 +++++++++++++++++
>  include/linux/btf.h |  2 ++
>  kernel/bpf/btf.c    | 13 ++++---------
>  3 files changed, 23 insertions(+), 9 deletions(-)
>

Minor (but unexplained and/or unnecessary) things I pointed out below,
but overall looks good

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eaee2a819f4c..ac44b857b2f9 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2301,6 +2301,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf=
_record *rec, bool percpu);
>  struct bpf_map *bpf_map_get(u32 ufd);
>  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>
> +/*
> + * The __bpf_map_get() and __btf_get_by_fd() functions parse a file
> + * descriptor and return a corresponding map or btf object.
> + * Their names are double underscored to emphasize the fact that they
> + * do not increase refcnt. To also increase refcnt use corresponding
> + * bpf_map_get() and btf_get_by_fd() functions.
> + */
> +
>  static inline struct bpf_map *__bpf_map_get(struct fd f)
>  {
>         if (fd_empty(f))
> @@ -2310,6 +2318,15 @@ static inline struct bpf_map *__bpf_map_get(struct=
 fd f)
>         return fd_file(f)->private_data;
>  }
>
> +static inline struct btf *__btf_get_by_fd(struct fd f)
> +{
> +       if (fd_empty(f))
> +               return ERR_PTR(-EBADF);
> +       if (unlikely(fd_file(f)->f_op !=3D &btf_fops))
> +               return ERR_PTR(-EINVAL);
> +       return fd_file(f)->private_data;
> +}
> +
>  void bpf_map_inc(struct bpf_map *map);
>  void bpf_map_inc_with_uref(struct bpf_map *map);
>  struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 4214e76c9168..69159e649675 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -4,6 +4,7 @@
>  #ifndef _LINUX_BTF_H
>  #define _LINUX_BTF_H 1
>
> +#include <linux/file.h>

do we need this in linux/btf.h header?

>  #include <linux/types.h>
>  #include <linux/bpfptr.h>
>  #include <linux/bsearch.h>
> @@ -143,6 +144,7 @@ void btf_get(struct btf *btf);
>  void btf_put(struct btf *btf);
>  const struct btf_header *btf_header(const struct btf *btf);
>  int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz)=
;
> +

?

>  struct btf *btf_get_by_fd(int fd);
>  int btf_get_info_by_fd(const struct btf *btf,
>                        const union bpf_attr *attr,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e7a59e6462a9..ad5310fa1d3b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7743,17 +7743,12 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr=
_t uattr, u32 uattr_size)
>
>  struct btf *btf_get_by_fd(int fd)
>  {
> -       struct btf *btf;
>         CLASS(fd, f)(fd);
> +       struct btf *btf;

nit: no need to just move this around



>
> -       if (fd_empty(f))
> -               return ERR_PTR(-EBADF);
> -
> -       if (fd_file(f)->f_op !=3D &btf_fops)
> -               return ERR_PTR(-EINVAL);
> -
> -       btf =3D fd_file(f)->private_data;
> -       refcount_inc(&btf->refcnt);
> +       btf =3D __btf_get_by_fd(f);
> +       if (!IS_ERR(btf))
> +               refcount_inc(&btf->refcnt);
>
>         return btf;
>  }
> --
> 2.34.1
>
>

