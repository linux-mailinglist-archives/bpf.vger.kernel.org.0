Return-Path: <bpf+bounces-66603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAFB37508
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 00:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE92A817F
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D271286422;
	Tue, 26 Aug 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlBETZRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2F30CDB4
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248643; cv=none; b=pov6AHWxmjflyz7Hf9IIfYUEsmDeGKrtRtN18TYzjI+9smIqGeYiBwr9wGxBduQ226DyGEEzAW4QwTaAOJt4xUhUMkDjC2LPCJFxIVBz/wKrQPBXYB23m3fP1QLletLLg3Q8pyC7HUHr19L3cfeXON17YQPTz7s8Dtg24DSIdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248643; c=relaxed/simple;
	bh=x4Z/MNZBt8pE0UVLfffWJIO5ftTtu9TKw7ROB+5OjUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMjOMWZFlqG5v7CyHSNNCl4QNgis4AuLxmYshbd/i9ftnxUA9I9idetYAMLPCMj6ww1WVq1/fIey15awkw9DUZKmGwaLB3t63v6YEyWOji7m53mWW2k1Gqd7i5KdqSB7xU6cwK0pwBRizA+U/o0XjuY1ZwYsrMyF2yfaiyPOH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlBETZRU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3256986ca60so3875324a91.1
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756248641; x=1756853441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvufJfIrQIUSEjFqSH9XKLj1HoabUiTxKvUW7VEO5og=;
        b=YlBETZRU4kQ0i5hX7C7wcstcKo8oFYYjlIQJvkEZunu9ExLBTe/yQzsb5Bqmzj3kbJ
         YY7UCDgYqWt/d7t3v6dtttWm3voKbDfIYzN9ADePxG01lXIS5LH1P/aljzWoKqFjYn3a
         mX/ZtWJaqRyXAsY1xN/fdxFgpMZjP41Z0jjnn1ub4iCPBgYWcJOwWIy7Wv63eDwSlEBN
         x+657sq6ckHU61qA9ZDtqF2u3TpeZcmlx8XtK8uLGETp7yiHqEQbcW1U8aigVCz5dJNk
         eVHAzjb7YR+KFASTB3bzcnvxj8clrLI8yQBVL2sEocHQaga6raa5Jk7fqX2f9R76onxx
         dyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756248641; x=1756853441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvufJfIrQIUSEjFqSH9XKLj1HoabUiTxKvUW7VEO5og=;
        b=cEAmTbJ2PsjTiPBOvBgm5DeErwIsf/Kk4VJz2xaMs3n0rGy76dbSktuhvfE8Wz41lR
         3KKTBjKLBXVjoXtto9+uI+IoZ/GkvSzx07ysWSPJCEgAGx1WdfGCpv59K+POt6e130ce
         O/Png9IUtwqdYkgV6N1gUGbDBWinCWl5cMwrFl6poHTUtKrlPgS3KbepW1hQGefJD+wW
         9GVnKJt2B1qgIX2Xk+nHOKgcrSXWHnAQGLN+lSndT+RWA0j0qp6PAhdjS7bdgKkaNVPe
         rQpbd+sqJMOPBg/R6MKDjh+FKeH+VC7N/EWgCdkHs+nIX6+WhHbbMuonUn5/c9I7XtZA
         51cw==
X-Gm-Message-State: AOJu0YxN9jwi2OkaCEfcvPqhXyhvlbZdaFofZkj8PoLvNb/4c7LeR4MT
	S/+EZkKTGCMLZIfSz0gOBemnn0QJaM0dN2cQ+fNTeoxwTebUi4l4xvuPntX7dtCTUMS/rPFNbP+
	nqWwan25tvPl0S3JU/4GgQkMq20lLCCM=
X-Gm-Gg: ASbGnctD8tvGevLiacCDec16DhddUW8n4xAKXbYlORyo3nYzPnPI/x+1MNlZFTvxvaZ
	/+JHl4gFHjbGKesFOny6MPybshWgyTBknfNNph2CscBkJYTQKnjmSp63bDF5B5THk6wQTWXz9Qm
	7UkQe6rIOVM/feFo9qkHzDlqWzWbHGrxpPfpfp5JYgdvXRhc0dhiZGzUvAi+l/coNZqKYznzX5C
	tE95rwVEwcZW4cxfrZ2u3d8dTlqu4OYmA==
X-Google-Smtp-Source: AGHT+IEQSi7m4g0JmE69p6Z9YWwkt4VUVn9XW8CkIqMY6WaiOIJI6nthZrWEWlDfd+a4+q64BBCzJAMO3D/SEivNG+c=
X-Received: by 2002:a17:90b:1d06:b0:321:2f06:d3ab with SMTP id
 98e67ed59e1d1-32515eab619mr22807108a91.21.1756248640733; Tue, 26 Aug 2025
 15:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821160817.70285-1-leon.hwang@linux.dev> <20250821160817.70285-6-leon.hwang@linux.dev>
 <CAEf4BzbcAnmHd42gVXJHPJWczYPQ3Vq6t9E+VT-m7UNLzLmidQ@mail.gmail.com> <DCCGXF27DYLC.1J21FLM3YZZ1A@linux.dev>
In-Reply-To: <DCCGXF27DYLC.1J21FLM3YZZ1A@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Aug 2025 15:50:26 -0700
X-Gm-Features: Ac12FXwP_vXY4e1Y6_qiIpVw_tfIA1CfXy7h5G680PCHoZow07ArBguIUcSfBNs
Message-ID: <CAEf4BzaxYceShq6fV2V5sf9+dEBt_gQM75R0DwYcV2GHGxgEQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] libbpf: Support BPF_F_CPU for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, olsajiri@gmail.com, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:35=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Sat Aug 23, 2025 at 6:20 AM +08, Andrii Nakryiko wrote:
> > On Thu, Aug 21, 2025 at 9:09=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
>
> [...]
>
> >> @@ -10630,6 +10630,19 @@ static int validate_map_op(const struct bpf_m=
ap *map, size_t key_sz,
> >>                 int num_cpu =3D libbpf_num_possible_cpus();
> >>                 size_t elem_sz =3D roundup(map->def.value_size, 8);
> >>
> >> +               if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
> >> +                       if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_=
CPUS))
> >> +                               return -EINVAL;
> >> +                       if ((flags >> 32) >=3D num_cpu)
> >> +                               return -ERANGE;
> >
> > The idea of validate_map_op() is to make it easier for users to
> > understand what's wrong with how they deal with the map, rather than
> > just getting indiscriminate -EINVAL from the kernel.
> >
> > Point being: add human-readable pr_warn() explanations for all the new
> > conditions you are detecting, otherwise it's just meaningless.
> >
>
> Ack.
>
> I'll add these pr_warn() explanations in next revision.
>
> >> +                       if (value_sz !=3D elem_sz) {
> >> +                               pr_warn("map '%s': unexpected value si=
ze %zu provided for per-CPU map, expected %zu\n",
> >> +                                       map->name, value_sz, elem_sz);
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       break;
> >> +               }
> >> +
> >>                 if (value_sz !=3D num_cpu * elem_sz) {
> >>                         pr_warn("map '%s': unexpected value size %zu p=
rovided for per-CPU map, expected %d * %zu =3D %zd\n",
> >>                                 map->name, value_sz, num_cpu, elem_sz,=
 num_cpu * elem_sz);
> >> @@ -10654,7 +10667,7 @@ int bpf_map__lookup_elem(const struct bpf_map =
*map,
> >>  {
> >>         int err;
> >>
> >> -       err =3D validate_map_op(map, key_sz, value_sz, true);
> >> +       err =3D validate_map_op(map, key_sz, value_sz, true, flags);
> >>         if (err)
> >>                 return libbpf_err(err);
> >>
> >> @@ -10667,7 +10680,7 @@ int bpf_map__update_elem(const struct bpf_map =
*map,
> >>  {
> >>         int err;
> >>
> >> -       err =3D validate_map_op(map, key_sz, value_sz, true);
> >> +       err =3D validate_map_op(map, key_sz, value_sz, true, flags);
> >>         if (err)
> >>                 return libbpf_err(err);
> >>
> >> @@ -10679,7 +10692,7 @@ int bpf_map__delete_elem(const struct bpf_map =
*map,
> >>  {
> >>         int err;
> >>
> >> -       err =3D validate_map_op(map, key_sz, 0, false /* check_value_s=
z */);
> >> +       err =3D validate_map_op(map, key_sz, 0, false /* check_value_s=
z */, 0);
> >
> > hard-coded 0 instead of flags, why?
> >
>
> It should be flags.
>
> However, delete op does not support the introduced cpu flags.
>
> I think it's OK to use 0 here.
>
> >>         if (err)
> >>                 return libbpf_err(err);
> >>
> >> @@ -10692,7 +10705,7 @@ int bpf_map__lookup_and_delete_elem(const stru=
ct bpf_map *map,
> >>  {
> >>         int err;
> >>
> >> -       err =3D validate_map_op(map, key_sz, value_sz, true);
> >> +       err =3D validate_map_op(map, key_sz, value_sz, true, 0);
> >
> > same about flags
> >
>
> Ack.
>
> >>         if (err)
> >>                 return libbpf_err(err);
> >>
> >> @@ -10704,7 +10717,7 @@ int bpf_map__get_next_key(const struct bpf_map=
 *map,
> >>  {
> >>         int err;
> >>
> >> -       err =3D validate_map_op(map, key_sz, 0, false /* check_value_s=
z */);
> >> +       err =3D validate_map_op(map, key_sz, 0, false /* check_value_s=
z */, 0);
> >>         if (err)
> >>                 return libbpf_err(err);
> >>
> >> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> >> index 2e91148d9b44d..6a972a8d060c3 100644
> >> --- a/tools/lib/bpf/libbpf.h
> >> +++ b/tools/lib/bpf/libbpf.h
> >> @@ -1196,12 +1196,13 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(=
struct bpf_map *map);
> >>   * @param key_sz size in bytes of key data, needs to match BPF map de=
finition's **key_size**
> >>   * @param value pointer to memory in which looked up value will be st=
ored
> >>   * @param value_sz size in byte of value data memory; it has to match=
 BPF map
> >> - * definition's **value_size**. For per-CPU BPF maps value size has t=
o be
> >> - * a product of BPF map value size and number of possible CPUs in the=
 system
> >> - * (could be fetched with **libbpf_num_possible_cpus()**). Note also =
that for
> >> - * per-CPU values value size has to be aligned up to closest 8 bytes =
for
> >> - * alignment reasons, so expected size is: `round_up(value_size, 8)
> >> - * * libbpf_num_possible_cpus()`.
> >> + * definition's **value_size**. For per-CPU BPF maps, value size can =
be
> >> + * definition's **value_size** if **BPF_F_CPU** or **BPF_F_ALL_CPUS**=
 is
> >> + * specified in **flags**, otherwise a product of BPF map value size =
and number
> >> + * of possible CPUs in the system (could be fetched with
> >> + * **libbpf_num_possible_cpus()**). Note else that for per-CPU values=
 value
> >> + * size has to be aligned up to closest 8 bytes for alignment reasons=
, so
> >
> > nit: aligned up for alignment reasons... drop "for alignment reasons", =
I guess?
> >
>
> It is "for alignment reasons", because percpu maps use bpf_long_memcpy()
> to copy data.
>

my complaint is just wording, if you say "aligned up" it implies that
there is some alignment reason. So I'd just say "size has to be
aligned up to 8 bytes." and be done with it

> static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
> {
>         const long *lsrc =3D src;
>         long *ldst =3D dst;
>
>         size /=3D sizeof(long);
>         while (size--)
>                 data_race(*ldst++ =3D *lsrc++);
> }
>
> Thanks,
> Leon
>
> [...]

