Return-Path: <bpf+bounces-41012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E799107D
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDD2B2A38B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215131DB371;
	Fri,  4 Oct 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i65lkRe1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988651D9689;
	Fri,  4 Oct 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072671; cv=none; b=ttZ7e9rMVdRnsAI/Fr1fDbnC+T7IRT2+5kLR6rwPj51jgT4R+/cD9JrhLWDeCEUGm12Jqo+d0odA0wJ5Aykwaod0685sLrzNJQRXKIv3LpDHkOKMpQh+peFXXo+F3rZ06FmZl/bEylUldHxpzuvQUt7bcNsWXnxtvQjD7/xfey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072671; c=relaxed/simple;
	bh=NnBk3LnKYCZ5iFKF5AqTT8rdYv7l7hGgWci/fR+vGSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkR0nZJt3PTs6IphaCrEZxn6zI0ULURQ0uUY3KYjF5ODjYra05+v3KZUgMPMGROyhmH4+Av6ZIhL6zUiD6LXb9aNxzoyVMkVwMsOXxWT2cY+5svadi4LmcKJNrWra1o2Uu0PZy5YQd0LOjRRGXyvaW95oMnUGHEj+K7Dughx/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i65lkRe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B77C4CED4;
	Fri,  4 Oct 2024 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728072671;
	bh=NnBk3LnKYCZ5iFKF5AqTT8rdYv7l7hGgWci/fR+vGSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i65lkRe1lYWrkBWR3gCHDpFIJpYCd3cDLrO2vZPy/WNmy+394c+mFj6nI7MlTScOe
	 /GWaGeIi7hFJm5BVAVsjhsSCgDmZ/A426q7hQ7I83CFiF8T2/BrPmzeoGL7wiKU/nL
	 wDkA1hg0nBog6JWFkVnQecMJSMFWLVZFB8pQ9ZunODVNJvsUN038c8VasUd+QiYhn5
	 +xmTNfO48Y9kF8w0TH/z4b1ordr05Yr7TIIsJ3HREKpEfVP0OsUM5bDkWuSwCK6ekf
	 ZKJBtzSlbnNABrzZcQJ856a/vlni3KbBCHhI1LsMY6/WneqHEbID1SfNQ4DxLoeEFE
	 1Wv1Kb/EgXn/w==
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a377534e00so3657415ab.3;
        Fri, 04 Oct 2024 13:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDbAr0eRfPGBS6FOi1ZCO6AImwBjcs7pdk+UaRtVBm/hza1/sh5p7HmLLJ6gI+RntgkrM=@vger.kernel.org, AJvYcCWj+PVtvGLFRhkDJsMpi4xbm6M71U4OZBSBfi+mCFjlcK8Ot8nryTCDZ+DUZ9yDjTbQGpuwTZOow4jOWQSe@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQ0gbdAi6plFcCd11QvSor9Nu9hV+iHAyiLjMm8hmJaR4eUyP
	iOA22+xMRDAUJdol0TgeVPS1E6k94iHzSDH5Yj4txu3KMd0ocqBjlIHZK7QuYFzvr0ZJMgHx875
	Xzd01OsSzg0oMSHzwW+l/Kyt9sLA=
X-Google-Smtp-Source: AGHT+IH+FqtwP+CAIXfw1HbhK7Hj5jM4yQcYaDSjWiH0pUADieY8H1qdXWDnxc8PDNqyqTjiXXmYIFl2yp0wjAGXFtw=
X-Received: by 2002:a92:c269:0:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a375b9aba9mr43340495ab.15.1728072670428; Fri, 04 Oct 2024
 13:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002180956.1781008-1-namhyung@kernel.org> <20241002180956.1781008-3-namhyung@kernel.org>
In-Reply-To: <20241002180956.1781008-3-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 4 Oct 2024 13:10:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
Message-ID: <CAPhsuW7Bh-ZXfM2aYB=Yj8WaJHFc==AKmv6LDRgBq-TfdQ3s8A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] mm/bpf: Add bpf_get_kmem_cache() kfunc
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:10=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The bpf_get_kmem_cache() is to get a slab cache information from a
> virtual address like virt_to_cache().  If the address is a pointer
> to a slab object, it'd return a valid kmem_cache pointer, otherwise
> NULL is returned.
>
> It doesn't grab a reference count of the kmem_cache so the caller is
> responsible to manage the access.  The intended use case for now is to
> symbolize locks in slab objects from the lock contention tracepoints.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> (mm/*)
> Acked-by: Vlastimil Babka <vbabka@suse.cz> #mm/slab
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/bpf/helpers.c |  1 +
>  mm/slab_common.c     | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4053f279ed4cc7ab..3709fb14288105c6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3090,6 +3090,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7443244656150325..5484e1cd812f698e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1322,6 +1322,25 @@ size_t ksize(const void *objp)
>  }
>  EXPORT_SYMBOL(ksize);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +#include <linux/btf.h>
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc struct kmem_cache *bpf_get_kmem_cache(u64 addr)
> +{
> +       struct slab *slab;
> +
> +       if (!virt_addr_valid(addr))
> +               return NULL;
> +
> +       slab =3D virt_to_slab((void *)(long)addr);
> +       return slab ? slab->slab_cache : NULL;
> +}

Do we need to hold a refcount to the slab_cache? Given
we make this kfunc available everywhere, including
sleepable contexts, I think it is necessary.

Thanks
Song

> +
> +__bpf_kfunc_end_defs();
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>  /* Tracepoints definitions. */
>  EXPORT_TRACEPOINT_SYMBOL(kmalloc);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
> --
> 2.46.1.824.gd892dcdcdd-goog
>

