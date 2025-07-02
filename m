Return-Path: <bpf+bounces-62171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04830AF6007
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147E516C290
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5351E633C;
	Wed,  2 Jul 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbwBf8M1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445C3FB31
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477427; cv=none; b=YkgdLMhp06el1AjnSyfQVBqKaIV+YZ6d1ujQk0WLS60p7jYhNOyc/b15vAQofm+Jab+rbBQdVnDMLW8zUz3jwspW6egSkIn+TEAws6f8s7W609POdF8PWA10U8jWe6MVdsWg7nsDeutmbQpbItJ5cz3dMuhBsL5wiSEn1vEcDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477427; c=relaxed/simple;
	bh=Sjfqv09H2W7EIvf4duXBws8G4BKZrD0qdjj3KsYCDcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTPZHeswqHr0QuRNrr+u52eKMtpjj8qAr0IgnwC4x6Yggihl/MWhW7WEQR4ZPKrPGZc/eXSaglfqhtUGyhgXU14MRGOwW5NpGN+sQFChUrTD4sqMKfDVxdecknetEgUlePTp51dzqyKihh76l38burvSY+VvBDiWC1fNUEhVmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbwBf8M1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so5435763a12.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477425; x=1752082225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/70+p1V7NJ5T6P6NeT9wge3d3pter4QYMJkqIhZ2ss=;
        b=cbwBf8M1VGYAxJ95eg+EiwONpSbwzlid03dwm3hUL1B2B2QMhEWkj5rTDnSqGi7enb
         8MxymGtTDaGhbZeGQSulxSW5XWq4T4ygaTAWerzjNv8aSOEr84YuX6GUwm+CIvUCqxjz
         hxw44XNYMjXkPzu8icH3fbMcneNjG0OXK40DElJAJdtfWEkUEHE8eowkRexdNfiSDd9D
         sC23pbafVtJ4bBwuKWHrFt/wGTCN1Wvf0BczYRpTHo64l0x3JACYkypcV/MxjysgBHrJ
         KTXmFeuo6+PnFprKs8iCgG61kqtXmSM9q0JAm4m8Y4YQu+LQplwJ5/+qvDmLvEHZzoqs
         pCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477425; x=1752082225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/70+p1V7NJ5T6P6NeT9wge3d3pter4QYMJkqIhZ2ss=;
        b=t8L6MY6FbYWOw+zkA9AaLiMAL0Y09HZKoBPjkB3JmJcpmbPJu29LdqLnsHzt5p5hRX
         f/EF4kpw+TRxDW9YIXuwrpUZoCp/mY8XsEfx7vcfBdt3xeJuBMgAMneFaO6PlqJKmJfG
         KK41pSftyxS5df2knVddJ9rS+MD/s6+2cwKTlp6BefVP/M1xkva/gFxFxW1Iy/v1Ds/+
         oePT7UbRZdNAWj6sElPi3RXvDLCzQ1Aq32Rw6rTPxwGgiDCSGz7iH9htTV3e2UhJkUJs
         vLB+mBgi8YHU5sJEaAT5ZdtWXQvpgkwUlWvNTj8RFBoavKI+k9PUx4XYtIlVPOjhkRkL
         wSyA==
X-Gm-Message-State: AOJu0YztQfkBk0XZ76Tzi/+OjPAyzfn0qR5HFPiZ59dhWqk/xndv6442
	nvwUkmdNlNvgGZJJ9Ia3phuYwlv4rhdgw0k08cWRj7DosaxZoQaY8gyuyKp2lrmDidqRJkeCk85
	HGrTF1HQNIfs31uY9ve4p2voZZkZGVnI=
X-Gm-Gg: ASbGnctUd+PnYj5rR2UCUUtR+zkGXIXpOP3ZdUHYhbSG7S4GAQuZ9yA9g9AELXy78v5
	9Qq2icdJawfqQL3ThmFWOxmbMq5dQnzM5/2FzmwrCTL651Tu1UCL9FNOmvJp9og939Cs48FsiaH
	7loiApSdg6ZLMq/U3X3sVmr5ABGhexB2o+TB8xb9VZj+advLIGe1/VTRHw1hM=
X-Google-Smtp-Source: AGHT+IFOYzRQwGPy5zZo84Qm+Jit2AUUo699Md5MImvewpgI6F1ccqHg8raoY6uspOr+acAImqQHbbiFNVdRvu0Uyd8=
X-Received: by 2002:a17:90b:2b4c:b0:311:ad7f:3281 with SMTP id
 98e67ed59e1d1-31a9d58f2a0mr363607a91.12.1751477425172; Wed, 02 Jul 2025
 10:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624165354.27184-1-leon.hwang@linux.dev> <20250624165354.27184-3-leon.hwang@linux.dev>
 <CAEf4BzagyjD3LAc3s=w=TbVrqxKWJ=t6Enu6s6BN8cAu3Vmzyw@mail.gmail.com> <1135ef3d-1fec-40f6-b2c1-446325951b2d@linux.dev>
In-Reply-To: <1135ef3d-1fec-40f6-b2c1-446325951b2d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Jul 2025 10:30:12 -0700
X-Gm-Features: Ac12FXwYZnkLag-rHOPc9jVtbvVpa_Omd9FOQ4VaE16-XWAGQ2qFxmWi16QYDu0
Message-ID: <CAEf4BzbsN3E467efA3Wu1TMwW+J=6ZMgtF7H490_waec32Grgg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:28=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/7/2 04:22, Andrii Nakryiko wrote:
> > On Tue, Jun 24, 2025 at 9:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array =
maps,
> >> introducing the following APIs:
> >>
> >> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_=
opts
> >> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_=
opts
> >> 3. bpf_map__update_elem_opts(): high-level wrapper with input validati=
on
> >> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validati=
on
> >>
> >> Behavior:
> >>
> >> * If opts->cpu =3D=3D 0xFFFFFFFF, the update is applied to all CPUs.
> >> * Otherwise, it applies only to the specified CPU.
> >> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is us=
ed.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c           | 37 +++++++++++++++++++++++
> >>  tools/lib/bpf/bpf.h           | 35 +++++++++++++++++++++-
> >>  tools/lib/bpf/libbpf.c        | 56 ++++++++++++++++++++++++++++++++++=
+
> >>  tools/lib/bpf/libbpf.h        | 45 ++++++++++++++++++++++++++++
> >>  tools/lib/bpf/libbpf.map      |  4 +++
> >>  tools/lib/bpf/libbpf_common.h | 12 ++++++++
> >>  6 files changed, 188 insertions(+), 1 deletion(-)
> >>

[...]

> >>  };
> >> -#define bpf_map_batch_opts__last_field flags
> >> +#define bpf_map_batch_opts__last_field cpu
> >>
> >>
> >>  /**
> >> @@ -286,6 +315,10 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(in=
t fd, void *in_batch,
> >>   *    Update spin_lock-ed map elements. This must be
> >>   *    specified if the map value contains a spinlock.
> >>   *
> >> + * **BPF_F_CPU**
> >> + *    As for percpu map, update value on all CPUs if **opts->cpu** is
> >> + *    0xFFFFFFFF, or on specified CPU otherwise.
> >> + *
> >>   * @param fd BPF map file descriptor
> >>   * @param keys pointer to an array of *count* keys
> >>   * @param values pointer to an array of *count* values
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 6445165a24f2..30400bdc20d9 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -10636,6 +10636,34 @@ int bpf_map__lookup_elem(const struct bpf_map=
 *map,
> >>         return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
> >>  }
> >>
> >> +int bpf_map__lookup_elem_opts(const struct bpf_map *map, const void *=
key,
> >> +                             size_t key_sz, void *value, size_t value=
_sz,
> >> +                             const struct bpf_map_lookup_elem_opts *o=
pts)
> >> +{
> >> +       int nr_cpus =3D libbpf_num_possible_cpus();
> >> +       __u32 cpu =3D OPTS_GET(opts, cpu, nr_cpus);
> >> +       __u64 flags =3D OPTS_GET(opts, flags, 0);
> >> +       int err;
> >> +
> >> +       if (flags & BPF_F_CPU) {
> >> +               if (map->def.type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> >> +                       return -EINVAL;
> >> +               if (cpu >=3D nr_cpus)
> >> +                       return -E2BIG;
> >> +               if (map->def.value_size !=3D value_sz) {
> >> +                       pr_warn("map '%s': unexpected value size %zu p=
rovided, expected %u\n",
> >> +                               map->name, value_sz, map->def.value_si=
ze);
> >> +                       return -EINVAL;
> >> +               }
> >
> > shouldn't this go into validate_map_op?..
> >
>
> It should.
>
> However, to avoid making validate_map_op really complicated, I'd like to
> add validate_map_cpu_op to wrap checking cpu and validate_map_op.

validate_map_op is meant to handle all the different conditions, let's
keep all that in one function

[...]

