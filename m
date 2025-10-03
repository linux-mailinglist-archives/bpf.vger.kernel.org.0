Return-Path: <bpf+bounces-70270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F927BB5CB7
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 04:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B625F484A7C
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 02:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB732D373E;
	Fri,  3 Oct 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWJFN79A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971092D2490
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759457932; cv=none; b=aMoWQfiNSWvKA8IhSJIpK5Uz4FxNDlEdJphUxQwxBqPbEmMmNtd4xJoPKk1+XyS958UITnj4SMzOZ6Wm5doaRroV+aXjG0DjfvmpNM4H3a/rknj/2/AMJmSLScFajmPwOHZO+8BcNpvUmzRmOhHeGIgmahvI6sMyLS+RFkbubN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759457932; c=relaxed/simple;
	bh=YwdIWqYwyVfdeCv+Niz43GiSsR+lHbtXSQFoDV7XnBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9Ck+PLQdJGhQXcJhS3vTo6CTvp1CsabCa6YxIcrOY9NjPFoVOhZ9/pnjXM59DUnnrBnl1Qg0KXXJ560llx3gfNGpX2CFDxVyC3438oMW49ZZDSmRd/JF4CxHUoQkMGpqLui02vNkcyaAx1lqr/JhUbeAYanMoQSiEkWou6GuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWJFN79A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so13340835e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 19:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759457925; x=1760062725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e/i8EbjlbnXxewfi6hJm/z/4ZP0XZNKcXcN/4b871g=;
        b=NWJFN79AMeM6DsxRpE+O8M9CNrXkzLxdWrjMG0Egzg9gl0DLd7BTgCOL7DJvW/eFKr
         ynTbLkw8RiRsDqT5ZzMyLVc1J2brv7fN8+K6IY6Dn/HOXEBYK2cnov0x14XBr8ajHEBt
         o54URJ1Nv0Q2E9uyLJAufdKy9hhkvhWZRXSQi2W03EVSCYi+bllDjSSMJyM2fKtdNo0R
         9F5ZtXuKgRZtMgfZh+v6radU+Hy6G3lKxQUySu5t0Zm982uwLT4EUZ+BRmY7pQ/8MX+X
         mcvZErUc5wlDXsSYZMBwVi8Ps+PibM16WWzX+k/Uxnv0FoehMD3fgOxlWm+Kq/AQvMHC
         sPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759457925; x=1760062725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e/i8EbjlbnXxewfi6hJm/z/4ZP0XZNKcXcN/4b871g=;
        b=qRUzx0J5WWgYWmC+Se1pDaO6Wv3W8t7OYKpeY1EEYdltmfAbOYlYDgn929EpNVkoiz
         8UplhHakUyEJXE/3CjxY6P8a5p/C1OQeeXoRgtp5AwSJgJDlJYCth/f2JxPw8FRFd6sd
         ugi0IEwF/MRVYYqN50kFBGdiBDUiigpd8oU2jOLuinc7AWkE2mIx+cLUvbnyRyxQAEbt
         xoRnP9FuzihNgXYIGGNQjLKiC1qskwdkW2hThDwOG4AEVGkQSbMCSsAtcVydSO/gHRlz
         S38XluhADV1EyR3y47QWCyp7IcXlP2wUDTjrrNDYlqcGrvqfkb78EySAf9IK77Q2PrAu
         Mzjw==
X-Forwarded-Encrypted: i=1; AJvYcCWPgoM28+7XbFj3Q5ch9U05XYfDdNINa8qWP5rnROeWNUe4w/DGBcKnA7gXSym8cS4F6aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGcJbRhyL3wh6ZHgaBPsngl+AmfD5Ist13rrfrKtwx81zQJYP
	bapz6Hgwj5EICSAXsTpSGyQ43JuE3y35oo/Gun/XduezAaalvJyjx2oW4cqBnijo9M4qp3M/GRj
	FMqvrn3IkG8n2vLVnqUXR7AKgBKa9L/8=
X-Gm-Gg: ASbGncsd4eFmkc9dtFw4gEWYtof/VR9jmtRl9F6qYYaYFSQOFPsCI3UlsFEBrZ5aC8L
	YDRQMDwoyoBRz6wbQbW0TJ3l6MKqmv9yf8kB073mfMkivdXq0ux/t6Ap70bwih4jECA7WWAxs9C
	H+4rFl9j9vc2YxdkPo3xQelC2jXdgYO5+Csz3OX9kH0uNfZxUktBlV8cLqel3bveqMrQIP/zmz0
	GLZDjtTgZSPFl1qnbAwurIXMwbZrA0GGZ+vmSUSHd9m6s6NyTxJKogiL8EM
X-Google-Smtp-Source: AGHT+IEUdi5h2t7CXTLul7ivkETFz4Fjf+lqMHwgof5CobhAX/VcEKSKvJeht/4smjkDa2Hgzo4fwK0xXe88/EAzHP8=
X-Received: by 2002:a05:600c:8b65:b0:46e:2861:9eb2 with SMTP id
 5b1f17b1804b1-46e711002e7mr8372685e9.8.1759457924865; Thu, 02 Oct 2025
 19:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
In-Reply-To: <20250930055826.9810-4-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 19:18:33 -0700
X-Gm-Features: AS18NWB-xO-pJI19YtwvzZWDSOLQVewqObSZM817yMkm5nTGr0yasX6RQmgofXI
Message-ID: <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> +                                     enum tva_type type,
> +                                     unsigned long orders)
> +{
> +       thp_order_fn_t *bpf_hook_thp_get_order;
> +       int bpf_order;
> +
> +       /* No BPF program is attached */
> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +                     &transparent_hugepage_flags))
> +               return orders;
> +
> +       rcu_read_lock();
> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_order)=
;
> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> +               goto out;
> +
> +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> +       orders &=3D BIT(bpf_order);
> +
> +out:
> +       rcu_read_unlock();
> +       return orders;
> +}

I thought I explained it earlier.
Nack to a single global prog approach.

The logic must accommodate multiple programs per-container
or any other way from the beginning.
If cgroup based scoping doesn't fit use per process tree scoping.

