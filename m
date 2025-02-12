Return-Path: <bpf+bounces-51293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9547A32EBF
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DE11883F61
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC727180B;
	Wed, 12 Feb 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEq1Pq1i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60A25D52E;
	Wed, 12 Feb 2025 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385229; cv=none; b=O9T3zDoWXIdoSPb9xOxlEWKlAqbwd/Nm7fwLtHdtI+8b0JDsuHEVjv6q/gaC3cPaHoeChZfMP2kM2P9lS8CGvhpOJlNFRIo5O4KjmSjLzvXxGd6jzsXTQJGXoCpEmTXJT4+7G7Rg+bAackrbTpvAfTRAPm95iUDFZuoMBJx4T5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385229; c=relaxed/simple;
	bh=eeT+EqDAJGLasaCpXQp2LHBFYvf+/MKZIDO83RoqgjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMrlnHjkfaBg7msFKj+C+5SrKCWlbRiDFKm6WDZGlWnWYJH752QlKp/qV+82lzRPohu5Wod0H+8fQUesWnwA+lnEg6dBahcbvsXtBDdOAUNAxdYQ7Tmu94M4+gm8cuA6cKVYjt5p8X81NsMF5W+SaFS52e2U4jnx1jKTYsJi8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEq1Pq1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DBC4CEEA;
	Wed, 12 Feb 2025 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739385228;
	bh=eeT+EqDAJGLasaCpXQp2LHBFYvf+/MKZIDO83RoqgjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uEq1Pq1ibuLV8+W3GivKuwnYO+iLw+Os1qctPBl2dO12jzaqtLVjAgfOnibzYqkVg
	 sQAMWRlQVR+UDBVR3BK4RrGQoB4b5Zvi7a7mBmBXsKkqNnTv3GE4c6fG3+6prvlIC2
	 FODKCLLu24aJMy7o4XcbfF4+2LehuEwLaUR7mvVw0brF97NgQkhkFWMCyK4/S9oRbU
	 JbBssHzPi+co7MQiQJW6E4iKf0Ri7beWjK3DSJf9hLdIIll8rCZI+O7zZD5CUPvVfD
	 znBUmq0TB4m2sshWHB+MoHA8t/seTGL/AZiRjnxtBbWw/EZyVgrPLcKrxenD3c4ok1
	 TYuMzTzHjJQzA==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce85545983so121465ab.0;
        Wed, 12 Feb 2025 10:33:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUE7sm1jGOclQQSc4QdvVNqoy9VUKYRCJzJM7oZ74KRZEe/o+YiXafUh16Jn2CYmUDqDXgckrfWB6psJkuv@vger.kernel.org, AJvYcCXkF9cqWCLd50BMcOHVwn/Ob1SQdhk6Dc7gBDwMXm7wUiAJnZhFi7h/cqSEySABMVBW8p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaGV2bdfsgwZFLFM0UWfUdfLNMkynT1Gua1ppo7+JGkqidVoZ
	yWxj+gkf7J423ItKZkhyEBERbzO+6AS/+hzQSXDd4XqOPCA5ODzKlHlMEBYO6dx/0zzLnkSKr5Z
	35OWpgasOb+AmZuRl/LA2Hm07FK4=
X-Google-Smtp-Source: AGHT+IF2iZVVNy8GJabUi8Pft49OjkC5CuEnZLN7MPhVV+XB2o0k1FU9/Zv0NaQGayZdZRkUKbD14jIPjA3cVDVcmKM=
X-Received: by 2002:a05:6e02:221a:b0:3d0:353a:c97e with SMTP id
 e9e14a558f8ab-3d18c265743mr3858065ab.10.1739385228017; Wed, 12 Feb 2025
 10:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212084851.150169-1-changwoo@igalia.com>
In-Reply-To: <20250212084851.150169-1-changwoo@igalia.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Feb 2025 10:33:37 -0800
X-Gmail-Original-Message-ID: <CAPhsuW44cRU6rfrpnkdd-+6MRm7fbQ2ucnhtueaD9wBKXYnn8Q@mail.gmail.com>
X-Gm-Features: AWEUYZlm3Cp2aW_DZToa0sCL-JKSuZVSS3LcFsISd6IdJRdcv19AkyN8TWcyhLw
Message-ID: <CAPhsuW44cRU6rfrpnkdd-+6MRm7fbQ2ucnhtueaD9wBKXYnn8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add a retry after refilling the free list
 when unit_alloc() fails
To: Changwoo Min <changwoo@igalia.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, arighi@nvidia.com, 
	kernel-dev@igalia.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:49=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> When there is no entry in the free list (c->free_llist), unit_alloc()
> fails even when there is available memory in the system, causing allocati=
on
> failure in various BPF calls -- such as bpf_mem_alloc() and
> bpf_cpumask_create().
>
> Such allocation failure can happen, especially when a BPF program tries m=
any
> allocations -- more than a delta between high and low watermarks -- in an
> IRQ-disabled context.

Can we add a selftests for this scenario?

>
> To address the problem, when there is no free entry, refill one entry on =
the
> free list (alloc_bulk) and then retry the allocation procedure on the fre=
e
> list. Note that since some callers of unit_alloc() do not allow to block
> (e.g., bpf_cpumask_create), allocate the additional free entry in an atom=
ic
> manner (atomic =3D true in alloc_bulk).
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/bpf/memalloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 889374722d0a..22fe9cfb2b56 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -784,6 +784,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache =
*c)
>         struct llist_node *llnode =3D NULL;
>         unsigned long flags;
>         int cnt =3D 0;
> +       bool retry =3D false;

"retry =3D false;" reads weird to me. Maybe rename it as "retried"?

>
>         /* Disable irqs to prevent the following race for majority of pro=
g types:
>          * prog_A
> @@ -795,6 +796,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache =
*c)
>          * Use per-cpu 'active' counter to order free_list access between
>          * unit_alloc/unit_free/bpf_mem_refill.
>          */
> +retry_alloc:
>         local_irq_save(flags);
>         if (local_inc_return(&c->active) =3D=3D 1) {
>                 llnode =3D __llist_del_first(&c->free_llist);
> @@ -815,6 +817,13 @@ static void notrace *unit_alloc(struct bpf_mem_cache=
 *c)
>          */
>         local_irq_restore(flags);
>
> +       if (unlikely(!llnode && !retry)) {
> +               int cpu =3D smp_processor_id();
> +               alloc_bulk(c, 1, cpu_to_node(cpu), true);
cpu_to_node() is not necessary, we can just do

alloc_bulk(c, 1, NUMA_NO_NODE, true);

Also, maybe we can let alloc_bulk return int (0 or -ENOMEM).
For -ENOMEM, there is no need to goto retry_alloc.

Does this make sense?

Thanks,
Song

> +               retry =3D true;
> +               goto retry_alloc;
> +       }
> +
>         return llnode;
>  }
>
> --
> 2.48.1
>

