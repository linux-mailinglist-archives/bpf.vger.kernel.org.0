Return-Path: <bpf+bounces-56958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C2AA1076
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993747A854C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97013221729;
	Tue, 29 Apr 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iiq+o6tR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678ED21CA1F
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940418; cv=none; b=BiTocKsaJV6uwYfdJ9GCvF/DwGgufUxqzT7lCocDiCoe5hgy00pCUTcKXiXBA29fELZv6mLfLiz634jb21nKVirJsEJ3RQ7i6gTxUw8qlpVGbiBHkJo9M0Nl40/jQ5kUcqj43qUwTR/woPDd+/FFjbjtWJ6Pi4IymZJyHn1Vih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940418; c=relaxed/simple;
	bh=XfUgRkGlK6wln1rFR6aCMA6+diK7wgOCmP0ZuxHx69c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Inj9xCFPSGt3dqC09jXPXIJAwk9rn+wCn1iwWTpKy0ww7/qtdJtEkdS0lPEMfvOUValV1A8NgcGxUpucCiSYbsT6Z7wpyuZO7f8DRVaJYDYIQbfaGmi4o+6QYFQiEL0aCkXgc7uYl9I/Di1gxCD1wHaQXqK/DtNo9Riv7+VOCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iiq+o6tR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso9239655a12.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 08:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745940413; x=1746545213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o3YZLthCdx1ZsnJiax3XnbHWY0e82uvxz2zjUXCWIc=;
        b=Iiq+o6tRZlbVRV3Jfsw+j1ccF1kFwCO+Bpq3e3WscLWWfMgqWFvcj6LMuKTuBLpAPb
         jxXJ+m1w06dXPzquXHSl6nwsWXFms3flqmRcnW5VoZxdVa4flXBt2ErNctIWDDwA1W5f
         ASc6xoZyBuwUMOKYw3N9G+mnm9eEAiGh/fLI85b+S6QLQ8ctyDcS6o/SWgSeC0zK7dIF
         CCiV69nvcpGhLEbwV6+OIFxd5QWeGKYD2EQYGLM0vsQfIKazsg6SDT4hpn8TP6VwEceD
         sbhyw4R6fygDQcnhF3IVKX0OHcJGATtgviCwBGO/89KNww9k5TpPeXz1WRFlqH0WUSHt
         WhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745940413; x=1746545213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o3YZLthCdx1ZsnJiax3XnbHWY0e82uvxz2zjUXCWIc=;
        b=mPUbtQtRfhxoZI4/mScTH4LBcEmWH6oJWWarkNpou/0fBhsZzGXnH7Wr/dbBRbepyo
         1RLB/+9ygxdN/aI2DaAj2njpu6/AlL7oWGZOifBx61vEF4pJA21CuKXDODPLolIq/EFE
         mPKdzd78vlmJSDW/Ia0YbYRstWioznO3V9RkH1A9LnkLvrDXHDWJsyz+nS3zTEWcUpSU
         m3CY6kCqQBY32dX7L7B0EqqndCvz0PkeuT8rf3FhuVcqf0JwLw6WULBSq2+UuL+XeIn5
         xrZRx9Z6A/Wo91hCHxyXe1SpRGBkrTko6gL8zKOBKGKnFWQqZ+qeQRK1kHzsYpIRmBsK
         Yumg==
X-Forwarded-Encrypted: i=1; AJvYcCWp2289AEJieQgReU/BoqvKLOTAVKJkGOwcH5eUnMr+XZYCn7yxWU7NVwFW/64gkGNhPbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQG6hhAsFZMKfI9TajCN3KOQX96o6/cMUOCXRp1EqrqRzJCdsr
	y/Q32IDdVBJUEF5wANBnaQDh/2fK1iak6vP3Ua1zqmLebHvKNIGxNuaorvbwMHShb0Rmx4sbDS9
	hNcUIn43DVKJ5I4jlPNyK32TYNHlRDw==
X-Gm-Gg: ASbGncuuvXK1J6JDSBrBuBjUdT6QGoseRt0TGwurBn4aJ8ejzBzpcgr+bl+TFeiI/0V
	MBGSp+oab5wt35oKEDP7XZwtIhQy0YKV1ZD1BrdZC1pFQ0occA00DEReG/i1IxZ2CUo79v/aMRC
	qjYqIsQdwh6//5PqZAMz/8NA8pGa1AOU8KdS6k/v6SgnaKoNUf
X-Google-Smtp-Source: AGHT+IEKrqfR6pygOVH5iWkcP8cayTZnb9oghXvklRUVGTHRWYz7KdjAwuAIc7K60b5hEFyldG4JSiVjGPVnGDcgh8s=
X-Received: by 2002:a05:6000:430c:b0:39c:1f0e:95af with SMTP id
 ffacd0b85a97d-3a0890a5104mr3581910f8f.3.1745939990044; Tue, 29 Apr 2025
 08:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <20250429024139.34365-4-laoar.shao@gmail.com>
In-Reply-To: <20250429024139.34365-4-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 08:19:38 -0700
X-Gm-Features: ATxdqUEY4yBbJFrcBm1747j0TrsvmzhZ0S6ckhj3XQSyWYZumSIa2qBv3hFSGkM
Message-ID: <CAADnVQJw2ou7mHtvp+kCxLi_kzN+j4UqXA5xvOR1gJDjA8iVfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] mm: add BPF hook for THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 7:42=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We will use the @vma parameter in BPF programs to determine whether THP c=
an
> be used. The typical workflow is as follows:
>
> 1. Retrieve the mm_struct from the given @vma.
> 2. Obtain the task_struct associated with the mm_struct
>    It depends on CONFIG_MEMCG.
> 3. Adjust THP behavior dynamically based on task attributes
>    E.g., based on the task=E2=80=99s cgroup
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/Makefile   |  3 +++
>  mm/bpf.c      | 36 ++++++++++++++++++++++++++++++++++++
>  mm/bpf.h      | 21 +++++++++++++++++++++
>  mm/internal.h |  3 +++
>  4 files changed, 63 insertions(+)
>  create mode 100644 mm/bpf.c
>  create mode 100644 mm/bpf.h
>
> diff --git a/mm/Makefile b/mm/Makefile
> index e7f6bbf8ae5f..97055da04746 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
>  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> +ifdef CONFIG_BPF_SYSCALL
> +obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D bpf.o
> +endif
>  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
>  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> diff --git a/mm/bpf.c b/mm/bpf.c
> new file mode 100644
> index 000000000000..72eebcdbad56
> --- /dev/null
> +++ b/mm/bpf.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Yafang Shao <laoar.shao@gmail.com>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/mm_types.h>
> +
> +__bpf_hook_start();
> +
> +/* Checks if this @vma can use THP. */
> +__weak noinline int
> +mm_bpf_thp_vma_allowable(struct vm_area_struct *vma)
> +{
> +       /* At present, fmod_ret exclusively uses 0 to signify that the re=
turn
> +        * value remains unchanged.
> +        */
> +       return 0;
> +}
> +
> +__bpf_hook_end();
> +
> +BTF_SET8_START(mm_bpf_fmod_ret_ids)
> +BTF_ID_FLAGS(func, mm_bpf_thp_vma_allowable)
> +BTF_SET8_END(mm_bpf_fmod_ret_ids)
> +
> +static const struct btf_kfunc_id_set mm_bpf_fmodret_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &mm_bpf_fmod_ret_ids,
> +};
> +
> +static int __init bpf_mm_kfunc_init(void)
> +{
> +       return register_btf_fmodret_id_set(&mm_bpf_fmodret_set);
> +}
> +late_initcall(bpf_mm_kfunc_init);
> diff --git a/mm/bpf.h b/mm/bpf.h
> new file mode 100644
> index 000000000000..e03a38084b08
> --- /dev/null
> +++ b/mm/bpf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __MM_BPF_H
> +#define __MM_BPF_H
> +
> +#define MM_BPF_ALLOWABLE       (1)
> +#define MM_BPF_NOT_ALLOWABLE   (-1)
> +
> +#define MM_BPF_ALLOWABLE_HOOK(func, args...)   {       \
> +       int ret =3D func(args);                           \
> +                                                       \
> +       if (ret =3D=3D MM_BPF_ALLOWABLE)                    \
> +               return 1;                               \
> +       if (ret =3D=3D MM_BPF_NOT_ALLOWABLE)                \
> +               return 0;                               \
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +int mm_bpf_thp_vma_allowable(struct vm_area_struct *vma);
> +#endif
> +
> +#endif
> diff --git a/mm/internal.h b/mm/internal.h
> index aa698a11dd68..c8bf405fa581 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -21,6 +21,7 @@
>
>  /* Internal core VMA manipulation functions. */
>  #include "vma.h"
> +#include "bpf.h"
>
>  struct folio_batch;
>
> @@ -1632,6 +1633,7 @@ static inline bool reclaim_pt_is_enabled(unsigned l=
ong start, unsigned long end,
>   */
>  static inline bool hugepage_global_enabled(struct vm_area_struct *vma)
>  {
> +       MM_BPF_ALLOWABLE_HOOK(mm_bpf_thp_vma_allowable, vma);
>         return transparent_hugepage_flags &
>                         ((1<<TRANSPARENT_HUGEPAGE_FLAG) |
>                         (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
> @@ -1639,6 +1641,7 @@ static inline bool hugepage_global_enabled(struct v=
m_area_struct *vma)
>
>  static inline bool hugepage_global_always(struct vm_area_struct *vma)
>  {
> +       MM_BPF_ALLOWABLE_HOOK(mm_bpf_thp_vma_allowable, vma);

Please define a clean struct_ops based interface and demonstrate
the generality of the api with both bpf prog and a kernel module.
Do not use fmod_ret since it's global while struct_ops can be made
scoped for use case. Ex: per cgroup.

