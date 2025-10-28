Return-Path: <bpf+bounces-72598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219ADC16205
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 18:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EA31C22599
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE10D34AAF8;
	Tue, 28 Oct 2025 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs/uSPNN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC304334369
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672264; cv=none; b=Jfm/l72VQ+GUfQc8xzBcgxCMd1nW4fnY475rJwSMH9+X70y8VE3+nEkVADmfBnJy3FZ+9knTthF76I6Fcte2pxgyqmT/koEVyZ/qqdHaIjV3AagGUQtpPtoFVAHjMsdWxYp6UizNC1apE903IwWU8Ofb6HMSGGzItJ13RK8iqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672264; c=relaxed/simple;
	bh=OewkxvHD9T8olwhI1f/2XQgi9rznzfBFvLBmKpBSzpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOXw+K6+wQpCvrK+UN4xOFJUtrt4NfnUPodsUdpArE5AdhkOiGYpGdNwukGN2C3w/EVGdyZ182QRTP+EqgOzfD4LKToir3Fp6obnY9LkJZn98pKxwUOQ8wpLqN3rjRMf7m1Z+fkjJmLhXKMudk4KR1x3SmkywIRzTCWfARTK+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs/uSPNN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso122943a91.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672262; x=1762277062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tljGKA799ISeHe7sJ8nVq9wgNoDMbrBY6ATHrDEAPsw=;
        b=Fs/uSPNNxPDnHb/1kG8A+IX9qzaIBBfATKEcYDMrR907f+quLdKjSgjqMEI8yq7ouW
         MKjiekBSjlId9vDUtvwZDRoaXSFJ1BHTIWNZthwyJ6gdIZov+tE+w9/+mygYtbAiGNm9
         n3BJyjZBA0ncDDWlha+RTUCJPefiNbO2mqA4Ry8z1b3Tx8ZOq6/qaKRpCoFXdWzFfqmR
         LXkI1lhQuh9VytIGDQQJbiB45WnAsLgKyTiwz6h35tAhKmeI57fk5dV2j7z6af0NwzfQ
         Ys2CBsHsha7aP9ZLIug2uuEY8JsByKmasP1uIDuy3//p1nBi1c1FyK3BFq05uulZyEm3
         Yp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672262; x=1762277062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tljGKA799ISeHe7sJ8nVq9wgNoDMbrBY6ATHrDEAPsw=;
        b=PiPo18rSV5k1nAZaQIl97QpKUstXPlqNxYk7EnkqW9jNkGjm6qH3pRFpeTvvoiBHaW
         24rEyiGOQLcEYfHpmPqOYAdvDQ2BuAb4m+fmTC0/lYIfakdUCfWYSAkG2jnlKXpp2M0L
         ruYiewaEEHGY9khBqr8NIo25hBBmK7NXbhz2dqgAlmHupW+hs9KbHdoFrly3tDrG/TQm
         pV/qXOCOEt4p/Sgd+xrxJthH4YVNRvc0R7YCQD265Abr6APJ1Ii+WTGPLSErRrc4uI46
         rYa+wV8BwY3+QeKYZMMNsFBwyGPgkSjt0q2ygKiqMACrKQp2lwAaYfG+Di33FaeOvbIr
         ucIg==
X-Forwarded-Encrypted: i=1; AJvYcCVpZa1OI2qnkJ8fZn5MsxhDlB85h467vFgYsm9/X2J/K9purjTt2/MuUkZtkCt1Qxhhc80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUY3qbX7EFQKhzBY4Atqg9pBnqPC/X/32Mri1zCmALEwo/xkEE
	os+F4Qc7lxe5h/j/8Npv/BGsyuWc6/J6EcR0865Jdv/inlenI+DMtWTQMIr6sJbtURm9w0ACjnH
	QkS1k0sF39RSk2+RxER0xZj1yFRiu/uU=
X-Gm-Gg: ASbGnculWQ4G/VIhcS9aGdNpIy4np0ooPtmw2yWsQiClPjnZiyRdeyasiueR5yWOUeF
	cu86B3VtkjoiN5mhdU2Mhti0B/UaCZL3NQp9iGB5pizutKS9d7Pz7x6ZLSd+ORQLlgvUJhofYgU
	QDLD36KO5saol6dxaqOSP1Vl3gP9XG3mMgzAGpgbaED9eTvQnqtfQokdxEXmpYM0MXsICGHPuxp
	n7ai+QvqOzAYmOohpPFEbe+Li7em0LgGxIIWuNtcRnQzaQP1QC7+R0rT+eesewBHNNIrvWMVbug
X-Google-Smtp-Source: AGHT+IFyyusQp9jVxJoqbcKJt1LGrdYEflLMuoSJ8Py8QQQ6PdrknVOCcNvnUgVhWXQIoX5kkVhJPU1j59NfN4UGYKI=
X-Received: by 2002:a17:90a:e7c9:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-340396c8960mr41024a91.10.1761672262000; Tue, 28 Oct 2025
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027232206.473085-6-roman.gushchin@linux.dev>
 <5e97ecea6574f100385cb21507076c6efb2667eb9def24f322306be038e98165@mail.kernel.org>
 <87o6pruf9j.fsf@linux.dev>
In-Reply-To: <87o6pruf9j.fsf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 10:24:05 -0700
X-Gm-Features: AWmQ_bk6C1eqilbaEGQX1H9gGHgUPIMiUUod78Q2POZa47mMAp7WiEEcnvZm4YA
Message-ID: <CAEf4BzZu_mmUa6n=kKJBgivKpKh3R3c8TcKwGnKdAV1WenuUAA@mail.gmail.com>
Subject: Re: [PATCH v2 16/23] libbpf: introduce bpf_map__attach_struct_ops_opts()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, surenb@google.com, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	andrii@kernel.org, inwardvessel@gmail.com, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org, 
	song@kernel.org, memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:07=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> bot+bpf-ci@kernel.org writes:
>
> > ```
> > commit b58d54ed56054e3a550e02c324982feb20a2671e
> > Author: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > libbpf: introduce bpf_map__attach_struct_ops_opts()
> >
> > This commit introduces a new API function that extends the existing
> > bpf_map__attach_struct_ops() to accept additional options, specifically
> > allowing attachment of struct_ops maps to cgroups via a relative_fd.
> >
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index b90574f39..be56a5dee 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -13196,12 +13196,19 @@ static int bpf_link__detach_struct_ops(struc=
t bpf_link *link)
> >>      return close(link->fd);
> >>  }
> >>
> >> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map=
)
> >> +struct bpf_link *bpf_map__attach_struct_ops_opts(const struct bpf_map=
 *map,
> >> +                                             const struct bpf_struct_=
ops_opts *opts)
> >>  {
> >> +    DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> >>      struct bpf_link_struct_ops *link;
> >>      __u32 zero =3D 0;
> >>      int err, fd;
> >>
> >> +    if (!OPTS_VALID(opts, bpf_struct_ops_opts)) {
> >> +            pr_warn("map '%s': invalid opts\n", map->name);
> >> +            return libbpf_err_ptr(-EINVAL);
> >> +    }
> >> +
> >>      if (!bpf_map__is_struct_ops(map)) {
> >>              pr_warn("map '%s': can't attach non-struct_ops map\n", ma=
p->name);
> >>              return libbpf_err_ptr(-EINVAL);
> >
> > [ ... ]
> >
> >>      link =3D calloc(1, sizeof(*link));
> >>      if (!link)
> >>              return libbpf_err_ptr(-EINVAL);
> >
> > Should this return -ENOMEM instead of -EINVAL? All other calloc failure=
s
> > in libbpf.c return -ENOMEM (see lines 11006, 11802, 12288, 12746, 12829=
,
> > 12891, 13089, 13129 in the same file).
>
> This code was introduced by e9fc3ce99b34 ("libbpf: Streamline error
> reporting for high-level APIs"), so it's new. I agree that ENOMEM is
> correct, however it might be too late to fix. I'll let libbpf
> maintainers to decide.

yeah, let's fix this to return -ENOMEM

>
> >
> > [ ... ]
> >
> >> -    fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, NULL);
> >> +    link_opts.cgroup.relative_fd =3D OPTS_GET(opts, relative_fd, 0);
> >> +
> >> +    fd =3D bpf_link_create(map->fd, 0, BPF_STRUCT_OPS, &link_opts);
> >
> > Is the expected_revision field being propagated correctly? The new
> > bpf_struct_ops_opts structure includes an expected_revision field
> > (see libbpf.h), and bpf_link_create() with BPF_STRUCT_OPS reads
> > opts->cgroup.expected_revision (see bpf.c line 889), but this code only
> > sets relative_fd in link_opts. Should it also include:
> >
> >     link_opts.cgroup.expected_revision =3D OPTS_GET(opts,
> >     expected_revision, 0);
>
> Correct, fixed.

I haven't looked at the rest of patches, but this use of relative_fd
seems wrong. relative_fd/relative_id and expected_version are there
for ordering of programs within the same attach target (e.g., same
cgroup). If you just want to specify cgroup to attach to, I think you
should use attr.link_create.target_fd (which is already handled a bit
lower generically)

>
> Thanks!

