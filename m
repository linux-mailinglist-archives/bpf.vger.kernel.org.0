Return-Path: <bpf+bounces-17772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 618EB812525
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56C9B2124F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4A812;
	Thu, 14 Dec 2023 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjAggtNI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0E9BD
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:19:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c317723a8so66960635e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702520370; x=1703125170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg8XwWx79ndwQFXqVGIP8SFMxiBBc/y9D1kXEpPZFUw=;
        b=bjAggtNIkW+1ZfkTu08B/nl28kYS1Sb/J8JWz5/3nJX2+RucGST01oWAL5X2bL1NAG
         kvmhzTM0i55BHwv4NpqJUUw+/zW2mlH5edNl9fgJ1REUT3LmLTE1sPYBSm7KpOQ6MLNr
         c5pAiZCwZ0DLEGpmGRYmahdZZLDoT1Q1XO86WTDDxI94bcFJYet5QGBmgCdRyMy7ZvKt
         EAdLOeAdqt9WgyXeydkCerB6m/5jzpQ3f4DhlcnEk8gNICcHQ3Umxu8s6ctacZ3E9xWI
         23lS9SOIc0OhZdvkpt9Eq/cM+Dhf4UPGpjb2x4t1mYC5NGMfDOhVdb3DWvU4y/Fg1zgX
         G5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702520370; x=1703125170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg8XwWx79ndwQFXqVGIP8SFMxiBBc/y9D1kXEpPZFUw=;
        b=ZiIYcQTU+Dq3ZNx7PnvTZs/x43borO9tYuxMXb2DXSwYtIoZWT3GQHvt4p9zmifdzg
         d+Yh6nbN6qcq/R5CqwcA4E5yFbC9rKoocXVh8bBK3SfFepwqq3flMpXPtogcnFQpJ2vo
         rxT13oJQD51h1HQAwXk82Oe5fSsxKOwyk4jvJrC5h2GfrWNwMfVoI5Wzb4aNIyTpGKcU
         Hemy91+YeAXbKBoZDwHNLu3Bi4zHHOtYThb/CF66vIzF8iFDbkZITj5/RJdMcUMo+xdb
         PmPOarN57NFYM2BFV/gjlZV2KiLwC6MqQdeFq6hSL8aeKRJCvxTyv5wyYNKUPu3NyT+D
         UwPQ==
X-Gm-Message-State: AOJu0YwT7FqsEewpPhgBlBAITiCzGviTFf3F+il/7hHcvHpoNP3Zuklm
	WypvFlsUIo4KOtLkAAij4Hl0YBi7xR5x0W2xP8A=
X-Google-Smtp-Source: AGHT+IGQUG9BgK2EJqOVMIQJpMRIkwJgPeNgO6EErYD25i8R+DpxE/0npt5vAhdwMXQGaYqzVDeykBynQScd8+9LzBM=
X-Received: by 2002:a05:6000:881:b0:333:2fd2:5210 with SMTP id
 cs1-20020a056000088100b003332fd25210mr3970203wrb.137.1702520369974; Wed, 13
 Dec 2023 18:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211073843.1888058-1-houtao@huaweicloud.com>
 <20231211073843.1888058-2-houtao@huaweicloud.com> <CAADnVQ+Tb9btofrgp41E+2RBEtpp_s5D2rPZjYx34XX=XY3BFw@mail.gmail.com>
 <c4ff43a8-b2a1-16e9-d8a8-1ea8c629b4f6@huaweicloud.com>
In-Reply-To: <c4ff43a8-b2a1-16e9-d8a8-1ea8c629b4f6@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 18:19:18 -0800
Message-ID: <CAADnVQL3X7igioj1sG-+F9Va=8Q7X+w1iaBn615aty6EYM48Bw@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 5:57=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 12/14/2023 9:10 AM, Alexei Starovoitov wrote:
> > On Sun, Dec 10, 2023 at 11:37=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
> >> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
> >> callbacks and only uses rcu-read-lock for the underlying update
> >> operations in bpf_fd_{array,htab}_map_update_elem().
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/arraymap.c | 2 ++
> >>  kernel/bpf/hashtab.c  | 2 ++
> >>  kernel/bpf/syscall.c  | 4 ----
> >>  3 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> >> index 8d365bda9a8b..6cf47bcb7b83 100644
> >> --- a/kernel/bpf/arraymap.c
> >> +++ b/kernel/bpf/arraymap.c
> >> @@ -863,7 +863,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *m=
ap, struct file *map_file,
> >>                 map->ops->map_poke_run(map, index, old_ptr, new_ptr);
> >>                 mutex_unlock(&array->aux->poke_mutex);
> >>         } else {
> >> +               rcu_read_lock();
> >>                 old_ptr =3D xchg(array->ptrs + index, new_ptr);
> >> +               rcu_read_unlock();
> >>         }
> >>
> >>         if (old_ptr)
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 5b9146fa825f..4c28fd51ac01 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >> @@ -2523,7 +2523,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *=
map, struct file *map_file,
> >>         if (IS_ERR(ptr))
> >>                 return PTR_ERR(ptr);
> >>
> >> +       rcu_read_lock();
> >>         ret =3D htab_map_update_elem(map, key, &ptr, map_flags);
> >> +       rcu_read_unlock();
> >>         if (ret)
> >>                 map->ops->map_fd_put_ptr(map, ptr, false);
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index a76467fda558..019d18d33d63 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -183,15 +183,11 @@ static int bpf_map_update_value(struct bpf_map *=
map, struct file *map_file,
> >>                 err =3D bpf_percpu_cgroup_storage_update(map, key, val=
ue,
> >>                                                        flags);
> >>         } else if (IS_FD_ARRAY(map)) {
> >> -               rcu_read_lock();
> >>                 err =3D bpf_fd_array_map_update_elem(map, map_file, ke=
y, value,
> >>                                                    flags);
> >> -               rcu_read_unlock();
> >>         } else if (map->map_type =3D=3D BPF_MAP_TYPE_HASH_OF_MAPS) {
> >> -               rcu_read_lock();
> >>                 err =3D bpf_fd_htab_map_update_elem(map, map_file, key=
, value,
> >>                                                   flags);
> >> -               rcu_read_unlock();
> > Sorry. I misunderstood the previous diff.
> > Dropping rcu_read_lock() around bpf_fd_array_map_update_elem()
> > is actually mandatory, since it may do mutex_lock
> > which will splat under rcu CS.
>
> Acquiring mutex_lock is only possible for program fd array, but
> bpf_fd_array_map_update_elem() has already been called above to handle
> program fd array and there is no rcu_read_lock() being acquired.

ahh. right. That explains why we don't have a splat now. good.

> >
> > Adding rcu_read_lock() to bpf_fd_htab_map_update_elem()
> > is necessary just to avoid the WARN.
> > The RCU CS doesn't provide any protection to any pointer.
> > It's worth adding a comment.
>
> Yes. There is no spin-lock support in fd htab, the update operation for
> fd htab is taken under bucket lock. So the RCU CS is only to make the
> WARN_ON_ONCE() in htab_map_update_elem() happy.
>
> To ensure I fully understand what you mean, let me rephrase the things
> that need to done:
> 1) Repost v3 based on v1
> 2) In v3, add comments in bpf_fd_htab_map_update_elem() to explain why
> the RCU CS is needed. Is that correct ?

Yes.
Thanks

