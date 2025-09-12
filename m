Return-Path: <bpf+bounces-68245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0290B55566
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240491D61DEC
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377931AF25;
	Fri, 12 Sep 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ab4aAj5U"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F1272E67
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697346; cv=none; b=b43fqHIHSp3ClYfcbM0Xf97cnkRw9WFSdMn2GshfmCpjchw8dyXgUrk1tT2JDRfEva5wn9NaeQYQ7mQ4LmmrMycBkgDJqZVOIGQLK2df9V98wh6LHvBhKK2YXf2KsUOrqYa0UTyu2nC5RgwPKLvkhqxQKMrZpkES4F3mnlP6i4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697346; c=relaxed/simple;
	bh=gTdQ7nFgBQQk38HAQIzd4cuTz8qOgXJF/IZpiRTri04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy1eembuYgK0dIB483sP4uAVNY+LdOG/1d8Va7zr1Wx0/Zgb1nOUF1BGctIVmqTN+j14UIlw2dcp4BsvFH/udknUM1AP1WFGs6fO2KGyGis0VKpPDAO38GIiLOzfb707+AeXG/vZdLWVwp8WI63ubDD60NH58jB2cB86c4Sk1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ab4aAj5U; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 10:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757697342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1M/JA9EobQm4/fkyUEBy+aOR9iJr1+HAKxCAevq03Q4=;
	b=ab4aAj5UQT1aRuMiHELZYBT3/QUnYjH/YvaEGGZmD/CTKCK1JlzwiEdBhxl3MIG6C5KkDv
	Ao36h36MedRy8Wc8oXI33K3HGCowK6jg9QZzuAJPQBKsynkkIaqgdEtTIZoluxYsSRyvP4
	Gk5wqp3Ae/pnbDotXSPvUd5Jux9oe2o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 3/6] mm: Introduce alloc_frozen_pages_nolock()
Message-ID: <33sckm5763xkrbctkjbyzmphopo2nry4s5cpyvcajmfhmc2plh@qspdcqd7h36k>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-4-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-4-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 06:00:04PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Split alloc_pages_nolock() and introduce alloc_frozen_pages_nolock()
> to be used by alloc_slab_page().
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

