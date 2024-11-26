Return-Path: <bpf+bounces-45611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47539D9007
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 02:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348EFB26632
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B4D528;
	Tue, 26 Nov 2024 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnIQm7Qs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AFDDA9
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585115; cv=none; b=eAOG8LCHc+oj8NTLMDmDnj6jIAWLiK+9xJlsg1FeCpdfiEVn7pvVGwcnprA0u0sM0w+fnAi6XLBae02QrQsF5AvLtNIQTvNG67XcKYJowBdy2tY8uPkwIO23uXg+71mZFSqcNJbTJOLSnRypPAzxt/pfNVBxzsDF6tpUG/VZbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585115; c=relaxed/simple;
	bh=VRFfgjmrv4x4B3pWtAb/nKa2jSyGKrufAiRQv1aX9lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wx5ZzAxdqy1CGqSM6KAe+c2PHjzTTs+djo6Zv7oONao/mvzC8LzOL99ywwmw/CVDTBIx/hzdPa/6MnMxtAHvUubvinTscds+VNpYyxGS8O18oZhx5uN6+yGdpnIZmxYA7ZWu7j7/bt0WmaomMrvoYdeU88Unkp8X0a3OW508Ag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnIQm7Qs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3824446d2bcso4504820f8f.2
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 17:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732585112; x=1733189912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdhmUqQsvnBgKAG3cA9lzcesyb/TS4Zg7EKkYiyBtjI=;
        b=UnIQm7QsaD9MjLCxfD3l8cpxVsUxoq1i9xhrosU/nlM/umRkgLqTMSDv/W5d7WovV8
         AeKaMy00icV/zzbnsyz0QVr8fFj1cWQn+hC/+SCrGAnQJsVGBpVe+NcbPhGL7D+JYDrj
         +z2oRsLRs9GC+fisYYsGhP6F3ft6+QpivyL+XbNE8UCyEVSUaq2svFlu9/A0nPOoPPIE
         nHwN22Ii3CTBY38AwBmZcQ6wqFqxE/aCgB/IYngaq6ZBfh4F5+kamM9SXn8NYs4D+qrz
         OiAZ8bYd6q0IQeCbTfLZWA/+pPYPWVK+/8BUdiTIPML6IVW5xTOI0uus3D0Vl7Sr10ER
         zhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585112; x=1733189912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdhmUqQsvnBgKAG3cA9lzcesyb/TS4Zg7EKkYiyBtjI=;
        b=KAi1FkNMugt0gdhWP0aOn/bDIqMpQ4wh4EMLLyK78lldMn6H6UdhgfFDpLIiySQIu8
         FxwccPQkDnNVJWXY7rWMTPHWZp89m5zhbJrcNFdLHE5bRvOlLyFJYPRcKitaTb0lxI9N
         6dao+SUUq38/BF5buynwvhn7cynuIK//6ZKTH93FiAqqzq5UuBt9KlygoeQ5iX9hkoA0
         qQ4zC8H4dMmqkm2NxUz6Ca98UfFwdrPqqRAgG6VUBqDQEwRrFmrUZl9DxunRFsPlkQeY
         v009BcuIzlp/U6WKyxTflnjeZoRK7yi1bQPUlS4WwPhpSNxzfGaOMY48HiGNJPkWFMZW
         NxdA==
X-Gm-Message-State: AOJu0Yx5D2t5mU790Cl6auSJaKmgnLTIy2IOrL9SXOgSkKqOLL0Y/u6J
	oj3HeqcucsVec6NOJCfZUwWwDDsrurdtDngQ5jD1kbWbgafAZXJf7VWO5/lmL2WnMoA6AwiSVwA
	0tiwNfsuNqF2vm4bOfnBYUt3brpqqFWzX
X-Gm-Gg: ASbGncvjeGpEo2PE4beTn+vKcKCEI8NNZVp5TDKjq/dvaHHmePAw50xJZj4feu8QO+7
	MPo/99iyPXPGq9e+nghrwcYkm+2JMZS2ctSLaVodNIFRCPyc=
X-Google-Smtp-Source: AGHT+IG5VyYN8wb7SrazT+qpH9dDR7iTqVXa8CtUG6nP3tIOcIITCi2YNslXGl0ioJjslZU7Fg2OBk2LaIqlPD7RkF4=
X-Received: by 2002:a05:6000:178a:b0:37d:47e0:45fb with SMTP id
 ffacd0b85a97d-38260b53851mr14162731f8f.21.1732585111766; Mon, 25 Nov 2024
 17:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-4-aspsk@isovalent.com>
In-Reply-To: <20241119101552.505650-4-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Nov 2024 17:38:20 -0800
Message-ID: <CAADnVQ+=SoVvmGizF8L78j=U+MWi1XnCQEdz9tJOxwYeKuZsJw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
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
>  include/uapi/linux/bpf.h       |  10 ++++
>  kernel/bpf/syscall.c           |   2 +-
>  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
>  tools/include/uapi/linux/bpf.h |  10 ++++
>  4 files changed, 113 insertions(+), 15 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4162afc6b5d0..2acf9b336371 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1573,6 +1573,16 @@ union bpf_attr {
>                  * If provided, prog_flags should have BPF_F_TOKEN_FD fla=
g set.
>                  */
>                 __s32           prog_token_fd;
> +               /* The fd_array_cnt can be used to pass the length of the
> +                * fd_array array. In this case all the [map] file descri=
ptors
> +                * passed in this array will be bound to the program, eve=
n if
> +                * the maps are not referenced directly. The functionalit=
y is
> +                * similar to the BPF_PROG_BIND_MAP syscall, but maps can=
 be
> +                * used by the verifier during the program load. If provi=
ded,
> +                * then the fd_array[0,...,fd_array_cnt-1] is expected to=
 be
> +                * continuous.
> +                */
> +               __u32           fd_array_cnt;
>         };
>
>         struct { /* anonymous struct used by BPF_OBJ_* commands */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 58190ca724a2..7e3fbc23c742 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2729,7 +2729,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type=
 prog_type)
>  }
>
>  /* last field in 'union bpf_attr' used by this command */
> -#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
> +#define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
>
>  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_size)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e034a22aa2a..a84ba93c0036 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19181,22 +19181,10 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
>         return 0;
>  }
>
> -/* Add map behind fd to used maps list, if it's not already there, and r=
eturn
> - * its index.
> - * Returns <0 on error, or >=3D 0 index, on success.
> - */
> -static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)
> +static int add_used_map(struct bpf_verifier_env *env, struct bpf_map *ma=
p)

_from_fd suffix is imo too verbose.
Let's use __add_used_map() here instead?

>  {
> -       CLASS(fd, f)(fd);
> -       struct bpf_map *map;
>         int i, err;
>
> -       map =3D __bpf_map_get(f);
> -       if (IS_ERR(map)) {
> -               verbose(env, "fd %d is not pointing to valid bpf_map\n", =
fd);
> -               return PTR_ERR(map);
> -       }
> -
>         /* check whether we recorded this map already */
>         for (i =3D 0; i < env->used_map_cnt; i++)
>                 if (env->used_maps[i] =3D=3D map)
> @@ -19227,6 +19215,24 @@ static int add_used_map_from_fd(struct bpf_verif=
ier_env *env, int fd)
>         return env->used_map_cnt - 1;
>  }
>
> +/* Add map behind fd to used maps list, if it's not already there, and r=
eturn
> + * its index.
> + * Returns <0 on error, or >=3D 0 index, on success.
> + */
> +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd)

and keep this one as add_used_map() ?

> +{
> +       struct bpf_map *map;
> +       CLASS(fd, f)(fd);
> +
> +       map =3D __bpf_map_get(f);
> +       if (IS_ERR(map)) {
> +               verbose(env, "fd %d is not pointing to valid bpf_map\n", =
fd);
> +               return PTR_ERR(map);
> +       }
> +
> +       return add_used_map(env, map);
> +}
> +
>  /* find and rewrite pseudo imm in ld_imm64 instructions:
>   *
>   * 1. if it accesses map FD, replace it with actual map pointer.
> @@ -22526,6 +22532,75 @@ struct btf *bpf_get_btf_vmlinux(void)
>         return btf_vmlinux;
>  }
>
> +/*
> + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.=
  In
> + * this case expect that every file descriptor in the array is either a =
map or
> + * a BTF, or a hole (0). Everything else is considered to be trash.
> + */
> +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> +{
> +       struct bpf_map *map;
> +       CLASS(fd, f)(fd);
> +       int ret;
> +
> +       map =3D __bpf_map_get(f);
> +       if (!IS_ERR(map)) {
> +               ret =3D add_used_map(env, map);
> +               if (ret < 0)
> +                       return ret;
> +               return 0;
> +       }
> +
> +       if (!IS_ERR(__btf_get_by_fd(f)))
> +               return 0;
> +
> +       if (!fd)
> +               return 0;

This is not allowed in new apis.
zero cannot be special.

> +
> +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", f=
d);
> +       return PTR_ERR(map);
> +}
> +
> +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_att=
r *attr, bpfptr_t uattr)

What an odd name... why is 'env_' there?

> +{
> +       int size =3D sizeof(int) * attr->fd_array_cnt;

int overflow.

> +       int *copy;
> +       int ret;
> +       int i;
> +
> +       if (attr->fd_array_cnt >=3D MAX_USED_MAPS)
> +               return -E2BIG;
> +
> +       env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
> +
> +       /*
> +        * The only difference between old (no fd_array_cnt is given) and=
 new
> +        * APIs is that in the latter case the fd_array is expected to be
> +        * continuous and is scanned for map fds right away
> +        */
> +       if (!size)
> +               return 0;
> +
> +       copy =3D kzalloc(size, GFP_KERNEL);

the slab will WARN with dmesg splat on large sizes.

> +       if (!copy)
> +               return -ENOMEM;
> +
> +       if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
> +               ret =3D -EFAULT;
> +               goto free_copy;
> +       }
> +
> +       for (i =3D 0; i < attr->fd_array_cnt; i++) {
> +               ret =3D add_fd_from_fd_array(env, copy[i]);
> +               if (ret)
> +                       goto free_copy;
> +       }

I don't get this feature.
Why bother copying and checking for validity?
What does it buy ?

pw-bot: cr

