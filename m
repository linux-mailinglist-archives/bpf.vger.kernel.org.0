Return-Path: <bpf+bounces-45986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CEE9E113C
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 03:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C91631C2
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1D6BFC0;
	Tue,  3 Dec 2024 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEnLsVL6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668A8460
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192784; cv=none; b=PAeeLyz/81E07rM6isuRYU6+5BRBblVrUhdQrm71AlxGuQ7Cmho2ujky4VlV0VFtChB4offG4WzVEDydSwva1mbZfqtfR2Jum2LaRcLcHqWQpMxd3OMzjb75ciL4Qz11XrxOWCuwKu52HdSK68z+CenqNA9eKRdTx/t5xd+fj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192784; c=relaxed/simple;
	bh=LyfTJufADcTOKCow6nEJXwMVLzHtIl0YwEmhfUmvWY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA8t6/380XFFjTes25yI532RKgLY6WHwKsk2APO8uWcQ6E0IyEcXhQOxCvO+lGdIkQdPmzoDb9ElksJcAUc26WC0A2Rr38VvZiDeU44CmYBTL18gWOti3YdvXAU/zbSqvwLKlzTXuRzwa0q+w0bqvfgUiuO8LpZYYJDDJQVWEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEnLsVL6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385df8815fcso2287085f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 18:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733192780; x=1733797580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEy7Q7AXUuvq+Rmunh+4YUZRpCHgypg32Urn94wJBhQ=;
        b=XEnLsVL6PGvnV5K9RNeunuzeUkYTpZd8Dx+H2AOhFS8gQgIxsV2ChE3ZPLRPoUugkt
         YV4Rc+HAhdoT+9XyIw9syl/GxdMNPqpbj55cE2bw7Ad4VcdfzfQOJKjrZlVKC6J5bQVu
         IQ2isjOkrRziblgcdoT8dtBo0izEK3TgxA7eV8vS1F8y9zAzCRMfFBXger1NZjdXyFZs
         /Fs85Nfjgs++64wWZl+hI5I/sNkG1Q1t+EKEO174pnnaM3dVyx/AER5s+aMUQrmdDQF/
         QUok2SSnKVi8IAsEGDAnfd9lZPUE92Ez7guHto5j+5/Ro0HcJ0zzuXAAR8P4aXG7YVR2
         9oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733192780; x=1733797580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEy7Q7AXUuvq+Rmunh+4YUZRpCHgypg32Urn94wJBhQ=;
        b=ou2dODY41MW6eIu5eeanpEo2hocixkJbZtlyPPJlvETYpgrDQqjpzb63rfyoDert2w
         ASVCahFBdhCQNJG3uOAS6z+MlV6e3TRZuRQFI/QTq8sQXk3MWs0/xgGJc1nwzvcPFgYN
         r0+IDGzmMXnI5upLmyCAExw9HuTKB1xt5zAUbidPOm2/vPF12nPwjyZzL3iLDCM0dmgN
         GCNE/LrMXPakPhjKwGWGHutnbxUjAvTKOgYUs0b0zdBURmzrLf1EaVwdjVq267qYzfB7
         Rg4f0IhSZ1+X3qt3ptN/2FPk9kyVKWMUbyINCpjRrJN1HEHjBKlJiWxfLl46uAr4FvIh
         kR4w==
X-Gm-Message-State: AOJu0Yzx3cxIj/LqcU7EkrGS3wxU72ALhourFOgmaxJn7MWPn4SJMdtx
	NqsBexi/yrUHohX1RI71rWaTCQ65en4FJhLsOtzmDS8oYLlJCopg5jjS+GUzJNUZNM0DsPV/teP
	yFrtXW8uu7SlH7TMLNndko8i7aew=
X-Gm-Gg: ASbGncuzaYHQLixUzcSBuhyanjm5kQfSiqKXsSsL96Me0CV+dODqKABSixE4pNE3pLj
	aY06sXTcafNBaHjnYBJoQwE139lKOlETVox3FP/DEeYL1pbs=
X-Google-Smtp-Source: AGHT+IGjeXwp7O/zcBv0D5sSECWpa/osgkQQvu93pGVqp13KlhrKHzoP1WANdokxCP6076JdWsJhmrYOhTjfaOLP/l4=
X-Received: by 2002:a05:6000:2cf:b0:385:f195:26f with SMTP id
 ffacd0b85a97d-385fd3ebe55mr536308f8f.19.1733192780198; Mon, 02 Dec 2024
 18:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129132813.1452294-1-aspsk@isovalent.com> <20241129132813.1452294-4-aspsk@isovalent.com>
In-Reply-To: <20241129132813.1452294-4-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 18:26:09 -0800
Message-ID: <CAADnVQLezUADcW5gJopCyfdYaNSiA+9Zk2n5Mf2EovzCv0AnvQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:26=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
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
>  include/uapi/linux/bpf.h       | 10 ++++
>  kernel/bpf/syscall.c           |  2 +-
>  kernel/bpf/verifier.c          | 94 ++++++++++++++++++++++++++++------
>  tools/include/uapi/linux/bpf.h | 10 ++++
>  4 files changed, 100 insertions(+), 16 deletions(-)
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
> index 8e034a22aa2a..d172f6974fd7 100644
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
> +static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *=
map)
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
> +static int add_used_map(struct bpf_verifier_env *env, int fd)
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
> +       return __add_used_map(env, map);
> +}
> +
>  /* find and rewrite pseudo imm in ld_imm64 instructions:
>   *
>   * 1. if it accesses map FD, replace it with actual map pointer.
> @@ -19318,7 +19324,7 @@ static int resolve_pseudo_ldimm64(struct bpf_veri=
fier_env *env)
>                                 break;
>                         }
>
> -                       map_idx =3D add_used_map_from_fd(env, fd);
> +                       map_idx =3D add_used_map(env, fd);
>                         if (map_idx < 0)
>                                 return map_idx;
>                         map =3D env->used_maps[map_idx];
> @@ -22526,6 +22532,61 @@ struct btf *bpf_get_btf_vmlinux(void)
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

The comment is now incorrect. 0 is not a valid hole.
No holes are allowed. And no trash.

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
> +       if (!IS_ERR(__btf_get_by_fd(f)))
> +               return 0;

It is quite asymmetrical that maps get refcnted and saved
while BTFs just checked for existence and not refcnted.
A comment is necessary.

> +
> +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", f=
d);
> +       return PTR_ERR(map);
> +}
> +
> +static int init_fd_array(struct bpf_verifier_env *env, union bpf_attr *a=
ttr, bpfptr_t uattr)

The name still bothers me.
The fd_array in the env and in uattr is not initialized.

Maybe process_fd_array() ?

pw-bot: cr

