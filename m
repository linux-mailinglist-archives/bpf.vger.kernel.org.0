Return-Path: <bpf+bounces-70775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E04BCEE77
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 04:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023F119A3BA0
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 02:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1A1957FC;
	Sat, 11 Oct 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dspWmUds"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46215A848
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760148868; cv=none; b=c1vq6tGc9j9tb9an6w4PnZoZStBk3+OZSqOQVVZoT+oHnAfCuUbCTVATdH/CpLC1C2KlHEscJtTZOcyxoCHXKpv6GRg9bv5MB9Gq1NW5y7fjsAL6iy2/O0GMFe5/ekDjoqlFymCm290Kpkkh8HH45q0k+/wcNsWr9if/8OKoIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760148868; c=relaxed/simple;
	bh=MvLEj9hucysQ43ekc4SLvEyDMBwRfa6Vthc+LLe9js4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJCk0hJ4pRjkOJvbuj9AYCA5hWgNxJPW04Z9ccb8QGF4F7YeZ5jMvAR8IB4jzxnZIl3lACvHCoAmfC6X5moc4h4VWdJjulFmS9BZCEmP06EjMEbO8OjcPO0Hi61oQg2CZibOJFtuorU+Q45hMAzY3KVa3Xyvk25kppYIdDFytbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dspWmUds; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78ea15d3489so27756736d6.3
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760148865; x=1760753665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjM7Uo7QXRSYcqIINz76pFr6NJAIPUeKl8+ji06M7jI=;
        b=dspWmUdscCvqkoFepAyqW4ATgVV+D3bBNXpKrba26EggEL63orZIppAozYFUwWLHHq
         kM3rDMIBTz/nIPYBmaFidFvLOmX/No2wkODsNUEIE0NN2Ixq49dNZt97G+f/it7jMVGV
         VYJp1Qk2qY3ZVmgCAe1gXaBiTGOFNhdaMRA1HC4kMDMhidcWrTvqmQJ45pTbOTUMdkpD
         Mo8UfPE6T7K7FAJGpjrM7VdBzckdKXs8az60hfca2Zxd5/WAJ7qXDC5yEaPKEdmtJ1vU
         mqJs9RaozKzH2NYxYqba1U8QYQrmsGSDXw8oHroB+oqCHDHTfRJJWDfSJUZVXCqwvY/R
         udsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760148865; x=1760753665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjM7Uo7QXRSYcqIINz76pFr6NJAIPUeKl8+ji06M7jI=;
        b=M51u7wnj4Pt9TBInhde3IoQCmdl4vdcuNdkZeBplmk0Bc5y3zFT8lrDBD1tI8GrUZ2
         5D+nN9Y3eewxMMtCwff/GG+SOEM30bM4psdruOc8ooeb5JWayswrcT2kbO/1i1+faQwn
         aIJX+N75OeoJW05rVdMbh8S96wX71aQ8rhSw/9rR928p/vlfii7B0osIxR57tSURxiKH
         YWScquXAcGM+jmuHWI5444veQ4psO1640Oy8sPHAe83Sh6PnLUBZ3Fw8dbZt5SnUHpiv
         T9XtR9wpzh5vkcpLbfp7FNsx8Xfw+5TbsnasgL/mVp3JzX5ukIfYsghEYB5BxM4p8NLS
         P0NA==
X-Forwarded-Encrypted: i=1; AJvYcCUna7gCIa4Lt6Xhr6I9b16hVp6VrFYOHTWoURNMcgBIUCFDL+abyzwTylB+nBrIX5GUQZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGwnTqL7QRkasISr20L996fvmCKDEOgjejRvpdsVXMlBuqv6O
	KrF0KVtorI8ZZOB2NpMi1rG21zvvJXjKOxyyAHgQTRirtg5S0xtrT3m/6rQENtfRisml8DIEsvg
	jtkbS4MqlEnHuySeZiSnkjkiyTtY2HKQ=
X-Gm-Gg: ASbGncusRYJmILSjSkkCa431Thjq1L9gAJM55WphPGJpPJmyk/xpf9WNwnfKRxUqXZB
	RBqv7/EtrK/2f30buMI4P1Q0+V0dIK/fQRS3wCajJt026Vvj4A3TiGQ7bALUsOKoNhySFA5C9NI
	LN/gjAT2kWceXsx8+XbPytHbPoDS3NKRk7trtdJwFEEtk+t15fve2kzxZEdTVSagPE54VK+PzDQ
	aMyY5PyM9x/17oc9cj4oyB3kpHDe0ySHsS2hHwEPKcHi3nShehFD7t5aFY=
X-Google-Smtp-Source: AGHT+IGaeWexa9bzckVo2Zuz8KIURfJ9ec0dzy2/uD8zB9hlaiwuFTNQBQBPWfvTfKv9XXFEhBIN1ZQ9u4RYMWr8GwE=
X-Received: by 2002:a05:6214:250d:b0:72a:ba05:7759 with SMTP id
 6a1803df08f44-87b2105abd3mr248316426d6.28.1760148864567; Fri, 10 Oct 2025
 19:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com> <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com> <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com> <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
 <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
 <129379f6-18c7-4d10-8241-8c6c5596d6d5@redhat.com> <CALOAHbD8ko104PEFHPYjvnhKL50XTtpbHL_ehTLCCwSX0HG3-A@mail.gmail.com>
 <3577f7fd-429a-49c5-973b-38174a67be15@redhat.com>
In-Reply-To: <3577f7fd-429a-49c5-973b-38174a67be15@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 11 Oct 2025 10:13:48 +0800
X-Gm-Features: AS18NWCAaE3m0s9H3fRQL4N3FgUc6r2BHuW_Zdib2ILLDEDUTnQn0cQOhl7yXZI
Message-ID: <CALOAHbAeS2HzQN96UZNOCuME098=GvXBUh1P4UwUJr0U-bB5EQ@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: David Hildenbrand <david@redhat.com>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	Matthew Wilcox <willy@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 3:54=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 09.10.25 11:59, Yafang Shao wrote:
> > On Thu, Oct 9, 2025 at 5:19=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 08.10.25 15:11, Yafang Shao wrote:
> >>> On Wed, Oct 8, 2025 at 8:07=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 08.10.25 13:27, Zi Yan wrote:
> >>>>> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
> >>>>>
> >>>>>> On Wed, Oct 8, 2025 at 4:28=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> >>>>>>>
> >>>>>>> On 08.10.25 10:18, Yafang Shao wrote:
> >>>>>>>> On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@=
redhat.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
> >>>>>>>>>> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.sh=
ao@gmail.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct =
*vma,
> >>>>>>>>>>> +                                     enum tva_type type,
> >>>>>>>>>>> +                                     unsigned long orders)
> >>>>>>>>>>> +{
> >>>>>>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >>>>>>>>>>> +       int bpf_order;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       /* No BPF program is attached */
> >>>>>>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >>>>>>>>>>> +                     &transparent_hugepage_flags))
> >>>>>>>>>>> +               return orders;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       rcu_read_lock();
> >>>>>>>>>>> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.th=
p_get_order);
> >>>>>>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >>>>>>>>>>> +               goto out;
> >>>>>>>>>>> +
> >>>>>>>>>>> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, order=
s);
> >>>>>>>>>>> +       orders &=3D BIT(bpf_order);
> >>>>>>>>>>> +
> >>>>>>>>>>> +out:
> >>>>>>>>>>> +       rcu_read_unlock();
> >>>>>>>>>>> +       return orders;
> >>>>>>>>>>> +}
> >>>>>>>>>>
> >>>>>>>>>> I thought I explained it earlier.
> >>>>>>>>>> Nack to a single global prog approach.
> >>>>>>>>>
> >>>>>>>>> I agree. We should have the option to either specify a policy g=
lobally,
> >>>>>>>>> or more refined for cgroups/processes.
> >>>>>>>>>
> >>>>>>>>> It's an interesting question if a program would ever want to sh=
ip its
> >>>>>>>>> own policy: I can see use cases for that.
> >>>>>>>>>
> >>>>>>>>> So I agree that we should make it more flexible right from the =
start.
> >>>>>>>>
> >>>>>>>> To achieve per-process granularity, the struct-ops must be embed=
ded
> >>>>>>>> within the mm_struct as follows:
> >>>>>>>>
> >>>>>>>> +#ifdef CONFIG_BPF_MM
> >>>>>>>> +struct bpf_mm_ops {
> >>>>>>>> +#ifdef CONFIG_BPF_THP
> >>>>>>>> +       struct bpf_thp_ops bpf_thp;
> >>>>>>>> +#endif
> >>>>>>>> +};
> >>>>>>>> +#endif
> >>>>>>>> +
> >>>>>>>>      /*
> >>>>>>>>       * Opaque type representing current mm_struct flag state. M=
ust be accessed via
> >>>>>>>>       * mm_flags_xxx() helper functions.
> >>>>>>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
> >>>>>>>>      #ifdef CONFIG_MM_ID
> >>>>>>>>                     mm_id_t mm_id;
> >>>>>>>>      #endif /* CONFIG_MM_ID */
> >>>>>>>> +
> >>>>>>>> +#ifdef CONFIG_BPF_MM
> >>>>>>>> +               struct bpf_mm_ops bpf_mm;
> >>>>>>>> +#endif
> >>>>>>>>             } __randomize_layout;
> >>>>>>>>
> >>>>>>>> We should be aware that this will involve extensive changes in m=
m/.
> >>>>>>>
> >>>>>>> That's what we do on linux-mm :)
> >>>>>>>
> >>>>>>> It would be great to use Alexei's feedback/experience to come up =
with
> >>>>>>> something that is flexible for various use cases.
> >>>>>>
> >>>>>> I'm still not entirely convinced that allowing individual processe=
s or
> >>>>>> cgroups to run independent progs is a valid use case. However, sin=
ce
> >>>>>> we have a consensus that this is the right direction, I will proce=
ed
> >>>>>> with this approach.
> >>>>>>
> >>>>>>>
> >>>>>>> So I think this is likely the right direction.
> >>>>>>>
> >>>>>>> It would be great to evaluate which scenarios we could unlock wit=
h this
> >>>>>>> (global vs. per-process vs. per-cgroup) approach, and how
> >>>>>>> extensive/involved the changes will be.
> >>>>>>
> >>>>>> 1. Global Approach
> >>>>>>       - Pros:
> >>>>>>         Simple;
> >>>>>>         Can manage different THP policies for different cgroups or=
 processes.
> >>>>>>      - Cons:
> >>>>>>         Does not allow individual processes to run their own BPF p=
rograms.
> >>>>>>
> >>>>>> 2. Per-Process Approach
> >>>>>>        - Pros:
> >>>>>>          Enables each process to run its own BPF program.
> >>>>>>        - Cons:
> >>>>>>          Introduces significant complexity, as it requires handlin=
g the
> >>>>>> BPF program's lifecycle (creation, destruction, inheritance) withi=
n
> >>>>>> every mm_struct.
> >>>>>>
> >>>>>> 3. Per-Cgroup Approach
> >>>>>>        - Pros:
> >>>>>>           Allows individual cgroups to run their own BPF programs.
> >>>>>>           Less complex than the per-process model, as it can lever=
age the
> >>>>>> existing cgroup operations structure.
> >>>>>>        - Cons:
> >>>>>>           Creates a dependency on the cgroup subsystem.
> >>>>>>           might not be easy to control at the per-process level.
> >>>>>
> >>>>> Another issue is that how and who to deal with hierarchical cgroup,=
 where one
> >>>>> cgroup is a parent of another. Should bpf program to do that or mm =
code
> >>>>> to do that? I remember hierarchical cgroup is the main reason THP c=
ontrol
> >>>>> at cgroup level is rejected. If we do per-cgroup bpf control, would=
n't we
> >>>>> get the same rejection from cgroup folks?
> >>>>
> >>>> Valid point.
> >>>>
> >>>> I do wonder if that problem was already encountered elsewhere with b=
pf
> >>>> and if there is already a solution.
> >>>
> >>> Our standard is to run only one instance of a BPF program type
> >>> system-wide to avoid conflicts. For example, we can't have both
> >>> systemd and a container runtime running bpf-thp simultaneously.
> >>
> >> Right, it's a good question how to combine policies, or "who wins".
> >
> >  From my perspective, the ideal approach is to have one BPF-THP
> > instance per mm_struct. This allows for separate managers in different
> > domains, such as systemd managing BPF-THP for system processes and
> > containerd for container processes, while ensuring that any single
> > process is managed by only one BPF-THP.
>
> I came to the same conclusion. At least it's a valid start.
>
> Maybe we would later want a global fallback BPF-THP prog if none was
> enabled for a specific MM.

good idea. We can fallback to the global model when attaching pid 1.

>
> But I would expect to start with a per MM way of doing it, it gives you
> way more flexibility in the long run.

THP, such as shmem and file-backed THP, are shareable across multiple
processes and cgroups. If we allow different BPF-THP policies to be
applied to these shared resources, it could lead to policy
inconsistencies. This would ultimately recreate a long-standing issue
in memcg, which still lacks a robust solution for this problem [0].

This suggests that applying SCOPED policies to SHAREABLE memory may be
fundamentally flawed ;-)

[0]. https://lore.kernel.org/linux-mm/YwNold0GMOappUxc@slm.duckdns.org/

(Added the maintainers from the old discussion to this thread.)

--=20
Regards
Yafang

