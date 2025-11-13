Return-Path: <bpf+bounces-74424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42806C59440
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1664F38F2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC10435A95D;
	Thu, 13 Nov 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEPnpg/p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02071F2BAD
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052526; cv=none; b=kbspInYbSGH+SnPeeUM5Cb95I6DawClD5jca7aPPZEIYpHtgzfFObW4ciu0Nk52zu5trXBEmKm1l3VIqUzNhbROX3Il3oGZl6nAhljoyUc0bgJq080XDw0nShqIF+SpvsZcP3rP6nLNRhGh8K1/LWReUEfIoGJ3QiZPQafQNIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052526; c=relaxed/simple;
	bh=GcQCJjua/D8mklX/rr0KMH+1XU9pj8X0cJnaIhN8pj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbgIbTAmNjE7ScSYmQ6WpEsH6IvlzLDuq7+BNimbRcu5UqvSAkQn/cxWmYKNjvbT1lOTalFPAjFkaQvxCj6EG13lwffixdF1L01yW+616FSaoQjzxNf1k9SErCUHf3zICJhkyJNUq5B4MdxlS6Z71fPTt2c6bRv3/uP97yRD450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEPnpg/p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298287a26c3so11904585ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052524; x=1763657324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtBw2QaKFUcY/ykNwr991VNkMXbEXUIubxDUCz9u1I8=;
        b=FEPnpg/pUq/k0NHUPUm1AzoL6AaGcGtyrMWXGKfAThMIFW+y1laBf6c0S61YqZ3jM+
         1d7skEaGMBQuHPLlyzV39p8bEtuwVT7rRVYV8sbytY6qT1WfJI79K8/M+ZSZOmjU1M6m
         7EbQHG4IxDGK+Ure+H+wpQ+IDgmZ9Qpi1BP9oYAk3LbVZL5fWA7zkknevljXpwmgBZez
         AbXqvnZaQApjXCa53OFy/SIfjl/PHAtS+egtMQ0k924ZzEZ4whoiwjWgjDZHOHkc1HQL
         Gn3kC/RziP2JKT5EHEvD+eTqPM4ZGwwGCTSb4EWEnTHBjgBK+BU5XBdQKKqCfHEZOlBQ
         6fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052524; x=1763657324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtBw2QaKFUcY/ykNwr991VNkMXbEXUIubxDUCz9u1I8=;
        b=w/6MnmzVLyi0gOPDw4g1/psFNILCYzTg9YSmL1cS4fQwvDglbm+HiAx9XmTPioSL9R
         stJUrlHLo/pR8iiN66SCpQ6mNBhqt/vxhfOMAd+8L731ZTUjXIOuMh6TPdMm+3DWFXh6
         4fuJktjGpUWvUKgYT9ntu/cyP3BMKtRY9sPXYqKXaE35IxLv4iTG38x63aXh4fBGFzsW
         P737mdr+7H4gH9xDfm6mjc25YvjErNP5xB+jzfhKNU9kRntXWPI5wZM+iUcTcGmtuj2l
         s4cTrTd7qI/O6W6h9TyNq2UO21P5zxz4QHVjcB37cFJ4hq9ttRbdgRFxMxTq+NT/epCW
         Jb2A==
X-Forwarded-Encrypted: i=1; AJvYcCUnVI0mSOlL9njQav0HXHXO6TXkXbGelWSoPBP8kpftfKFCY85QfLkE5pcy6qdAlBX4dVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFVt9bUKRlJMGLPCLF9yZ7bFUw4JDfj/5Um8V5W2TJaVFIzho
	ccxDcxnWepONeJk3JY3+qTAYaFj7ODISleRfqaaag54MzI4I95fRLi4B
X-Gm-Gg: ASbGncvy0MzX+JEFQnljQag4Fji+dtpFKjWI69U9yTKSCYRN82GDI0VmKszGG89kTVD
	wc3oN5Ib+zlfU0Gf73m2JLvdXIDxBOCvELuo/GtmvnSBbZvZb2arwDpedGfH3ju2iKiGPUKodGK
	25CSEr8g6hYsCLU/etdHGNQmKJ+RlbC3LyvMX5/yDU+3RXjW+08ODBCwFT4YlcfrepHyMDeQ99P
	XDFwFjE0Y/gNzwiInbpf0MmbnZogFHtcejBkDeKujnFM9B/aP8QB4KlnlSdZW6JQhy5kPy8keLW
	ZKE/CjCB/jGF0X5MHaF+hSv9BFnF1iPV0rqwEr48vhA+V8eBvIVHuYRflGpFSR7Mtm4mHf1qpZx
	e3yESohx1Bqkwgo1eppW3Q/OlGQ0LgCT1+VnhOO2Xsi6df/1ydxT1NRxymeq5/twA3TAQW3t2rq
	bQ4po1dbwXFLKd/WjyvpLjwD7B/RjtTop8
X-Google-Smtp-Source: AGHT+IHeub5aNCvnanVAkTfvVdmm0rKNrZXKV+kknwHxz7AyPMKPAPWmPtn/96i7E7eHSTeZ/nnwWQ==
X-Received: by 2002:a17:902:d551:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-2984ed7a01cmr100922265ad.1.1763052524113;
        Thu, 13 Nov 2025 08:48:44 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed2esm30948585ad.81.2025.11.13.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:48:43 -0800 (PST)
Date: Thu, 13 Nov 2025 08:48:41 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: akpm@linux-foundation.org, bpf@vger.kernel.org, hch@infradead.org,
	hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
Message-ID: <aRYL6XVX5pfhLqBX@fedora>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
 <69158bb1.a70a0220.3124cb.001e.GAE@google.com>
 <aRXeK_C44xGb3ovg@milan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRXeK_C44xGb3ovg@milan>

On Thu, Nov 13, 2025 at 02:33:31PM +0100, Uladzislau Rezki wrote:
> On Wed, Nov 12, 2025 at 11:41:37PM -0800, syzbot ci wrote:
> > syzbot ci has tested the following series
> > 
> > [v2] make vmalloc gfp flags usage more apparent
> > https://lore.kernel.org/all/20251112185834.32487-1-vishal.moola@gmail.com
> > * [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
> > * [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
> > * [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
> > * [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
> > 
> > and found the following issue:
> > WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> > 
> > Full report is available here:
> > https://ci.syzbot.org/series/46d6cb1a-188d-4ff5-8fab-9c58465d74d3
> > 
> > ***
> > 
> > WARNING: kmalloc bug in bpf_prog_alloc_no_stats
> > 
> > tree:      linux-next
> > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> > base:      b179ce312bafcb8c68dc718e015aee79b7939ff0
> > arch:      amd64
> > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > config:    https://ci.syzbot.org/builds/3449e2a5-35e0-4eac-86c6-97ca0ec741d7/config
> > 
> > ------------[ cut here ]------------
> > Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> > WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0, CPU#1: syz-executor/6079
> > Modules linked in:
> >
> Again bpf :)
> 
> GFP_KERNEL_ACCOUNT? I saw there have been __GFP_HARDWALL added already,
> IMO it is worth to replace it by "high level flag", which is GFP_USER.

Yeah I'll replace __GFP_HARDWALL with GFP_USER, and add
GFP_KERNEL_ACCOUNT. At this point I'll just add GFP_NOFS and GFP_NOIO
as well so its easier to understand the mask.

