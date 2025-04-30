Return-Path: <bpf+bounces-57023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34189AA40F3
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 04:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B509A4D5C
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B311BCA0E;
	Wed, 30 Apr 2025 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7iOCMrd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043D2AD32
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 02:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745980452; cv=none; b=u3Ci1QBczLGJd+eoyIHBrY03VtUTRZfRdOF8AEaMk18JaGnjJE3DxUQCpvTP6jDVMjrsxbqVBxJlQmlYZjm+PFM+6+cedReX32Z+KuQeLG+7ImWsDOwhjJbSLOLkJjOr551SHXlFI3uZANp7DTdMkni+1Sq+TjRIiZ9US9TLoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745980452; c=relaxed/simple;
	bh=IUppYby16c38jJK0+mfO1v9ybirLHt5zPF1QXPJlL/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSDz6vkSJW0Ft1fSY2vDyPjhTTj6n41s0oKhEQNr/EaUCnWwezwcka0WRT3yFxFT8l3bTFey6RA0yzDaFqwqEod1dne2FCbeh58rTjtLJ7uzWZ+FwilIxNb1vfDK6LgeoUNtez3X4g84ybaH2hoBjENUFsGhw4Qa4c41LJK20uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7iOCMrd; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecf0e07947so5136596d6.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 19:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745980449; x=1746585249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oESaPB1iKmIZBkzNoUzvC4+0JJSrJDGSFz7cfCF+wY=;
        b=N7iOCMrdF3bkaTctV/ffnY/ezn+osubkr/hHWQke5BMjV9QK5Mnr+smEPg6qwOpDV0
         H9k+S9KKmZC7XKbmWxI2H4r3X50XfINfqZctN4IbaVsLZXuL0bpLLK64uwEIAFnpaYvv
         qjHt2JUiYF0XH/PZT7xkS6rrdTVLSo6ZIdTZj9Zaf0NbbRc+5yJFsi7ZaXkOjSolVWnc
         oPBek/ti+NVPdn+zqwbgVuQ0Urk3n38/V1dpPUnR0SmdALVRlcWEt2rHb2nlJPy+kyd3
         sGaPYXiVkt3v0oCAFZ+11Atk+sS9AF+KJoEF8r+GFBjWYrSk1y/6kbi4J0+51/ztW+tl
         zksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745980449; x=1746585249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oESaPB1iKmIZBkzNoUzvC4+0JJSrJDGSFz7cfCF+wY=;
        b=h40O28QuJkiHBBrl8Tu8+zPAyzX6/VYURRmxsq4SPcH2jEfn8ffvFyRlQXE2MdmZwK
         G64S2CvAkFM8xcVqUm8/tW6JgD2z0c4pKPrXwdbEs178Bx7ZNEgtB2Jvpvxzf15wF6xg
         COCTIBIedXeCGaXFLJKaxNdY0VcPqYKEGvgae+AheVzvBX10g0DsqpGaQu6clqZeY8s6
         EOd0zQLwLCPyeyuyTBw2B75iIalxwaq4bJtkPzO1IGv+OIYNk6/qzQ43ba6K2nYQSrAM
         e3hBdCDmoSnbMgZ2FeiJ+yThdiHB8+SL5P4LtvbxhGwh+v/rqUzdgbaWaxC98y5IWCm6
         RbfA==
X-Forwarded-Encrypted: i=1; AJvYcCW/BDOxqcZzqp9jg7duzWdDEN1e4jQXpZkBAQVo6EygMZn7+c4B4bNkQoRpfisHSNiVFBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5u/zaNThQm/8XgTCaEGVROu/mI3zF5FN5P4IUzwT3D04B+WB/
	rXEiJmps4As1nsUM3/mTgf6WQo6p9z31Uz4T8ZGFqud4RPv3rELNTX7ZoxNxqwHCmRRajToZpZs
	ZovNsBpQn0lxuR7jUs2ioP/crBag=
X-Gm-Gg: ASbGncuqPetWfsZz4FtJeZGNzR7kKwxkqXwZDh3a2p+vOKa3+h1hO9ntXwcouiw+pPZ
	8CELswwThzYD4GA6vuPvyyIGiHR+pCrmJToSTqFB479boWwTV06iN+J3Fcs5eUwKkUlrSl+nQj5
	figQdBBSU319WZyT9w2xFslig=
X-Google-Smtp-Source: AGHT+IHy22YRv03Bt3DTEhNvKhmb6JC+MQpuO6oqWaXg+77bVRpudf1qkFVeaWYeu54v3xHMrlLhLpYZhsKHnJE+QRw=
X-Received: by 2002:ad4:5ce9:0:b0:6e6:5b8e:7604 with SMTP id
 6a1803df08f44-6f4fdcb4565mr21749336d6.12.1745980449171; Tue, 29 Apr 2025
 19:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
In-Reply-To: <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 10:33:33 +0800
X-Gm-Features: ATxdqUGkhBWaatImKKdlBK3KsfC5xQ-S9XPUbbmk0fRceBoFqvDv4Stbee33cWo
Message-ID: <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> Hi Yafang,
>
> We recently added a new THP entry in MAINTAINERS file[1], do you mind cci=
ng
> people there in your next version? (I added them here)
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/MAIN=
TAINERS?h=3Dmm-everything#n15589

Thanks for your reminder.
I will add the maintainers and reviewers in the next version.

>
> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> > In our container environment, we aim to enable THP selectively=E2=80=94=
allowing
> > specific services to use it while restricting others. This approach is
> > driven by the following considerations:
> >
> > 1. Memory Fragmentation
> >    THP can lead to increased memory fragmentation, so we want to limit =
its
> >    use across services.
> > 2. Performance Impact
> >    Some services see no benefit from THP, making its usage unnecessary.
> > 3. Performance Gains
> >    Certain workloads, such as machine learning services, experience
> >    significant performance improvements with THP, so we enable it for t=
hem
> >    specifically.
> >
> > Since multiple services run on a single host in a containerized environ=
ment,
> > enabling THP globally is not ideal. Previously, we set THP to madvise,
> > allowing selected services to opt in via MADV_HUGEPAGE. However, this
> > approach had limitation:
> >
> > - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> >   third-party libraries, bypassing our restrictions.
>
> Basically, you want more precise control of THP enablement and the
> ability of overriding madvise() from userspace.
>
> In terms of overriding madvise(), do you have any concrete example of
> these third-party libraries? madvise() users are supposed to know what
> they are doing, so I wonder why they are causing trouble in your
> environment.

To my knowledge, jemalloc [0] supports THP.
Applications using jemalloc typically rely on its default
configurations rather than explicitly enabling or disabling THP. If
the system is configured with THP=3Dmadvise, these applications may
automatically leverage THP where appropriate

[0]. https://github.com/jemalloc/jemalloc

>
> >
> > To address this issue, we initially hooked the __x64_sys_madvise() sysc=
all,
> > which is error-injectable, to blacklist unwanted services. While this
> > worked, it was error-prone and ineffective for services needing always =
mode,
> > as modifying their code to use madvise was impractical.
> >
> > To achieve finer-grained control, we introduced an fmod_ret-based solut=
ion.
> > Now, we dynamically adjust THP settings per service by hooking
> > hugepage_global_{enabled,always}() via BPF. This allows us to set THP t=
o
> > enable or disable on a per-service basis without global impact.
>
> hugepage_global_*() are whole system knobs. How did you use it to
> achieve per-service control? In terms of per-service, does it mean
> you need per-memcg group (I assume each service has its own memcg) THP
> configuration?

With this new BPF hook, we can manage THP behavior either per-service
or per-memory.
In our use case, we=E2=80=99ve chosen memcg-based control for finer-grained
management. Below is a simplified example of our implementation:

struct{
        __uint(type, BPF_MAP_TYPE_HASH);
        __uint(max_entries, 4096);      /* usually there won't too
many cgroups */
        __type(key, u64);
        __type(value, u32);
        __uint(map_flags, BPF_F_NO_PREALLOC);
} thp_whitelist SEC(".maps");

SEC("fmod_ret/mm_bpf_thp_vma_allowable")
int BPF_PROG(thp_vma_allowable, struct vm_area_struct *vma)
{
        struct cgroup_subsys_state *css;
        struct css_set *cgroups;
        struct mm_struct *mm;
        struct cgroup *cgroup;
        struct cgroup *parent;
        struct task_struct *p;
        u64 cgrp_id;

        if (!vma)
                return 0;

        mm =3D vma->vm_mm;
        if (!mm)
                return 0;

        p =3D mm->owner;
        cgroups =3D p->cgroups;
        cgroup =3D cgroups->subsys[memory_cgrp_id]->cgroup;
        cgrp_id =3D cgroup->kn->id;

        /* Allow the tasks in the thp_whiltelist to use THP. */
        if (bpf_map_lookup_elem(&thp_whitelist, &cgrp_id))
            return 1;
        return 0;
}

I chose not to include this in the self-tests to avoid the complexity
of setting up cgroups for testing purposes. However, in patch #4 of
this series, I've included a simpler example demonstrating task-level
control.
For service-level control, we could potentially utilize BPF task local
storage as an alternative approach.

--=20
Regards
Yafang

