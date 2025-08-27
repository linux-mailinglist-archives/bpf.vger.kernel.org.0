Return-Path: <bpf+bounces-66744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62941B38EFF
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FAA189ED4A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DCB283159;
	Wed, 27 Aug 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1k5/8Bk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC030CDA6
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336692; cv=none; b=GMbWZP5aBuQLJlVCawOAlj1tyW9jkYwE4clPSsFfvS6mQIiOmd9Nmv+M77bQECLVlFRpiK1QnXXORoRa7pY8a4T4QRkN7tELtF2BE80EomdPhm+cBapbBKVaYG0v2Ra4vOPljgFRUYx6+UjFjQloHLopPXcKE6chHeMykYCKMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336692; c=relaxed/simple;
	bh=2CMawNZOgvnnFXX+ZaoK3qiGFg2UwK1N6cBdyZ8JD4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HloIqDNId3M459krHd7B8mnckrKk0AnkjcriNXdvO+NPxuTyHfwalOO0qOtSEQtRIwZrY1G9mO7XW+4l1BFtYFTkop3TZQbE6r5A8cu4YGrhztVONsLJbbniFEuDE1ec0XvAYfMYPEFPpcYRrjX8bE5jVHfu/jEqF6tf0W1ICwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1k5/8Bk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266d6f57so421300a91.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336690; x=1756941490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUgSSWZgjnMaYmVlcD/X2Os5itWL2DPqp4ZGn6vNMP0=;
        b=a1k5/8BkqxgYmgmlAu10f0efCtPe1w0ZLY3wCxr5ROUBsvjjS/8HIDgKzOqpVvbJ37
         dZFHjBNZLjHxh21DXm4vH6V1ZztXTvPZNa0ZVnlPTlNv8WY7gyY9xgo3GR7yulDPPRRu
         vMNt6iSz/46VEG5ge4HWF2GJrhWTm+oEjKFypAMjUc/C95SOdxIYyVtVJG+HUqfXR/uz
         p+YUXkpkmnfz1d1Z/dJiKM9sadete0oMIzv/dfVaNf8k9xTP2lTilV1xlCZjE8LZnnwJ
         R565usLXDXYvqv1XwvjfEon06Mk33eU7V2vKSh3yPG5WPQWwtpftWV0YhzORlG7lrrmH
         0IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336690; x=1756941490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUgSSWZgjnMaYmVlcD/X2Os5itWL2DPqp4ZGn6vNMP0=;
        b=Hs7BmiQDTHuNhRUgkJRXjDhnK0Sbo0R+unWoIYCmlh0U0Zc3pFMGSgNUyTMp1Be0Ug
         ON53xmfwQhy45p41JTpIcaOew1I/5ZtOJdNcTtF4Fvt8/atXcpjh7SZRezyLUsAcmfX3
         xkJ3SrmdG/0OnrcQTPcHdLh+m68//Ne7Q97KRDU5y+7lnuRq9gGCzGP/rV6vzP5BA3LW
         a0YpgoCZ/Az04CxRh6209PtdYeDMVv3HB5kHllmEzkan8lxf2WLq2V1+BijHEjYdRtOl
         mYXKcnyvvXX1uahC2TsuGpgBXrqvLpsscZxHed6o2Bf/R/ejp9qzIQuZGV+dzi0QHxyT
         fdVA==
X-Gm-Message-State: AOJu0YxDZI6x+/DL9eVnHaA+vfjoArhc1CsW8NKqIO9SQhMWSxLaQYjx
	THlvP5KBGo+6FXYNzdtljKITJl3zilgDkh4/t20tWrmDttvv2j5jSCOrhKwlpsUs5/gv7e2YHPn
	p7c6iEg/cs38WcFkeMlIiBV7UxbzpcGk=
X-Gm-Gg: ASbGncsMd5BJTu2yWlKDLRuift2Hfa9474XthiWrdc0CG+75ZRUTX8snDMmrSZce50D
	I6I7od4APdWB71zyV1TpcTK7lVT9Sy8Ch3ZwQHtk3mpmq8gsVi3N1do2bLPsxCZldE/KJ2Qe22J
	txym+L1xPnyYJU34vdbnkG+T0Yg3U7Cv73IQSdHqBiwBLrrivLKDOq1UZR9ihgy6yNbxXX+nxlh
	Fqe9JPLvJ13+dayhfvejNIEubltatILrg==
X-Google-Smtp-Source: AGHT+IGbpHDbBHWAfgQ9FGw3eFlgZyViGxNXFajsv6vRxoyMGR9TvGWPkk/or1O66MVhbc+mJhCOd8EhuuNY9eVGhZg=
X-Received: by 2002:a17:90b:3948:b0:325:46f4:4f6e with SMTP id
 98e67ed59e1d1-32546f450b5mr22602690a91.32.1756336690249; Wed, 27 Aug 2025
 16:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827164509.7401-1-leon.hwang@linux.dev> <20250827164509.7401-2-leon.hwang@linux.dev>
In-Reply-To: <20250827164509.7401-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 16:17:55 -0700
X-Gm-Features: Ac12FXzsao6W4k7blKWvWT_SsEiVOfxtBzuvmdq5c968JImgR5bxYoNqe36q1JA
Message-ID: <CAEf4BzbuhaWSE6-1fnxYhUX_6iaBvrr6Q1Mq05MhuxE7U4_63A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: Introduce internal
 bpf_map_check_op_flags helper function
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> It is to unify map flags checking for lookup_elem, update_elem,
> lookup_batch and update_batch APIs.
>
> Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
> flags in it for these APIs in next patch.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h  | 28 ++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c | 34 +++++++++++-----------------------
>  2 files changed, 39 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a89..512717d442c09 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3709,4 +3709,32 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, =
unsigned long ip, const char *
>                            const char **linep, int *nump);
>  struct bpf_prog *bpf_prog_find_from_stack(void);
>
> +static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags,=
 u64 extra_flags_mask)
> +{
> +       if (extra_flags_mask && (flags & extra_flags_mask))

doh, Leon... when extra_flags_mask =3D=3D 0, `flags & extra_flags_mask` is
always false, so just:

if (flags & extra_flags_mask)
    return -EINVAL;

But it feels more natural to reverse the meaning of this and treat it
as extra *allowed flags*. So zero would mean no extra flags should be
there (most strict case) and ~0 would mean "we don't care or will
check later". And so in the code you'd have

if (flags & ~extra_flags) /* check for any unsupported flags */
    return -EINVAL;

But I need someone else to do a reality check on me here at this point.

> +               return -EINVAL;
> +
> +       if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BP=
F_SPIN_LOCK))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 fl=
ags)
> +{
> +       return bpf_map_check_op_flags(map, flags, 0);
> +}
> +
> +#define BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK (~BPF_F_LOCK)
> +
> +static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 fl=
ags)
> +{
> +       return bpf_map_check_op_flags(map, flags, BPF_MAP_LOOKUP_ELEM_EXT=
RA_FLAGS_MASK);
> +}
> +
> +static inline int bpf_map_check_batch_flags(struct bpf_map *map, u64 fla=
gs)
> +{
> +       return bpf_map_check_op_flags(map, flags, BPF_MAP_LOOKUP_ELEM_EXT=
RA_FLAGS_MASK);
> +}
> +
>  #endif /* _LINUX_BPF_H */

[...]

