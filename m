Return-Path: <bpf+bounces-77273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4494CD47D7
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE34C3003BD7
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D3D1DF72C;
	Mon, 22 Dec 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHr8z96w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B1A945
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766363997; cv=none; b=j9AlCyaVZQfMOec2n/oPpgGjwF+1zSo3jRqvFqoUjxglnm+VXufjv1wwOVFui0cS7oPA/bT2oGnqeKtYz2c9NWY6IiSwCVvIlCyPBOa4eP0R/rQlf53sxDK2IiwihERVmRrWcpJnMxrW5Wa+r3/tQzhM2km4d55u8+eJRZTnjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766363997; c=relaxed/simple;
	bh=1Lv3UL68EFBOvGc00WG8yUODzmYD8Hmdvh7uIa0pco0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8zrND5IkjPIkrOkWqkArZ05G4itXtQpQ4zewflbnH7YkiFb0En+5r0todEQ8y79B55vQ89LFI74GgOZSZGenKngs/4cpT0jMg9NJOXvsuu4sCxj2W9yTzvmJM4hbDMILEx2NLPKHNAbRlWRozEFEsvZYFB3PeP+iaWEbcRnLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHr8z96w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso1494441f8f.2
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 16:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766363994; x=1766968794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/H19Q6tBd0UoTOXIGQ7f4tfksWDWCO13hxwp5+fi/A=;
        b=YHr8z96w2MuYCjTXuKNRQBzORnAue2D9yrrvrYdSuDYttOfalf9v3ZclsDR3wfJD8l
         yyBKl0xYYYTy/1XduXwR2hSIq/o44PJbu5gqyk05zeSclRvt9nXGCzwm10wJPel3IA4I
         AziWLd3jmat3wc78tceswksOxeiMHXFto7mkxL6dOBQNuv+p4vCuFjFnnzFm1L/N5pCW
         0Gys+NKP8AtB1N6wWYjeXE4Sm15xC+egtGZct01+5HoSQy1IjdGn/LgjyJAa+lmXQ8sR
         ePA73sRpVTinMzvLAbk+uV/OYuYZ/5Dd/KeK9NyN2EhK3UPVIpr725DvhRm0pXaDZX9K
         pqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766363994; x=1766968794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/H19Q6tBd0UoTOXIGQ7f4tfksWDWCO13hxwp5+fi/A=;
        b=f1CcgLZCow+N5Q72JqISxxiEEdKwJzx8PYURPgtjQnDSrG798sprl+4QjYw+LoSl1b
         ZsPKDQDlM85dUo6r5Dg8F1R7McC07RICTgszS4UJ5W/arjdZH33wY/PDBcNeTMR5e6t/
         zLZnnaSbfoItbRp2CtHAP/FiUMMDn77yQn4CdB9Y63THbarhk7dK+VwKRohD271vTMI7
         xFAzckdh962QHMOIHyN8mIhp2q2K2fKew9HQs6by2T6mgEytj7BBMayIig6bIBxf8QiC
         So4HQTCUSc5s4hIkxee5LNsNZDBQSwmwpmtfifbLuIqT+UIsH9w9xYe1P5UHSyx1rdsQ
         kyXQ==
X-Gm-Message-State: AOJu0Yzkk7RfdCEd7bD0I9AGuyITEoF7/Uw8q9JDyazHxoaZqepn6b/F
	FutJl7IrHCyXgVJ9P+DdVFrUDP5KcePv4jptL+2V1Qw62uAjgpcRxMLr5VvBHofIJAWoUnrMQEm
	tmAZbAimF+XFb9aTpMfhgjvRUpjQoQIY=
X-Gm-Gg: AY/fxX5s5B3Oj/fJkOkLIcgKRwUgGTnozy2+g4pNWT9zagxQ1Ga1bLBTTAwlHVp74y4
	lF81D4xp4tmCNeM4//9EhSbqTBqRGAeoAOuemDztIkD4kMpifU9HuUGGmqJroLcaWUtQ21FEG6k
	P/uG1hXB5/nnFCzccMzN/AiUjfWviOQ29VhOg/aqzsAoRlt31qvrMOn5R6QVA2bqJi9UuhHWr9q
	Ugi1KAJD+3It6l70qtMqxQWJIG677bhATAC8kfdytxemWa/TmOHW1MQZCv7hJ/16M9/3+wC
X-Google-Smtp-Source: AGHT+IGkS9dOdEhg5+dCkmUmeaWzy4PZ0nHJDOAvsq+qfntVAU3c0jXqwzhWWTxM0175xdfDO/eCyt7iUEHIffnxA0A=
X-Received: by 2002:a05:6000:2089:b0:431:9b2:61c0 with SMTP id
 ffacd0b85a97d-4324e4c92b0mr10844629f8f.24.1766363993525; Sun, 21 Dec 2025
 16:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220041250.372179-1-roman.gushchin@linux.dev> <20251220041250.372179-3-roman.gushchin@linux.dev>
In-Reply-To: <20251220041250.372179-3-roman.gushchin@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 16:39:42 -0800
X-Gm-Features: AQt7F2oyBrROwRVLxqymS_B6UpKn5g9mpaj4yyV5pWKX0A3abRXIXQm-DHsTaoE
Message-ID: <CAADnVQ+T2_=F-885FtYZ1K8+UBfxmanExrfA+-0v4UdFVhmeDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] mm: introduce BPF kfuncs to deal with
 memcg pointers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:13=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> To effectively operate with memory cgroups in BPF there is a need
> to convert css pointers to memcg pointers. A simple container_of
> cast which is used in the kernel code can't be used in BPF because
> from the verifier's point of view that's a out-of-bounds memory access.
>
> Introduce helper get/put kfuncs which can be used to get
> a refcounted memcg pointer from the css pointer:
>   - bpf_get_mem_cgroup,
>   - bpf_put_mem_cgroup.
>
> bpf_get_mem_cgroup() can take both memcg's css and the corresponding
> cgroup's "self" css. It allows it to be used with the existing cgroup
> iterator which iterates over cgroup tree, not memcg tree.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/Makefile         |  3 ++
>  mm/bpf_memcontrol.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 mm/bpf_memcontrol.c
>
> diff --git a/mm/Makefile b/mm/Makefile
> index 9175f8cc6565..79c39a98ff83 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -106,6 +106,9 @@ obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) +=3D swap_cgroup.o
>  endif
> +ifdef CONFIG_BPF_SYSCALL
> +obj-$(CONFIG_MEMCG) +=3D bpf_memcontrol.o
> +endif
>  obj-$(CONFIG_CGROUP_HUGETLB) +=3D hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) +=3D gup_test.o
>  obj-$(CONFIG_DMAPOOL_TEST) +=3D dmapool_test.o
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> new file mode 100644
> index 000000000000..03d435fc4f10
> --- /dev/null
> +++ b/mm/bpf_memcontrol.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Memory Controller-related BPF kfuncs and auxiliary code
> + *
> + * Author: Roman Gushchin <roman.gushchin@linux.dev>
> + */
> +
> +#include <linux/memcontrol.h>
> +#include <linux/bpf.h>
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_get_mem_cgroup - Get a reference to a memory cgroup
> + * @css: pointer to the css structure
> + *
> + * Returns a pointer to a mem_cgroup structure after bumping
> + * the corresponding css's reference counter.
> + *
> + * It's fine to pass a css which belongs to any cgroup controller,
> + * e.g. unified hierarchy's main css.
> + *
> + * Implements KF_ACQUIRE semantics.
> + */
> +__bpf_kfunc struct mem_cgroup *
> +bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
> +{
> +       struct mem_cgroup *memcg =3D NULL;
> +       bool rcu_unlock =3D false;
> +
> +       if (mem_cgroup_disabled() || !root_mem_cgroup)
> +               return NULL;
> +
> +       if (root_mem_cgroup->css.ss !=3D css->ss) {
> +               struct cgroup *cgroup =3D css->cgroup;
> +               int ssid =3D root_mem_cgroup->css.ss->id;
> +
> +               rcu_read_lock();
> +               rcu_unlock =3D true;
> +               css =3D rcu_dereference_raw(cgroup->subsys[ssid]);
> +       }
> +
> +       if (css && css_tryget(css))
> +               memcg =3D container_of(css, struct mem_cgroup, css);
> +
> +       if (rcu_unlock)
> +               rcu_read_unlock();
> +
> +       return memcg;
> +}
> +
> +/**
> + * bpf_put_mem_cgroup - Put a reference to a memory cgroup
> + * @memcg: memory cgroup to release
> + *
> + * Releases a previously acquired memcg reference.
> + * Implements KF_RELEASE semantics.
> + */
> +__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
> +{
> +       css_put(&memcg->css);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> +BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_TRUSTED_ARGS | KF_ACQUIRE | KF=
_RET_NULL | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_TRUSTED_ARGS | KF_RELEASE)

This is an unusual combination of flags.
KF_RCU is a weaker KF_TRUSTED_ARGS, so just use KF_RCU.
We have an odd selftest kmod that specifies both,
but it's unnecessary there as well.
Just KF_ACQUIRE | KF_RET_NULL | KF_RCU will do.

Similarly KF_RELEASE implies KF_TRUSTED_ARGS.
That's even documented Documentation/bpf/kfuncs.rst,
so just use KF_RELEASE for bpf_put_mem_cgroup.

pw-bot: cr

