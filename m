Return-Path: <bpf+bounces-22601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5C8619BE
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7B01C23C52
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621813DBB8;
	Fri, 23 Feb 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nus8kRZn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB15A12E1F9
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709249; cv=none; b=nCHtnBJkCSVHkoxyMbq4XahO7nN15K6B9LMTWIUsfhs/CQ4YuHf8Lb1NKW72gw9pQZtTJcHguTpygICx/BHIKlbO17814yVHVCSQ+VXTOXnn6EYsYCiM8BjrCHL2HSLx0GpUIAx/Ga0CXFD0ax8FHARYPQsAdSrxIv5V/sp+F3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709249; c=relaxed/simple;
	bh=Dl6yfUkCSfkdEuh2+qZaXPGySbIipq3TXLLNHuJuhRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jurX4pogO4C+vt5S3JNj+Zv4XCk/jPpe9qnu0CHRAXwXrzuHnSAbwJlblKurQcKUk8WbheoIVl67Q+0H36B99jRs2PL5iAmPeEBBh9neVNaYvvrULmHE3F/JwTTMKRjNYtHcComex6jAOZprtGNgg4/ns1jJmE8GKMS16EFFqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nus8kRZn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412985a51ecso1284385e9.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 09:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708709246; x=1709314046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vNuyNXu25mKmmUjoA0sFm1bo+r/+O1xP9DbW8b+d/Q=;
        b=Nus8kRZnvpfcysGiZJUIbQEVqVlAkjGSYpNTCjdgPl1+gKb4FLaHmqkoqwvI4Yibdl
         wQAhWWwwZlTx/cAN6PSlkMpIV61gyt6cQk4NdmxYl8dtt3Jy7FYPP2gl+e70JjsSjMm6
         2BCbpC1C1i8pRjei2XIWgSFIdTuhlpro5ImCZCUMuPe/EPAYafQG/K2fhgl7qOoh2+IU
         iwdZ4uEz9Up8TDZzOoC1pYGosvh1yPi1WAQzPE3gFNES09ahWkMt3vrZUIYjQzhEliS4
         /U+72n6uOgogvfvDVkdK5ZMIfrzL/+mZ/8W3VcE1lV2vxZRl0XXqe6DyN2z3EZ2EbHrR
         pxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709246; x=1709314046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vNuyNXu25mKmmUjoA0sFm1bo+r/+O1xP9DbW8b+d/Q=;
        b=GqrVv8WHvOyV10b4VYUyoLwMTCVwgtgvI/zcevOmZVP8NxLqZpk+rPYzQTCwYMoMLV
         153zkgjvSgAR+IiW7IfUu9q7Qqr2dTCD3A5p/w/u2dIu9w+HCvrSKgKElAj6r+chn8ar
         R8BIb+4RRrpLUkexc5uggOdLoji0O9F/Qrv3rY5XPtshUHULFm9pk1PTD5CUKOvfjT6k
         pYyihFFnkYLV+5j5Hbo1xmxpD/fsg1RrHbyGvGJgKgHxUYFGCU4k9ZGGWdrhYTYh/aI7
         Xg+0h3mmi+lk24CsK3/jFtqD5NGRfjfi0hPQgb2xH5pmJo8iwuDdQO1tk1qPBl8pKHM7
         m/cA==
X-Gm-Message-State: AOJu0Yw8AsaXfl7owiJ9cCJ/WcXln9ZCiDCqsnxsmWwW9D1A4ms5MOSj
	oEFkVHuwYLluSSJ2r6lytiSN8iIolMJJPG5wC+EQ/2OZWQexS1qvnRSBiV2l/CCEqYfv3BNMnd3
	5P5Ld+X7/WmdHawdKqkxkouLgYYk=
X-Google-Smtp-Source: AGHT+IEVoZv7qmp/PLS60Kz0jBWXjbAJ6R1pwCFv983Q/7a2+W0nLQGWUpODt3JAXnigML7dlri8VPUxn6n9aYmgAa0=
X-Received: by 2002:a05:6000:1b8b:b0:33d:8783:1e0e with SMTP id
 r11-20020a0560001b8b00b0033d87831e0emr232244wru.70.1708709245786; Fri, 23 Feb
 2024 09:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220192613.8840-1-alexei.starovoitov@gmail.com>
 <ZdWPjmwi8D0n01HP@infradead.org> <CAADnVQLrUpJizoVeYjFwSEPg1Eo=ACR-Gf5LWhD=c-KnnOTKuA@mail.gmail.com>
 <ZdjSfSBu2yO1Z8Tq@infradead.org>
In-Reply-To: <ZdjSfSBu2yO1Z8Tq@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Feb 2024 09:27:14 -0800
Message-ID: <CAADnVQKpcGO1yAACnX8YPW6RKooP6nFJa5nDs6FECqLNamcm9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] mm: Introduce vm_area_[un]map_pages().
To: Christoph Hellwig <hch@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:14=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Feb 21, 2024 at 11:05:09AM -0800, Alexei Starovoitov wrote:
> > +#define VM_BPF                 0x00000800      /* bpf_arena pages */
> >
> > +static inline struct vm_struct *get_bpf_vm_area(unsigned long size)
> > +{
> > +       return get_vm_area(size, VM_BPF);
> > +}
> >
> > and enforce that flag in vm_area_[un]map_pages() ?
> >
> > vmallocinfo can display it or skip it.
> > Things like find_vm_area() can do something different with such an area
> > (if that was the concern).
>
> Well, a growing allocation is a generally useful feature.  I'd
> rather not limit it to bpf if we can.

sure. See VM_SPARSE proposal in the other email.

> > > For the dynamically growing part do you need a special allocator or
> > > can we just go straight to the page allocator and implement this
> > > in common code?
> >
> > It's a bit special allocator that is using maple tree to manage
> > range within 4G region and
> > alloc_pages_node(GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT)
> > to grab pages.
> > With extra dance:
> >         memcg =3D bpf_map_get_memcg(map);
> >         old_memcg =3D set_active_memcg(memcg);
> > to make sure memcg accounting is done the common way for all bpf maps.
>
> Ok, so it's not just a growing allocation but actually sparse and
> all over the place?  That doesn't really make it easier to come
> up with a good enough interface.

yep.

> How do you decide what gets placed
> where?

See proposal in the other email in this thread.
tldr: it's a user space mmap() like interface.
either give me N pages at any addr or
give me N pages at this addr if this range is still free.

> > struct vm_struct *area =3D get_sparse_vm_area(size);
> > vm_area_alloc_pages(struct vm_struct *area, ulong addr, int page_cnt,
> > int numa_id);
> >
> > and vm_area_alloc_pages() will allocate pages and vmap_pages_range()
> > them while all code in mm/vmalloc.c ?
>
> My vague hope was that we could just start out with an area and
> grow it.  But it sounds like you need something much more complex
> that that.

yes. With bpf specific tricks due to lower 32-bit wrap around.

> But yes, a more specific API is probably a better idea.  And maybe
> the cookie should be a VM area either but a structure dedicated to
> this.

Right. see 'struct sparse_vm_area' proposal in the other email.

