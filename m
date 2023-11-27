Return-Path: <bpf+bounces-15875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D37F9749
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 02:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58896280D93
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8284ED4;
	Mon, 27 Nov 2023 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8JiKQXF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AFDE5
	for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 17:49:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332c0c32d19so2568628f8f.3
        for <bpf@vger.kernel.org>; Sun, 26 Nov 2023 17:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701049775; x=1701654575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knEq3RkKo9G1QB9NNaTmyvAmeE+nceS1zl449mesyBI=;
        b=A8JiKQXFZTBmg3Y0A+/D6tHbge0Ce4y37Rda6E9PG7s7snzvDJBq3EFHpobmKvylzW
         AQLF67oP6nrg4M72SsaAQzbHHChUtj2HGhlvcIDN5IUaU86vCrDRr9hBKae1DbwUBxap
         PQaVRVKcNt7YMsqbKI746pjo4X9AdSEnD3LnMLoEBRUnkE0OJCZmlPt7jATC1glp6q0M
         ZWqpmChwnLHqeZaOEOl1L4rGDjq6UNTYoECRPlqWwliILy/WGwTMAMdBltHbE6+tL13d
         60nB3Lu47wu5lP6y+IP+naeHI/jIKP2wf5E4rfQ9V88RYPJrcQeDYYFafkIk1bdUcAx3
         yUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701049775; x=1701654575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knEq3RkKo9G1QB9NNaTmyvAmeE+nceS1zl449mesyBI=;
        b=Ri1AHm+13zMFWo1dSBZ0f6nfFG1xZkFx4PaiD19UIh2o95VObb9RmizwLulLuOtGm3
         XJBqsF+t5ebhPoZyH6LXrXhzIbEMklrDkAgg4vhQYpbKJDvMe8mpGqTB4M5GOTdBvpzD
         HXm/zrAY/bH2AMyMr/eVjRAlk2xnX5yf7tPWh8KjYyBtSlM4TeK6GnWTbZTX8W2OdWhY
         o2ei1UCFzNpZ27wFXuzBM67qQZzOqtZV8MbZcv8BvNcOi8KQ0r0dgpwFuNCcTOEPvDNF
         wQNnsRiJO10mRgaOzkIEkKlIoP7wk80JhYKRrAKTqC8ecigrCcB9yV42otvZNIgGv7B1
         Z9Kg==
X-Gm-Message-State: AOJu0Yw95MSWFJ1KKsQwe4IybsmHn/AJOO/xZ02uwNALfaLhubNFHq4+
	/wecYr8g3jDHsXziYP3lZ+YBI8EUn7Wx7xEn6SH3ZRl4Czc=
X-Google-Smtp-Source: AGHT+IEViGmqY6ziNyA2/z8ATuozeRmWoB/n45IBZm941yOjsbWdKyxvhbkoqAo2VTMTBSAr08zXPYZ1o59jkpkrGDQ=
X-Received: by 2002:a5d:51c5:0:b0:32f:7fb1:66d9 with SMTP id
 n5-20020a5d51c5000000b0032f7fb166d9mr6512167wrv.21.1701049775098; Sun, 26 Nov
 2023 17:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124113033.503338-1-houtao@huaweicloud.com> <20231124113033.503338-5-houtao@huaweicloud.com>
In-Reply-To: <20231124113033.503338-5-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 26 Nov 2023 17:49:24 -0800
Message-ID: <CAADnVQJ8_QcisYsRVD1cz8PDHvDHzrtdHwmG21jCWogvaBQ9Lw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 4/6] bpf: Optimize the free of inner map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 3:29=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When removing the inner map from the outer map, the inner map will be
> freed after one RCU grace period and one RCU tasks trace grace
> period, so it is certain that the bpf program, which may access the
> inner map, has exited before the inner map is freed.
>
> However there is unnecessary to wait for any RCU grace period, one RCU
> grace period or one RCU tasks trace grace period if the outer map is
> only accessed by userspace, sleepable program or non-sleepable program.
> So recording the sleepable attributes of the owned bpf programs when
> adding the outer map into env->used_maps, copying the recorded
> attributes to inner map atomically when removing inner map from the
> outer map and using the recorded attributes in the inner map to decide
> which, and how many, RCU grace periods are needed when freeing the
> inner map.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf.h     |  8 +++++++-
>  kernel/bpf/map_in_map.c | 19 ++++++++++++++-----
>  kernel/bpf/syscall.c    | 15 +++++++++++++--
>  kernel/bpf/verifier.c   |  4 ++++
>  4 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 15a6bb951b70..c5b549f352d7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -245,6 +245,11 @@ struct bpf_list_node_kern {
>         void *owner;
>  } __attribute__((aligned(8)));
>
> +enum {
> +       BPF_MAP_RCU_GP =3D BIT(0),
> +       BPF_MAP_RCU_TT_GP =3D BIT(1),
> +};
> +
>  struct bpf_map {
>         /* The first two cachelines with read-mostly members of which som=
e
>          * are also accessed in fast-path (e.g. ops, max_entries).
> @@ -296,7 +301,8 @@ struct bpf_map {
>         } owner;
>         bool bypass_spec_v1;
>         bool frozen; /* write-once; write-protected by freeze_mutex */
> -       bool free_after_mult_rcu_gp;
> +       atomic_t used_in_rcu_gp;
> +       atomic_t free_by_rcu_gp;
>         s64 __percpu *elem_count;
>  };
>
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index cf3363065566..d044ee677107 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -131,12 +131,21 @@ void bpf_map_fd_put_ptr(struct bpf_map *map, void *=
ptr, bool deferred)
>  {
>         struct bpf_map *inner_map =3D ptr;
>
> -       /* The inner map may still be used by both non-sleepable and slee=
pable
> -        * bpf program, so free it after one RCU grace period and one tas=
ks
> -        * trace RCU grace period.
> +       /* Defer the freeing of inner map according to the attribute of b=
pf
> +        * program which owns the outer map, so unnecessary multiple RCU =
GP
> +        * waitings can be avoided.
>          */
> -       if (deferred)
> -               WRITE_ONCE(inner_map->free_after_mult_rcu_gp, true);
> +       if (deferred) {
> +               /* used_in_rcu_gp may be updated concurrently by new bpf
> +                * program, so add smp_mb() to guarantee the order betwee=
n
> +                * used_in_rcu_gp and lookup/deletion operation of inner =
map.
> +                * If a new bpf program finds the inner map before it is
> +                * removed from outer map, reading used_in_rcu_gp below w=
ill
> +                * return the newly-set bit set by the new bpf program.
> +                */
> +               smp_mb();
> +               atomic_or(atomic_read(&map->used_in_rcu_gp), &inner_map->=
free_by_rcu_gp);

You resent the patches before I had time to reply to the previous thread...

> I think the main reason is that there is four possible case for the free
> of inner map:
> (1) neither call synchronize_rcu() nor synchronize_rcu_tasks_trace()
> It is true when the outer map is only being accessed in user space.
> (2) only call synchronize_rcu()
> the outer map is only being accessed by non-sleepable bpf program
> (3) only call synchronize_rcu_tasks_trace
> the outer map is only being accessed by sleepable bpf program
> (4) call both synchronize_rcu() and synchronize_rcu_tasks_trace()
>
> Only using sleepable_refcnt can not express 4 possible cases and we also
> need to atomically copy the states from outer map to inner map, because
> one inner map may be used concurrently by multiple outer map, so atomic
> or mask are chosen.

We don't care about optimizing 1, since it's rare case.
We also don't care about optimizing 3, since sync_rcu time is negligible
when we need to wait for sync_rcu_tasks_trace and also
because rcu_trace_implies_rcu_gp() for foreseeable future.

> need to atomically

we do NOT have such need.
There is zero need to do this atomic games and barries "just want to
be cautious". The code should not have any code at all "to be
cautious".
Every barrier has to be a real reason behind it.
Please remove them.
The concurent access to refcnt and sleepable_refcnt can be serialized
with simple spin_lock.

I also don't like
> +       BPF_MAP_RCU_GP =3D BIT(0),
> +       BPF_MAP_RCU_TT_GP =3D BIT(1),

the names should not describe what action should be taken.
The names should describe what the bits do.
I still think sleepable_refcnt and refcnt is more than enough to
optimize patch 3.

