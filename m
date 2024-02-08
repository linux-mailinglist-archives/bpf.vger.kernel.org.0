Return-Path: <bpf+bounces-21473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891C684D99A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A71C22B3F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 05:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FA67C56;
	Thu,  8 Feb 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nQaEFQv2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739867C4D
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707371082; cv=none; b=LTXf0RCeJj0h32Ou06Yu+GCXmnLxnp5FHdupWMAiwUnd/wIgPpHoIjUHpW2Sqc04IdlfSnTiR9FdCW9byRkBmaHIW5TEPeYZ7TuxyblC7ApZ/tqX28J8kQM8tmwnLDu4T9Vj+tbEKJFPcTKppxPUCNJMARku0vOVdQD8smtS5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707371082; c=relaxed/simple;
	bh=KVrc69p/tbKGLVRPpSKWXhSawLAxShLipsPAo5K6RjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5ZbqpMp2QfwMF3eYnWoaIkGmcspHyrp4LZvotikilpi8XmP4nLzW/t4sXsTOHnB83EdihV1cLBnH0zZyljLwlJp8EhwLnBANObRCr9/zrOx26NPxrf9kBKN7ups7Yyux+N8YXx82ppJkLbp4fV3hTfBTWg95hxMFQYJBLco+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nQaEFQv2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511689cc22aso2208899e87.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 21:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707371077; x=1707975877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4k5aIiBFyHrBPof33aIf/8qoqBN1gTRvAwPh7UCjnCg=;
        b=nQaEFQv2WV51bwNQRQsksnrzz61OdD+N2E5R4E1EgwomhAwQYGrSuvnrLgawzO1waa
         bMD0e5MVNG3p0t0FyXJawpiC7SulWfSnCxA6v6rIEmxAdF5ixqq3qm6qqYj/sFfLBPB6
         3M84iGzKMRKNsmS5kmJ+5aOpUX7/KOjiOlVj01XlUPRlnZoFCS0QGrM0I3de3zc5nZN3
         Tcvv/cAT8tMQS7ZJa6cCRQWhrBxUxrXUOiBspEmGeRfmXaC1z3YWODwcejsfR2HcnNi3
         UPWcDT4oxaqqjpZfJw7FKA8cMZ87kIgnqJXd9OEHtsl40Rc70ruHX5MYv7ZuXK297dsu
         +sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707371077; x=1707975877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k5aIiBFyHrBPof33aIf/8qoqBN1gTRvAwPh7UCjnCg=;
        b=iTgsbdHt2Pk420rzawqpCzLBBm2gzvZucF+RlwJAINuTXpfJW0CeKO7rlQlFA9RuhY
         T+CmRAIplpRoJc+O+Tq0wD6Q7uPR0qYa7fNF0uReyzVQpoOIUxWlY+kHt/+GBSOnlB9F
         d9Ync0ornUWzPFdp95whrLBSUZNE3HPjelM3pawzk55/nK6hcBfcyF9ZXns/sqMFvPGV
         agVDm7pg0uAUFq0rDkQYGkppNxOMAks7ON8WOOb3MtcU+gPTBnUQMKMTfsYmElL8YDX7
         mriSiCb2q+CRskle/qRbHiV6n2DVWJCkK2j+rUr+ri5QH3TmaPAxRDINEZVXd0NDhvlA
         55Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVqLjccYXjjQ4udgpZS72UGxslIWZKDiMZ25/HHlJt+dBjnhoBakeu3aYWys8/uoqDowLa86hSULbeC2+H9JXHhJ2dl
X-Gm-Message-State: AOJu0Yyl1cN4Y/V5LmNb9NPDzbJFYrSjPE28PbUROQYy6mYymc1TAnrX
	2WNU0x3XYJcjv6Eq3o1gAMopikQj0jwRyKorSm/FagC3Kv6NpGTKLfZHcds7aPI=
X-Google-Smtp-Source: AGHT+IFS2uj00zf2FxyqyPWXdruzVYLAIwL3C99onCgm9MTyehEEQY8iYHo3sbOtEtPVzM7SmEC18w==
X-Received: by 2002:a05:6512:2152:b0:511:483b:91c6 with SMTP id s18-20020a056512215200b00511483b91c6mr4182647lfr.48.1707371076948;
        Wed, 07 Feb 2024 21:44:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpO5yA8IC7DYUDkcvBtDTQugbGscQu7lWVQTd1d2qonozAMGxZcENduPCPp3TU1Cs259qOkgkK//EGXMc6mhif8V8xcto660JD2NCrqhLur96SLyLpFAkGHn5b7QcqrAe98VJ2UJk1twb6Q9f05YVoti76zQAmQhqsv8xHGGW4ptqYsQGJVb1ySVh36X8gc/rtaZ3b9FffUZFOFvi6fAZ86PC6kRvUUa0knJ1latZHW1S8PAuSBQX3c0h3Axk2+3wLP9znaIKaSGLdGx2lv368TbzzJ1iIBuO1SgY6rMOAqdZCjWZD3bzavi14YUwK9d5yfsWTpZ59tOfDFOeHII9jt2N9fdeKZakGy40vUPw06TkMg59uKbQ/tl5aWbntt28pKjYSeFtM3deIQ1ZcFNJU
Received: from localhost ([2a02:8071:6401:180:f8f5:527f:9670:eba8])
        by smtp.gmail.com with ESMTPSA id bf14-20020a170907098e00b00a382d8a32a0sm1548177ejc.18.2024.02.07.21.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 21:44:36 -0800 (PST)
Date: Thu, 8 Feb 2024 06:44:35 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com,
	linux-mm@kvack.org, kernel-team@fb.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest
 of the kernel.
Message-ID: <20240208054435.GD185687@cmpxchg.org>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-4-alexei.starovoitov@gmail.com>
 <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>

On Wed, Feb 07, 2024 at 09:07:51PM +0000, Lorenzo Stoakes wrote:
> On Tue, Feb 06, 2024 at 02:04:28PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The next commit will introduce bpf_arena which is a sparsely populated shared
> > memory region between bpf program and user space process.
> > It will function similar to vmalloc()/vm_map_ram():
> > - get_vm_area()
> > - alloc_pages()
> > - vmap_pages_range()
> 
> This tells me absolutely nothing about why it is justified to expose this
> internal interface. You need to put more explanation here along the lines
> of 'we had no other means of achieving what we needed from vmalloc because
> X, Y, Z and are absolutely convinced it poses no risk of breaking anything'.

How about this:

---

BPF would like to use the vmap API to implement a lazily-populated
memory space which can be shared by multiple userspace threads.

The vmap API is generally public and has functions to request and
release areas of kernel address space, as well as functions to map
various types of backing memory into that space.

For example, there is the public ioremap_page_range(), which is used
to map device memory into addressable kernel space.

The new BPF code needs the functionality of vmap_pages_range() in
order to incrementally map privately managed arrays of pages into its
vmap area. Indeed this function used to be public, but became private
when usecases other than vmalloc happened to disappear.

Make it public again for the new external user.

---

> I mean I see a lot of checks in vmap() that aren't in vmap_pages_range()
> for instance. We good to expose that, not only for you but for any other
> core kernel users?

Those are applicable only to the higher-level vmap/vmalloc usecases:
controlling the implied call to get_vm_area; managing the area with
vfree(). They're not relevant for mapping privately-managed pages into
an existing vm area. It's the same pattern and layer of abstraction as
ioremap_pages_range(), which doesn't have any of those checks either.

