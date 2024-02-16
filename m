Return-Path: <bpf+bounces-22120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0151857379
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E524C281C83
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B654DDAD;
	Fri, 16 Feb 2024 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTxjIyNi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7CD2EE
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047270; cv=none; b=nKGwuvae5BjrovnqIOvLyFHvGIfKuWsKvQEyAYCeMp7QoBwDc7H67rWADdwjISTxiCQFi/xhiQVjsXnA2zF2xZr1Vs5nTDav/jsZxBEb7T45jEnZbUkp2R86QSPVq9ClJZcODv3xplFNnPwtMqCGHhG7sWTc0gEYZOfNzLildeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047270; c=relaxed/simple;
	bh=hHBnTwS/madWzpJT8F6K0IhIJbkW1QgzlT6vLmulCCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9EF9mqRFbisaSQT9/0RT6wfz3usDh3yi7SlIf0czoEzZaJV1oIfHCfgmSMVp7PmmQQ5bSSKU2PkqiPe+OAHZf19E1nROiwisg58z9H1ekoRrkKiLQDrwdRtYFulhWsFuPC3jZgX2K//MfFXNhNlMHD20ej+WtapvFssS3FwK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTxjIyNi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-410e820a4feso14680645e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 17:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708047267; x=1708652067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v11hDBMoJ35S/9vJCehJMvG0Fni/QxtjIEuJ20WEdbI=;
        b=nTxjIyNiyxs2rl4REL/W23u6XS1dbt4ac8cUZOcDXIk9i34Mm+Ufmd/5gnTf+QZE9Q
         yfdJx2NHpormpB2LhgdRIThFaao4WBehprK9VQOQJ5BuCuARtvA7rkgh3NK6MHIqH9vK
         nm1A8hfDTC/YoKapolkOrX/jM+8OVVI/WO/q00h3QQ44RwrcjMzDSzjPkShSE9xt7Etl
         LHJmfHu28UDvMCbsy6xDvFMfOaiboewjU2c2103TpqafU1QcT2m5m6oDIoyfLj5sTcGe
         umFd1kNhS/kDTJ0pBBEAq8peQh2BssAJp69VPWc9NDDoP/IBEXv6bSwyqXex6bq19ct8
         9WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708047267; x=1708652067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v11hDBMoJ35S/9vJCehJMvG0Fni/QxtjIEuJ20WEdbI=;
        b=lSERLmOaGsXE/luxjvMl6xR+IEPAQJ6h10B9Sj7khCluJtVGXET2fsX0Rz92cVZMfd
         Q0TzNUPgieVyWiWxkBzdahtsa689KdtiCr4Lj+eWLcS/T63nJUWxsK5RKGLiySCtVwlm
         gB9nYUP/NbLgD6esA7PdzRHA+zL4bdZNJMkqwSSxs4XvER49vRFW9SWAzOebcGknTix/
         QSESODYdwC8xFCkjQLDbPd/deQpFviEkTwA1SLwHuTJ7mWgI3vHXprvGBPzRve7v9QHB
         msTUngW24VsxVDvTi7c7KjGw6C9gPay68a9tf/GeaN1re4iKr/0CR+rAddfk9AG2cu88
         TKfg==
X-Forwarded-Encrypted: i=1; AJvYcCVLfNbTUGTzXG18mSeF6LSzd8T5I6jOsgg2KSOHiUu6nXcIoV3xG1d+CYHFtEF+4xot/GRHMy4c2fbaKH/CKjpjsMQC
X-Gm-Message-State: AOJu0YzcDZueYz9m+L4ToS8ePGMTrbLgeRbaz0zv8sqVBCbFM4EHMPvU
	vFW07YZtffjA3MolPF3lgoG04VNldUcggEGCyqCM1cgIG41I18On/E3lEMz/fJziunb3KNG+0Q9
	kOt1MHZQeeVSudJn6Lftem3vEU3A=
X-Google-Smtp-Source: AGHT+IHmsNbfRcds+7XrS4r4mxcIEyITV/r5kZwwlMsctd08MdOnruyCs49crdhmLOvPloCNdn8/QgRiRgziy1p9si0=
X-Received: by 2002:a05:600c:444f:b0:411:fd40:4296 with SMTP id
 v15-20020a05600c444f00b00411fd404296mr5015651wmn.5.1708047266900; Thu, 15 Feb
 2024 17:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com> <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org> <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
In-Reply-To: <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Feb 2024 17:34:15 -0800
Message-ID: <CAADnVQ+8Ag1tKaAFgrXoyRFxcsWWNGthc0kUv7sxYBJgPK6kqg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 12:50=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> >
> > So propose an API that does that instead of exposing random low-level
> > details.
>
> The generic_ioremap_prot() and vmap() APIs make sense for the cases
> when phys memory exists with known size. It needs to vmap-ed and
> not touched after.
> bpf_arena use case is similar to kasan which
> reserves a giant virtual memory region, and then
> does apply_to_page_range() to populate certain pte-s with pages in that r=
egion,
> and later apply_to_existing_page_range() to free pages in kasan's region.
>
> bpf_arena is very similar, except it currently calls get_vm_area()
> to get a 4Gb+guard_pages region, and then vmap_pages_range() to
> populate a page in it, and vunmap_range() to remove a page.
>
> These existing api-s work, so not sure what you're requesting.
> I can guess many different things, but pls clarify to reduce
> this back and forth.
> Are you worried about range checking? That vmap_pages_range()
> can accidently hit an unintended range?

guessing... like this ?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..3bc67b526272 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -635,6 +635,18 @@ static int vmap_pages_range(unsigned long addr,
unsigned long end,
        return err;
 }

+
+int vm_area_map_pages(struct vm_struct *area, unsigned long addr,
unsigned int count,
+                     struct page **pages)
+{
+       unsigned long size =3D ((unsigned long)count) * PAGE_SIZE;
+       unsigned long end =3D addr + size;
+
+       if (addr < (unsigned long)area->addr || (void *)end >
area->addr + area->size)
+               return -EINVAL;
+       return vmap_pages_range(addr, end, PAGE_KERNEL, pages, PAGE_SHIFT);
+}

in addition.. can conditionally silence WARN_ON-s in vmap_pages_pte_range()=
,
but imo overkill.
What did you have in mind?

