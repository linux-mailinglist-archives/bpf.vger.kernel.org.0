Return-Path: <bpf+bounces-70593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6ABC5256
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B39189BA43
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315CD27C17C;
	Wed,  8 Oct 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfzQuLW2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83B23D29F
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929139; cv=none; b=p+/mi5FBN02x+rM5KQxdFhJps+mbK57plxJe0MSOh2SHI0dKoEOAeZ/f5mExcV+HvI0vmXgNZw1sF5j+aSLriGpeH5iXgLMKDAd01veunz3vgWIybsIv2vlHGoeXBPOj6NIOGajFWtpF2JNABsyiiG6hH+JKbqzdx09JG4kiv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929139; c=relaxed/simple;
	bh=xpmGg4c/Cl5ZY8pMnlzNFA1QPQP86/btg3j7tq3p2As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRyBIKbrt7htuxAlrEm/eD+eQZTX8/YzmrAFPgB27PmVVAtQbPLNfszQ/lC0NjJIyGNBvgoxrDDeC8Co0o+fbYQJB1epZDkoAqMeSZ0HizFrclQLSzOD9fWLsSoVl5/MXbb01ds8BcI6rbrPLWVHBMinfFf2bB89c5Xcj9PZEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfzQuLW2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-791875a9071so72735666d6.1
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929137; x=1760533937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBKwa75rcl5jnXtV/oS/WIGH19YZKQyj0WoGa9cCm+I=;
        b=AfzQuLW26qLV0TO7J0YgyYvNWLNPTP+63uUk5+wQH7LcU/y06cOHO92q/9QCxgyLIs
         ZJTMMMjbd8kzYT4Wl2KaPQN6rAx3z90MAKJhYUq+9XN2QhfKkRnumtDWq+DtL92JK/x/
         D9+qjNLJBHIZoUy5HTjCnuQ7cxrYCPCDIIJiH+yJJxBMHC+00Tm6qU1ZaNa5GTO0ed0T
         JLHc0ZOOrJ+AvvfjAI4SYHWfJe6IX3ol1dyGJRPNJOJhN9a+Xqr+BvSISEvrdluc4ly0
         +/SaJCpENX8XbfSwnGTgUtfTbUzeConzbS/GEclFORfYcLkBx5nLayKmf4qiYKqeBgoe
         syyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929137; x=1760533937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBKwa75rcl5jnXtV/oS/WIGH19YZKQyj0WoGa9cCm+I=;
        b=QZ1BfVYSKkMTJHDkVmg6ucaFQWrYXeSAd3A9XjgdPpt6Vbrpn/ip8GYoDibVbVu69I
         RYSQaW0p+oK8lRDzdGqhJS0R1rZICxsJ65Fan78q+NrSZ6L2Vbc/ncw/XBZH7zrF0Wjp
         OlryJMVqE8CdvbjhcaAbkwF5eIbIwOAlZHge/CxU1CVL/5KIfXuUgCjR1JSyJwRowR9S
         4P18y91ZzUBaPPpUlirgqI1XqjXLaZgUMlo1PMTDbkq+TScauib67aorrPQQaQ5eN5Wm
         /Whq3K4oft7vJozRbWLWmTXpH9G1SH43s52tiefH9Htmns1A6q22qEAUClef+aUdoIN3
         fsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9jsyDfScTVnrv2840A4dUC6zt3OckUJxYe7s04qon4uv+ZguIMy8QsgpuUAKUK0phIlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9wfpNjVNmqknRzwk7Nizmb3DB+Mdz3mWUR4M9/xTyEmm9Y1+
	L9ibLwvcy4nQILon5xPb4W7JY2pqKJVxUgBnKIUUX4TH5j76fkxFebJKt+aIqN0Omn4sstFj2gY
	90yNCdG55RuDRAWuq71Ap601fw+/F/vo=
X-Gm-Gg: ASbGncuYFWg6PdfCAewgRkIEq4xudhDAoQbQ3rhpsSsa0EWtmcDkyjH3yVQEBgO8aiA
	0Wm40W06cejTlH9CmtATkhzjTtiOW3h4LDiocEMkbWWSJYw5++9jxPj1fvK+wlnbLN+S8dUicKP
	SU65Y9v+fOEzmUAeSn8E73BK+8aGBfghf1UwMU59kmuVuK1Sqq1mSDGa2OEnJywQRgB+cuX3U3A
	l46HiVonA9fdlHr8+i/4j8Xta+WhVI8q6q8RVWG6sWFuuJfmq+odrNIy0+/0/gLoWOzl91NX2A=
X-Google-Smtp-Source: AGHT+IFzUXffB1zB7vnWpuKrlcQPdtVGJfSjZp7EPf6PBL/bCYvn3+y9LWXlhXOmcWWw4fXUcxkyECmMdiurn0kjvhs=
X-Received: by 2002:a05:6214:268b:b0:796:6034:c0fb with SMTP id
 6a1803df08f44-87b20ff9e9fmr42443166d6.13.1759929136653; Wed, 08 Oct 2025
 06:12:16 -0700 (PDT)
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
In-Reply-To: <f743cfcd-2467-42c5-9a3c-3dceb6ff7aa8@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 21:11:39 +0800
X-Gm-Features: AS18NWAfLSZj5vVPHQEFQdqoJ0RU1U5dgEf--oeMfkY_sJP1b_wNMDZYIuMpIdc
Message-ID: <CALOAHbAY9sjG-M=nwWRdbp3_m2cx_YJCb7DToaXn-kHNV+A5Zg@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	Matthew Wilcox <willy@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, Randy Dunlap <rdunlap@infradead.org>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.10.25 13:27, Zi Yan wrote:
> > On 8 Oct 2025, at 5:04, Yafang Shao wrote:
> >
> >> On Wed, Oct 8, 2025 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>>
> >>> On 08.10.25 10:18, Yafang Shao wrote:
> >>>> On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>>
> >>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
> >>>>>> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> >>>>>>>
> >>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma=
,
> >>>>>>> +                                     enum tva_type type,
> >>>>>>> +                                     unsigned long orders)
> >>>>>>> +{
> >>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >>>>>>> +       int bpf_order;
> >>>>>>> +
> >>>>>>> +       /* No BPF program is attached */
> >>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >>>>>>> +                     &transparent_hugepage_flags))
> >>>>>>> +               return orders;
> >>>>>>> +
> >>>>>>> +       rcu_read_lock();
> >>>>>>> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_ge=
t_order);
> >>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >>>>>>> +               goto out;
> >>>>>>> +
> >>>>>>> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> >>>>>>> +       orders &=3D BIT(bpf_order);
> >>>>>>> +
> >>>>>>> +out:
> >>>>>>> +       rcu_read_unlock();
> >>>>>>> +       return orders;
> >>>>>>> +}
> >>>>>>
> >>>>>> I thought I explained it earlier.
> >>>>>> Nack to a single global prog approach.
> >>>>>
> >>>>> I agree. We should have the option to either specify a policy globa=
lly,
> >>>>> or more refined for cgroups/processes.
> >>>>>
> >>>>> It's an interesting question if a program would ever want to ship i=
ts
> >>>>> own policy: I can see use cases for that.
> >>>>>
> >>>>> So I agree that we should make it more flexible right from the star=
t.
> >>>>
> >>>> To achieve per-process granularity, the struct-ops must be embedded
> >>>> within the mm_struct as follows:
> >>>>
> >>>> +#ifdef CONFIG_BPF_MM
> >>>> +struct bpf_mm_ops {
> >>>> +#ifdef CONFIG_BPF_THP
> >>>> +       struct bpf_thp_ops bpf_thp;
> >>>> +#endif
> >>>> +};
> >>>> +#endif
> >>>> +
> >>>>    /*
> >>>>     * Opaque type representing current mm_struct flag state. Must be=
 accessed via
> >>>>     * mm_flags_xxx() helper functions.
> >>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
> >>>>    #ifdef CONFIG_MM_ID
> >>>>                   mm_id_t mm_id;
> >>>>    #endif /* CONFIG_MM_ID */
> >>>> +
> >>>> +#ifdef CONFIG_BPF_MM
> >>>> +               struct bpf_mm_ops bpf_mm;
> >>>> +#endif
> >>>>           } __randomize_layout;
> >>>>
> >>>> We should be aware that this will involve extensive changes in mm/.
> >>>
> >>> That's what we do on linux-mm :)
> >>>
> >>> It would be great to use Alexei's feedback/experience to come up with
> >>> something that is flexible for various use cases.
> >>
> >> I'm still not entirely convinced that allowing individual processes or
> >> cgroups to run independent progs is a valid use case. However, since
> >> we have a consensus that this is the right direction, I will proceed
> >> with this approach.
> >>
> >>>
> >>> So I think this is likely the right direction.
> >>>
> >>> It would be great to evaluate which scenarios we could unlock with th=
is
> >>> (global vs. per-process vs. per-cgroup) approach, and how
> >>> extensive/involved the changes will be.
> >>
> >> 1. Global Approach
> >>     - Pros:
> >>       Simple;
> >>       Can manage different THP policies for different cgroups or proce=
sses.
> >>    - Cons:
> >>       Does not allow individual processes to run their own BPF program=
s.
> >>
> >> 2. Per-Process Approach
> >>      - Pros:
> >>        Enables each process to run its own BPF program.
> >>      - Cons:
> >>        Introduces significant complexity, as it requires handling the
> >> BPF program's lifecycle (creation, destruction, inheritance) within
> >> every mm_struct.
> >>
> >> 3. Per-Cgroup Approach
> >>      - Pros:
> >>         Allows individual cgroups to run their own BPF programs.
> >>         Less complex than the per-process model, as it can leverage th=
e
> >> existing cgroup operations structure.
> >>      - Cons:
> >>         Creates a dependency on the cgroup subsystem.
> >>         might not be easy to control at the per-process level.
> >
> > Another issue is that how and who to deal with hierarchical cgroup, whe=
re one
> > cgroup is a parent of another. Should bpf program to do that or mm code
> > to do that? I remember hierarchical cgroup is the main reason THP contr=
ol
> > at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't =
we
> > get the same rejection from cgroup folks?
>
> Valid point.
>
> I do wonder if that problem was already encountered elsewhere with bpf
> and if there is already a solution.

Our standard is to run only one instance of a BPF program type
system-wide to avoid conflicts. For example, we can't have both
systemd and a container runtime running bpf-thp simultaneously.

Perhaps Alexei can enlighten us, though we'd need to read between his
characteristically brief lines. ;-)

>
> Focusing on processes instead of cgroups might be easier initially.


--=20
Regards
Yafang

