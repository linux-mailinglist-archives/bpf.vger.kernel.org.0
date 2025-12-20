Return-Path: <bpf+bounces-77232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAEACD27EC
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 06:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34CC93013388
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D852F1FE7;
	Sat, 20 Dec 2025 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sT6+aEOB"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBE2EDD40
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208107; cv=none; b=QKwcCfeH4rqqi9KHn6zT5KlG3qceOoW9jl6ddqVDR8+igulm2ZhH6hVz/bgLIamwNHtC6MlnDhk1sdxv9USdKEM0UyzJz2QWkoUrlvrf6fd3ZreSm8jlxyLhYSjrsJJApDsCft1JcYcmX0Qpit/vCBjUv7tzNHs+VGatTerVsLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208107; c=relaxed/simple;
	bh=/V4Rq2bzvjzR6/vmjanTyQWEVD9oRlS8Bx4Rln73TXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLGVTa3GsR3gS6Lp97dAW0xGetC1SbtYDKZ8k4GBGKd7lFwpHzE+4P4SDNnflMbiZPwAyezVWVsCofjKOIz+bv2lXfg2buJbLf/5BcbfSCSqszwDxETRCWaoggI1FKLtbWzb+cPJ41gXvOYytw//72fsFgLJr068g0OMKRKoE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sT6+aEOB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Dec 2025 21:21:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766208098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=souUkGn3xil7wv4noOJluLBfspbrG8JUK1OG0jc5tDQ=;
	b=sT6+aEOBs+eEyAGqMW9JXOhT+7sbFm0WwvObsIrrqBh4a9WVh+pvCR1BseK/sXTSQgY6iZ
	i2vVOs633gKhK8N0cFFvKBM9zJbeur+yAoWwuW7+zFjPArCD68XJgkXzlM5PMvrHxOmHuA
	fobiR4hXIz8Rm3S7oCsbF52LzEnI+S4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	JP Kobryn <inwardvessel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH bpf-next v2 3/7] mm: introduce bpf_get_root_mem_cgroup()
 BPF kfunc
Message-ID: <he4iziqotq6ecucq5ipqukwnetonwyzl2gm5ej7ii3ltjc3lue@xpqxrvcblquj>
References: <20251220041250.372179-1-roman.gushchin@linux.dev>
 <20251220041250.372179-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220041250.372179-4-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 19, 2025 at 08:12:46PM -0800, Roman Gushchin wrote:
> Introduce a BPF kfunc to get a trusted pointer to the root memory
> cgroup. It's very handy to traverse the full memcg tree, e.g.
> for handling a system-wide OOM.
> 
> It's possible to obtain this pointer by traversing the memcg tree
> up from any known memcg, but it's sub-optimal and makes BPF programs
> more complex and less efficient.
> 
> bpf_get_root_mem_cgroup() has a KF_ACQUIRE | KF_RET_NULL semantics,
> however in reality it's not necessary to bump the corresponding
> reference counter - root memory cgroup is immortal, reference counting
> is skipped, see css_get(). Once set, root_mem_cgroup is always a valid
> memcg pointer. It's safe to call bpf_put_mem_cgroup() for the pointer
> obtained with bpf_get_root_mem_cgroup(), it's effectively a no-op.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

