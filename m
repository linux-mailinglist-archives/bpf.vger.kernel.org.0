Return-Path: <bpf+bounces-50531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86790A295FE
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21B23A1143
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C8198857;
	Wed,  5 Feb 2025 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="M2wRrb3I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811861FC3
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772132; cv=none; b=UpUYFpZduy8LLOrXIyJ4QBTckG+TtZDHDGcHtJQ5Ry/DqwTTRlni92WGEYgeFXQCaONtbKHEIlIiCd7ubmZsBDhsW70EYk14uBfsKcYhqiFDhegMbcniZNmUTqfeplIpXFTB3tGRJbTiIT6bAXCuO9zYhyj69zAg0LhAGbPLcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772132; c=relaxed/simple;
	bh=yEnDU9Nsl+RnvVIdlSs72iDs/x6pp/kvqtHoKIMFUFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umMi2kMB4Jd9Lq/jY1f0WT6XlZzPPrsUso9BRnSVg9WZmUDUkfwlpCH1xC9c3EVO0Tg6ncdMTxSO5DMIlXcuU+9DRwmMlxKE7gM/y1tVRYlO3Pif/Jsd48ZT16RZiCzAwGeOxzR2XA8YWspXt2HfY1dj4iTNpfSHwk38/Ln4GCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=M2wRrb3I; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dcd3454922so2942353a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738772129; x=1739376929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6id6N2pmQpkkJ430sSw5SctJbHFe83XzEvglmWVJTTk=;
        b=M2wRrb3IFT9GXqq77AWI28h0pvb5AUTffDCT88DoesoQm9TW/9DOH2XkAHZSjWGZBU
         TfjIg0AO4I8EXeUYRtgx4YQ3FydHcoWKGJ/lKZX0ahFWlCh2iK68SdXxidYjz4su9v0j
         4u+KqHp+z9E6XiAp/uYDImdxUSHnuvlpXzsk+cdvryYXxk6fcCkQbiZzA7EzmykdrNh+
         XCTv57NhgY1h2Yi7bVOQPliCSX9DVkh/hABkIR0FmNE4d9Fr5U1fI3mDTqN4SghDFPxI
         Aqwu7+MI2DIC4cqi5NDVh+D82M2OWRNGzx2C764P3O+3cGXZcNAMQY1WPAiSX+f8QH/t
         JYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738772129; x=1739376929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6id6N2pmQpkkJ430sSw5SctJbHFe83XzEvglmWVJTTk=;
        b=w/PcgaMzqlj1at6qOdpVw2oPelWO/ZLoMwKrZ3p9wxdBixTYlL63JcwW9Lh4nOmT38
         m+/s8PegVLHQTZ835LIzSx+B3TVg2LAmX8797+vuMZNd+TeaEGX8s78umLFeeONrGiux
         TInv2WLHjQbfLnh6vlbVyKjrhslBH53jIbYDlV116ie5AegsMjtnBScUt6VFnc9g5mKX
         MmLruawEDrIOjsvNByPaBcgRccmIS1vmUY0AvbBr01ov8i+8bE4uBw64cMjTpft66B1z
         g332zMpkdnHkSY7PEYiaBBZKDFSFGx4dzppbewzGYlYDRuDyR02iDVZyyfQll3MZPouI
         gpfw==
X-Gm-Message-State: AOJu0YztPfzepi9ZHmpNvgSeBUYlqYo7KyPqutY97iYzQn9KoupNLcZr
	hAPW3otYcP+RT+U8ugluLbdnDijYpCeU1rxo6eRT3xNNIu+Y00XhmmnmKgTBfD+tvgG/ZjMUhdO
	BbeHhKbxXTqRfQLylkRo019Gwp5Byx22VpPQcFGgP841NBiye
X-Gm-Gg: ASbGncv1yZsZgCNS2t7HnabeMh+noAUFWCnWlQ2Uz36k/tz1NuJ8ARCxU4BjTChpmk0
	L/EVHSebd6tkpH8F/s8vxOyV+guRWfURtKeE6V/rS1h/zoiepYNF6KHdWV+5qaMztC5qfEqHbZa
	+QS3o5rtkNgCXW+yY=
X-Google-Smtp-Source: AGHT+IFo/K5EaojTXw0IdzA9BWlyXOGtrwwNTODO+x+9azAZZbT+jlmYIT2ojKsrIhJcEsUqfIit8E2NJdLqaJcwBu4=
X-Received: by 2002:a05:6402:2110:b0:5dc:80d5:ff28 with SMTP id
 4fb4d7f45d1cf-5dcdb71b9eamr3699500a12.14.1738772128598; Wed, 05 Feb 2025
 08:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6JXtA1M5jAZx8xD@debian.debian> <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
In-Reply-To: <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 5 Feb 2025 10:15:17 -0600
X-Gm-Features: AWEUYZn9InMO6vKkPSNHI1ibnXF8Xkrs6VTIzzIzxo7kGVK4Vv6Z-POUOrf0Oo8
Message-ID: <CAO3-PboqQqUprY7=fzZk4tFfQQ9xoOkqzx0G0U8PspcdznLRKw@mail.gmail.com>
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 8:19=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 2/5/2025 2:08 AM, Yan Zhai wrote:
> > I am getting EINTR when trying to use bpf_map_lookup_batch on an
> > array_of_maps. The error happens when there is a "hole" in the array.
> > For example, say the outer map has max entries of 256, each inner map
> > is used for a transport protocol, and I only populated key 6 and
> > 17 for TCP and UDP. Then when I do batch lookup, I always get EINTR.
> > This so far seems to only happen with array of maps. Does it make
> > sense to allow skipping to the next key for this map type? Something
> > like:
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c420edbfb7c8..83915a8059ef 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2027,6 +2027,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >                                          attr->batch.elem_flags);
> >
> >                 if (err =3D=3D -ENOENT) {
> > +                       if (IS_FD_ARRAY(map)
> > +                               goto next_key;
>
> It seems only BPF_MAP_TYPE_ARRAY_OF_MAPS supports batched operation, so
> map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS will be enough. It is als=
o
> better to reset err as 0, otherwise generic_map_lookup_batch may return
> -ENOENT.

Jump to the next key should always restart the loop, thus err will be
correctly set afterwards.

> >                         if (retry) {
> >                                 retry--;
> >                                 continue;
> > @@ -2048,6 +2050,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >                         goto free_buf;
> >                 }
> >
> > +next_key:
> >                 if (!prev_key)
> >                         prev_key =3D buf_prevkey;
> >
>
> Make sense.  Please add a selftest for it. Another way is to return id 0
> for these non-existent values in the fd array, but it may break existed
> prog. Just skipping the empty array slot is better.

Working on it.

thanks
Yan

> > Also the context about my scenario if anyone is curious: I am trying
> > to associate each map to a userspace service in a multi tenant
> > environment. This is an addition to cgroup accounting, in case the
> > creator cgroup goes away, e.g. systemd service restarts always
> > recreate cgroups. And we also want to monitor the utilization level of
> > non-prealloc maps of different tenants. When dealing with inner maps,
> > it is not always trivial. To connect dots I choose to read these IDs
> > periodically and link them to the tenant of the outer map, that's
> > where this EINTR occurred.
> >
> > best
> > Yan
> >
> > .
>

