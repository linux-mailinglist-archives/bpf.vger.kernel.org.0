Return-Path: <bpf+bounces-21088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A931847BF2
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1921F22B11
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53583A0C;
	Fri,  2 Feb 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BinMnyuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4D83A07
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911390; cv=none; b=GxhFZbPem+ma/ugawyYRp/a1KyaVPBcL7SWq80GcEwU5R1a+XVn7ePu35BWVEljZ6xVzDcP5lGgXt0p36e5leuaiG/I7HPbS6kHUhAaBky/fvGSELdaWGkn9eqN2SeS8nM6PkQSbrpEvfYOkm3MwCmIMqIHz3DvFvQ+vs0yD9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911390; c=relaxed/simple;
	bh=0Ryb2SgCHflLiT2wOrsqsHGecyquoTRbaml3oexUA2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE24qLsHO/43k/Y8eLkwCJDTBIqoDj8nm6/1RB1/sgcgZagjv3mX4Pmdi3IQmddpfUDHwKiiEaPKSl9Kcgo7Rp1y794aJk8dbiUwsWUvz+MzNBQAFdl2jGpYpKWG+yqOFiEVH0K7dkxiWMxufPs7lQKn+4br4HnOIspNgGMT8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BinMnyuP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e02597a0afso256285b3a.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911388; x=1707516188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TCwSoharfFq6B8R/QE6CJNA8pH5fv624pRPqdb8mvw=;
        b=BinMnyuPE3RbK7jI10qRe8ICEw5bEntkS9eEDPEp6C732Jz6S5dwvyuo5FYiIodCXL
         3VwRXPw9XGVSfDW910V/b3VoMXgOW49MA9MdSGngv1smYJg7R5w3d4/mxUU1DFVfZkpD
         V/CzcyiP8ewjeeyV0tzbEEsrHrk0/2lOuuwKko1LvobOVxRUQ5/fS27D2wtg9EcwX9Bt
         MtLxTKK+Vc2Xz3t0HtjhjZCazmzYDSLvoaKEKim8/mnE4aUZhnSC30E0Msl7K77DRRFO
         M6EYXVbybUvFyRPDhhbUYVyhvepbbh0f58ANF9FafGP6KFiyD8AAnGkgZvxUZSSdsFTH
         K2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911388; x=1707516188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TCwSoharfFq6B8R/QE6CJNA8pH5fv624pRPqdb8mvw=;
        b=NTvfTnlA2FuAK67mH/ZnKcxmWo/W6/UdT2sXaYElw7B4CVL6e4aSXXk5fMga1ZA9M+
         ueP7hFYFsm79GoObDQgtuPW8kgKNADcPK0UcnwWAfksfmcVl9H2Cjs0ZVjPIYFzCerNq
         y14BVlghTn8ToNq95ypeMV/E0WSRjA3aKyCJHYiV0TqbNFmba6HpzL+ImFlvWVYOWv4w
         9yOsTvHUtdSD0z8wcD9c6PBdGhjhnZdooEgbmZuth8Ev9sJheGRBNmkYUdHa/7612CgS
         QfPqgghcUDkV2N1GEnh6A6tVi2EB1VLpXPVEqADtdB98wH5+RnF35ieqkyggUwVZGMsY
         VK7g==
X-Gm-Message-State: AOJu0YxosETRad41vSyaQKxrksnXfIcba2rs/E776un7wHnTW2s3e/cO
	/Fo/cRVU2eg55tQNU8xc+CwiMVTujrvZdlkQttnz+nlL48TqsK9xZbaZP7FnOLJAob1cy00otIt
	AArFfT1eSxE9crtke5n3MuA82IKf0TceZ
X-Google-Smtp-Source: AGHT+IHApi3paLMrfbF+yVwnUDonfJyr6foGp/xtnhJTXrP+HR2wGhM82+XsWMiRXPA8B4ggiM2lZeDCvVD5ZgDEvVo=
X-Received: by 2002:aa7:8059:0:b0:6de:1e25:48e8 with SMTP id
 y25-20020aa78059000000b006de1e2548e8mr3373114pfm.14.1706911388197; Fri, 02
 Feb 2024 14:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131145454.86990-1-laoar.shao@gmail.com> <20240131145454.86990-2-laoar.shao@gmail.com>
In-Reply-To: <20240131145454.86990-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Feb 2024 14:02:54 -0800
Message-ID: <CAEf4BzYwyFyydjNie4OfEUF0epV=ejcUCtuR6bZBJgk=8BX0wQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Add bpf_iter_cpumask kfuncs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, void@manifault.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
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
>  kernel/bpf/cpumask.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 2e73533a3811..c6019368d6b1 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -422,6 +422,85 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpum=
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
> + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a specifie=
d cpumask

I'd say "Initialize a new CPU mask iterator for a given CPU mask"?
"new bpf_iter_cpumask" is both confusing and misleading (we don't
create it, we fill provided struct)

> + * @it: The new bpf_iter_cpumask to be created.
> + * @mask: The cpumask to be iterated over.
> + *
> + * This function initializes a new bpf_iter_cpumask structure for iterat=
ing over
> + * the specified CPU mask. It assigns the provided cpumask to the newly =
created
> + * bpf_iter_cpumask @it for subsequent iteration operations.

The description lgtm.

> + *
> + * On success, 0 is returen. On failure, ERR is returned.

typo: returned

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
> +       kit->cpu =3D -1;
> +       return 0;
> +}
> +
> +/**
> + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
> + * @it: The bpf_iter_cpumask
> + *
> + * This function retrieves a pointer to the number of the next CPU withi=
n the

"function returns a pointer to a number representing the ID of the
next CPU in CPU mask" ?

> + * specified bpf_iter_cpumask. It allows sequential access to CPUs withi=
n the
> + * cpumask. If there are no further CPUs available, it returns NULL.
> + *
> + * Returns a pointer to the number of the next CPU in the cpumask or NUL=
L if no
> + * further CPUs.

this and last sentence before this basically repeat the same twice,
let's keep just one?


> + */
> +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +       const struct cpumask *mask =3D kit->mask;
> +       int cpu;
> +
> +       if (!mask)
> +               return NULL;
> +       cpu =3D cpumask_next(kit->cpu, mask);
> +       if (cpu >=3D nr_cpu_ids)
> +               return NULL;
> +
> +       kit->cpu =3D cpu;
> +       return &kit->cpu;
> +}
> +
> +/**
> + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
> + * @it: The bpf_iter_cpumask to be destroyed.
> + *
> + * Destroy the resource assiciated with the bpf_iter_cpumask.

typo: associated

> + */
> +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +       if (!kit->mask)
> +               return;
> +       bpf_mem_free(&bpf_global_ma, kit->mask);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_SET8_START(cpumask_kfunc_btf_ids)
> @@ -450,6 +529,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
>  BTF_SET8_END(cpumask_kfunc_btf_ids)

Seems like you'll have to rebase, there is a merge conflict with
recently landed changes.


>
>  static const struct btf_kfunc_id_set cpumask_kfunc_set =3D {
> --
> 2.39.1
>

