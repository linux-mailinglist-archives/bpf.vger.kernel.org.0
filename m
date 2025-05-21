Return-Path: <bpf+bounces-58637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05291ABEA8D
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 06:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496547A6C94
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 04:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E622D7B1;
	Wed, 21 May 2025 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxtWBq59"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912002907
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800168; cv=none; b=g5m5ZKWLURgzVn7dQ3aPmeGSS3+Qej2Fi0aNJy/5CeUedgNmBkWBWayK6lwnWvvgVK9kZHx1CZQlBtY5ooLMGhp1CYebbGlm2yFK/dqt2dhiwtoxMQMJYunohrKwnzhHEq9QIMD6ZrFLgJE1V2Wl8yi8LR1mLXK/WVFwbcJunZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800168; c=relaxed/simple;
	bh=6HtqLLCwBUb99gIabn3dnxW6sMl7Nr+lz5CkjTrbe0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dkh7m24C4T+BRCjfIyIzsVWSpCr/34MBLyO2ugDxaM13NSujp9K8NYOe1FkpZ0rCUFUVFb2lkh2vLeMNBoUIz2nCsp32CfvTWtVR7zMRTscW6av5qrM/gp/kS75tE6c+1F6uGKjLf81WfTa7Yc8HF7Dk4Y8lj1D8i3JlfXwdWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxtWBq59; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f5373067b3so81544406d6.2
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 21:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747800165; x=1748404965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HtqLLCwBUb99gIabn3dnxW6sMl7Nr+lz5CkjTrbe0Q=;
        b=IxtWBq59MHMmiI03IIGRCZocBEjB5AU2/8DuS1k0IFaD+TvCUeTcc+LLT1X90IoJgd
         B+UyhD+2c+AWect8rcpwvF+jUF+C4e9tuB5dvgdeGqCL2chsAVA3eq0zQFyfv+fTRnef
         gXkCxIe5pQco75JJdh81HrBibrLydYOKfu0WlUPccfIdl4vZkmpwES5l+IS1yaQbGGmk
         VQ7Hi+7SC0hREke2OQB72TBDl/sg9JD0V6sQP9YA2pHGRXt6NYrQw9+mflaVnk4bm/po
         x1Gjg2vjRQ/FysQyq2tM1+gMu6NVuK0t8JrkOn2njBPJR0U+QiLtSUZLrnkeM3yhkbFy
         jzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747800165; x=1748404965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HtqLLCwBUb99gIabn3dnxW6sMl7Nr+lz5CkjTrbe0Q=;
        b=mnhdzcxkOibyS6fnoIc/RBrtrOkfr5cNU/VYESAXhvtgAn8GclRjEnaBH0gReKjdxW
         YTPpdORLEu1xVHRtCteZic0lIsvml26REFMJQ1J0kPNkLLi7BScz/3erOcpwGmXs9VtD
         qhEDeQlX9G+EhIkCwpNyPSBWkH5mK1v5AxsvbiKxW7Yt3u7yGKJBBo65UufT1UiMfwtK
         TeUCVrL6foqz1/OZgyUhCf+izNQZ2BqKCHS3RxkH4M8uDFlPa6SGETVMeo3C9sc6Y+gl
         IMlwK1pBYa+dDcM2uy/haUTNn3rhalcoIbKQHotPljOcIytkM1qEnClloshAHaqphomG
         U/mg==
X-Forwarded-Encrypted: i=1; AJvYcCVGJGjBC1jpP60d9cm57DJ5bPGhxOn6jc2RVjKThQTQnizRtJpRSxtjtIOFOff8xyzD2i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvNcl5ueg0zZyfb2lGnPkfdrScrW5jU6UFtjEQTeiLVF0zy8yT
	5maw8L/DqxIELz9/kgVbHLTernWy6bmx2l7ieBmRJhPAA0sv3+PPxPDlLg0K9TIEss9hz1vzMJF
	8jwttnS2HYcF3UVPVmEhZ5p2Dv+vWCrM=
X-Gm-Gg: ASbGnct4A62AwQv+dqy30+N1Tf7J8u2ElA+B5YsHoL3ANoOogiAK62ohsIZZ30txc+w
	dpyP6UAaYQGopiY5ywApfh6vt1k0nK+lhfzsEyLcIVX92ha0OIe5Ck5s3IpOuEOK3BV67e3xtjD
	Yun3ozef6k8+09zT+9nZWDK6zWO5d5zznkGQ==
X-Google-Smtp-Source: AGHT+IH3VLJxqXmpLuRFutOgfXxr4uHJ5w7FLUB7gGAidC+ZjeWwWlebh1V0twWXR4V4cpBCnI1l09g+Y1zg63YlWkI=
X-Received: by 2002:a05:6214:124c:b0:6f5:3e38:6127 with SMTP id
 6a1803df08f44-6f8b2d3ccc8mr312348726d6.42.1747800165186; Tue, 20 May 2025
 21:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520060504.20251-1-laoar.shao@gmail.com> <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
 <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local> <CALOAHbCZRDuMtc=MpiR1FWpURZAVrHWQmDV08ySsiPekxU2KcA@mail.gmail.com>
 <849decad-ab38-4a1a-8532-f518a108d8c6@lucifer.local> <9b44fe43-155d-457d-81ce-a2c1fb86521a@redhat.com>
In-Reply-To: <9b44fe43-155d-457d-81ce-a2c1fb86521a@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 May 2025 12:02:09 +0800
X-Gm-Features: AX0GCFsReOKCGqxICXXb7neCkzsy6lyNJknjYXZCpDfY_Aoc9vO15nTIrdwWGZA
Message-ID: <CALOAHbAQ49iY3X91nOrsTGJO7v31j8KiCe7XJy6q3iyio_sxdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:54=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >> I totally agree with you that the key point here is how to define the
> >> API. As I replied to David, I believe we have two fundamental
> >> principles to adjust the THP policies:
> >> 1. Selective Benefit: Some tasks benefit from THP, while others do not=
.
> >> 2. Conditional Safety: THP allocation is safe under certain conditions
> >> but not others.
> >>
> >> Therefore, I believe we can define these APIs based on the established
> >> principles - everything else constitutes implementation details, even
> >> if core MM internals need to change.
> >
> > But if we're looking to make the concept of THP go away, we really need=
 to
> > go further than this.
>
> Yeah. I might be wrong, but I also don't think doing control on a
> per-process level etc would be the right solution long-term.

The reality is that achieving truly 'automatic' THP behavior requires
process-level control. Given that THP provides no benefit for certain
workloads, there's no justification for incurring the overhead of
allocating higher-order pages in those cases.

>
> In a world where we do stuff automatically ("auto" mode), we would be
> much smarter about where to place a (m)THP, and which size we would use.

We still have considerable ground to cover before reaching this goal.

>
> One might use bpf to control the allocation policy. But I don't think
> this would be per-process or even per-VMA etc. Sure, we might give
> hints, but placement decisions should happen on another level (e.g.,
> during page faults, during khugepaged etc).

Nico has proposed introducing a new 'defer' mode to address this.
However, I argue that we could achieve the same functionality through
BPF instead of adding a dedicated policy mode. [0]

[0]. https://lore.kernel.org/linux-mm/CALOAHbAa7DY6+hO4RJtjg-MS+cnUmsiPXX8K=
S1MKSfgy6HLYAQ@mail.gmail.com/

>
> >
> > The second we have 'bpf program that figures out whether THP should be
> > used' we are permanently tied to the idea of THP on/off being a thing.
> >
> > I mean any future stuff that makes THP more automagic will probably inv=
olve
> > having new modes for the legacy THP
> > /sys/kernel/mm/transparent_hugepage/enabled and
> > /sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled
>
> Yeah, the plan is to have "auto" in
> /sys/kernel/mm/transparent_hugepage/enabled and just have all other
> sizes "inherit" that option. And have a Kconfig that just enables that
> as default. Once we're there, just phase out the interface long-term.
>
> That's the plan. Now we "only" have to figure out how to make the
> placement actually better ;)
>
> >
> > But if people are super reliant on this stuff it's potentially really
> > limiting.
> >
> > I think you said in another post here that you were toying with the not=
ion
> > of exposing somehow the madvise() interface and having that be the 'sta=
ble
> > API' of sorts?
> >
> > That definitely sounds more sensible than something that very explicitl=
y
> > interacts with THP.
> >
> > Of course we have Usama's series and my proposed series for extending
> > process_madvise() along those lines also.
>
> Yes.
>


--=20
Regards
Yafang

