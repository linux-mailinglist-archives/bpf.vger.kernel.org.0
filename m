Return-Path: <bpf+bounces-57054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A0AA4FF8
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A1D1C045F5
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259CC219E93;
	Wed, 30 Apr 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0IdJOgP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972625EF80
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026228; cv=none; b=bSFiV3F9cPzUy8zQbzHCBjmxpCD4FRa031zIfExbFH9xGEUqp/bd5rjrrdRDAwPDgLEUrk2OpDQRj/LQtTQ+0VXRxot36gZj3e6Wi+BKXucjvKB4VDFETybI7D9zE1gP6ccZq+KBiE8n+V3CqO3IECdnSB+dW63ghemEVr0+NiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026228; c=relaxed/simple;
	bh=dSPy5I5HCEn0q2x0Q5FyljkOO/G6+wvyQMDZQErpxPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTDwpmgipAxuajt76zxg++Hz/zsNo5G1cHiFUdTqvZIEv5VfyOkyGn2VzNOZPFaGu3eu/1ffZeGZd4qHtaWEEh34OA87VvCZ6MyF7be9sT16zZdR9vffqpAXIU5w/AvAvTugIl8NG3qhswYp0ht271ueL4fqWHpxDCM0gYeESzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0IdJOgP; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fce04655so32066d6.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746026226; x=1746631026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1eGfNgNhOkfDvT6PA5fh2AacW8V+M0lJMdLcR/pdF0=;
        b=I0IdJOgPHbfkRmin8HY+iwYQrCj0b9xtRukuswIcxMEDgvV9C/js3+jwwuE6ZUGbus
         XvJQSVSBePB5P9/2x6sq1LvXNelf6WshC+aSFfJfuTzSmMaPrLOrAUs/VxhTNWm+OSim
         ksO1V1rsi/ulqYXraFGF/z7chmlC/VFD6MZl1x501PMiwEUxecMrXAMGzFeWBOj31kUA
         QOGbHHLknDlFSU2WJxCgMmNCOBszAOgtxl6FH9ilo53lCJQXurt5BCrc4XfOWYX7IQ6H
         RovRwTGvJOnpZhcbDAN80VZDgRRCj/iEDtrvQREWTqUpN5TNnfzZGUOHIyuG5S6qjGjQ
         OBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746026226; x=1746631026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1eGfNgNhOkfDvT6PA5fh2AacW8V+M0lJMdLcR/pdF0=;
        b=qgt0U1/Y/HbK7Ecd6/83RVsO65MRpshII/x/TqqOc52ZmXHCPDBpnCElHaesjhkdRX
         B7Efz6XAwBEGBM0iB9d4h5C9n6GLJgbYUN7KkIV9LUs0ioYYQhcpHj/6lCWyYJa0pZmg
         sAY2ZNvK7ng3CXdsTT3af0Y6SYn/gNqF1vv05JPx1K1egtLEhqh2hGlokJTxvOv5alpu
         1d/noclVqEfuiJHShSmqXsyPol1so58M2yCRXc4pPdb1IID1+Idol0VvDygN3kiZVEw2
         2TE7EwfmpScB9yg1FT7KHXVTEnwMRi0nfqWqVLO+DW1bJOY8S08bYFin36sFWDrd7hnM
         gkgw==
X-Forwarded-Encrypted: i=1; AJvYcCUy+YayZ1jqiH87UKSThl0sAOyb/y8qfcAu2mC4XjcuCQ3pXtsJqzx+O5Edxt4h0c4IwgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYn5377x8Su46/i/K2tKNIMB/9K0jnHluQdTvNwXfsTXhehEAp
	4aB/A7udjXL/E0EZTzeoy8gcFGe6E8/TKL1aorWrMSEPXKg0NtyK/5OY+y/5q8pM7VEVVTJ4aIj
	oetjWURuQ6LCxB2hhC4k0OpY21N4=
X-Gm-Gg: ASbGncsxYi9kyLOdtOz9pYLQMG2/sa8T80gTUj0oO6NlT8DiUOpq13uSwXUIJzde5Wh
	X986taMASAs7oDCI214D5hjBuEOKkaMxI5xknrtKdCOWKf9s2UBtD2u57F4Lh7yMIZDnPEhDmYw
	utqpZNFEeNi/p5ESMj7Bkk26M=
X-Google-Smtp-Source: AGHT+IEia4f+wjAVsBUvm/2+ziBVTBEuYip3CdpjAvABDnOWGPHqBtFRRyGkWVvfA72hUjQ4aaQR4MlRJcQbEJ4VGl4=
X-Received: by 2002:a05:6214:d41:b0:6e8:9dfa:d932 with SMTP id
 6a1803df08f44-6f4fcea349cmr60372726d6.15.1746026225636; Wed, 30 Apr 2025
 08:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com> <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
In-Reply-To: <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 23:16:28 +0800
X-Gm-Features: ATxdqUEy1ObHwX52a6IW6Ijr93XcylJGHFGOQfcuuqOdUkPDHEQ_5lpHj2vRvPA
Message-ID: <CALOAHbCua2_MU-Rnct8Y47f=27ELgRXb_732jcDb-Ss+hnvFVA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:00=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 30 Apr 2025, at 10:38, Yafang Shao wrote:
>
> > On Wed, Apr 30, 2025 at 9:19=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> On 29 Apr 2025, at 22:33, Yafang Shao wrote:
> >>
> >>> On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrot=
e:
> >>>>
> >>>> Hi Yafang,
> >>>>
> >>>> We recently added a new THP entry in MAINTAINERS file[1], do you min=
d ccing
> >>>> people there in your next version? (I added them here)
> >>>>
> >>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree=
/MAINTAINERS?h=3Dmm-everything#n15589
> >>>
> >>> Thanks for your reminder.
> >>> I will add the maintainers and reviewers in the next version.
> >>>
> >>>>
> >>>> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> >>>>> In our container environment, we aim to enable THP selectively=E2=
=80=94allowing
> >>>>> specific services to use it while restricting others. This approach=
 is
> >>>>> driven by the following considerations:
> >>>>>
> >>>>> 1. Memory Fragmentation
> >>>>>    THP can lead to increased memory fragmentation, so we want to li=
mit its
> >>>>>    use across services.
> >>>>> 2. Performance Impact
> >>>>>    Some services see no benefit from THP, making its usage unnecess=
ary.
> >>>>> 3. Performance Gains
> >>>>>    Certain workloads, such as machine learning services, experience
> >>>>>    significant performance improvements with THP, so we enable it f=
or them
> >>>>>    specifically.
> >>>>>
> >>>>> Since multiple services run on a single host in a containerized env=
ironment,
> >>>>> enabling THP globally is not ideal. Previously, we set THP to madvi=
se,
> >>>>> allowing selected services to opt in via MADV_HUGEPAGE. However, th=
is
> >>>>> approach had limitation:
> >>>>>
> >>>>> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> >>>>>   third-party libraries, bypassing our restrictions.
> >>>>
> >>>> Basically, you want more precise control of THP enablement and the
> >>>> ability of overriding madvise() from userspace.
> >>>>
> >>>> In terms of overriding madvise(), do you have any concrete example o=
f
> >>>> these third-party libraries? madvise() users are supposed to know wh=
at
> >>>> they are doing, so I wonder why they are causing trouble in your
> >>>> environment.
> >>>
> >>> To my knowledge, jemalloc [0] supports THP.
> >>> Applications using jemalloc typically rely on its default
> >>> configurations rather than explicitly enabling or disabling THP. If
> >>> the system is configured with THP=3Dmadvise, these applications may
> >>> automatically leverage THP where appropriate
> >>>
> >>> [0]. https://github.com/jemalloc/jemalloc
> >>
> >> It sounds like a userspace issue. For jemalloc, if applications requir=
e
> >> it, can't you replace the jemalloc with a one compiled with --disable-=
thp
> >> to work around the issue?
> >
> > That=E2=80=99s not the issue this patchset is trying to address or work
> > around. I believe we should focus on the actual problem it's meant to
> > solve.
> >
> > By the way, you might not raise this question if you were managing a
> > large fleet of servers. We're a platform provider, but we don=E2=80=99t
> > maintain all the packages ourselves. Users make their own choices
> > based on their specific requirements. It's not a feasible solution for
> > us to develop and maintain every package.
>
> Basically, user wants to use THP, but as a service provider, you think
> differently, so want to override userspace choice. Am I getting it right?

No=E2=80=94the users aren=E2=80=99t specifically concerned with THP. They j=
ust copied
a configuration from the internet and deployed it in the production
environment.

>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> To address this issue, we initially hooked the __x64_sys_madvise() =
syscall,
> >>>>> which is error-injectable, to blacklist unwanted services. While th=
is
> >>>>> worked, it was error-prone and ineffective for services needing alw=
ays mode,
> >>>>> as modifying their code to use madvise was impractical.
> >>>>>
> >>>>> To achieve finer-grained control, we introduced an fmod_ret-based s=
olution.
> >>>>> Now, we dynamically adjust THP settings per service by hooking
> >>>>> hugepage_global_{enabled,always}() via BPF. This allows us to set T=
HP to
> >>>>> enable or disable on a per-service basis without global impact.
> >>>>
> >>>> hugepage_global_*() are whole system knobs. How did you use it to
> >>>> achieve per-service control? In terms of per-service, does it mean
> >>>> you need per-memcg group (I assume each service has its own memcg) T=
HP
> >>>> configuration?
> >>>
> >>> With this new BPF hook, we can manage THP behavior either per-service
> >>> or per-memory.
> >>> In our use case, we=E2=80=99ve chosen memcg-based control for finer-g=
rained
> >>> management. Below is a simplified example of our implementation:
> >>>
> >>> struct{
> >>>         __uint(type, BPF_MAP_TYPE_HASH);
> >>>         __uint(max_entries, 4096);      /* usually there won't too
> >>> many cgroups */
> >>>         __type(key, u64);
> >>>         __type(value, u32);
> >>>         __uint(map_flags, BPF_F_NO_PREALLOC);
> >>> } thp_whitelist SEC(".maps");
> >>>
> >>> SEC("fmod_ret/mm_bpf_thp_vma_allowable")
> >>> int BPF_PROG(thp_vma_allowable, struct vm_area_struct *vma)
> >>> {
> >>>         struct cgroup_subsys_state *css;
> >>>         struct css_set *cgroups;
> >>>         struct mm_struct *mm;
> >>>         struct cgroup *cgroup;
> >>>         struct cgroup *parent;
> >>>         struct task_struct *p;
> >>>         u64 cgrp_id;
> >>>
> >>>         if (!vma)
> >>>                 return 0;
> >>>
> >>>         mm =3D vma->vm_mm;
> >>>         if (!mm)
> >>>                 return 0;
> >>>
> >>>         p =3D mm->owner;
> >>>         cgroups =3D p->cgroups;
> >>>         cgroup =3D cgroups->subsys[memory_cgrp_id]->cgroup;
> >>>         cgrp_id =3D cgroup->kn->id;
> >>>
> >>>         /* Allow the tasks in the thp_whiltelist to use THP. */
> >>>         if (bpf_map_lookup_elem(&thp_whitelist, &cgrp_id))
> >>>             return 1;
> >>>         return 0;
> >>> }
> >>>
> >>> I chose not to include this in the self-tests to avoid the complexity
> >>> of setting up cgroups for testing purposes. However, in patch #4 of
> >>> this series, I've included a simpler example demonstrating task-level
> >>> control.
> >>
> >> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?
> >
> > You=E2=80=99ll need to modify the user-space code=E2=80=94and again, th=
is likely
> > wouldn=E2=80=99t be a concern if you were managing a large fleet of ser=
vers.
> >
> >>
> >>> For service-level control, we could potentially utilize BPF task loca=
l
> >>> storage as an alternative approach.
> >>
> >> +cgroup people
> >>
> >> For service-level control, there was a proposal of adding cgroup based
> >> THP control[1]. You might need a strong use case to convince people.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez=
.asier@huawei-partners.com/
> >
> > Thanks for the reference. I've reviewed the related discussion, and if
> > I understand correctly, the proposal was rejected by the maintainers.
>
> I wonder why your approach is better than the cgroup based THP control pr=
oposal.

It=E2=80=99s more flexible, and you can still use it even without cgroups.

One limitation is that CONFIG_MEMCG must be enabled due to the use of
mm_struct::owner. I'm wondering if it would be feasible to decouple
mm_struct::owner from CONFIG_MEMCG. Alternatively, if there=E2=80=99s anoth=
er
reliable way to retrieve the task_struct without relying on
mm_struct::owner, we could consider adding BPF kfuncs to support it.

--=20
Regards
Yafang

