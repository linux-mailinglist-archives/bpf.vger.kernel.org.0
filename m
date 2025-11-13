Return-Path: <bpf+bounces-74425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40121C590E6
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFF4256094A
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99C359F9D;
	Thu, 13 Nov 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tml3eyuq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FD287504
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052862; cv=none; b=l8vXJtfhbpXeoWYi/Fg/EA0Zv8hDwPoFxZgM9DBJzKqNJj47HXbSE6bOW7sBwa7zX63S+xcZVvJRrmsv+UeQ4cgwBTkKUPHUjIXixfpCoihLTf8aQOmAFI+XYXjJyDD29UPOKObF4fllkNxEwKtna0XdDl1Kq484P+/A7RJ4WuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052862; c=relaxed/simple;
	bh=XQKSNRiFdFgqas04TlGNKyX+jgREILg+oYD/Bn1ut4U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFlvkwd6m17feyKp7UBWi6SRm/pQsoLQLqbPer1R/nWgp6x4Ce5hkV1ay0DN3cB+8DL70+fHFsaHB//Oj6FL5DhLeBvSJCYzsHppIW9ZClYuEVudASNv2zN0BRgLq6sibeUIZ7mhkrFM7wZ3oxy2L4XMDBXhvYEQhJAksCsA+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tml3eyuq; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37b996f6b28so10034931fa.3
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052859; x=1763657659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etMtDfwD+3QZuYUqVZKqjI6mrl2ackYWEvqoK5GuUAQ=;
        b=Tml3eyuqARHXMx1ms43GTMv6227HUrjlJhStI5PupcFKvWYJQpoc8NqUyQdXBR9cn9
         pohSCVyddnZQFt9CuzWnrpAzJXJ/6WMaBWhteW0e/fWVzEYMVY18UZR2gE2KxOGTrEsy
         CZe1gzQaJ/vy+WUnqSiUc6rNK7c2VTWvZ+S2Qjqd8AzIUNsGJQz4gSdk9wi9G9ogDJgF
         KLBKjBkcD9Gsu9kQ6y1q0HUe5dj3ekDXIM2KFuc8sLYuFQeqoPb56CqedHSQqpLfrjpI
         JzkGvbXmclWmGHrM4ZQaetJ35jVSt4mDRywLuJA99C7+0wd0Y+SW8FIRLN0pbaqFpqtB
         4hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052859; x=1763657659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etMtDfwD+3QZuYUqVZKqjI6mrl2ackYWEvqoK5GuUAQ=;
        b=biNCRo6zOy4PhEr/QOfyb891qbWOTsa/38rOHNRAvwetsHKRJ+FEIyh7Lsisnq5XE0
         xpdm1EjNgN/9JPhIrMN+Ywbc1/2NeNBxaPxOrtGeaRN8oia9/cT2tZSuXD1Loj1V1c4D
         jDI9geg+XACozTxbWCray+Qv9Iv0xSAacycZH5L5PV8oMMV3xoqkOy/N2kUoOT5Tn/kn
         kFsREnDrmuL1e+70coc6yW0Mlki6BKpRq470MFTbJttqY+ITl12EtBWDEh51MhOpiZXx
         +cAkpAlTZF/Zt6FL822YzUgNdJhaddGCtX+x364xBlGXHx0GD0o/Fn0IO/mcij+J6hGi
         wFpw==
X-Forwarded-Encrypted: i=1; AJvYcCXkdlNIsE+XQh1tvT0jcbyCtQRVGzWZES4N2DfGb03+l0ImA0laksMy/7INVKY7I2YGAdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITpKMsP335urlt2tNEK8v7zL4uB3XbTcUs3fc+X6Dol2NdO1r
	bRBjgllxJfbiTIw6LlPFFAXXQAojRrM/a1tc9XG59NnzqUOrNQlzhYRg
X-Gm-Gg: ASbGnctQBZJIyTH8WuEIqgWtG65Raq82yK9bQejJOPYZvczJH4BjpDRgVbC4SXzHHZh
	AlwrBn/ZGxwMcNApSvmMHOxsx1/dISw7eU3udLEWZT6d6Ca3sKC5w+owyveEGlFRhzBmUT+4F+y
	HgZVqo8TXLK/FIrtOXMYjOGX+/i1VTFkrWxw96T/prj/U4Ko9mRwrBIrizG23IwcGjHDQl5GSap
	Y+mZOHrL5YU1h7h2N1p27NgzRS7lzKk2wF4OgGwTo5nSfFBy6NL73UIpnvyCImqV6LlMS7uWeBv
	SFOE+Fpje/5faMnFIJqblR14r+B/QrvrEuZiiZbrFruPOchhNVrAg/PIRYMlSLKFjVp9cgJk7M8
	ZrA7JFqFkVVp5NMFib8tWtQChCsdDHFxt8NYI0G7p5eY=
X-Google-Smtp-Source: AGHT+IEPT42mAJ6MUQqgjo5ZM8rlqgnxDoAaqQlhU3CiG0tihICqar5Ppn5XfbeoxErgayfhRkMTWw==
X-Received: by 2002:a05:6512:b20:b0:594:35d5:9a1f with SMTP id 2adb3069b0e04-59584265411mr32340e87.50.1763052858346;
        Thu, 13 Nov 2025 08:54:18 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5958040576csm507458e87.88.2025.11.13.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:54:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 13 Nov 2025 17:54:16 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, akpm@linux-foundation.org,
	bpf@vger.kernel.org, hch@infradead.org, hch@lst.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aRYNOIQ0A4g6BClW@milan>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
 <69158bb1.a70a0220.3124cb.001e.GAE@google.com>
 <aRXeK_C44xGb3ovg@milan>
 <aRYL6XVX5pfhLqBX@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYL6XVX5pfhLqBX@fedora>

On Thu, Nov 13, 2025 at 08:48:41AM -0800, Vishal Moola (Oracle) wrote:
> On Thu, Nov 13, 2025 at 02:33:31PM +0100, Uladzislau Rezki wrote:
> > On Wed, Nov 12, 2025 at 11:41:37PM -0800, syzbot ci wrote:
> > > syzbot ci has tested the following series
> > > 
> > > [v2] make vmalloc gfp flags usage more apparent
> > > https://lore.kernel.org/all/20251112185834.32487-1-vishal.moola@gmail.com
> > > * [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
> > > * [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
> > > * [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
> > > * [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
> > > 
> > > and found the following issue:
> > > WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> > > 
> > > Full report is available here:
> > > https://ci.syzbot.org/series/46d6cb1a-188d-4ff5-8fab-9c58465d74d3
> > > 
> > > ***
> > > 
> > > WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> > > 
> > > tree:      linux-next
> > > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> > > base:      b179ce312bafcb8c68dc718e015aee79b7939ff0
> > > arch:      amd64
> > > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > config:    https://ci.syzbot.org/builds/3449e2a5-35e0-4eac-86c6-97ca0ec741d7/config
> > > 
> > > ------------[ cut here ]------------
> > > Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> > > WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0, CPU#1: syz-executor/6079
> > > Modules linked in:
> > >
> > Again bpf :)
> > 
> > GFP_KERNEL_ACCOUNT? I saw there have been __GFP_HARDWALL added already,
> > IMO it is worth to replace it by "high level flag", which is GFP_USER.
> 
> Yeah I'll replace __GFP_HARDWALL with GFP_USER, and add
> GFP_KERNEL_ACCOUNT. At this point I'll just add GFP_NOFS and GFP_NOIO
> as well so its easier to understand the mask.
>
Sounds good!

--
Uladzislau Rezki

