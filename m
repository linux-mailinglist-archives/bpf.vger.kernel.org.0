Return-Path: <bpf+bounces-17760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783981244F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48AF1F219E0
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BE645;
	Thu, 14 Dec 2023 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWHnkvk+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B00B7
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:10:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3363ebb277bso839253f8f.2
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702516236; x=1703121036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqY1omFJslupmO9TIcc94T8P0bBw1X4HO06nU6zoGGs=;
        b=XWHnkvk+8wlN+rgdFyoU2upGjeeRIBFG4bUr5lLYiyJxTE1OYMlNoDgYYia6eOph2X
         p4Fm7RKxAcsUXgHujMXqnwY7y+4bczT/fvuM4LjH9hWEUvPNmYeBu1/uWagXZRtCOSGc
         NkV/r0pQXNuba9Dcz5FV1PS6yNspUiJOWWrW/i0EQm7n+ITykqOsDMrZeBhVu68XtkPB
         NV09+A0Nm4yN1qihUBFgIKymVdguv0dm6FzV6aIxUsnt0MlefN4Fjz1W5GjFe0S1dfgg
         ON0Zje4i3EmTwNTUgD043Bn0C0c8ge9bUwwSCmVIkRRpRBZ1/tsnXCXpqYZPb/pVR/3S
         lXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702516236; x=1703121036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqY1omFJslupmO9TIcc94T8P0bBw1X4HO06nU6zoGGs=;
        b=npt1M3dtVQhaRE+6fqUB+WGcWtMSdwgJuW2MPmVx2j4ef/E09C/tysWMeAi/+BLUKY
         KRsaZsUxdW94Dc1hbF2F2K11+uXR2LnnUoNFfx4L7WpbE9QHYAJl4qqEBmwtRNpJmW6B
         DPiqlJXWczYDUjQzqOBABWixdC8b854CXRoLeLMRGUtp8ueiVQQRYirx/N6TyP1MXrs6
         pgYHrWUItxtyEyRN/D/MT88Bl9HMB6H16xv/8pbPxigo7useLjtj+RMXMrfMxNOo53Tn
         ZkIzRK0tnJnV5NchoeBwbOhDLJwh1wfxvmf3VWLS7h5IhHRtIP5K1GvS/UmsQR+8h4Sl
         71MA==
X-Gm-Message-State: AOJu0Yy+TU8Qfvp8JziZbBNAp2nXfkQTM81updW/GfpSmtxiUofblksN
	otdEiCz+HZw9GAPpf1nXfhyuJrtAv0MGBpqnm1Y=
X-Google-Smtp-Source: AGHT+IEEP4rRpd/JE2AmVkC6wVX2rvTlaZFo+5MRjuRDwNnJH9CvXD5GPDcPfDOqBRcVRFWeyykbQoysDPE5SLbz8iw=
X-Received: by 2002:a5d:6352:0:b0:336:36a1:3b1b with SMTP id
 b18-20020a5d6352000000b0033636a13b1bmr1391880wrw.47.1702516235617; Wed, 13
 Dec 2023 17:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211073843.1888058-1-houtao@huaweicloud.com> <20231211073843.1888058-2-houtao@huaweicloud.com>
In-Reply-To: <20231211073843.1888058-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 17:10:23 -0800
Message-ID: <CAADnVQ+Tb9btofrgp41E+2RBEtpp_s5D2rPZjYx34XX=XY3BFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 11:37=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> callbacks and only uses rcu-read-lock for the underlying update
> operations in bpf_fd_{array,htab}_map_update_elem().
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/arraymap.c | 2 ++
>  kernel/bpf/hashtab.c  | 2 ++
>  kernel/bpf/syscall.c  | 4 ----
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 8d365bda9a8b..6cf47bcb7b83 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -863,7 +863,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map,=
 struct file *map_file,
>                 map->ops->map_poke_run(map, index, old_ptr, new_ptr);
>                 mutex_unlock(&array->aux->poke_mutex);
>         } else {
> +               rcu_read_lock();
>                 old_ptr =3D xchg(array->ptrs + index, new_ptr);
> +               rcu_read_unlock();
>         }
>
>         if (old_ptr)
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5b9146fa825f..4c28fd51ac01 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2523,7 +2523,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map=
, struct file *map_file,
>         if (IS_ERR(ptr))
>                 return PTR_ERR(ptr);
>
> +       rcu_read_lock();
>         ret =3D htab_map_update_elem(map, key, &ptr, map_flags);
> +       rcu_read_unlock();
>         if (ret)
>                 map->ops->map_fd_put_ptr(map, ptr, false);
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a76467fda558..019d18d33d63 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -183,15 +183,11 @@ static int bpf_map_update_value(struct bpf_map *map=
, struct file *map_file,
>                 err =3D bpf_percpu_cgroup_storage_update(map, key, value,
>                                                        flags);
>         } else if (IS_FD_ARRAY(map)) {
> -               rcu_read_lock();
>                 err =3D bpf_fd_array_map_update_elem(map, map_file, key, =
value,
>                                                    flags);
> -               rcu_read_unlock();
>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS) {
> -               rcu_read_lock();
>                 err =3D bpf_fd_htab_map_update_elem(map, map_file, key, v=
alue,
>                                                   flags);
> -               rcu_read_unlock();

Sorry. I misunderstood the previous diff.
Dropping rcu_read_lock() around bpf_fd_array_map_update_elem()
is actually mandatory, since it may do mutex_lock
which will splat under rcu CS.

Adding rcu_read_lock() to bpf_fd_htab_map_update_elem()
is necessary just to avoid the WARN.
The RCU CS doesn't provide any protection to any pointer.
It's worth adding a comment.

And
 +               rcu_read_lock();
                 old_ptr =3D xchg(array->ptrs + index, new_ptr);
 +               rcu_read_unlock();
is wrong and unnecessary.
Neither old_ptr nor new_ptr are rcu protected.
This rcu_read_lock() only causes confusion.

pw-bot: cr

