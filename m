Return-Path: <bpf+bounces-67491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62883B445AD
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E45546CF1
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18051D8E1A;
	Thu,  4 Sep 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxUiF6Yw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51132F772
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011537; cv=none; b=gvgMZN6ZZwfeIPuRPY2JWqRni6v4FTvYzzKX134RiNm3sRuHKrunu/LoTy5e0XWy4zIbGEEV9auaW7T5OSxTILmuNury07ul7va2VeGvIQVdJXVEhqDO6KB273uX94iB1qIjXulOoljguLIAihofk6Lhv+nmWijt+AzxN/AoWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011537; c=relaxed/simple;
	bh=GqDGpmjKZBh+hH/IZORqu8MaFn6+HLhryvvTy2xBbfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjMySeOxd5tUBp/jIDIinQ9xakuoujR+rKu7A9XbGOWzQzRz4AVjhtqa9OxV7icxhWgdX+x11TbOGJNFei0GIdRieb3s+mS2OkI8QyFLVhO2flK8HcvMRAGgIOfXosVxuAUx9FZSOea2Hq1Fqu8zufJjWlBgyNYAB6UuOmRLqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxUiF6Yw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329b760080fso1367165a91.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757011535; x=1757616335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKlLvjU+9xhGbIejp89zIIHgcgOSrQCeGC6DSyYCjIQ=;
        b=TxUiF6YwA6BFx4t4J0M6h5CKtIdPWrqDXIsZ9FGo8ujSi8oK5RpID2FOz9sVhb3K1A
         DE8NMENz6Ob9y52T07ZHdUncq8tCqSyc+SX3lsO89HHjS07yZi2nk/fjkd9gfZA90fEf
         7oJ2ZgRVwcTa+2CZzlNR7fiMWd7V/CBbXjFu6beERafWCEiDQ3LpXdekD0IMSRXs4xXE
         +Un5J6L9RYRnCJznqUuK8z8wqzw7kn/1Y2PnLjfb0xNDB/jBmyrM73FDL+gLQKJcuBtQ
         sZsdpdWn7eaST3lZju1Z9o38udOk0bUXK3jmfP2uX79uuXgsGk1SFiGepDxxAYgmytyB
         9nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757011535; x=1757616335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKlLvjU+9xhGbIejp89zIIHgcgOSrQCeGC6DSyYCjIQ=;
        b=YYLLKsevwUZIlFeVBbzBm5TNdkVmqZFjz8gZ2gn+6IKNq4uzBi0vjJha9TmI8k9Ux4
         osqGX53TEj+HF2sCXDj7NmEsJqMLLA35m8xaBmt7nNxAO8SrqcA43mbo/gp1IZLQn3bT
         pBRkOIAJ7cr3QPHR46mpoMLtWwIdAie01jDE8YbuiUdeU13XJLTA1ZkB4o0eVREk3IEt
         lPNNijs6O95Qd+YEyaqaM35u7/ndztQUE40ulObcbUZuhfZdtsd0ehDPOnAvZOKpqf0h
         vuG88EJjaIo4zQWzBFTdcOt9UeYepU+kfpxNFZYgwqjCnVoPcNlch0bxRqBVwOqi5NEL
         Iglg==
X-Forwarded-Encrypted: i=1; AJvYcCVcb+C61cyry526SdLzFjBxs4MdR1VY3QwjMUazMOwqVvhrlx5S+9vjNp326Eadg2W44ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu47v3B7zkC7oB4G03ZYzB9FvaTqIxdQrzq3wD+HD5VvSidnJB
	rH33qXUFVk5jW5mk6DhJUNT3d1/BCQrbHiU+rOswQ3+e+PJatmg7KXpi+cg3OcMPyZPxAp1Li9G
	Vy0feKFQSHY+mWNYZaBqkUsttCOKRTns=
X-Gm-Gg: ASbGncvQzJ4BJTb+cWn9cQo/6ME36gq8Xz3RyPqGIJ9YEAkyi7529yIj3S1/bwnO6ho
	tgWQczw9tZnKjuBg0JEw9HG/VFux7RQRu/Qr+VhVJTbYYsTP0/85wvKDxwtQOJSt+6R5d6jbJt7
	yNBL5dMIhjW6HiZALn/2sxYYqQ3NnNb2TSRa/ZES1FqmJNlSbyYcdeWIBlyPjdcf3WsLp5HHdij
	k9x4Ho1fXMkD4l6zaRUF8168Z/IHUzpsA==
X-Google-Smtp-Source: AGHT+IEDe5l4GoMx82bMExF6mRfDJMGqq8rjZVIJU7GEB3+2rFvss+temmxUft13JrBrxTvBX5lfCU+87Y7oNoDQm30=
X-Received: by 2002:a17:90b:3809:b0:329:dff0:701b with SMTP id
 98e67ed59e1d1-329dff070c6mr16959277a91.17.1757011534877; Thu, 04 Sep 2025
 11:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903170411.69188-1-leon.hwang@linux.dev> <CAADnVQL-Zj95bfOxkxc2tf9CKvUSCt4PKdoQMZtqaiirzPLxvw@mail.gmail.com>
 <CAEf4BzYmX9RfOwArEAa+XW+uVzqUUy-5gjenog+ZvDjxGa80SQ@mail.gmail.com> <dfe41b0d-c73a-433b-99fe-db05dbe1c0f1@linux.dev>
In-Reply-To: <dfe41b0d-c73a-433b-99fe-db05dbe1c0f1@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Sep 2025 11:45:20 -0700
X-Gm-Features: Ac12FXx_g5_q0Mn5C5CXY37C78F_MfZhL2N5Xh_2LsCtyD0-k-1iRAfpMwoit40
Message-ID: <CAEf4BzY=LRibrtnjvQ6P99a-u+LffRqBzEWynRn25LZNN=PbDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Generalize data copying for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:34=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 4/9/25 07:39, Andrii Nakryiko wrote:
> > On Wed, Sep 3, 2025 at 10:36=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Wed, Sep 3, 2025 at 10:04=E2=80=AFAM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>>
> >>> While adding support for the BPF_F_CPU and BPF_F_ALL_CPUS flags, the =
data
> >>> copying logic of the following percpu map types needs to be updated:
> >>>
> >>> * percpu_array
> >>> * percpu_hash
> >>> * lru_percpu_hash
> >>> * percpu_cgroup_storage
> >>>
> >>> Following Andrii=E2=80=99s suggestion[0], this patch refactors the da=
ta copying
> >
> > as flattering as that is, "Andrii's suggestion" is no justification
> > why the patch is correct :)
> >
>
> :)
>
> >>> logic by introducing two helpers:
> >>>
> >>> * `bpf_percpu_copy_to_user()`
> >>> * `bpf_percpu_copy_from_user()`
> >>>
> >>> This prepares the codebase for the upcoming CPU flag support.
> >>>
> >>> [0] https://lore.kernel.org/bpf/20250827164509.7401-1-leon.hwang@linu=
x.dev/
> >>>
> >>> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >>> ---
> >>>  include/linux/bpf.h        | 29 ++++++++++++++++++++++++++++-
> >>>  kernel/bpf/arraymap.c      | 14 ++------------
> >>>  kernel/bpf/hashtab.c       | 20 +++-----------------
> >>>  kernel/bpf/local_storage.c | 18 ++++++------------
> >>>  4 files changed, 39 insertions(+), 42 deletions(-)
> >>>
> >>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>> index 8f6e87f0f3a89..2dc0299a2da50 100644
> >>> --- a/include/linux/bpf.h
> >>> +++ b/include/linux/bpf.h
> >>> @@ -547,6 +547,34 @@ static inline void copy_map_value_long(struct bp=
f_map *map, void *dst, void *src
> >>>         bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
> >>>  }
> >>>
> >>> +#ifdef CONFIG_BPF_SYSCALL
> >>> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void=
 __percpu *pptr, void *value,
> >>> +                                          u32 size)
> >>> +{
> >>> +       int cpu, off =3D 0;
> >>> +
> >>> +       for_each_possible_cpu(cpu) {
> >>> +               copy_map_value_long(map, value + off, per_cpu_ptr(ppt=
r, cpu));
> >>> +               check_and_init_map_value(map, value + off);
> >
> > I still maintain that this makes zero sense... value+off is memory
> > that we'll copy_to_user, why are we setting refcount to 1, or
> > rb_node/list_node to "proper empty node" is absolutely not clear... it
> > feels like we can drop check_and_init_map_value() altogether and be
> > absolutely no worse. If anything, memset(0) would be nicer, but I
> > guess we didn't have it to begin with, so no need to add it now.
> >
>
> Agreed.
>
> As 'copy_map_value_long()' won't copy those fields,
> 'check_and_init_map_value()' is unnecessary here.
>
> >>> +               off +=3D size;
> >>> +       }
> >>> +}
> >>> +
> >>> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> >>> +
> >>> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, vo=
id __percpu *pptr, void *value,
> >>> +                                            u32 size)
> >>> +{
> >>> +       int cpu, off =3D 0;
> >>> +
> >>> +       for_each_possible_cpu(cpu) {
> >>> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), valu=
e + off);
> >
> > copy_map_value_long is generalization of bpf_long_memcpy, and so it
> > would be good to call this out to explain why your refactoring is
> > correct
> >
>
> No.
>
> It shouldn't call bpf_long_memcpy() before bpf_obj_free_fields(), or it
> will overwrite those fields data used for bpf_obj_free_fields().

I'm not exactly following what you are trying to say here. I didn't
propose to replace copy_map_value_long() with bpf_long_memcpy().
bpf_long_memcpy() works only for those maps where we don't enable
those special bpf_spinlock and other fields. copy_map_value_long() is
a generalization of copying user-provided data into the map, skipping
all those special fields.

Again, confused a bit here, sorry.

>
> It would be better to call bpf_obj_free_fields() then bpf_long_memcpy().

I agree, but not sure it makes any practical difference.

>
> >>> +               bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cp=
u));
> >>> +               off +=3D size;
> >>> +       }
> >>> +}
> >>> +#endif
> >>> +
> >>>  static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, =
void *dst, void *src)
> >>>  {
> >>>         unsigned long *src_uptr, *dst_uptr;
> >>> @@ -2417,7 +2445,6 @@ struct btf_record *btf_record_dup(const struct =
btf_record *rec);
> >>>  bool btf_record_equal(const struct btf_record *rec_a, const struct b=
tf_record *rec_b);
> >>>  void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
> >>>  void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj)=
;
> >>> -void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> >>>  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool=
 percpu);
> >>>
> >>>  struct bpf_map *bpf_map_get(u32 ufd);
> >>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> >>> index 3d080916faf97..6be9c54604503 100644
> >>> --- a/kernel/bpf/arraymap.c
> >>> +++ b/kernel/bpf/arraymap.c
> >>> @@ -300,7 +300,6 @@ int bpf_percpu_array_copy(struct bpf_map *map, vo=
id *key, void *value)
> >>>         struct bpf_array *array =3D container_of(map, struct bpf_arra=
y, map);
> >>>         u32 index =3D *(u32 *)key;
> >>>         void __percpu *pptr;
> >>> -       int cpu, off =3D 0;
> >>>         u32 size;
> >>>
> >>>         if (unlikely(index >=3D array->map.max_entries))
> >>> @@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, v=
oid *key, void *value)
> >>>         size =3D array->elem_size;
> >>>         rcu_read_lock();
> >>>         pptr =3D array->pptrs[index & array->index_mask];
> >>> -       for_each_possible_cpu(cpu) {
> >>> -               copy_map_value_long(map, value + off, per_cpu_ptr(ppt=
r, cpu));
> >>> -               check_and_init_map_value(map, value + off);
> >>> -               off +=3D size;
> >>> -       }
> >>> +       bpf_percpu_copy_to_user(map, pptr, value, size);
> >>>         rcu_read_unlock();
> >>>         return 0;
> >>>  }
> >>> @@ -387,7 +382,6 @@ int bpf_percpu_array_update(struct bpf_map *map, =
void *key, void *value,
> >>>         struct bpf_array *array =3D container_of(map, struct bpf_arra=
y, map);
> >>>         u32 index =3D *(u32 *)key;
> >>>         void __percpu *pptr;
> >>> -       int cpu, off =3D 0;
> >>>         u32 size;
> >>>
> >>>         if (unlikely(map_flags > BPF_EXIST))
> >>> @@ -411,11 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map,=
 void *key, void *value,
> >>>         size =3D array->elem_size;
> >>>         rcu_read_lock();
> >>>         pptr =3D array->pptrs[index & array->index_mask];
> >>> -       for_each_possible_cpu(cpu) {
> >>> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), valu=
e + off);
> >>> -               bpf_obj_free_fields(array->map.record, per_cpu_ptr(pp=
tr, cpu));
> >>> -               off +=3D size;
> >>> -       }
> >>> +       bpf_percpu_copy_from_user(map, pptr, value, size);
> >>>         rcu_read_unlock();
> >>>         return 0;
> >>>  }
> >>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >>> index 71f9931ac64cd..5f0f3c00dbb74 100644
> >>> --- a/kernel/bpf/hashtab.c
> >>> +++ b/kernel/bpf/hashtab.c
> >>> @@ -944,12 +944,8 @@ static void pcpu_copy_value(struct bpf_htab *hta=
b, void __percpu *pptr,
> >>>                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value)=
;
> >>>         } else {
> >>>                 u32 size =3D round_up(htab->map.value_size, 8);
> >>> -               int off =3D 0, cpu;
> >>>
> >>> -               for_each_possible_cpu(cpu) {
> >>> -                       copy_map_value_long(&htab->map, per_cpu_ptr(p=
ptr, cpu), value + off);
> >>> -                       off +=3D size;
> >>> -               }
> >>> +               bpf_percpu_copy_from_user(&htab->map, pptr, value, si=
ze);
> >>
> >> This is not a refactor. There is a significant change in the logic.
> >> Why is it needed? Bug fix or introducing a bug?
> >
> > this is preparation for that BPF_F_CPU/BPF_F_ALLCPUS, but I agree that
> > it would be better to include as preparatory patch in the actual patch
> > set
> >
>
> Ack.
>
> I'll move this patch into the patch set of BPF_F_CPU/BPF_F_ALLCPUS flags.
>
> >>
> >> The names to_user and from_user are wrong.
> >> There is no user space memory involved.
> >
> > This was my suggestion because we either are copying user-supplied
> > data or copying data back to user. Strictly speaking it's all kernel
> > memory (copy_from_user/copy_to_user is done afterwards by the caller),
> > but that's the intent.
> >
> > Maybe "copy_in" and "copy_out" would be better, I don't know. But
> > there is certainly a direction here w.r.t. user space provided data
> > (note, this is not BPF program-side logic).
> >
>
> 'bpf_percpu_copy_data()' and 'bpf_percpu_update_data()' would be better,
> as "copy_data" is used in those 'bpf_percpu_*_copy()' functions and
> "update_data" is used in those 'bpf_percpu_*_update()' functions.

And I have to keep looking up how "copy_data" is actually used to
remind myself that it's for "lookup" to copy data *to user*, not copy
*from user*. Which is why "copy_in" and "copy_out". But that's ok. My
point is that I don't see copy vs update as a meaningful and clear
distinction.

>
> Thanks,
> Leon
>

