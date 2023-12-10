Return-Path: <bpf+bounces-17321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF280B862
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 03:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7601C208CC
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1A15A5;
	Sun, 10 Dec 2023 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6rHjr2v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E522010C
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 18:12:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33334480eb4so3952549f8f.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 18:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702174327; x=1702779127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tCZB3KFtOu61BsXE81B06m5RyTsHvy6ZvVhJYTjq/o=;
        b=d6rHjr2vYueVi4Lq9V8ITpv3CVX+DQtOwF+KiSZHITOUY8Y3rpM9EnNuly/s0REiaQ
         /z/MDamslvy5w6Q3NGfXRGUWFEnjGA4kMpEizFmfYmO/WewUMLZ9W5H0HKwXWf7a47+K
         j050J2ggqGSHNb1Dke/+ba6hJ1zGXZ6ga1jdxhfqiSPFNbNRTkFQDrGyKgwRU2BL+Y1X
         KZxqaT+zxxzGQhQKOQjOAsGhvP2LTtDSiV7GZIc799HCVbEoco3ptrAlcs2sETUfhSF4
         AzHH2s0/fyQ2vV2loHkcWoLfOy/H/+T2oGQ3SFmkWb0L3g5Vgi5wBwTUtSn5bCT/ERVb
         /J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702174327; x=1702779127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tCZB3KFtOu61BsXE81B06m5RyTsHvy6ZvVhJYTjq/o=;
        b=ML0+EYgxSI8nuYA56IlDJ5slE9iPuCTDcxz13+rUJU+6oFooNUBPQ/MEcSYb6cSeMH
         2kMSJ+I2tLV/llRbm56mOf5n98JThQOxwyAiyKa8pCEXidXahJ5EVKAcEI37yM3RdaBE
         m4oiHWi5JTf3D9AZKzGUUmloVgIKM2KnfModukbQkNgOgBg5Deni72hrEJQauoGwPiu+
         4h0TYj1lThR+L6wphfk18XVzSHeC/n1mwGrMWb+ZGut4D0Z5dgmZy+g7HUakiIYbhEpZ
         HZ9nWpS3UTjG5TG1qWsz7YtSwqHZ5R8kR7VP99ojopFIAIrRg40yORT8fXWMWnm41dYL
         liqA==
X-Gm-Message-State: AOJu0YzXmdZaa4fsNaCJDMnBryo7D6IDgsh3EiJeaHWC4omaNCJBc7Ou
	uhYmsJI4NaKXvm3QzP6BCZiC5gtx3lFx3Q64tk8=
X-Google-Smtp-Source: AGHT+IHo3nfQyEl2psKrFJlbj5bDe/9QDOcOb/SysNtzEZi9XW/97Xx/IazMMvrGkNO9wtURD7pgRYXzgKzWJKisYT0=
X-Received: by 2002:a5d:6306:0:b0:333:2fd2:2ede with SMTP id
 i6-20020a5d6306000000b003332fd22edemr903836wru.87.1702174327100; Sat, 09 Dec
 2023 18:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-7-houtao@huaweicloud.com> <35510021-8c55-455b-894f-6b7656f8b8d4@linux.dev>
In-Reply-To: <35510021-8c55-455b-894f-6b7656f8b8d4@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 18:11:56 -0800
Message-ID: <CAADnVQJXn2SezUefQQ_k=HLg2ZS7_G_q1sicXJvQxYG-BNa_zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: Only call maybe_wait_bpf_programs()
 when at least one map operation succeeds
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 2:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/8/23 2:23 AM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > There is no need to call maybe_wait_bpf_programs() if all operations in
> > batched update, deletion, or lookup_and_deletion fail. So only call
> > maybe_wait_bpf_programs() if at least one map operation succeeds.
> >
> > Similar with uattr->batch.count which is used to return the number of
> > succeeded map operations to userspace application, use attr->batch.coun=
t
> > to record the number of succeeded map operations in kernel. Sometimes
> > these two number may be different. For example, in
> > __htab_map_lookup_and_delete_batch(do_delete=3Dtrue), it is possible th=
at
> > 10 items in current bucket have been successfully deleted, but copying
> > the deleted keys to userspace application fails, attr->batch.count will
> > be 10 but uattr->batch.count will be 0 instead.
> >
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >   include/linux/bpf.h  | 14 +++++++-------
> >   kernel/bpf/hashtab.c | 20 +++++++++++---------
> >   kernel/bpf/syscall.c | 21 ++++++++++++++-------
> >   3 files changed, 32 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f7aa255c634f..a0c4d696a231 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -81,17 +81,17 @@ struct bpf_map_ops {
> >       int (*map_get_next_key)(struct bpf_map *map, void *key, void *nex=
t_key);
> >       void (*map_release_uref)(struct bpf_map *map);
> >       void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key)=
;
> > -     int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr=
 *attr,
> > +     int (*map_lookup_batch)(struct bpf_map *map, union bpf_attr *attr=
,
> >                               union bpf_attr __user *uattr);
> >       int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
> >                                         void *value, u64 flags);
> >       int (*map_lookup_and_delete_batch)(struct bpf_map *map,
> > -                                        const union bpf_attr *attr,
> > +                                        union bpf_attr *attr,
> >                                          union bpf_attr __user *uattr);
> >       int (*map_update_batch)(struct bpf_map *map, struct file *map_fil=
e,
> > -                             const union bpf_attr *attr,
> > +                             union bpf_attr *attr,
> >                               union bpf_attr __user *uattr);
> > -     int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr=
 *attr,
> > +     int (*map_delete_batch)(struct bpf_map *map, union bpf_attr *attr=
,
> >                               union bpf_attr __user *uattr);
> >
> >       /* funcs callable from userspace and from eBPF programs */
> > @@ -2095,13 +2095,13 @@ void bpf_map_area_free(void *base);
> >   bool bpf_map_write_active(const struct bpf_map *map);
> >   void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr=
);
> >   int  generic_map_lookup_batch(struct bpf_map *map,
> > -                           const union bpf_attr *attr,
> > +                           union bpf_attr *attr,
> >                             union bpf_attr __user *uattr);
> >   int  generic_map_update_batch(struct bpf_map *map, struct file *map_f=
ile,
> > -                           const union bpf_attr *attr,
> > +                           union bpf_attr *attr,
> >                             union bpf_attr __user *uattr);
> >   int  generic_map_delete_batch(struct bpf_map *map,
> > -                           const union bpf_attr *attr,
> > +                           union bpf_attr *attr,
> >                             union bpf_attr __user *uattr);
> >   struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
> >   struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 5b9146fa825f..b777bd8d4f8d 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1673,7 +1673,7 @@ static int htab_lru_percpu_map_lookup_and_delete_=
elem(struct bpf_map *map,
> >
> >   static int
> >   __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> > -                                const union bpf_attr *attr,
> > +                                union bpf_attr *attr,
> >                                  union bpf_attr __user *uattr,
> >                                  bool do_delete, bool is_lru_map,
> >                                  bool is_percpu)
> > @@ -1708,6 +1708,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
> >       if (!max_count)
> >               return 0;
> >
> > +     attr->batch.count =3D 0;
> >       if (put_user(0, &uattr->batch.count))
> >               return -EFAULT;
> >
> > @@ -1845,6 +1846,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
> >               }
> >               dst_key +=3D key_size;
> >               dst_val +=3D value_size;
> > +             attr->batch.count++;
> >       }
> >
> >       htab_unlock_bucket(htab, b, batch, flags);
>
> [...]
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index efda2353a7d5..d2641e51a1a7 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1695,7 +1695,7 @@ static int map_get_next_key(union bpf_attr *attr)
> >   }
> >
> >   int generic_map_delete_batch(struct bpf_map *map,
> > -                          const union bpf_attr *attr,
> > +                          union bpf_attr *attr,
> >                            union bpf_attr __user *uattr)
> >   {
> >       void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> > @@ -1715,6 +1715,7 @@ int generic_map_delete_batch(struct bpf_map *map,
> >       if (!max_count)
> >               return 0;
> >
> > +     attr->batch.count =3D 0;
> >       if (put_user(0, &uattr->batch.count))
> >               return -EFAULT;
> >
> > @@ -1742,6 +1743,8 @@ int generic_map_delete_batch(struct bpf_map *map,
> >                       break;
> >               cond_resched();
> >       }
> > +
> > +     attr->batch.count =3D cp;
> >       if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
> >               err =3D -EFAULT;
> >
> > @@ -1751,7 +1754,7 @@ int generic_map_delete_batch(struct bpf_map *map,
> >   }
> >
> >   int generic_map_update_batch(struct bpf_map *map, struct file *map_fi=
le,
> > -                          const union bpf_attr *attr,
> > +                          union bpf_attr *attr,
> >                            union bpf_attr __user *uattr)
> >   {
> >       void __user *values =3D u64_to_user_ptr(attr->batch.values);
> > @@ -1774,6 +1777,7 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
> >       if (!max_count)
> >               return 0;
> >
> > +     attr->batch.count =3D 0;
> >       if (put_user(0, &uattr->batch.count))
> >               return -EFAULT;
> >
> > @@ -1802,6 +1806,7 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
> >               cond_resched();
> >       }
> >
> > +     attr->batch.count =3D cp;
> >       if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
> >               err =3D -EFAULT;
> >
> > @@ -1813,9 +1818,8 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
> >
> >   #define MAP_LOOKUP_RETRIES 3
> >
> > -int generic_map_lookup_batch(struct bpf_map *map,
> > -                                 const union bpf_attr *attr,
> > -                                 union bpf_attr __user *uattr)
> > +int generic_map_lookup_batch(struct bpf_map *map, union bpf_attr *attr=
,
> > +                          union bpf_attr __user *uattr)
> >   {
> >       void __user *uobatch =3D u64_to_user_ptr(attr->batch.out_batch);
> >       void __user *ubatch =3D u64_to_user_ptr(attr->batch.in_batch);
> > @@ -1838,6 +1842,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >       if (!max_count)
> >               return 0;
> >
> > +     attr->batch.count =3D 0;
> >       if (put_user(0, &uattr->batch.count))
> >               return -EFAULT;
> >
> > @@ -1903,6 +1908,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >       if (err =3D=3D -EFAULT)
> >               goto free_buf;
> >
> > +     attr->batch.count =3D cp;
>
> You don't need to change generic_map_lookup_batch() here. It won't trigge=
r
> maybe_wait_bpf_programs().
>
> >       if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
> >                   (cp && copy_to_user(uobatch, prev_key, map->key_size)=
)))
> >               err =3D -EFAULT;
> > @@ -4926,7 +4932,7 @@ static int bpf_task_fd_query(const union bpf_attr=
 *attr,
> >               err =3D fn(__VA_ARGS__);          \
> >       } while (0)
> >
> > -static int bpf_map_do_batch(const union bpf_attr *attr,
> > +static int bpf_map_do_batch(union bpf_attr *attr,
> >                           union bpf_attr __user *uattr,
> >                           int cmd)
> >   {
> > @@ -4966,7 +4972,8 @@ static int bpf_map_do_batch(const union bpf_attr =
*attr,
> >               BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr=
);
> >   err_put:
> >       if (has_write) {
> > -             maybe_wait_bpf_programs(map);
> > +             if (attr->batch.count)
> > +                     maybe_wait_bpf_programs(map);
>
> Your code logic sounds correct but I feel you are optimizing for extreme
> corner cases. In really esp production environment, a fault with somethin=
g
> like copy_to_user() should be extremely rare. So in my opinion, this opti=
mization
> is not needed.

+1
the code is fine as-is.

