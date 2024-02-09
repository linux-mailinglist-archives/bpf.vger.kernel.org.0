Return-Path: <bpf+bounces-21605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F294184F046
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 07:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680BD1F24992
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995B651BA;
	Fri,  9 Feb 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB36Eg8+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574C657A8
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460746; cv=none; b=uzxA5CVzOHWIAY2oGNRTx6UoIyHofckSJtstF23illbYxX4gEX3YVr8RDVuJO/0sv+glvlH8tORLKDc4JspYLHfEwZ/8EmOv5lahYBAEdSQ9txUpZuIugSNi00Q4ES0X3XOnBpNpRRm6EJ+5TeLbsp7Bl7fzAjmk55SVkOXuW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460746; c=relaxed/simple;
	bh=gGbGyGc8JL/lSzURGkvPdcfI/7YMtQSBWkf15oXUQ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phWL8naZXj3Saf6l3JHRuGBe1dMWnqs55KzEaAmz6D+DGZXdXtNjFd43RZCEuHoAMaBvGMquH6xnalKJ0qbPZr6HETeoLDE1Mb8Y2U4O9e3TojjAIxKGWa4lqaXz6xydKcyCZH9viFCr5mazcFkPitoFZLve+GtspfkmTn5nIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB36Eg8+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41059577f26so5726155e9.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 22:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707460743; x=1708065543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGbGyGc8JL/lSzURGkvPdcfI/7YMtQSBWkf15oXUQ0I=;
        b=CB36Eg8+VMDGVECfUYmr8n3KNIXPD/9ePK2+ZpKoTILmeNWdujBqfEvxoeLzYVf2vn
         ofE9u/ihwoxoylNd1bxoy5n50Dd39B84Ci+ZxTSLTyEuS/3Xm32fRuh4BneaMOvMZJ/U
         PrjhSzvHQCeKtCMpLF/+cplseMzb4czOvh2ddabpXXQkhMLRa9VlNpGzWEcupBkER7q5
         /40XXZtqEBVd3QigtmrOS6QZUskTB+ZyRqp0iCNAs9t9dI18HY2hps9z57QJeB8eDc8c
         BqSfQhoNQwkd5cVd7fVF7vfaOA4pRiIhIwF+u4aXMgK64qMhVchSE/07fBWKC08BH0Hc
         SyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460743; x=1708065543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGbGyGc8JL/lSzURGkvPdcfI/7YMtQSBWkf15oXUQ0I=;
        b=NkvNMkwYaU/yhD6Xqn8Lzd7QFAE8+EWmOAoahHpjJInjWE5VhEra5P+Wkc0Olqgxxi
         PXVnd+MG6pl/PNjjp3rBpFDugiyocDdtOIoYZWU6ypBm2hJ9AJ49fhvI5AUQ7dSGWmAj
         aMfvbV4ztWlc+crcezw9gO5CXxC/pP4cXPPw4aArgXvDSs6JsVGxVpC+kbhdmq3kM67e
         4csmkJIqJ9cNkAqnKoHMvaUWmAHrpsyYKLE7O+CiReAdhtczeA2QScQAflbyYPfL5mFG
         +mncG/0b/LF7i2xWyzG/bAW/Z5lJZ9FM1wCf8Ry7xn5LDXJ+BSBJHbnnTVB5weRIYUEC
         KfrA==
X-Gm-Message-State: AOJu0Yy/yIA9Bf4dgZ9aRYtJNT1OUZNDgKuokxwHh9B2D18IkT5YHra9
	rkxyoZxvlqPJO2GuM9FhRojGcrSOmyF/Mvz8MTvYYPitObfq5DRK
X-Google-Smtp-Source: AGHT+IHH02HUeNDa5Mlgg4UD2e0pVLRle/mWIx2WZRQr8nbdARSwIX/yjti8IJ/t6bPc0/1HIETD1w==
X-Received: by 2002:a05:600c:4f43:b0:410:2223:553f with SMTP id m3-20020a05600c4f4300b004102223553fmr419588wmq.9.1707460742529;
        Thu, 08 Feb 2024 22:39:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6bfGDSuARvjOJTg7t5TaVK9hXO61Z12WojUwpMtDHtLOG/LZzIfDy/47TcDhZ9fi9Lb0kEzefCRPBucMoceegkMdsmkokMoQ46rT3sVeRIC52mNi9zBH+cGvDVccvSZNTKIY8mkrbtM1fi6w+qrpkV87h8nOsBJIa31w9tEYHtFgOnuEz+iZv2q8YpXgyhtb4Z/a2Hx1HkgzZ3HSxsGRa/dRUYQ9Awwp9YrrYWKBir+l8SrshacqSSlJo/GQ3tPAflbbIgqldjTfEYFJstU2h8tffc18L1RGjpUvYXZ/zghLM/8FbqNHYgxoVpKzDyvbdA0a0S6OEwdfnRbQD6cJ7QQAwSPoHEB4/he10sfmdjLfW5x0Hw7W7BdA1pSIHDPy2NzkhVNNZmwhkccpG+hLJ
Received: from localhost (host109-150-53-182.range109-150.btcentralplus.com. [109.150.53.182])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0040fb44a9288sm1538120wmq.48.2024.02.08.22.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:39:01 -0800 (PST)
Date: Fri, 9 Feb 2024 06:36:46 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com,
	linux-mm@kvack.org, kernel-team@fb.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest
 of the kernel.
Message-ID: <16158935-80fb-41d5-ba9b-4d5b9c4d22d7@lucifer.local>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-4-alexei.starovoitov@gmail.com>
 <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
 <20240208054435.GD185687@cmpxchg.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208054435.GD185687@cmpxchg.org>

On Thu, Feb 08, 2024 at 06:44:35AM +0100, Johannes Weiner wrote:
> On Wed, Feb 07, 2024 at 09:07:51PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Feb 06, 2024 at 02:04:28PM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > The next commit will introduce bpf_arena which is a sparsely populated shared
> > > memory region between bpf program and user space process.
> > > It will function similar to vmalloc()/vm_map_ram():
> > > - get_vm_area()
> > > - alloc_pages()
> > > - vmap_pages_range()
> >
> > This tells me absolutely nothing about why it is justified to expose this
> > internal interface. You need to put more explanation here along the lines
> > of 'we had no other means of achieving what we needed from vmalloc because
> > X, Y, Z and are absolutely convinced it poses no risk of breaking anything'.
>
> How about this:
>
> ---
>
> BPF would like to use the vmap API to implement a lazily-populated
> memory space which can be shared by multiple userspace threads.
>
> The vmap API is generally public and has functions to request and
> release areas of kernel address space, as well as functions to map
> various types of backing memory into that space.
>
> For example, there is the public ioremap_page_range(), which is used
> to map device memory into addressable kernel space.
>
> The new BPF code needs the functionality of vmap_pages_range() in
> order to incrementally map privately managed arrays of pages into its
> vmap area. Indeed this function used to be public, but became private
> when usecases other than vmalloc happened to disappear.
>
> Make it public again for the new external user.

Thanks yes this is much better!

>
> ---
>
> > I mean I see a lot of checks in vmap() that aren't in vmap_pages_range()
> > for instance. We good to expose that, not only for you but for any other
> > core kernel users?
>
> Those are applicable only to the higher-level vmap/vmalloc usecases:
> controlling the implied call to get_vm_area; managing the area with
> vfree(). They're not relevant for mapping privately-managed pages into
> an existing vm area. It's the same pattern and layer of abstraction as
> ioremap_pages_range(), which doesn't have any of those checks either.

OK that makes more sense re: comparison to ioremap_page_range(). My concern
arises from a couple things - firstly to avoid the exposure of an interface
that might be misinterpreted as acting as if it were a standard vmap() when
it instead skips a lot of checks (e.g. count > totalram_pages()).

Secondly my concern is that this side-steps metadata tracking the use of
the vmap range doesn't it? So there is nothing something coming along and
remapping some other vmalloc memory into that range later right?

It feels like exposing page table code that sits outside of the whole
vmalloc mechanism for other users.

On the other hand... since we already expose ioremap_page_range() and that
has the exact same issue I guess it's moot anyway?

