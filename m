Return-Path: <bpf+bounces-69273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD36B937E8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 00:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7459A2E1319
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B92F7AC7;
	Mon, 22 Sep 2025 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IntUQ1y2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2219A288
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580704; cv=none; b=tG/n2kCAy4Px6DLwK+yZ5yMOCWJ4PKZ+iyzWVvcZlJxaJWQg4BfYAKaWd/dsuGLjYMLvqmcFLst+Nx6s3dJXXClUepjygXQZZsTg65QzSSghYftbN+VZxwAs4iOBh+mdGxV6YpnapTQ2A+dwANpUyzJzd5rLUlrX3wL2ALs8J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580704; c=relaxed/simple;
	bh=t6Gt2zZIkJZS/kqtp/S1AKWEh2MhVkBy+nkJ62TpK4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMOdclh/F+EcVKncNqxhh7vqktlmxlyrL0jvgUt7wQeg8Ef53myIfdVs8d+jbLeuyisd038bvRN4rQ8JGU3EXu59q6i1WQbxH+YO3SbIaQZu7P114e5itWb61PWCUueeHwqDsRT9b4/zn8JwY4FGLCFyTsJ3g16QrCPvheLgfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IntUQ1y2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77d94c6562fso4931781b3a.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580702; x=1759185502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYwEszi0bEvk60svgdH1qo2zgJoVd3qxrSSLiTClCF0=;
        b=IntUQ1y2/Ss1GEZBMYTRa+r4UvVdsrLAz//Ld9GSUdOUpO4x9XXgH+J8NOIyG6ghzd
         TPrqQPeeSf/JYxKaplZQQbqKWB5ZWEvz5+KNRNq3n7GrADosmTtRxFXVTcnbjIMcZLDI
         KB50uAYCWWNVZBP6fFB7pLiM/fnDvX4/EjH6hpsT2ZFkhVxmJb2STtlENxnYqFEXZTuK
         jCNt8c4prUFqm/F+riw3q0VBqea9RdadTHiJK6kRycTGVOqbRVqo9KkD3rIb9zMgVlmU
         /YfBzWB2N2Ev6zOdXDS+u7LvKhQKNSv0WvAnbSNu8iao1AFWWmV2+HwTvlRom5iwAqOK
         lB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580702; x=1759185502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYwEszi0bEvk60svgdH1qo2zgJoVd3qxrSSLiTClCF0=;
        b=jxmxR3E7gm+cxJjSZaSEtRg0R+zRT4st9C6UaAUD2VyuMpyK0UZv+CuKHpkcbYAqnd
         BB1iKE5J2HkZPoQU28fwQaSNlHE5iy5nFvrUxV7CLvUz2PT1wc8UBhZ8VIU8bWXvXZbF
         9XXRHdoNMEGqWgkoQoH3kiJgHuS0rxjr3VaR4p9x0ifoLR+LOZrmj3a7Lbs9sNcoBDFq
         qqqWWDEhtM9BlKo+QSdxQFvwpnnXE7ZUtn1O+bSCPsr+xJzWAKKPtpor6G6IyBkUhtet
         SUNReYr5HJfDL7q/tqgNev+T2cdjQ3N0aGUbVp3pzWVFZ7gGvCQFpdE0ZNSig46DVg1+
         E59g==
X-Forwarded-Encrypted: i=1; AJvYcCXVzUmtQ5P3JiM4oV/H+bBF/Zu23ox9H5mx8FGFWtvabGz0bxxNr5qaLlWxNTG0t4iapH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRgNhYsTp45CCiOepZsilp86xAAUOxmTvQfECCLkGudCRxk+f
	8KqNKurkdakJk+SYZf9Aa42+hspJ6RR8gK6Ehib/8uVRail8fmwRvNA0Vi+kTCzp7FK5Ni7P3SJ
	spv+kqZ7rHJhRPgdXlKC+5TQPoJ83xVI=
X-Gm-Gg: ASbGnctlmV8SFumeyXly3Y5cF5eBKZRhAJBWPZmD3uvPzoMS7Huq+3cHfY3GvIsahkc
	/UnxVA8OUrxlzHqU0gKonA4YZmkfnya0Lt+K4na+MAA+Ax+26ffx2EbTmNyFoVm+aFpfqPFFQL/
	o5DmwrH4ja/f26CHLULXPNLYl3f38pl7D05LYQmJhlVLHac08EKcTqDBjLjgnaBM25OF45zSlp6
	L/rPs6gxlGrFA9p7oBMKa4=
X-Google-Smtp-Source: AGHT+IEQFQoR0QNM+odyEnMBpN2MGkliZTtUBGe+w3ytXVYziHfuQhgLsKdv5BNowAYLiyY7wV4AXhYJ9qjm2ktFWOQ=
X-Received: by 2002:a05:6a20:a11f:b0:243:c6d1:776c with SMTP id
 adf61e73a8af0-2d006a3c80bmr827377637.21.1758580701881; Mon, 22 Sep 2025
 15:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912233509.74996-1-contact@arnaud-lcm.com> <20250912233558.75076-1-contact@arnaud-lcm.com>
In-Reply-To: <20250912233558.75076-1-contact@arnaud-lcm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 15:38:07 -0700
X-Gm-Features: AS18NWB3UGvFDrhuRjJsFHHzijhXB-nXkC4Q0Y6-LlxGpZGShaH_bAayBzyNlyQ
Message-ID: <CAEf4BzaoCOUofb8xzpuxT0Lg+XwdLiW1uEZURqhy_mZzigx63w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/3] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: alexei.starovoitov@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, 
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 4:36=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lcm.=
com> wrote:
>
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid(=
)
> when copying stack trace data. The issue occurs when the perf trace
>  contains more stack entries than the stack map bucket can hold,
>  leading to an out-of-bounds write in the bucket's data array.
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc9b724fbb41cf2538b7b
> Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommoda=
te skip > 0")
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
> Changes in v2:
>  - Fixed max_depth names across get stack id
>
> Changes in v4:
>  - Removed unnecessary empty line in __bpf_get_stackid
>
> Changes in v6:
>  - Added back trace_len computation in __bpf_get_stackid
>
> Changes in v7:
>  - Removed usefull trace->nr assignation in bpf_get_stackid_pe
>  - Added restoration of trace->nr for both kernel and user traces
>    in bpf_get_stackid_pe
>
> Changes in v9:
>  - Fixed variable declarations in bpf_get_stackid_pe
>  - Added the missing truncate of trace_nr in __bpf_getstackid
>
> Link to v8: https://lore.kernel.org/all/20250905134833.26791-1-contact@ar=
naud-lcm.com/
> ---
> ---
>  kernel/bpf/stackmap.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 9a86b5acac10..ac5ec3253ce6 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -251,8 +251,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  {
>         struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack=
_map, map);
>         struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> +       u32 hash, id, trace_nr, trace_len, i, max_storable;
>         u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> -       u32 hash, id, trace_nr, trace_len, i;
>         bool user =3D flags & BPF_F_USER_STACK;
>         u64 *ips;
>         bool hash_matches;
> @@ -261,7 +261,9 @@ static long __bpf_get_stackid(struct bpf_map *map,
>                 /* skipping more than usable stack trace */
>                 return -EFAULT;
>
> +       max_storable =3D map->value_size / stack_map_data_size(map);
>         trace_nr =3D trace->nr - skip;
> +       trace_nr =3D min_t(u32, trace_nr, max_storable);
>         trace_len =3D trace_nr * sizeof(u64);
>         ips =3D trace->ip + skip;
>         hash =3D jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
> @@ -369,6 +371,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_=
data_kern *, ctx,
>  {
>         struct perf_event *event =3D ctx->event;
>         struct perf_callchain_entry *trace;
> +       u32 elem_size, max_depth;
>         bool kernel, user;
>         __u64 nr_kernel;
>         int ret;
> @@ -390,15 +393,16 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_even=
t_data_kern *, ctx,
>                 return -EFAULT;
>
>         nr_kernel =3D count_kernel_ip(trace);
> +       elem_size =3D stack_map_data_size(map);
> +       __u64 nr =3D trace->nr; /* save original */
>
>         if (kernel) {
> -               __u64 nr =3D trace->nr;
> -
>                 trace->nr =3D nr_kernel;

unnecessary, you'll be overriding it two lines below

> +               max_depth =3D
> +                       stack_map_calculate_max_depth(map->value_size, el=
em_size, flags);

here and below, keep on the same line, it's under 100 characters

> +               trace->nr =3D min_t(u32, nr_kernel, max_depth);
>                 ret =3D __bpf_get_stackid(map, trace, flags);
>
> -               /* restore nr */
> -               trace->nr =3D nr;
>         } else { /* user */
>                 u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
>
> @@ -407,8 +411,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event=
_data_kern *, ctx,
>                         return -EFAULT;
>
>                 flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> +               max_depth =3D
> +                       stack_map_calculate_max_depth(map->value_size, el=
em_size, flags);
> +               trace->nr =3D min_t(u32, trace->nr, max_depth);
>                 ret =3D __bpf_get_stackid(map, trace, flags);
>         }
> +
> +       /* restore nr */
> +       trace->nr =3D nr;
> +
>         return ret;
>  }
>
> --
> 2.43.0
>

