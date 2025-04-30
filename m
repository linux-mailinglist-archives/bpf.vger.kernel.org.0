Return-Path: <bpf+bounces-57046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956CAA4EE0
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD03B5A14
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA725E459;
	Wed, 30 Apr 2025 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT1nNESp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79925D1F4
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023931; cv=none; b=SXdVe2nBXkdjPSnRgR/z9+QWn2z4cMXLSZaF9mXtOo0wAYHATG69jvY1Pw3bdb+op67uuc1FaVX4fsksYTWbxqdr4OMtkKro24/BnguvEKyTEUWp5gfWJuMR33HWKIiIeck8vyUaxykusyd9ud+W6GPQoZ2r0URfRn8kliUXD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023931; c=relaxed/simple;
	bh=PVTohydLilgP3dZOFPpnptbOBDwdk7rbM/tY9eFqFAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR4ZW2cEj0RjRxBQOQencTm/EoypQcI85zsig1h68GAKYcj1sGQpRikja8iFWZwguJ/WFwHniH/3vzq34m62m8tfCanf7V7XpvRSiYdGY1U5NX+tyqXxMltwZgodGC/5YM8Ae0rEjn9uso8JlECgFVkvpwrzsDmWUrvlWFONlUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT1nNESp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f0ad74483fso83421016d6.1
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746023928; x=1746628728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZaQKL0lKSkWTZ3PYuofXsxJYk/+1B248o24QagaRnc=;
        b=AT1nNESpG1oawoFinE6BTCSDeST/7W/0ff9XPnLawaZoy0zqF4qedXgZomch9JuO2r
         bhTzQEQFTf7PpTvF1QNWBOBFSxp4aYiUv7Ui76k0yWPgG/U3q/PyP6TpiD7LnuQfWo4B
         3cR3LRGJ9wfGRv7fpGsH+kWxo22aux150aG3v1oF5vLxSjaOIHk+1NzDCWGw9EzeXl+7
         71m2UzCQErHg6jMjbSEbftDcwAWMyi1c56JMqsNFZ1FzJN9efUp4ZG+MG6IPkzaPWCVf
         gWXICYaUYpi4NwJ1KB+ThmUatNcMFOFAjogEa7aOSbhZHtSq3vO2n9HDCbNgzadwXKad
         AVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746023928; x=1746628728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZaQKL0lKSkWTZ3PYuofXsxJYk/+1B248o24QagaRnc=;
        b=ZxaczUhJEFJMaBgcsP3A/1xlLs5k9j1OS2HxZhQgIf7yo8y0oGdVrr8vyIhJTWWstQ
         mIWqyiio6vBTn+eW3wuyIwbxXv+BMrFPnCgJE/nW8/mmwlmjIATQhKIkq8xTNd1fwytw
         IzKPZgEWAjIR1gQrubXNunXeMGcRCP/laIWs/r2k+MsRGoOuG7Qc6e9wVClKbHEeA5W9
         z4lq0BBcgXQVk7m9O5IlGsCxAEEWrgy3pQkAvitCr1epeCqFDRqV2o3k4e5jtapOlAVh
         Q/FRje5jxSCMDRPZEf+LhVpgaLN2BFktlpavykrQtBg/yo/Va289NgYUElQsYmqku+IP
         Mkqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/VbMg1V/wBv7Ohec6taZTpFEiwgPJZhv46kP+SEV5fY/i2ci028XBoejcMYMB4wyVTP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfD/FQZs1woQL8yZIbph2kWDiLEPGGKJu9oqM1NfNILANf/JE3
	iziWDwroghaZ13vR1nTsqz6wFGNpRpUPZjIuIEb9R4KJz5uPhBv08sWfkKqD6wdbgQyltfzi0kZ
	E8dZTqfeb/X8banv1Hi8RYWYixR4=
X-Gm-Gg: ASbGncvc9YsWv7wb+TFHUOexxA5BmaEW9O9U6U/zF9X5WXEFgnQsae4yi/8Xq6ij30f
	go1YuLA4avyBpYvyPyKG6BoiteqXcZ/hO9abPL5Tp/moFFuw+HMWSqGqlvH7jrp9JEPsiq+LESj
	pq5pAD5ExvrOb4SPtTyOmOtFQ=
X-Google-Smtp-Source: AGHT+IHg+dNBE9IgivlmhXXs9kgFbJGA2vwJQy+7AROJZC2vzGZZQeWQcBL7P+66HVxAwhmUFFHfXTxra6y/Ac/yesw=
X-Received: by 2002:ad4:5942:0:b0:6e8:f4c6:6813 with SMTP id
 6a1803df08f44-6f4fce6824amr56619626d6.13.1746023928083; Wed, 30 Apr 2025
 07:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429024139.34365-1-laoar.shao@gmail.com> <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com> <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
In-Reply-To: <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Apr 2025 22:38:10 +0800
X-Gm-Features: ATxdqUEkpNmZXgzw3NLqzVrGeErP__C_79FEfxEYquqvwEzk3Jt8KlA3VRx4JPo
Message-ID: <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
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

On Wed, Apr 30, 2025 at 9:19=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 29 Apr 2025, at 22:33, Yafang Shao wrote:
>
> > On Tue, Apr 29, 2025 at 11:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> Hi Yafang,
> >>
> >> We recently added a new THP entry in MAINTAINERS file[1], do you mind =
ccing
> >> people there in your next version? (I added them here)
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/M=
AINTAINERS?h=3Dmm-everything#n15589
> >
> > Thanks for your reminder.
> > I will add the maintainers and reviewers in the next version.
> >
> >>
> >> On Mon Apr 28, 2025 at 10:41 PM EDT, Yafang Shao wrote:
> >>> In our container environment, we aim to enable THP selectively=E2=80=
=94allowing
> >>> specific services to use it while restricting others. This approach i=
s
> >>> driven by the following considerations:
> >>>
> >>> 1. Memory Fragmentation
> >>>    THP can lead to increased memory fragmentation, so we want to limi=
t its
> >>>    use across services.
> >>> 2. Performance Impact
> >>>    Some services see no benefit from THP, making its usage unnecessar=
y.
> >>> 3. Performance Gains
> >>>    Certain workloads, such as machine learning services, experience
> >>>    significant performance improvements with THP, so we enable it for=
 them
> >>>    specifically.
> >>>
> >>> Since multiple services run on a single host in a containerized envir=
onment,
> >>> enabling THP globally is not ideal. Previously, we set THP to madvise=
,
> >>> allowing selected services to opt in via MADV_HUGEPAGE. However, this
> >>> approach had limitation:
> >>>
> >>> - Some services inadvertently used madvise(MADV_HUGEPAGE) through
> >>>   third-party libraries, bypassing our restrictions.
> >>
> >> Basically, you want more precise control of THP enablement and the
> >> ability of overriding madvise() from userspace.
> >>
> >> In terms of overriding madvise(), do you have any concrete example of
> >> these third-party libraries? madvise() users are supposed to know what
> >> they are doing, so I wonder why they are causing trouble in your
> >> environment.
> >
> > To my knowledge, jemalloc [0] supports THP.
> > Applications using jemalloc typically rely on its default
> > configurations rather than explicitly enabling or disabling THP. If
> > the system is configured with THP=3Dmadvise, these applications may
> > automatically leverage THP where appropriate
> >
> > [0]. https://github.com/jemalloc/jemalloc
>
> It sounds like a userspace issue. For jemalloc, if applications require
> it, can't you replace the jemalloc with a one compiled with --disable-thp
> to work around the issue?

That=E2=80=99s not the issue this patchset is trying to address or work
around. I believe we should focus on the actual problem it's meant to
solve.

By the way, you might not raise this question if you were managing a
large fleet of servers. We're a platform provider, but we don=E2=80=99t
maintain all the packages ourselves. Users make their own choices
based on their specific requirements. It's not a feasible solution for
us to develop and maintain every package.

>
> >
> >>
> >>>
> >>> To address this issue, we initially hooked the __x64_sys_madvise() sy=
scall,
> >>> which is error-injectable, to blacklist unwanted services. While this
> >>> worked, it was error-prone and ineffective for services needing alway=
s mode,
> >>> as modifying their code to use madvise was impractical.
> >>>
> >>> To achieve finer-grained control, we introduced an fmod_ret-based sol=
ution.
> >>> Now, we dynamically adjust THP settings per service by hooking
> >>> hugepage_global_{enabled,always}() via BPF. This allows us to set THP=
 to
> >>> enable or disable on a per-service basis without global impact.
> >>
> >> hugepage_global_*() are whole system knobs. How did you use it to
> >> achieve per-service control? In terms of per-service, does it mean
> >> you need per-memcg group (I assume each service has its own memcg) THP
> >> configuration?
> >
> > With this new BPF hook, we can manage THP behavior either per-service
> > or per-memory.
> > In our use case, we=E2=80=99ve chosen memcg-based control for finer-gra=
ined
> > management. Below is a simplified example of our implementation:
> >
> > struct{
> >         __uint(type, BPF_MAP_TYPE_HASH);
> >         __uint(max_entries, 4096);      /* usually there won't too
> > many cgroups */
> >         __type(key, u64);
> >         __type(value, u32);
> >         __uint(map_flags, BPF_F_NO_PREALLOC);
> > } thp_whitelist SEC(".maps");
> >
> > SEC("fmod_ret/mm_bpf_thp_vma_allowable")
> > int BPF_PROG(thp_vma_allowable, struct vm_area_struct *vma)
> > {
> >         struct cgroup_subsys_state *css;
> >         struct css_set *cgroups;
> >         struct mm_struct *mm;
> >         struct cgroup *cgroup;
> >         struct cgroup *parent;
> >         struct task_struct *p;
> >         u64 cgrp_id;
> >
> >         if (!vma)
> >                 return 0;
> >
> >         mm =3D vma->vm_mm;
> >         if (!mm)
> >                 return 0;
> >
> >         p =3D mm->owner;
> >         cgroups =3D p->cgroups;
> >         cgroup =3D cgroups->subsys[memory_cgrp_id]->cgroup;
> >         cgrp_id =3D cgroup->kn->id;
> >
> >         /* Allow the tasks in the thp_whiltelist to use THP. */
> >         if (bpf_map_lookup_elem(&thp_whitelist, &cgrp_id))
> >             return 1;
> >         return 0;
> > }
> >
> > I chose not to include this in the self-tests to avoid the complexity
> > of setting up cgroups for testing purposes. However, in patch #4 of
> > this series, I've included a simpler example demonstrating task-level
> > control.
>
> For task-level control, why not using prctl(PR_SET_THP_DISABLE)?

You=E2=80=99ll need to modify the user-space code=E2=80=94and again, this l=
ikely
wouldn=E2=80=99t be a concern if you were managing a large fleet of servers=
.

>
> > For service-level control, we could potentially utilize BPF task local
> > storage as an alternative approach.
>
> +cgroup people
>
> For service-level control, there was a proposal of adding cgroup based
> THP control[1]. You might need a strong use case to convince people.
>
> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.as=
ier@huawei-partners.com/

Thanks for the reference. I've reviewed the related discussion, and if
I understand correctly, the proposal was rejected by the maintainers.

--=20
Regards
Yafang

