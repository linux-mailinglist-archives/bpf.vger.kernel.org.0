Return-Path: <bpf+bounces-62983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F5B00D76
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EA86400D0
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 20:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4F2FD878;
	Thu, 10 Jul 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlOrX3uP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6971DC988
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181222; cv=none; b=L4DlwuirBs2JnTVHC4qDTOXbqpAzgk7NUq6ZPnabrhspMow4yyG5MC7MTqvVN5BqIqXkVJix16/RroUqLKIK50/xm2Je2WQWk/Rh/5jz+ZXe4K+seSNxU1NDzeD81+s5DkmA8beQNeQDIe2gkcyhe0kaGjyPgrQPHlTP4mdEVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181222; c=relaxed/simple;
	bh=L9X8ztFj1oLeyHnkcITlhzULgsGaMmHCNE2W3JXAE1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qx+5qeuSgvaT1NTW7iODzfp2jfmQBgf5YQKIgzX5/bqRu1JAAwEGVZ1QvWvHgBYF/2Jii43KbIMD8X8FJluR5aTusQ2tUxiuBW8AX8tVnnUp8fLyWsar6Oc6dHlC/oKsu/rE38nfzlTD84FQZAd3QvCHob68tYUV+EmumjM9Mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlOrX3uP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-710e344bbf9so15128957b3.2
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752181220; x=1752786020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJpsBhWzz99D+ZGXY7P/byNHz7r+eB6XqrJtsAIpMzQ=;
        b=PlOrX3uPkBdrkzLxR5Vl4Hb3l0i7u8toURRikxBiyPySJUEvHsu17CzlRzQF5hp+v+
         7b6HouV+Xa1eUhW1nE3Z6mK5ABzfxkVGHzhvsfcl5zpw/kFxDIUvH/2YUDisK+07RF4J
         QIhrtyZjIMdoogJhIk0L9omcEHPkAkBW9u844xCoRck94HQi1Q0NVWgUwvlPbztsEp2V
         cuX/BEwBWsr/PzP2kGLQAtJ25YPS+GzQlPktsHlnpijsut2N/GjQ4E/9L13ozPqkXOAb
         ekYaAlwcLVP3MAifFIlqTdSXvTEtB6p2qRoj5Cn7RCKWnZB2ET03dyPOYW7P3xq7B9zf
         ujhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181220; x=1752786020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJpsBhWzz99D+ZGXY7P/byNHz7r+eB6XqrJtsAIpMzQ=;
        b=BTmSFaTmNcE1cRFWOl6atUY4qyzfQWvifsd61BZBHm99om4XyPivMG27G2HbpbYx8u
         3nfH2nsDGDmLs9f9c0F6zbAm68R+cTorq8mVrzZPFPaPii7dBVBi6z7yKEPr4mdPnVnv
         UK0/L5V3+76j00B+NQuYklbbdx+1ffYdMb5Jo7UEEj2JUeMYGDxaCCWAOXUyuiTtve0b
         NPO6XJwNY/NGWRPNAUo1McImREt3K32CH9uxQQpumcdps84hjEt4bnO+0VeDazFTg7hJ
         5vt4xUYHjr6Jg4zYy/mLH0UhSWyi40r1DAk/GsVV5/7xQ4zMyyMvp/gAItnT/OuMWVr4
         2sIg==
X-Forwarded-Encrypted: i=1; AJvYcCXx8qbFZjTyCMi/2pl9wxKcJ8pT6u2+TVo3uljDMzlWqdn39VyZjpzbsb1J1/Jg8cc7L/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oz8KvpAnf0b5Zv1xD4GuJal9pNb4ok+tckJKGNbJmK8f3hNR
	2UQsiUdeW+MKbrYf1Ss6ym27T1mGDi8jt7bvwDAyNHKwOb/YP09Uig2xUmh517oz6jR1c2u/7fD
	qyxogNsWe2xn9MCkRiBe5cVVi487N+hw=
X-Gm-Gg: ASbGncvJoIOgKUx0vEs5IVk0TEOxm63gVlROIqGQXdbb1GBKhMH9/MXwV2QXoBkCpUW
	OnO36d7Ox/kvS0cAp40qOjIv2+IvsL5S/OJor3aBEzmpnqqAiJMVPVdLQs5Q4qUHhojlChuqa2x
	/it04zSVlOLaI7rt7cEqNFIj3JQyeR3vy42FaDLe89G0WGSeRU/kWFhsMFUrDRSEYmaZqlzQ==
X-Google-Smtp-Source: AGHT+IGCnZmwV+Uv+9EhzLZlUIvUXwn4+EQ4xRkwNAtHZQbd4vDYJcuAon3wyyfQ268B77ix0rBG0255es8lfmvIvVY=
X-Received: by 2002:a05:690c:4486:b0:717:bff8:4681 with SMTP id
 00721157ae682-717d7a0ec81mr11153757b3.24.1752181219602; Thu, 10 Jul 2025
 14:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230825.4159486-1-ameryhung@gmail.com> <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev> <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev>
In-Reply-To: <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 10 Jul 2025 14:00:06 -0700
X-Gm-Features: Ac12FXwVNr_g6mTDSEREkn6ZyKkgYju7kOWP5hvzAkEpEDCCOLwtUpsn09Z4c_E
Message-ID: <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	tj@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 7/10/25 11:39 AM, Amery Hung wrote:
> >> On 7/8/25 4:08 PM, Amery Hung wrote:
> >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_elem(struc=
t bpf_map *map, void *key,
> >>>                goto unlock;
> >>>        }
> >>>
> >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> >> A follow-up on the "using the map->id as the cookie" comment in the co=
ver
> >> letter. I meant to use the map->id here instead of 0. If the cookie is=
 intended
> >> to identify a particular struct_ops instance (i.e., the struct_ops map=
), then
> >> map->id should be a good fit, and it is automatically generated by the=
 kernel
> >> during the map creation. As a result, I suspect that most of the chang=
es in
> >> patch 1 and patch 2 will not be needed.
> >>
> > Do you mean keep using cookie as the mechanism to associate programs,
> > but for struct_ops the cookie will be map->id (i.e.,
> > bpf_get_attah_cookie() in struct_ops will return map->id)?
>
> I meant to use the map->id as the bpf_cookie stored in the bpf_tramp_run_=
ctx.
> Then there is no need for user space to generate a unique cookie during
> link_create. The kernel has already generated a unique ID in the map->id.=
 The
> map->id is available during the bpf_struct_ops_map_update_elem(). Then th=
ere is
> also no need to distinguish between SEC(".struct_ops") vs
> SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will not be need=
ed.
>
> A minor detail: note that the same struct ops program can be used in diff=
erent
> trampolines. Thus, to be specific, the bpf cookie is stored in the trampo=
line.
>
> If the question is about bpf global variable vs bpf cookie, yeah, I think=
 using
> a bpf global variable should also work. The global variable can be initia=
lized
> before libbpf's bpf_map__attach_struct_ops(). At that time, the map->id s=
hould
> be known already. I don't have a strong opinion on reusing the bpf cookie=
 in the
> struct ops trampoline. No one is using it now, so it is available to be u=
sed.
> Exposing BPF_FUNC_get_attach_cookie for struct ops programs is pretty che=
ap
> also. Using bpf cookie to allow the struct ops program to tell which stru=
ct_ops
> map is calling it seems to fit well also after sleeping on it a bit. bpf =
global
> variable will also break if a bpf_prog.o has more than one SEC(".struct_o=
ps").
>

While both of them work, using cookie instead of global variable is
one less thing for the user to take care of (i.e., slightly better
usability).

With the approach you suggested, to not mix the existing semantics of
bpf cookie, I think a new struct_ops kfuncs is needed to retrieve the
map->id stored in bpf_tramp_run_ctx::bpf_cookie. Maybe
bpf_struct_ops_get_map_id()?

Another approach is to complete the plumbing of this patchset by
moving trampoline and ksyms from map to link. Right now it is broken
when creating multiple links from the same map as can be seen in the
CI. I think this is better as we don't create another unique thing for
struct_ops.

WDYT?

> For tracing program, the bpf cookie seems to be an existing mechanism tha=
t can
> have any value (?). Thus, user space is free to store the map->id in it a=
lso. It
> can also choose to store the map->id in a bpf global variable if it has o=
ther
> uses for the bpf cookie. I think both should work similarly.

