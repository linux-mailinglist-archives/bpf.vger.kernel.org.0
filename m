Return-Path: <bpf+bounces-52420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C4A42D01
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5720818976BB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EEE1EA7CF;
	Mon, 24 Feb 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TMq4ivB4"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F62571CC
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426479; cv=none; b=EM0y0gf33uv8rq4mwknzK1NZyTtRBcs15qFGPogvlqCcuVwSbwXDOKNzg9VvKY/9LO2Q6AyzljiJUYiyxWqSldpHQdUFvC3bIjnBlUDXjSliarcVtAuVqtZyaCJjOydSnsc+qBBuxl8zvqNfWSsD0p0iHR7pCvIaPh94yaxBUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426479; c=relaxed/simple;
	bh=k1j1TxXiLFPKo9IcYBdCCwwk/S72wAR6K+LEV4qdv2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGPG/0wM38AKA74IaXlTyFZvpmNAXSJPzr51JRc1Q/eiFQ4/d1witMP/yhhYX8gTyzs4VJt22K7rr+cpfszAwCZaHW6B5U0OdcaKk3UspJXeETrkDaLQmYysTudbBq0lGMFLLdnEpkIZTwYJ843FltM6cjXnDfdthGdju1Il+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TMq4ivB4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3d9f618-5d7e-41bb-ba50-474ba3b8cfd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740426474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfHnf8t0+ykXnaETy2HqtZyceh6blUQ28pANW1Fb+yU=;
	b=TMq4ivB4QyHRTATaMDH+rU6DuNhGtEZFUlGgUibbzAlhKPR95kp72inEDDfGEnKyAgEclB
	e7FKKomlWQJp47SrUKsWmmSX8rgw2Oxpq015rdJE4Jog7nr+Jkqr2+TtTDs1ea/Tcw2grC
	oR3xm2rFmSXDrnAE1dqVNmPzhT0HvSE=
Date: Mon, 24 Feb 2025 11:47:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Fix kmemleak warnings for percpu hashmap
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Vlad Poenaru <thevlad@meta.com>
References: <20250224175514.2207227-1-yonghong.song@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250224175514.2207227-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/24/25 9:55 AM, Yonghong Song wrote:
> Vlad Poenaru from Meta reported the following kmemleak issues:
> 
>    ...
>    unreferenced object 0x606fd7c44ac8 (size 32):
>      comm "floodgate_agent", pid 5077, jiffies 4294746072
>      hex dump (first 32 bytes on cpu 32):
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace (crc 0):
>        pcpu_alloc_noprof+0x730/0xeb0
>        bpf_map_alloc_percpu+0x69/0xc0
>        prealloc_init+0x9d/0x1b0
>        htab_map_alloc+0x363/0x510
>        map_create+0x215/0x3a0
>        __sys_bpf+0x16b/0x3e0
>        __x64_sys_bpf+0x18/0x20
>        do_syscall_64+0x7b/0x150
>        entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    unreferenced object 0x606fd7c44ae8 (size 32):
>      comm "floodgate_agent", pid 5077, jiffies 4294746072
>      hex dump (first 32 bytes on cpu 32):
>        d3 08 00 00 00 00 00 00 d3 08 00 00 00 00 00 00  ................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace (crc d197b0fe):
>        pcpu_alloc_noprof+0x730/0xeb0
>        bpf_map_alloc_percpu+0x69/0xc0
>        prealloc_init+0x9d/0x1b0
>        htab_map_alloc+0x363/0x510
>        map_create+0x215/0x3a0
>        __sys_bpf+0x16b/0x3e0
>        __x64_sys_bpf+0x18/0x20
>        do_syscall_64+0x7b/0x150
>        entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    ...
> 
> Further investigation shows the reason is due to not 8-byte aligned
> store of percpu pointer in htab_elem_set_ptr():
>    *(void __percpu **)(l->key + key_size) = pptr;
> 
> Note that the whole htab_elem alignment is 8 (for x86_64). If the key_size
> is 4, that means pptr is stored in a location which is 4 byte aligned but
> not 8 byte aligned. In mm/kmemleak.c, scan_block() scans the memory based
> on 8 byte stride, so it won't detect above pptr, hence reporting the memory
> leak.
> 
> In htab_map_alloc(), we already have
> 
>          htab->elem_size = sizeof(struct htab_elem) +
>                            round_up(htab->map.key_size, 8);
>          if (percpu)
>                  htab->elem_size += sizeof(void *);
>          else
>                  htab->elem_size += round_up(htab->map.value_size, 8);
> 
> So storing pptr with 8-byte alignment won't cause any problem and can fix
> kmemleak too.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

