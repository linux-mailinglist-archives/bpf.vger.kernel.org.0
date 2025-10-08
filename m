Return-Path: <bpf+bounces-70591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001BBC4B5C
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 14:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B904B351751
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E312F83C4;
	Wed,  8 Oct 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfwAdR31"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA62F7479
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925241; cv=none; b=efdvZyquu5SDB9bSynfzRzVsNbZId+LmmmBBEYaUwdKSpPrzkan5/YLfq59Bt1xRGS6oSTnCLhXW1DMAIDaL6NsZnJTQAmwOueVHT41AirJd9X9fAh+n5cdkfuwX431Kh1c+J3GCFp4dwJ183B0R0dQz6wRdVLjfrHoUPrk5Uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925241; c=relaxed/simple;
	bh=BVu2EEg8ejklaIGY6WvonMMEPvoYw6A3F33Ut3458MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI0Qki0wyVA2j0h4pRgqZEs/6yMTEN/J+mNxrlm1JAAdCVS0cVbalvR4uFcdptxRwDMG0cETibcndNQTkAZMjCQlvKnTDZyOFw/0kc18KL2r2Y3ZteM7YjIGwo3+aYbXYxfOVwWjcl2iUGrg+i+dLe7BMIh29T4BqHTkAA0PFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfwAdR31; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78febbe521cso79953576d6.2
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759925238; x=1760530038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnTtsbSmHH4T9zX0iyH6U/3gYlbL4q2Uw39tvDIL9jc=;
        b=GfwAdR31aFJ8IrZk+KKqE4Hf2uFVkUWir4ZFd4HK+nipILQpefIwmgCKh2/xekBYtN
         7rlASY91j5Js/rd3ElIhT8I6f2Nn7uPuQdWluRnn9Ew8KUp9uCvxqLfSvq+Rg2Q8jPaW
         hbz3mvKK8zlwNJABddhlYEpyW4h8iQw4wUzJjZbyX7owYxUkhS/asJT3ggcdENJg8V3q
         XdRLdrj3w0Ht95GsjIS+OfMxb4JJF+JCCJ5vDgQf7LgEPwWE4R0UxhkCf0P1MTqIHcBS
         cVJQHOFj02mFcNhIC0NPdCzNdhxGk1orGNw0LgFwEVrX7cohBYyaDAyqBH76JbD4HBEC
         wB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925238; x=1760530038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnTtsbSmHH4T9zX0iyH6U/3gYlbL4q2Uw39tvDIL9jc=;
        b=o5PWgqQCGWOKBrmmeBeERuuPpCVOWbadX+5kKyHocRzO5j1Jg72zLUAA4PIQxEdkk2
         vVpl/9djkiTAOL3E+NA4AUtgcOFiOFkehU5jgQW/Dhtcv0stgTvLVH0kYdZ+xNzLhhz1
         zfhyM+8zL3JrEpD5uB39F27UT2DJz6anrOqQJMesxL6wJoRiArp3HOT7/wkRJlp4PjhG
         xzbGUMEt5AaFkwv+lTgZlUeNyNLZB/wn7O0gCIWgzXsO1W7w92EGZR1ctu65edZL1dx0
         yoo/eZv1EHhr4N2MbFY45/eHCs+w7H3DUnHrZgPud0GstaOb10QZAZVDtqNrxRUCH1z+
         Ne7A==
X-Forwarded-Encrypted: i=1; AJvYcCWfFKl2owGj0XLjXKeZQJB+kgyba0kWU6TZifMAaUdmLMmDmCTIHRzuwzvsD0+AV/S958s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2U5bv+rmfjRG9f7VHsBKf6uNj7OFZpKyay/JvRsQ3XVqhx84
	6xMRAloGdWCCZTaonHt3moVEjvartYHLvH5i0YGLfR9lzw0wFbD+Oimk1gYkrWNQGcs2mCi2Dk+
	5jFRWXwEbnvgqgLO14h6Dr819T4E75Ps=
X-Gm-Gg: ASbGncttUzNBdo9pUO47kFyPebLuP5TLEiPe6RQqcMw2Lm65BAi5p2dGeIBVj0p/kui
	qNPG6g/ttJ2oP1SPUbfNUclMPY+LiZ9nz2XqodHEgJT/0+V99J6quv+k+P/Qm40CD6fNqhXDf6P
	mwYHVyVRr0zUFyk+ys6QQxpxdt09Reb0RPrpHz1NVZpevWefQEHSmpv6JxqT/xJ4zXTnOM52HxU
	+18LSta+ObW+Ox54a5zMEBvgLTDlJxceAq/Tte0UywbL3tlCBwcnpptzO/nGlRNVS2MtiIg4YY=
X-Google-Smtp-Source: AGHT+IEVKGmMv/tkSbd+O4UvvaCrDeP7UI1yITjpMQ8N+fjVNf2S7Zm9vVDrsesEpPbKlJ3VI/molVYwtOHeWvkfcWQ=
X-Received: by 2002:ad4:5948:0:b0:820:a83:eaff with SMTP id
 6a1803df08f44-87b2ef7fab7mr37825166d6.64.1759925237890; Wed, 08 Oct 2025
 05:07:17 -0700 (PDT)
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
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
In-Reply-To: <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 8 Oct 2025 20:06:40 +0800
X-Gm-Features: AS18NWBIxlsXVNTBzBqe9RKDEHMGwyRZXw76KJBRlynko-9PYAcMYCTd07kAK4o
Message-ID: <CALOAHbCS0WvUSsK_rbtU8LTLuz_eynVEa1ULyYmyRcMW_hfZWg@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
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

On Wed, Oct 8, 2025 at 7:27=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
>
> > On Wed, Oct 8, 2025 at 4:28=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 08.10.25 10:18, Yafang Shao wrote:
> >>> On Wed, Oct 8, 2025 at 4:08=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
> >>>>> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> >>>>>>
> >>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> >>>>>> +                                     enum tva_type type,
> >>>>>> +                                     unsigned long orders)
> >>>>>> +{
> >>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
> >>>>>> +       int bpf_order;
> >>>>>> +
> >>>>>> +       /* No BPF program is attached */
> >>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> >>>>>> +                     &transparent_hugepage_flags))
> >>>>>> +               return orders;
> >>>>>> +
> >>>>>> +       rcu_read_lock();
> >>>>>> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get=
_order);
> >>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> >>>>>> +               goto out;
> >>>>>> +
> >>>>>> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> >>>>>> +       orders &=3D BIT(bpf_order);
> >>>>>> +
> >>>>>> +out:
> >>>>>> +       rcu_read_unlock();
> >>>>>> +       return orders;
> >>>>>> +}
> >>>>>
> >>>>> I thought I explained it earlier.
> >>>>> Nack to a single global prog approach.
> >>>>
> >>>> I agree. We should have the option to either specify a policy global=
ly,
> >>>> or more refined for cgroups/processes.
> >>>>
> >>>> It's an interesting question if a program would ever want to ship it=
s
> >>>> own policy: I can see use cases for that.
> >>>>
> >>>> So I agree that we should make it more flexible right from the start=
.
> >>>
> >>> To achieve per-process granularity, the struct-ops must be embedded
> >>> within the mm_struct as follows:
> >>>
> >>> +#ifdef CONFIG_BPF_MM
> >>> +struct bpf_mm_ops {
> >>> +#ifdef CONFIG_BPF_THP
> >>> +       struct bpf_thp_ops bpf_thp;
> >>> +#endif
> >>> +};
> >>> +#endif
> >>> +
> >>>   /*
> >>>    * Opaque type representing current mm_struct flag state. Must be a=
ccessed via
> >>>    * mm_flags_xxx() helper functions.
> >>> @@ -1268,6 +1281,10 @@ struct mm_struct {
> >>>   #ifdef CONFIG_MM_ID
> >>>                  mm_id_t mm_id;
> >>>   #endif /* CONFIG_MM_ID */
> >>> +
> >>> +#ifdef CONFIG_BPF_MM
> >>> +               struct bpf_mm_ops bpf_mm;
> >>> +#endif
> >>>          } __randomize_layout;
> >>>
> >>> We should be aware that this will involve extensive changes in mm/.
> >>
> >> That's what we do on linux-mm :)
> >>
> >> It would be great to use Alexei's feedback/experience to come up with
> >> something that is flexible for various use cases.
> >
> > I'm still not entirely convinced that allowing individual processes or
> > cgroups to run independent progs is a valid use case. However, since
> > we have a consensus that this is the right direction, I will proceed
> > with this approach.
> >
> >>
> >> So I think this is likely the right direction.
> >>
> >> It would be great to evaluate which scenarios we could unlock with thi=
s
> >> (global vs. per-process vs. per-cgroup) approach, and how
> >> extensive/involved the changes will be.
> >
> > 1. Global Approach
> >    - Pros:
> >      Simple;
> >      Can manage different THP policies for different cgroups or process=
es.
> >   - Cons:
> >      Does not allow individual processes to run their own BPF programs.
> >
> > 2. Per-Process Approach
> >     - Pros:
> >       Enables each process to run its own BPF program.
> >     - Cons:
> >       Introduces significant complexity, as it requires handling the
> > BPF program's lifecycle (creation, destruction, inheritance) within
> > every mm_struct.
> >
> > 3. Per-Cgroup Approach
> >     - Pros:
> >        Allows individual cgroups to run their own BPF programs.
> >        Less complex than the per-process model, as it can leverage the
> > existing cgroup operations structure.
> >     - Cons:
> >        Creates a dependency on the cgroup subsystem.
> >        might not be easy to control at the per-process level.
>
> Another issue is that how and who to deal with hierarchical cgroup, where=
 one
> cgroup is a parent of another. Should bpf program to do that or mm code
> to do that?

The cgroup subsystem handles this propagation automatically. When a
BPF program is attached to a cgroup via cgroup_bpf_attach(), it's
automatically inherited by all descendant cgroups.

Note: struct-ops programs aren't supported by cgroup_bpf_attach(),
requiring us to build new attachment mechanisms for cgroup-based
struct-ops.

> I remember hierarchical cgroup is the main reason THP control
> at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't we
> get the same rejection from cgroup folks?

Right, it was rejected by the cgroup maintainers [0]

[0]. https://lore.kernel.org/linux-mm/20241030150851.GB706616@cmpxchg.org/

--=20
Regards
Yafang

