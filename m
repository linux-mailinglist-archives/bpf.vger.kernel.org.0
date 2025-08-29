Return-Path: <bpf+bounces-67020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F30B3C1BB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1015A1153
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A1341ABA;
	Fri, 29 Aug 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC4+UYJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA08101DE;
	Fri, 29 Aug 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488577; cv=none; b=Rk4DpPILwadYIRO9E1LbBfyMWwLG8/Ur3UXnfe1/FxxCE/XGDEms9unUPlVfTbGDuXTgJYCGhqfzCjpMn9b1q0Lx8SCaebC6eBAWC3GkkzPnUXOelw3HCHxuS+sAVQHRBtD6uXnymX5jFrIFwXyUklpOuWeVZ8hQUATj+MzCDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488577; c=relaxed/simple;
	bh=sEnuUj7Sr3bpuLOAgNEHB9VqYw21ZHzMro9c5/zGMe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uO9PWfKVpotEsG7OlT4YD3MsihGwpWugiecwBc6nCFgRKElXPlmmju2kyt2/gz3n+BKMommcUct9eYgPyejPfdXPR7jm6T1FsGhm+ZE7o762V0S5LxxdubgfjlLH6O1mKiuOP/85Eq1hEuY0LRmiKeSw/frs8qOJDDQ8qoRCdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC4+UYJz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so7349715e9.1;
        Fri, 29 Aug 2025 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756488574; x=1757093374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utt8v41OqdwcXNTs60r1yAh67/DGb5v/X1J5aTwQAjM=;
        b=kC4+UYJz66bYB3wUQ1XFC2lykfuoXSdExhNUIQIDVmDfPrgXaI9c6MzkBDFn2Oy2l2
         5zz+Gt6UuVjelDGOlIwT62d+N8OXJwTvk/5DRNM/bwRR9jfT4VY0sbyF9xbL7N42aeAK
         rYFvK9hC1xB3w70ddZ75s6xmezcYwIUtQiM+MYuiH7pPcf+Y/HxqfFax8f/NPAiQ5fp6
         OCZs7LNWP1KX8QfaKi3fOgIbDhlOiHKvbcqjPyXVcgRR4CrvcDVR+262lWRUR/3Xu/Ks
         JqBrp4MGrsVXC3F7+vKc8zK46IWNcmDJWdBz+yDf/xlUA6IpyTmEmVJbAoc68DwJpf8o
         WCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756488574; x=1757093374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Utt8v41OqdwcXNTs60r1yAh67/DGb5v/X1J5aTwQAjM=;
        b=dnvgQibvPGjrSYuNOw6/eszaA92zBO2pclxmPFOqz5xEbZWxK6/dffsOEusPN8Hfil
         7qcCF75tknV+gxkhMQYTnzglCdD6hAm4jfl46ES9l9gcMA3/3iwexZJVE9eek+Z1i73C
         B7qj56fMPiZVFR/P6wf2KvBrjksnUYlWijSkJwCrmOmcdVJFQtK81HtRvXu9cI5TThp4
         cyKh17UoZZa2a6riY4cWQxi4BK97Q3wMWO2JYxNRq2NtdhVo3a9xDg6fd23fYgzKM1Xa
         uo/2Xww+9eiWOsUWLGupcIAnGlCIn17Hhk6hCR42oyAf/+vtsPE2q7hmW/BDYSWInJeu
         GKmg==
X-Forwarded-Encrypted: i=1; AJvYcCVYZTLgxbJOgldNdS6qgGPIFQ5A+gyj7qug5tHu88Ag6dHaU4rnrQ+Gyr5w9cLjqxFY+6Y71QBpvAEi1mro@vger.kernel.org, AJvYcCXhErfnqLtzX4wV5FPbkOmaGDwnP6CSRbJZ8j6xERO+AA0+nJUEnx74edcziKNUmIUsckU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTXn+hgK6+4D/12jOFp/y7kYkSJ/2M3SJ20ndqGz2Jy2eq7Li
	y0qW6u7neojsmvLPML5gGj9mErIUkyelxuVPGrHd0BAtVUa+cw+xFpkDyHsxCAI3cLi59gakeDL
	u/E6Q7kcoWEclpHig5Tzg2sdSF4lddmw=
X-Gm-Gg: ASbGncvzSAegcYCInHo+LrnriUyaQdszxeFyh+q85Ph7ns1Isz+mzpMbYjsx6RVEQlE
	/DFcGFW+C1IuzGx8juGwO90Vpgbpb8Z4xLSFtaUuZAko+aUuEdb5akn0ZQ4ti/eAaJQdG8sJlO2
	NdwZZHt49SNguFyhoUeRI/Gwt5c+knHk+voTS4BmJlwrOIFIgfoZBWNJMQXJyX7cFjvwo850Fb4
	Ggc7JrOjdUqh4zpOhZe4jVzHfaHgAKcMQ==
X-Google-Smtp-Source: AGHT+IFNeYFEufRu7GlQAG34ccBuuU6fVaBDYaah0lvyX3Fra4LvLOgCbZ8MwIHdQ+fWQnnlw/Aihzp1M95/a2jbQPQ=
X-Received: by 2002:a05:600c:46cf:b0:456:43c:dcdc with SMTP id
 5b1f17b1804b1-45b517dd96dmr238318245e9.33.1756488573448; Fri, 29 Aug 2025
 10:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826212229.143230-1-contact@arnaud-lcm.com> <20250826212352.143299-1-contact@arnaud-lcm.com>
In-Reply-To: <20250826212352.143299-1-contact@arnaud-lcm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Aug 2025 10:29:20 -0700
X-Gm-Features: Ac12FXxLyJEHbYO01cWHleEDLGMX8X5FnZGa6gNqD0GXFVdNlDxekK2ZmgESRjM
Message-ID: <CAADnVQ+6bV3h3i-A1LHbEk=nY_PMx69BiogWjf5GtGaLxWSQVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:24=E2=80=AFPM Arnaud Lecomte <contact@arnaud-lcm.=
com> wrote:
>
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid(=
)
> when copying stack trace data. The issue occurs when the perf trace
>  contains more stack entries than the stack map bucket can hold,
>  leading to an out-of-bounds write in the bucket's data array.
>
> Changes in v2:
>  - Fixed max_depth names across get stack id
>
> Changes in v4:
>  - Removed unnecessary empty line in __bpf_get_stackid
>
> Link to v4: https://lore.kernel.org/all/20250813205506.168069-1-contact@a=
rnaud-lcm.com/
>
> Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc9b724fbb41cf2538b7b
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 796cc105eacb..ef8269ab8d6f 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -247,7 +247,7 @@ get_callchain_entry_for_task(struct task_struct *task=
, u32 max_depth)
>  }
>
>  static long __bpf_get_stackid(struct bpf_map *map,
> -                             struct perf_callchain_entry *trace, u64 fla=
gs)
> +                             struct perf_callchain_entry *trace, u64 fla=
gs, u32 max_depth)
>  {
>         struct bpf_stack_map *smap =3D container_of(map, struct bpf_stack=
_map, map);
>         struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> @@ -263,6 +263,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
>
>         trace_nr =3D trace->nr - skip;
>         trace_len =3D trace_nr * sizeof(u64);
> +       trace_nr =3D min(trace_nr, max_depth - skip);
> +

The patch might have fixed this particular syzbot repro
with OOB in stackmap-with-buildid case,
but above two line looks wrong.
trace_len is computed before being capped by max_depth.
So non-buildid case below is using
memcpy(new_bucket->data, ips, trace_len);

so OOB is still there?

