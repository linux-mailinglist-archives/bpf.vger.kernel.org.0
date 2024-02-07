Return-Path: <bpf+bounces-21383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 684B884C1A9
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 02:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D491F24325
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447763CF;
	Wed,  7 Feb 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkNRQEq9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706B46A0
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268015; cv=none; b=nVQgY8EvkGbFYw0QFgyI9/gxtdCpo9iIXjX0GZwMWSZOgxsXh3zG10fYVVJC26JRtV9uUKuKw1JoO4YgSc/a58Kb+eqDMwKULWfnLceGjN5olvZY3SJrxk0D3pgHRXfKBnOrkVnXNn3OC1ksXVCXAaS0An9F/izY47rqDweHV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268015; c=relaxed/simple;
	bh=pRNVZL2ABtOU9M+0rUFkKN7w+ILTwrOD4bDPcSNpPAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF/g8IPMmew02u3G5fyxWFV9FwhcUQ9l464chKlo+y0FrPs+o5+w3k+bDNiv9nsA/LIvEOZKC1Y9WbpOODvLO+rkdxGcGbnz5xtrDCwiJzr9Qj9dD1km9drVu7u2naBG0AKVTP/utwh+aclUxP0bwVkCQlPMTyVe/32F4rcOkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkNRQEq9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394b892691so59357f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 17:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707268011; x=1707872811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M743qlztkGkb1GUPi2bUehmjk3/IHNjzAp3P4jHdo1U=;
        b=FkNRQEq9G0Yvgaztj+4bLApKVCWrERTRAjK6kGZQEFjsCR2UQc7QmTvBFqmesDhX/u
         +/nZGyGIzjptvHnmnQYBzSnL+8uAA3bARnG11j5Tlqahv/Xm3EpSShAwXbnPeJ424DV5
         SPucS4kpDQiP8zaaKnDx/B88A/zIyuOU6NovFw1ktl4BRpcKQE6/TEnz8ZHb7F2aKNVx
         Vv2UUA4I1DcH6+gzvjRJkme+2GRdiv7wEREKavhF6yyVEuebWmILgU4xB22o+D87/XTj
         OnVqEz2JOSmpwQob0+k5PZXSVFFMtnVQVCO8gy4vHgYeiZAsDCviADpSkTAOoefPRyOu
         Kxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707268011; x=1707872811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M743qlztkGkb1GUPi2bUehmjk3/IHNjzAp3P4jHdo1U=;
        b=kBDEBYlbj0LKerTp6Pecbug6GL36mdZRh6qnSwTwxg22Cg78rIRSil9KYRKg4r1URE
         33SnDfL6LOf3Lt7oS+CFtFmS59gI78N05V6egE9nZw4toxxYmEAdtT2ULN8VzC3T5lF/
         Ow1KIT2Ws/9epkkFkBR5jyjXh7hQ2QklmYN529AwUJWLEcpMetxjMED9QO2xC0NwivrR
         tQZrPyw5+dA6NbXOz/p5XlJhaYDmU6II/q1yuIBl8r+6kUUmRQS6InFJiZhFEKClEg4B
         BJNm1DJislqIr9GWRfWYeFU8/cfyemzKfZy83sepIk76dn+hFztpDtzLoSvuuKSoZzbO
         0WGA==
X-Gm-Message-State: AOJu0YyzHLDpNKLNSYTxCy0j6cn++tg9s14msMll3moAajToWibT3SEG
	g5q67F2xHXsdN8MAlWpDqumTfSabMNebUrk8yk3b4AsgKyvFiguQRz2ZWbhxQPZudftVA0zXQZY
	0pYdr1uwbGdCrxQcFJZUlBti7/S4=
X-Google-Smtp-Source: AGHT+IEdasumBGEM0fUtLAo7Z1hfTudX/oadvTEyG38D6/GM4kOXNbKETj5fJt9Hd2Pr85K+/IslKXywT6aH63JUNC8=
X-Received: by 2002:a05:6000:f:b0:33a:f503:30b3 with SMTP id
 h15-20020a056000000f00b0033af50330b3mr2440825wrx.24.1707268011262; Tue, 06
 Feb 2024 17:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206081416.26242-1-laoar.shao@gmail.com> <20240206081416.26242-2-laoar.shao@gmail.com>
In-Reply-To: <20240206081416.26242-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Feb 2024 17:06:40 -0800
Message-ID: <CAADnVQ+n0xDB5=+bpTiuAaHQ7UJAzQVQKkyuNSOxaPyOhHWYBw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bpf_iter_cpumask kfuncs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:14=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add three new kfuncs for bpf_iter_cpumask.
> - bpf_iter_cpumask_new
>   KF_RCU is defined because the cpumask must be a RCU trusted pointer
>   such as task->cpus_ptr.
> - bpf_iter_cpumask_next
> - bpf_iter_cpumask_destroy
>
> These new kfuncs facilitate the iteration of percpu data, such as
> runqueues, psi_cgroup_cpu, and more.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/cpumask.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index dad0fb1c8e87..ed6078cfa40e 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -422,6 +422,82 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpum=
ask *cpumask)
>         return cpumask_weight(cpumask);
>  }
>
> +struct bpf_iter_cpumask {
> +       __u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_cpumask_kern {
> +       struct cpumask *mask;
> +       int cpu;
> +} __aligned(8);
> +
> +/**
> + * bpf_iter_cpumask_new() - Initialize a new CPU mask iterator for a giv=
en CPU mask
> + * @it: The new bpf_iter_cpumask to be created.
> + * @mask: The cpumask to be iterated over.
> + *
> + * This function initializes a new bpf_iter_cpumask structure for iterat=
ing over
> + * the specified CPU mask. It assigns the provided cpumask to the newly =
created
> + * bpf_iter_cpumask @it for subsequent iteration operations.
> + *
> + * On success, 0 is returned. On failure, ERR is returned.
> + */
> +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, const =
struct cpumask *mask)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct=
 bpf_iter_cpumask));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> +                    __alignof__(struct bpf_iter_cpumask));
> +
> +       kit->mask =3D bpf_mem_alloc(&bpf_global_ma, cpumask_size());
> +       if (!kit->mask)
> +               return -ENOMEM;
> +
> +       cpumask_copy(kit->mask, mask);

Since it's mem_alloc plus memcpy how about we make it more
generic ?
Instead of cpumask specific let's pass arbitrary
"void *unsafe_addr, u32 size"

allocate that much and probe_read_kernel into the buffer?


> +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +       const struct cpumask *mask =3D kit->mask;
> +       int cpu;
> +
> +       if (!mask)
> +               return NULL;
> +       cpu =3D cpumask_next(kit->cpu, mask);

Instead of cpumask_next() call find_next_bit()

> +       if (cpu >=3D nr_cpu_ids)
> +               return NULL;

instead of nr_cpu_ids we can check size in bits of copied bit array.

> BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)

KF_RCU is also not needed.
Such iterator will be callable from anywhere and on any address.

wdyt?

