Return-Path: <bpf+bounces-68693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619DDB818D2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 21:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB0B3B21FB
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C525344E3E;
	Wed, 17 Sep 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntswvo8x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A430CB26
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136371; cv=none; b=j6wTLt6lE7AyYosA8fq+YlYWAA9ujMH1Kca5iyKQdUrme2hreyvBx6qUErv9g25WGENtfVcRgRYrAqbRQz2B3ZVQsR47vqltGf8zF7dulRVSC2M0zqFqHo0I05IEqE414LIrXKbfZ2OrKtjQ4ulbqDZB/m9dOwNQXQY+dJGErUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136371; c=relaxed/simple;
	bh=EBj8arynveRkYNfaQLeNVp7YnH7klECms5YCZ3oNQDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2iWRwM9DiXH3e6YXS8GFJnG8l9W7Tm1zg1Wdm6BZdsfT111ELROsX9NTTIXAw81NBEyIuK1ALSlBZWP3d1L4usUVcvTQrym2KPC5qAnMJqHbknRqSmD+XsBoVo+z5I3Pw5b3M7ZizPGonEsBh0qMJ2aEBlYVH13CbU7G790mjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntswvo8x; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54fa8a371fso106783a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758136369; x=1758741169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEH7zzfm1A5KWVEOPs4CDmYgixLmgQ/OFsk292BPHiU=;
        b=Ntswvo8x0WCLjsySrepgG0JyuIbJzfEjZTsPZ2mTYjK6Zc0AuUo1TStyjDIqd2Xlyg
         Tduyg2+QmDSsCK+vRHYy0v4DxcCEWX1grggyACYD6d6RoLo8t8GneS0X5Ew+ZD+cXGIo
         et0FHXA5P7lJh6Byz39rguSF4aZ1DmMW6a0Z8vQCY9V4xpU2BjYMdmrE0+j9z+xchzPS
         OfZDYt1p5DLkM7KP+mr1TBihbVd6r9bp8fumgTedyRlo2YQlyvBTGBm4C6xT5LgAtSpO
         xSMNkIqD3M2qcLvNCy/GIrOQVacogh5T1NqoG/QtsBSrA80fdesqLB4fDVZAdndFKF9r
         j/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136369; x=1758741169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEH7zzfm1A5KWVEOPs4CDmYgixLmgQ/OFsk292BPHiU=;
        b=oY+RB/5uDfPXvWBh0T20C5yrWazbQCoY/orRBQLm0EH2jqdPk1shRX7P4jiJQC6mez
         Mwr+n74uRWlW+KkGyTDRcBLAyUOGVX5UNtIh/I25p/ZdugOngUUipDpsjmgD+NAn6ob4
         lp/jZwtk/M6JxaJswn4jrplY1KOCuzqK4P9vtF4l7t+8Gsl0HIOEDm/20ly69uhaAt6v
         zSccJyFxYJvpoVt3zYFfDR+xYxbEsZ1YkT57ejrWNLfzp1g/5UvRoIyp7BabH1q7/I0a
         rZeNfGhhc5nW/UHv0aJAhEbnhyP2PSmOVDNwPgo73EoyQLNzc51oJ0UNVn0vpjzzFR6D
         1K4w==
X-Gm-Message-State: AOJu0Yx/l1Zx/tsIuYfINmdi5ApXvAeSUTwnCjMznZ0r015RvEp9Lh5b
	n4XQM2DXB03WnF8+0G+k6DGl5nWNiE9NFYRxlKKn1+b42aI19pxty1Hq68JPAOXwJnj2JrAWEAX
	Fl1mwTp0wdsOYotIF2HWtwtUj4sTI5vg=
X-Gm-Gg: ASbGncvKbiDJTZghCQpsQ658QfUKoukcLtT4idvN+2pGFtLffxbgn7loJBXWx7n7xmo
	IcGKVni5RqnVMpVn5/WBlRl4kHFaBl3OgCUg29I9ovXzQnyXdz8h+U3cXNaZCEwM2l67G3IUE6T
	H8QtC9+E1CnMFKH1M2cM9LATqxzkNF/s4AU9tYw83CHlKuLkFgORB5WVTQnkkgqyGfdA4L8kL4e
	xVcGipD2gAC9sU=
X-Google-Smtp-Source: AGHT+IE9+ZsKL0rfJmHOgXUV3PqUvYcEER3BEdmFKjQAqj7W4lRQP39GZUdU9hrTIB+Nr3s6JFhI4TABO3tLfcKMlsk=
X-Received: by 2002:a17:90b:528d:b0:32e:87f6:f5a6 with SMTP id
 98e67ed59e1d1-32ee3dd9d23mr4015385a91.0.1758136369408; Wed, 17 Sep 2025
 12:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-6-leon.hwang@linux.dev>
 <CAEf4BzaknkgAFfxA5WorX-2kZa=MHCB=MNXBvf6tDvQOb36o0A@mail.gmail.com> <DCV64CLD2WRC.VLHMKT6BLL7G@linux.dev>
In-Reply-To: <DCV64CLD2WRC.VLHMKT6BLL7G@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Sep 2025 12:12:35 -0700
X-Gm-Features: AS18NWAupol76HfEfacon_DYFJdVf2a7JTlYJJNeHMj1Ouvi4bZ844IwFmRfOw8
Message-ID: <CAEf4BzZvmwExwaWFAj2b1BpUQM2G_KK9EF9GjGK7A11wO5JRKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:08=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Wed Sep 17, 2025 at 7:44 AM +08, Andrii Nakryiko wrote:
> > On Wed, Sep 10, 2025 at 9:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps t=
o
> >> allow updating values for all CPUs with a single value for update_elem
> >> API.
> >>
> >> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
> >> allow:
> >>
> >> * update value for specified CPU for update_elem API.
> >> * lookup value for specified CPU for lookup_elem API.
> >>
> >> The BPF_F_CPU flag is passed via map_flags along with embedded cpu inf=
o.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf-cgroup.h |  4 ++--
> >>  include/linux/bpf.h        |  1 +
> >>  kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
> >>  kernel/bpf/syscall.c       |  2 +-
> >>  4 files changed, 23 insertions(+), 6 deletions(-)
> >>
> >
> > [...]
> >
> >> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_ma=
p *_map, void *key,
> >>         int cpu, off =3D 0;
> >>         u32 size;
> >>
> >> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
> >> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F=
_ALL_CPUS))
> >>                 return -EINVAL;
> >
> > shouldn't bpf_map_check_op_flags() be used here to validate cpu number
> > and BPF_F_CPU and BPF_F_ALL_CPUS exclusivity?..
> >
>
> bpf_map_check_op_flags() has been called in
> syscall.c::map_update_elem().

ah, I actually tried to double-check that by looking at earlier
patches, but still missed that. Never mind then.

>
> Thanks,
> Leon
>

