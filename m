Return-Path: <bpf+bounces-67067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278BEB3D0D4
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 05:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F20189DBAA
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 03:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9125520102C;
	Sun, 31 Aug 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/Hrn0CL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62648CFC;
	Sun, 31 Aug 2025 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756610226; cv=none; b=Z9jzth5aWdemNSZd/AeGEFqmKEiqorJQY4cyd30EV7tFE753Rf31CTRqSa2RaTRnAaAdvOweJ4bvjiuAduuMO9CCM6Av0AHiOmIFU4Wn3wubDvGDASj2nGkYg0blkC216a+IFrOmDI1LadzzduhS7IUIvOUjQgFSpIhDatDeD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756610226; c=relaxed/simple;
	bh=uNoXH+wPgXdIb++tmK8Rpao0qcmHJzxf5uW0DbXtepM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as7luoJHacW1t2yM4ZPkacIsdI0tjsVfWPcD4rGTUhAn/QAdt8RXtZSt6efNKt2IZK4REpzZ8rxNqlZ2GpMUUt/dOOVytwU7TtJqnf8zIe3sROR9Lesv8jkD742j5R5ZzNYAalH3u+wSQyOWpiuCv6yB2SdpY3rrw16j39Pwax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/Hrn0CL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b307179ea4so22650601cf.2;
        Sat, 30 Aug 2025 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756610223; x=1757215023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N7BdKrpgIpY9aSYUioHU5026fLiwEEjedpqQJ1T/KU=;
        b=R/Hrn0CLj8QXkAuvARc1cdvg6PbcQ3g6lg5KsBtsY1cJzG8CLJj0V73hFhSl0sT3KG
         l59tE/Sb7X1iDgQeh4FMj7uywI0NgBc0dcORtkDH4VB158o4mEK656171RIxHVPkvdoa
         rwfIyfow0eZOsjy7AskLjftG+a2dZwTlseS7zE83m7jaymXXahOzdDxFn24CQucLhGb+
         xAyC5w1hUG8wLkUAvJPhC+EBYfROdF/ZF/zfc8mHHSkcy5HgIvU3JgEpo8VCqPksRWWo
         xRsTxQc4X8P5fDLaXTnCuurXJLsPb+auQuxtpyaoEAR8x8bS9JCYToV4AmvJAmi3xSaX
         6uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756610223; x=1757215023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N7BdKrpgIpY9aSYUioHU5026fLiwEEjedpqQJ1T/KU=;
        b=w4mmv7Z5bYAibrwcIusMIuDBFQ3aI/pLew5eQn3zTfY7rBJ1ekCtIggFbvxZ3RffBa
         PL7p2bisdUirX84GxDUCboPVJnJn5b+f4MNWEbCAzIxpUm4RvhLEx/6kezq94IAqmidq
         2kd/8+8neiObGDi5IxVDb7m6tZAcD2jgW61Qhh4CorbQy5CYV49koRPfmK+/oh2GGApK
         /zEY02ns88ZaxEkvMUd3GNWk5FFu+dnxrdGxuNs4ao291Yo5V7a0prwr/kQN7dsTVfTk
         iPlw0Ddn3jJX2TblYkNezPVmEFOipgKgKDOsm8kXNefUi65T+tuyHumwwj9WYpdp621a
         3IKA==
X-Forwarded-Encrypted: i=1; AJvYcCUsdg7M5KTDx6Ld0+AqGrobLn+tNJ8UcoyH8Yj4BmX/ghy2+WlGWH19+1H/of18UIe7jvE=@vger.kernel.org, AJvYcCVMpkiRHw18zPuMwMvAO0HZtFT1w5kpah/NhmD/kSvSDDlf2Am1zoEydrbUTESmTrALFe/hT49m2/5y@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPpkYh3G8Yszzx6/7veSOZXSOBNnf+ArDpojmZnY0xf6gEHBn
	njxjt6Fvn79Dbquq6gzQTuyaW/r83gMZu3Z51OnGYYAHfL8bvI9oWQtgupNvoykPppskZYJkcJB
	SL0c3WPhYbOu5lhH7e1pkhvCRo3yt4PI=
X-Gm-Gg: ASbGncvXq/NH9Iubb/XZW3tHDtlHVcdVYzaLI3HtjfLovfahvuLzN1LbxxutqrgIhvS
	nfUKQ5z7V/VehGwlekFDyrv7jS4inJPWrfKN/+CucSFwd8QJaV46MC0TlZ6SqHcaklFP4qG7FVa
	uZAl+gaWwOZi9AVCNOBh2Shv7ch11iqqe70FNsjOVBaaWCGmBsTZRL53ShE4zQcT0TBf/psyWfh
	H3eSW64dSzd+HS1Rx4BzVUKPEF1GNnbuizVCPmm
X-Google-Smtp-Source: AGHT+IHe94eMIWMY4dbrxy1YiHjHy0HuBEp+5ADPw2mSy4ygzqofX4QZ6gFssRpbt5INRd/s9w0eUBJOOA9RRs/hVCY=
X-Received: by 2002:a05:622a:592:b0:4b2:9830:197 with SMTP id
 d75a77b69052e-4b31da3cdadmr39861351cf.48.1756610223300; Sat, 30 Aug 2025
 20:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-5-laoar.shao@gmail.com>
 <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local> <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
 <b335afe9-be7a-46bb-bf92-37abf806d164@lucifer.local> <CALOAHbApv0Sj25La7EQZg7UBxfvkfMXpGPtNrYKABSYpNV6ORA@mail.gmail.com>
 <a4d0857f-1520-49a2-a717-3e74325f2d6f@lucifer.local>
In-Reply-To: <a4d0857f-1520-49a2-a717-3e74325f2d6f@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 31 Aug 2025 11:16:27 +0800
X-Gm-Features: Ac12FXzUXlC_rm_aYklaAinmwNAfHTa64DZQJN2Q1d5F2Z14aWeMQl-5B-4ZRZM
Message-ID: <CALOAHbBaC2sd578CCT_15R64P75MAtYopm+pDrRqmOJpaOB-Dg@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 6:49=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 29, 2025 at 11:05:01AM +0800, Yafang Shao wrote:
> > On Thu, Aug 28, 2025 at 7:11=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Thu, Aug 28, 2025 at 02:12:12PM +0800, Yafang Shao wrote:
> > > > On Wed, Aug 27, 2025 at 11:46=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> > > > > > Every VMA must have an associated mm_struct, and it is safe to =
access
> > > > >
> > > > > Err this isn't true? Pretty sure special VMAs don't have that set=
.
> > > >
> > > > I=E2=80=99m not aware of any VMA that doesn=E2=80=99t belong to an =
mm_struct. If there
> > > > is such a case, it would be helpful if you could point it out. In a=
ny
> > > > case, I=E2=80=99ll remove the VMA-related code in the next version =
since it=E2=80=99s
> > > > unnecessary.
> > >
> > > If you lok at get_vma_name() in fs/proc/task_mmu.c you'll see:
> > >
> > >         if (!vma->vm_mm) {
> > >                 *name =3D "[vdso]";
> > >                 return;
> > >         }
> > >
> > > So a VDSO will have this condition.
> > >
> > > I did a quick drgn()/printk() test and didn't see any, but maybe my s=
ystem - but
> > > in any case this appears to be a valid situation that can arise, pres=
umably
> > > because it's a VMA somehow shared with multiple mm's or something tru=
ly god
> > > awful like that :)
> >
> > Thanks for clarifying that.
>
> No problem! These weird edge cases are... weird and hugely confusing. I s=
hould
> document some of this somewhere, as it's at the moment more 'oh yeah I
> remember...' then having to dig through to figure it out.
>
> The "/dev/zero file-backed but actually anon if MAP_PRIVATE'd" is another=
 fun
> unique case.

It would be immensely helpful if you could document these cases. We
truly appreciate your contribution and the time you've invested in
this.

--=20
Regards
Yafang

