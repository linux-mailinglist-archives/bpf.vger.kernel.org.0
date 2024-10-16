Return-Path: <bpf+bounces-42243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256A9A1516
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83F1282F52
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3261D31A2;
	Wed, 16 Oct 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tU4ZhuCZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A91C1741
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115149; cv=none; b=LGW8AE5QDhlz5ssM0vYPKaHN07KYE5ZVg8thUNPFaR1wTcQPGksL/i4v0JKLngjpFSahGjiHbMwuOtr79YUYJvZ3KrvL7oc7CzoWvwBwaARbL5aRTTo+hMD+C97TTx3CINMGy2JQLy1zFJ3MET9fSmIG20s9Fwi4m8kcmPzPXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115149; c=relaxed/simple;
	bh=1/V4feXPUB4kGNXKsu2hBzl5oCt2y19qqOaw9nM6uRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkrukumMWU5c2oZPXw7SBjr/sOmcqEinuz39coosBQb65iZX1Wmv0OhuvEfJTfLNUWi3NrC0M6iNePs7RpiuOYsNqq9htmMK9K8IjACHE3AdcNpL4B9YfI4n6xXwFZRfSGSvirB0+2TEAZeaoKe44Mt79yKatGaxGjUP3lALJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tU4ZhuCZ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 14:45:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729115145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v5cxppTEMM7NUJQ2rhvny6tsM0muKpV+U5GhjqYjGB4=;
	b=tU4ZhuCZJKMgX7Vht4WtZmHqMrcvFgLxy4ZoA/bDRs+sRX/YFmu5OUMY7gbvgpIJANpft9
	WYYI2QfKlBdgkAyFx8WmTjfvjfqLd+/WXtebKXI+G3Tk3GuDsfvnAVTxpEV6RpdIDVBIcF
	dGMdsygCheqtOw2+pbk2SOLtqzItV0o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	pbonzini@redhat.com, seanjc@google.com, tabba@google.com, david@redhat.com, 
	jackmanb@google.com, jannh@google.com, rppt@kernel.org
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <55xdknbnbcyj4fv3qfoqrjyc5okfxltlcbkxmmdhvb5eflgexs@y6b5nfrpr4ex>
References: <20241014235631.1229438-1-andrii@kernel.org>
 <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
 <CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 16, 2024 at 12:59:13PM GMT, Yosry Ahmed wrote:
> On Wed, Oct 16, 2024 at 11:39 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Ccing couple more folks who are doing similar work (ASI, guest_memfd)
> >
> > Folks, what is the generic way to check if a given mapping has folios
> > unmapped from kernel address space?
> 
> I suppose you mean specifically if a folio is not mapped in the direct
> map, because a folio can also be mapped in other regions of the kernel
> address space (e.g. vmalloc).
> 
> From my perspective of working on ASI on the x86 side, I think
> lookup_address() is
> the right API to use. It returns a PTE and you can check if it is
> present.
> 
> Based on that, I would say that the generic way is perhaps
> kernel_page_present(), which does the above on x86, not sure about
> other architectures. It seems like kernel_page_present() always
> returns true with !CONFIG_ARCH_HAS_SET_DIRECT_MAP, which assumes that
> unmapping folios from the direct map uses set_direct_map_*().
> 
> For secretmem, it seems like set_direct_map_*() is indeed the method
> used to unmap folios. I am not sure if the same stands for
> guest_memfd, but I don't see why not.
> 
> ASI does not use set_direct_map_*(), but it doesn't matter in this
> context, read below if you care about the reasoning.
> 
> ASI does not unmap folios from the direct map in the kernel address
> space, but it creates a new "restricted" address space that has the
> folios unmapped from the direct map by default. However, I don't think
> this is relevant here. IIUC, the purpose of this patch is to check if
> the folio is accessible by the kernel, which should be true even in
> the ASI restricted address space, because ASI will just transparently
> switch to the unrestricted kernel address space where the folio is
> mapped if needed.
> 
> I hope this helps.
> 

Thanks a lot. This is really helpful.


