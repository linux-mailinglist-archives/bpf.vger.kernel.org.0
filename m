Return-Path: <bpf+bounces-68692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28664B8172C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A6D2A7758
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C56288C14;
	Wed, 17 Sep 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXJe/Xwr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB82FF163
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136317; cv=none; b=Dk6QuajdIXdNhGsbDFYWAjur7hKitzl+9AVQKEMoxmO7Ci7J3e7kMSCLZgREBfpauBZp85I6lDfaNcc/2c53d4QET3LjcG70DfGTgjIJx1RtIvDFOIdx7Zl7wFq4W0m4WHRJGee7WHFYFEQKIqlZZ8IWAqUPCsrNB5YDv9rJ6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136317; c=relaxed/simple;
	bh=tVN9Pssf7mK9HUQubPI7GeDPymJzD3z6cbfD73zs7L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDf+yBPyi0rlCXCFZOtgI6lOE/PBO46xydNclODVEKcud2xjY8PsMMUszEzGOcHsuS7toUoD25Cb/xsWUnjJ1ckt7amELN2RATAIpm9VoyAdM0OofMrb52/HVJ93IIM/CokzSEOqJPrwXXsQqV5NV2Bwk9OhQT1oZq/rxYHMFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXJe/Xwr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so96524a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758136315; x=1758741115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZ/Cxstw9UpqhZrMYZVXW5W2p7c74huWdtCJXuwn/2s=;
        b=WXJe/Xwryx+8Q11uDI+Lhc+KnlY0vuKPfx8zgD7fL649tpWCyu92XWPG3uWSg0XkDm
         4B519WZgiiDul/yMDhbi08XABp2U3GspYpOxcBV7/t12ts5Si7RRSOYAAnfubKUX6ZcC
         VpVd0rRDGhzhRiXym3PGqLoYiVD6wXNdbB9H8h/72Meul1Ji0B2iYPuPGU76pUQYWsXF
         QILHLUyph6qSRYTXz0vELppYJbrTEQ0CS5bgEG8s1rUoDigkZ97QksQ6TZ7B5CvMgWAh
         U8jONvDuiR48AWmB1n8+CdFGk7ra9Zt5AbHTI9EPCi+uOAKHPb0JE/PPX4IE9KNoneOu
         NkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136315; x=1758741115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZ/Cxstw9UpqhZrMYZVXW5W2p7c74huWdtCJXuwn/2s=;
        b=DxmAfKXNrXhq9vDgrD8l36VxhoCYQqfOsPBs7qYAUMvFMHRNvhWanDfMK/TkYkssxs
         0af3r85Dc0fb+1GchuWbTzOVZw2m1B9HaIPgT5VvzJVPo+4doAyh0EM3b9V4s18a2bRA
         Kx8UsKDMqnAM9hqrjomNE9Uy3hhoJvyF92X2NjtX01JBot3WmySTFWPINdqXl8ReBkG0
         +yFoZuAQwD1z/zxsYK7B6E23m+DgMAVyrC2eW4I9oDLKdpJ6SNX/47P5hz/HQeGDZPOj
         c3td1S2h/sEd4JIgg+ME1NftMBXZR6XjbfIVuTdi7giVvQkAQ6L7RbbP/ycp/OhR27gL
         I1RQ==
X-Gm-Message-State: AOJu0YzUsoaCbx5apSBJg5pGyPxc5V/gK6PMs6CNWDe61YXmLBKeuMAH
	DAUkRwkxmthJxtZUNCHELx+ddK1Eyi5tcgwElEtMZnnm+PZzErHRJglHwwQyDv6fmnUHg3fWHYx
	/heLFvUcWy6TK+7M9+DY7T6FuqRjshkw=
X-Gm-Gg: ASbGncsLnr8rUVpdhK4HNpdMF+cP5+sj/R+1h+piDPoAy2p4LaSCHdOgnvp100rwfUf
	mTZ2UJhlrPavPsnXrUnZAeebMjnON6GiEfiP1n6NdvpbMO+ll9R0wNzNDt0JYFqt6pDo4lXQ7im
	2tkNZyY5/GZ5SEYs7gnMobiv9y82QV+E491mlPT6WtpTcROHlk0T+SRgLS3HYQr1ZJUpPnLLOvD
	dV9YactM2Ct5HbIcKwDLIE=
X-Google-Smtp-Source: AGHT+IEpF75m+shPfsTY2JeYzpA/OOceLSzwDvLqJOhEc3MFk2354JChNjLoacEUCVcGNIEcoTQ9B6xUs8TNdxk7ds4=
X-Received: by 2002:a17:90b:3e86:b0:32d:dc3e:5575 with SMTP id
 98e67ed59e1d1-32ee3ec227dmr3687196a91.5.1758136314614; Wed, 17 Sep 2025
 12:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com> <DCV6E0U82WFC.2GU139G1W4KMA@linux.dev>
In-Reply-To: <DCV6E0U82WFC.2GU139G1W4KMA@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 12:11:42 -0700
X-Gm-Features: AS18NWBpC1Dm9FaAUAtXIxUoTMcf1NX3Un1wn8ZFSuzRNC_CD-3SMu7c36zFg_U
Message-ID: <CAEf4BzZeVcae2rcTc0o7q8xFH5-gb1hLG8RAXSgi_Cf-u--Xpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:20=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Wed Sep 17, 2025 at 7:44 AM +08, Andrii Nakryiko wrote:
> > On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
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
> >>  include/linux/bpf.h  |  4 ++-
> >>  kernel/bpf/hashtab.c | 77 +++++++++++++++++++++++++++++++------------=
-
> >>  kernel/bpf/syscall.c |  2 +-
> >>  3 files changed, 58 insertions(+), 25 deletions(-)
> >>
> >
> > [...]
> >
> >> @@ -1147,7 +1158,7 @@ static long htab_map_update_elem(struct bpf_map =
*map, void *key, void *value,
> >>         }
> >>
> >>         l_new =3D alloc_htab_elem(htab, key, value, key_size, hash, fa=
lse, false,
> >> -                               l_old);
> >> +                               l_old, map_flags);
> >>         if (IS_ERR(l_new)) {
> >>                 /* all pre-allocated elements are in use or memory exh=
austed */
> >>                 ret =3D PTR_ERR(l_new);
> >> @@ -1263,7 +1274,7 @@ static long htab_map_update_elem_in_place(struct=
 bpf_map *map, void *key,
> >>         u32 key_size, hash;
> >>         int ret;
> >>
> >> -       if (unlikely(map_flags > BPF_EXIST))
> >> +       if (unlikely(!onallcpus && map_flags > BPF_EXIST))
> >
> > BPF_F_LOCK shouldn't be let through
> >
>
> Ack.
>
> >>                 /* unknown flags */
> >>                 return -EINVAL;
> >>
> >
> > [...]
> >
> >> @@ -1698,9 +1709,16 @@ __htab_map_lookup_and_delete_batch(struct bpf_m=
ap *map,
> >>         int ret =3D 0;
> >>
> >>         elem_map_flags =3D attr->batch.elem_flags;
> >> -       if ((elem_map_flags & ~BPF_F_LOCK) ||
> >> -           ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(ma=
p->record, BPF_SPIN_LOCK)))
> >> -               return -EINVAL;
> >> +       if (!do_delete && is_percpu) {
> >> +               ret =3D bpf_map_check_op_flags(map, elem_map_flags, BP=
F_F_LOCK | BPF_F_CPU);
> >> +               if (ret)
> >> +                       return ret;
> >> +       } else {
> >> +               if ((elem_map_flags & ~BPF_F_LOCK) ||
> >> +                   ((elem_map_flags & BPF_F_LOCK) &&
> >> +                    !btf_record_has_field(map->record, BPF_SPIN_LOCK)=
))
> >> +                       return -EINVAL;
> >> +       }
> >
> > partially open-coded bpf_map_check_op_flags() if `do_delete ||
> > !is_percpu`, right? Have you considered
> >
> > u32 allowed_flags =3D 0;
> >
> > ...
> >
> > allowed_flags =3D BPF_F_LOCK | BPF_F_CPU;
> > if (do_delete || !is_percpu)
> >     allowed_flags ~=3D BPF_F_CPU;
> > err =3D bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);
> >
> >
> > This reads way more natural (in my head...), and no open-coding the
> > helper you just so painstakingly extracted and extended to check all
> > these conditions.
> >
>
> My intention was to call bpf_map_check_op_flags() only for lookup_batch
> on *percpu* hash maps, while excluding lookup_batch on non-percpu hash
> maps and the lookup_and_delete_batch API.
>
> I don=E2=80=99t think we should be checking op flags for non-percpu hash =
maps or
> for lookup_and_delete_batch cases.

Can you elaborate on why?

>
> >>
> >>         map_flags =3D attr->batch.flags;
> >>         if (map_flags)
> >> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_ma=
p *map,
> >>         value_size =3D htab->map.value_size;
> >>         size =3D round_up(value_size, 8);
> >>         if (is_percpu)
> >> -               value_size =3D size * num_possible_cpus();
> >> +               value_size =3D (elem_map_flags & BPF_F_CPU) ? size : s=
ize * num_possible_cpus();
> >
> > if (is_percpu && !(elem_map_flags & BPF_F_CPU))
> >     value_size =3D size * num_possible_cpus();
> >
> > ?
> >
>
> Right, good catch.
>
> Thanks,
> Leon

