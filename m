Return-Path: <bpf+bounces-70842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DEEBD6B78
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F3D18A80B0
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287C26F467;
	Mon, 13 Oct 2025 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuj4kURb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD7242D90
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397495; cv=none; b=tSi+yZw2Qgkkfpb57mGcfXWHgPrXqXp/NFKQnnWEeRCak6AZp9FW+wYp3R3OfJcVd2uyU7AqGHYiH/LjG5twvueqdlRa6CeLghC3HmWZsyF69zt2vUGrJY1WX3Fj4i0taNH3+Vd5/XwwAuneyIw68SCR6f24vmaOV9oOgk3G1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397495; c=relaxed/simple;
	bh=GCLZffwGz4YBEhQAonwBTNfEf7CYnGocJJWi/jlkvSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpETjpNjTYd4Ibpe7YlhH93dIoqk/Oe1vnOh1XkgNRrqV6bHK+VOlMXnJUNRwkrN197Ka6auX0AdZ0wQ//aBnsOAqtRfMXitvY1nYo4AFiPyAwjTxK2gMCzG6ZZe2maWVn9QSfRtmtt8SccIABonWxJw8HTCa8DeVzsfZJjchpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuj4kURb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so4581395a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760397491; x=1761002291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp1PUmL65nKd6p585F3DbBM0gR/guHowQUXUUR7pexA=;
        b=fuj4kURblrSfnCipJPiRut4Nw4SSKFTk7p7gEEfcH+FrBkMCAxZdrHbx8LmLUqotQX
         6d5rv4GgkVB0OoT6uu5JEUWoU6OvxMEZV/yh4KOb6t4Yc/ULEfrupnoQRTUFwJj0lrw0
         TKtEX958nBu15yh2p+7bnkhwuKHwMcOirvhvm4KVmEVa8rltYOn+kXpmvO/LgO9Dfwbk
         gYDKl7gJzXN16MF+JqvsHqDPTjg2EejknC+aeWHsogFp0dtO3b3qji+3NLkZrttEN4iB
         K219GX3ASOVYmvP9R1sN4eQfv9QDIuwX6aB4IA7p//ErLlW21LszI16EhUCDrnsXPMon
         1NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760397491; x=1761002291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp1PUmL65nKd6p585F3DbBM0gR/guHowQUXUUR7pexA=;
        b=ZMEM87ouKrAmoCMcnKX+nmwpQXTLSW3X6lMs0xvfZ0xBMjXzJNM/PwzL/dxR3noJI5
         uh4M4LU1r+/917fhw5vUcsxhJfuErNghbN3r/yIpNfrDAf8e3yBC/BJjjoIy30czaaV4
         +3yaYFHDUXPCfQF6ytPiyb+i3+CVDKnqwGRIMMyTRLahCB3Fw4isqZLuHT44ZbZNd2C6
         UnWPKgVJi6ZROlKNpxUpvDb+5MzWZT9yBIgJiAYYm9HTxJQnIzIpAdJ5MSDLm3Fwg0gh
         YoqAoJ2aDdRJhd1V+f8DoO2TgSGffi3Woe4jYuFGiTkdNsT78aTgngDr5e9OTfw4+ABv
         a1vQ==
X-Gm-Message-State: AOJu0YzUA2Q1/fvJbqEZ15Pm+m3v3oQ0QgTV9QQKSV0zD/03VkU6XdWc
	aF25ww/rhLYzzwTwOAIUAKW3fovEBTW1MSx/5PP27seoD/s5gGOr/h+hnNPl/G4dhbTIjux13Tp
	6THA6lWhlHc2/NUA7CW0JsOU6RBuj1aU=
X-Gm-Gg: ASbGncvjLfoUmkI4E6Y0R1hkWsHoIaR01tyah+HVkq4pvqwDWfxJdraDmSih1jajfXv
	vfWxYdzzJJ/+/PVCwK0ImRSuIPvBKy+aP4Ln61fXyzm17v/8L1kh53fLXX9QxqtEhBtX5hAnhr0
	yexpbzGUouZu0OOJPg376KGt1R7o8KFfG/77EKTSNV67CtxHF6/JPnyblSF3o2bqZMy4VRvxkJg
	4twm/hXdU3Wu/ZXFF4Qz0bS8uQ9h/qkvXrjRtDbfFAfx0duugug
X-Google-Smtp-Source: AGHT+IFSyuDkZwiQVWc6ScaUaUZBUx2ywYXS4MuRRFzfTRNRmYREdxVaQuhIdLjl0mcJEET59qR+k52ER8ClZ1mKXFo=
X-Received: by 2002:a17:90b:17c2:b0:327:734a:ae7a with SMTP id
 98e67ed59e1d1-33b5114ac35mr34971585a91.11.1760397491124; Mon, 13 Oct 2025
 16:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930153942.41781-1-leon.hwang@linux.dev> <20250930153942.41781-5-leon.hwang@linux.dev>
 <CAEf4Bzb5Md09meboYPvdBUPZP3V2ET0AafbQFi89U8Wa3zVfGw@mail.gmail.com> <f87450f9-f748-428f-8d5e-842cd96303c0@linux.dev>
In-Reply-To: <f87450f9-f748-428f-8d5e-842cd96303c0@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 13 Oct 2025 16:17:57 -0700
X-Gm-Features: AS18NWAZl1mjFOoRQ6pCMQEaYAcf_iXw66Cv1JGuEr4QxmplbedUIhJ5snxPfoA
Message-ID: <CAEf4BzajBGOSPKXhW1r+wyPTrgjOU4AJA3Kdx4h0nuxLOC1PHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:48=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 7/10/25 06:29, Andrii Nakryiko wrote:
> > On Tue, Sep 30, 2025 at 8:40=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_h=
ash
> >> maps to allow updating values for all CPUs with a single value for bot=
h
> >> update_elem and update_batch APIs.
> >>
> >> Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
> >> maps to allow:
> >>
> >> * update value for specified CPU for both update_elem and update_batch
> >> APIs.
> >> * lookup value for specified CPU for both lookup_elem and lookup_batch
> >> APIs.
> >>
> >> The BPF_F_CPU flag is passed via:
> >>
> >> * map_flags along with embedded cpu info.
> >> * elem_flags along with embedded cpu info.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
>
> [...]
>
> >>
> >>                 for_each_possible_cpu(cpu) {
> >> -                       copy_map_value_long(&htab->map, per_cpu_ptr(pp=
tr, cpu), value + off);
> >> -                       off +=3D size;
> >> +                       ptr =3D (map_flags & BPF_F_ALL_CPUS) ? value :=
 value + size * cpu;
> >> +                       memcpy(per_cpu_ptr(pptr, cpu), ptr, size);
> >
> > ok, so you fixed the value_size problem and at the same time
> > introduced blind memcpy() problem?.. Per-CPU maps are allowed to have
> > some special fields (see BPF_REFCOUNT and BPF_KPTR_* checks in
> > map_check_btf()), which have to be handled specially inside
> > copy_map_value[_long](), we cannot just memcpy() blindly
> >
> > all the other places use copy_map_value[_long](), why did you decide
> > to switch to memcpy here?
> >
>
> You=E2=80=99re right =E2=80=94 using memcpy() here is incorrect. I should=
 be using
> copy_map_value() instead.
>
> When comparing this path with bpf_percpu_array_update(), I noticed that
> bpf_obj_free_fields() is missing here. That was why I initially switched
> to memcpy().
>
> To clarify:
>
> 1. If those special fields (like BPF_REFCOUNT or BPF_KPTR_*) are
>    *not* supported here, memcpy() behaves the same as
>    copy_map_value().
>
> static inline void bpf_obj_memcpy(struct btf_record *rec,
>                                   void *dst, void *src, u32 size,
>                                   bool long_memcpy)
> {
>         u32 curr_off =3D 0;
>         int i;
>
>         if (IS_ERR_OR_NULL(rec)) {
>                 if (long_memcpy)
>                         bpf_long_memcpy(dst, src, round_up(size, 8));
>                 else
>                         memcpy(dst, src, size);
>                 return;
>         }
>
>         ...
> }
>
> static inline void copy_map_value(struct bpf_map *map, void *dst, void *s=
rc)
> {
>         bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
> }
>
> 2. However, if those special fields *are* supported here, then missing
>    bpf_obj_free_fields() seems like a real issue.
>    In that case, I=E2=80=99d like to send a separate patch set to add
>    bpf_obj_free_fields() properly.
>    Does that sound reasonable?

Add a test and we'll know for sure? But it looks like yes, you can use
*some* special fields for per-CPU maps.

>
> Thanks,
> Leon
>
> [...]

