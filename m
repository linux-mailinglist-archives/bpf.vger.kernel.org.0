Return-Path: <bpf+bounces-69914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9FBA665F
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA03B97C5
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D73266A7;
	Sun, 28 Sep 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIoxK1wJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE61373
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759026972; cv=none; b=NMgJkWVNChyde4d9J17W3Nh1K+kxHZFO9lcZ9+qnCxpdE1w2xPCF/XzkiajgYCJg3QXArKoqSHAwrZrbANUr3cf77dyfVsed0y/THFcQbsi19+pH1Tagj0OgwY9p2mhtgcolgcUv+ObZlGjfd6jDgYIbP86tzUdT7l6Q3+YgYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759026972; c=relaxed/simple;
	bh=4Fv1wYXHyeXTflKUE70KCKGjjd7Db6HeOyzZQXwDdfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7dXmsLtonmeXySddgc1tUhV7bkmAU4TdDxbFSNLQn4YiHY9ckvfz/jxx46IVS3AG80JmE6WX09Erfg9dDWyFETZLzLIOhK77ZAj6gxbpa5/lbR/lWgoBYrpmqCpHz6HKr8FqotscragmgsxQNfeYvTm82u5cIs4pE3S5T3C61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIoxK1wJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8599c274188so350655785a.1
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759026970; x=1759631770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gaDCzK/mppvE+TbZ3WPtXIvdSdoczZCrzHaCPLwFrU=;
        b=gIoxK1wJhedRgw3h6p6oMv6y8LgAS8F/yK77fdRPWum+mC51T8pKObNaDcEl6AFR4d
         TfKqSpJO+gvS5UaHqVa31CQPi0zGNsZCZeBLxvOpfgfoaaGISJzodrzONr43EbOMmVdp
         5mvdHtQ+X4PJOmo2O9WSwP4XKV3TTsPhY1UIuYMce7/NmWcAJYlI9dOC3zZg5tc3TgMf
         y1TnsMbPkyAFrcatK+LYtRrrBvVosVnKIkVv1niSbSUO3Jbqbg2IfzdPDFrbqS4aCg5L
         kAdJ/VDGKuq12Ul+NFKTiH7+wNW+boserU+Rdel3zgw2Ht/GGpZ30GCosycmYkFIznw0
         kdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759026970; x=1759631770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gaDCzK/mppvE+TbZ3WPtXIvdSdoczZCrzHaCPLwFrU=;
        b=oShv401bc9K2eWIKErjVjSvX9HCYvFMX+Vzb9JVzjIktG/oli/dHCO0EfBrrxhU2vY
         E+EL/gTPXr87HPknMa93RoDc90G6k+dos/CMDipcxouQW8dqtFF/2O3d8Lh0QeaoDUra
         wFuzRgQi8EwNjWAXcZ7Tkx/c6/dr4UEoJ/Csd2ixaEHHqtspNp+ghtq7+yzzLf3mqEEe
         /Bf8Nl26ZrcvOxwdRxSZ7uIzorwexZEQ4XC2N906O0jSe5sVtyZEPFKi7JXPoZSOoka+
         +vLqBhkvCqCzQ3By5Ga0QsmvP2yOJVneFc5ZIAUevrdzqKU1ULWdTkb8knMgyxTmumNq
         s+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVQtX4e+Vn/QXzT7NncMO3Z1ww3GiYi0r3rSqZWp4fdCc2cGyIS9dL+sxINUo+0kG2qt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnCMUZThwBEFd7yf4bNNX39tmoun2KpDsa+4uNVCfC0GaECUE
	lMpDydCEjU1+bzt6b30ZgTLQQinlhhOilhrWg8V0zremwggOBDkseqnbqTLgH7pSitCpRKPIBa0
	qMyYmCZBtk2+blEs7jefLozdfLutPHcc=
X-Gm-Gg: ASbGnctiAOnmonbHmFwBz+/SLFclOCAj5NqwYs7q9JDLF6Hg4BQaoLSaIhRLyOcNyEy
	sjMvBxphpx+w3GcEQXlMbZUI9RJ0ODryfscQ6qfTfgC51V1y2dpWOpP+Om+5KJDbeh50e2rdxc6
	/89aNxPEF/pNunbsrjdrSLNs0ISKFnUpGJ7kRTq/rM20D1bO71YAg2yblEIviOaqAs/rwnb0Z7f
	B70OBnFrRNrBkRBiKxNWPmzjcadyydbRQZFXy2fL7llLR37a5A=
X-Google-Smtp-Source: AGHT+IEzrIRNkapYZtuzG9WFj/jlawGAcqNjlZSzbgOX3dCv7E2T+yBJS3MoM5SUVq717wHU1xry8WXSW8zEZoWw0ng=
X-Received: by 2002:a05:6214:d09:b0:82d:f77f:28c3 with SMTP id
 6a1803df08f44-82df77f34ebmr78705576d6.30.1759026969739; Sat, 27 Sep 2025
 19:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093343.1000-1-laoar.shao@gmail.com> <20250926093343.1000-3-laoar.shao@gmail.com>
 <146b95bd-e0f0-4e6b-a9fa-5a8f11355268@gmail.com>
In-Reply-To: <146b95bd-e0f0-4e6b-a9fa-5a8f11355268@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Sep 2025 10:35:33 +0800
X-Gm-Features: AS18NWBmL8y2V1x6RK8Hi5Yh_Mzxczyqhv8V1kW5X07v9F-7y38eCcLmLbTOSok
Message-ID: <CALOAHbAGPZX+V4CBRyGhHtQ2mVFJWD4CUX+9Fujp-JAiK426Xg@mail.gmail.com>
Subject: Re: [PATCH v8 mm-new 02/12] mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:50=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 26/09/2025 10:33, Yafang Shao wrote:
> > The khugepaged_enter_vma() function requires handling in two specific
> > scenarios:
> > 1. New VMA creation
> >   When a new VMA is created, if vma->vm_mm is not present in
> >   khugepaged_mm_slot, it must be added. In this case,
> >   khugepaged_enter_vma() is called after vma->vm_flags have been set,
> >   allowing direct use of the VMA's flags.
> > 2. VMA flag modification
> >   When vma->vm_flags are modified (particularly when VM_HUGEPAGE is set=
),
> >   the system must recheck whether to add vma->vm_mm to khugepaged_mm_sl=
ot.
> >   Currently, khugepaged_enter_vma() is called before the flag update, s=
o
> >   the call must be relocated to occur after vma->vm_flags have been set=
.
> >
> > Additionally, khugepaged_enter_vma() is invoked in other contexts, such=
 as
> > during VMA merging. However, these calls are unnecessary because the
> > existing VMA already ensures that vma->vm_mm is registered in
> > khugepaged_mm_slot. While removing these redundant calls represents a
> > potential optimization, that change should be addressed separately.
> > Because VMA merging only occurs when the vm_flags of both VMAs are
> > identical (excluding special flags like VM_SOFTDIRTY), we can safely us=
e
> > target->vm_flags instead.
> >
>
> The patch looks good to me, but if we are sure that khugepaged_enter_vma
> is not needed in VMA merging case,

Calling khugepaged_enter_vma() is unnecessary during VMA merging
because it's already handled: for non-anonymous VMAs, it's called upon
creation, and for anonymous VMAs, it's handled at page fault.

> we should remove it in this patch itself.

I'd prefer to handle this cleanup separately. The goal is to keep the
THP changes minimal, even though I've already made significant
modifications ;-)

> If the reason we are removing what flags are being considered when callin=
g
> khugepaged_enter_vma in VMA merging case is because the calls are unneces=
sary,

Actually, the rationale is that the flags can be removed because:

 Because VMA merging only occurs when the vm_flags of both VMAs are
 identical (excluding special flags like VM_SOFTDIRTY), we can safely use
 target->vm_flags instead.

I will update the commit log to clarify this point.

> then we should just remove the calls and not modify them
> (if its safe and functionally correct :))


--=20
Regards
Yafang

