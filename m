Return-Path: <bpf+bounces-66927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1164B3B169
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB49EA02E2D
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E972264DB;
	Fri, 29 Aug 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7NB0q0r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370C22256F;
	Fri, 29 Aug 2025 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436740; cv=none; b=D9N7UMETUpLQzXIXXrgF4eXnX9WEwkZOC08LCHWFTguDZxZNNeKSoe6T3uZOTVcme3jHNOXhOvgFrIVBQTXX11FYuBCw98FrAbDbhCr5Dg7IXzJCZAIixOZOAXc4YPrgdXJDUbC/0qa9JObmpbzHTAZQzp9e53ceGvIdMnKFK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436740; c=relaxed/simple;
	bh=AIBuNQqIkGuV4P+bJp7hqxoHQqtC9eBLltRVRaguEk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sltFA1/HV2M7rQ2LAo7UgHqcxgdC/nSrX7pbwrbr4xhR72KrgTI2dYlDj+JR4KgvmrF8261Xdb+aAXM1T+0Ecmk8WacX/3t5botjiAwmd8ZJOM9X+Z5scM8+YUg7AXP35Oc0rx4iCCTyj1NapEuzJAWHQDHgwq9qjgaXYmz4Y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7NB0q0r; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70ba7aa13dcso14665786d6.3;
        Thu, 28 Aug 2025 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756436738; x=1757041538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm9UORu61ILt8i4V4EUJUDwciURTt9U7GCvX8oYPwcg=;
        b=P7NB0q0rcpOAk21iczbOO/vI/XaXKs9ujIyKl/BDMEn/htfpXv+O8LQosLEjHrGGnP
         YOLC/QK46NNHvKmaeYMU0E6E/thm6bhXIqtje/qE5Eh0H965ufxQvkUHENmNLHXA1rCj
         vzQ29wEmkP7+Ejzv1CBTP9Cyl8T7wOVICxXCSSkl+55TaSfbYhT4rSKOydBieVtnoy1E
         0IMEbjrquGksvCufVAGcCki7bTSPS3k8Qn+ArCaVVzGaQMIvP9CL/egV/Tvzu9GQH59D
         HOF8uy5LR+efgzXEwuegeht76eojbhhqKewDPjRUXT7DDoNhZ+HGgE0LKAGHLWTyde6n
         uvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436738; x=1757041538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm9UORu61ILt8i4V4EUJUDwciURTt9U7GCvX8oYPwcg=;
        b=ufs81PRrtjEjfoFdDeQgI2EfYaFwNPgyj+9wpiAObvZe8jvwaL671VnBRvsiBDrOMe
         lpQ3yPo+/9V+P3/NikoBh9Mte+FsLS+OfzRenOcO9I99pDGwKgFelE8yQyeCDPd3/X9X
         8F/ZcuM3Rf7KqQxu6olIogIA+3rBWivne1jXA8TMA7M6AOg9RRQEdHYJPacL3tO+vJw4
         lv4aBDV/rlPL5dfpxazMhg7tqN3HpWGtAUPoAaMNn88C8ygLmyaktkBN1MUrszSKAx1q
         hVEzgu0tlbbg5ox3+Rms9Uk44BXnaJlHA67nwl4KK38lnrpZSAiycLWUHwo63Pge6Tje
         XVfg==
X-Forwarded-Encrypted: i=1; AJvYcCWdbQD6gLShkP6BVw3T1iSfl2qsCCP1okQBCwJobxqm1O0yvJzrvgfwX9e/WsejcPHREIY=@vger.kernel.org, AJvYcCX+5lkg/QEfFtNfRSLjLBfYq6dz/Mxe/zhQ6518Qo6HjPYiZ66haiujIKDtJsO9UloOSG6yqXDPKe1M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvk4Poz0iky6GthV8VU+kEGktpSbHewWxQ47u/M8/MdAX0bOY/
	fSlQDqTh2BMAbkLuYYT+LUjAdAasGwpy+OolKMuUwTb0OdmdlfE+EErksJyF3szsnbjE5Gu/1rN
	2CAP7E+gTXduZBsy0ywOtPLswiP090Js=
X-Gm-Gg: ASbGncsLnzatC7Px10p2XMkmx0j3numGe98E5fHZYbH1SnLvR4dUcwY3pYI7hspOYu3
	Yrkh6JCBuOdoNYG9FVx11XJ4FLQZYiBaCLlwDgLpzwQxKfP/t3MVug2/2OKjJv5gOkG3vNN6nF5
	LI36Fz3FNYbIa+zSMl7y2Kytw0PTDVCY4U+t79tNAaWjPg4/9FaWYIqVe9uydxrxt32zSyo3MCq
	ZAhfo+X27nplcj0kXS+ZOWUfxHy7+11Mrxzd9Q=
X-Google-Smtp-Source: AGHT+IFXdA7LJArbjhB50zi9oIGtUBIHMcF+ph6Q/htUjjp/1ateQP201klw17fLGsGNyNz6MLeHTAPUSbdTC5BQtKg=
X-Received: by 2002:a05:6214:248c:b0:70d:cd1a:4a43 with SMTP id
 6a1803df08f44-70dcd1a4ad2mr152609386d6.46.1756436737975; Thu, 28 Aug 2025
 20:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-5-laoar.shao@gmail.com>
 <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local> <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
 <b335afe9-be7a-46bb-bf92-37abf806d164@lucifer.local>
In-Reply-To: <b335afe9-be7a-46bb-bf92-37abf806d164@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Aug 2025 11:05:01 +0800
X-Gm-Features: Ac12FXyRkVAu3IBFWqROm107KDRmxs-OaNCft6vWe5MQxiSekVcD1hUUDL-ITVU
Message-ID: <CALOAHbApv0Sj25La7EQZg7UBxfvkfMXpGPtNrYKABSYpNV6ORA@mail.gmail.com>
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

On Thu, Aug 28, 2025 at 7:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 28, 2025 at 02:12:12PM +0800, Yafang Shao wrote:
> > On Wed, Aug 27, 2025 at 11:46=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> > > > Every VMA must have an associated mm_struct, and it is safe to acce=
ss
> > >
> > > Err this isn't true? Pretty sure special VMAs don't have that set.
> >
> > I=E2=80=99m not aware of any VMA that doesn=E2=80=99t belong to an mm_s=
truct. If there
> > is such a case, it would be helpful if you could point it out. In any
> > case, I=E2=80=99ll remove the VMA-related code in the next version sinc=
e it=E2=80=99s
> > unnecessary.
>
> If you lok at get_vma_name() in fs/proc/task_mmu.c you'll see:
>
>         if (!vma->vm_mm) {
>                 *name =3D "[vdso]";
>                 return;
>         }
>
> So a VDSO will have this condition.
>
> I did a quick drgn()/printk() test and didn't see any, but maybe my syste=
m - but
> in any case this appears to be a valid situation that can arise, presumab=
ly
> because it's a VMA somehow shared with multiple mm's or something truly g=
od
> awful like that :)

Thanks for clarifying that.

--=20
Regards
Yafang

