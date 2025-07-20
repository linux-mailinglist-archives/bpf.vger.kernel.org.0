Return-Path: <bpf+bounces-63814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A6B0B33E
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F65D3ABBCF
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6C2E3716;
	Sun, 20 Jul 2025 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmHBQBZH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E94C85
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752980445; cv=none; b=f+/nX85VKBW/Ju526NMIPjFqDZNytdXruw+FAGwh/h4/rz8Dj7cRNbSoTu8+MA/OlGJOFbEiCFzhB4vZ4i26uzBjvbotjMHqscgRBaq9rUVkcZuczhBM6SDVOUvyZB1I8OJiWQCFoHGFqHqM4pXgRTCBOTtLDXK7AMEsPIxyVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752980445; c=relaxed/simple;
	bh=+LZIJ42lefgHc3vN2WiJ7zYk1jcjdZULo5z4KEBsL00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZ8hbxlzyvHxF45G9z0ooyeUmffg4ZTyWQYtIKqP0o4s9RhcVcG4v7rS50+nRi+MPyJ/sosKHc9v1qcK8VDe7lOda/bhUgXii5fSBz5SQk2NVt+Td4rjtOZZ1QgFnxkotNgLeI12fMJLySDrmTx16xLv9UAFm4M8rEABUbMhLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmHBQBZH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fabb948e5aso33839606d6.1
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752980442; x=1753585242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usaLBwpi9OVmz3of8m9IN0eJF2HKiIcgcSrXxMCtjhk=;
        b=MmHBQBZHFjyrBpgS1W6410IjP/In3YyrB4aGLTgWt7nIcjWAnSdHmxhq1dcxIUWvxh
         kN+UUuI5FlMnh3qBELWTmF1EfHjxL6EAJWBK2hd3+wSRT2Y2V9WM9rVTVZzBzNIwDiDH
         QcICYk8AMDtLwgPvxE6NaAF04WURVRT0N0goeZX1CH1RT8RDFLkhN4vhacqgFRetAYnK
         My2qlYo9osL3T5P3DFJPQPT3TNraAWucJos1Fv+ez52JPagRuJjFk6BoeUjICvDjmuhx
         NlIq+PHRCH04RNBJqGYaX1urI29GQ5yUEstbQa5VPSN+ehT6xKJMH6u3xkM7X8CDF+T0
         UTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752980442; x=1753585242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usaLBwpi9OVmz3of8m9IN0eJF2HKiIcgcSrXxMCtjhk=;
        b=tcOJurd5Tb08kqJS7TjJhY3/xgqaLVg18Wi+xzU5co/rX7+pVEFAs5wJTML7/nDUJS
         jVkrSFA77H7l3KGieLi/6xuy1+dkjYbu1AyBXGvr9xzoJrxLVftZgg6QTbpklxNEehef
         LfZiyGlBYjPpTuflTeWvIRkXOV+e6E1Hg7msSRWzJUv/IuqkX+W4hXesCHvbiG+G3+Gd
         V0XCnouRQqo9+JlhUNZrhkdnc3gChO+75oi8Y3fM3CbSegNtWYcbNWd83g5FT0kdOY4Y
         /yqEyvRj7sUJ3rUMhnGpeA/dh8KytYh1Yyo1A5Q2LTSSlTHRc32HHZRnYuxlCV3YIyAT
         CMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzGniOy+bCICanQEoioeYyxWExZtck6u684a0PckA4hxIihQ/noSqjnVcd3pEb1TtNKL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgAFTwQpSnB1BqTYNeeokc29Hn9zD7eyZwWqg3Q+kBr8h92O4
	saQEqcHFgL5KldCFGqF6w4MyqRn8xyJVML0WZhBDwlzuN93qPXkLNLhM2m52jrXlNCL79J2TWVS
	p0C6nIUrfBeX+x66L53r3II8ygGjXZP4=
X-Gm-Gg: ASbGnctiruuzvgErwBbfCScJHLR6foo2vqDGchvVZAs98kABlOIYMaoKQQke/YWX9i2
	YlPVTv6dJwdeDmdkWWDw8b0cRKJv2Pw2orLI4Bl/k9pNo+XyI3Amny8l5wLUI2UwSqPLCFF2n2R
	t3lscbEz4KoYYWpqGLeUTu0A+y73F8knZ2U/I5S5vh9h7e75H03O5PG3tLTwaX8zaUUkQpMRZNE
	cSYuuR2
X-Google-Smtp-Source: AGHT+IEn+qPSPfjnI0o/h2PRsh2Z14ypiX7IZI3vT0u2cSjT2O3N8mv53++RoBSEcpuQ/A5YdpPVAiWKa8DWUntEZbg=
X-Received: by 2002:a05:6214:2621:b0:704:e137:e29 with SMTP id
 6a1803df08f44-704f69fde21mr205580286d6.9.1752980442473; Sat, 19 Jul 2025
 20:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <20250608073516.22415-3-laoar.shao@gmail.com>
 <90ef1e37-4d76-4714-9071-51c33e315fa5@gmail.com>
In-Reply-To: <90ef1e37-4d76-4714-9071-51c33e315fa5@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 20 Jul 2025 11:00:06 +0800
X-Gm-Features: Ac12FXyEytQQb_wC9IJ5Ce1VsEVIrs0HGGDVDTCa3Pqzem5X8li2u8jHxBopWok
Message-ID: <CALOAHbCZ3Tnsv=rCKeGnw5LoMmaoPK9e0MLKnnt6+=pznuDTmA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/5] mm, thp: add bpf thp hook to determine thp allocator
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:30=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 08/06/2025 08:35, Yafang Shao wrote:
> > A new hook bpf_thp_allocator() is added to determine if the THP is
> > allocated by khugepaged or by the current task.
>
> I would add in the summary why we need this. I am assuming I will find ou=
t
> when reviewing the next few patches, but would be good to know here.
>
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 10 ++++++++++
> >  mm/khugepaged.c         |  2 ++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2f190c90192d..db2eadd3f65b 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -190,6 +190,14 @@ static inline bool hugepage_global_always(void)
> >                       (1<<TRANSPARENT_HUGEPAGE_FLAG);
> >  }
> >
> > +#define THP_ALLOC_KHUGEPAGED (1 << 1)
> > +#define THP_ALLOC_CURRENT (1 << 2)
> > +static inline int bpf_thp_allocator(unsigned long vm_flags,
> > +                                  unsigned long tva_flags)
> > +{
> > +     return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
>
> You dont use either vm_flags or tva_flags in this function?
> I am guessing you wanted to check if these bits are set here?
>
>
> But you dont seem to be setting these flags anywhere? I am guessing
> its in a future patch. If it is, I would move the setting of these bits
> here as its confusing to only see the check without knowing where its
>
> I feel this patch is broken and needs to be rewritten.

The `bpf_thp_allocator()` function serves as a placeholder that will
be implemented by a BPF program. The BPF implementation will use the
`@vm_flags` and `@tva_flags` parameters to determine whether a task
qualifies for THP allocation.

I see how this could be confusing.

> > +}
> > +
> >  static inline int highest_order(unsigned long orders)
> >  {
> >       return fls_long(orders) - 1;
> > @@ -290,6 +298,8 @@ unsigned long thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
> >       if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> >               unsigned long mask =3D READ_ONCE(huge_anon_orders_always)=
;
> >
> > +             if (!(bpf_thp_allocator(vm_flags, tva_flags) & THP_ALLOC_=
CURRENT))
> > +                     return 0;
>
> I am assuming that this is the point to check for allocation, but thp_vma=
_allowable_orders
> is not just used for allocation, its used for in other places as well, li=
ke hugepage_vma_revalidate
> and swap.

Agreed, some adjustments are necessary.

--=20
Regards
Yafang

