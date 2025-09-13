Return-Path: <bpf+bounces-68283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB5B55A8E
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 02:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4685C0A86
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6401D4A04;
	Sat, 13 Sep 2025 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZruUw4f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACAA59
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722327; cv=none; b=KbNGbUJckp3cOYhG25e3LDpet4h1PpdnrrBIo9P7RG+NyhZHS1Al/YT3sjY6eQ+qmw1AF1No4cZdC6ryAu2pSGNRImbIPwRMIFulTMmZLTi2etVTuqXPVvZJQTnqtFHX5RXXIkWOx2Njr6p3CSmM3NOPLkEXjhn/3fmNF5vYsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722327; c=relaxed/simple;
	bh=WB5TOJtMW3h+GuYaL/izz3E14BoEMKkYzRjqP9SFXlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7tQqCcgpYIJwEgWJ6oEHDzr4eivTLFzZXl1vhbEfPTnQzh6JRj6gScFDRc68TQkNpLzSe1Z8TqJiIHzDzaL9oFnmsXYpwK6Z8Q4Xz2Pv86MzzgDmsims1PXAf/yRjHCsEtWN65ivWh9RcY7GQutOaAevueRwUTdn6kIwgwfYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZruUw4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752F5C4CEF9
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757722327;
	bh=WB5TOJtMW3h+GuYaL/izz3E14BoEMKkYzRjqP9SFXlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KZruUw4fP4wRc7jPpcf4VgYHrnQT6LIIHFQB/QxYEcutyW06Y+TbgRm1jREA2uwcc
	 zCeYsBQ570XiITWIwkXPgYY4yLeoKGy0GThh2tEGl2yLaAdkj3t07NMJJQBQ+UTnsG
	 OJSelI294Fc8K6BfPJpBs1DBT2u6QH8gNdwhVQS9i7RyaMivg6YQpRsy/jjNoCr8sv
	 ZtLvgAVJDZgX3ZUBo4I6cVl7OEfq3NVWR7LFjHKPM3wLfU/Npev9OfDqcwvs3KAu2R
	 Qb84kseOs9LYsXlGMQyhBKy+3nBeqB0BbAqed8zchKG+XepOUz3NtkZm6s6tSP6cns
	 XEygswxvEJsKQ==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8116af074e2so225740885a.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:12:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YwBKsrOnh+d+maHPT+I6+rMNs4lRcTcKs2Ti5BVjpQi2jF0p/r1
	XU4JbxeOKBiloShWqDqR0tjavggmLKOPLuhvF3pwGnRgAigCw+6/+B1wkpyTvXge0hhIzMUQceD
	JhjmlhVeqelZLql9LVKVxjI7o35K+r30=
X-Google-Smtp-Source: AGHT+IF+cYBBF4ywlJ9yslWSLlw3gny6F5tzpvcjxcpdDnw0945XcqUOCZLT3qoeAnYVE/yCviZrCOlwQNcK4h27VFk=
X-Received: by 2002:a05:620a:1794:b0:815:2cc1:ed37 with SMTP id
 af79cd13be357-82404ba17bamr649870985a.86.1757722326540; Fri, 12 Sep 2025
 17:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
In-Reply-To: <20250912222539.149952-2-dwindsor@gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 12 Sep 2025 17:11:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
X-Gm-Features: Ac12FXzJeDfs8WQpSjWmoLJJrMKDVwMS6T8FuLd0g8xpZTMpLK5rqKm9ncM5Jz4
Message-ID: <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:25=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> All other bpf local storage is obtained using helpers which benefit from
> RET_PTR_TO_MAP_VALUE_OR_NULL, so can return void * pointers directly to
> map values. kfuncs don't have that, so return struct
> bpf_local_storage_data * and access map values through sdata->data.
>
> Signed-off-by: David Windsor <dwindsor@gmail.com>

Maybe I missed something, but I think you haven't addressed Alexei's
question in v1: why this is needed and why hash map is not sufficient.

Other local storage types (task, inode, sk storage) may get a large
number of entries in a system, and thus would benefit from object
local storage. I don't think we expect too many creds in a system.
hash map of a smallish size should be good in most cases, and be
faster than cred local storage.

Did I get this right?

Thanks,
Song

The following are some quick feedbacks of the patch, but let's
first address the question above.

This is hitting KASAN BUG in CI:

https://github.com/kernel-patches/bpf/actions/runs/17687566710/job/50275683=
479

(You may need to log in GitHub to see details).

[...]

> +
> +__bpf_kfunc int bpf_cred_storage_delete(struct bpf_map *map, struct cred=
 *cred)
> +{
> +       if (!cred)
> +               return -EINVAL;
> +
> +       return cred_storage_delete(cred, map);
> +}
> +
> +BTF_KFUNCS_START(bpf_cred_storage_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_cred_storage_delete, 0)
> +BTF_ID_FLAGS(func, bpf_cred_storage_get, KF_RET_NULL)
> +BTF_KFUNCS_END(bpf_cred_storage_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_cred_storage_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &bpf_cred_storage_kfunc_ids,
> +};
> +
> +static int __init bpf_cred_storage_init(void)
> +{
> +       int err;

We need an empty line after the declaration.
scripts/checkpatch.pl should warn this. Please fix other warnings
from checkpatch.pl.

> +       err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_cred_st=
orage_kfunc_set);
> +       if (err) {

[...]

> diff --git a/kernel/cred.c b/kernel/cred.c
> index 9676965c0981..a1be27fe5f4c 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -38,6 +38,10 @@ static struct kmem_cache *cred_jar;
>  /* init to 2 - one for init_task, one to ensure it is never freed */
>  static struct group_info init_groups =3D { .usage =3D REFCOUNT_INIT(2) }=
;
>
> +#ifdef CONFIG_BPF_LSM
> +#include <linux/bpf_lsm.h>
> +#endif

We defined a dummy version of bpf_cred_storage_free
in bpf_lsm.h, so the ifdef here is not needed.

> +
>  /*
>   * The initial credentials for the initial task
>   */
> @@ -76,6 +80,9 @@ static void put_cred_rcu(struct rcu_head *rcu)
>                       cred, atomic_long_read(&cred->usage));
>
>         security_cred_free(cred);
> +#ifdef CONFIG_BPF_LSM
> +       bpf_cred_storage_free(cred);
> +#endif

Ditto.

>         key_put(cred->session_keyring);
>         key_put(cred->process_keyring);
>         key_put(cred->thread_keyring);
[...]

