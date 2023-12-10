Return-Path: <bpf+bounces-17334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380F880B922
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 06:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A4A280EFE
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49401FAA;
	Sun, 10 Dec 2023 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtSu8mgk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083ACF3
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 21:36:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so3222795f8f.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 21:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702186595; x=1702791395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucu6j/DSgsHUHubluSDQm292/sghrqdpgKl3zBY+25s=;
        b=HtSu8mgkcJNU5fuAdetDVWWNEAFWdJjdsMhpRUXyCbF48jTz4ktWvUdQiBbqNKqNmV
         3zOA2NavX25aLgVZtU/d1HRfUZpb3agDtljP4H2ltzP6gM9NzjVDhqJkwkOIeNwIHGHP
         PrILhRuK3xAr6FqalM8cN3GBwdfENQ3TXJtH1JVLcr7xC6nanKUl6w5I6HUgSIhCr5QI
         IPiG+DVSp8ZwjZM7JXJC9UOLMLQuUZkfiv/uvSZPrBr5aeVd5myhuZyvhHP4VshyGapC
         ELe1Otn9xClL4JCvP2p2SAE36rl1eXMMCv2UVK/Z9FNQwHoMT+2yP27KDsnYbqJnjBYy
         J0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702186595; x=1702791395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucu6j/DSgsHUHubluSDQm292/sghrqdpgKl3zBY+25s=;
        b=TV7M1dha3/BLjcQp/RrFqpMWk+nKyCjj0++Y1Vn1aFbhJZVH1OkQqivtG9Hvi0YawB
         o3z/bJuXEy7OYzKQvB6/SewLYMvrXV7sPkGha4k83d529Pc0ozIPmWzCj6T3I1IPeyZ2
         PkWR+24eRS1Z9US8woTFV5BC5o2glEummv+51sp6N1uMIZhVkoUizRvhI5ad0NUIg0/1
         oc6e3/UP/9rfDE/n7cy4V/JpCNH1XQF4p8HWNcOmaMg4zxqpeumc810/NAKH/By1+t5/
         qHh/z/OY6M681k33N163AezOJLgw36uEi+Jbeahj4BMomfANRbeBpV+bnK/UTkNjNKx2
         xCqQ==
X-Gm-Message-State: AOJu0YyDwl1oCjlqMMHRwg5Y/eGE22OsoaZdbAFsDxDOtEg5XgjlcMUX
	rC7flYT2XtLV6gEngzgtOUhIIDyOHALylDVmlXE=
X-Google-Smtp-Source: AGHT+IFep5/bMy/CDnoLfnE1RpDxZNOm2hVdoCeOXR0HsX6A+Bh3ARauhMfAbOJDaxeHcfuPSGzALu2Z79VzsmRF6yY=
X-Received: by 2002:a5d:6e56:0:b0:333:2fd2:6f5a with SMTP id
 j22-20020a5d6e56000000b003332fd26f5amr1246974wrz.100.1702186595185; Sat, 09
 Dec 2023 21:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208103357.2637299-1-houtao@huaweicloud.com> <20231208103357.2637299-2-houtao@huaweicloud.com>
In-Reply-To: <20231208103357.2637299-2-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 21:36:23 -0800
Message-ID: <CAADnVQJ0TxpDPYij-rHgcEb2J=r_RmnPgDe=VVJPan1ieT5dng@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 1/2] bpf: Reduce the scope of
 rcu_read_lock when updating fd map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 2:32=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> callbacks.
>
> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
> rcu-read-lock because array->ptrs will not be freed until the map-in-map
> is released. For bpf_fd_htab_map_update_elem(), htab_map_update_elem()
> requires rcu-read-lock to be held, so only use rcu_read_lock() during
> the invocation of htab_map_update_elem().
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 2 ++
>  kernel/bpf/syscall.c | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b777bd8d4f8d..50b539c11b29 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2525,7 +2525,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map=
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
> index 6b9d7990d95f..fd9b73e02c7a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -190,15 +190,11 @@ static int bpf_map_update_value(struct bpf_map *map=
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

I feel it's inconsistent to treat an array of FDs differently than
hashmap of FDs.
The patch is correct, but the users shouldn't be exposed
to array vs hashtab implementation details.

