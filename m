Return-Path: <bpf+bounces-60331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D6AD598B
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDBB17E95C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC01B4F1F;
	Wed, 11 Jun 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUEtUsMY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2491ADFFB;
	Wed, 11 Jun 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654284; cv=none; b=cnVgyfut4xTkrgZJd3qA7Fn6NoEoQB296vKbnJ9IumfYQXaRQ+wz+YW0GxlBtlxWkvSgCG8ovYoC1WNmTXCKqgY3/qW5Y6Kh5KSnohI5SFwZjZe7aHrqaUPBFJcwtF30hML1qG9cYhUjSrZZSO1bz/e9o79dGKI24SmqFG54MF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654284; c=relaxed/simple;
	bh=wCdTYRWpCahjIsqcoraZdokvJ/dzGrBWyCkh+Nxso44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJs2D5ltnYWuRt2XyizAjUowmXUSwBHLQQFnIROaw89hOlzchjav5wVHa2kbaM2Ic0ohoqb5FLP6wKg8XU/UImAnxZmcDzwjhptVD86jEiGltY7noXCF0A5axPgpe1qp2O2sJ/9yhfBrorHxvOILATSwYGdogttnpESod+5Z1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUEtUsMY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a53ee6fcd5so2517325f8f.1;
        Wed, 11 Jun 2025 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749654281; x=1750259081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJVpdQmzOms9l4a11tO5AbxujAROVkXSwTeecd0Po/c=;
        b=GUEtUsMYP0hrQYaFoEgHqHdAlz6HKb85K1BI4Q6DVcpvS1/M8H7DAGXsqbN8Y6AiTI
         k9DHOemYwz9E4boklss1WPzAl4G9kTg8hcE4ZlbDpVqTsHBW17PpiG7emIFHfFHVJCbe
         Wesvx5wMMLIr2VbjvwY/u9mLDh/Ezo3NbowRrEFWlTXTbiWsqfXcgfrpmyoySgqg6UvR
         2DVqgIo+rOwIfZm0Q4awSyhCDFlRDYZkzCosVo088/44ZZhVxTHsYoqW6wM3kB0ZptlH
         /e4qXpU6LyIcXa8iZdnSfM9WsXOkiLfGiF1Jdcg9eFX474tK/34EadfLvbfZBlMxiSK+
         ZBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654281; x=1750259081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJVpdQmzOms9l4a11tO5AbxujAROVkXSwTeecd0Po/c=;
        b=rop7ZOHYwOpefaOcVG06nuXJQOM/LzR+iYlRhF9yYDeHe17r9W7Obwg945BXChTxbz
         HcPExPD3i9ZYcW9RKgapxYX6Xa0SzKLQUYfKJLfKcY/mLw/6K82fAWQyclzxaVtul6Qs
         rgryAiXxfRMzp7+hpSy/hsiHt/6RDegjLSfoud+uGdwZpmqtngB+09Yeq61W/eiz6RGK
         kd04R1olrT9IG20FINKxQtkDqzKSTqb6JTeFAWSKo7PiUF1DMKDW6CjMFIinslGSmNw2
         4KyHHua07ScaMTIoxcthWHNkVMACjgauMoT9hdfbczlKteIQxbeZfqW1v0NPbah+IdRf
         x6/A==
X-Forwarded-Encrypted: i=1; AJvYcCX/7XVX4zv0iXU9qdIqd+8qali89lQIbUxSV+a5KdLyrL1QZnzpG6mzKm9V11XF8YKR/xFZ10Urh6LVZSrzapg6ublGxec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnm1sm1lZlpQLp90VBICQcLfCU30rrh5Ru7cNSfEs+ajDr97xU
	VtI1HuGPOk4yMHy24raYa9c8sHep/PYCLi7936QDLBlf8/xJRzvKpGgbHQN6L2K5mQmU9UVJEL+
	T4sJq4acgpYOV1kWGmA86hh+hxy/QCGWCJQ==
X-Gm-Gg: ASbGnctIUjPS3N+n2gA87ONwRJP7ZAawvzklqjMBUu7U7Mxdjb+npLht4XFOotIXQdN
	PMuZW5MwKDAxiH9CHJxdiMlDfx5KHUDjU4e3FPDYdZhActRDP1mGA7ujF0dYYQDEU9ZK7iFsFpO
	I17PbGJwa7MlAYNNIVedFuaDN6U/hwB65PHAVbXPgaiCON8tR1ii4ewKVBe106L8S+rvWVFwh7
X-Google-Smtp-Source: AGHT+IHBn5+0LGgyVrYZhgzWDo92zhGJRYc/dUG2SDjx5YVtS9COoMd6GZucqacIqskiySmaEz+0NC8uksN9F9aC3xk=
X-Received: by 2002:a05:6000:2088:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3a558afec9cmr2509421f8f.45.1749654279251; Wed, 11 Jun 2025
 08:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-8-kpsingh@kernel.org>
 <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com> <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com>
In-Reply-To: <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 08:04:28 -0700
X-Gm-Features: AX0GCFuYEml8R879TFDM6N1Ru6jvNrO8OhLliHxrGcakpporZz3qvpB220-HUPU
Message-ID: <CAADnVQLmrbOFbJZAdx3auye8YVwVJvMM4qp0L_-mFyD4xDedUA@mail.gmail.com>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:27=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Mon, Jun 9, 2025 at 11:30=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
>
> [...]
>
> > >
> > > +       if (map->ops->map_get_hash && map->frozen && map->excl_prog_s=
ha) {
> > > +               err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZ=
E, &map->sha);
> >
> > & in &map->sha looks suspicious. Should be just map->sha ?
>
> yep, fixed.
>
> >
> > > +               if (err !=3D 0)
> > > +                       return err;
> > > +       }
> > > +
> > > +       if (info.hash) {
> > > +               char __user *uhash =3D u64_to_user_ptr(info.hash);
> > > +
> > > +               if (!map->ops->map_get_hash)
> > > +                       return -EINVAL;
> > > +
> > > +               if (info.hash_size < SHA256_DIGEST_SIZE)
> >
> > Similar to prog let's =3D=3D here?
>
> Thanks, yeah agreed.
>
> >
> > > +                       return -EINVAL;
> > > +
> > > +               info.hash_size  =3D SHA256_DIGEST_SIZE;
> > > +
> > > +               if (map->excl_prog_sha && map->frozen) {
> > > +                       if (copy_to_user(uhash, map->sha, SHA256_DIGE=
ST_SIZE) !=3D
> > > +                           0)
> > > +                               return -EFAULT;
> >
> > I would drop above and keep below part only.
> >
> > > +               } else {
> > > +                       u8 sha[SHA256_DIGEST_SIZE];
> > > +
> > > +                       err =3D map->ops->map_get_hash(map, SHA256_DI=
GEST_SIZE,
> > > +                                                    sha);
> >
> > Here the kernel can write into map->sha and then copy it to uhash.
> > I think the concern was to disallow 2nd map_get_hash on exclusive
> > and frozen map, right?
> > But I think that won't be an issue for signed lskel loader.
> > Since the map is frozen the user space cannot modify it.
> > Since the map is exclusive another bpf prog cannot modify it.
> > If user space calls map_get_hash 2nd time the sha will be
> > exactly the same until loader prog writes into the map.
> > So I see no harm generalizing this bit of code.
> > I don't have a particular use case in mind,
> > but it seems fine to allow user space to recompute sha
> > of exclusive and frozen map.
> > The loader will check the sha of its map as the very first operation,
> > so if user space did two map_get_hash() it just wasted cpu cycles.
> > If user space is calling map_get_hash() while loader prog
> > reads and writes into it the map->sha will change, but
> > it doesn't matter to the loader program anymore.
> >
> > Also I wouldn't special case the !info.hash case for exclusive maps.
> > It seems cleaner to waste few bytes on stack in
> > skel_obj_get_info_by_fd() later in patch 9.
> > Let it point to valid u8 sha[] on stack.
> > The skel won't use it, but this way we can kernel behavior
> > consistent.
> > if info.hash !=3D NULL -> compute sha, update map->sha, copy to user sp=
ace.
>
> Here's what I updated it to:
>
>     if (info.hash) {
>         char __user *uhash =3D u64_to_user_ptr(info.hash);
>
>         if (!map->ops->map_get_hash)
>             return -EINVAL;
>
>         if (info.hash_size !=3D SHA256_DIGEST_SIZE)
>             return -EINVAL;
>
>         if (!map->excl_prog_sha || !map->frozen)
>             return -EINVAL;
>
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          I think we still need this check as we want the program to
> have exclusive control over the map when the hash is being calculated
> right?

Why add such a restriction?
Whether it's frozen or exclusive or both it still races with map_get_hash.
It's up to the user to make sure that the computed hash
will be meaningful.
I would allow for all maps.
The callback will work for arrays initially, but that
can be improved in the future.

>         err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha)=
;
>         if (err !=3D 0)
>             return err;
>
>         if (copy_to_user(uhash, map->sha, SHA256_DIGEST_SIZE) !=3D 0)
>             return -EFAULT;
>     } else if (info.hash_size) {
>         return -EINVAL;
>     }

yep.

