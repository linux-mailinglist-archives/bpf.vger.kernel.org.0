Return-Path: <bpf+bounces-63931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C4B0C93D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF37F4E692C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C5B2E0924;
	Mon, 21 Jul 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUCTD/aP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062828469C
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117894; cv=none; b=MMWEvPzL3yA1clgj3VRoUEjV7OL+yoi8bUzL4fuh4kyyxYyk3RvGYgFU4Rod9KneTOGeJGRmpcwzgyc40XlOsle1fVBybzF4mv0DA/IP78H8IOw+A8jc+C0RqT7O0IQim8mfQPxySiZ/CVWQrXHTcc6XHxEY0kZckCroJR148i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117894; c=relaxed/simple;
	bh=z4hDZVpf58AVHFOS5EVSomGfmOjQpVBT6ttc9yACW6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoI8++mkcWR/a0f6HnSYPdV5EK6djOjckoL00lnR+HmIZZqonl0QuY9wSIEaLGUwXSymtsc/JvMyFRr23WKtIJHPlzOq6iopTopV/irnRMTHi7zPt7YObUz4RlhvRnyRcRZyNe1jCKn0960a42a8N+nCDuQMpdyfDx8otjCIev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUCTD/aP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234f17910d8so40463865ad.3
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753117893; x=1753722693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KwmEnFL5IvfHYrORq/y5J/RyPO329ZSEg3olnDvg9q0=;
        b=OUCTD/aPwC32TbePzO89+rFu9Z4LT3vhmr8EzZdUfA7NhYCgMo6kBUKctTUFxrp0AL
         YWSRGXlVTZs0vEW+VoePG183B2EfZVcKkUvKrurVBoMxIXee4i4OTVBFzaGHbYlmQ4qV
         Y35ql/dheotj0hR0/b6I/Ub647uQHNKDebVxhpSKuo0/Q7ucxjy4quXmMJS0Cxd0bgFs
         bc7dc5vzczgkn4aNijAthrEMhkzR1YWYlHq0pEysVhgxMGBXC7UnpJF7tlKALyfXmcdu
         Ojz/S9DLN2pXcSi4I57I69RC2Uplk/0enYKmXvMMPW7C2WSXVEHTldxGD397at4uddXG
         GN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753117893; x=1753722693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwmEnFL5IvfHYrORq/y5J/RyPO329ZSEg3olnDvg9q0=;
        b=mWioBllh6+EvyPiErcGbVlUg/3DaqkIzp+Yt0jRt2cgdEXs0n/cBGT7cZNEaVAwooW
         jFDu+6tHt7gNBr+gEZNKxm2K1tziQ0vf7y09XPdcyqyRR5/TpqCYOULT17gfTOVnl1+E
         94zcoxGCW0dOCkAsfHC9Q7EqDZqdPrgKVhEMlhJGPGhh0/7NukkiocMeTEYA/H/FVd2A
         GR0ZBexM7JKF0fdov7ufwjDvZtrVgNMDq/qy90KS728fLYaBXoJElBBNpf0A6LdTlKkB
         0vGqfmHRQ2/8doUEG9+jE2Jd0aKtQ0dcqhzogWU5FdASdux93aoiAGoI7yVTWA0oENbT
         XYHw==
X-Gm-Message-State: AOJu0YweY7QcNuF3kwkLBu6GPUGDVBluZkdtngngJ8OXrBZ69wJ8B0Mx
	DEosEOtrtQG8RA1LiECXy4AIhOXRhyvexcYKsZiWh/fv1fYBCK9gkdqnwwu/eBo2
X-Gm-Gg: ASbGncscDMMcyvaLNdF/cU7wVAo2MiDT1xGB8ZmhcMUFGR8OEb9TfAAt7FUpHvM9HPU
	Lyc03dwrwhDU806K6Wq35oo2s9dZNbrmCek4Uoe8CWbTutKJc1svzkWsB3rwK1OOlYnmKBD63XE
	UAVGQXVsS0tVnhFZDHpZLMoLk7FEnfWEO5eeVFvrBEmEs3TNvZADlfLcgoLridpdbVqWlXx6k/U
	/xkI1JPKP0NIxk+73OcAFlTpMkgfaZNfUkKdDaz35BTfQtsnXMsnfAKTKBKnzXwRYa7cpz6HeRI
	oHM0wWFagYTM5uED/LSTwGNOtQOaVK83nPWUcvx/GEZ/3obJF5U6P19rbvDyidL4BEZQF1DbTxf
	ARl4VvfwubKNVC2fnFfffbD3lkrP3
X-Google-Smtp-Source: AGHT+IEJ4Ll2F06ateAx4CtXu3CdyXeRbM//Rh8dQeU0I+OJ5qSajjSSaUSx+FL+CikEjg0TL5eyKw==
X-Received: by 2002:a17:902:8e82:b0:236:7050:74af with SMTP id d9443c01a7336-23e3b765f15mr118247385ad.9.1753117892547;
        Mon, 21 Jul 2025 10:11:32 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef682sm60687185ad.192.2025.07.21.10.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:11:31 -0700 (PDT)
Message-ID: <c55df650fe8a491d5ae6640f5e08707bab9c30dc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for
 percpu_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	yonghong.song@linux.dev, song@kernel.org,
 dxu@dxuuu.xyz, deso@posteo.net, 	kernel-patches-bot@fb.com
Date: Mon, 21 Jul 2025 10:11:30 -0700
In-Reply-To: <d8d4cd89-2953-45d1-9f81-ab633aa3e4cd@linux.dev>
References: <20250717193756.37153-1-leon.hwang@linux.dev>
	 <20250717193756.37153-2-leon.hwang@linux.dev>
	 <CAEf4BzY74tbyzD-4iF1Em9EmKX=2fAN4dTp_k8o+MuN2T3CVqQ@mail.gmail.com>
	 <d8d4cd89-2953-45d1-9f81-ab633aa3e4cd@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 01:08 +0800, Leon Hwang wrote:

[...]

> > > @@ -1941,19 +1945,25 @@ int generic_map_update_batch(struct bpf_map *=
map, struct file *map_file,
> > >  {
> > >         void __user *values =3D u64_to_user_ptr(attr->batch.values);
> > >         void __user *keys =3D u64_to_user_ptr(attr->batch.keys);
> > > -       u32 value_size, cp, max_count;
> > > +       u32 value_size, cp, max_count, cpu =3D attr->batch.cpu;
> > > +       u64 elem_flags =3D attr->batch.elem_flags;
> > >         void *key, *value;
> > >         int err =3D 0;
> > >=20
> > > -       if (attr->batch.elem_flags & ~BPF_F_LOCK)
> > > +       if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
> > >                 return -EINVAL;
> > >=20
> > > -       if ((attr->batch.elem_flags & BPF_F_LOCK) &&
> > > +       if ((elem_flags & BPF_F_LOCK) &&
> > >             !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
> > >                 return -EINVAL;
> > >         }
> > >=20
> > > -       value_size =3D bpf_map_value_size(map);
> > > +       if ((elem_flags & BPF_F_CPU) &&
> > > +               map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> >=20
> > nit: keep on the single line
> >=20
>=20
> Ack.
>=20
> Btw, how many chars of one line do we allow? 100 chars?

Yes, 100 chars per line (Andrii is on PTO).

